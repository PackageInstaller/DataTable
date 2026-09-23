-- local iconColors = {"white", "green", "blue", "purple", "yellow", "red"}
--local iconColors = {"ffffff", "57bd7e", "39a9ff", "cf83f3", "ff7246", "ff4747"}

function OnOpen()
    id = data[1]
    isTalent = data[2] == 2

    SetTop()
    SetDatas()
    SetItems()
    SetPopup()
end

function SetTop()
    cfg = nil
    local cfgDesc = nil
    if (isTalent) then
        cfg = Cfgs.CfgSubTalentSkill:GetByID(id)
        cfgDesc = cfg
    else
        cfg = Cfgs.skill:GetByID(id)
        cfgDesc = Cfgs.CfgSkillDesc:GetByID(id)
    end
    -- child
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
    -- --imgTypc
    -- local b = false
    -- local strID = nil
    -- if(isTalent) then
    -- 	b = true
    -- 	strID = 4035
    -- else
    -- 	if(cfg.main_type == SkillMainType.CardTalent) then
    -- 		b = true
    -- 		strID = 4044
    -- 	end
    -- end
    -- CSAPI.SetGOActive(imgTypc, b)
    -- if(b) then
    -- 	LanguageMgr:SetText(txt_type, strID)
    -- end
    -- --imgGrid
    -- if(not isTalent and cfg.main_type ~= SkillMainType.CardTalent) then
    -- 	CSAPI.SetGOActive(imgGrid, true)
    -- 	local resRange = "effective_range_07";	
    -- 	if(cfg and cfg.range_key) then
    -- 		local cfgRange = Cfgs.skill_range:GetByKey(cfg.range_key);
    -- 		resRange = cfgRange.skill_icon;
    -- 	end	
    -- 	if(cfgDesc and cfgDesc.icon_bg_type) then
    -- 		local colorIndex = cfgDesc.icon_bg_type or 1;
    -- 		local colorStr = "";
    -- 		if(colorIndex and iconColors[colorIndex]) then
    -- 			colorStr = "_" .. iconColors[colorIndex];
    -- 		end
    -- 		resRange = "UIs/Skill/" .. resRange .. colorStr .. ".png";
    -- 		CSAPI.LoadImg(imgGrid, resRange, true, nil, true);
    -- 	end
    -- else
    -- 	CSAPI.SetGOActive(imgGrid, false)
    -- end
    -- lv
	local maxLv = GetMaxLv()
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv1, string.format("%s%s<color=#929296>/%s</color>",lvStr, cfg.lv, maxLv))
    --local str1 = LanguageMgr:GetByID(4039)
    --CSAPI.SetText(txtLv2, string.format("%s：<color=#ffc146>LV.%s</color>", str1, cfg.lv))
    -- name
    CSAPI.SetText(txt_name, cfgDesc.name)

    -- light
    CSAPI.SetImgColorByCode(light, RoleTool.GetSkillColor(cfgDesc.icon_bg_type))
end

function SetDatas()
    datas = {}
    if (isTalent) then
        -- 天赋
        datas = Cfgs.CfgSubTalentSkill:GetGroup(cfg.group)
    else
        -- 技能
        datas = Cfgs.skill:GetGroup(cfg.group)
    end
end

function SetItems()
    items = items or {}
    local elseData = {id, isTalent, #datas, cfg.lv}
    ItemUtil.AddItems("RoleSkillItem/RoleSkillAllLVItem", items, datas, content, nil, 1, elseData)
end

function SetPopup()
    local cfgs = {}
    local cfgDesc = nil
    for i, v in ipairs(datas) do
        if (isTalent) then
            local cfg = Cfgs.CfgSubTalentSkill:GetByID(v.id)
            cfgDesc = cfg
        else
            cfgDesc = Cfgs.CfgSkillDesc:GetByID(v.id)
        end

        local desc1 = ""
        if (data.isTalent) then
            desc1 = cfgDesc.desc
        else
            desc1 = cfgDesc.desc
        end
        local _desc1, _cfgs1 = StringUtil:SkillDescFormat(desc1)
        table.insert(cfgs, _cfgs1)
        -- desc2 
        local desc2 = ""
        if (not data.isTalent) then
            desc2 = cfgDesc.desc1
        end
        local _desc2, _cfgs2 = "", {}
        if (desc2 and desc2 ~= "") then
            _desc2, _cfgs2 = StringUtil:SkillDescFormat(desc2)
            table.insert(cfgs, _cfgs2)
        end
    end
    local skillEffectDatas = {}
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
    popupItems = popupItems or {}
    ItemUtil.AddItems("SkillEffectPopup/SkillEffectPopup2", popupItems, skillEffectDatas, Content2, nil, 1, nil,
        SetSVSize)
end

function SetSVSize()
    -- 延迟1帧执行
    FuncUtil:Call(function()
        local arr = CSAPI.GetRTSize(Content2)
        CSAPI.SetRTSize(child2, 560, arr[1] + 100)
    end, nil, 1)
end

function OnClickMask()
    view:Close()
end
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
