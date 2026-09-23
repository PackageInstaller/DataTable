-- data={
--     name:
--     val:
--     desc:
--     color1:
--     addColor:
--     color2:
--     isNew
-- }
function Refresh(_data)
    if _data then
        data = _data
        val1Color = _data and _data.color1 or "c3c3c8"
        val2Color = _data and _data.addColor or "ffc146"
        val3Color = _data and _data.color2 or "c3c3c8"
        if not IsNil(icon) and data.cfg then
            CSAPI.SetGOActive(icon,true);
            ResUtil.AttributeIcon:Load(icon,data.cfg.icon2);
        elseif not IsNil(icon) then
            CSAPI.SetGOActive(icon,false);
        end
        if data.desc ~= nil and data.desc ~= "" then
            CSAPI.SetGOActive(txtNum, false)
            CSAPI.SetGOActive(txtName, false)
            CSAPI.SetGOActive(txtDesc, true)
        else
            CSAPI.SetGOActive(txtName, true)
            CSAPI.SetGOActive(txtNum, true)
            CSAPI.SetGOActive(txtDesc, false)
        end
        local str1 = ""
        local str2 = ""
        local str3 = ""
        -- val1
        if data.name then
            str1 = StringUtil:SetByColor(data.name, val1Color)
        end
        -- val2
        if (data.val) then
            str2 = StringUtil:SetByColor("+"..data.val, val2Color)
        end

        if data.desc then
            str3 = StringUtil:SetByColor(data.desc, val3Color)
        end
        -- name
        SetName(str1);
        SetNum(str2);
        SetDesc(str3);
        SetLv(data.lv);
        SetNewObj(data.isNew);
    end
end

function SetIndex(i)
    CSAPI.SetGOActive(img, i % 2 == 1);
end

function SetName(str)
    CSAPI.SetText(txtName, str == nil and "" or str)
end

function SetNum(str)
    CSAPI.SetText(txtNum, str == nil and "" or str)
end

function SetDesc(str)
    CSAPI.SetText(txtDesc, str == nil and "" or str)
end

function SetLv(str)
    CSAPI.SetText(txtLv, str == nil and "" or str)
end

function SetNewObj(isNew)
    CSAPI.SetGOActive(newObj, isNew);
end