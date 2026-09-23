function Refresh(_childCfg, _elseData)
    weaponChildCfg = _childCfg
    cardData = _elseData[1]
    weaponLv = _elseData[2]
    isSelect = weaponChildCfg.level == weaponLv

    local type = weaponChildCfg.show_types == 1 and 2 or 1 --  1属性 2技能
    CSAPI.SetGOActive(node1, type == 1)
    CSAPI.SetGOActive(node2, type == 2)
    if (type == 1) then
        SetNode1()
    else
        SetNode2()
    end
    -- str 
    local lanID = type == 1 and 340011 or 340012
    local str = "Lv." .. weaponChildCfg.level .. "-" .. LanguageMgr:GetByID(lanID)
    CSAPI.SetText(txtName, str)
    local code = type == 1 and "ffffff" or "000000"
    CSAPI.SetTextColorByCode(txtName, code)
    -- 
    CSAPI.SetGOActive(select, isSelect)
end

-- 属性
function SetNode1()
    statusItems = statusItems or {}
    ItemUtil.AddItems("Role/RoleWeaponBaseStatusItem", statusItems, weaponChildCfg.use_types, glg)
    -- 
    local bgName = isSelect and "img_60_02" or "img_60_01"
    CSAPI.LoadImg(node1, "UIs/Role/" .. bgName .. ".png", false, nil, true)
end

-- 技能
function SetNode2()
    oldSkillData = cardData:GetSkillByGroup(weaponChildCfg.skill_group)
    -- oldSkill
    if skillGrid == nil then
        ResUtil:CreateUIGOAsync("Role/RoleInfoSkillItem1", skillParent, function(go)
            skillGrid = ComUtil.GetLuaTable(go)
            skillGrid.Refresh(oldSkillData.id)
            skillGrid.SetClickCB(ClickSkillItemCB)
        end);
    else
        skillGrid.Refresh(oldSkillData.id)
        skillGrid.SetClickCB(ClickSkillItemCB)
    end

    -- name 
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(oldSkillData.id)
    CSAPI.SetText(txtSkillName, cfgDesc.name)
    -- th 
    thItems = thItems or {}
    ItemUtil.AddItems("Role/RoleWeaponTHItem", thItems, weaponChildCfg.skills, content)
    -- 
    local bgName = isSelect and "img_60_03" or "img_60_04"
    CSAPI.LoadImg(node2, "UIs/Role/" .. bgName .. ".png", false, nil, true)
end

function ClickSkillItemCB()
    oldSkillData = cardData:GetSkillByGroup(weaponChildCfg.skill_group)
    CSAPI.OpenView("RoleSkillInfoView", {oldSkillData, cardData}, 1)
end

