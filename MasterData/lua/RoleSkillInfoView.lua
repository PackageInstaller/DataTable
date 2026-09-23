-- local iconColors = {"white", "green", "blue", "purple", "yellow", "red"}
-- local iconColors = {"ffffff", "57bd7e", "39a9ff", "cf83f3", "ff7246", "ff4747"}
local isDetail = true

function Awake()
    cg_btnUp = ComUtil.GetCom(btnUp, "CanvasGroup")
end

function OnOpen()
    if (isIn) then
        return
    end
    isIn = 1

    skillTalentData = data[1]
    cardData = data[2]

    isTalent = openSetting == 2
    cfg = nil
    cfgDesc = nil
    if (isTalent) then
        cfg = Cfgs.CfgSubTalentSkill:GetByID(skillTalentData.id)
        cfgDesc = cfg
    else
        cfg = Cfgs.skill:GetByID(skillTalentData.id)
        cfgDesc = Cfgs.CfgSkillDesc:GetByID(skillTalentData.id)
    end

    -- child
    maxLv = GetMaxLv()
    if (isTalent) then
        -- 天赋
        ResUtil:CreateUIGOAsync("Role/RoleInfoTalentItem2", childParent, function(go)
            local item = ComUtil.GetLuaTable(go)
            item.Refresh2(cfg)
        end)
    else
        -- 技能	
        ResUtil:CreateUIGOAsync("Role/RoleInfoSkillItem2", childParent, function(go)
            local item = ComUtil.GetLuaTable(go)
            item.Refresh2(cfg)
        end)
    end

    -- lv
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv1, string.format(lvStr .. "%s/%s", cfg.lv, maxLv))
    -- local str1 = LanguageMgr:GetByID(4039)
    -- CSAPI.SetText(txtLv2, string.format("%s：<color=#ffc146>LV.%s</color>", str1, cfg.lv))
    -- name
    CSAPI.SetText(txt_name, cfgDesc.name)
    -- 描述
    SetDesc()
    -- 升级按钮
    SetBtn()

    -- light
    CSAPI.SetImgColorByCode(light, RoleTool.GetSkillColor(cfgDesc.icon_bg_type))

    -- 
    local key = not isTalent and cfg.range_key
    SetGridIcon(key)
end

function SetBtn()
    -- 隐藏
    local isHide = false
    if (not cardData:IsBaseCard() or not cardData:CheckIsRealCard()) then
        isHide = true
    end
    -- sv1高度
    local height = isHide and 551 or 485.9
    CSAPI.SetRTSize(sv1, 691, height)
    -- btn_svType位置 
    local posY = isHide and -380 or -315.6
    CSAPI.SetAnchor(btn_svType, -190.5, posY)
    CSAPI.SetGOActive(btnUp, not isHide)
    if (isHide) then
        return
    end

    -- 
    if (isTalent) then
        isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special20")
    else
        isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special4")
    end
    local isLight = false
    if (isOpen and cfg.lv < maxLv and cardData and cardData:CheckIsRealCard()) then
        isLight = true
    end
    cg_btnUp.alpha = isLight and 1 or 0.3

    -- 多 
    local lanId = cfg.lv < maxLv and 4012 or 4217
    LanguageMgr:SetText(txtUp1, lanId)
    LanguageMgr:SetEnText(txtUp2, lanId)
end

function SetDesc()
    -- CSAPI.SetGOActive(svOnObj, isDetail)
    -- CSAPI.SetGOActive(svOffObj, not isDetail)

    local desc1 = ""
    if (isTalent) then
        desc1 = isDetail and cfgDesc.desc or cfgDesc.desc1
    else
        desc1 = isDetail and cfgDesc.desc or cfgDesc.desc2
    end
    local _desc1, _cfgs1 = StringUtil:SkillDescFormat(desc1)
    CSAPI.SetText(txt_desc1, _desc1)

    -- desc2 
    local desc2 = ""
    if (not isTalent) then
        desc2 = isDetail and cfgDesc.desc1 or cfgDesc.desc3
    end
    local _desc2, _cfgs2 = "", {}
    if (desc2 and desc2 ~= "") then
        _desc2, _cfgs2 = StringUtil:SkillDescFormat(desc2)
    end

    CSAPI.SetGOActive(overload, _desc2 ~= "")
    CSAPI.SetGOActive(txt_desc2, _desc2 ~= "")
    CSAPI.SetText(txt_desc2, _desc2)

    -- desc3 专武
    local name3, desc3, cfgs3 = "", "", {}
    if (not isTalent) then
        local oldSkill, addSkill = cardData:GetWeaponSkill()
        if (addSkill ~= nil and cfg.group == oldSkill) then
            local _cfg = Cfgs.skill:GetByID(addSkill)
            local _cfgDesc = Cfgs.CfgSkillDesc:GetByID(addSkill)
            local _desc3 = isDetail and _cfgDesc.desc or _cfgDesc.desc2
            desc3, cfgs3 = StringUtil:SkillDescFormat(_desc3)
            name3 = _cfgDesc.name
        end
    end
    CSAPI.SetGOActive(weapon, desc3 ~= "")
    CSAPI.SetText(txtWeapon, name3)
    CSAPI.SetGOActive(txt_desc3, desc3 ~= "")
    CSAPI.SetText(txt_desc3, desc3)

    -- left
    local skillEffectDatas = {}
    local cfgs = {_cfgs1, _cfgs2}
    for k, m in ipairs(cfgs) do
        for p, q in ipairs(m) do
            local isIn = false
            for i, v in ipairs(skillEffectDatas) do
                if (v.id == q.id) then
                    isIn = true
                end
            end
            if (not isIn) then
                table.insert(skillEffectDatas, q)
            end
        end
    end
    CSAPI.SetGOActive(child2, #skillEffectDatas > 0)
    if (#skillEffectDatas > 0) then
        items = items or {}
        ItemUtil.AddItems("SkillEffectPopup/SkillEffectPopup2", items, skillEffectDatas, Content2, nil, 1, nil,
            SetSVSize)
    end
end

function SetGridIcon(range_key)
    local _cfg = range_key and Cfgs.skill_range:GetByKey(range_key) or nil
    if (_cfg and _cfg.skill_icon) then
        CSAPI.SetGOActive(grid, true)
        ResUtil.RoleSkillGrid:Load(imgGrid, _cfg.skill_icon)
    else
        CSAPI.SetGOActive(grid, false)
    end
end

function SetSVSize()
    -- 延迟1帧执行
    FuncUtil:Call(function()
        local arr = CSAPI.GetRTSize(Content2)
        CSAPI.SetRTSize(child2, 560, arr[1] + 100)
    end, nil, 1)
end

-- function ItemAnims()
--     if (isFirst) then
--         return
--     end
--     isFirst = 1
--     for i, v in ipairs(items) do
--         local delay = (i - 1) * 20
--         UIUtil:SetObjFade(v.gameObject, 0, 1, nil, 300, delay)
--     end
-- end

function GetMaxLv()
    if (isTalent) then
        if (cfg.group) then
            local _cfgs = Cfgs.CfgSubTalentSkill:GetGroup(cfg.group)
            return _cfgs[#_cfgs].lv
        end
    else
        if (cfg.group) then
            local _cfgs = Cfgs.skill:GetGroup(cfg.group)
            return _cfgs[#_cfgs].lv
        end
    end
    return 1
end

-- function OnClickSVType()
--     isDetail = not isDetail
--     SetDesc()
-- end

function OnClickMask()
    view:Close()
end

function OnClickUp()
    if (not cardData) then
        return
    end
    if (cg_btnUp.alpha ~= 1) then
        if (not isOpen) then
            Tips.ShowTips(lockStr)
        end
        return
    end
    if (cardData:IsFighting()) then
        LanguageMgr:ShowTips(1003)
        return
    end
    local str = isTalent and "talent" or "skill"
    CSAPI.OpenView("RoleCenter", {cardData, cfg.id}, str) -- todo 要跳到指定技能
    view:Close()
end

