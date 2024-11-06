
function sendText() {
    var textToSend = document.getElementById("text-to-send").value;
    if (wschat && wschat.readyState === WebSocket.OPEN) {
        wschat.send(
            JSON.stringify({
                from: from_username,
                chat_id: chat_id,
                message: textToSend
            })
        );
        document.getElementById("text-to-send").value = ''; // Clear the input field
    } else {
        console.error("WebSocket is not open or not initialized.");
    }
}

function sendOnEnter(evt) {
    if (evt.keyCode === 13) {
        this.sendText();
    }
}

function initializeWebSocket(channel) {
    var endPoint = "/ws/chat/" + channel;
    var protocol = (document.location.protocol == "https:") ? "wss://" : "ws://";
    wschat = new WebSocket(protocol + document.location.host + endPoint);

    const urlParams = new URLSearchParams(window.location.search);



    wschat.addEventListener("open", (evt) => {
        console.log("WebSocket connection opened:", evt);
    });

    wschat.addEventListener("message", (evt) => {
        try {
            const messagesDiv = document.querySelector('.messages');       
            const data = JSON.parse(evt.data);
            console.log("Message received:", data);
            
            // Parse the MESSAGE field to get the actual message details
            const messageData = JSON.parse(data.MESSAGE);
            
            // Create a new message element
            const newMessage = document.createElement('div');

            // Check if the message is sent or received
            if (messageData.from === from_username) {
                newMessage.className = 'message sent'; // User sent the message
            } else {
                newMessage.className = 'message received'; // User received the message
            }

            // Format the message time from the TIMESTAMP
            const messageTime = new Date(data.TIMESTAMP).toLocaleString(); // Adjust format as needed
            const timeDiv = document.createElement('div');
            timeDiv.className = 'message-time';
            timeDiv.textContent = messageTime;

            // Set the message content
            newMessage.textContent = messageData.message; // Access the message content
            newMessage.appendChild(timeDiv);

            // Append the new message to the messages div
            messagesDiv.appendChild(newMessage);
            
            // Optionally scroll to the bottom
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
            
        } catch (error) {
            console.error("Error parsing message:", error);
        }
    });
}

async function displayChat() {
    const urlParams = new URLSearchParams(window.location.search);
    const isChatActive = urlParams.has('chatwith'); // Check if the "chatwith" query parameter exists
    to_username = urlParams.get('chatwith');  // Get the username of the person you want to chat with
     // The element where the chat will be displayed

    if (isChatActive && to_username) {
        try {
            // Fetch chat_id from the API endpoint
            const response = await fetch('/rest/api/chat/getchatinfo', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ from: from_username, to: to_username }),
            });

            const data = await response.json(); // Parse the JSON response

            if (data && data.chat_id) {
                // Initialize WebSocket with the chat_id
                chat_id = data.chat_id;
                initializeWebSocket(chat_id);

                // Display existing chat messages (This could be extended with dynamic message loading)
                renderMessage(chat_id);
            } else {
                console.error('Chat ID not found or error occurred.');
            }
        } catch (error) {
            console.error('Error fetching chat info:', error);
        }

    } else {
        const promptMessage = `
            <p class="center-message">Click to start chat</p>
        `;
        chatArea.innerHTML = promptMessage; // Show prompt message if no chat is active
    }
}

async function renderMessage(chat_id) {
    const chatArea = document.getElementById('chat-area');
    
    // Fetch chat messages from the server
    const messageResponse = await fetch('/rest/api/chat/getchatmessages', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 'chat_id': chat_id }),
    });

    const messageData = await messageResponse.json();

    // Initialize an empty string to hold the HTML content
    let chatMessagesHTML = '<div class="messages">';

    // Loop through each message in the response and create HTML elements
    messageData.forEach(message => {
        const formattedTimestamp = formatTimestamp(message.TIMESTAMP);
        
        // Check if the message is sent or received based on the "FROM" field
        const messageClass = message.FROM === from_username ? 'sent' : 'received';

        // Create HTML for the message
        chatMessagesHTML += `
            <div class="message ${messageClass}">
                <div class="message-time">${formattedTimestamp}</div>
                ${message.BODY}
            </div>
        `;
    });

    // Close the messages container
    chatMessagesHTML += '</div>';

    // Add the input container below the messages
    chatMessagesHTML += `
        <div class="input-container">
            <input type="text" class="input-box" id="text-to-send" onkeypress="sendOnEnter(event);" placeholder="Type your message..." />
            <button class="send-button" onClick="sendText();">Send</button>
        </div>
    `;

    // Insert the chat messages into the chat area
    chatArea.innerHTML = chatMessagesHTML;

    // Optionally, scroll to the bottom of the chat area
    chatArea.scrollTop = chatArea.scrollHeight;
}

function formatTimestamp(timestamp) {
    const date = new Date(timestamp);
    return date.toLocaleString();  // Customize the format as needed
}

displayChat();