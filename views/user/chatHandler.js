var channel = "1";
var endPoint = "/ws/chat/" + channel;
var protocol = (document.location.protocol == "https:") ? "wss://" : "ws://";
var wschat = new WebSocket(protocol + document.location.host + endPoint);

const urlParams = new URLSearchParams(window.location.search);
const chatWith = urlParams.get('chatwith');

console.log(chatWith);



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
        if (messageData.from === username) {
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

function sendText() {
    var textToSend = document.getElementById("text-to-send").value;
    wschat.send(
        JSON.stringify(
            {
                from: username,
                to: "user2",
                message: textToSend
            }
        )
    );

    document.getElementById("text-to-send").value = '';
}

function sendOnEnter(evt) {
    if (evt.keyCode === 13) {
        this.sendText();
    }
}

function displayChat() {
    const urlParams = new URLSearchParams(window.location.search);
    const isChatActive = urlParams.has('chatwith'); // Adjust the parameter name as needed

    const chatArea = document.getElementById('chat-area');

    if (isChatActive) {
        const chatMessages = `
        <div class="messages">
            <div class="message sent">
                <div class="message-time">2024-10-28 10:00 AM</div>
                Wow! How are you?
            </div>
            <div class="message received">
                <div class="message-time">2024-10-28 10:01 AM</div>
                I’m good, thanks! How about you?
            </div>
        </div>
        
        <div class="input-container">
            <input type="text" class="input-box" id="text-to-send" onkeypress="sendOnEnter(event);" placeholder="Type your message..." />
            <button class="send-button" onClick="sendText();">Send</button>
        </div>
            `;
            chatArea.innerHTML = chatMessages;
    } else {
        const promptMessage = `
                    <p class="center-message">Click to start chat</p>
            `;
            chatArea.innerHTML = promptMessage;
    }
}

displayChat();