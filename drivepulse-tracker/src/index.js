// src/api/index.js
const BASE_URL = 'http://localhost:8080'; // Adjust if your backend is hosted elsewhere

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

export const predictBehavior = async (sensorData) => {
  const response = await fetch(`${BASE_URL}/predict_behavior`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(sensorData)
  });
  return response.json();
};

export const getFuelUsage = async (carType, speed, hours) => {
  const response = await fetch(`${BASE_URL}/fuel-usage?car_type=${carType}&speed=${speed}&hours=${hours}`);
  return response.json();
};

export const getVehicleStatus = async (speed, rpm) => {
  const response = await fetch(`${BASE_URL}/vehicle?speed=${speed}&rpm=${rpm}`);
  return response.json();
};

export const getDriverScore = async (speed, rpm) => {
  const response = await fetch(`${BASE_URL}/driver-score?speed=${speed}&rpm=${rpm}`);
  return response.json();
};

export const emergencyAlert = async (latitude, longitude) => {
  const response = await fetch(`${BASE_URL}/emergency?latitude=${latitude}&longitude=${longitude}`);
  return response.json();
};

export const autoPark = async (latitude, longitude, speed) => {
  const response = await fetch(`${BASE_URL}/auto-park?latitude=${latitude}&longitude=${longitude}&speed=${speed}`);
  return response.json();
};
