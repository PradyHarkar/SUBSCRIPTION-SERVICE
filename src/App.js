import React from 'react';
import Login from './Login';
import Subscription from './Subscription';
import './App.css';

function App() {
  return (
    <div className="App">
      <header>
        <nav>
          <ul>
            <li>Home</li>
            <li>About Us</li>
            <li>Services</li>
          </ul>
        </nav>
      </header>
      <main>
        <Login />
        <Subscription />
      </main>
      <footer>
        <p>© 2025 Your Company</p>
        <ul>
          <li>Privacy Policy</li>
          <li>Careers</li>
          <li>Contact Us</li>
        </ul>
      </footer>
    </div>
  );
}

export default App;