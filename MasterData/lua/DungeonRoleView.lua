local sectionData = nil
local canvasHeight = 0
local openInfo = nil
local jumpID = 0
local isTurnLoad, isItemLoad, isLoadComplite = false, false, false
-- 背景
local bgItem = nil
local isCreateBG = false
-- 轮盘
local turnNum = 0
local turnItem = nil
local isCreateTurnItem = false -- 防止创建多个
local currAngle = 0
local lastAngle = 0
local targetAngle = 0
local angleSpeed = 6
local currTurnNum = 1
local lastTurnNum = 1
local turnOpenList = {}
-- item
local datas = {}
local currDatas = {}
local itemHeight = 606
local items = {}
local currItem = nil
local isHardOpen = false
local hardTips = ""
local isHardTimeOpen = false
local hardTimeTips = ""
local currLevel = 1
-- drop
local isTurnRotate = false
-- 动效
local isAnim = false
local isOpenNextTurn = false
local isOpenNewDungeon = false

function Awake()
    -- CSAPI.SetGOActive(infoMask,false)
    InitAnim()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnLoadComplete()
    isLoadComplite = true
    if isOpenNextTurn then
        InitDungeonOverAnim()
    else
        StartAnim()
    end
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" or viewKey == "ShopView" then
        FuncUtil:Call(function()
            if gameObject then
                CSAPI.PlayBGM(sectionData:GetBGM(), 1)
            end
        end, this, 300)
    end
end

function OnDestroy()
    SaveInfo()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("DungeonRole", topParent, OnClickBack)
end

function Update()
    UpdateHardState()

    if isAnim then
        return
    end

    TurnRotate()

    if isTurnRotate then
        RotateToTarget()
    end
end

function OnOpen()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        if not sectionData then
            LogError("缺少章节数据！id" .. data.id)
            return
        end

        turnNum = sectionData:GetTurnNum() or 0
        if turnNum == 0 then
            LogError("章节表未填轮盘数!!")
            return
        end

        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if not openInfo then
            LogError("缺少活动时间数据！id" .. sectionData:GetID())
            return
        end
        isHardTimeOpen, hardTimeTips = openInfo:IsHardOpen()
        isHardTimeOpen = true

        InitDatas()
        InitState()
        if sectionData:GetStoryID() and (not PlotMgr:IsPlayed(sectionData:GetStoryID())) then -- 第一次观看入场剧情
            PlotMgr:TryPlay(sectionData:GetStoryID(), function()
                PlotMgr:Save()
                InitPanel()
            end, this, true);
        else
            InitPanel()
        end
    end
end

function InitPanel()
    InitLeftPanel()
    InitRightPanel()
end

function InitLeftPanel()
    InitTurn()
    SetLevel(currLevel, isHardOpen and isHardTimeOpen)
end

function InitRightPanel()
    if openInfo:GetOpenCfg().hardBegTime then
        CSAPI.SetText(txtHardTime, LanguageMgr:GetTips(24007, openInfo:GetOpenCfg().hardBegTime))
    else
        CSAPI.SetGOActive(hardObj, false)
    end
    SetBG()
    SetItems(true) -- 初次加载
end

function InitState()
    if data.itemId then -- 跳转进入
        SetInfoByJump()
    else -- 正常进入
        SetInfo()
    end
    if openSetting and openSetting.isDungeonOver then
        local groupData = currDatas[currTurnNum]
        local ids = groupData:GetDungeonGroups()
        if DungeonMgr:GetCurrDungeonIsFirst() then
            DungeonMgr:SetCurrDungeonNoFirst()
            if ids[#ids] == data.itemId then
                if currTurnNum < turnNum then
                    isOpenNextTurn = true -- 解锁动效
                    jumpID = 0
                elseif currTurnNum == turnNum then
                    if currLevel == 1 and isHardOpen and isHardTimeOpen then
                        currLevel = 2
                        currTurnNum = 1
                        currDatas = datas[currLevel]
                        jumpID = 0
                    end
                end
            else
                isOpenNewDungeon = true
            end
        end
    end
end

function SetInfo()
    for i, v in pairs(datas) do
        for k, m in ipairs(v) do
            if m:IsOpen() and not m:IsPass() then
                local ids = m:GetDungeonGroups()
                for _, id in ipairs(ids) do
                    local dungeonData = DungeonMgr:GetDungeonData(id)
                    if not dungeonData or (dungeonData:IsOpen() and not dungeonData:IsPass()) then
                        currTurnNum = k
                        currLevel = i
                        currDatas = datas[i]
                        -- jumpID = id
                        return
                    end
                end
            end
        end
    end

    -- 获取上次退出前状态
    local info = LoadInfo()
    currTurnNum = info.turn or currTurnNum
    currLevel = info.level or currLevel
    currDatas = datas[currLevel]
end

function SetInfoByJump()
    if data.itemId > 0 then
        for i, v in pairs(datas) do
            for k, m in ipairs(v) do
                local ids = m:GetDungeonGroups()
                for _, id in ipairs(ids) do
                    if data.itemId == id then
                        jumpID = id
                        currTurnNum = k
                        currLevel = i
                        currDatas = datas[i]
                        break
                    end
                end
            end
        end
    end
end

function RefreshPanel()
    SetTurnOpenList()
    SetItems()
end
-----------------------------------------------背景-----------------------------------------------
function SetBG()
    if bgItem then
        bgItem.Refresh(sectionData, currTurnNum)
    elseif not isCreateBG then
        isCreateBG = true
        ResUtil:CreateUIGOAsync("DungeonRole/DungeonRoleImg", bgParent, function(go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(sectionData, currTurnNum)
            bgItem = lua
        end)
    end
end
-----------------------------------------------物品-----------------------------------------------

function InitDatas()
    local _datas = DungeonMgr:GetDungeonGroupDatas(data.id)
    if _datas and #_datas > 0 then
        for i, v in ipairs(_datas) do
            local cfg = v:GetCfg()
            if cfg and cfg.type then
                datas[cfg.type] = datas[cfg.type] or {}
                table.insert(datas[cfg.type], v)
            end
        end
    end

    for k, m in pairs(datas) do
        table.sort(m, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end

    if datas[2] and #datas[2] > 0 then
        local _data = datas[2][1]
        isHardOpen, hardTips = _data:IsOpen()
    end

    currDatas = datas[1] or {}
end

function SetItems(b)
    items = items or {}
    if currDatas[currTurnNum] == nil then
        LogError("缺少当前区域数据！！！" .. currTurnNum)
        return
    end

    if #items > 0 then
        for i, v in ipairs(items) do
            CSAPI.SetGOActive(v.node,false)
        end
    end

    local pos = {{x = -301.5,y = 120}, {x = -301.5,y = -111},{x = -301.5,y = 4.5}}
    local _datas = currDatas[currTurnNum]:GetDungeonGroups()
    local groupCfg = currDatas[currTurnNum]:GetCfg()
    if _datas then
        for i, v in ipairs(_datas) do
            local cfg = Cfgs.MainLine:GetByID(v)
            if cfg then
                if items[i] then
                    CSAPI.SetGOActive(items[i].node ,true)
                    if #_datas > 1 then
                        items[i].SetIndex(i == 1 and currTurnNum * 2 - 1 or currTurnNum * 2)
                    else
                        items[i].SetIndex(currTurnNum)
                    end
                    items[i].Refresh(cfg, currLevel)
                    items[i].SetIcon(groupCfg.Icon and groupCfg.Icon[i] or "")
                    if #_datas == 1 then
                        CSAPI.SetAnchor(items[i].gameObject, pos[3].x, pos[3].y)
                    else
                        CSAPI.SetAnchor(items[i].gameObject, pos[i].x, pos[i].y)
                    end
                    if isActive then
                        if not items[1].GetLock() then
                            itemInfo.ClearLastItem()
                            OnItemClick(items[1])
                        else
                            OnClickBack()
                        end
                    end
                else
                    ResUtil:CreateUIGOAsync("DungeonRole/DungeonRoleItem2", itemParent, function(go)
                        local lua = ComUtil.GetLuaTable(go)
                        if #_datas > 1 then
                            lua.SetIndex(i == 1 and currTurnNum * 2 - 1 or currTurnNum * 2)
                        else
                            lua.SetIndex(currTurnNum)
                        end                        lua.SetClickCB(OnItemClick)
                        lua.Refresh(cfg, currLevel)
                        lua.SetIcon(groupCfg.Icon and groupCfg.Icon[i] or "")
                        items[i] = lua
                        if #_datas == 1 then
                            CSAPI.SetAnchor(go, pos[3].x, pos[3].y)
                        else
                            CSAPI.SetAnchor(go, pos[i].x, pos[i].y)
                        end
                        if i == #_datas then
                            isItemLoad = true
                            StartAnim()
                        end
                    end)
                end
            end
        end
    end
end

function OnItemClick(item)
    if currItem then
        currItem.SetSelect(false)
    end

    currItem = item
    currItem.SetSelect(true)
    ShowInfo(item)
end

function OnClickLevel()
    currLevel = currLevel == 1 and 2 or 1
    if currLevel == 2 and (not isHardOpen or not isHardTimeOpen) then
        currLevel = 1
        local str = isHardTimeOpen and hardTips or hardTimeTips
        Tips.ShowTips(str)
        return
    end
    SetLevel(currLevel, isHardOpen and isHardTimeOpen)
    turnItem.SetHard(currLevel)

    currDatas = datas[currLevel]
    SetTurnOpenList()
    SetItems()
    ItemChangeAnim()
    turnItem.ScaleTo(function()
        SetTurn()
    end)
end

function SetLevel(lv, isHardOpen)
    local iconName = "normal_lock"
    if lv == 2 then
        iconName = "hard"
    elseif isHardOpen then
        iconName = "normal_unLock"
    end
    CSAPI.LoadImg(btnLevel, "UIs/DungeonRole/" .. iconName .. ".png", true, nil, true)
    CSAPI.SetGOActive(hardImg, lv == 2)
end

function UpdateHardState()
    if not isHardTimeOpen and openInfo and openInfo:IsHardOpen() then
        isHardTimeOpen = true
        if isHardOpen then
            SetLevel(currLevel, isHardOpen and isHardTimeOpen)
        end
    end
end

-----------------------------------------------轮盘-----------------------------------------------
function InitTurn()
    lastTurnNum = currTurnNum

    -- canvasHeight = CSAPI.GetMainCanvasSize()[1] or 1080
    -- canvasHeight = canvasHeight * 3 / 4
    -- local height = canvasHeight * (turnNum + 4) -- 上下多出两格用于无限滚动
    -- local width = CSAPI.GetRTSize(dropImg)
    -- CSAPI.SetRTSize(dropImg, width, height)

    currAngle = (currTurnNum - 1) * 360 / turnNum
    targetAngle = currAngle

    -- 设置位置低于第一格
    -- local x, y = CSAPI.GetAnchor(dropImg)
    -- y = currAngle / 360 * (turnNum * canvasHeight) + canvasHeight * 2
    -- CSAPI.SetAnchor(dropImg, x, y)

    SetTurnOpenList()
    SetTurnItem()
end

function SetTurnOpenList()
    if currDatas and #currDatas >= turnNum then
        for i = 1, turnNum do
            local isOpen = currDatas[i]:IsOpen()
            turnOpenList[i] = isOpen and 1 or 0
        end
    else
        local num = currDatas and #currDatas or 0
        LogError("缺少当前难度的关卡组配置表数据数量!!!需要" .. (turnNum - num))
        return
    end
end

function SetTurnItem()
    if turnItem == nil and isCreateTurnItem == false then
        isCreateTurnItem = true
        ResUtil:CreateUIGOAsync("DungeonRole/DungeonRoleItem1", turnParent, function(go)
            local lua = ComUtil.GetLuaTable(go)
            lua.SetNumClickCB(OnNumCallBack)
            lua.Refresh(sectionData)
            lua.SetHard(currLevel)
            turnItem = lua
            turnItem.Rotate(currAngle)
            SetTurn()
            isTurnLoad = true
            StartAnim()
        end)
    end
end

function OnNumCallBack(num)
    if currTurnNum == num then
        return
    end

    -- 找位置，对位顺时针旋转
    local isUp = false
    local angle = 0
    if num - currTurnNum == 1 or num - currTurnNum == -3 then
        angle = 90
        angleSpeed = 6
        isUp = true
    elseif currTurnNum - num == 1 or currTurnNum - num == -3 then
        angle = -90
        angleSpeed = 6
        isUp = false
    elseif num - currTurnNum == 2 or currTurnNum - num == 2 then
        angle = -180
        angleSpeed = 12
        isUp = false
    end
    targetAngle = currAngle + angle
    isTurnRotate = true
    TurnChangeAnim(isUp)
    if turnItem then
        PlayAnim(800, nil, true)
        turnItem.PlayRotateAnim(isUp, math.abs(angle) - 0.01)
        turnItem.ScaleIn()
        -- turnItem.ScaleTo(function ()
        --     SetTurn()
        --     SetBG()
        --     turnItem.PlayTurnFade()
        -- end)
    end
end

function SetTurn()
    SetLevel(currLevel, isHardOpen and isHardTimeOpen)
    turnItem.SetHard(currLevel)
    turnItem.SetRegion(turnOpenList[currTurnNum] == 1)
    -- turnItem.SetLock(turnOpenList[currTurnNum] == 1)
    if turnOpenList[currTurnNum] ~= 1 then
        turnItem.SetLock(true)
        turnItem.SetLock(false)
    else
        turnItem.SetLock(true)
    end
    turnItem.SetNum(currTurnNum, turnOpenList)
end

function SetLockTurn()
    SetLevel(currLevel, isHardOpen and isHardTimeOpen)
    turnItem.SetHard(currLevel)
    turnItem.SetRegion(false)
    turnItem.SetLock(false)
    local _turnOpenList = {}
    for i, v in ipairs(turnOpenList) do
        if i == currTurnNum then
            _turnOpenList[i] = 0
        else
            _turnOpenList[i] = v
        end
    end
    turnItem.SetNum(currTurnNum, _turnOpenList)

    if #items > 0 then
        items[1].SetLock(true)
        items[1].SetNew(false)
    end
end

function TurnRotate()
    if turnItem == nil then
        return
    end

    -- local x, y = CSAPI.GetAnchor(dropImg)
    -- currAngle = 360 * ((y - canvasHeight * 2) / (turnNum * canvasHeight))
    if currAngle ~= lastAngle then
        lastAngle = currAngle
        turnItem.Rotate(currAngle)
        currTurnNum = GetCurrTurnNum()
    end
end

function RotateToTarget()
    if targetAngle ~= currAngle then
        if targetAngle > currAngle then
            currAngle = math.floor(currAngle + angleSpeed)
            currAngle = currAngle > targetAngle and targetAngle or currAngle
        else
            currAngle = math.floor(currAngle - angleSpeed)
            currAngle = currAngle < targetAngle and targetAngle or currAngle
        end

        if targetAngle == currAngle then -- 终点
            -- if currAngle <= -(360 / turnNum) then
            --     currAngle = 360 - (360 / turnNum)
            -- if currAngle <= -360 then
            --     currAngle = 0
            -- elseif currAngle >= 360 then
            --     currAngle = 0
            -- end
            targetAngle = currAngle
            -- CSAPI.SetScriptEnable(sv, "ScrollRect", true)
            if currTurnNum ~= lastTurnNum then
                SetItems()

                if isOpenNextTurn then
                    turnItem.ScaleOut(function()
                        SetBG()
                        SetLockTurn()
                        turnItem.PlayTurnFade()
                        PlayDungeonOverAnim()
                    end)
                    isOpenNextTurn = false
                else
                    turnItem.ScaleOut(function()
                        SetBG()
                        SetTurn()
                        turnItem.PlayTurnFade()
                    end)
                end
                lastTurnNum = currTurnNum
            end
        end

        -- local y = currAngle / 360 * (turnNum * canvasHeight) + canvasHeight * 2
        -- local x = CSAPI.GetAnchor(dropImg)
        -- CSAPI.SetAnchor(dropImg, x, y)
    else
        isTurnRotate = false
    end
end

function GetTargetAngle()
    local angle = 0
    local offset = 360 / turnNum
    if turnNum > 0 then
        for i = 1, turnNum do
            if currAngle % 360 <= offset * (0.5 + i - 1) and currAngle % 360 > offset * (0.5 + (i - 2)) then
                angle = (i - 1) * offset
            elseif currAngle % 360 >= -(offset * (0.5 + (turnNum - (i - 1)))) and currAngle % 360 <
                -(offset * (0.5 + (turnNum - i))) then
                angle = -(turnNum - (i - 1)) * offset
            end
            -- if currAngle >= offset * (0.5 + (i - 2)) and currAngle < offset * (0.5 + (i - 1)) then
            --     angle = (i - 1) * (360 / turnNum)
            -- elseif i == 1 and currAngle >= offset * (0.5 + (turnNum - 1)) and currAngle < offset * (0.5 + turnNum) then
            --     angle = 360
            -- elseif i == turnNum and currAngle >= offset * (0.5 + (0 - 2)) and currAngle < offset * (0.5 + (1 - 2)) then
            --     angle = -(360 / turnNum)
            -- end
        end
    end
    return angle
end

function GetCurrTurnNum()
    local angle = GetTargetAngle()
    local num = math.floor(angle / (360 / turnNum))
    num = num < 0 and turnNum + num or num
    return num + 1
end
-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType()
    -- CSAPI.SetGOActive(infoMask, isActive)
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(cfg, type, OnLoadCallBack)
            CSAPI.MoveTo(node, "UI_Local_Move", isActive and -576 or 0, 0, 0, nil, 0.1)
            CSAPI.MoveTo(svMove, "UI_Local_Move", isActive and -576 or 0, 0, 0, nil, 0.1)
        end)
    else
        itemInfo.Show(cfg, type, OnLoadCallBack)
        CSAPI.MoveTo(node, "UI_Local_Move", isActive and -576 or 0, 0, 0, nil, 0.1)
        CSAPI.MoveTo(svMove, "UI_Local_Move", isActive and -576 or 0, 0, 0, nil, 0.1)
    end
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button2", "OnClickEnter", OnBattleEnter)
    itemInfo.SetFunc("PlotButton", "OnClickStory",OnStoryEnter)
    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
    if currItem then
        itemInfo.AddTeamReplace(currItem.GetType() == DungeonInfoType.Normal,OnBattleEnter)
    end
end

-- 进入
function OnBattleEnter()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if (currItem) then
        local cfg = currItem:GetCfg()
        if cfg.arrForceTeam ~= nil then -- 强制上阵编队
            CSAPI.OpenView("TeamForceConfirm", {
                dungeonId = cfg.id,
                teamNum = cfg.teamNum
            })
        else
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = cfg.id,
                teamNum = cfg.teamNum
            }, TeamConfirmOpenType.Dungeon)
        end
    end
end

function OnStoryEnter()
    itemInfo.CallFunc("PlotButton","OnStoryClick")
    if currItem and currItem.GetCfg() then
        local dungeonData = DungeonMgr:GetDungeonData(currItem.GetCfg().id)
        if not dungeonData or not dungeonData:IsPass() then --未看过剧情
            itemInfo.Show()
        end
    end
end

function OnStoryCB(isStoryFirst)
    if not isStoryFirst then
        return
    end
    local id = currItem.GetCfg().id
    local groupData = currDatas[currTurnNum]
    local ids = groupData:GetDungeonGroups()
    if id == ids[#ids] then
        if currTurnNum < turnNum then
            isOpenNextTurn = true -- 解锁动效
            jumpID = 0
        elseif currTurnNum == turnNum then
            if currLevel == 1 and isHardTimeOpen then
                isHardOpen = true
                currLevel = 2
                currTurnNum = 1
                lastTurnNum = 1
                currDatas = datas[currLevel]
                currAngle = 0
                targetAngle = 0
                turnItem.Rotate(currAngle)
                jumpID = 0
            end
        end
    else
        jumpID = ids[#ids]
        isOpenNewDungeon = true
    end

    RefreshPanel()

    if isOpenNextTurn then
        InitDungeonOverAnim()
    else
        StartAnim()
    end
end

function OnClickBack()
    if itemInfo and itemInfo.IsShow() then
        if currItem then
            currItem.SetSelect(false)
            currItem = nil
        end
        ShowInfo()
        return
    end

    view:Close()
end

-----------------------------------------------滑动-----------------------------------------------
local startPosX = 0
local startPosY = 0

function OnPressRDown()
    if isAnim or isTurnRotate then
        return
    end
    startPosX = CS.UnityEngine.Input.mousePosition.x
    startPosY = CS.UnityEngine.Input.mousePosition.y
end

function OnPressRUp()
    if isAnim or isTurnRotate then
        return
    end
    local posX = CS.UnityEngine.Input.mousePosition.x
    local posY = CS.UnityEngine.Input.mousePosition.y
    local lenX = posX - startPosX
    local lenY = posY - startPosY
    if math.abs(lenY) - math.abs(lenX) > 0 and math.abs(lenY) > 100 then -- 上下滑动且超过一定距离才响应
        local offset = 360 / turnNum
        targetAngle = lenY > 0 and targetAngle + offset or targetAngle - offset
        isTurnRotate = true
        TurnChangeAnim(lenY > 0)
        if turnItem then
            PlayAnim(700, nil, true)
            turnItem.PlayRotateAnim(lenY > 0, 89)
            turnItem.ScaleIn()
            angleSpeed = 6
            -- turnItem.ScaleTo(function ()
            --     SetTurn()
            --     SetBG()
            --     turnItem.PlayTurnFade()
            -- end)
        end
    elseif isActive then
        OnClickBack()
    end
end

function OnPressLDown()
    if isAnim or isTurnRotate then
        return
    end
    startPosX = CS.UnityEngine.Input.mousePosition.x
    startPosY = CS.UnityEngine.Input.mousePosition.y
end

function OnPressLUp()
    local posX = CS.UnityEngine.Input.mousePosition.x
    local posY = CS.UnityEngine.Input.mousePosition.y
    local lenX = posX - startPosX
    local lenY = posY - startPosY
    if (math.abs(lenY) - math.abs(lenX) <= 0 or math.abs(lenY) <= 100) and isActive then
        OnClickBack()
    end

    if isTurnRotate == false then
        targetAngle = GetTargetAngle()
        if targetAngle ~= currAngle then
            CSAPI.SetScriptEnable(sv, "ScrollRect", false)
            isTurnRotate = true
            if lastTurnNum ~= currTurnNum then
                TurnChangeAnim(targetAngle - currAngle > 0)
                if turnItem then
                    PlayAnim(700, nil, true)
                    turnItem.PlayRotateAnim(targetAngle - currAngle > 0, currAngle)
                    -- SetTurn()
                    -- SetBG()
                    turnItem.ScaleIn()
                    -- turnItem.ScaleTo(function ()
                    --     turnItem.PlayTurnFade()
                    -- end)
                end
            end
        end
    end
end

-----------------------------------------------动效-----------------------------------------------
local contentFade, contentMove

function InitAnim()
    CSAPI.SetGOActive(animMask, false)
    CSAPI.SetGOActive(enterAction, false)
    CSAPI.SetGOActive(turnChangeAction, false)
    contentFade = ComUtil.GetCom(contentAction, "ActionFade")
    contentMove = ComUtil.GetCom(contentAction, "ActionMoveByCurve")
end

function PlayAnim(time, callBack, ignore)
    CSAPI.SetGOActive(animMask, true)
    if not ignore then
        isAnim = true
    end
    FuncUtil:Call(function()
        if gameObject then
            CSAPI.SetGOActive(animMask, false)
            isAnim = false
            if callBack then
                callBack()
            end
        end
    end, this, time)
end

function StartAnim()
    if not isItemLoad or not isTurnLoad or isAnim then
        return
    end

    if openSetting and openSetting.isDungeonOver and not isLoadComplite then
        return
    end

    if not isOpenNextTurn then
        EnterAnim()
    end
end

-- 正常进入
function EnterAnim()
    -- PlayAnim(450,function ()
    if jumpID > 0 and #items > 0 then -- 跳转进入不播放入场动画
        for i, v in ipairs(items) do
            if v.GetCfg().id == jumpID then
                v.OnClick()
                if isOpenNewDungeon then
                    if #items > 0 then
                        items[2].SetLock(true)
                        items[2].SetNew(false)
                        FuncUtil:Call(function()
                            if gameObject then
                                items[2].PlayUnLockAnim()
                            end
                        end, nil, 200)
                    end
                    isOpenNewDungeon = false
                end
                return
            end
        end
    end
    -- end)

    PlayAnim(700)
    CSAPI.SetGOActive(enterAction, false)
    CSAPI.SetGOActive(enterAction, true)
    if turnItem then
        turnItem.PlayEnterAnim()
        SetTurn()
        SetBG()
    end

    if #items > 0 then
        for i, v in ipairs(items) do
            v.PlayEnterAnim()
        end
    end
end

-- 关卡结束后进入
function InitDungeonOverAnim()
    PlayAnim(800, nil, true)

    targetAngle = currAngle + 360 / turnNum
    -- CSAPI.SetScriptEnable(sv, "ScrollRect", false)
    isTurnRotate = true
    TurnChangeAnim(true)

    if isOpenNextTurn then
        turnItem.ScaleIn()
        -- turnItem.ScaleTo(function ()
        --     SetBG()
        --     SetLockTurn()
        --     turnItem.PlayTurnFade()
        --     PlayDungeonOverAnim()
        -- end)
        -- isOpenNextTurn = false
    end
end

function PlayDungeonOverAnim()
    turnItem.PlayUnLockAnim(currTurnNum, turnOpenList)

    if #items > 0 then
        FuncUtil:Call(function()
            if gameObject then
                items[1].PlayUnLockAnim()
            end
        end, nil, 100)
    end
end

-- 切换区域
function TurnChangeAnim(isUp)
    PlayAnim(1400, nil, true)
    CSAPI.SetGOActive(turnChangeAction, false)
    CSAPI.SetGOActive(turnChangeAction, true)
    local distance1 = isUp and 1000 or -1000
    local distance2 = isUp and -1000 or 1000
    FadePingPong(imgObj.gameObject, 200, 440)
    FadePingPong(bgParent.gameObject, 200, 440)
    contentFade:Play(1, 0, 100)
    contentMove.time = 200
    contentMove.startPos = UnityEngine.Vector3(0, 0, 0)
    -- contentMove.targetPos = UnityEngine.Vector3(0,isUp and itemHeight or -itemHeight,0)
    contentMove.targetPos = UnityEngine.Vector3(0, distance1, 0)
    contentMove:Play(function()
        contentFade:Play(0, 1, 540)
        contentMove.time = 350
        -- contentMove.startPos = UnityEngine.Vector3(0,isUp and -itemHeight or itemHeight,0)
        contentMove.startPos = UnityEngine.Vector3(0, distance2, 0)
        contentMove.targetPos = UnityEngine.Vector3(0, 0, 0)
        contentMove:Play()
    end)
end

function FadePingPong(go, time1, time2)
    local _fade = ComUtil.GetOrAddCom(go, "ActionFade")
    time1 = time1 or 100
    time2 = time2 or 100
    _fade:Play(1, 0, time1, 0, function()
        _fade:Play(0, 1, time2)
    end)
end

-- 子物体改变动效
function ItemChangeAnim()
    PlayAnim(450, nil, true)
    if #items > 0 then
        for i, v in ipairs(items) do
            v.PlayEnterAnim()
        end
    end
end
-----------------------------------------------本地记录-----------------------------------------------
function SaveInfo()
    local info = FileUtil.LoadByPath("DungeonRole.txt") or {}
    info[sectionData:GetID()] = info[sectionData:GetID()] or {}
    info[sectionData:GetID()].level = currLevel
    info[sectionData:GetID()].turn = currTurnNum
    FileUtil.SaveToFile("DungeonRole.txt", info)
end

function LoadInfo()
    local info = FileUtil.LoadByPath("DungeonRole.txt") or {}
    info[sectionData:GetID()] = info[sectionData:GetID()] or {}
    local cfgs = Cfgs.MainLine:GetGroup(sectionData:GetID())
    if cfgs and cfgs[1] then --重置数据
        local dungeonData = DungeonMgr:GetDungeonData(cfgs[1].id)
        if not dungeonData or not dungeonData:IsPass() then
            info[sectionData:GetID()] = {}
        end
    end
    return info[sectionData:GetID()]
end
