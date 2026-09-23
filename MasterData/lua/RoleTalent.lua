-- local index = 1 -- 有问题
function Awake()
    cg_btnUp = ComUtil.GetCom(btnUp, "CanvasGroup")
    FuncUtil:Call(function ()
        EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "RoleTalent"); -- 引导用
    end,nil,120)
    AdaptiveConfiguration.SetLuaObjUIFit("RoleTalent", gameObject)

    eventMgr = ViewEvent.New()    
    eventMgr:AddListener(EventType.Menu_PopupPack, function ()
        PopupPackMgr:CheckByCondition({5})
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
    AdaptiveConfiguration.LuaView_Lua_Closed("RoleTalent")
end

function Refresh(_cardData, _curData)
    cardData = _cardData or cardData
    curData = _curData or curData
    RefreshPanel()
end

function RefreshPanel()
    cfg = Cfgs.CfgSubTalentSkill:GetByID(curData.id)
    isMax = cfg.next_id == nil
    nextCfg = not isMax and Cfgs.CfgSubTalentSkill:GetByID(cfg.next_id) or nil
    maxLv = GetMaxLv()

    -- item 
    SetTalentItem()
    -- name
    CSAPI.SetText(txtName, cfg.name)
    -- lv 
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    local str = isMax and string.format(lvStr .. "%s", cfg.lv) or
                    string.format(lvStr .. "%s  >  <color=#FFC146>%s%s</color>", cfg.lv, lvStr, nextCfg.lv)
    CSAPI.SetText(txtLv, str)
    -- desc1
    local desc2 = cfg.desc2 and StringUtil:SkillDescFormat(cfg.desc2) or ""
    CSAPI.SetText(txtDesc1, desc2)

    SetUp()

    SetLock()
end

function GetMaxLv()
    local cfg = Cfgs.CfgSubTalentSkill:GetByID(cfg.id)
    if (cfg.group) then
        local _cfgs = Cfgs.CfgSubTalentSkill:GetGroup(cfg.group)
        return _cfgs[#_cfgs].lv
    end
    return cfg.lv
end

function SetTalentItem()
    if (not talentItem) then
        ResUtil:CreateUIGOAsync("Role/RoleInfoTalentItem2", talentPoint, function(go)
            talentItem = ComUtil.GetLuaTable(go)
            talentItem.Refresh2(cfg)
        end)
    else
        talentItem.Refresh2(cfg)
    end
end

function SetUp()
    CSAPI.SetGOActive(up, curData.had)
    if (curData.had) then
        SetMaterials()
        SetBtnUp()
        CSAPI.SetGOActive(objMax, isMax)
    end
end

function SetMaterials()
    CSAPI.SetGOActive(mat, not isMax)
    CSAPI.SetGOActive(coin, false)
    if (not isMax) then
        isEnough = true
        datas = {}
        local expCfg = Cfgs.CfgSubTalentMaterial:GetByID(cfg.costId)
        local materialCfg = expCfg.costs
        local mats = expCfg and expCfg.costs or {}
        for i, v in ipairs(mats) do
            local goodsData = BagMgr:GetFakeData(v[1])
            table.insert(datas, {goodsData, v[2]})
            if (isEnough) then
                isEnough = goodsData:GetCount() >= v[2]
            end
        end
        -- items
        items = items or {}
        local count = #datas > 1 and 5 or 1
        ItemUtil.AddItems("Grid/RoleGridItem", items, datas, materialGrids, GridClickFunc.OpenInfo, 1, {nil, count})

        -- 金币
        CSAPI.SetGOActive(coin, expCfg.costAdds ~= nil)
        if (expCfg.costAdds ~= nil) then
            local cost = expCfg.costAdds[1]
            local cfg = Cfgs.ItemInfo:GetByID(cost[1])
            ResUtil.IconGoods:Load(imgCoin, cfg.icon .. "_1")
            CSAPI.SetText(txtCoin, cost[2] .. "")
            if (isEnough) then
                isEnough = BagMgr:GetCount(cost[1]) >= cost[2]
            end
        end
    end
end

function SetBtnUp()
    CSAPI.SetGOActive(btnUp, not isMax)
    cg_btnUp.alpha = isEnough and 1 or 0.3
end

function SetLock()
    CSAPI.SetGOActive(lock, not curData.had)
    if (not curData.had) then
        local cfg = Cfgs.CfgCardBreakLimitLv:GetByID(curData.index)
        -- tips1
        local isSuccess1 = cardData:GetLv() >= cfg.limitLv
        CSAPI.SetGOActive(img11, not isSuccess1)
        CSAPI.SetGOActive(img12, isSuccess1)
        CSAPI.SetText(txtTips1, cfg.Unlockdes1)
        -- tips2 
        CSAPI.SetText(txtTips2, cfg.Unlockdes2)
        CSAPI.SetGOActive(img22, false)
        -- btnGo 
        local show = curData.index == cardData:GetBreakLevel()
        CSAPI.SetGOActive(btnGo, show)
    end
end

function OnClickUp()
    if (isEnough) then
        PlayerProto:UpgradeSubTalent(cardData:GetID(), curData.index)
    end
end

function OnClickGo()
    CSAPI.OpenView("RoleUpBreak", cardData)
end

function OnClickAll()
    local id = cfg.id
    CSAPI.OpenView("RoleSkillAllLV", {id, 2})
end
