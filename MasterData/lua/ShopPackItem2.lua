
function Refresh(data,_selIndex)
    local c=this.index%2==0 and {0,0,0,26} or {152,152,152,26}
    CSAPI.SetImgColor(gameObject,c[1],c[2],c[3],c[4]);
    local  cfg = Cfgs.CfgFurniture:GetByID(data[1])
    if cfg==nil then
        LogError("配置表CfgFurniture中找不到数据！data:"..table.tostring(data))
        do return end
    end
    CSAPI.SetText(txt_name,cfg.sName);
    local colorName = data[2] > data[3] and "fa4048" or "ffffff"
    StringUtil:SetColorByName(txt_num, string.format("%s/%s", data[3], data[2]), colorName)
    CSAPI.SetGOActive(pIcon, not cfg.special)
    CSAPI.SetGOActive(txt_Price, not cfg.special)
    if (not cfg.special) then
        local prices = _selIndex == 1 and cfg.price_1 or cfg.price_2
        local price = prices and prices[1] or nil
        local _cfg = Cfgs.ItemInfo:GetByID(price[1])
        local iconName = _cfg and _cfg.icon or nil
        if (iconName) then
            ResUtil.IconGoods:Load(pIcon, iconName .. "_1", true)
        end
        local num = data[2] > data[3] and (data[2] - data[3]) or 0
        local str = num == 0 and "---" or price[2] * num .. ""
        CSAPI.SetText(txt_Price, str)
    end
    CSAPI.SetGOActive(txt_special, cfg.special)
end

function SetIndex(_id)
    this.index=_id;
end