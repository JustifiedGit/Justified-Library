--  Name:       sv_notifications.lua
--  Realm:      Server
--  Purpose:    Allows convinient networking of messages from server to client.
--  Date:       07/03/2021 - 1:44 PM
local util_AddNetworkString = SERVER and util.AddNetworkString
local FindMetaTable = FindMetaTable
util_AddNetworkString("jlib.notifications")
local meta = FindMetaTable("Player")

function meta:jlib_message(...)
    jnet.send("message", {...} or {""}, self)
    --net_Start("jlib.notifications")
    --net_WriteTable({...} or {""})
    --net_Send(self)
end

function jlib.broadcast(...)
    jnet.send("message", {...} or {""}, true)
    --net_Start("jlib.notifications")
    --net_WriteTable({...} or {""})
    --net_Broadcast()
end