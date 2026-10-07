let data = {};
let currentLang = 'en';

async function loadData() {
  const response = await fetch('data.json');
  data = await response.json();
  document.getElementById('system-title').textContent = data.system.title[currentLang];
}

function login() {
  const username = document.getElementById('username').value;
  const password = document.getElementById('password').value;

  let authenticatedRole = findRole(data.system.roles, username, password);

  if (authenticatedRole) {
    document.getElementById('login-section').style.display = 'none';
    document.getElementById('dashboard').style.display = 'block';
    document.getElementById('role-info').innerHTML = `
      <h3>${authenticatedRole.role[currentLang]}</h3>
      <p><strong>Name:</strong> ${authenticatedRole.name}</p>
      ${authenticatedRole.division ? `<p><strong>Division:</strong> ${authenticatedRole.division}</p>` : ''}
      ${authenticatedRole.district ? `<p><strong>District:</strong> ${authenticatedRole.district}</p>` : ''}
    `;
  } else {
    document.getElementById('login-message').textContent = "Invalid credentials!";
  }
}

function findRole(roles, username, password) {
  for (let role of roles) {
    if (role.name === username && role.password === password) {
      return role;
    }
    if (role.children) {
      let childRole = findRole(role.children, username, password);
      if (childRole) return childRole;
    }
  }
  return null;
}

loadData();
