--  Name:       materials.lua
--  Realm:      Client
--  Purpose:    Allows creation of materials live using the HTTP lib.
--  Date:       07/08/2021 - 11:00 AM
local self = {}
local Material = Material
local string = string
local file = file
local http = http
self.CreatedMaterialCache = {}
self.Downloading = 0
local missing = Material("error")

function self.Material(matName)
    return matName and self.CreatedMaterialCache[string.lower(matName)] or missing
end

function self.DownloadFinished()
    if self.Downloading == 0 then
        print(CurTime() - self.StartTime)
    end
end

function self.CreateMaterial(matName, addOn, matUrl, matArgs)
    self.Downloading = self.Downloading + 1
    matName = string.lower(matName)
    jlib.msg("[Materials] '" .. addOn .. "' requested Material instance named '" .. matName .. "'")
    local directory = string.format("jlib/%s/", addOn)
    local filename = directory .. "/" .. matName .. ".png"
    file.CreateDir(directory)

    if file.Exists(filename, "DATA") then
        local mmat = Material("data/" .. filename, matArgs or "smooth")

        if not mmat:IsError() then
            jlib.msg("[Materials] Loaded resource '" .. addOn .. "' from cache.")
            self.Downloading = self.Downloading - 1
            self.CreatedMaterialCache[matName] = mmat
            self.DownloadFinished()

            return
        end
    end

    http.Fetch(matUrl, function(b, _, _, _)
        file.Write(filename, b)
        self.CreatedMaterialCache[matName] = Material("data/" .. filename, "smooth")
        jlib.msg("[Materials] Created new WebMaterial Instace '" .. matName .. "'")
        self.Downloading = self.Downloading - 1
        self.DownloadFinished()
    end)
end

local function requestResources()
    timer.Simple(0, function()
        self.StartTime = CurTime()
        jlib.msg("[Materials] Downloading Server Resources...")
        hook.Call("jlib.downloadResources")
    end)
end

local function clearResources()
    local res = jlib.search("jlib", "DATA")

    for _, f in ipairs(res) do
        jlib.msg("[Materials] Removing '" .. f .. "' ...")
        file.Delete(f)
    end
end

hook.Add("Initialize", "jlib.Materials.Stub", requestResources)

concommand.Add("jlib_reloadresources", function()
    requestResources()
end)

concommand.Add("jlib_clearresources", function()
    table.Empty(self.CreatedMaterialCache)
    clearResources()
end)

concommand.Add("jlib_forceredownload", function()
    clearResources()
    requestResources()
end)

jlib.materials = self