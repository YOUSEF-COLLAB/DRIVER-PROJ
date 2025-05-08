import React, { useState } from 'react';
import axios from 'axios'; // Import axios for making HTTP requests

const Signup = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');

  const handleSignup = async () => {
    if (password !== confirmPassword) {
      setError('Passwords do not match');
      return;
    }
    setError(''); // Clear previous error

    try {
      const response = await axios.post('http://127.0.0.1:8000//signup', {
        email,
        password,
      });

      if (response.data.success) {
        setMessage('Signup successful! Please log in.');
        setEmail('');
        setPassword('');
        setConfirmPassword('');
      } else {
        setError('Signup failed. Please try again.');
      }
    } catch (err) {
      setError('Signup failed. Please try again.');
    }
  };

  return (
    <div className="signup-container">
      <h2>Sign Up</h2>
      {/* Displaying Error or Success Message */}
      {error && <div style={{ color: 'red' }}>{error}</div>}
      {message && <div style={{ color: 'green' }}>{message}</div>}

      {/* Sign Up Form */}
      <div>
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
      </div>
      <div>
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
      </div>
      <div>
        <input
          type="password"
          placeholder="Confirm Password"
          value={confirmPassword}
          onChange={(e) => setConfirmPassword(e.target.value)}
          required
        />
      </div>

      {/* Sign Up Button */}
      <button onClick={handleSignup}>Sign Up</button>
    </div>
  );
};

export default Signup;
