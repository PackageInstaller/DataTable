-- 战场界面
local mapView
local items = nil
local pos = {{29, -40}, {26, -211}, {-308, -31}, {27, 188}, {387, -23}}
local cfg = nil
local lastCur = 0
local resetTime = 0
local rewardInfo = nil
local currItem = nil
local txts = {"A", "B", "C", "D"}
local cardItem = nil
local slider = nil
local cfgEntry = nil
local isEnd = false
local sectionData = nil

function Awake()
    slider = ComUtil.GetCom(rewardSlider, "Slider")
end

function OnInit()
    top = UIUtil:AddTop2("BattleField", topObj, OnClickReturn,nil,{10042,nil,ITEM_ID.Hot});

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClose)
    eventMgr:AddListener(EventType.BattleField_Show_List, OnButtonShow)
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, OnRewardUpdate)
    eventMgr:AddListener(EventType.BattleField_BossData_Refresh, OnBossViewOpen)
end

function OnViewClose(viewKey)
    if viewKey == "BattleFieldBoss" or viewKey == "TeamConfirm" then
        CSAPI.SetGOActive(mapView.ModelCamera, true)
        CSAPI.SetGOActive(mapView.effectNode, true)
    end
end

function OnRewardUpdate()
    rewardInfo = BattleFieldMgr:GetRewardInfo(true)
    RefreshReward(rewardInfo)
end

function OnBossViewOpen()
    if not CSAPI.IsViewOpen("BattleFieldBoss") then
        CSAPI.SetGOActive(mapView.ModelCamera, false)
        CSAPI.SetGOActive(mapView.effectNode, false)
        CSAPI.OpenView("BattleFieldBoss")
        if mapView then
            mapView.ResetPos()
        end
    end
end

function Update()
    local curTime = TimeUtil.GetTime()
    if cfgEntry and cfgEntry.endTime then
        local finshTime = GCalHelp:GetTimeStampBySplit(cfgEntry.endTime)
        isEnd = curTime >= finshTime
        SetTime(finshTime)
        EventMgr.Dispatch(EventType.Activity_Open_State)
    end
    if rewardInfo then
        if curTime > rewardInfo.resetTime then
            local dayDiffs = g_ActivityDiffDayTime * 3600
            rewardInfo.resetTime = TimeUtil:GetResetTime(dayDiffs)
            rewardInfo.cur = 0
            SaveRewardInfo(rewardInfo)
            RefreshReward(rewardInfo)
        end
    end
end

function OnOpen()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        ResUtil:CreateUIGOAsync("SectionMap/SectionMapView", mapParent, function(go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Init(sectionData, 1.2, 2.2)
            lua.InitEffect(battleFieldEffect.gameObject, 1)
            lua.SetClickBtnCB(OnBtnClick)
            lua.InitPivot(0.5,0)
            CSAPI.SetRTSize(lua.itemNode, 565, 661)
            mapView = lua
            SetCenterBtn()
            PlayerProto:GetBattleFieldData()
        end)
    end
end

function OnBtnClick()
    PlayerProto:GetBattleBossData()
end

function SetCenterBtn()
    CSAPI.SetParent(btnCenter, mapView.listNode)
    local centerPos = pos[1]
    CSAPI.SetAnchor(btnCenter, centerPos[1], centerPos[2])
    CSAPI.SetScale(btnCenter, 1 / mapView.curScale, 1 / mapView.curScale)
end

function OnButtonShow(_datas)
    if _datas then
        local datas = {}
        for k, v in pairs(_datas) do
            table.insert(datas, v)
        end
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
        if #datas > 0 then
            items = items or {}
            if #items > 0 then
                for i, v in ipairs(items) do
                    CSAPI.SetGOActive(v.gameObject, false)
                end
            end
            local idx = 1
            for _, data in pairs(datas) do
                if items[idx] then
                    local item = items[idx]
                    CSAPI.SetGOActive(item.gameObject, true)
                    item.Refresh(data)
                else
                    ResUtil:CreateUIGOAsync("BattleField/BattleFieldItem", mapView.listNode, function(go)
                        local lua = ComUtil.GetLuaTable(go)
                        lua.SetIndex(idx)
                        lua.SetClickCB(OnClickItem)
                        lua.Refresh(data)
                        CSAPI.SetScale(go, 1 / mapView.curScale, 1 / mapView.curScale)
                        table.insert(items, lua)
                    end)
                end
                idx = idx + 1
            end
        end
    end

    RefreshPanel()
end

function OnClickItem(item)
    if not mapView.isMove then
        currItem = item
        if mapView.currIdx < 2 then
            ClickEnter()
        end
    end
end

function RefreshPanel()
    local info = BattleFieldMgr:GetBattleFieldInfo()
    cfgEntry = Cfgs.CfgActiveEntry:GetByID(info.id)
    if info then
        cfg = Cfgs.CfgBattleField:GetByID(info.configID)
        if cfg then
            rewardInfo = BattleFieldMgr:GetRewardInfo()
            RefreshReward(rewardInfo)
        end
    end
end

function RefreshReward(_info)
    local cur = StringUtil:SetByColor(_info.cur, "FFC146")
    local max = _info.max
    CSAPI.SetText(txtReward, cur .. "/" .. max)
    local precent = _info.cur / _info.max
    slider.value = precent
end

function SetTime(target)
    if TimeUtil:GetTime() >= target then
        LanguageMgr:SetText(txtTime, 39002)
    else
        local timeTab = TimeUtil:GetDiffHMS(target, TimeUtil:GetTime())
        local day = timeTab.day > 0 and timeTab.day or 0
        local hour = timeTab.hour > 0 and timeTab.hour or 0
        local minute = timeTab.minute > 0 and timeTab.minute or 0
        LanguageMgr:SetText(txtTime, 1042, day, hour, minute)
    end
end

function OnClickEnter()
    if isEnd then
        LanguageMgr:ShowTips(24001)
        return
    end
    if currItem then
        local curState = currItem:GetState()
        if (curState == 1 or curState == 5) and (not BattleFieldMgr:IsAllPass()) then
            return
        end
        local itemData = currItem:GetData()
        if itemData then
            if itemData:GetCfg().arrForceTeam ~= nil then -- 强制上阵编队
                CSAPI.OpenView("TeamForceConfirm", {
                    dungeonId = itemData:GetID(),
                    teamNum = itemData:GetTeamNum(),
                    isNotAssist = true
                })
            else
                CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                    dungeonId = itemData:GetID(),
                    teamNum = itemData:GetTeamNum(),
                    isNotAssist = true
                }, TeamConfirmOpenType.Dungeon)
            end
            CSAPI.SetGOActive(mapView.ModelCamera, false);
            CSAPI.SetGOActive(mapView.effectNode, false)
        end
    end
end

function OnClickReturn()
    if not mapView.isMove then
        if mapView.currIdx > 1 then
            ClickBack()
        else
            view:Close()
        end
    end
end

---------------------------------------------场景移动----------------------------------------------
-- 前进
function ClickEnter()
    if mapView and currItem then
        local startFunc = function()
            ShowItem(nil, false)
        end
        local finshFunc = function()
            ShowItem(currItem)
            ShowInfo(currItem)
            CSAPI.SetScale(currItem.gameObject, 1 / mapView.curScale, 1 / mapView.curScale)
        end
        mapView.Enter(currItem, startFunc, finshFunc)
    end
end

-- 后退
function ClickBack()
    if mapView and currItem then
        local startFunc = function()
            ShowInfo()
            ShowItem()
        end
        local finshFunc = function()
            ShowItem(nil, true)
            CSAPI.SetScale(currItem.gameObject, 1 / mapView.curScale, 1 / mapView.curScale)
            currItem = nil
        end
        mapView.Back(currItem, startFunc, finshFunc)
    end
end

-- 展示物体
function ShowItem(item, isShow)
    CSAPI.SetGOActive(btnCenter, not item)
    if items then
        for i, v in ipairs(items) do
            if item then
                CSAPI.SetGOActive(v.gameObject, item == v)
            else
                CSAPI.SetGOActive(v.gameObject, isShow)
            end
        end
    end
end

-- 展示左侧
function ShowInfo(item)
    CSAPI.SetGOActive(leftInfo.gameObject, item ~= nil)
    CSAPI.SetGOActive(mapView.itemNode, item ~= nil)
    if item then
        local IsAllPass = BattleFieldMgr:IsAllPass() --清剿行动
        -- icon
        local itemData = item:GetData()
        local cfgCard = Cfgs.MonsterData:GetByID(itemData:GetEnemyID())
        ShowCard(cfgCard, itemData)

        CSAPI.SetText(txt_title, LanguageMgr:GetByID(37004) .. txts[item.index])
        local curState = item:GetState()
        local str, txtColor = BattleFieldUtil.GetTextColor(curState)
        if IsAllPass then
            str = LanguageMgr:GetByID(37025)
            txtColor = {0,255,191,255}
        end
        CSAPI.SetText(txtState, str)
        CSAPI.SetTextColor(txtState, txtColor[1], txtColor[2], txtColor[3], txtColor[4])
        CSAPI.SetImgColor(txtImg,txtColor[1], txtColor[2], txtColor[3], txtColor[4])
        CSAPI.SetText(txtDjlx, item:GetType())
        CSAPI.SetText(txtDjsl, IsAllPass and LanguageMgr:GetByID(37026) or itemData:GetCurrEnemy() .. "")

        local isNoEnter = ((curState == 1 or curState == 5) and not IsAllPass) and true or false
        CSAPI.SetImgColor(btnEnter, 255, 255, 255, isNoEnter and 76 or 255)
    end
end

function ShowCard(cfg, itemData)
    if cfg then
        if not cardItem then
            ResUtil:CreateUIGOAsync("RoleCard/RoleFiledCard", iconNode, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.Refresh(cfg)
                lua.SetLv(itemData:GetLv())
                cardItem = lua
            end)
        else
            cardItem.Refresh(cfg)
            cardItem.SetLv(itemData:GetLv())
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end


function OnClickExplain()
    CSAPI.OpenView("BattleFieldExplain", 1)
end

function OnClickReward()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.DupFight,
        title = LanguageMgr:GetByID(6020)
    })
end

function OnClickBuff()
    CSAPI.OpenView("BattleFieldExplain", 2)
end

function OnClickRank()
    -- CSAPI.OpenView("BattleFieldRank")
end

function OnClickShop()
    CSAPI.OpenView("ShopView", 903)
end