local layout = nil
local sectionData = nil
local datas = {}
local curDatas = {}
local curIndex = 1
local selIndex = 0
local currItem = nil
local lastIndex = 0
local currLevel = 1
local currDanger = 1
local openInfo = nil
local isDungeonOver = false
local lastEffect = nil
local effects = {}
-- hard
local isHardOpen = false
local hardTips = ""
local isHardChange = false
local isHardUnLockAnim = false
-- extra
local isExtraOpen = false
local extraTips = ""
local isExtraUnLockAnim = false
-- idle
local isStopIdle = false
local idleTime = 0
local idleInfos = nil
local idleState = 0
local itemInfo = nil

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity5/DungeonFeastItem", LayoutCallBack, true)

    CSAPI.SetGOActive(infoMask, false)

    InitAnim()

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Arachnid_Count_Refresh, function() -- 购买刷新
        local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
        EventMgr.Dispatch(EventType.Universal_Purchase_Refresh_Panel, curCount)
    end)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, currLevel)
        lua.SetSelect(index == selIndex, true)
        lua.ShowClickAnim(false)
    end
end

function OnItemClickCB(item)
    StartActive()
    local isOpen, lockStr = curDatas[item.index]:IsOpen()
    isStopIdle = not isOpen
    if not isOpen then
        Tips.ShowTips(lockStr)
    end
    if selIndex == item.index then
        return
    end

    local lua = layout:GetItemLua(selIndex)
    if lua then
        lua.SetSelect(false)
        lua.ShowClickAnim(false)
        lastIndex = lua.index
    end

    currItem = item
    currItem.SetSelect(true)
    currItem.ShowClickAnim(true)
    curIndex = item.index
    selIndex = item.index

    ChangeDungeonAnim(ShowLeftPanel)
    SetRight()
end

function OnViewOpened(viewKey)
    if viewKey ~= "DungeonFeast" then
        isStopIdle = true
    end
end

function OnViewClosed(viewKey)
    if viewKey ~= "DungeonFeast" then
        isStopIdle = false
    end
end

function OnLoadComplete()
    StartEnterAnim(function()
        if isHardUnLockAnim then
            isHardUnLockAnim = false
            isHardOpen = true
            SetLevel()
            StartUnLockHardAnim()
        end
    end)
    isDungeonOver = false
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("DungeonFeast", topParent, OnClickBack);
end

function Update()
    CSAPI.SetGOActive(idleMask, idleState > 0)

    UpdateRightIdle()

    if idleState > 1 or isStopIdle then
        return
    end

    idleTime = idleTime + Time.deltaTime
    if idleState < 1 and idleTime >= idleInfos[1] then
        ShowIdleAnim1()
        idleState = 1
    elseif idleState < 2 and idleTime >= (idleInfos[1] + idleInfos[2]) then
        ShowIdleAnim2()
        idleState = 2
    end
end

function OnOpen()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if not openInfo then
            LogError("缺少活动时间数据！id" .. sectionData:GetID())
            return
        end
        InitDatas()
        InitAnimState()
        InitIdleInfo()
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

function InitDatas()
    local _datas = DungeonMgr:GetDungeonGroupDatas(data.id)
    if _datas and #_datas > 0 then
        for i, v in ipairs(_datas) do
            local cfg = v:GetCfg()
            if cfg and cfg.type then
                datas[cfg.type] = datas[cfg.type] or {}
                table.insert(datas[cfg.type], v)
                local groups = v:GetDungeonGroups()
                if data.itemId and groups then
                    for k, m in ipairs(groups) do
                        if m == data.itemId then
                            currLevel = cfg.type
                        end
                    end
                end
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

    if datas[3] and #datas[3] > 0 then
        local _data = datas[3][1]
        isExtraOpen, extraTips = _data:IsOpen()
    end

    if not data.itemId then
        currLevel = isHardOpen and 2 or 1
        currLevel = isExtraOpen and 3 or currLevel
    end
    curDatas = datas[currLevel] or {}
end

-- 正常进入 --跳转进入 --完成关卡后进入
function InitAnimState()
    curIndex = GetCurIndex(data.itemId)
    if data.itemId then
        if openSetting and openSetting.isDungeonOver then -- 战斗结束
            isDungeonOver = true
            if DungeonMgr:GetCurrDungeonIsFirst() then -- 首通
                DungeonMgr:SetCurrDungeonNoFirst()
                -- if currLevel == 1 and curIndex == #curDatas then --开启困难
                --     isHardUnLockAnim = true
                --     currLevel = 1
                --     isHardOpen = false
                --     curDatas = datas[currLevel]
                -- end
            end
        end
    end
end

function GetCurIndex(_itemId)
    local index = curIndex
    if curDatas and #curDatas > 0 then
        index = #curDatas
        local isFirst = DungeonMgr:GetCurrDungeonIsFirst()
        for i, v in ipairs(curDatas) do
            if isFirst then -- 首通
                local ids = v:GetDungeonGroups()
                if ids and #ids > 0 then
                    if #ids > 1 then -- 有危险难度
                        for k, id in ipairs(ids) do
                            local data = DungeonMgr:GetDungeonData(id)
                            if DungeonMgr:IsDungeonOpen(id) and (not data or not data:IsPass()) then
                                index = i
                                currDanger = k
                                break
                            end
                        end
                    elseif v:IsOpen() and not v:IsPass() then
                        index = i
                        break
                    end
                end
            elseif _itemId then -- 跳转
                local ids = v:GetDungeonGroups()
                if ids and #ids > 0 then
                    for k, id in ipairs(ids) do
                        if id == _itemId then
                            index = i
                            currDanger = k
                            break
                        end
                    end
                end
            elseif v:IsOpen() and not v:IsPass() then -- 正常
                index = i
                break
            end
        end
    end
    return index
end

function InitIdleInfo()
    if g_DungeonFeastIdleTime and #g_DungeonFeastIdleTime > 0 then
        idleInfos = {g_DungeonFeastIdleTime[1] or 8, g_DungeonFeastIdleTime[2] or 8}
    end
end

function InitPanel()
    CheckNew()
    SetLevel()
    layout:IEShowList(#curDatas, OnItemLoadCB, curIndex)
end

function OnItemLoadCB()
    local item = layout:GetItemLua(curIndex)
    if item then
        local lua = layout:GetItemLua(selIndex)
        if lua then
            lua.SetSelect(false)
            lua.ShowClickAnim(false)
            lastIndex = lua.index
        end

        currItem = item
        currItem.SetSelect(true)
        curIndex = item.index
        selIndex = item.index
        ShowLeftPanel()
        SetRight()
        if not isFirst and not isDungeonOver then
            isFirst = true
            StartEnterAnim(function()
                if isHardUnLockAnim then
                    isHardUnLockAnim = false
                    isHardOpen = true
                    SetLevel()
                    StartUnLockHardAnim()
                end
            end)
        elseif isHardUnLockAnim then
            isHardUnLockAnim = false
            isHardOpen = true
            SetLevel()
            StartUnLockHardAnim()
        end
    end
    if isHardChange then
        ChangeLevelAnim2()
    end
end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonFeastView") then
        LanguageMgr:ShowTips(8012)
    end
end

function RefreshDatas()
    datas = {}
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

    curDatas = datas[currLevel]
end

function RefreshPanel()
    curDatas = datas[currLevel]
    SetLeft()
end
-----------------------------left-----------------------------
function ShowLeftPanel()
    if curDatas[curIndex] then
        local isOpen = curDatas[curIndex]:IsOpen()
        CSAPI.SetGOActive(state1, not isOpen)
        CSAPI.SetGOActive(idle1, not isOpen)
        SetSpine()
    end
end

function SetSpine()
    if lastEffect then
        CSAPI.SetGOActive(lastEffect.gameObject, false)
        lastEffect = nil
    end
    local isOpen = curDatas[curIndex]:IsOpen()
    if not isOpen then
        return
    end
    local json = curDatas[curIndex]:GetTargetJson() and curDatas[curIndex]:GetTargetJson()[1] or nil
    local name = json and json.effect or ""
    if name ~= "" then
        if effects[name] == nil then
            ResUtil:CreateSpine("Feast/" .. name, 0, 0, 0, effectParent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.InitAnim()
                effects[name] = lua
                lastEffect = lua
            end)
        else
            CSAPI.SetGOActive(effects[name].gameObject, true)
            effects[name].PlayAnim()
            lastEffect = effects[name]
        end
    end
end

function SetLeft()
    SetLevel()
    SetItems()
end

function SetLevel()
    local iconName1 = "easy"
    local iconName2 = "easy_str"
    if currLevel == 1 then
        iconName1 = isHardOpen and "hard" or "hardLock"
        iconName2 = isHardOpen and "hard_str" or "hardLock_str"
    end
    CSAPI.LoadImg(btnLevel, "UIs/DungeonActivity5/" .. iconName1 .. ".png", true, nil, true)
    CSAPI.LoadImg(levelImg, "UIs/DungeonActivity5/" .. iconName2 .. ".png", true, nil, true)
    CSAPI.SetGOActive(levelLock, currLevel == 1 and not isHardOpen)
    CSAPI.SetGOActive(levelShadow2, not isExtraOpen)
    CSAPI.SetGOActive(levelLock2, not isExtraOpen)
    CSAPI.SetGOActive(lockEffect2, not isExtraOpen)
end

function SetItems()
    layout:IEShowList(#curDatas, OnItemLoadCB, curIndex)
end

function OnClickLevel(go)
    StartActive()
    local lastLevel = currLevel
    if go.name == "btnLevel" then
        currLevel = currLevel == 1 and 2 or 1
    elseif go.name == "btnLevel2" then
        currLevel = 3
    end
    if currLevel == 2 and not isHardOpen then
        Tips.ShowTips(hardTips)
        currLevel = lastLevel
        return
    end
    if currLevel == 3 and not isExtraOpen then
        Tips.ShowTips(extraTips)
        currLevel = lastLevel
        return
    end
    local func = function()
        curIndex = 1
        selIndex = 0
        lastIndex = 0
        RefreshPanel()
    end
    if currLevel == 3 or lastLevel == 3 then
        func()
    else
        ChangeLevelAnim1(func)
    end
end

function OnClickBack()
    view:Close()
end

-----------------------------right-----------------------------
function SetRight()
    if curDatas[curIndex] then
        local isOpen = curDatas[curIndex]:IsOpen()
        ShowInfo(isOpen and currItem or nil)
        ShowRightIdle(not isOpen)
        CSAPI.SetGOActive(open2, isOpen)
    end
end

function ShowRightIdle(isShow)
    CSAPI.SetGOActive(idle2, isShow)
end

function UpdateRightIdle()
    if idleState > 1 or (curDatas and curDatas[curIndex] and not curDatas[curIndex]:IsOpen()) then
        local week, tab = TimeUtil:GetWeekDay(TimeUtil:GetTime())
        tab.hour = tab.hour < 10 and "0" .. tab.hour or tab.hour
        tab.min = tab.min < 10 and "0" .. tab.min or tab.min
        CSAPI.SetText(txtTime1, tab.hour .. ":" .. tab.min)
        CSAPI.SetText(txtTime2,
            tab.month .. LanguageMgr:GetByID(16049) .. tab.day .. LanguageMgr:GetByID(16050) .. " " ..
                LanguageMgr:GetByID(1016 + tonumber(week)))
        CSAPI.SetText(txtTime3, tab.hour .. ":" .. tab.min)
        CSAPI.SetText(txtTime4,
            tab.month .. LanguageMgr:GetByID(16049) .. tab.day .. LanguageMgr:GetByID(16050) .. " " ..
                LanguageMgr:GetByID(1016 + tonumber(week)))
    end
end

function ShowInfo(item)
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetInfoType() or DungeonInfoType.Normal
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo3", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.SetClickCB(OnBattleEnter, nil, OnStoryCB)
            itemInfo.SetIsActive(true)
            itemInfo.PlayInfoMove = PlayInfoMove
            itemInfo.PlayMoveAction = PlayMoveAction
            itemInfo.Show(cfg, type, function()
                if item then
                    itemInfo.CallFunc("Danger", "ShowDangeLevel", item.IsDanger(), item.GetCfgs(), currDanger)
                    itemInfo.SetItemPos("Double", -166, -427)
                    itemInfo.AddTeamReplace(item.GetInfoType() == DungeonInfoType.Feast, OnBattleEnter)
                end
            end)
            CSAPI.SetRTSize(itemInfo.layout, 579, 845)
        end)
    else
        itemInfo.Show(cfg, type, function()
            if item then
                itemInfo.CallFunc("Danger", "ShowDangeLevel", item.IsDanger(), item.GetCfgs(), currDanger)
                itemInfo.SetItemPos("Double", -166, -427)
                itemInfo.AddTeamReplace(item.GetInfoType() == DungeonInfoType.Feast, OnBattleEnter)
            end
        end)
        CSAPI.SetRTSize(itemInfo.layout, 579, 845)
    end
end

-- 进入
function OnBattleEnter()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if currItem and currItem.GetCfg() then -- 非体力消耗
        local cost = DungeonUtil.GetCost(currItem.GetCfg())
        if cost then
            local cur = BagMgr:GetCount(cost[1])
            if cur < cost[2] then
                local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
                UIUtil:OpenPurchaseView(nil, nil, curCount, sectionData:GetBuyCount(), sectionData:GetBuyCost(),
                    sectionData:GetBuyGets(), OnPayFunc)
                return
            end
        end
    end
    EnterNextView()
end

function OnStoryCB()
    if not itemInfo.IsStoryFirst() then
        return
    end

    RefreshDatas()
    curIndex = GetCurIndex()
    layout:UpdateList()
    if curIndex ~= selIndex then
        local item = layout:GetItemLua(curIndex)
        if item then
            local lua = layout:GetItemLua(selIndex)
            if lua then
                lua.SetSelect(false)
                lua.ShowClickAnim(false)
                lastIndex = lua.index
            end

            currItem = item
            currItem.SetSelect(true)
            curIndex = item.index
            selIndex = item.index
            ShowLeftPanel()
            SetRight()
        end
    else
        SetRight()
    end

    if currItem.index ~= #curDatas then
        return
    end

    if currLevel == 2 then -- 困难不播动效
        return
    end

    isHardOpen = true
    StartUnLockHardAnim()
end

function OnPayFunc(count)
    PlayerProto:BuyArachnidCount(count, sectionData:GetID())
end

function EnterNextView()
    if (currItem) then
        local cfg = currItem:GetCfg()
        local cfgs = currItem.GetCfgs()
        if cfgs and #cfgs > 1 then
            cfg = cfgs[itemInfo.GetCurrDanger()]
        end
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

function OnBuyFunc()
    local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
    UIUtil:OpenPurchaseView(nil, nil, curCount, sectionData:GetBuyCount(), sectionData:GetBuyCost(),
        sectionData:GetBuyGets(), OnPayFunc)
end

-- 大于右到左，小于左到右
function PlayInfoMove(isShow, callBack)
    CSAPI.SetGOActive(itemInfo.gameObject, isShow)
    if lastIndex > 0 and curIndex > 0 then
        local isRightToLeft = curIndex > lastIndex
        local infoMove = itemInfo.infoMove
        CSAPI.SetLocalPos(itemInfo.childNode, isRightToLeft and 600 or -600, 0, 0)
        PlayMoveAction(itemInfo.childNode, {0, 0, 0})
        if callBack then
            callBack()
        end
    else
        CSAPI.SetLocalPos(itemInfo.childNode, 600, 0, 0)
        PlayMoveAction(itemInfo.childNode, {0, 0, 0})
        if callBack then
            callBack()
        end
    end
end

function PlayMoveAction(go, pos, callBack)
    local infoMove = itemInfo.infoMove
    infoMove.target = go
    local x, y, z = CSAPI.GetLocalPos(go)
    infoMove.startPos = UnityEngine.Vector3(x, y, z)
    infoMove.targetPos = UnityEngine.Vector3(pos[1], pos[2], pos[3])
    infoMove.time = 400
    infoMove:Play(function()
        if callBack then
            callBack()
        end
    end)
end

-----------------------------待机-----------------------------

function StartActive()
    ShowIdleExitAnim()
    idleTime = 0
    idleState = 0
end

function OnClickActive()
    StartActive()
end

-----------------------------anim-----------------------------
local animator = nil
local animator2 = nil

function PlayAnim(delay, cb)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
        if cb then
            cb()
        end
    end, this, delay)
end

function InitAnim()
    animator = ComUtil.GetComInChildren(state2, "Animator")
    animator2 = ComUtil.GetComInChildren(effectChangeAnim, "Animator")
    CSAPI.SetGOActive(animMask, false)
    CSAPI.SetGOActive(levelEffect, false)
    CSAPI.SetGOActive(state2, false)
    CSAPI.SetGOActive(lockEffect, false)
    CSAPI.SetGOActive(levelShadow, false)
    CSAPI.SetGOActive(darkImg1, false)
    CSAPI.SetGOActive(darkImg2, false)
    CSAPI.SetGOActive(effectChangeAnim, false)

    if not IsNil(action) and action.transform.childCount > 0 then
        for i = 0, action.transform.childCount - 1 do
            CSAPI.SetGOActive(action.transform:GetChild(i).gameObject, false)
        end
    end
end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function StartEnterAnim(cb)
    local animTime = 800
    local idx = 0
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.ShowEnterAnim(idx * 60)
                idx = idx + 1
            end
        end
    end
    animTime = animTime + idx * 60
    ShowEffect(enter)
    ShowEffect(showItem)
    PlayAnim(animTime, cb)
end

-- 困难按钮解锁
function StartUnLockHardAnim()
    CSAPI.SetGOActive(levelLock, false)
    CSAPI.SetGOActive(levelShadow, true)
    ShowEffect(lockEffect)
    ShowEffect(levelUnLock)
    PlayAnim(300)
end

-- 切换难度
function ChangeLevelAnim1(cb)
    isHardChange = true
    -- selitem
    if currItem then
        currItem.ShowClickAnim(false)
        CSAPI.SetGOActive(currItem.selAnim, false)
    end
    -- 按钮
    CSAPI.SetUIScaleTo(btnLevel, nil, 0.85, 0.85, 1, nil, 0.2)
    FuncUtil:Call(function()
        CSAPI.SetUIScaleTo(btnLevel, nil, 1.05, 1.05, 1, nil, 0.1)
    end, this, 200)
    FuncUtil:Call(function()
        CSAPI.SetUIScaleTo(btnLevel, nil, 1, 1, 1, nil, 0.3)
    end, this, 300)
    -- 文字
    CSAPI.SetUIScaleTo(levelImg, nil, 1.3, 1.3, 1, nil, 0.2)
    UIUtil:SetObjFade(levelImg, 1, 0, cb, 200)

    -- 关卡
    UIUtil:SetObjFade(svNode, 1, 0, nil, 200)
    -- 特效
    ShowEffect(levelEffect)
    CSAPI.SetGOActive(animMask, true)
end

function ChangeLevelAnim2()
    local animTime = 6 * 60 + 500 + 200
    -- 文字
    CSAPI.SetScale(levelImg, 0.7, 0.7, 1)
    CSAPI.SetUIScaleTo(levelImg, nil, 1, 1, 1, nil, 0.15)
    UIUtil:SetObjFade(levelImg, 0, 1, nil, 150)
    -- 关卡
    local idx = 0
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua and idx < 7 then
                lua.ShowEnterAnim(idx * 60)
                idx = idx + 1
            end
        end
    end
    ShowEffect(showItem2)
    isHardChange = false

    PlayAnim(animTime)
end

function ChangeDungeonAnim(cb)
    ShowEffect(effectChangeAnim)
    if not IsNil(animator2) then
        animator2:SetBool("isExit", false)
    end
    FuncUtil:Call(function()
        if not IsNil(animator2) then
            animator2:SetBool("isExit", true)
        end
    end, this, 400)
    PlayAnim(400, cb)
end

function ShowIdleAnim1()
    CSAPI.SetGOActive(darkImg1, true)
    CSAPI.SetGOActive(darkImg2, true)
    UIUtil:SetObjFade(darkImg1, 0, 1, nil, 1000)
    UIUtil:SetObjFade(darkImg2, 0, 1, nil, 1000)
end

function ShowIdleAnim2()
    ShowEffect(state2)
    if not IsNil(animator) then
        animator:SetBool("isExit", false)
    end
    if currItem and currItem.IsOpen() then
        ShowEffect(itemInfo.idleAction1)
        FuncUtil:Call(function()
            if itemInfo then
                CSAPI.SetScale(itemInfo.scaleNode, 1, 1, 1)
                CSAPI.SetGOAlpha(itemInfo.scaleNode, 1)
            end
            CSAPI.SetGOActive(infoParent, false)
            CSAPI.SetGOActive(idle2, true)
            CSAPI.SetScale(scaleNode, 0.8, 0.8, 1)
            ShowEffect(idleAction)
            CSAPI.SetGOActive(state1, true)
        end, this, 400)
    end
    PlayAnim(800)
end

function ShowIdleExitAnim()
    if idleState == 1 then
        UIUtil:SetObjFade(darkImg1, 1, 0, nil, 300)
        UIUtil:SetObjFade(darkImg2, 1, 0, nil, 300)
        PlayAnim(300)
    elseif idleState == 2 then
        UIUtil:SetObjFade(darkImg1, 1, 0, nil, 300)
        UIUtil:SetObjFade(darkImg2, 1, 0, nil, 300)
        if not IsNil(animator) then
            animator:SetBool("isExit", true)
        end
        if currItem and currItem.IsOpen() then
            UIUtil:SetObjFade(scaleNode, 1, 0, function()
                CSAPI.SetGOAlpha(scaleNode, 1)
                CSAPI.SetGOActive(idle2, false)
                CSAPI.SetGOActive(state1, false)
            end, 300)
            FuncUtil:Call(function()
                CSAPI.SetGOActive(infoParent, true)
                if itemInfo then
                    CSAPI.SetScale(itemInfo.scaleNode, 1.1, 1.1, 1)
                    CSAPI.SetGOActive(itemInfo.idleAction1, false)
                    ShowEffect(itemInfo.idleAction2)
                end
            end, this, 160)
        end
        PlayAnim(460)
    end
end

