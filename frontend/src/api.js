import axios from "axios";
import { authHeader, getJwtToken, getUserIdFromToken } from "./auth";

const API_URL = "http://192.168.50.67:8000";

class Api {
  login(email, password) {
    return axios.post(API_URL + "/rpc/login", { email, password });
  }

  signup(email, password, firstname, lastname, middlename, zipcode, username) {
    return axios.post(API_URL + "/rpc/signup", {
      email,
      password,
      firstname,
      lastname,
      middlename,
      zipcode,
      username
    });
  }

  getGameList() {
    return axios.get(API_URL + "/game_list");
  }

  getProfileInfo(userid) {
    return axios.get(API_URL + "/profile_page?userid=eq." + userid);
  }

  getGameByOwner(username) {
    return axios.get(API_URL + `/game_list?owner=eq.${username}`);
  }

  getLocations() {
    return axios.get(API_URL + `/location_list`);
  }

  getSports() {
    return axios.get(API_URL + `/sport_list`);
  }

  //I think spread operator is correct here and in updates

  createGame(game) {
    return axios.post(API_URL + "/rpc/creategame", game, {
      headers: {
        Authorization: `Bearer ${getJwtToken()}`
      }
    });
  }

  hasJoined(userid, gameid) {
    return axios.get(`${API_URL}/joined?userid=eq.${userid}&gameid=eq.${gameid}`)
  }

  joinGame(joinObject) {
    return axios.post(API_URL + "/joined", joinObject, {
      headers: {
        Authorization: `Bearer ${getJwtToken()}`
      }
    });
  }

  deleteJoin (userid, gameid) {
    return axios.delete(`${API_URL}/joined?userid=eq.${userid}&gameid=eq.${gameid}`, {
      headers: {
        Authorization: `Bearer ${getJwtToken()}`
      }
    });
  }

  deleteGame(gameId) {
    return axios.post(
      API_URL + "/rpc/deletegame",
      { gameid: gameId },
      {
        headers: {
          Authorization: `Bearer ${getJwtToken()}`
        }
      }
    );
  }
  deleteUser(userId) {
    return axios.delete(API_URL + "/pickupuser?userid=eq." + userId, {
      headers: {
        Authorization: `Bearer ${getJwtToken()}`
      }
    });
  }
  getUsers() {
    return axios.get(API_URL + "/pickupuser");
  }

  getSports() {
    return axios.get(API_URL + "/sport_list");
  }

  getLocations() {
    return axios.get(API_URL + "/location_list");
  }

  getRanks() {
    return axios.get(API_URL + "/rank_list");
  }

  updateGame(gameId, updatedFields) {
    return axios.patch(API_URL + "/game?gameid=eq." + gameId, updatedFields, {
      headers: {
        Authorization: `Bearer ${getJwtToken()}`
      }
    });
  }
  updateUser(userId, updatedFields) {
    return (
      axios.patch(API_URL + "/pickupuser?userid=eq." + userId, updatedFields),
      {
        headers: {
          Authorization: `Bearer ${getJwtToken()}`
        }
      }
    );
  }
}

export default new Api();
