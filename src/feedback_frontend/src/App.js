// App.js
import React, { useState, useEffect } from 'react';
import './App.css';
import MessageForm from './MessageForm';
import MessageList from './MessageList';

function App() {
  const [messages, setMessages] = useState([]);

  // Function to fetch messages from the backend
  async function fetchMessages() {
    try {
      const response = await fetch('/api/messages');
      const data = await response.json();
      setMessages(data);
    } catch (error) {
      console.error("Error fetching messages:", error);
    }
  }

  useEffect(() => {
    fetchMessages();
  }, []);

  // Function to handle deletion and update state by re-fetching messages
  const handleDelete = async (id) => {
    try {
      await fetch(`/api/message/${id}`, { method: 'DELETE' });
      fetchMessages();
    } catch (error) {
      console.error("Error deleting message:", error);
    }
  };

  // Update handleAddMessage to re-fetch messages rather than expecting a JSON response
  const handleAddMessage = async (message) => {
    try {
      await fetch('/api/message', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ message }),
      });
      // Instead of using the empty POST response to update state,
      // re-fetch messages from the backend.
      fetchMessages();
    } catch (error) {
      console.error("Error adding message:", error);
    }
  };

  return (
    <div className="App">
      <h1>Feedback App</h1>
      <MessageForm onAddMessage={handleAddMessage} />
      <MessageList messages={messages} onDelete={handleDelete} />
    </div>
  );
}

export default App;
