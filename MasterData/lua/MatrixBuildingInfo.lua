local runTime = false
local timer = 0
local needTime = 0
local baseTime = 0

-- function Awake()
--     outlineBar = ComUtil.GetCom(hp, "OutlineBar")
-- end

function OnInit()
    -- 	UIUtil:AddTop2("MatrixBuildingInfo", gameObject, function() view:Close() end, nil, {})
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Matrix_Building_Update, function()
        OnOpen()
    end)
end
function OnDestroy()
    eventMgr:ClearListener()
end

-- function Update()
--     if (runTime) then
--         timer = timer - Time.deltaTime
--         if (timer < 0) then
--             timer = 0.2
--             SetTime()
--         end
--     end
-- end

function OnOpen()
    buildData = data
    -- lv
    -- CSAPI.SetText(txtLv2, "" .. buildData:GetLv())
    -- desc
    CSAPI.SetText(txtDesc, buildData:SetBaseCfg().explanation)
    -- name
    CSAPI.SetText(txtName, buildData:GetBuildingName() or "")
    -- hp
    cfg = buildData:GetCfg()
    -- if (cfg.maxHp) then
    --     CSAPI.SetGOActive(hp, true)
    --     local cur, max = buildData:GetHP()
    --     outlineBar:SetProgress(max == 0 and 1 or cur / max)
    -- else
    --     CSAPI.SetGOActive(hp, false)
    -- end

    -- 建筑属性
    SetGrid()

    -- SetUpgrade()
    -- SetTime()

    --
    --CSAPI.SetGOActive(btnUp, (not runTime and curLv < maxLv) and true or false)
end

-- function SetUpgrade()
--     runTime = false
--     baseTime = 0
--     needTime = 0

--     curLv, maxLv = buildData:GetLv()
--     -- local id = 10036 --已满级
--     -- local alpha = 0.3
--     if (curLv < maxLv) then
--         local _buildingState, _baseTime = buildData:GetState()
--         if (_buildingState == MatrixBuildingType.Upgrage) then
--             baseTime = _baseTime
--         end
--     end
-- end

-- function SetTime()
--     if (baseTime > 0) then
--         needTime = baseTime - TimeUtil:GetTime()
--         -- needTime = needTime > 0 and needTime or 0
--     else
--         needTime = -1
--     end
--     runTime = needTime >= -0.1
--     CSAPI.SetGOActive(timeObj, runTime)
--     CSAPI.SetText(txtUpTime, TimeUtil:GetTimeStr7(needTime))
--     if (runTime == false) then
--         -- SetUpgrade()
--         -- CSAPI.SetGOActive(btnUp, (curLv < maxLv) and true or false)
--     end
-- end

-- 对应 CfgMatrixAttribute表
function SetGrid()
    local atts = {}
    if (buildData:GetType() == BuildsType.ControlTower) then
        atts = {2, 3, 4, 5}
    elseif (buildData:GetType() == BuildsType.PowerHouse) then
        atts = {2, 3, 5}
    elseif (buildData:GetType() == BuildsType.ProductionCenter) then
        atts = {6, 3, 5, 8}
    elseif (buildData:GetType() == BuildsType.TradingCenter) then
        atts = {6, 3, 5, 9}
    elseif (buildData:GetType() == BuildsType.Expedition) then
        atts = {6, 3, 5}
    elseif (buildData:GetType() == BuildsType.Compound) then
        atts = {6, 3, 5} --, 11, 12}
    elseif (buildData:GetType() == BuildsType.Remould) then
        atts = {6, 3, 5, 13}
    end

    local datas = {}
    for i, v in ipairs(atts) do
        local _cfg = Cfgs.CfgMatrixInfo:GetByID(v)
        local func = this["AttributeFunc" .. v]
        local str = func()
        table.insert(datas, {_cfg.sName, str})
    end

    items = items or {}
    ItemUtil.AddItems("Matrix/MatrixBuildingInfoItem", items, datas, grid)
end

-- 建筑耐久
function AttributeFunc1()
    cfg = buildData:GetCfg()
    if (cfg.maxHp) then
        local cur, max = buildData:GetHP()
        return cur .. "/" .. max
    end
    return "-/-"
end

-- 提供电力
function AttributeFunc2()
    return buildData:GetPower()
end
-- 驻员上限
function AttributeFunc3()
    local cur, max = buildData:GetRoleCnt()
    return string.format("%s/%s", cur, max)
    -- return buildData:GetMaxRoleLimit()
end
-- 等级上限
function AttributeFunc4()
    local cur, max = buildData:GetLv()
    return max
end
-- 心情消耗 
function AttributeFunc5()
    local plDel = MatrixMgr:GetPLDerate()
    if (cfg.tiredVal) then
        local num = math.floor(cfg.tiredVal[1] / 60)
        local minStr = LanguageMgr:GetByID(11011) or "min"
        return (math.abs(cfg.tiredVal[2]) - plDel) .. "/" .. num .. minStr
    else
        return "0"
    end
end
-- 电力消耗
function AttributeFunc6()
    return buildData:GetPower()
end
-- 产出效率
function AttributeFunc7()
    return buildData:GetCfg().desc1 or ""
end
-- 资源上限
function AttributeFunc8()
    return buildData:GetCfg().desc2 or ""
end
-- 订单上限
function AttributeFunc9()
    return buildData:GetTradingCount()
end

-- -- 订单产出
-- function AttributeFunc10()
-- 	local baseValue = buildData:GetCfg().orderTimeDiff or 0
-- 	local del = 0
-- 	if(buildData:GetData().roleAbilitys and buildData:GetData().roleAbilitys[RoleAbilityType.Traders]) then
-- 		local per = buildData:GetData().roleAbilitys[RoleAbilityType.Traders].vals[1]
-- 		del = baseValue *(per / 100)
-- 	end
-- 	local value = math.floor((baseValue - del) / 60)
-- 	return "1/" .. value .. "min"
-- end

-- 制作能力
function AttributeFunc11()
    return buildData:GetCreateAbilityCount()
end
-- 制作上限
function AttributeFunc12()
    return buildData:GetCfg().failMaxCnt or ""
end

-- 改造上限
function AttributeFunc13()
    return buildData:GetCfg().taskNumLimit or "0"
end
-- 派遣队伍
function AttributeFunc14()
    return buildData:GetCfg().teamCntLimit or "0"
end

-- -- 升级
-- function OnClickUp()
--     local num, str = IsCreateOrUpgrade()
--     if (num == 2) then
--         -- LanguageMgr:ShowTips(str)  --建造中
--         return false
--     end
--     if (num == 1) then
--         LanguageMgr:ShowTips(str) -- 升级中
--         return false
--     end

--     if (curLv >= maxLv) then
--         return
--     end
--     CSAPI.OpenView("MatrixUp", buildData)
-- end
-- 是否升级或者建造中
function IsCreateOrUpgrade()
    local num, str = 0, ""
    if (buildData) then
        local buildingState, time = buildData:GetState()
        if (buildingState == MatrixBuildingType.Upgrage) then
            num = 1
            str = 2004
        elseif (buildingState == MatrixBuildingType.Create) then
            num = 2
            str = 10037
        end
    end
    return num, str
end

function OnClickMask()
    view:Close()
end
