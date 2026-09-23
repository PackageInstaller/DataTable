local matIndex = nil
local iconColors = {"white", "green", "blue", "purple", "yellow", "red"};

-- 引导用 todo 
function Awake()
    EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "RoleSkill");
    AdaptiveConfiguration.SetLuaObjUIFit("RoleSkill", gameObject)
    --
    eventMgr = ViewEvent.New()    
    eventMgr:AddListener(EventType.Menu_PopupPack, function ()
        PopupPackMgr:CheckByCondition({2})
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
    AdaptiveConfiguration.LuaView_Lua_Closed("RoleSkill")
end

function Refresh(_cardData, _curData)
    cardData = _cardData or cardData
    curData = _curData or curData

    RefreshPanel()
end

function RefreshPanel()
    cfg = Cfgs.skill:GetByID(curData.id)
    cfgDesc = Cfgs.CfgSkillDesc:GetByID(cfg.id)
    isMax = cfg.next_id == nil
    nextCfg = not isMax and Cfgs.skill:GetByID(cfg.next_id) or nil
    maxLv = GetMaxLv()
    isPassive = cfg.main_type == SkillMainType.CardTalent and true or false

    -- name
    CSAPI.SetText(txtName, cfgDesc.name)
    -- lv 
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    local str = isMax and string.format(lvStr .. "%s", cfg.lv) or
                    string.format(lvStr .. "%s  >  <color=#FFC146>%s%s</color>", cfg.lv, lvStr, nextCfg.lv)
    CSAPI.SetText(txtLv, str)
    -- desc1
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(cfg.id)
    local desc4 = cfgDesc.desc4 and StringUtil:SkillDescFormat(cfgDesc.desc4) or ""
    CSAPI.SetText(txtDesc1, desc4)
    -- imgGrid
    SetIconGrid()
    -- txtPassive
    CSAPI.SetGOActive(txtPassive, isPassive)
    -- spadd
    if (isPassive) then
        CSAPI.SetGOActive(txtSPAdd, true)
        local sp1 = RoleSkillMgr:GetAddSP(cardData, cfg)
        local sp2 = nextCfg and RoleSkillMgr:GetAddSP(cardData, nextCfg) or 0
        local _spStr = LanguageMgr:GetByID(28001) or "SP"
        local spStr = isMax and string.format(_spStr .. "+%s", sp1) or
                          string.format(_spStr .. "+%s  >  %s+<color=#FFC146>%s</color>", sp1, _spStr, sp2)
        CSAPI.SetText(txtSPAdd, spStr)
    else
        CSAPI.SetGOActive(txtSPAdd, false)
    end
    -- desc2 (overload)
    local desc5 = ""
    if (cfgDesc.desc5) then
        desc5 = StringUtil:SkillDescFormat(cfgDesc.desc5)
    end
    CSAPI.SetGOActive(overload, desc5 ~= "")
    CSAPI.SetText(txtDesc2, desc5)

    SetMaterials()
    SetBtnUp()

    -- max
    CSAPI.SetGOActive(objMax, isMax)
end

function SetIconGrid()
    CSAPI.SetGOActive(imgGrid, not isPassive)
    if (not isPassive) then
        -- icon
        local resRange = "effective_range_07";
        if (cfg and cfg.range_key) then
            local cfgRange = Cfgs.skill_range:GetByKey(cfg.range_key);
            resRange = cfgRange.skill_icon;
        end
        if (cfgDesc and cfgDesc.icon_bg_type) then
            local colorIndex = cfgDesc.icon_bg_type or 1;
            local colorStr = "";
            if (colorIndex and iconColors[colorIndex]) then
                colorStr = "_" .. iconColors[colorIndex];
            end
            resRange = "UIs/Skill/" .. resRange .. colorStr .. ".png";
            CSAPI.LoadImg(imgGrid, resRange, true, nil, true);
        end
        -- np
        local str, num = RoleTool.GetNPStr(cfg)
        CSAPI.SetText(txtSP1, str)
        CSAPI.SetText(txtSP2, num .. "")
    end
end

function SetMaterials()
    CSAPI.SetGOActive(mat, not isMax)
    if (not isMax) then
        CSAPI.SetGOActive(materialGrids1, not isPassive)
        CSAPI.SetGOActive(materialGrids2, isPassive)
        if (isPassive) then
            passiveMats()
        else
            NormalMats()
        end
    end
end

function NormalMats()
    isEnough = true
    -- datas
    datas1 = {}
    local expCfg = Cfgs.CardSkillExp:GetByID(cardData:GetQuality())
    local materialCfg = expCfg.arr[cfg.lv]
    local mats = materialCfg and materialCfg.costs or {}
    for i, v in ipairs(mats) do
        local goodsData = BagMgr:GetFakeData(v[1])
        table.insert(datas1, {goodsData, v[2]})
        if (isEnough) then
            isEnough = goodsData:GetCount() >= v[2]
        end
    end
    -- items
    items1 = items1 or {}
    local count = #datas1 > 1 and 5 or 1
    ItemUtil.AddItems("Grid/RoleGridItem", items1, datas1, materialGrids1, GridClickFunc.OpenInfo, 1, {nil, count})

    -- 金币
    CSAPI.SetGOActive(coin, materialCfg.costAdds ~= nil)
    if (materialCfg.costAdds ~= nil) then
        local cost = materialCfg.costAdds[1]
        local cfg = Cfgs.ItemInfo:GetByID(cost[1])
        ResUtil.IconGoods:Load(imgCoin, cfg.icon .. "_1")
        CSAPI.SetText(txtCoin, cost[2] .. "")
        if (isEnough) then
            isEnough = BagMgr:GetCount(cost[1]) >= cost[2]
        end
    end
end

function passiveMats()
    goodsData1 = BagMgr:GetFakeData(cardData:GetCfg().coreItemId)
    local num1 = RoleTool.GetTalentUpgrateCostNum(cardData, curData)
    isEnough1 = goodsData1:GetCount() >= num1

    local cost = RoleTool.GetTalentUpgrateElseCost(cardData, curData)
    local goodsData2 = cost ~= nil and BagMgr:GetFakeData(cost[1]) or nil
    isEnough2 = cost ~= nil and goodsData2:GetCount() >= cost[2] or false

    if (matIndex == nil) then
        matIndex = (not isEnough1 and isEnough2) and 2 or 1
    else
        if (matIndex == 2 and not isEnough2) then
            matIndex = 1
        end
    end

    datas2 = {{goodsData1, num1, true}, {goodsData2, cost and cost[2] or 0, true}}
    items2 = items2 or {}
    ItemUtil.AddItems("Grid/RoleGridItem2", items2, datas2, materialGrids2, ItemClickCB, 1, {matIndex, 1})

    isEnough = matIndex == 1 and isEnough1 or isEnough2

    -- 金币
    CSAPI.SetGOActive(coin, false)
end

function ItemClickCB(_index)
    if (matIndex ~= _index) then
        matIndex = _index
        MatSetSelect()
    else
        local tab = items2[_index]
        GridRewardGridFunc(tab)
    end
end

function MatSetSelect()
    isEnough = matIndex == 1 and isEnough1 or isEnough2
    for i, v in ipairs(items2) do
        v.SetSelect(matIndex)
    end
    SetBtnUpAlpha(isEnough and 1 or 0.3)
end

function SetBtnUp()
    CSAPI.SetGOActive(btnUp, not isMax)
    if (not isMax) then
        SetBtnUpAlpha(isEnough and 1 or 0.3)
    end
end

function SetBtnUpAlpha(num)
    if (btnUpCanvasGroup == nil) then
        btnUpCanvasGroup = ComUtil.GetCom(btnUp, "CanvasGroup")
    end
    btnUpCanvasGroup.alpha = num
end

function GetMaxLv()
    local cfg = Cfgs.skill:GetByID(cfg.id)
    if (cfg.group) then
        local _cfgs = Cfgs.skill:GetGroup(cfg.group)
        return _cfgs[#_cfgs].lv
    end
    return cfg.lv
end

function OnClickUp()
    if (not isPassive) then
        if (isEnough) then
            RoleSkillMgr:CardSkillUpgrade(cardData:GetID(), cfg.id)
        end
    else
        if (isEnough) then
            local str = matIndex == 1 and "costNum" or "costArr"
            PlayerProto:MainTalentUpgrade(cardData:GetID(), cfg.id, str)
        end
    end
end

function OnClickAll()
    local id = cfg.id
    CSAPI.OpenView("RoleSkillAllLV", {id, 1})
end
