<cfinclude template="/views/partials/header.cfm" runonce="true"/>

<cfscript>
    all_group_names = new db.GroupChat().findGroupChatsByUsername(getAuthUser());
    allMembersExceptSelf = new db.Chat().getAllContact(getAuthUser());
</cfscript>

<style type="text/css">
    <cfinclude template="/assets/css/chat.css" />
</style>

<div class="chat-container" id="chat-container">
    <div class="sidebar">
        <div class="text-center m-3">
            <!-- Button to open the modal -->
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createGroupModal">Create Group</button>
        </div>
        <h6 class="text-center">Contacts</h6>
        <ul class="list-group">
            <cfoutput query="all_group_names">
                <!--- Check if url.chatwith exists and if it matches the username --->
                <cfset isActive = (StructKeyExists(url, "groupchatwith") AND url.groupchatwith EQ chat_name)> 
        
                <li class="list-group-item <cfif isActive>active</cfif>">
                    <a href="?groupchatwith=#chat_name#" class="btn btn-link">#chat_name#</a>
                </li>
            </cfoutput>
        </ul>
    </div>
    <div class="chat-area" id="chat-area">
    </div>
</div>

<!-- Bootstrap Modal Structure with Dual List Box -->
<div class="modal fade" id="createGroupModal" tabindex="-1" aria-labelledby="createGroupModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createGroupModalLabel">Create Group</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="createGroupForm">
                    <div class="mb-3">
                        <label for="groupName" class="form-label">Group Name</label>
                        <input type="text" class="form-control" id="groupName" name="groupName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Add Members</label>
                        <div class="d-flex">
                            <!-- Available Members List -->
                            <select id="availableMembers" class="form-control" multiple style="height: 150px; width: 45%;">
                                <cfoutput query="allMembersExceptSelf">
                                    <option value="#username#">#username#</option>
                                </cfoutput>
                            </select>
                            
                            <!-- Control Buttons -->
                            <div class="d-flex flex-column justify-content-center mx-3">
                                <button type="button" class="btn btn-primary mb-2" onclick="addSelectedMembers()"> &gt; </button>
                                <button type="button" class="btn btn-primary" onclick="removeSelectedMembers()"> &lt; </button>
                            </div>
                            
                            <!-- Selected Members List -->
                            <select id="selectedMembers" name="groupMembers[]" class="form-control" multiple style="height: 150px; width: 45%;" required>
                                <!-- Selected members will appear here -->
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary" form="createGroupForm">Create Group</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    <cfoutput>
        let from_username = "#getAuthUser()#";
        let chat_id;
        let wschat;
    </cfoutput>
    <cfinclude template="./groupChatHandler.js" />
</script>




<script type="text/javascript">
</script>


<cfinclude template="/views/partials/footer.cfm" runonce="true"/>