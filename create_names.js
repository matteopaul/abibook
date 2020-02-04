const names = require('./names.json')

for(let i = 0; i < names.length; i++) {
  let current = names[i];
  let firstname = current.split(' ')[0];
  let lastname = current.split(' ')[1];
  let username = firstname.charAt(0) + lastname;
  console.log('INSERT INTO user (`id`, `firstname`, `lastname`, `password`, `username`) VALUES (' + i + ', "' + firstname + '", "' + lastname + '", "' + username + '", "' + username + '");');
}
