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
local levelTab = nil
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
local infoAnim = nil
-- posInfo
local lastPos = {}
--bg
local curMapId = 0
local moveTime = 0 -- 点与点之间移动时间

function Awake()
    CSAPI.SetGOActive(infoMask, false)
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity21/DungeonErosionItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Bag_Update, SetGoods)
    eventMgr:AddListener(EventType.Arachnid_Count_Refresh, function() -- 购买刷新
        local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
        EventMgr.Dispatch(EventType.Universal_Purchase_Refresh_Panel, curCount)
    end)
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, CheckNew) -- 双倍刷新

    InitAnim()

    levelTab = ComUtil.GetCom(levelTabs, "CTab")
    levelTab:AddSelChangedCallBack(OnTabChanged)

    CSAPI.SetGOActive(mapParent2,false)
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
        lua.ShowSelAnim(false)
    end

    currItem = item
    currItem.ShowSelAnim(true)
    curIndex = item.index
    selIndex = item.index

    if data.itemId then -- 有过场动画不需要播动效
        SetMapPos(item.GetMapId())
        ShowInfo(item)
        data.itemId = nil
        return
    end

    if curMapId == item.GetMapId() then --已在当前位置
        ShowInfo(item)
        return
    end

    StartMapMove(curMapId,item.GetMapId(),item.GetMoveTime())
    curMapId = item.GetMapId()
end

function OnLoadComplete()
    if isDungeonOver then
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

function OnTabChanged(level)
    if level == currLevel then
        return
    end
    if level == 2 and not isHardOpen then
        Tips.ShowTips(hardTips)
        levelTab.selIndex = currLevel
        return
    elseif level == 3 and not isExtraOpen then
        Tips.ShowTips(extraTips)
        levelTab.selIndex = currLevel
        return
    end
    local delay = 0
    if isActive then
        local lua = layout:GetItemLua(selIndex)
        if lua then
            lua.ShowSelAnim(false)
        end
        selIndex = 0
        ShowInfo()
        delay = 500
    end
    ShowChangeLevel(level,currLevel)
    currLevel = level
    curDatas = datas[currLevel]
    ShowChangeDungeon(SetItems)
    PlayAnim(delay)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTopByDatas("DungeonErosion", topParent, OnClickBack, OnClickHome,{});
end

function Update()
    UpdateMapPos()
end

function OnOpen()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = sectionData:GetOpenInfo()
        if not openInfo then
            LogError("缺少活动时间数据！id" .. sectionData:GetID())
            return
        end
        InitDatas()
        InitAnimState()
        -- InitBGState()
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
    InitLevel()
    ShowEnterAnim()
    InitBGItems()
    layout:IEShowList(#curDatas, OnItemLoadCB, curIndex)
end

function OnItemLoadCB()
    if data.itemId then
        local lua = layout:GetItemLua(curIndex)
        if lua then
            lua.OnClick()
        end
    elseif #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.ShowEnterAnim((i - 1) * 80)
            end
        end
        local lua = layout:GetItemLua(curIndex)
        if lua then
            SetMapPos(lua.GetMapId())
        end
    end
end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonHoliday") then
        LanguageMgr:ShowTips(8012)
    end
end

function RefreshPanel()
    SetLeft()
end
-----------------------------------------------left-----------------------------------------------
function InitLevel()
    CSAPI.SetGOActive(hardLock, not isHardOpen)
    CSAPI.SetGOActive(hardNol, isHardOpen)
    CSAPI.SetGOActive(extraLock, not isExtraOpen)
    CSAPI.SetGOActive(extraNol, isExtraOpen)
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
local isMoveing = false
local targetPosX, targetPosY, curPosX, curPosY = 0, 0, 0, 0
local targetIndex = 1
local moveIds = {}
local curMapLevel = 1
local elapsed = 0 -- 进度时间

function InitBGItems()
    items = items or {}
    local cfgs = Cfgs.DungeonPathFind:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            if items[v.id] then
                items[v.id].Refresh(v)
            elseif v.level and this["mapParent" .. v.level] then
                ResUtil:CreateUIGOAsync("DungeonActivity21/DungeonErosionBGItem",
                    this["mapParent" .. v.level].gameObject, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(v)
                    items[v.id] = lua
                end)
            end
        end
    end
end

function SetMapPos(targetId)
    if items and items[targetId] and this["mapParent" .. items[targetId].GetMapLevel()] then
        for i = 1, 2 do
            CSAPI.SetGOActive(this["mapParent" .. i].gameObject,i == items[targetId].GetMapLevel())
        end
        local x,y = items[targetId].GetPos()
        CSAPI.SetLocalPos(this["mapParent" .. items[targetId].GetMapLevel()].gameObject,x,y)
        curMapId = targetId
        curMapLevel = items[targetId].GetMapLevel()
        SetLeftTop()
        LanguageMgr:SetText(txtLevel,items[targetId].GetMapLevel() == 1 and 15162 or 15161)
    end
end


function StartMapMove(id1, id2, time)
    curPosX, curPosY = CSAPI.GetLocalPos(this["mapParent" .. curMapLevel].gameObject)
    moveIds = DungeonUtil.FindPaths(id1, id2)
    if moveIds == nil then
        LogError("起点和目标点之间不连通!!!")
        return
    end
    -- CSAPI.SetGOAlpha(this["mapParent" .. curMapLevel].gameObject)

    if #moveIds <= 1 then
        if #moveIds == 1 and moveIds[1] == id2 then -- 换层
            ShowBlackToAnim(function ()
                SetMapPos(id2)
                ShowInfo(currItem)
            end)
        end
        return
    end
    local ids = {}
    for i, v in ipairs(moveIds) do -- 剔除掉起点
        if v ~= id1 then
            table.insert(ids,v)
        end
    end
    moveIds = ids
    moveTime = 0.3
    targetIndex = 1
    if items and items[moveIds[targetIndex]] then
        local delay = 0
        if isActive then
            ShowInfo()
            delay = 350
        end
        FuncUtil:Call(function ()
            targetPosX, targetPosY = items[moveIds[targetIndex]].GetPos()
            SetPlayerAngle({curPosX, curPosY}, {targetPosX, targetPosY})
            elapsed = 0
            isMoveing = true
        end,this,delay)
        CSAPI.SetGOActive(animMask,true)
    end
end

function UpdateMapPos()
    if not isMoveing then
        return
    end

    if GetDistance({curPosX, curPosY}, {targetPosX, targetPosY}) > 0.1 then
        elapsed = elapsed + Time.deltaTime
        curPosX = curPosX + (targetPosX - curPosX) * math.min(1, elapsed / moveTime)
        curPosY = curPosY + (targetPosY - curPosY) * math.min(1, elapsed / moveTime)
        CSAPI.SetLocalPos(this["mapParent" .. curMapLevel].gameObject, curPosX, curPosY)
    elseif targetIndex + 1 <= #moveIds then
        if items and items[moveIds[targetIndex + 1]] then
            targetIndex = targetIndex + 1
            elapsed = 0
            targetPosX, targetPosY = items[moveIds[targetIndex]].GetPos()
            SetPlayerAngle({curPosX, curPosY}, {targetPosX, targetPosY})
        else
            isMoveing = false
            LogError("找不到下一个指定地点")
        end
    else
        isMoveing = false
        CSAPI.SetGOActive(animMask,false)
        ShowInfo(currItem)
        SetLeftTop()
    end
end

function GetDistance(pos1, pos2)
    return math.sqrt((pos1[1] - pos2[1]) * (pos1[1] - pos2[1]) + (pos1[2] - pos2[2]) * (pos1[2] - pos2[2]))
end

function ClampedLerp(a, b, t)
    t = math.max(0, math.min(1, t))
    return a + (b - a) * t
end
-----------------------------------------------头顶图标-----------------------------------------------
local goodsInfos = {}
function SetLeftTop()
    SetGoods()
    local cfgPath = Cfgs.DungeonPathFind:GetByID(curMapId)
    if cfgPath then
        CSAPI.SetText(txtPos, cfgPath.name)
    end  
    if curIndex then
        local groupData = curDatas[curIndex]
        if not groupData then
            return
        end
        local cfgModel = Cfgs.character:GetByID(tonumber(groupData:GetTargetContent("roleModelId")))
        if cfgModel then
            ResUtil.RoleCard:Load(iconLT,cfgModel.icon)
        end
        local state = tonumber(groupData:GetTargetContent("state"))
        CSAPI.SetGOActive(safeImg,state == 1)
        CSAPI.SetGOActive(disorderImg,state == 2)
        CSAPI.SetGOActive(dangerImg,state == 3)
        local id = state == 1 and 39013 or 39014
        id = state == 3 and 39015 or id
        LanguageMgr:SetText(txtState,id)
    end
end

function SetGoods()
    local cfgView = Cfgs.view:GetByKey("DungeonErosion")
    if cfgView and cfgView.Show_CurrencyType then
        goodsInfos = cfgView.Show_CurrencyType
        local goodsData = nil
        for i, v in ipairs(cfgView.Show_CurrencyType) do
            goodsData = GridFakeData({id = v[1]})
            goodsData:GetIconLoader():Load(this["goodsIcon" .. i].gameObject, goodsData:GetIcon() .. "_4")
            CSAPI.SetText(this["txtNum" .. i].gameObject,BagMgr:GetCount(goodsData:GetID()) .. "")
            CSAPI.SetText(this["txtGoods" .. i].gameObject,goodsData:GetName() .. "")
        end
    end
end

function OnClickJump(go)
    local index = go.name == "obj3" and 1 or 2
    if goodsInfos and goodsInfos[index] then
        if goodsInfos[index][2] then
            JumpMgr:Jump(goodsInfos[index][2])
        else
            local goodsData = GridFakeData({id = goodsInfos[index][1]})
            if goodsData then
                CSAPI.OpenView("GoodsFullInfo",{data=goodsData});
            end
        end
    end
end

-----------------------------------------------玩家图标-----------------------------------------------
-- 设置角度
function SetPlayerAngle(pos1, pos2)
    local angle = math.atan((pos2[1] - pos1[1]), (pos1[2] - pos2[2])) * (180 / math.pi)
    CSAPI.SetRectAngle(player, 0, 0, angle)
end

-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    CSAPI.SetGOActive(infoMask, isActive)
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType()
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonActivity21/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(cfg, type, OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg, type, OnLoadCallBack)
    end
    SetWidth(isActive)
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
    itemInfo.CallFunc("Double", "SetTextColor", "3b3632", "3b3632", "3b3632", "e7b042")
    itemInfo.CallFunc("Double", "SetButtonImg", "btn_03_04", "btn_03_06")
    itemInfo.CallFunc("Danager", "SetColors", {{182, 176, 156, 255}, {59, 54, 50, 255}, {59, 54, 50, 128}})
    itemInfo.CallFunc("Target", "SetGoal", "3b3632", "3b3632", "erosion_02", "erosion_01")
    if currItem then
        itemInfo.CallFunc("Danger", "ShowDangeLevel", currItem.IsDanger(), currItem.GetCfgs(), currDanger)
        itemInfo.AddTeamReplace(currItem.GetType() == DungeonInfoType.Erosion, OnBattleEnter, "Common/btn_18_09",
            "3b3632")
    end
    SetInfoItemPos()
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title", 50, 408)
        itemInfo.SetPanelPos("Level", 41, 318)
        itemInfo.SetPanelPos("Target", 41, 185)
        itemInfo.SetPanelPos("Details", 41, -200)
        itemInfo.SetPanelPos("Button", 41, -334)
        if currItem then
            itemInfo.SetPanelPos("Output", 41, currItem.IsPlot() and 15 or -17)
            itemInfo.SetPanelPos("Plot", 41, currItem.IsSpecial() and 185 or 244)
        end
        itemInfo.SetPanelPos("PlotButton", 41, -339)
        itemInfo.SetPanelPos("Danger", 41, -19)
        itemInfo.SetItemPos("Double", -238, -437)
        CSAPI.SetRTSize(itemInfo.layout, 779, 1004)
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
    if not isStoryFirst then
        -- return
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
function SetWidth(isSel)
    local canvasSize = CSAPI.GetMainCanvasSize()
    local size = CSAPI.GetRTSize(hsv.gameObject)
    if isSel then
        CSAPI.SetRTSize(hsv.gameObject, -670, size[1])
        if #curDatas > 3 then
            local index = curIndex - 2
            index = curIndex == 1 and curIndex - 1 or index
            local x = index > 0 and -((418 + 36) * index) or 0
            local itemSize = CSAPI.GetRTSize(itemParent2.gameObject)
            x = x < -(itemSize[0] - (canvasSize[0] - 670)) and -(itemSize[0] - (canvasSize[0] - 670)) or x
            CSAPI.MoveTo(itemParent2, "UI_Local_Move", x, 0, 0, nil, 0.2)
        end
    else
        CSAPI.SetRTSize(hsv.gameObject, 0, size[1])
    end
end
-----------------------------------------------anim-----------------------------------------------
local moveAction = nil
local levelAnims = {}
function PlayAnim(delay, cb)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        if not isMoveing then
            CSAPI.SetGOActive(animMask, false)
            if cb then
                cb()
            end
        end
        
    end, this, delay)
end

function InitAnim()
    CSAPI.SetGOActive(animMask, false)
    moveAction = ComUtil.GetCom(bg, "ActionMoveByCurve")

    table.insert(levelAnims,ComUtil.GetComInChildren(easyObj, "Animator"))
    table.insert(levelAnims,ComUtil.GetComInChildren(hardObj, "Animator"))
    table.insert(levelAnims,ComUtil.GetComInChildren(extraObj, "Animator"))
end

function ShowEffect(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function ShowEnterAnim()
    if isDungeonOver or data.itemId ~= nil then
        return
    end
    -- ShowEffect(enterAction)
    PlayAnim(1300)
end

function ShowUnLockHardAnim()
    PlayAnim(400)
    CSAPI.SetGOActive(hardLock, true)
    UIUtil:SetObjFade(hardLock, 1, 0, function()
        isHardOpen = true
        curIndex = 1
        levelTab.selIndex = 2
        OnTabChanged(2)
    end, 400)
end

function ShowUnLockExtraAnim()
    PlayAnim(400)
    CSAPI.SetGOActive(extraLock, true)
    UIUtil:SetObjFade(extraLock, 1, 0, function()
        isExtraOpen = true
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
        end, this, 100)
        FuncUtil:Call(function()
            for i, v in ipairs(curDatas) do
                local lua = layout:GetItemLua(i)
                if lua then
                    lua.ShowEnterAnim((i - 1) * 40)
                end
            end
        end, this, 120)
    end
end

function ShowDungeonUnLockAnim()
    local lua = layout:GetItemLua(curIndex + 1)
    if lua then
        lua.ShowUnLockAnim()
        lua.OnClick()
    end
end

function ShowBlackToAnim(callBack)
    UIUtil:SetObjFade(blackMask,0,1,callBack,250)
    FuncUtil:Call(function ()
        UIUtil:SetObjFade(blackMask,1,0,nil,250)
    end,this,250)
    PlayAnim(500)
end
