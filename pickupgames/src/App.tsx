import React from 'react';
import {Admin, Resource} from 'react-admin';
import {
	BrowserRouter as Router,
	Switch,
	Route,
	Link
  } from "react-router-dom";
import simpleRestProvider from 'ra-data-simple-rest';

import logo from './logo.svg';
import './App.css';
import Signup from './pages/Signup';
import PageNotFound from './pages/PageNotFound';
	

function App() {
  return (
    // <div className="App">
    //   <header className="App-header">
    //     <img src={logo} className="App-logo" alt="logo" />
    //     <p>
    //       Edit <code>src/App.tsx</code> and save to reload.
    //     </p>
    //     <a
    //       className="App-link"
    //       href="https://reactjs.org"
    //       target="_blank"
    //       rel="noopener noreferrer"
    //     >
    //       Learn React
    //     </a>
    //   </header>
	// </div>
	<Router>
		{/* <div></div>
		<Switch>
			<Route exact path='/signup' component={Signup}></Route>
			<Route component={PageNotFound}/>
		</Switch> */}
		<Admin dataProvider={simpleRestProvider('http://192.168.50.67:8000/')}>
			<Resource name="signup" create={Signup} />
		</Admin>
	</Router>
  );
}

export default App;
