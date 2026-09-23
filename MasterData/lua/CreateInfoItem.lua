function Refresh(_data, _isSelectPool)
    quality = _data[1]
    datas = _data[2]
    isSelectPool = _isSelectPool

    if (CSAPI.RegionalCode() ~= 5 and CSAPI.RegionalCode() ~= 3) then
        LanguageMgr:SetText(txtStar, 17027, quality)
    end
    --
    ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. quality)
    -- CSAPI.LoadImg(imgStar, "UIs/Create/img_12_0" .. quality .. ".png", true, nil, true)
    --
    --[[
    local percent = 0
    local pickUpPercent = 0
    for k, m in pairs(datas) do
        percent = percent + tonumber(m.s_probability)
        if (m.desc) then
            pickUpPercent = pickUpPercent + tonumber(m.s_probability)
        end
    end
    local str = ""
    if (pickUpPercent ~= 0) then
        local p = math.ceil(pickUpPercent / percent * 100) .. "%"
        str = LanguageMgr:GetByID(17028, quality, p)
    end
    ]]
    local percent, pickUpPercent = GetPercent()
    local str = ""
    if (pickUpPercent ~= 0) then
        str = LanguageMgr:GetByID(17028, quality, p)
    end
    CSAPI.SetText(txtPU, str)
    -- grid
    -- local _datas = RomoveUp()
    items = items or {}
    ItemUtil.AddItems("RoleLittleCard/CreateProItem", items, datas, grid)

    -- CSAPI.SetText(txtPercent, "<color=#ffc146>" .. (percent * 100) .. "%</color>")
    if (CSAPI.RegionalCode() == 5 or CSAPI.RegionalCode() == 3) then
        CSAPI.SetText(txtPercent, "")
        if (quality == 6) then
            LanguageMgr:SetText(txtStar, 17061)
        else
            local str = (percent * 100) .. "%"
            LanguageMgr:SetText(txtStar, 17062, quality, str)
        end
    else
        CSAPI.SetText(txtPercent, "<color=#ffc146>" .. (percent * 100) .. "%</color>")
    end
end

function GetPercent()
    local cns = nil
    local isJP = CSAPI.IsADVRegional(3)
    if (isJP) then
        cns = isSelectPool and g_CardPoolPercentJp2 or g_CardPoolPercentJp1
    else
        cns = isSelectPool and g_CardPoolPercentCn2 or g_CardPoolPercentCn1
    end
    local percent = cns[7 - quality]
    -- local percent = 0
    -- if (quality == 6) then
    --     percent = 0.02
    -- elseif (quality == 5) then
    --     percent = CSAPI.IsADVRegional(3) and 0.089 or 0.08
    -- elseif (quality == 4) then
    --     percent = 0.4
    -- elseif (quality == 3) then
    --     percent = 0.5
    -- end
    local pickUpPercent = 0
    for k, m in pairs(datas) do
        if (m.desc) then
            pickUpPercent = 0.5
            break
        end
    end
    return percent, pickUpPercent
end

-- -- 去除单Up角色
-- function RomoveUp()
--     local _datas = {}
--     for k, v in ipairs(datas) do
--         if (not v.s_up_probability) then
--             table.insert(_datas, v)
--         end
--     end
--     return _datas
-- end
