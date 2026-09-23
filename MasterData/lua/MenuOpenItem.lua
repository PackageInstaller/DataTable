function SetClickCB(_cb)
    cb = _cb
end
-- MenuConditionInfo
function Refresh(_data)
    data = _data
    -- icon
    local iconName = data and data:GetIcon() or nil
    if (iconName) then
        ResUtil.SystemOpen:Load(icon, iconName)
    end
    -- name
    CSAPI.SetText(txtName, data:GetCfg().sName)
end

function OnClick()
    if (data:GetCfg().jump) then
        JumpMgr:Jump(data:GetCfg().jump)
        cb()
    end
end
