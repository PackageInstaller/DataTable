local timer = nil
local is12 = true
local timer2 = nil
local fill_power = nil
local ids = {}
local waitInfos = nil
local isDestory = false 

function Awake()
    fill_power = ComUtil.GetCom(fill, "Image")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Player_Select_Card, SetBG)
end

function OnDestroy()
    isDestory = true
    eventMgr:ClearListener()
end

function Update()
    if (timer and Time.time >= timer) then
        timer = Time.time + 1
        SetTime()
    end
    if (timer2 and Time.time >= timer2) then
        timer2 = Time.time + 60
        SetPower()
    end
    if (waitInfos and TimeUtil:GetTime() >= waitInfos[1][2]) then
        if (waitInfos[1][1] == 7) then
            local buildingData = MatrixMgr:GetBuildingDataByType(BuildsType.ProductionCenter)
            if (buildingData~=nil and buildingData:IsGiftMax()) then
                table.insert(ids, waitInfos[1][1])
            end
        else
            table.insert(ids, waitInfos[1][1])
        end
        if (#ids > 5) then
            table.remove(ids, 1)
        end
        SetInfos()
        table.remove(waitInfos, 1)
        if (#waitInfos < 1) then
            waitInfos = nil
            InitInfos()
        end
    end
end

function OnOpen()
    -- --
    -- local go0 = CSAPI.GetView("MenuMore")
    -- if (go0) then
    --     local menuMore = ComUtil.GetLuaTable(go0)
    --     menuMore.OnClickMask()
    -- end
    --
    local go = CSAPI.GetView("Menu")
    menu = ComUtil.GetLuaTable(go)
    -- 
    CSAPI.SetScale(menu.gameObject, 0, 0, 0)
    -- role
    movePointX = CSAPI.GetAnchor(menu.movePoint)
    CSAPI.SetAnchor(menu.movePoint, 0, 0, 0)
    CSAPI.SetParent(menu.movePoint, center)
    --
    SetBG()
    InitTime()
    SetDay()
    InitPower()
    InitInfos()
    SetChange()
end

function SetBG()
    local curDisplayData = CRoleDisplayMgr:GetCurData()
    local cfg = curDisplayData and Cfgs.CfgMenuBg:GetByID(curDisplayData:GetBG()) or nil
    if (cfg and cfg.name) then
        ResUtil:LoadMenuBg(bg, "UIs/" .. cfg.name, false)
    end
end

function InitTime()
    local b = SettingMgr:GetValue(s_wait_scale.time) == 0
    CSAPI.SetGOActive(times, b)
    if (b) then
        is12 = SettingMgr:GetValue(s_wait_scale.timeFormat) == 0
        timer = Time.time
    end
end

function SetTime()
    local time = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    local hour, min = time.hour, time.min
    local ap = nil
    if (is12) then
        ap = hour > 12 and 1096 or 1095
        hour = hour > 12 and (hour - 12) or hour
    end
    hour = hour < 10 and ("0" .. hour) or hour
    min = min < 10 and ("0" .. min) or min
    CSAPI.SetText(txtTime1, hour .. ":" .. min)
    CSAPI.SetGOActive(txtTime2, ap ~= nil)
    if (ap ~= nil) then
        LanguageMgr:SetText(txtTime2, ap)
    end
end

function SetDay()
    local b = SettingMgr:GetValue(s_wait_scale.date) == 0
    CSAPI.SetGOActive(txtDay1, b)
    if (b) then
        local w = TimeUtil:GetWeekDay2(TimeUtil:GetTime())
        local s1 = LanguageMgr:GetByType(1016 + w, 4)
        local time = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
        local month = time.month < 10 and ("0" .. time.month) or time.month
        local day = time.day < 10 and ("0" .. time.day) or time.day
        CSAPI.SetText(txtDay1, s1 .. "/" .. time.year .. "/" .. month .. "/" .. day)
    end
end

function InitPower()
    local b = SettingMgr:GetValue(s_wait_scale.electric) == 0
    CSAPI.SetGOActive(txtPower, b)
    if (b) then
        timer2 = Time.time
    end
end
function SetPower()
    local cur = CSAPI.GetElectricQuantity()
    cur = cur and math.ceil(math.abs(cur) * 100) or 100
    CSAPI.SetText(txtPower, cur .. "%")
    fill_power.fillAmount = cur / 100
end

--[[
1		新的时装已在商店上架
2		新的插画已在商店上架
3		燃料已回复至等级上限
4		燃料已回复至最大值
5		订单已刷新
6		芯片改造已完成
7		挖掘矿场已到达最大值
8		非副本类的活动开启时
9		副本类的活动开启时
]]
function InitInfos()
    waitInfos = nil
    local b = SettingMgr:GetValue(s_wait_scale.tips) == 0
    if (not b) then
        return
    end
    local dic = {}
    local cTime = TimeUtil:GetTime()
    -- 1/2 
    local cfgs = Cfgs.CfgCommodity:GetAll()
    for k, v in pairs(cfgs) do
        if (v.sBuyStart and v.sBuyStart~="") then
            local sTime = TimeUtil:GetTimeStampBySplit(v.sBuyStart)
            if (sTime > cTime) then
                -- 1 
                if (v.nType and v.nType == 3 and (not dic[1] or dic[1][2] > sTime)) then
                    dic[1] = {1, sTime}
                end
                -- 2
                if (v.tabID and v.tabID == 1006 and (not dic[2] or dic[2][2] > sTime)) then
                    dic[2] = {2, sTime}
                end
            end
        end
    end
    -- 3/4
    local isMax1, isMax2 = PlayerClient:IsMaxHot()
    if (not isMax1) then
        dic[3] = {3, PlayerClient:MaxTHot()}
    elseif (not isMax2) then
        dic[4] = {4, PlayerClient:MaxTHot()}
    end
    -- 5 
    InitBuildingInfo(dic, 5, BuildsType.TradingCenter)
    -- 6
    InitBuildingInfo(dic, 6, BuildsType.Remould)
    -- 7
    InitBuildingInfo(dic, 7, BuildsType.ProductionCenter)
    -- 8 
    InitCfgInfo(dic, 8, "CfgActiveList", "sTime")
    -- 9 
    InitCfgInfo(dic, 9, "CfgActiveEntry", "begTime")
    --
    local _waitInfos = {}
    for k, v in pairs(dic) do
        table.insert(_waitInfos, v)
    end
    if (#_waitInfos > 1) then
        table.sort(_waitInfos, function(a, b)
            return a[2] < b[2]
        end)
    end
    if (#_waitInfos > 0) then
        waitInfos = _waitInfos
    end
end

function InitBuildingInfo(dic, index, buildingType)
    local buildingData = MatrixMgr:GetBuildingDataByType(buildingType)
    if (buildingData~=nil and buildingData:StandbyTime() and buildingData:StandbyTime() > TimeUtil:GetTime()) then
        dic[index] = {index, buildingData:StandbyTime()}
    end
end

function InitCfgInfo(dic, index, cfgName, timeName)
    local cfg = Cfgs[cfgName]:GetAll()
    local cTime = TimeUtil:GetTime()
    for k, v in pairs(cfg) do
        if (v[timeName] and v[timeName]~="") then
            local sTime = TimeUtil:GetTimeStampBySplit(v[timeName])
            if (sTime > cTime) then
                if (not dic[index] or dic[index][2] > sTime) then
                    dic[index] = {index, sTime}
                end
            end
        end
    end
end

function SetInfos()
    if (#ids > 5) then
        table.remove(ids, 1)
    end
    items = items or {}
    ItemUtil.AddItems("MenuStandby/MenuStandbyItem", items, ids, hGroup)
end

function SetChange()
    local b = SettingMgr:GetValue(s_wait_scale.rotate) == 0
    CSAPI.SetGOActive(btnChange, b)
end

function OnClickBlack()
    CSAPI.SetScale(menu.gameObject, 1, 1, 1)
    CSAPI.SetGOAlpha(gameObject, 0)
    CSAPI.SetGOActive(mask, true)
    CSAPI.SetAnchor(menu.movePoint, movePointX or 0,0,0)
    CSAPI.SetParent(menu.movePoint, menu.center)
    menu.movePoint.transform:SetAsFirstSibling()

    -- 查看状态
    if (menu.GetIsHideUI()) then
        view:Close()
        return
    end

    -- 入场
    local viewDic = menu.GetOpenViews()
    local len = 0
    for k, v in pairs(viewDic) do
        len = len + 1
    end
    if (len == 1) then
        menu.HideAnimRD()
        CSAPI.SetGOActive(menu.uis, false)
        CSAPI.SetGOActive(menu.uis, true)
    end

    FuncUtil:Call(function()
        if(not isDestory)then 
            view:Close()
        end 
    end, nil, 2000)
end

function OnClickChange()
    CRoleDisplayMgr:Change2()
end

