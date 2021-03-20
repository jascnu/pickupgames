import jwt_decode from "jwt-decode";

export function getJwtToken() {
  return localStorage.getItem("accessToken");
}

export function getusername() {
  return localStorage.getItem("username");
}

export function getUserIdFromToken(token) {
  const decoded = jwt_decode(token);
  console.log(decoded);
  return decoded.user_id;
}

export function setJwtToken(token, username) {
  localStorage.setItem("accessToken", token);
  window.localStorage.setItem("username", username);
  window.localStorage.setItem("userid", getUserIdFromToken(token));
}

export function deleteJwtToken() {
  localStorage.removeItem("accessToken");
}

export function logout() {
	localStorage.removeItem("username");
  localStorage.removeItem("accessToken");
  localStorage.removeItem("userid");
	location.reload();
}

export function authHeader() {
  let accessToken = getJwtToken();

  if (accessToken) {
    return { Authorization: "Bearer " + accessToken };
  } else {
    return {};
  }
}