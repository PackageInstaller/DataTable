local layout = nil
local currLevel = 1
local lastLevel = 1
local sectionData =nil
local datas = {}
local openInfo = nil
local curDatas = {}
local isDungeonOver = false
local overTipsId = 0
local isDungeonUnLock = false
--hard
local isHardOpen = false
local hardTips = ""
local isHardUnLockAnim = false
--extra
local isExtraOpen = false
local extraTips = ""
local isExtraUnLockAnim = false
--danger
local currDanger = 1
--item
local selIndex = 0
local curIndex = 0
local currItem = nil
--info
local itemInfo = nil
local infoAnim = nil

function Awake()    
    InitCanvas()

    CSAPI.SetGOActive(infoMask, false)
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/DungeonActivity7/DungeonSummerItem", LayoutCallBack, true)

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

function InitCanvas()
    local rect1 = ComUtil.GetCom(canvas1,"RectTransform")
    if not IsNil(rect1) then
        rect1.anchorMin = UnityEngine.Vector2(0,0)
        rect1.anchorMax = UnityEngine.Vector2(1,1)
    end
    CSAPI.SetScale(canvas1,1,1,1)
    CSAPI.SetAnchor(canvas1,0,0)
    CSAPI.SetRTSize(canvas1,0,0)

    local rect2 = ComUtil.GetCom(canvas2,"RectTransform")
    if not IsNil(rect2) then
        rect2.anchorMin = UnityEngine.Vector2(0,0)
        rect2.anchorMax = UnityEngine.Vector2(1,1)
    end
    CSAPI.SetScale(canvas2,1,1,1)
    CSAPI.SetAnchor(canvas2,0,0)
    CSAPI.SetRTSize(canvas2,0,0)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data,currLevel)
        lua.SetSelect(index == selIndex,true)
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
    ShowInfo(item)
    ShowBGAnim()
    -- RefreshPanel()
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
            FuncUtil:Call(function ()
                LanguageMgr:ShowTips(overTipsId)
                overTipsId = 0
            end,this,200)
        end
    end
end

function OnViewOpened(viewKey)
    if viewKey == "TeamConfirm" then
        CSAPI.SetGOAlpha(black,1)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "TeamConfirm" then
        FuncUtil:Call(function ()
            if gameObject then
                UIUtil:SetObjFade(black,1,0,nil,200)
            end
        end,this,300)
    end
end


function OnDestroy()
    eventMgr:ClearListener()
    -- CSAPI.SetGOAlpha(gameOjbect,0)
end

function OnInit()
    UIUtil:AddTop2("DungeonSummer", topParent, OnClickBack,OnClickHome);
end

function OnOpen()
    if data then
        -- data.itemId =96002
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if not openInfo then
            LogError("缺少活动时间数据！id" .. sectionData:GetID())
            return
        end
        InitDatas()
        InitAnimState()
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
                elseif currLevel == 2 and curIndex == #curDatas then
                    isExtraUnLockAnim = true
                    currLevel = 2
                    isExtraOpen = false
                    curDatas = datas[currLevel]
                end

                if currLevel<3 and curIndex~=#curDatas then
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


function InitPanel()
    CheckNew()
    InitLevel()
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
    ShowItemEnterAnim()
end

function CheckNew()
    if SectionNewUtil:IsNew("DungeonSummerView") then
        LanguageMgr:ShowTips(8012)
    end
end

function RefreshPanel()
    SetLeft()
end
-----------------------------------------------left-----------------------------------------------
function InitLevel()
    CSAPI.SetGOActive(bg_nol,currLevel == 1)
    CSAPI.SetGOActive(bg_hard,currLevel ~= 1)    

    CSAPI.SetAnchor(nolMove,currLevel == 1 and 30 or 0,0)
    CSAPI.SetAnchor(hardMove,currLevel == 2 and 30 or 0,0)
    CSAPI.SetAnchor(extraMove,currLevel == 3 and 30 or 0,0)

    CSAPI.SetGOActive(hardLockImg,not isHardOpen)
    CSAPI.SetGOActive(hardNolImg, isHardOpen)
    CSAPI.SetGOActive(hardSelImg, isHardOpen)

    CSAPI.SetGOActive(extraLockImg,not isExtraOpen)
    CSAPI.SetGOActive(extraNolImg, isExtraOpen)
    CSAPI.SetGOActive(extraSelImg, isExtraOpen)

    if isHardOpen then
        CSAPI.SetGOAlpha(hardNolImg,currLevel ~=2 and 1 or 0 )
        CSAPI.SetGOAlpha(hardSelImg,currLevel ==2 and 1 or 0 )    
    end

    if isExtraOpen then
        CSAPI.SetGOAlpha(extraNolImg,currLevel ~=3 and 1 or 0 )
        CSAPI.SetGOAlpha(extraSelImg,currLevel ==3 and 1 or 0 )  
    end

    CSAPI.SetGOAlpha(nolNolImg,currLevel ~=1 and 1 or 0 )
    CSAPI.SetGOAlpha(nolSelImg,currLevel ==1 and 1 or 0 )

    CSAPI.SetAnchor(txt_hard,isHardOpen and 27.5 or -7.5,0)
    CSAPI.SetAnchor(txt_extra,isExtraOpen and 27.5 or -7.5,0)

    SetLevel()
end

function SetLeft()
    SetLevel()
    SetItems()
end

function SetLevel()
    CSAPI.SetScriptEnable(txt_nol,"Outline",currLevel ~= 1)

    local hardCode = isHardOpen and "292929" or "2f2820"
    if isHardOpen then
        hardCode = currLevel == 2 and "f9dcb7" or hardCode
    end
    CSAPI.SetTextColorByCode(txt_hard,hardCode)

    local hardColor = isHardOpen and {249,220,183,255}or {225,225,225,255}
    if isHardOpen then
        CSAPI.SetScriptEnable(txt_hard,"Outline",currLevel ~= 2)
    end
    CSAPI.SetOutlineColor(txt_hard,hardColor[1],hardColor[2],hardColor[3],hardColor[4])

    local extraCode = isExtraOpen and "292929" or "2f2820"
    if isExtraOpen then
        extraCode = currLevel == 3 and "f9dcb7" or extraCode
    end
    CSAPI.SetTextColorByCode(txt_extra,extraCode)

    local extraColor = isExtraOpen and {249,220,183,255}or {225,225,225,255}
    if isExtraOpen then
        CSAPI.SetScriptEnable(txt_extra,"Outline",currLevel ~= 3)
    end
    CSAPI.SetOutlineColor(txt_extra,extraColor[1],extraColor[2],extraColor[3],extraColor[4])
end

function SetItems()
    local index = curIndex - 1 > 0 and curIndex - 1 or curIndex
    layout:IEShowList(#curDatas,nil,index)
end

function OnClickLevel(go)
    local level = go.name == "btnHard" and 2 or 1
    level = go.name == "btnExtra" and 3 or level
    if level == currLevel then
        return
    end
    lastLevel = currLevel
    currLevel = level
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
    if isActive then
        if currItem then
            currItem.ShowSelAnim(false)
            curIndex = 0
            selIndex = 0
        end
        ShowInfo()
    end
    SetLevel()
    ShowChangeLevel(function ()
        curDatas = datas[currLevel]
        SetItems()
        ReLoadBGAnim()
    end)
end

function OnClickBack()
    if isActive then
        if currItem then
            currItem.ShowSelAnim(false)
            curIndex = 0
            selIndex = 0
        end
        ShowInfo()
        return        
    end
    CSAPI.SetGOAlpha(gameObject,0)
    view:Close()
end

function OnClickHome()
    CSAPI.SetGOAlpha(gameObject,0)
    UIUtil:ToHome()
end

function OnClickRank()
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

-----------------------------------------------关卡信息-----------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    CSAPI.SetGOActive(infoMask, isActive)
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType() 
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo5", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            CSAPI.SetLocalPos(itemInfo.childNode, 0, 0, 0)
            itemInfo.PlayInfoMove = PlayInfoMove
            itemInfo.Show(cfg,type,OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg,type,OnLoadCallBack)
    end
    SetWidth(isActive)
end

function PlayInfoMove(isShow, callBack)
    local animTime = 1000
    if isShow then
        CSAPI.SetGOActive(itemInfo.gameObject, true);
        if infoAnim == nil then
            infoAnim = ComUtil.GetComInChildren(itemInfo.childNode.gameObject,"Animator")
        end
        if itemInfo.isInfoShow then
            infoAnim:Play("Level_detail_switch",0,0)
            FuncUtil:Call(function ()
                if callBack then
                    callBack()
                end
            end,itemInfo,225)
        else
            itemInfo.isInfoShow = true
            if callBack then
                callBack()
            end
        end
    elseif itemInfo.isInfoShow then
        infoAnim:SetBool("isQuit",true)
        FuncUtil:Call(function ()
            itemInfo.isInfoShow = false;
            CSAPI.SetGOActive(itemInfo.gameObject, false);
        end,itemInfo,700)
        animTime = 700
    end
    PlayAnim(animTime)
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button2","OnClickEnter",OnBattleEnter)
    itemInfo.CallFunc("PlotButton","SetStoryCB",OnStoryCB)
    if currItem then
        itemInfo.CallFunc("Danger3","ShowDangeLevel",currItem.IsDanger(),currItem.GetCfgs(),currDanger)
        itemInfo.SetGOActive("Level2","img2",not currItem.IsPlot())
        itemInfo.SetGOActive("Level2","txtLevel",not currItem.IsPlot())
        itemInfo.CallFunc("Level2","SetTitle",LanguageMgr:GetByID(currItem.IsPlot() and 22033 or 15035))
        itemInfo.AddTeamReplace(currItem.GetType() == DungeonInfoType.Summer,OnBattleEnter,"Common/btn_18_02","1e160e")
    end
    SetInfoItemPos()
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title3",0,387)
        itemInfo.SetPanelPos("Level2",0,315)
        itemInfo.SetPanelPos("Target2",0,286)
        itemInfo.SetPanelPos("Output2",11,-24)
        itemInfo.SetPanelPos("Details",0,-220)
        itemInfo.SetPanelPos("Button2",0,-414)
        itemInfo.SetPanelPos("PlotButton",0,-383)
        itemInfo.SetPanelPos("Danger3",11,-24)
        itemInfo.SetPanelPos("Plot2",0,286)
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
                cfg = cfgs[itemInfo.CallFunc("Danger3","GetCurrDanger")]
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
end

function OnBuyFunc()
    local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
    if sectionData:GetBuyGets() then
        UIUtil:OpenPurchaseView(nil,nil,curCount,sectionData:GetBuyCount(),sectionData:GetBuyCost(),sectionData:GetBuyGets(),OnPayFunc)
    end
end

function OnPayFunc(count)
    PlayerProto:BuyArachnidCount(count,sectionData:GetID())
end

function OnStoryCB()
    if not itemInfo.IsStoryFirst() then
        return
    end

    RefreshDatas()
    layout:UpdateList()

    if currItem.index ~= #curDatas then
        ShowDungeonUnLockAnim()
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

function SetWidth(isSel)
    local canvasSize = CSAPI.GetMainCanvasSize()
    local size = CSAPI.GetRTSize(hsv.gameObject)
    if isSel then
        CSAPI.SetRTSize(hsv.gameObject, -700, size[1])
        if #curDatas > 3 then
            local index = curIndex - 2
            index = curIndex == 1 and curIndex - 1 or index
            local x = index > 0 and -(56 + (340 + 14) * index) or 0
            local itemSize = CSAPI.GetRTSize(itemParent.gameObject)
            x = x < -(itemSize[0] - (canvasSize[0] - 700)) and -(itemSize[0] - (canvasSize[0] - 700)) or x
            CSAPI.MoveTo(itemParent, "UI_Local_Move", x, 0, 0, nil, 0.2)    
        end
    else
        CSAPI.SetRTSize(hsv.gameObject, 0, size[1])
    end
end
-----------------------------anim-----------------------------
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
    PlayAnim(1100)
end

function ShowItemEnterAnim()
    if isDungeonOver or data.itemId~=nil then
        return
    end
    if curDatas and #curDatas>0 then
        local index = 1
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.ShowEnterAnim(index)
                index = index + 1
            end
        end
    end
end

function ShowUnLockHardAnim()
    PlayAnim(700)
    CSAPI.SetGOActive(hardLockImg, true)
    CSAPI.SetGOActive(hardNolImg, true)
    CSAPI.SetGOActive(hardSelImg, true)
    CSAPI.SetGOAlpha(hardSelImg,0)
    ShowEffect(hardUnLockAction)
end

function ShowUnLockExtraAnim()
    PlayAnim(700)
    CSAPI.SetGOActive(extraLockImg, true)
    CSAPI.SetGOActive(extraNolImg, true)
    CSAPI.SetGOActive(extraSelImg, true)
    CSAPI.SetGOAlpha(extraSelImg,0)
    ShowEffect(extraUnLockAction)
end

function ShowChangeLevel(cb)
    PlayAnim(1650)
    local go1 = currLevel == 1 and selectNormalAction or selectHardAction
    go1 = currLevel == 3 and selectExtrAction or go1
    ShowEffect(go1)

    if lastLevel == 1 then
        ShowEffect(unSelectNormalAction)
    elseif lastLevel == 2 then
        ShowEffect(unSelectHardAction)
    elseif lastLevel == 3then
        ShowEffect(unSelectExtraAction)
    end

    CSAPI.SetGOActive(bg_nol,true)
    CSAPI.SetGOActive(bg_hard,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(bg_nol,currLevel == 1)
        CSAPI.SetGOActive(bg_hard,currLevel ~= 1)    
    end,this,200)

    if curDatas and #curDatas>0 then
        for i, v in ipairs(curDatas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.ShowChangeLevel()
            end
        end
    end

    FuncUtil:Call(function ()
        if cb then
           cb() 
        end

        if curDatas and #curDatas>0 then
            local index = 1
            for i, v in ipairs(curDatas) do
                local lua = layout:GetItemLua(i)
                if lua then
                    lua.ShowEnterAnim(index,20)
                    index = index + 1
                end
            end
        end
    end,this,200)
end

function ShowDungeonUnLockAnim()
    if curIndex > 2 then
        -- ShowEffect(dungeonUnLockAction)
    end
    if curIndex + 1 <= #curDatas then
        local lua = layout:GetItemLua(curIndex + 1)
        if lua then
            lua.SetIsLock(true)
            lua.SetLock()
            CSAPI.SetGOActive(lua.unLockObj,true)
            lua.SetTitle()
            FuncUtil:Call(function ()
                if gameObject then
                    lua.ShowUnLockAnim()
                end
            end,this,600)
            FuncUtil:Call(function ()
                if gameObject then
                    lua.OnClick()
                end
            end,this,1050)
        end
    end
    PlayAnim(1000)
end

function ShowBGAnim()
    if curDatas and curDatas[curIndex] then
        local json = curDatas[curIndex]:GetTargetJson()
        if json and json[1] then
            local idx = json[1].bg or 1
            local _,y = CSAPI.GetLocalPos(bgParent)
            CSAPI.MoveTo(bgParent,"UI_Local_Move",-((idx -1) * 1590),y,0,nil,0.5)
        end
    end
end

function ReLoadBGAnim()
    local _,y = CSAPI.GetLocalPos(bgParent)
    CSAPI.MoveTo(bgParent,"UI_Local_Move",0,y,0,nil,0.5)
end