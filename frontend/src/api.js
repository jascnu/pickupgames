import axios from "axios";
import { authHeader, getJwtToken, getUserIdFromToken } from "./auth";

const API_URL = "http://192.168.50.67:8000";

class Api {

  login(email, password) {
    return axios.post(API_URL + "/rpc/login", { email, password });
  }

  signup(email, password, firstname, lastname, middlename, zipcode, username) {
    return axios.post(API_URL + "/rpc/signup", { email, password, firstname, lastname, middlename, zipcode, username });
  }

  getGameList() {
    return axios.get(API_URL + "/game_list");
  }

  getProfileInfo(userid) {
    return axios.get(API_URL + "/profile_page?userid=eq." + userid);
  }

  //I think spread operator is correct here and in updates
  createGame(game) {
	return axios.post(API_URL + "/rpc/creategame", ...game);
  }
  deleteGame(gameId) {
	return axios.post(API_URL + "/rpc/deletegame", {gameid: gameId});
  }
  deleteUser(userId) {
	return axios.delete(API_URL + "/pickupuser?userid=eq." + userId);
  }
  getUsers() {
	return axios.get(API_URL + "/pickupuser");
  }

  updateGame(gameId, updatedFields) {
	return axios.patch(API_URL + "/game?gameid=eq."+ gameId, ...updatedFields);
  }
  updateGame(userId, updatedFields) {
	return axios.patch(API_URL + "/pickupuser?userid=eq."+ userId, ...updatedFields);
  }
}

export default new Api();