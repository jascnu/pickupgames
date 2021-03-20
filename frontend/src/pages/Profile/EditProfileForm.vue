<template>
  <card>
    <h5 slot="header" class="title">Edit Profile</h5>
    <div class="row">
      <div class="col-md-5 pr-md-1">
        <base-input label="Attendance Score (disabled)"
                  placeholder="NA"
                  v-model="model.attendancescore"
                  disabled>
        </base-input>
      </div>
      <div class="col-md-3 px-md-1">
        <base-input label="Username"
                  placeholder="Username"
                  v-model="model.username"
                  disabled>
        </base-input>
      </div>
      <div class="col-md-4 pl-md-1">
        <base-input label="Email address"
                  type="email"
                  v-model="model.email"
                  placeholder="mike@email.com"
                  disabled>
        </base-input>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6 pr-md-1">
        <base-input label="First Name"
                  v-model="model.firstname"
                  placeholder="First Name">
        </base-input>
      </div>
      <div class="col-md-6 pl-md-1">
        <base-input label="Last Name"
                  v-model="model.lastname"
                  placeholder="Last Name">
        </base-input>
      </div>
      <div class="col-md-2 pr-md-1">
        <base-input label="Postal Code"
                  v-model="model.zipcode"
                  placeholder="ZIP Code">
        </base-input>
      </div>
    </div>
    <div class="row">
      <div class="col-md-8">
        <base-input>
          <label>About Me</label>
          <textarea rows="4" cols="80"
                    class="form-control"
                    placeholder="Here can be your description"
                    v-model="model.description">

              </textarea>
        </base-input>
      </div>
    </div>
    <base-button @click="update" slot="footer" type="primary" fill>Save</base-button>
  </card>
</template>
<script>
  import Api from '../../api';
  import { getJwtToken, getUserIdFromToken } from '../../auth';
  export default {
    props: {
      model: {
        type: Object,
        default: () => {
          return {};
        }
      }
    },
    methods: {
      update() {
      Api.updateUser(getUserIdFromToken(getJwtToken()), this.model)
        .then((res) => {
          console.log(res.data[0]);
        })
        .catch((error) => {
          console.log(error.response.data);
          if (error.response && error.response.status === 403) {
            //this.message = error.response.data.message;
			      console.log("Failed to update user profile");
          }
          //this.loading = false;
        });
      }
    }
  }
</script>
<style>
</style>
