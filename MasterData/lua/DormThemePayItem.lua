-- 购买内容 
-- {id,需要的数量，已购买的数量}
function Refresh(_data, _selIndex)
    data = _data

    cfg = Cfgs.CfgFurniture:GetByID(data[1])
    -- name 
    CSAPI.SetText(txtName, cfg.sName)
    -- count
    local colorName = data[2] > data[3] and "bfbfbf" or "707070"
    StringUtil:SetColorByName(txtCount, string.format("%s/%s", data[3], data[2]), colorName)
    -- spend 
    CSAPI.SetGOActive(icon, not cfg.special)
    CSAPI.SetGOActive(txtNum, not cfg.special)
    if (not cfg.special) then
        local prices = _selIndex == 0 and cfg.price_1 or cfg.price_2
        local price = prices and prices[1] or nil
        local _cfg = Cfgs.ItemInfo:GetByID(price[1])
        local iconName = _cfg and _cfg.icon or nil
        if (iconName) then
            ResUtil.IconGoods:Load(icon, iconName .. "_1", true)
        end
        local num = data[2] > data[3] and (data[2] - data[3]) or 0
        local str = num == 0 and "---" or price[2] * num .. ""
        CSAPI.SetText(txtNum, str)
    end
    -- special
    CSAPI.SetGOActive(txtSpecial, cfg.special)
end
