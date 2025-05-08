import React, { useState } from 'react';
import Signup from './components/signup.js';
import Login from './components/login.js';
import Dashboard from './components/Dashboard.js';

function App() {
    const [currentView, setCurrentView] = useState('login');
  
    const renderView = () => {
      switch (currentView) {
        case 'signup':
          return <Signup />;
        case 'login':
          return <Login />;
        case 'dashboard':
          return <Dashboard />;
        default:
          return <Login />;
      }
    };
  
    return (
      <div className="App">
        <h1>DrivePulse Tracker</h1>
        <div>
          <button onClick={() => setCurrentView('login')}>Login</button>
          <button onClick={() => setCurrentView('signup')}>Signup</button>
          <button onClick={() => setCurrentView('dashboard')}>Dashboard</button>
        </div>
        <div>
          {renderView()}
        </div>
      </div>
    );
  }
  
  export default App;
  
  // src/components/Signup.js
  import React, { useState } from 'react';
  import { signup } from '../api';
  
  const Signup = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
  
    const handleSignup = async () => {
      try {
        const result = await signup(email, password);
        alert(result.message);
      } catch (error) {
        alert('Signup failed');
      }
    };
  
    return (
      <div>
        <h2>Signup</h2>
        <input type="email" placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} />
        <input type="password" placeholder="Password" value={password} onChange={e => setPassword(e.target.value)} />
        <button onClick={handleSignup}>Signup</button>
      </div>
    );
  };
  
  export default Signup;
  
  // src/components/Login.js
  import React, { useState } from 'react';
  import { login } from '../api';
  
  const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
  
    const handleLogin = async () => {
      try {
        const result = await login(email, password);
        alert(result.message);
      } catch (error) {
        alert('Login failed');
      }
    };
  
    return (
      <div>
        <h2>Login</h2>
        <input type="email" placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} />
        <input type="password" placeholder="Password" value={password} onChange={e => setPassword(e.target.value)} />
        <button onClick={handleLogin}>Login</button>
      </div>
    );
  };
  
  export default Login;
  
  // src/components/Dashboard.js
  import React from 'react';
  
  const Dashboard = () => {
    return (
      <div>
        <h2>Dashboard</h2>
        <p>Welcome to your dashboard!</p>
      </div>
    );
  };
  
  export default Dashboard;
  
  // src/api/index.js
  const BASE_URL = 'http://localhost:8080';
  
  export const signup = async (email, password) => {
    const response = await fetch(`${BASE_URL}/signup`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ email, password })
    });
    return response.json();
  };
  
  export const login = async (email, password) => {
    const response = await fetch(`${BASE_URL}/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ email, password })
    });
    return response.json();
  };