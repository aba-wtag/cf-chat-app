<cfinclude template="/views/partials/header.cfm" runonce="true"/>

<cfscript>
    allContact = new controllers.chat.chatDbConn().getAllContact(getAuthUser());
</cfscript>

<style type="text/css">
    <cfinclude template="/assets/css/chat.css" />
</style>

<div class="chat-container" id="chat-container">
    <div class="sidebar">
        <h5>Contacts</h5>
        <ul class="list-group">
            <cfoutput query="allContact">
                <li class="list-group-item">
                    <a href="?chatwith=#username#" class="btn btn-link">#username#</a>
                </li>
            </cfoutput>
        </ul>
    </div>
    <div class="chat-area" id="chat-area">
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
    </div>
</div>



<script type="text/javascript">
    <cfoutput>
        let from_username = "#getAuthUser()#";
        let to_username;
        let chat_id;
        let wschat;
    </cfoutput>
    <cfinclude template="./chatHandler.js" />
</script>


<cfinclude template="/views/partials/footer.cfm" runonce="true"/>