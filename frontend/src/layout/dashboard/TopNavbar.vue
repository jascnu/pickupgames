<template>
  <nav class="navbar navbar-expand-lg navbar-absolute"
       :class="{'bg-white': showMenu, 'navbar-transparent': !showMenu}">
    <div class="container-fluid">
      <div class="navbar-wrapper">
        <div class="navbar-toggle d-inline" :class="{toggled: $sidebar.showSidebar}">
          <button type="button"
                  class="navbar-toggler"
                  aria-label="Navbar toggle button"
                  @click="toggleSidebar">
            <span class="navbar-toggler-bar bar1"></span>
            <span class="navbar-toggler-bar bar2"></span>
            <span class="navbar-toggler-bar bar3"></span>
          </button>
        </div>
        <a class="navbar-brand" href="#pablo">{{routeName}}</a>
      </div>
      <button class="navbar-toggler" type="button"
              @click="toggleMenu"
              data-toggle="collapse"
              data-target="#navigation"
              aria-controls="navigation-index"
              aria-label="Toggle navigation">
        <span class="navbar-toggler-bar navbar-kebab"></span>
        <span class="navbar-toggler-bar navbar-kebab"></span>
        <span class="navbar-toggler-bar navbar-kebab"></span>
      </button>

      <collapse-transition>
        <div class="collapse navbar-collapse show" v-show="showMenu">
          <ul class="navbar-nav" :class="$rtl.isRTL ? 'mr-auto' : 'ml-auto'">
            <div class="search-bar input-group" @click="searchModalVisible = true">
              <!-- <input type="text" class="form-control" placeholder="Search...">
              <div class="input-group-addon"><i class="tim-icons icon-zoom-split"></i></div> -->
              <button v-if="isLoggedIn" class="btn btn-link" id="search-button" data-toggle="modal" data-target="#searchModal">
                <i class="tim-icons icon-zoom-split"></i>
              </button>
              <!-- You can choose types of search input -->
            </div>
            <modal :show.sync="searchModalVisible"
                   class="modal-search"
                   id="searchModal"
                   :centered="false"
                   :show-close="true">
              <input slot="header" v-model="searchQuery" type="text" class="form-control" id="inlineFormInputGroup" placeholder="SEARCH">
            </modal>
            <base-button v-if="isLoggedIn" style="overflow: visible" type="default" class="btn" @click="modals.modal3 = true; getLocations(); getSports();">
                Create Game
            </base-button>
            <modal :show.sync="modals.modal3"
                  body-classes="p-0"
                  modal-classes="modal-dialog modal-dialog-centered">
                <card type="primary"
                      header-classes="bg-white pb-5"
                      body-classes="px-lg-5 py-lg-5"
                      class="border-0 mb-0">
                    <template>
                        <div class="text-muted text-center mb-3">
                            <h5>Create Pickup Game</h5>
                        </div>
                    </template>
                    <template>
                        <form role="form">
                          <div class="row">
                            <div class="col pr-md-1">
                              <base-input label="Title"
                                        placeholder="Title" v-model="newGame.title">
                              </base-input>
                            </div>
                            <div class="col pl-md-1">
                              <base-input label="Date"
                                        placeholder="Date"
                                        type="datetime-local" v-model="newGame.datetime">
                              </base-input>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col pr-md-1">
                              <base-input label="Num Players Req" v-model="newGame.playersrequired">
                                <select type="number" class="text-white-50 form-control">
                                  <option class="text-black-50">2</option>
                                  <option class="text-black-50">3</option>
                                  <option class="text-black-50">4</option>
                                  <option class="text-black-50">5</option>
                                  <option class="text-black-50">6</option>
                                  <option class="text-black-50">7</option>
                                  <option class="text-black-50">8</option>
                                  <option class="text-black-50">9</option>
                                  <option class="text-black-50">10</option>
                                  <option class="text-black-50">11</option>
                                  <option class="text-black-50">12</option>
                                  <option class="text-black-50">13</option>
                                  <option class="text-black-50">14</option>
                                  <option class="text-black-50">15</option>
                                  <option class="text-black-50">16</option>
                                  <option class="text-black-50">17</option>
                                  <option class="text-black-50">18</option>
                                  <option class="text-black-50">19</option>
                                  <option class="text-black-50" value="20">20+</option>
                                </select>
                              </base-input>
                            </div>
                            <div class="col pl-md-1">
                              <base-input label="Sport">
                                <select class="text-white-50 form-control" v-model="newGame.sportid">
                                  <option v-for="sport in sports" class="text-black-50" v-bind:value="sport.sportid">{{sport.name}}</option>
                                </select>
                              </base-input>
                            </div>
                          </div>
                          <div class="row">
                            <div class="col">
                              <base-input label="Location" v-model="newGame.locationid">
                                 <select class="text-white-50 form-control">
                                   <option v-for="location in locations" class="text-black-50" v-bind:value="location.locationid">{{location.address}}</option>
                                  </select>
                              </base-input>
                            </div>
                          </div>
                          <base-input label="Description">
                            <textarea class="form-control" id="description" rows="3" v-model="newGame.description"></textarea>
                          </base-input>
                           <base-checkbox class="" v-model="newGame.iscompetitive">
                                    is Competitive?
                          </base-checkbox>
                          <div class="modal-footer">
                            <base-button type="danger" @click="modals.modal3 = false">Cancel</base-button>
                            <base-button v-if="loading === false" @click="createGame();" type="primary" class="ml-auto">Create Game</base-button>
                            <base-button loading v-else-if="loading" type="primary" class="ml-auto">Creating</base-button>
                          </div>
                        </form>
                    </template>
                </card>
            </modal>
            <!-- <base-dropdown tag="li"
                           :menu-on-right="!$rtl.isRTL"
                           title-tag="a" class="nav-item">
              <a slot="title" href="#" class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="true">
                <div class="notification d-none d-lg-block d-xl-block"></div>
                <i class="tim-icons icon-sound-wave"></i>
                <p class="d-lg-none">
                  New Notifications
                </p>
              </a>
              <li class="nav-link">
                <a href="#" class="nav-item dropdown-item">Mike John responded to your email</a>
              </li>
              <li class="nav-link">
                <a href="#" class="nav-item dropdown-item">You have 5 more tasks</a>
              </li>
              <li class="nav-link">
                <a href="#" class="nav-item dropdown-item">Your friend Michael is in town</a>
              </li>
              <li class="nav-link">
                <a href="#" class="nav-item dropdown-item">Another notification</a>
              </li>
              <li class="nav-link">
                <a href="#" class="nav-item dropdown-item">Another one</a>
              </li>
            </base-dropdown> -->
            <base-dropdown v-if="isLoggedIn" tag="li"
                           :menu-on-right="!$rtl.isRTL"
                           title-tag="a"
                           class="nav-item"
                           menu-classes="dropdown-navbar">
              <a slot="title" href="#" class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="true">
                <div class="photo">
                  <img src="img/animeNew.png">
                </div>
                <b class="caret d-none d-lg-block d-xl-block"></b>
                <p class="d-lg-none">
                  Log out
                </p>
              </a>
              <li class="nav-link">
                <a href="/#/profile" class="nav-item dropdown-item">Profile</a>
              </li>
              <li class="nav-link">
                <a href="#" class="nav-item dropdown-item">Settings</a>
              </li>
              <div class="dropdown-divider"></div>
              <li class="nav-link">
                <a v-if="isLoggedIn" v-on:click="logout" href="#" class="nav-item dropdown-item">Log out</a>
                <a v-else href="/#/login" class="nav-item dropdown-item">Log in</a>
              </li>
            </base-dropdown>
            <a v-else href="/#/login" class="title login-button">Login</a>
          </ul>
        </div>
      </collapse-transition>
    </div>
  </nav>
</template>
<script>
  import { CollapseTransition } from 'vue2-transitions';
  import Modal from '@/components/Modal';
  import Api from '../../api';
  import { getJwtToken, getUserIdFromToken } from "../../auth";

  export default {
    components: {
      CollapseTransition,
      Modal
    },
    computed: {
      routeName() {
        const { name } = this.$route;
        return this.capitalizeFirstLetter(name);
      },
      isRTL() {
        return this.$rtl.isRTL;
      }
    },
    data() {
      return {
        activeNotifications: false,
        showMenu: false,
        searchModalVisible: false,
        searchQuery: '',
        modals: {
          "modal3": false
        },
        loading: false,
        locations: [],
        sports: [],
        newGame: {
          title: '',
          datetime: '',
          playersrequired: 2,
          sportid: 0,
          locationid: 0,
          description: '',
          iscompetitive: false,
          playersjoined: 1,
          ownerid: null,
          levelid: 0
        }
      };
    },
    computed: {
    isLoggedIn() {
      return window.localStorage.getItem("username");
    }
  },
    methods: {
      capitalizeFirstLetter(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
      },
      toggleNotificationDropDown() {
        this.activeNotifications = !this.activeNotifications;
      },
      closeDropDown() {
        this.activeNotifications = false;
      },
      toggleSidebar() {
        this.$sidebar.displaySidebar(!this.$sidebar.showSidebar);
      },
      hideSidebar() {
        this.$sidebar.displaySidebar(false);
      },
      toggleMenu() {
        this.showMenu = !this.showMenu;
      },
      getLocations() {
        Api.getLocations()
              .then(res => {
                this.locations = res.data
              })
      },
      getSports() {
        Api.getSports()
              .then(res => {
                this.sports = res.data
              })
      },
      logout() {
      window.localStorage.removeItem("username");
      window.localStorage.removeItem("accessToken");
      window.location.reload();
  },
      createGame() {
        this.loading = true;
        this.newGame.ownerid = getUserIdFromToken(getJwtToken())
        Api.createGame(this.newGame)
            .then(res => {
              console.log(res)
              modals.modal3 = false;
              this.loading = false;
            })
            .catch((error) => {
              console.log(error);
              this.loading = false;
            })
      }
    }
  };
</script>
<style>
</style>
