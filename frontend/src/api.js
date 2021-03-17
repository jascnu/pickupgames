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
}

export default new Api();