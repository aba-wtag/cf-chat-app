function addSelectedMembers() {
    const available = document.getElementById("availableMembers");
    const selected = document.getElementById("selectedMembers");
    
    Array.from(available.selectedOptions).forEach(option => {
        selected.add(option);
    });
}

function removeSelectedMembers() {
    const selected = document.getElementById("selectedMembers");
    
    Array.from(selected.selectedOptions).forEach(option => {
        document.getElementById("availableMembers").add(option);
    });
}

document.getElementById("createGroupForm").addEventListener("submit", async function(event) {
    event.preventDefault(); // Prevent actual form submission

    // Get group name
    const groupName = document.getElementById("groupName").value;

    // Collect selected members
    const selectedMembers = Array.from(document.getElementById("selectedMembers").options)
        .filter(option => option.selected)
        .map(option => option.value);

    // Add `from_username` to the selected members list
    selectedMembers.push(from_username);

    // Check if there are at least 2 selected members
    if (selectedMembers.length < 3) {
        window.location.href = "/user/groupchat";
        return;
    }

    // Prepare the payload
    const payload = {
        group_name: groupName,
        group_members: selectedMembers
    };

    try {
        // Send POST request to the server
        const response = await fetch("/rest/api/groupchat/create", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(payload)
        });

        // Handle response
        if (response.ok) {
            console.log("Group created successfully!");
            window.location.href = "/user/groupchat";
        } else {
            window.location.href = "/user/groupchat";
            console.error("Error creating group:", response.statusText);
        }
    } catch (error) {
        console.error("Network error:", error);
    }
});

