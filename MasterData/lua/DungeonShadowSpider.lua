local layout = nil
local datas = {}
local curDatas = nil
local sectionData = nil
local lastData = nil
local openInfo = {}
local currLevel = 1
local currItem = nil
local currIndex = 0
local selIndex = 0
local isHardOpen = false
local hardTips = ""
local levelNames = {"btnNormal", "btnHard"}
local initState = {}
local lastInfo = nil
local effects = {}
local lastEffect = nil
local currDanger = 1
local viewKeys = {}
local offsetScale = 0

-- anim
local isAnim = false
local isJumpAnim = false -- 关卡结束后进入
local isHardUnLockAnim = false -- 解锁困难
local isDungeonUnLockAnim = false -- 解锁关卡
local isShowAnim = true
local bgFade = nil
local moveAction1 = nil
local moveAction2 = nil

function Awake()
    CSAPI.SetGOActive(infoMask, false)
    CSAPI.SetGOActive(animMask, false)
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity4/DungeonShadowSpiderItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Arachnid_Count_Refresh, function() -- 购买刷新
        local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
        EventMgr.Dispatch(EventType.Universal_Purchase_Refresh_Panel, curCount)
    end)
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, CheckNew) -- 双倍刷新
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)

    InitAnim()

    viewKeys = {"TeamConfirm", "TeamForceConfirm", "ShopView", "TeamView", "Bag", "FightOverResult"}
end

function OnLoadComplete()
    ShowEnterAnim()
end

function OnViewOpened(viewKey)
    if CheckView(viewKey) then
        CSAPI.SetGOActive(lastEffect, false)
    end
end

function OnViewClosed(viewKey)
    if CheckView(viewKey) then
        CSAPI.SetGOActive(lastEffect, true)
    end
end

function CheckView(viewKey)
    for i, v in ipairs(viewKeys) do
        if v == viewKey then
            return true
        end
    end
    return false
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("DungeonShadowSpider", topParent, OnClickBack);
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, currLevel)
        lua.SetSelect(selIndex == index)
    end
end

function OnItemClickCB(item)
    if selIndex == item.index then
        return
    end

    local isItemChange = false
    local lua = layout:GetItemLua(selIndex)
    if lua then
        lua.SetSelect(false)
        isItemChange = true
    end
    currItem = item
    currItem.SetSelect(true)

    currIndex = item.index
    selIndex = item.index

    local animTime = 300
    if itemInfo then
        SetWidth()
        itemInfo.SetPos(false)
    end
    if item.GetTargetInfo() then
        local infos = item.GetTargetInfo()
        local delay = 0
        if infos and #infos > 0 then
            if infos[2] and IsDontMove(infos[2]) then
                ShowInfo(item)
            else
                ClearEffect()
                for i, v in ipairs(infos) do
                    local scale = v.scale
                    if isItemChange and i == 1 then
                        scale = CSAPI.GetScale(bg)
                    end
                    FuncUtil:Call(function()
                        MoveToTarget(i, v.pos[1], v.pos[2], scale, v.time, function()
                            if i == #infos then
                                FuncUtil:Call(function()
                                    ShowInfo(item)
                                    PlayEffect(v.effect)
                                end, this, 100)
                            end
                        end)
                        ShowBGFade(i == 1, i == 1 and 0 or v.time)
                    end, this, delay)
                    delay = delay + v.time * 1000 + 50
                end
            end
            lastInfo = infos[2]
        end
        animTime = delay + 100
    else
        BackToInit()
        ShowInfo(item)
    end

    PlayAnim(animTime)
end

function IsDontMove(info)
    if lastInfo then
        local x, y = lastInfo.pos[1], lastInfo.pos[2]
        if info.pos[1] == x and info.pos[2] == y then
            return true
        end
    end
    return false
end

function OnOpen()
    InitState()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if not openInfo then
            LogError("缺少活动时间数据！id" .. sectionData:GetID())
            return
        end
        InitDatas()
        InitAnimState()
        InitHardState()
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

    if not data.itemId then
        currLevel = isHardOpen and 2 or 1
    end
    curDatas = datas[currLevel]
end

-- 正常进入 --跳转进入 --完成关卡后进入
function InitAnimState()
    currIndex = GetCurrIndex(data.itemId)
    if data.itemId then
        isJumpAnim = true
        if openSetting and openSetting.isDungeonOver then -- 战斗结束
            if DungeonMgr:GetCurrDungeonIsFirst() then -- 首通
                DungeonMgr:SetCurrDungeonNoFirst()
                if currLevel == 1 and currIndex == #curDatas then -- 开启困难
                    isHardUnLockAnim = true
                elseif currIndex ~= #curDatas then -- 不在最后一关
                    currIndex = currIndex + 1
                    isDungeonUnLockAnim = true
                end
            end
        end
    end
end

function InitHardState()
    local color = 128
    if isHardOpen and not isHardUnLockAnim then
        color = 255
    end
    CSAPI.SetTextColor(txt_hard, 255, 255, 255, color)
end

function InitPanel()
    SetLevel()
    CheckNew()
    layout:IEShowList(#curDatas, OnItemLoadSuccess, currIndex)
end

function OnItemLoadSuccess()
    if not openSetting or not openSetting.isDungeonOver then
        ShowEnterAnim()
    end
end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonShadowSpider") then
        LanguageMgr:ShowTips(8012)
    end
end

function RefreshPanel()
    SetLevel()
    curDatas = datas[currLevel]
    layout:IEShowList(#curDatas)
end

function OnClickShop()
    CSAPI.OpenView("ShopView", openInfo:GetShopID())
end

function GetCurrIndex(_itemId)
    local index = currIndex
    if curDatas and #curDatas > 0 then
        index = #curDatas
        for i, v in ipairs(curDatas) do
            if _itemId then
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
            elseif v:IsOpen() and not v:IsPass() then
                index = i
                break
            end
        end
    end
    return index
end

-----------------------------------------------难度-----------------------------------------------
function SetLevel()
    CSAPI.SetGOActive(nolImg1, currLevel ~= 1)
    CSAPI.SetGOActive(nolImg2, currLevel == 1)
    CSAPI.SetGOActive(hardImg1, currLevel == 1)
    CSAPI.SetGOActive(hardImg2, currLevel ~= 1)
    CSAPI.SetGOActive(hardLock, not isHardOpen)
end

function OnClickLevel(go)
    if go.name == levelNames[currLevel] then
        return
    end
    currLevel = currLevel == 1 and 2 or 1
    local lastLevel = currLevel
    if currLevel == 2 and not isHardOpen then
        Tips.ShowTips(hardTips)
        currLevel = 1
    end
    if lastLevel == currLevel then
        if itemInfo and itemInfo.IsShow() then
            OnClickBack()
        end
        PlayChangeLevel(RefreshPanel)
    end
end

-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    CSAPI.SetGOActive(infoMask, isActive)
    -- if IsPlotItem(item) then
    --     return
    -- end
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType() or nil
    SetWidth(isActive)
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo2", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.SetClickCB(OnBattleEnter)
            itemInfo.SetIsActive(true)
            itemInfo.Show(cfg, type, function()
                if item then
                    itemInfo.CallFunc("Danger", "ShowDangeLevel", item.IsDanger(), item.GetCfgs(), currDanger)
                    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
                    itemInfo.SetItemPos("Double", -166, -427)
                    itemInfo.AddTeamReplace(type == DungeonInfoType.Normal,OnBattleEnter)
                end
            end)
        end)
    else
        itemInfo.Show(cfg, type, function()
            if item then
                itemInfo.CallFunc("Danger", "ShowDangeLevel", item.IsDanger(), item.GetCfgs(), currDanger)
                itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
                itemInfo.SetItemPos("Double", -166, -427)
                itemInfo.AddTeamReplace(type == DungeonInfoType.Normal,OnBattleEnter)
            end
        end)
    end
end

function OnStoryCB()
    if not itemInfo.IsStoryFirst() then
        return
    end

    RefreshDatas()
    layout:UpdateList()

    if currItem.index ~= #curDatas then
        currIndex = currIndex + 1
        PlayDungeonUnLock()
        return
    end

    PlayHardUnLock()
    isHardOpen = true
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

function OnClickBack()
    if isActive then
        if currItem then
            currItem.SetSelect(false)
            currItem = nil
        end
        currIndex = 0
        selIndex = 0
        ShowInfo()
        BackToInit()
        lastInfo = nil
        return
    end

    view:Close()
end

-----------------------------------------------UISV-----------------------------------------------
function InitState()
    local x, y = CSAPI.GetAnchor(bg)
    initState.x = x
    initState.y = y
    local scale = CSAPI.GetScale(bg)
    initState.scale = scale
    offsetScale = CSAPI.GetSizeOffset() - 1
    if offsetScale > 0 then
        CSAPI.SetScale(bg, scale + offsetScale, scale + offsetScale, scale + offsetScale)
    end
end

function BackToInit()
    PlayAnim(500)
    ClearEffect()
    MoveToTarget(1, initState.x, initState.y, initState.scale, 0.5)
    ShowBGFade(true, 0)
    FuncUtil:Call(function()
        ShowBGFade(false, 250)
    end, this, 250)
end

function MoveToTarget(index, x, y, scale, time, callBack)
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
    MoveToTargetByAnim(index, x, y, time, callBack)
    -- CSAPI.MoveTo(bg, "UI_Local_Move", x, y, 0, callBack, time)
end

function ScaleTo(scale, time)
    CSAPI.SetUIScaleTo(bg, nil, scale, scale, scale, nil, time)
end

function SetWidth(isSel)
    local canvasSize = CSAPI.GetMainCanvasSize()
    local size = CSAPI.GetRTSize(hsv.gameObject)
    if isSel then
        CSAPI.SetRTSize(hsv.gameObject, -748, size[1])
        local index = currIndex - 2
        index = currIndex == 1 and currIndex - 1 or index
        local x = -(30 + (405 - 11.2) * index)
        local itemSize = CSAPI.GetRTSize(itemParent.gameObject)
        x = x < -(itemSize[0] - (canvasSize[0] - 748)) and -(itemSize[0] - (canvasSize[0] - 748)) or x
        CSAPI.MoveTo(itemParent, "UI_Local_Move", x, 0, 0, nil, 0.12)
    else
        CSAPI.SetRTSize(hsv.gameObject, 0, size[1])
    end
end
-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    bgFade = ComUtil.GetCom(bgFront, "ActionFade")
    moveAction1 = ComUtil.GetCom(bgMove1, "ActionMoveByCurve")
    moveAction2 = ComUtil.GetCom(bgMove2, "ActionMoveByCurve")
    CSAPI.SetGOActive(enterAction, false)
    CSAPI.SetGOActive(hardUnLockAction, false)
    CSAPI.SetGOActive(changeLevelAction, false)

    CSAPI.SetGOActive(nolAnim, false)
    CSAPI.SetGOActive(hardAnim, false)
    CSAPI.SetGOActive(hardUnLockAnim, false)

    for i = 1, 6 do
        local go = this["effect" .. i].gameObject
        if go then
            table.insert(effects, go)
            CSAPI.SetGOActive(go, false)
        end
    end
end

function ShowAnim(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function PlayAnim(time, callback)
    time = time or 0
    isAnim = true
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        isAnim = false
        CSAPI.SetGOActive(animMask, false)
    end, this, time)
end

function ShowBGFade(b, time)
    local from = b and 0 or 1
    local to = b and 1 or 0
    time = time or 200
    bgFade:Play(from, to, time)
end

function ShowEnterAnim()
    if not isShowAnim then
        return
    end
    isShowAnim = false

    if isHardUnLockAnim then
        PlayHardUnLock()
        return
    end

    if isDungeonUnLockAnim then
        PlayDungeonUnLock()
        return
    end

    if isJumpAnim then
        local lua = layout:GetItemLua(currIndex)
        if lua then
            lua.OnClick()
        end
        return
    end

    PlayAnim(700)
    ShowAnim(enterAction)
    ShowBGFade(false, 400)
end

function MoveToTargetByAnim(index, x, y, time, callBack)
    local moveAction = index == 1 and moveAction1 or moveAction2
    local _x, _y = CSAPI.GetLocalPos(bg)
    moveAction.startPos = UnityEngine.Vector3(_x, _y, 0)
    moveAction.targetPos = UnityEngine.Vector3(x, y, 0)
    moveAction.time = time * 1000
    moveAction:Play(callBack)
end

-- 困难解锁动画
function PlayHardUnLock()
    PlayAnim(800)
    CSAPI.SetTextColor(txt_hard, 255, 255, 255, 255)
    CSAPI.SetImgColor(hardLock, 255, 255, 255, 255)
    ShowAnim(hardUnLockAction)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(hardUnLockAnim, true)
    end, this, 200)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(hardUnLockAnim, false)
    end, this, 600)
end

-- 切换难度动画
function PlayChangeLevel(callBack)
    PlayAnim(400)
    -- local anim = currLevel == 1 and nolAnim or hardAnim
    -- CSAPI.SetGOActive(anim,true)
    -- FuncUtil:Call(function ()
    --     CSAPI.SetGOActive(anim,false)
    -- end,this,400)
    ShowAnim(changeLevelAction)
    if callBack then
        callBack()
    end
end

-- 特效播放
function PlayEffect(index)
    if index and effects[index] then
        CSAPI.SetGOActive(effects[index], true)
        lastEffect = effects[index]
    end
end

function ClearEffect()
    if lastEffect then
        CSAPI.SetGOActive(lastEffect, false)
        lastEffect = nil
    end
end

-- 关卡解锁动画
function PlayDungeonUnLock()
    PlayAnim(400)
    local unLockItem = layout:GetItemLua(currIndex)
    if unLockItem then
        unLockItem.SetIsLock(true)
        unLockItem.SetNew(false)
        unLockItem.SetBG()
        unLockItem.SetLock()
        unLockItem.PlayUnLockAnim(function()
            unLockItem.SetIsLock(false)
            unLockItem.SetNew(true)
            unLockItem.SetBG()
            unLockItem.SetLock()
            if isActive then
                ShowInfo(currItem)
            end
        end)
    end
end
