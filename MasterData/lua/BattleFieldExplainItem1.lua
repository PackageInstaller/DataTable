local data = nil
local isGet = nil
local index = 0

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    data = _data
    if data then
        isGet = data.isGet
        -- SetBg()
        SetIcon()
        SetBuff(data.desc)
    end
end

function SetBg()

end

function SetIcon()
    if index > 0 then
        CSAPI.LoadImg(icon, "UIs/BattleField/icon1_" .. index .. ".png", true, nil, true)
    end
end

function SetBuff(str)
    if str == "" or not isGet then
        str = LanguageMgr:GetByID(37021)
    end
    CSAPI.SetText(txtBuff, str)
    local color = isGet and {255, 193, 70, 255} or {255, 255, 255, 255}
    CSAPI.SetTextColor(txtBuff, color[1], color[2], color[3], color[4])
end
