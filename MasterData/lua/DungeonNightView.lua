
local layout = nil
local sectionData =nil
local datas = {}
local openInfo = nil
local curDatas = {}
local currLevel = 1
local isDungeonOver = false
local overTipsId = 0
local isDungeonUnLock = false
local offsetScale = 0
--hard
local isHardOpen = false
local hardTips = ""
local isHardUnLockAnim = false
--extra
local isExtraOpen = false
local extraTips = ""
local isExtraUnLockAnim = false
--item
local selIndex = 0
local curIndex = 0
local currItem = nil
--item2
local items = nil
local lastIconName = 0
local itemCount = 0
--danger
local currDanger = 1
--info
local itemInfo = nil
local infoAnim = nil
--posInfo
local lastPos = {}

function Awake()
    CSAPI.SetGOActive(infoMask, false)
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity9/DungeonNightItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Arachnid_Count_Refresh,function () --购买刷新
        local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
        EventMgr.Dispatch(EventType.Universal_Purchase_Refresh_Panel, curCount)
    end)
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, CheckNew) --双倍刷新
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened) 
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed) 

    InitAnim()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data,currLevel)
        lua.SetSelect(index == selIndex,true)
        lua.SetLine(index ~= #curDatas)
    end
end

function OnItemClickCB(item)
    if selIndex == item.index then
        return
    end

    local lastItemInfo = nil
    local lua = layout:GetItemLua(selIndex)
    if lua then
        lua.SetSelect(false)
        lastItemInfo = lua.GetInfo()
    end

    currItem = item
    currItem.SetSelect(true)
    curIndex = item.index
    selIndex = item.index

    if data.itemId then --有过场动画不需要播动效
        SetPos(item.GetInfo())
        ShowInfo(item)
        ShowBGItem(curIndex)
        data.itemId = nil
        return
    end

    CSAPI.SetGOActive(animMask,true)
    if lastItemInfo then
        ShowInfo()
        ShowBGItem()
        MoveToTargetByIndex(lastItemInfo,1)
        FuncUtil:Call(function ()
            MoveToTargetByIndex(item.GetInfo(),1,function ()
                MoveToTargetByIndex(item.GetInfo(),2)
                ShowInfo(item)
                ShowBGItem(curIndex)
            end,true)
        end,this,lastItemInfo[1].time * 1000)
    else
        MoveToTargetByIndex(item.GetInfo(),1,function ()
            MoveToTargetByIndex(item.GetInfo(),2)
            ShowInfo(item)
            ShowBGItem(curIndex)
        end,true)
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
            FuncUtil:Call(function ()
                LanguageMgr:ShowTips(overTipsId)
                overTipsId = 0
            end,this,200)
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

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("DungeonNight", topParent, OnClickBack,OnClickHome);
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
        if sectionData:GetStoryID() and (not PlotMgr:IsPlayed(sectionData:GetStoryID())) then --第一次观看入场剧情
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

--正常进入 --跳转进入 --完成关卡后进入
function InitAnimState()
    curIndex = GetCurIndex(data.itemId)
    if data.itemId then
        if openSetting and openSetting.isDungeonOver then --战斗结束
            isDungeonOver = true
            if DungeonMgr:GetCurrDungeonIsFirst() then --首通
                DungeonMgr:SetCurrDungeonNoFirst()
                if currLevel == 1 and curIndex == #curDatas then --开启困难
                    isHardUnLockAnim = true
                    currLevel = 1
                    isHardOpen = false
                    curDatas = datas[currLevel]
                elseif currLevel == 2 and curIndex == #curDatas then --开启特殊
                    isExtraUnLockAnim = true
                    currLevel = 2
                    isExtraOpen = false
                    curDatas = datas[currLevel]
                elseif curIndex~=#curDatas then
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
            if _itemId then --跳转
                local ids = v:GetDungeonGroups()
                if ids and #ids>0 then
                    for k, id in ipairs(ids) do
                        if id == _itemId then
                            index = i
                            currDanger = k
                            break
                        end
                    end
                end
            elseif v:IsOpen() and not v:IsPass() then --正常
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
    InitImgScale()
    CheckNew()
    InitLevel()
    InitBGItems()
    ShowEnterAnim()
    local index = curIndex - 1 > 0 and curIndex - 1 or curIndex
    layout:IEShowList(#curDatas,OnItemLoadCB,index)
end

function OnItemLoadCB()
    if data.itemId then
        local lua = layout:GetItemLua(curIndex)
        if lua then
            lua.OnClick()
        end
    end
end

function InitImgScale()
    -- local size = CSAPI.GetMainCanvasSize()
    -- local xOffset = size[0] / 1920
    -- local yOffset = size[1] / 1080

end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonNightView") then
        LanguageMgr:ShowTips(8012)
    end
end

function RefreshPanel()
    SetLeft()
end
-----------------------------------------------left-----------------------------------------------
function InitLevel()
    CSAPI.SetGOActive(hardLock,not isHardOpen)
    CSAPI.SetGOActive(extraLock,not isExtraOpen)
    SetLevel()
end

function SetLeft()
    SetLevel()
    SetItems()
end

function SetLevel()
    CSAPI.SetGOActive(easySel1,currLevel == 1)
    CSAPI.SetGOActive(easySel2,currLevel == 1)
    CSAPI.SetGOActive(hardSel1,currLevel == 2)
    CSAPI.SetGOActive(hardSel2,currLevel == 2)
    CSAPI.SetGOActive(extraSel1,currLevel == 3)
    CSAPI.SetGOActive(extraSel2,currLevel == 3)

    local x1,y1 = currLevel == 1 and 207 or 176,currLevel == 1 and 832 or 836
    local x2,y2 = currLevel == 2 and 211 or 189,currLevel == 2 and 743 or 737
    local x3,y3 = currLevel == 3 and 215 or 203,currLevel == 3 and 645 or 641

    local scale1 = currLevel == 1 and 1 or 0.8
    local scale2 = currLevel == 2 and 1 or 0.8
    local scale3 = currLevel == 3 and 1 or 0.8
    CSAPI.SetAnchor(eszyMove,x1,y1)
    CSAPI.SetScale(eszyMove,scale1,scale1,1)
    CSAPI.SetAnchor(hardMove,x2,y2)
    CSAPI.SetScale(hardObj,scale2,scale2,1)
    CSAPI.SetAnchor(extraMove,x3,y3)
    CSAPI.SetScale(extraMove,scale3,scale3,1)
end

function SetItems()
    local index = curIndex - 1 > 0 and curIndex - 1 or curIndex
    layout:IEShowList(#curDatas,nil,index)

    OnItemSetIndex()
end

function OnClickLevel(go)
    local level = go.name == "btnHard" and 2 or 1
    level = go.name == "btnExtra" and 3 or level
    if level == currLevel then
        return
    end
    if level == 2 and not isHardOpen then
        Tips.ShowTips(hardTips)
        return
    elseif level == 3 and not isExtraOpen then
        Tips.ShowTips(extraTips)
        return
    end
    currLevel = level
    SetLevel()
    curDatas = datas[currLevel]
    SetItems()
    ShowChangeLevel()

    if isActive then
        if currItem then
            currItem.SetSelect(false)
            curIndex = 0
            selIndex = 0
            MoveToTargetByIndex(currItem.GetInfo(),1)
        end
        ShowBGItem()
        ShowInfo()
        return        
    end
end

function OnClickBack()
    if isActive then
        if currItem then
            currItem.SetSelect(false)
            curIndex = 0
            selIndex = 0
            MoveToTargetByIndex(currItem.GetInfo(),1)
        end
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
-----------------------------------------------bgItem-----------------------------------------------
function InitBGItems()
    itemCount = 0
    if datas then
        for k, v in pairs(datas) do
            if #v > 0 and #v>itemCount then
                itemCount = #v
            end
        end
    end
    if items == nil then
        items = {}
        local _datas = DungeonMgr:GetDungeonGroupDatas(data.id)
        local bgDatas = {}
        if _datas then
            for k, v in ipairs(_datas) do
                local iconName = v:GetIcon()
                if iconName and iconName~="" then
                    if bgDatas[iconName] == nil then
                        bgDatas[iconName] = 1
                        ResUtil:CreateUIGOAsync("DungeonActivity9/DungeonNightItem2",itemParent,function (go)
                            local lua=ComUtil.GetLuaTable(go)
                            lua.Refresh(v)
                            lua.SetSiblingIndex(itemCount)
                            items[iconName] = lua
                        end)
                    end
                end
            end
        end
    end
end

function OnItemSetIndex()
    if items then
        for i, v in pairs(items) do
            v.SetSiblingIndex(itemCount)
        end
    end
end
-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    CSAPI.SetGOActive(infoMask, isActive)
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType() 
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonActivity9/DungeonItemInfoNight", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            -- CSAPI.SetLocalPos(itemInfo.childNode, 0, 0, 0)
            itemInfo.PlayInfoMove = PlayInfoMove
            itemInfo.Show(cfg,type,OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg,type,OnLoadCallBack)
    end
    SetWidth(isActive)
    ShowClickAnim()
end

function PlayInfoMove(isShow, callBack)
    local animTime = 400
    if isShow then
        CSAPI.SetGOActive(itemInfo.gameObject, true);
        if itemInfo.isInfoShow and itemInfo.lastCfg ~= itemInfo.currCfg then
            itemInfo.lastCfg = itemInfo.currCfg
            itemInfo.infoFade:Play(1, 0, 200,0, function()
                CSAPI.SetLocalPos(itemInfo.childNode, 824,0,0)
                itemInfo.PlayMoveAction(itemInfo.childNode, itemInfo.enterPos)    
                itemInfo.infoCG.alpha = 1
                if callBack then
                    callBack()
                end
            end)
            animTime = 600
        else
            itemInfo.lastCfg = itemInfo.currCfg
            itemInfo.infoFade:Play(0, 1,200,0)
            itemInfo.PlayMoveAction(itemInfo.childNode, itemInfo.enterPos, function()
                itemInfo.isInfoShow = true
            end)
            if callBack then
                callBack()
            end
        end
    elseif itemInfo.isInfoShow then
        itemInfo.PlayMoveAction(itemInfo.childNode, {824, 0, 0}, function()
            CSAPI.SetLocalPos(itemInfo.childNode, 824, 0, 0)
            itemInfo.isInfoShow = false;
            CSAPI.SetGOActive(itemInfo.gameObject, false);
        end)
    end
    PlayAnim(animTime)
end

function OnLoadCallBack()
    itemInfo.SetFunc("NightButton","OnClickEnter",OnBattleEnter)
    itemInfo.CallFunc("NightPlotButton","SetStoryCB",OnStoryCB)
    itemInfo.CallFunc("Double","SetTextColor","ffc146")
    if currItem then
        itemInfo.CallFunc("NightDanger","ShowDangeLevel",currItem.IsDanger(),currItem.GetCfgs(),currDanger)
        itemInfo.AddTeamReplace(currItem.GetType() == DungeonInfoType.Night,OnBattleEnter,"Common/btn_18_03","492722")
    end
    SetInfoItemPos()
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("NightTitle",0,377)
        itemInfo.SetPanelPos("NightLevel",71,294)
        itemInfo.SetPanelPos("NightTarget",71,157)
        itemInfo.SetPanelPos("NightOutput",71,-45)
        itemInfo.SetPanelPos("NightDetails",71,-231)
        itemInfo.SetPanelPos("NightButton",21,-431)
        if currItem and currItem.GetType() == DungeonInfoType.NightSpecial then
            itemInfo.SetPanelPos("NightPlot",71,269)
            itemInfo.SetGOActive("NightPlot","titleObj",false)
        else
            itemInfo.SetPanelPos("NightPlot",71,317)
            itemInfo.SetGOActive("NightPlot","titleObj",true)
        end
        itemInfo.SetPanelPos("NightPlotButton",-276,-415)
        itemInfo.SetPanelPos("NightDanger",0,-52)
        itemInfo.SetItemPos("Double",-166,-425)
        CSAPI.SetRTSize(itemInfo.layout,579,812)
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
                cfg = cfgs[itemInfo.CallFunc("NightDanger","GetCurrDanger")]
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
    PlayerProto:BuyArachnidCount(count,sectionData:GetID())
end

function OnBuyFunc()
    local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
    if sectionData:GetBuyGets() then
        UIUtil:OpenPurchaseView(nil,nil,curCount,sectionData:GetBuyCount(),sectionData:GetBuyCost(),sectionData:GetBuyGets(),OnPayFunc)
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

    if currLevel == 2 then--困难不播动效
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
function MoveToTargetByIndex(info,index,callBack,isCheck)
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
        MoveToTarget(pos[1],pos[2],info[index].scale,info[index].time)
        if callBack then
            FuncUtil:Call(function ()
                callBack()
            end,this,info[index].time * 1000)
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
    CSAPI.SetUIScaleTo(bg, nil, scale, scale, scale, nil, time)
end

function SetPos(info)
    if info then
        local scale = info[2].scale
        CSAPI.SetScale(bg,scale,scale,1)
        local pos = info[2].pos
        CSAPI.SetAnchor(localObj, pos[1],pos[2])
        local x, y = CSAPI.GetLocalPos(localObj)
        CSAPI.SetLocalPos(bg,x,y)
    end
end

function SetWidth(isSel)
    local canvasSize = CSAPI.GetMainCanvasSize()
    local size = CSAPI.GetRTSize(hsv.gameObject)
    if isSel then
        CSAPI.SetRTSize(hsv.gameObject, -913, size[1])
        if #curDatas > 3 then
            local index = curIndex - 2
            index = curIndex == 1 and curIndex - 1 or index
            local x = index > 0 and -(20 + (308 + 125) * index) or 0
            local itemSize = CSAPI.GetRTSize(itemParent2.gameObject)
            x = x < -(itemSize[0] - (canvasSize[0] - 913)) and -(itemSize[0] - (canvasSize[0] - 913)) or x
            CSAPI.MoveTo(itemParent2, "UI_Local_Move", x, 0, 0, nil, 0.2)    
        end
    else
        CSAPI.SetRTSize(hsv.gameObject, -225, size[1])
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
                    v.SetAnim(true)
                else
                    UIUtil:SetObjFade(v.gameObject,1,0,nil,400)
                end
            else
                if i == lastIconName then
                    v.SetAnim(false)
                else
                    UIUtil:SetObjFade(v.gameObject,0,1,nil,400)
                end
            end
        end
    end
end
-----------------------------------------------anim-----------------------------------------------
local moveAction = nil
function PlayAnim(delay,cb)
    CSAPI.SetGOActive(animMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
        if cb then
            cb()
        end
    end,this,delay)
end

function InitAnim()
    CSAPI.SetGOActive(animMask,false)

    if not IsNil(action) and action.transform.childCount > 0 then
        for i = 0, action.transform.childCount - 1 do
            CSAPI.SetGOActive(action.transform:GetChild(i).gameObject, false)
        end
    end

    moveAction = ComUtil.GetCom(bg,"ActionMoveByCurve")
end

function MoveToTargetByAnim(x, y, time, callBack)
    local _x, _y = CSAPI.GetLocalPos(bg)
    moveAction.startPos = UnityEngine.Vector3(_x, _y, 0)
    moveAction.targetPos = UnityEngine.Vector3(x, y, 0)
    moveAction.time = time * 1000
    moveAction:Play(callBack)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function ShowEnterAnim()
    if isDungeonOver or data.itemId~=nil then
        return
    end
    ShowEffect(enterAction)
    PlayAnim(900)
end

function ShowClickAnim()
    if isActive then
        if not itemInfo.isInfoShow then
            UIUtil:SetObjFade(cImg,1,0,nil,200)
        end
    else
        UIUtil:SetObjFade(cImg,0,1,nil,200)
    end
end

function ShowUnLockHardAnim()
    PlayAnim(400)
    -- CSAPI.SetGOActive(hardLock,true)
    UIUtil:SetObjFade(hardLock,1,0,function ()
        isHardOpen = true
        SetLevel()
        curIndex = 1
        OnClickLevel(btnHard.gameObject)
    end,400)
end

function ShowUnLockExtraAnim()
    PlayAnim(400)
    UIUtil:SetObjFade(extraLock,1,0,function ()
        isExtraOpen = true
        SetLevel()
    end,400)
end

function ShowChangeLevel()
    PlayAnim(300)
    if currLevel == 2 then
        ShowEffect( hardAnim)
    elseif currLevel == 3 then
        ShowEffect(extraAnim)
    else
        ShowEffect(esayAnim )
    end
   
    ShowEffect(svAction)
end

function ShowDungeonUnLockAnim()
    local index = curIndex + 1
    if index <= #curDatas then
        CSAPI.SetGOActive(animMask,true)
        local lua1 =layout:GetItemLua(index - 1)
        if lua1 then
            if  currItem then
                currItem.SetSelect(false)
                currItem = nil
                selIndex = 0
                curIndex = 0
            end
            MoveToTargetByIndex(lua1.GetInfo(),1,function ()
                ShowInfo()
                ShowBGItem()
                local lua = layout:GetItemLua(index)
                if lua then
                    lua.ShowUnLockAnim()
                    lua.OnClick()
                    -- MoveToTargetByIndex(lua.GetInfo(),1,function ()
                    --     CSAPI.SetGOActive(animMask,false)
                    -- end)
                end
            end)
        end
    end
end