// MessageList.js
import React from 'react';

const MessageList = ({ messages, onDelete }) => {
  return (
    <ul>
      {messages.map((msg) => (
        <li key={msg.id}>
          <span>{msg.text}</span>
          <button className="delete-btn" onClick={() => onDelete(msg.id)}>
            ❌
          </button>
        </li>
      ))}
    </ul>
  );
};

export default MessageList;
