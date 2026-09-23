local layout = nil
local sectionData = nil
local datas = {}
local openInfo = nil
local curDatas = {}
local currLevel = 1
local isDungeonOver = false
local overTipsId = 0
local isDungeonUnLock = false
local offsetScale = 0
-- hard
local isHardOpen = false
local hardTips = ""
local isHardUnLockAnim = false
-- extra
local isExtraOpen = false
local extraTips = ""
local isExtraUnLockAnim = false
-- item
local selIndex = 0
local curIndex = 0
local currItem = nil
-- item2
local items = nil
local lastIconName = 0
-- danger
local currDanger = 1
-- info
local itemInfo = nil
-- posInfo
local lastPos = {}
-- tab
local levelTab = nil
-- line
local lineItem = nil
-- role
local bgIndex = 1

function Awake()
    CSAPI.SetGOActive(infoMask, false)
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity18/DungeonDesireItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Arachnid_Count_Refresh, function() -- 购买刷新
        local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
        EventMgr.Dispatch(EventType.Universal_Purchase_Refresh_Panel, curCount)
    end)
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, CheckNew) -- 双倍刷新
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)

    InitAnim()

    levelTab = ComUtil.GetCom(levelTabs, "CTab")
    levelTab:AddSelChangedCallBack(OnTabChanged)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, currLevel)
        lua.SetSelect(index == selIndex)
    end
end

function OnItemClickCB(item)
    if selIndex == item.index then
        return
    end

    local lua = layout:GetItemLua(selIndex)
    if lua then
        -- lua.SetSelect(false)
        lua.ShowSelAnim(false)
    end
    local lastItemInfo = curDatas[selIndex] and curDatas[selIndex]:GetTargetJson() and
                             curDatas[selIndex]:GetTargetJson()[1] or nil
    if lastItemInfo and lastItemInfo.index then
        bgIndex = lastItemInfo.index
    end

    currItem = item
    currItem.ShowSelAnim(true)
    curIndex = item.index
    selIndex = item.index

    if data.itemId then -- 有过场动画不需要播动效
        SetPos(item.GetInfo())
        ShowRoleIdle()
        ShowInfo(item)
        data.itemId = nil
        return
    end

    local index = item.GetInfo() and item.GetInfo().index or 1
    if bgIndex == index then
        ShowInfo(item)
        return
    end

    ShowBGChangeAnim(index)
end

function OnLoadComplete()
    if isDungeonOver then
        -- isHardUnLockAnim = true
        if isHardUnLockAnim then
            isHardOpen = true
            ShowUnLockHardAnim()
        elseif isExtraUnLockAnim then
            isExtraOpen = true
            ShowUnLockExtraAnim()
        elseif isDungeonUnLock then
            ShowDungeonUnLockAnim()
        end
        isDungeonOver = false

        if overTipsId > 0 then
            FuncUtil:Call(function()
                LanguageMgr:ShowTips(overTipsId)
                overTipsId = 0
            end, this, 200)
        end
    end
end

function OnViewOpened(viewKey)
    -- if viewKey == "TeamConfirm" then
    --     CSAPI.SetGOAlpha(black,1)
    -- end
end

function OnViewClosed(viewKey)
    -- if viewKey == "TeamConfirm" then
    --     FuncUtil:Call(function ()
    --         if gameObject then
    --             UIUtil:SetObjFade(black,1,0,nil,200)
    --         end
    --     end,this,300)
    -- end
end

function OnTabChanged(level)
    if level == currLevel then
        return
    end
    if level == 2 and not isHardOpen then
        Tips.ShowTips(hardTips)
        levelTab.selIndex = currLevel
        return
    elseif level == 3 and not isExtraOpen then
        if extraTips and extraTips~="" then
            Tips.ShowTips(extraTips)
        end
        levelTab.selIndex = currLevel
        return
    end
    if isActive then
        local lua = layout:GetItemLua(selIndex)
        if lua then
            -- currItem.SetSelect(false)
            lua.ShowSelAnim(false)
            -- MoveToTargetByIndex(lua.GetInfo(), 1)
        end
        curIndex = 0
        selIndex = 0
        ShowInfo()
    end
    ShowChangeLevel(level, currLevel)
    currLevel = level
    -- SetLevel()
    curDatas = datas[currLevel]
    ShowChangeDungeon(SetItems)
    -- SetItems()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("DungeonDesire", topParent, OnClickBack, OnClickHome);
end

function Update()
    UpdateRoleState()
end

function OnOpen()
    if data then
        -- data.itemId =917090
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if not openInfo then
            LogError("缺少活动时间数据！id" .. sectionData:GetID())
            return
        end
        InitDatas()
        InitAnimState()
        InitBGState()
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
        datas = {}
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
                if currLevel == 1 and curIndex == #curDatas then -- 开启困难
                    isHardUnLockAnim = true
                    currLevel = 1
                    isHardOpen = false
                    curDatas = datas[currLevel]
                elseif currLevel == 2 and curIndex == #curDatas then -- 开启特殊
                    isExtraUnLockAnim = true
                    currLevel = 2
                    isExtraOpen = false
                    curDatas = datas[currLevel]
                elseif curIndex ~= #curDatas then
                    isDungeonUnLock = true
                end

                local cfg = Cfgs.MainLine:GetByID(data.itemId)
                if cfg and cfg.passTips then
                    overTipsId = cfg.passTips
                end
            end
        end
    end
end

function GetCurIndex(_itemId)
    local index = curIndex
    if curDatas and #curDatas > 0 then
        index = #curDatas
        for i, v in ipairs(curDatas) do
            if _itemId then -- 跳转
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

function InitBGState()
    local scale = CSAPI.GetScale(bg)
    offsetScale = CSAPI.GetSizeOffset() - 1
    if offsetScale > 0 then
        CSAPI.SetScale(bg, scale + offsetScale, scale + offsetScale, scale + offsetScale)
    end
end

function InitPanel()
    CheckNew()
    SetBGScale()
    InitLevel()
    ShowEnterAnim()
    local index = curIndex - 1 > 0 and curIndex - 1 or curIndex
    layout:IEShowList(#curDatas, OnItemLoadCB, index)
end

function OnItemLoadCB()
    if #curDatas > 0 and not data.itemId then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.ShowEnterAnim((i - 1) * 48)
            end
        end
    end
    if data.itemId then
        local lua = layout:GetItemLua(curIndex)
        if lua then
            lua.OnClick()
        end
    end
end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonDesire") then
        LanguageMgr:ShowTips(8012)
    end
end

function RefreshPanel()
    SetLeft()
end
-----------------------------------------------left-----------------------------------------------
function InitLevel()
    CSAPI.SetGOActive(hardLock, not isHardOpen)
    CSAPI.SetGOActive(extraLock, not isExtraOpen)
    CSAPI.SetGOActive(txt_hard, isHardOpen)
    CSAPI.SetGOActive(txt_extra, isExtraOpen)
    levelTab.selIndex = currLevel
    ShowChangeLevel(currLevel)
end

function SetLeft()
    SetItems()
end

function SetItems()
    local index = curIndex - 1 > 0 and curIndex - 1 or curIndex
    layout:IEShowList(#curDatas, nil, index)
end

function OnClickBack()
    if isActive then
        local lua = layout:GetItemLua(selIndex)
        if lua then
            lua.ShowSelAnim(false)
            -- MoveToTarget(0,0,1,0.5)
        end
        curIndex = 0
        selIndex = 0
        ShowInfo()
        return
    end
    view:Close()
end

function OnClickHome()
    UIUtil:ToHome()
end

function OnClickRank()
UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end
-----------------------------------------------bg-----------------------------------------------
function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1, offset2 = size[0] / 1920, size[1] / 1080
    local offset = offset1 > offset2 and offset1 or offset2
    CSAPI.SetScale(imgObj, offset, offset, offset)
end
-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    CSAPI.SetGOActive(infoMask, isActive)
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType()
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonActivity18/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            -- CSAPI.SetLocalPos(itemInfo.bgObj, itemInfo.outPos[1], 0, 0)
            itemInfo.Show(cfg, type, OnLoadCallBack)
            -- itemInfo.SetLayoutPos({-165,430})
        end)
    else
        itemInfo.Show(cfg, type, OnLoadCallBack)
    end
    SetWidth(isActive)
    ShowClickAnim()
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
    itemInfo.CallFunc("Double", "SetTextColor", "f7ecd8", "f7ecd8", "f7ecd8")
    itemInfo.CallFunc("Danager", "SetColors", {{247, 236, 216, 255}, {85, 103, 109, 255}, {85, 103, 109, 128}})
    -- itemInfo.CallFunc("Output", "ShowOutput", true, "spec_04")
    itemInfo.CallFunc("Target", "SetGoal", "a0d3db", "a0d3db", "desire_01", "summer2_01")
    if currItem then
        itemInfo.CallFunc("Danger", "ShowDangeLevel", currItem.IsDanger(), currItem.GetCfgs(), currDanger)
        itemInfo.AddTeamReplace(currItem.GetType() == DungeonInfoType.Desire, OnBattleEnter, "Common/btn_18_06",
            "cecece")
        if itemInfo.GetPanelObj("Button","btnEnter") then
            CSAPI.SetAnchor(itemInfo.GetPanelObj("Button","btnEnter").gameObject,currItem.IsSpecial() and -35 or 17,-6)
        end
    end
    SetInfoItemPos()
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title", 0, 418)
        itemInfo.SetPanelPos("Level", 0, 327)
        itemInfo.SetPanelPos("Target", 0, 194)
        itemInfo.SetPanelPos("Details", 0, -180)
        itemInfo.SetPanelPos("Button", 0, -323)
        if currItem then
            itemInfo.SetPanelPos("Output", 0, currItem.IsPlot() and -17 or -6)
            itemInfo.SetPanelPos("Plot", 0, currItem.IsSpecial() and 195 or 235)
            itemInfo.SetGOActive("Output", "bg", not currItem.IsPlot())
        end
        itemInfo.SetPanelPos("PlotButton", 0, -365)
        itemInfo.SetPanelPos("Danger", 0, -10)
        itemInfo.SetItemPos("Double", -240, -428)
        CSAPI.SetRTSize(itemInfo.layout, 757, 928)
    end
end

-- 进入
function OnBattleEnter()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if currItem then
        local cfg = currItem:GetCfg()
        if cfg then
            local cost = DungeonUtil.GetCost(cfg)
            if cost then
                local cur = BagMgr:GetCount(cost[1])
                if cur < cost[2] then
                    OnBuyFunc()
                    return
                end
            end
            local cfgs = currItem.GetCfgs()
            if cfgs and #cfgs > 1 then
                cfg = cfgs[itemInfo.CallFunc("Danger", "GetCurrDanger")]
            end
            if cfg then
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
    end
end

function OnPayFunc(count)
    PlayerProto:BuyArachnidCount(count, sectionData:GetID())
end

function OnBuyFunc()
    local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
    if sectionData:GetBuyGets() then
        UIUtil:OpenPurchaseView(nil, nil, curCount, sectionData:GetBuyCount(), sectionData:GetBuyCost(),
            sectionData:GetBuyGets(), OnPayFunc)
    end
end

function OnStoryCB(isStoryFirst)
    isStoryFirst = true
    if not isStoryFirst then
        return
    end
    local index = currItem.index

    RefreshDatas()
    layout:UpdateList()
    ShowDungeonUnLockAnim()

    if index ~= #curDatas then
        return
    end

    if currLevel == 2 then -- 困难不播动效
        return
    end

    isHardOpen = true
    ShowUnLockHardAnim()
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
-----------------------------------------------sv-----------------------------------------------
local bgPos = {285, 2225, 3745, 5260, 7000}
function MoveToTargetByIndex(info)
    delay = delay or 0
    if info and info.index and bgPos[info.index] then
        bgIndex = info.index
        MoveToTarget(0, bgPos[info.index], info.scale, info.time)
    end
end

function MoveToTarget(x, y, scale, time, callBack)
    x = x or 0
    y = y or 0
    scale = scale or 1
    if offsetScale > 0 then
        x = x * (1 + offsetScale)
        y = y * (1 + offsetScale)
        scale = scale + offsetScale
    end
    CSAPI.SetAnchor(localObj, x, y)
    x, y = CSAPI.GetLocalPos(localObj)
    time = time or 0.2
    ScaleTo(scale, time)
    MoveToTargetByAnim(x, y, time, callBack)
    -- CSAPI.MoveTo(bg, "UI_Local_Move", x, y, 0, callBack, time)
end

function ScaleTo(scale, time)
    if bg and not IsNil(bg.gameObject) then
        CSAPI.SetUIScaleTo(bg, nil, scale, scale, scale, nil, time)
    end
end

function SetPos(info)
    if info then
        local scale = info.scale
        CSAPI.SetScale(bg, scale, scale, 1)
        local x, y = 0, info.index and bgPos[info.index] or 0
        bgIndex = info.index or bgIndex
        CSAPI.SetAnchor(localObj, x, y)
        x, y = CSAPI.GetLocalPos(localObj)
        CSAPI.SetLocalPos(bg, x, y)
    end
end

function SetWidth(isSel)
    if IsNil(hsv) then
        return
    end
    local canvasSize = CSAPI.GetMainCanvasSize()
    local size = CSAPI.GetRTSize(hsv.gameObject)
    if isSel then
        CSAPI.SetRTSize(hsv.gameObject, -727, size[1])
        if #curDatas > 3 then
            local index = curIndex - 2
            index = curIndex == 1 and curIndex - 1 or index
            local x = index > 0 and -(48 + (326 + 45.25) * index) or 0
            local itemSize = CSAPI.GetRTSize(itemParent2.gameObject)
            x = x < -(itemSize[0] - (canvasSize[0] - 727)) and -(itemSize[0] - (canvasSize[0] - 727)) or x
            CSAPI.MoveTo(itemParent2, "UI_Local_Move", x, 0, 0, nil, 0.2)
        end
    else
        CSAPI.SetRTSize(hsv.gameObject, 0, size[1])
    end
end
-----------------------------------------------anim-----------------------------------------------
local moveAction, easyAnim, hardAnim, extraAnim, bgAnim, nodeAnim, roleAnim,hsvAnim
local levelAnims = {}
local roleMoveAction = nil
local isRoleAnim = false
local idleTime = 0

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
    CSAPI.SetGOActive(animMask, false)

    if not IsNil(action) and action.transform.childCount > 0 then
        for i = 0, action.transform.childCount - 1 do
            CSAPI.SetGOActive(action.transform:GetChild(i).gameObject, false)
        end
    end

    moveAction = ComUtil.GetCom(bg, "ActionMoveByCurve")
    table.insert(levelAnims, ComUtil.GetCom(easyObj, "Animator"))
    table.insert(levelAnims, ComUtil.GetCom(hardObj, "Animator"))
    table.insert(levelAnims, ComUtil.GetCom(extraObj, "Animator"))

    roleAnim = ComUtil.GetCom(role, "Animator")
    bgAnim = ComUtil.GetCom(bottomCanvas, "Animator")
    nodeAnim = ComUtil.GetCom(node, "Animator")
    roleAnim = ComUtil.GetCom(roleAnimObj, "Animator")
    hsvAnim = ComUtil.GetCom(hsv, "Animator")
end

function MoveToTargetByAnim(x, y, time, callBack)
    local _x, _y = CSAPI.GetLocalPos(bg)
    moveAction.startPos = UnityEngine.Vector3(_x, _y, 0)
    moveAction.targetPos = UnityEngine.Vector3(x, y, 0)
    moveAction.time = time * 1000
    moveAction:Play(callBack)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function ShowEnterAnim()
    if isDungeonOver or data.itemId ~= nil then
        return
    end
    bgAnim:Play("bgEntry")
    nodeAnim:Play("entry")
    ShowEffect(enterAction)
    -- 角色入场
    isRoleAnim = true
    ShowRoleEnter()
    FuncUtil:Call(function()
        isRoleAnim = false
        ShowRoleIdle()
    end, this, 2000)
    PlayAnim(2000)
end

function ShowClickAnim()
    -- if isActive then
    --     if not itemInfo.isInfoShow then
    --         UIUtil:SetObjFade(cImg,1,0,nil,200)
    --     end
    -- else
    --     UIUtil:SetObjFade(cImg,0,1,nil,200)
    -- end
end

function ShowUnLockHardAnim()
    PlayAnim(400)
    CSAPI.SetGOActive(hardLock, true)
    CSAPI.SetGOActive(txt_hard, false)
    UIUtil:SetObjFade(hardLock, 1, 0, function()
        isHardOpen = true
        CSAPI.SetGOActive(txt_hard, true)
        -- SetLevel()
        curIndex = 1
        levelTab.selIndex = 2
        OnTabChanged(2)
    end, 400)
end

function ShowUnLockExtraAnim()
    PlayAnim(400)
    CSAPI.SetGOActive(extraLock, true)
    CSAPI.SetGOActive(txt_extra, false)
    UIUtil:SetObjFade(extraLock, 1, 0, function()
        isExtraOpen = true
        CSAPI.SetGOActive(txt_extra, true)
        -- SetLevel()
        curIndex = 1
        levelTab.selIndex = 3
        OnTabChanged(3)
    end, 400)
end

function ShowChangeLevel(cur, last)
    PlayAnim(1200)
    if last then
        if not IsNil(levelAnims[last]) then
            levelAnims[last]:SetBool("isSel", false)
        end
    end
    if cur then
        if not IsNil(levelAnims[cur]) then
            levelAnims[cur]:SetBool("isSel", true)
        end
    end
    if not IsNil(hsvAnim) then
        hsvAnim:Play("itemPos_switch")
    end
    -- ShowEffect(svAction)
end

function ShowChangeDungeon(cb)
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.ShowQuitAnim()
            end
        end
        FuncUtil:Call(function()
            if cb then
                cb()
            end
            for i, v in ipairs(curDatas) do
                local lua = layout:GetItemLua(i)
                if lua then
                    lua.ShowEnterAnim((i - 1) * 80)
                end
            end
        end, this, 100)
    end
end

function ShowDungeonUnLockAnim()
    local index = curIndex + 1
    if index <= #curDatas then
        -- CSAPI.SetGOActive(animMask, true)
        local lua1 = layout:GetItemLua(index - 1)
        if lua1 then
            local lua2 = layout:GetItemLua(selIndex)
            if lua2 then
                -- currItem.SetSelect(false)
                lua2.ShowSelAnim(false)
                currItem = nil
            end
            selIndex = 0
            curIndex = 0
            -- if isActive then
            --     ShowInfo()
            -- end
            local lua = layout:GetItemLua(index)
            if lua then
                lua.ShowUnLockAnim()
                lua.OnClick()
            end
            -- MoveToTargetByIndex(lua1.GetInfo(), 1, function()
            --     local lua = layout:GetItemLua(index)
            --     if lua then
            --         lua.ShowUnLockAnim()
            --         lua.OnClick()
            --     end
            -- end)
        end
    end
end

function ShowBGChangeAnim(index)
    local info = currItem and currItem.GetInfo()
    if not info then
        return
    end
    if roleMoveAction and not IsNil(roleMoveAction.gameObject) then
        CSAPI.RemoveGO(roleMoveAction.gameObject)
        roleMoveAction = nil
    end
    local isTeleport = bgIndex == 1 or index == 1
    local delay = isTeleport and 1 or 1.5
    isRoleAnim = true
    -- 退场
    CloseRoleAnim()
    ShowRoleOut(not isTeleport)
    ShowInfo()
    -- 背景移动
    FuncUtil:Call(function()
        CloseRoleAnim()
        MoveToTargetByIndex(info)
    end, this, delay * 1000)
    -- 入场
    delay = delay + info.time + 0.1
    FuncUtil:Call(function()
        ShowRoleEnter(not isTeleport)
    end, this, delay * 1000)
    -- 进入待机
    delay = delay + (isTeleport and 1 or 1.5)
    FuncUtil:Call(function()
        CloseRoleAnim()
        isRoleAnim = false
        ShowRoleIdle()
    end, this, delay * 1000)
    --关卡信息显示
    FuncUtil:Call(function()
        ShowInfo(currItem)
    end, this, (delay - 1) * 1000)
    PlayAnim(delay * 1000)
end
-----------------------------------------------role-----------------------------------------------
local targetIndex = 0
local targetPos = {-540, 0} --可移动的目标点集合
local roleMoveTime = 2 --移动到目标点所需的时间 单位：秒
local idleBaseTime = 5 --待机时间

function ShowRoleEnter(isDoor)
    CSAPI.SetGOActive(roleEnter, isDoor)
    CSAPI.SetGOActive(roleAnimObj, not isDoor)
    if not isDoor and not IsNil(roleAnim) then
        roleAnim:Play("Anim_entry")
    end
end

function ShowRoleOut(isDoor)
    CSAPI.SetGOActive(roleOut, isDoor)
    CSAPI.SetGOActive(roleAnimObj, not isDoor)
    if not isDoor and not IsNil(roleAnim) then
        roleAnim:Play("Anim_quit")
    end
end

function CloseRoleAnim()
    CSAPI.SetGOActive(roleEnter, false)
    CSAPI.SetGOActive(roleOut, false)
    CSAPI.SetGOActive(roleAnimObj, false)
    CSAPI.SetGOActive(roleWalkR, false)
    CSAPI.SetGOActive(roleWalkL, false)
    CSAPI.SetGOActive(roleIdle, false)
end

function ShowRoleIdle()
    CloseRoleAnim()
    CSAPI.SetGOActive(roleIdle, true)
    idleTime = idleBaseTime
end

function ShowRoleWalk(isLeft, targetPosX)
    CloseRoleAnim()
    CSAPI.SetGOActive(roleWalkR, not isLeft)
    CSAPI.SetGOActive(roleWalkL, isLeft)
    roleMoveAction = CSAPI.MoveTo(roleMove, "UI_Local_Move", targetPosX, 0, 0, nil, roleMoveTime)
end

function UpdateRoleState()
    if isRoleAnim then
        return
    end

    if idleTime > 0 then
        idleTime = idleTime - Time.deltaTime
        if idleTime <= 0 then
            targetIndex = GetTargetIndex()
            ShowRoleWalk(targetIndex == 1, targetPos[targetIndex])
            FuncUtil:Call(function()
                if not isRoleAnim then
                    ShowRoleIdle()
                end
            end, this, roleMoveTime * 1000)
        end
    end
end

function GetTargetIndex()
    if #targetPos > 1 then
        local index = CSAPI.RandomInt(1,#targetPos)
        if index == targetIndex then
            return GetTargetIndex()
        end
        return index
    end
    return 1
end


