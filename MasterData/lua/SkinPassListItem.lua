local data = nil

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg, b)
    CSAPI.SetGOActive(mask, not b)
end

function Refresh(_data)
    data = _data
    if data then
        SetName()
        SetIcon()
        SetColor()
        SetRed()
    end
end

function SetName()
    CSAPI.SetText(txtName, data:GetName())
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName and iconName ~= "" then
        ResUtil.SkinPass:Load(icon, iconName)
    end
end

function SetColor()
    CSAPI.SetImgColorByCode(selImg, data:GetIconCode())
end

function SetRed()
    UIUtil:SetRedPoint(redParent, data:IsRed())
end

function OnClick()
    if cb then
        cb(this)
    end
end