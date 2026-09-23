function Refresh(data)
    local cfg = Cfgs.CfgCardPropertyEnum:GetByID(data[1])
    -- icon
    ResUtil.AttributeIcon:Load(icon, cfg.icon2)
    -- 
    CSAPI.SetText(txtName, cfg.sName)
    -- 
    CSAPI.SetGOActive(val1, data[2] ~= nil)
    if (data[2]) then
        local str1 = data[2] < 1 and  math.modf(data[2] * 100) .. "%" or data[2] .. ""
        CSAPI.SetText(val1, str1)
    end
    CSAPI.SetGOActive(val2, data[3] ~= nil)
    if (data[3]) then
        local str1 = data[3] < 1 and math.modf(data[3] * 100) .. "%" or data[3] .. ""
        CSAPI.SetText(val2, "+" .. str1)
    end
    CSAPI.SetGOActive(new, data[4])
end


