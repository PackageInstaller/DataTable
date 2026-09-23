local data = nil
function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    data = _data
    if data then
        SetIcon()
        SetName()
        SetUnLock()
    end
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName ~= nil and iconName~="" then
        ResUtil.Badge:Load(icon,iconName)
    end
end

function SetName()
    CSAPI.SetText(txtName,data:GetName())
end

function SetUnLock()
    CSAPI.SetGOActive(txt_unLock, data:GetType() ~= nil)
end