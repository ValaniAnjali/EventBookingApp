// Import Firebase modules
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAy5OfLuRW1A4H15jGnjLrLOJRBOjZPvGA",
  authDomain: "eventmanagementsystem-99e2a.firebaseapp.com",
  projectId: "eventmanagementsystem-99e2a",
  storageBucket: "eventmanagementsystem-99e2a.firebasestorage.app",
  messagingSenderId: "286818601377",
  appId: "1:286818601377:web:8ee6314cd5ea69dd3de3e0",
  measurementId: "G-FHTLTTFTLM"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
