local data = nil
local iconName = ""
local code = {"FFFFFF","53afe6","ffc146","deb8ff"}

function Refresh(_data,_iconName)
    data = _data
    iconName = _iconName
    if data then
        SetIcon()
        SetNum()
        SetColor()
    end
end

function SetIcon()
    if iconName~=nil and iconName~="" then
        ResUtil.AchievementType:Load(icon,iconName)
    end
end

function SetColor()
    local codeStr = code[data.index]
    CSAPI.SetImgColorByCode(icon,codeStr)
end

function SetNum()
    CSAPI.SetText(txtNum,data.cur  .. "/" .. data.max)
end