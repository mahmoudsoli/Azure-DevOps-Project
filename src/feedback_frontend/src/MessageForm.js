// MessageForm.js
import React, { useState } from 'react';

const MessageForm = ({ onAddMessage }) => {
  const [message, setMessage] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (message.trim()) {
      onAddMessage(message);
      setMessage('');
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        value={message}
        onChange={(e) => setMessage(e.target.value)}
        placeholder="Enter your feedback"
      />
      <button type="submit">Submit</button>
    </form>
  );
};

export default MessageForm;
