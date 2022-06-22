--  Name:       cl_notifications.lua
--  Realm:      Client
--  Purpose:    Allows convinient networking of messages from server to client.
--  Date:       07/03/2021 - 1:44 PM
local unpack = unpack

jnet.subscribe("message", function(buffer)
    chat.AddText(unpack(buffer))
end)