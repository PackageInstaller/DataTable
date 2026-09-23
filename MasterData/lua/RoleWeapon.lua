local rIndex = nil
local isShow = false
local heights = {} -- 在这个区间则显示

function Awake()
    UIUtil:AddTop2("RoleWeapon", gameObject, function()
        view:Close()
    end, nil, {})
    -- 
    sv2_sv = ComUtil.GetCom(sv2, "ScrollRect")
    mTab = ComUtil.GetCom(tabs, "CTab")
    mTab:AddSelChangedCallBack(OnTabChanged)
    --
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Card_Update, RefreshPanel)
    eventMgr:AddListener(EventType.Bag_Update, function ()
        if(rIndex==1)then 
            SetR1()
        end 
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnTabChanged(index)
    local num = index + 1
    if not rIndex or rIndex ~= num then
        rIndex = num
        SetRight()
    end
end

function Update()
    if (isShow) then
        local x, y = CSAPI.GetAnchor(content2)
        if (not oldY or oldY ~= y) then
            oldY = y
            if (heights[2] < y or (y + svHeight) < heights[1]) then
                CSAPI.SetGOActive(btnR2, true)
            else
                CSAPI.SetGOActive(btnR2, false)
            end
        end
    end
end

-- data : uid
function OnOpen()
    cardData = data
    RefreshPanel()
end

function RefreshPanel()
    -- data 
    weaponLv = cardData:GetWeaponLv()
    weaponCfg = Cfgs.CfgCardWeapon:GetByID(cardData:GetCfgID())
    weaponChildCfg = weaponCfg.infos[weaponLv + 1]
    isMax = (weaponLv + 2) > #weaponCfg.infos
    nextWeaponChildCfg = isMax and weaponChildCfg or weaponCfg.infos[weaponLv + 2]
    -- icon
    ResUtil.RoleWeapon:Load(icon, weaponChildCfg.icon)
    -- name
    CSAPI.SetText(txtName, "Lv." .. weaponLv .. " - " .. weaponCfg.weaponname)
    -- desc 
    CSAPI.SetText(txtDesc, weaponCfg.weapontext)
    -- use_types
    SetStatus()
    -- 
    if (not rIndex) then
        mTab.selIndex = 0
    else
        SetRight()
    end
end

function SetStatus()
    local use_types = weaponChildCfg.use_types or {}
    statusItems1 = statusItems1 or {}
    ItemUtil.AddItems("Role/RoleWeaponBaseStatusItem", statusItems1, use_types, statusGrids)
end

function SetRight()
    for k = 1, 3 do
        CSAPI.SetGOActive(this["R" .. k], k == rIndex)
    end
    local func = this["SetR" .. rIndex]
    if (func) then
        func()
    end
end

function SetR1()
    local type = nextWeaponChildCfg.show_types or 2 -- 1技能 2属性
    CSAPI.SetGOActive(childParent1, type == 1)
    CSAPI.SetGOActive(childParent2, type == 2)
    if (type == 1) then
        SetR1_Skill()
    else
        SetR1_Status()
    end
    CSAPI.SetGOActive(objMax, isMax)
    CSAPI.SetGOActive(materialGrids, not isMax)
    CSAPI.SetGOActive(btns, not isMax)
    isEnough = false
    if (not isMax) then
        local goodsDatas = {}
        local mats = weaponChildCfg.costs or {}
        for i, v in ipairs(mats) do
            local goodsData = BagMgr:GetFakeData(v[1])
            table.insert(goodsDatas, {goodsData, v[2]})
        end
        -- item
        costItems = costItems or {}
        ItemUtil.AddItems("Grid/RoleGridItem", costItems, goodsDatas, materialGrids, GridClickFunc.OpenInfo)
        -- 
        isEnough = CheckEnough()
        CSAPI.SetGOAlpha(btnS, isEnough and 1 or 0.3)
        --
        local money = weaponChildCfg.cost_coin or 0
        CSAPI.SetText(txtCost, PlayerClient:GetGold() >= money and money .. "" or StringUtil:SetByColor(money, "ff8790"))
    end
end

-- 是否足够
function CheckEnough()
    if (weaponChildCfg.costs) then
        for i, v in ipairs(weaponChildCfg.costs) do
            local goodsData = BagMgr:GetData(v[1])
            local curNum = goodsData and goodsData:GetCount() or 0
            local needNum = v[2]
            if (curNum < needNum) then
                return false
            end
        end
    end
    if (weaponChildCfg.cost_coin and weaponChildCfg.cost_coin > PlayerClient:GetGold()) then
        return false
    end
    return true
end

function SetR1_Skill()
    local oldSkillData = cardData:GetSkillByGroup(weaponChildCfg.skill_group)
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
    -- str 
    local str = "Lv." .. nextWeaponChildCfg.level .. "-" .. LanguageMgr:GetByID(340012)
    CSAPI.SetText(txtQH, str)
    -- name 
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(oldSkillData.id)
    CSAPI.SetText(txtSkillName, cfgDesc.name)
    -- oldDesc
    CSAPI.SetText(txtSkillDesc, cfgDesc.desc)
    -- th 
    thItems = thItems or {}
    ItemUtil.AddItems("Role/RoleWeaponTHItem", thItems, nextWeaponChildCfg.skills, content1)
end

function ClickSkillItemCB()
    local oldSkillData = cardData:GetSkillByGroup(weaponChildCfg.skill_group)
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

function SetR1_Status()
    -- str 
    local str = "Lv." .. nextWeaponChildCfg.level .. "-" .. LanguageMgr:GetByID(340011)
    CSAPI.SetText(txtQH, str)
    -- 
    local curStatus = weaponChildCfg.use_types or {}
    local nextStaus = isMax and {} or nextWeaponChildCfg.use_types
    local curStatusDic = GetStatusDic(curStatus)
    local nextStatusDic = GetStatusDic(nextStaus)
    local statusDic = {}
    for k, v in pairs(nextStatusDic) do
        local _isNew = not curStatusDic[k]
        local _rValue = nil
        if (not _isNew and curStatusDic[k] and curStatusDic[k] ~= v) then
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
    statusItems2 = statusItems2 or {}
    ItemUtil.AddItems("Role/RoleWeaponStatusItem", statusItems2, statusArr, childParent2)
end

function SetR2()
    local y1, y2, y3 = 0, 0, 0
    -- 
    detailItems = detailItems or {}
    local _datas = {}
    for k, v in ipairs(weaponCfg.infos) do
        if (v.level > 0) then
            table.insert(_datas, v)
            -- 
            if (v.level == weaponLv) then
                y1 = y3
            end
            if (v.level == (weaponLv + 1)) then
                y2 = y3
            end
            if (v.show_types == 2) then
                y3 = y3 + 194
            else
                y3 = y3 + 257
            end
        end
    end
    ItemUtil.AddItems("Role/RoleWeaponDetailItem", detailItems, _datas, content2, nil, 1, {cardData, weaponLv}, SetFirst)
    -- 
    isShow = false
    CSAPI.SetGOActive(btnR2, false)
    if (weaponLv <= 0) then
        return
    end
    local size = CSAPI.GetRealRTSize(sv2)
    svHeight = size[1]
    contentHeight = y3
    -- 
    heights = {y1, y2, y1}
    -- 下不足时 
    if ((y1 + svHeight) > contentHeight) then
        heights[3] = (contentHeight - svHeight)
    end
    -- 
    isShow = contentHeight > svHeight
end

function SetFirst()
    sv2_sv.enabled = false
    sv2_sv.enabled = true
    local x, y = CSAPI.GetAnchor(content2)
    CSAPI.SetAnchor(content2, x, 0, 0)
    --
    for k, v in ipairs(detailItems) do
        UIUtil:SetObjFade(v.gameObject, 0, 1, nil, 300, (k - 1) * 100 + 1, 0)
    end
end

function SetR3()
    CSAPI.SetText(txt3, weaponCfg.weaponstory)
end

-- 升级
function OnClickS()
    if (isEnough) then
        PlayerProto:UpgradeWeaponLv(cardData:GetID())
    end
end

-- 回到当前等级
function OnClickR2()
    sv2_sv.enabled = false
    sv2_sv.enabled = true
    local x, y = CSAPI.GetAnchor(content2)
    CSAPI.SetAnchor(content2, x, heights[3], 0)
end

function OnClickShow()
    CSAPI.OpenView("RoleWeaponShow", weaponChildCfg)
end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    view:Close()
end
