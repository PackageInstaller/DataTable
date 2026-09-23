local badgeData = nil

function OnOpen()
    badgeData = data
    if data then
        SetIcon()
        SetName()
        SetTag()
        SetDesc()
        SetTime()
    end
    if openSetting then
        local x,y = openSetting[1],openSetting[2]
        SetPos(x,y)
    end
end

function SetPos(x,y)
    CSAPI.SetLocalPos(node,x,y)
end

function SetIcon()
    local iconName = badgeData:GetIcon()
    if iconName ~= nil and iconName~="" then
        ResUtil.Badge:Load(icon,iconName)
    end
end

function SetName()
    CSAPI.SetText(txtName,badgeData:GetName())
end

function SetTag()
    CSAPI.SetText(txtTag,badgeData:GetTag())
end

function SetDesc()
    CSAPI.SetText(txtDesc,badgeData:GetDesc())
end

function SetTime()
    local str = badgeData:IsGet() and LanguageMgr:GetByID(48004, badgeData:GetTimeStr()) or ""
    CSAPI.SetText(txtTime,str)
end

function OnClickBack()
    view:Close()
end

