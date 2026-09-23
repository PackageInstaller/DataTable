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
local infoAnim = nil
-- posInfo
local lastPos = {}
-- tab
local levelTab = nil
-- line
local lineItem = nil

function Awake()
    CSAPI.SetGOActive(infoMask, false)
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity13/DungeonSummer2Item", LayoutCallBack, true)

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
    local lastItemInfo = curDatas[selIndex] and curDatas[selIndex]:GetTargetJson() or nil

    currItem = item
    -- currItem.SetSelect(true)
    currItem.ShowSelAnim(true)
    curIndex = item.index
    selIndex = item.index

    if data.itemId then -- 有过场动画不需要播动效
        SetPos(item.GetInfo())
        ShowInfo(item)
        ShowBGItem(curIndex)
        data.itemId = nil
        return
    end

    -- CSAPI.SetGOActive(animMask, true)
    if lastItemInfo then
        ShowInfo()
        ShowBGItem()
        MoveToTargetByIndex(lastItemInfo, 1)
        FuncUtil:Call(function()
            MoveToTargetByIndex(item.GetInfo(), 1, function()
                MoveToTargetByIndex(item.GetInfo(), 2)
                ShowInfo(item)
                ShowBGItem(curIndex)
            end, true)
        end, this, lastItemInfo[1].time * 1000)
    else
        MoveToTargetByIndex(item.GetInfo(), 1, function()
            MoveToTargetByIndex(item.GetInfo(), 2)
            ShowInfo(item)
            ShowBGItem(curIndex)
        end, true)
    end
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
        Tips.ShowTips(extraTips)
        levelTab.selIndex = currLevel
        return
    end
    if isActive then
        local lua = layout:GetItemLua(selIndex)
        if lua then
            -- currItem.SetSelect(false)
            lua.ShowSelAnim(false)
            MoveToTargetByIndex(lua.GetInfo(), 1)
        end
        curIndex = 0
        selIndex = 0
        ShowBGItem()
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
    UIUtil:AddTop2("DungeonSummer2", topParent, OnClickBack, OnClickHome);
end

function OnOpen()
    if data then
        -- data.itemId =98114
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
    ShowBGItems()
    local index = curIndex - 1 > 0 and curIndex - 1 or curIndex
    layout:IEShowList(#curDatas, OnItemLoadCB, index)
end

function OnItemLoadCB()
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.PlayAnim("Stage_entry")
            end
        end
    end
    if data.itemId then
        local lua = layout:GetItemLua(curIndex)
        if lua then
            lua.OnClick()
        end
    end
    SetLine()
end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonSummer2View") then
        LanguageMgr:ShowTips(8012)
    end
end

function RefreshPanel()
    SetLeft()
end
-----------------------------------------------left-----------------------------------------------
function InitLevel()
    CSAPI.SetGOActive(hardLock, not isHardOpen)
    CSAPI.SetGOAlpha(hard, isHardOpen and 1 or 0.7)
    CSAPI.SetGOActive(extraLock, not isExtraOpen)
    CSAPI.SetGOAlpha(extra, isExtraOpen and 1 or 0.7)
    levelTab.selIndex = currLevel
    CSAPI.SetGOActive(img_easy, currLevel == 1)
    CSAPI.SetGOActive(img_hard, currLevel == 2)
    CSAPI.SetGOActive(img_extra, currLevel == 3)
    ShowChangeLevel(currLevel)
end

function SetLeft()
    SetLevel()
    SetItems()
end

function SetLevel()

end

function SetItems()
    ShowBGItems()

    local index = curIndex - 1 > 0 and curIndex - 1 or curIndex
    layout:IEShowList(#curDatas, nil, index)

    SetLine()
end

function OnClickBack()
    if isActive then
        local lua = layout:GetItemLua(selIndex)
        if lua then
            -- currItem.SetSelect(false)
            lua.ShowSelAnim(false)
            MoveToTargetByIndex(lua.GetInfo(), 1)
        end
        curIndex = 0
        selIndex = 0
        ShowBGItem()
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
function ShowBGItems()
    items = items or {}
    local _datas = DungeonMgr:GetDungeonGroupDatas(data.id)
    local bgDatas = {}
    if _datas and #_datas > 0 then
        for k, v in ipairs(_datas) do
            local iconName = v:GetIcon()
            if iconName and iconName ~= "" then
                -- if items[iconName] ~= nil then
                --     items[iconName].Refresh2(currLevel)
                -- elseif bgDatas[iconName] == nil then
                --     ResUtil:CreateUIGOAsync("DungeonActivity13/" .. iconName,itemParent,function (go)
                --         local lua=ComUtil.GetLuaTable(go)
                --         lua.Refresh(v,currLevel)
                --         items[iconName] = lua
                --     end)
                -- end
                bgDatas[iconName] = 1
            end
        end
    end
end

function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1, offset2 = size[0] / 1920, size[1] / 1080
    local offset = offset1 > offset2 and offset1 or offset2
    CSAPI.SetScale(imgObj, offset, offset, offset)
end
-----------------------------------------------line-----------------------------------------------
function SetLine()
    -- if lineItem == nil then
    --     ResUtil:CreateUIGOAsync("DungeonActivity11/DungeonCloudLine",itemParent2,function (go)
    --         local lua = ComUtil.GetLuaTable(go)
    --         lua.Refresh(curDatas,currLevel)
    --         lua.transform:SetSiblingIndex(0)
    --         CSAPI.SetAnchor(go,0,0)
    --         lineItem = lua
    --     end)
    -- else
    --     lineItem.Refresh(curDatas,currLevel)
    -- end
end
-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    CSAPI.SetGOActive(infoMask, isActive)
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType()
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonActivity13/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            -- CSAPI.SetLocalPos(itemInfo.bgObj, itemInfo.outPos[1], 0, 0)
            -- itemInfo.PlayInfoMove = PlayInfoMove
            itemInfo.Show(cfg, type, OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg, type, OnLoadCallBack)
    end
    SetWidth(isActive)
    ShowClickAnim()
end

function PlayInfoMove(isShow, callBack)
    local animTime = 400
    if itemInfo.bgMove == nil then
        itemInfo.bgMove = ComUtil.GetCom(itemInfo.bgObj, "ActionMoveByCurve")
    end
    if isShow then
        CSAPI.SetGOActive(itemInfo.gameObject, true);
        if itemInfo.anim == nil then
            itemInfo.anim = ComUtil.GetCom(itemInfo.gameObject, "Animator")
        end
        if itemInfo.isInfoShow and itemInfo.lastCfg ~= itemInfo.currCfg then
            itemInfo.lastCfg = itemInfo.currCfg
            itemInfo.infoFade:Play(1, 0, 200, 0, function()
                CSAPI.SetLocalPos(itemInfo.childNode, 824, 0, 0)
                CSAPI.SetLocalPos(itemInfo.bgObj, 824, 0, 0)
                itemInfo.PlayMoveAction(itemInfo.childNode, itemInfo.enterPos)
                BGMoveTo(itemInfo.bgMove, itemInfo.enterPos)
                itemInfo.infoCG.alpha = 1
                if callBack then
                    callBack()
                end
            end)
            animTime = 600
        else
            itemInfo.lastCfg = itemInfo.currCfg
            itemInfo.infoFade:Play(0, 1, 200, 0)
            BGMoveTo(itemInfo.bgMove, itemInfo.enterPos)
            itemInfo.PlayMoveAction(itemInfo.childNode, itemInfo.enterPos, function()
                itemInfo.isInfoShow = true
            end)
            if callBack then
                callBack()
            end
        end
    elseif itemInfo.isInfoShow then
        if not IsNil(itemInfo.anim) then
            itemInfo.anim:Play("Info_quit")
        end
        BGMoveTo(itemInfo.bgMove, itemInfo.outPos)
        itemInfo.PlayMoveAction(itemInfo.childNode, itemInfo.outPos, function()
            CSAPI.SetLocalPos(itemInfo.childNode, itemInfo.outPos[1], 0, 0)
            CSAPI.SetLocalPos(itemInfo.bgObj, itemInfo.outPos[1], 0, 0)
            itemInfo.isInfoShow = false;
            CSAPI.SetGOActive(itemInfo.gameObject, false);
        end)
    end
    PlayAnim(animTime)
end

function BGMoveTo(aciton, pos)
    if IsNil(aciton) then
        return
    end
    local x, y, z = CSAPI.GetLocalPos(aciton.gameObject)
    aciton.startPos = UnityEngine.Vector3(x, y, z)
    aciton.targetPos = UnityEngine.Vector3(pos[1], pos[2], pos[3])
    aciton:Play()
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
    itemInfo.CallFunc("Double", "SetTextColor", "b6a992", "b6a992", "b6a992")
    itemInfo.CallFunc("Danager", "SetColors", {{247, 236, 216, 255}, {51, 72, 99, 255}, {51, 72, 99, 128}})
    itemInfo.CallFunc("Output", "ShowOutput", true, "spec_03")
    itemInfo.CallFunc("Target", "SetGoal", "67707c", "67707c", "summer2_02", "summer2_01")
    if currItem then
        itemInfo.CallFunc("Danger", "ShowDangeLevel", currItem.IsDanger(), currItem.GetCfgs(), currDanger)
        itemInfo.AddTeamReplace(currItem.GetType() == DungeonInfoType.Summer2,OnBattleEnter,"Common/btn_18_05","334863")
    end
    SetInfoItemPos()
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title", 60, 388)
        itemInfo.SetPanelPos("Level", 60, 309)
        itemInfo.SetPanelPos("Target", 60, 181)
        itemInfo.SetPanelPos("Details", 60, -200)
        itemInfo.SetPanelPos("Button", 60, -345)
        if currItem then
            itemInfo.SetPanelPos("Output", 60, currItem.IsPlot() and 30 or -25)
            itemInfo.SetPanelPos("Plot", 60, currItem.IsSpecial() and 181 or 240)
            itemInfo.SetGOActive("Output", "img", not currItem.IsPlot())
        end
        itemInfo.SetPanelPos("PlotButton", 60, -345)
        itemInfo.SetPanelPos("Danger", 60, -23)
        itemInfo.SetItemPos("Double", -209, -425)
        CSAPI.SetRTSize(itemInfo.layout, 579, 859)
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
function MoveToTargetByIndex(info, index, callBack, isCheck)
    if info and info[index] then
        local pos = info[index].pos
        if index == 1 then
            if lastPos == pos and isCheck then
                if callBack then
                    callBack()
                end
                return
            end
            lastPos = pos
        end
        MoveToTarget(pos[1], pos[2], info[index].scale, info[index].time)
        if callBack then
            FuncUtil:Call(function()
                callBack()
            end, this, info[index].time * 1000)
        end
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
        local scale = info[2].scale
        CSAPI.SetScale(bg, scale, scale, 1)
        local pos = info[2].pos
        CSAPI.SetAnchor(localObj, pos[1], pos[2])
        local x, y = CSAPI.GetLocalPos(localObj)
        CSAPI.SetLocalPos(bg, x, y)
    end
end

function SetWidth(isSel)
    local canvasSize = CSAPI.GetMainCanvasSize()
    local size = CSAPI.GetRTSize(hsv.gameObject)
    if isSel then
        CSAPI.SetRTSize(hsv.gameObject, -791, size[1])
        if #curDatas > 3 then
            local index = curIndex - 2
            index = curIndex == 1 and curIndex - 1 or index
            local x = index > 0 and -(20 + (308 + 125) * index) or 0
            local itemSize = CSAPI.GetRTSize(itemParent2.gameObject)
            x = x < -(itemSize[0] - (canvasSize[0] - 791)) and -(itemSize[0] - (canvasSize[0] - 791)) or x
            CSAPI.MoveTo(itemParent2, "UI_Local_Move", x, 0, 0, nil, 0.2)
        end
    else
        CSAPI.SetRTSize(hsv.gameObject, 0, size[1])
    end
end

function ShowBGItem(index)
    local iconName = nil
    if index then
        local _data = curDatas[index]
        if _data then
            iconName = _data:GetIcon()
        end
    end
    if items then
        for i, v in pairs(items) do
            if iconName then
                if iconName == i then
                    lastIconName = i
                    v.ShowAnim(true)
                else
                    UIUtil:SetObjFade(v.gameObject, 1, 0, nil, 400)
                end
            else
                if i == lastIconName then
                    v.ShowAnim(false)
                else
                    UIUtil:SetObjFade(v.gameObject, 0, 1, nil, 400)
                end
            end
        end
    end
end
-----------------------------------------------anim-----------------------------------------------
local moveAction, easyAnim, hardAnim, extraAnim
local levelAnims = {}
local imgLevelAnims = {}
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
    table.insert(levelAnims, ComUtil.GetCom(esay, "Animator"))
    table.insert(levelAnims, ComUtil.GetCom(hard, "Animator"))
    table.insert(levelAnims, ComUtil.GetCom(extra, "Animator"))
    table.insert(imgLevelAnims, ComUtil.GetCom(img_easy, "Animator"))
    table.insert(imgLevelAnims, ComUtil.GetCom(img_hard, "Animator"))
    table.insert(imgLevelAnims, ComUtil.GetCom(img_extra, "Animator"))
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
    ShowEffect(enterAction)
    PlayAnim(900)
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
    UIUtil:SetObjFade(hardLock, 1, 0, function()
        isHardOpen = true
        SetLevel()
        curIndex = 1
        levelTab.selIndex = 2
        CSAPI.SetGOAlpha(hard, 1)
        OnTabChanged(2)
    end, 400)
end

function ShowUnLockExtraAnim()
    PlayAnim(400)
    CSAPI.SetGOActive(extraLock, true)
    UIUtil:SetObjFade(extraLock, 1, 0, function()
        isExtraOpen = true
        SetLevel()
        curIndex = 1
        levelTab.selIndex = 3
        CSAPI.SetGOAlpha(extra, 1)
        OnTabChanged(3)
    end, 400)
end

function ShowChangeLevel(cur, last)
    PlayAnim(1400)
    if last then
        if not IsNil(levelAnims[last]) then
            levelAnims[last]:SetBool("isSel", false)
        end
        if not IsNil(imgLevelAnims[last]) and imgLevelAnims[last].gameObject.activeSelf == true then
            imgLevelAnims[last]:SetBool("isSel", false)
        end
    end
    if cur then
        if not IsNil(levelAnims[cur]) then
            levelAnims[cur]:SetBool("isSel", true)
        end
        if not IsNil(imgLevelAnims[cur]) then
            CSAPI.SetGOActive(imgLevelAnims[cur].gameObject, true)
            imgLevelAnims[cur]:SetBool("isSel", true)
        end
    end

    -- ShowEffect(svAction)
end

function ShowChangeDungeon(cb)
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.PlayAnim("Stage_quit")
            end
        end
        FuncUtil:Call(function()
            if cb then
                cb()
            end
            for i, v in ipairs(curDatas) do
                local lua = layout:GetItemLua(i)
                if lua then
                    lua.PlayAnim("Stage_entry")
                end
            end
        end, this, 251)
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
            if isActive then
                ShowInfo()
            end
            ShowBGItem()
            MoveToTargetByIndex(lua1.GetInfo(), 1, function()
                local lua = layout:GetItemLua(index)
                if lua then
                    lua.ShowUnLockAnim()
                    lua.OnClick()
                end
            end)
        end
    end
end
