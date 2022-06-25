--  Name:       cl_notifications.lua
--  Realm:      Client
--  Purpose:    Allows convinient networking of messages from server to client.
--  Date:       07/03/2021 - 1:44 PM
local net_Receive = net.Receive
local net_ReadTable = net.ReadTable
local unpack = unpack

net_Receive("jlib.notifications", function()
    local tab = net_ReadTable()
    chat.AddText(unpack(tab))
end)