
---@class DisplayConfigMgr:DisplayConfigManager
local DisplayConfigMgr = class("DisplayConfigMgr", function (...)
    return DisplayConfigManager.Instance
end)

function DisplayConfigMgr:ctor(...)
end

function DisplayConfigMgr:Clear()
end

return DisplayConfigMgr