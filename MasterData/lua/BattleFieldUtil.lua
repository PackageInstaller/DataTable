local this = {};

local ids = {37013,37014,37015,37016,37017}

--获取字体内容和信息
function this.GetTextColor(state)
    local txtColor = {0,255,191,255}
    local text = LanguageMgr:GetByID(ids[state])
    if state < 3 then
        txtColor = state == 1 and {255,255,255,178} or txtColor
    elseif state >3 then
        txtColor = state == 5 and {255,255,255,178} or {255,101,101,255}
    end

    return text,txtColor
end

return this; 