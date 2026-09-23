local showIndex = 1

function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")
end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    SetPanel()
end

function SetPanel()
    cardData = RoleMgr:GetData(data.cid)
    weaponLv = cardData:GetWeaponLv() - 1 -- 升级前等级
    weaponCfg = Cfgs.CfgCardWeapon:GetByID(cardData:GetCfgID())
    weaponChildCfg = weaponCfg.infos[weaponLv + 1]
    nextWeaponChildCfg = weaponCfg.infos[weaponLv + 2] -- 当前等级
    -- title
    local lanID = 340007
    if (weaponLv == 0) then
        lanID = 340015
    end
    LanguageMgr:SetText(txtTitle1, lanID)
    -- 
    local isSkill = nextWeaponChildCfg.show_types == 1
    CSAPI.SetGOActive(node1, not isSkill)
    CSAPI.SetGOActive(node2, isSkill)
    if (isSkill) then
        SetNode2()
    else
        SetNode1()
    end
end

-- 属性
function SetNode1()
    local curStatus = weaponChildCfg.use_types or {}
    local nextStaus = nextWeaponChildCfg.use_types or {}
    local curStatusDic = GetStatusDic(curStatus)
    local nextStatusDic = GetStatusDic(nextStaus)
    local statusDic = {}
    for k, v in pairs(nextStatusDic) do
        local _isNew = not curStatusDic[k]
        local _rValue  = nil 
        if(not _isNew and v ~= curStatusDic[k])then 
            _rValue = v
        end
        table.insert(statusDic, {
            id = k,
            isNew = _isNew,
            lValue = _isNew and v or curStatusDic[k],
            rValue = _rValue
        })
    end
    local statusArr = {}
    for k, v in pairs(statusDic) do
        table.insert(statusArr, {v.id, v.lValue, v.rValue, v.isNew})
    end
    statusItems = statusItems or {}
    ItemUtil.AddItems("Role/RoleWeaponStatusItem", statusItems, statusArr, glg)
    CSAPI.SetText(txtLv0, "Lv." .. (weaponLv + 1))
end

-- 技能 修改命名 txtSkillDesc1
function SetNode2()
    -- l 
    thItems1 = thItems1 or {}
    skillGrid1 = skillGrid1 or nil
    SetSkill(weaponChildCfg, skillParent1, txtSkillName1, txtSkillDesc1, content1, thItems1, skillGrid1)
    CSAPI.SetText(txtLv1, "Lv." .. weaponLv)
    -- r 
    thItems2 = thItems2 or {}
    skillGrid2 = skillGrid2 or nil
    SetSkill(nextWeaponChildCfg, skillParent2, txtSkillName2, txtSkillDesc2, content2, thItems2, skillGrid2)
    CSAPI.SetText(txtLv2, "Lv." .. weaponLv + 1)
end

function SetSkill(_cfg, _skillParent, _txtSkillName1, _txtSkillDesc, _content, _thItems, _skillGrid)
    local oldSkillData = cardData:GetSkillByGroup(_cfg.skill_group)
    -- oldSkill
    if _skillGrid == nil then
        ResUtil:CreateUIGOAsync("Role/RoleInfoSkillItem1", _skillParent, function(go)
            _skillGrid = ComUtil.GetLuaTable(go)
            _skillGrid.Refresh(oldSkillData.id)
            _skillGrid.SetClickCB(ClickSkillItemCB)
        end);
    else
        _skillGrid.Refresh(oldSkillData.id)
        _skillGrid.SetClickCB(ClickSkillItemCB)
    end
    -- str 
    local str = "Lv." .. _cfg.level .. "-" .. LanguageMgr:GetByID(340012)
    CSAPI.SetText(txtQH, str)
    -- name 
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(oldSkillData.id)
    CSAPI.SetText(_txtSkillName1, cfgDesc.name)
    -- oldDesc
    CSAPI.SetText(_txtSkillDesc, cfgDesc.desc)
    -- th 
    if (_cfg.skills) then
        ItemUtil.AddItems("Role/RoleWeaponTHItem", _thItems, _cfg.skills, _content)
    end
end

function ClickSkillItemCB()
    OnClickMask()
    local oldSkillData = cardData:GetSkillByGroup(nextWeaponChildCfg.skill_group)
    CSAPI.OpenView("RoleSkillInfoView", {oldSkillData, cardData}, 1)
end

-- 属性转化为dic
function GetStatusDic(use_types)
    local dic = {}
    for k, v in ipairs(use_types) do
        dic[v[1]] = v[2]
    end
    return dic
end

function OnClickMask()
    if not isCanBack then
        return
    end

    fade:Play(1, 0, 167, 0, function()
        view:Close()
    end)
end
function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    view:Close()
end
