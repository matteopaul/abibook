const express = require('express');
const mysql = require('mysql');
const sassMiddleware = require('node-sass-middleware');
const session = require('express-session');
const bodyParser = require('body-parser');
var path = require('path');

const app = express();

const database = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "mpi-08042304",
  database: "abi"
})

database.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

const server = app.listen(8080, () => {
  console.log(`express running at ${server.address().port}`);
})

app.set('view engine', 'pug');

app.use(sassMiddleware({
    /* Options */
    src: path.join(__dirname, 'src'),
    dest: path.join(__dirname, 'public'),
    debug: true,
    outputStyle: 'compressed'
}));
app.use('/public', express.static(path.join(__dirname, 'public')));

app.use(express.static(__dirname + '/public'));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));




//
//
//
//              URL REQUEST HANDLERS
//
//
//
//



app.get('/', (req, res) => {
  if(req.session.loggedin && req.session.username != null) {
    database.query('SELECT * FROM user WHERE username = ?', [req.session.username], function(error, results, fields) {
			if (results.length > 0) {
        database.query('SELECT * FROM memories',function(mem_error, mem_results, mem_fields) {
          res.render('index', {
            title: "Übersicht",
            moments: mem_results,
            current_user: results[0]
          });
        });
			}
		});

  } else {
    res.redirect('/login');
  }
})

app.get('/login', (req, res) => {
  res.render('login', {
    error: req.session.error || null
  });
});

app.post('/auth', function(request, response) {

	var username = request.body.username;
	var password = request.body.password;

  if(username && username != "") {
    if(password && password != "") {
  		database.query('SELECT * FROM user WHERE username = ? AND password = ?', [username, password], function(error, results, fields) {
			if (results.length > 0) {
				request.session.loggedin = true;
				request.session.username = username;
        request.session.error = null;
				response.redirect('/');
			} else {
        request.session.error = "Nutzername und Passwort stimmen nicht überein.";
    		response.redirect("/login");
			}
			response.end();
  		});
    } else {
      request.session.error = "Du musst dein Passwort eingeben.";
      response.redirect("/login");
    }
	} else {
		request.session.error = "Du musst deinen Nutzernamen eingeben.";
		response.redirect("/login");
	}
});

app.post('/add_memory', function(req, res) {
  if(req.session.loggedin && req.session.username != null) {
    if(req.body.text != "") {
      var quote = req.body.text;
      database.query('SELECT * FROM user WHERE username = ?', [req.session.username], function(error, results, fields) {
  			if (results.length > 0) {
  				database.query('INSERT INTO memories (`text`, `author_id`) VALUES ("' + quote + '", ' + results[0].id + ')', function(err, insert_result) {
             if (err) throw err;
             res.redirect('/');
          })
  			} else {
  				res.redirect('/logout');
  			}
  		})
    }
  } else {
    req.session.error = "Du wurdest abgemeldet. Bitte melde dich erneut an.";
    res.redirect('/login');
  }
})

app.get('/logout', function(req, res) {
  loggedin = req.session.loggedin;
  username = req.session.username;
  if(username != "" && loggedin) {
    req.session.loggedin = false;
    req.session.username = "";
    res.redirect('/login');
  } else {
    res.redirect('/');
  }
  res.end();
})

app.get('/moment/:id', function(req, res) {
  if(req.session.loggedin) {
    let moment_id = req.params.id;
    database.query('SELECT * FROM memories WHERE id = ?', [moment_id], function(error, result, fields) {
      if(result.length > 0) {
        database.query('SELECT * FROM user WHERE id = ?', [result[0].author_id], function(user_error, user_result, user_fields) {
          if(user_result.length > 0) {
            if(user_result[0].username.toLowerCase() == req.session.username.toLowerCase()) {
              res.render('moment_detail_admin', {
                post: result[0],
                user: user_result[0]
              })
            } else {
              res.render('moment_detail', {
                post: result[0],
                user: user_result[0]
              })
            }
          } else {
            res.redirect('/');
          }
        })
      } else {
        res.redirect('/')
      }
    })
  } else {
    res.redirect('/login')
  }
})

app.post('/moments/:id/delete', function(req, res) {
  if(req.session.loggedin) {
    let moment_id = req.params.id;
    database.query("SELECT * FROM user WHERE username = ?", [req.session.username], function(error, result, fields) {
      if(result.length > 0) {
        database.query("SELECT * FROM memories WHERE id = ?", [moment_id], function(moment_error, moment_result, moment_fields) {
          if(moment_result.length > 0) {
            if(result[0].id == moment_result[0].author_id) {
              database.query("DELETE FROM memories WHERE id = ?", [moment_id], function(delete_error) {
                if (delete_error) throw delete_error;
                res.redirect(`/`);
              })
            } else {
              res.redirect(`/`);
            }
          }
        })
      } else {
        res.redirect('logout');
      }
    });
  } else {
    res.redirect('/login');
  }
})

app.get('/profile/:id', function(req, res) {
  if(req.session.loggedin) {
    let user_id = req.params.id;
    database.query('SELECT * FROM user WHERE id = ?', [user_id], function(error, result, fields) {
      if(result.length > 0) {
        database.query('SELECT * FROM personal_notes WHERE profile_id = ?', [user_id], function(post_error, post_result, post_fields) {
          database.query("SELECT * FROM user WHERE username = ?", [req.session.username], function(user_error, user_result, user_fields) {
            if(user_result.length > 0) {
              res.render('profile', {
                user: result[0],
                notes: post_result,
                current_user: user_result[0]
              })
            } else {
              res.redirect('/logout');
            }
          })

        })
      } else {
        res.redirect('/');
      }
    })
  } else {
    res.redirect('/login')
  }
})

app.post('/profile/:id/notes/add', function(req, res) {
  if(req.session.loggedin) {

    let user_id = req.params.id;
    let text = req.body.text;

    database.query("SELECT * FROM user WHERE username = ?", [req.session.username], function(error, result, fields) {
      if(result.length > 0) {
        let author_id = result[0].id;

        database.query('INSERT INTO personal_notes (`author_id`, `profile_id`, `text`) VALUES (' + author_id + ', ' + user_id + ', "' + text + '")', function(err, insert_result) {
           if (err) throw err;
           res.redirect('/profile/' + user_id);
        })
      } else {
        res.redirect('/logout');
      }
    })
  } else {
    res.redirect('/login')
  }
})

app.get('/profile/:profile_id/notes/:note_id', function(req, res) {
  if(req.session.loggedin) {

    let profile_id = req.params.profile_id;
    let note_id = req.params.note_id;

    database.query("SELECT * FROM personal_notes WHERE id = ? AND profile_id = ?", [note_id, profile_id], function(error, result, fields) {
      if (error) throw error;
      if(result.length > 0) {
        database.query("SELECT * FROM user WHERE id = ?", [result[0].author_id], function(author_error, author_result, author_fields) {
          if(author_result.length > 0) {
            database.query("SELECT * FROM user WHERE id = ?", [result[0].profile_id], function(user_error, user_result, user_fields) {
              if(user_result.length > 0) {
                if(author_result[0].username.toLowerCase() == req.session.username || user_result[0].username.toLowerCase() == req.session.username) {
                  res.render('note_detail_admin', {
                    note: result[0]
                  })
                } else {
                  res.render('note_detail', {
                    note: result[0]
                  })
                }
              } else {
                res.redirect('/');
              }
            })

          } else {
            res.redirect(`/profile/${profile_id}`);
          }
        })
      } else {
        res.redirect(`/profile/${profile_id}`)
      }
    })

  } else {
    res.redirect('/login')
  }
})

app.post('/profile/:profile_id/notes/:note_id/delete', function(req, res) {

  let profile_id = req.params.profile_id;
  let note_id = req.params.note_id;

  if(req.session.loggedin) {

    database.query("SELECT * FROM user WHERE username = ?", [req.session.username], function(error, result, fields) {
      if(result.length > 0) {
        database.query("SELECT * FROM personal_notes WHERE id = ?", [note_id], function(note_error, note_result, note_fields) {
          if(note_result.length > 0) {
            if(result[0].id == note_result[0].author_id || result[0].id == note_result[0].profile_id) {
              database.query("DELETE FROM personal_notes WHERE id = ?", [note_id], function(delete_error) {
                if (delete_error) throw delete_error;
                res.redirect(`/profile/${profile_id}/`);
              })
            } else {
              res.redirect(`/profile/${profile_id}/`);
            }
          }
        })
      } else {
        res.redirect('/logout');
      }
    });

  } else {
    res.redirect('/login');
  }

})
