local UIMaskGo = nil
local top = nil
local currItem = nil;
local currType = nil; -- 1.主线 2.日常 3.军演 4.活动
local isViewJump = false --跳转进来而不是战斗结束返回
--锚点
local PivotType = {
    Center = 0,
    Up = 1,
    Left = 2,
    Down = 3,
    Right = 4
}
--分辨率适应
local offset = {}
--场景界面
local SectionViewType ={
    MainLine = 1,
    Daily =2,
    Exercise = 3,
    Activity = 4
}
--选择物体
local SelectType = {
    MainLine = 1, --主线
    Daily = 2, --日常
    Exercise = 3, --演习
    Activity = 4, --活动
    All = 5 --任意
}
-- 主页
local rects = {}
local canvasSize = nil
local currIndex = 1 -- 页数
local viewInfo = {}
local linePool = {}
local lineItems = {}
local titleIds = {36001,36003,36002,15081}
local curState = 0 --1.前进 2.后退
local isAnim = false
local animTime = 0
local isJump = false
local jumpData = nil
local isClickEnter = false --限制点击过快导致打开多个界面
local isViewDrop = false
--主线
local currSectionIndex = 0
local mainLineDatas = nil
local mainLinePanel = nil
local layout1 = nil
local lastPrograssIdx = 0
local itemPos1 = {}
-- 日常
local weeks = {1017,1018,1019,1020,1021,1022,1023}
local dailyPanel = nil
local dailyDatas = nil
local dailyDatasL1 = nil
local dailyDatasL2 = nil
local layout2 = nil
local layout3 = nil
local curDailyItemR = nil
local dailyPoints = {}
local lastPosY={0,0,0}
local currDailyIndexL1 = 0
local currDailyIndexL2 = 0
local currDailyIndexR = 0
--军演
local exercisePanel = nil
local isPvpRet = false
--活动
local layout4 =nil
local activityDatas = nil
local activityDatas2 = nil
local curActivityItem1 = nil
local curActivityItem2 = nil
local btnCanvasGroup = nil
local hasSecond = false
local items4 = nil
local itemNums = nil
--uisv
local isDrop = false
--动效
local moveAction = nil
local menuFade = nil
local backFade = nil
local fades = nil 
local exerciseFade = nil
local exerciseMoveL = nil
local exerciseMoveR = nil
local activityFade = nil
--特殊引导
local lastGuideInfo = nil
local isStopSP = false
local viewKeys = {} --记录界面状态
local guideTimer = 0--限制点击

-- 章节界面
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnEnterSound)
    eventMgr:AddListener(EventType.Activity_Open_State, RefreshActivityDatas) --开启状态更新
    eventMgr:AddListener(EventType.Update_Everyday, RefreshActivityDatas) --每日到点更新
    eventMgr:AddListener(EventType.Tower_Update_Data, RefreshActivityDatas) --爬塔数据更新
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened)
    eventMgr:AddListener(EventType.Dungeon_MainLine_Update, OnMainLineUpdate)
    eventMgr:AddListener(EventType.Player_Update, OnDailyPanelRefresh)
    eventMgr:AddListener(EventType.Exercise_Update, OnExerciseRefresh)
    --new
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, DailyNewRefresh)
    --限时多倍
    eventMgr:AddListener(EventType.Section_Daily_Double_Update, OnDoubleRefresh)
    eventMgr:AddListener(EventType.Dungeon_Double_Update, OnDoubleRefresh)
    --red
    eventMgr:AddListener(EventType.ExerciseL_New, CheckExceriseRed)
    eventMgr:AddListener(EventType.Loading_Complete, CheckModelOpen) --检测功能开启
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedRefresh)
    eventMgr:AddListener(EventType.Guide_Complete,OnGuideComplete)
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask") 

    layout1 = ComUtil.GetCom(sv1, "UIInfinite")
    layout1:Init("UIs/Section/SectionMainLineItem", LayoutCallBack1, true)

    layout2 = ComUtil.GetCom(sv2, "UIInfinite")
    layout2:Init("UIs/Section/SectionDailyItemL1", LayoutCallBack2, true)

    layout3 = ComUtil.GetCom(sv3, "UIInfinite")
    layout3:Init("UIs/Section/SectionDailyItemL2", LayoutCallBack3, true)


    -- layout4 = ComUtil.GetCom(sv5, "UIInfinite")
    -- layout4:Init("UIs/Section/SectionActivityItem2", LayoutCallBack4, true)

    InitAnim()

    btnCanvasGroup = ComUtil.GetCom(btnEnter,"CanvasGroup")
    
    CSAPI.SetGOActive(clickMask, false)
    CSAPI.SetGOActive(doubleMask, false)
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = mainLineDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ClickMainLineItem)
        local _idx = index - 1
        _idx = index == 1 and #mainLineDatas - 2 or _idx
        _idx = index == #mainLineDatas and 1 or _idx
        lua.SetTitleIdx(_idx)
        local fakeType = 0 --在首位或者尾位
        fakeType = index == 1 and 1 or fakeType
        fakeType = index == #mainLineDatas and 2 or fakeType
        local elseData = {fakeType = fakeType}
        lua.Refresh(_data, elseData)
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = dailyDatasL1[index]
        lua.SetIndex(index)
        lua.SetClickCB(ClickDailyItemL1)  
        lua.Refresh(_data:GetDailyType())
        lua.SetSelect(currDailyIndexL1 == index,true)
    end
end

function LayoutCallBack3(index)
    local lua = layout3:GetItemLua(index)
    if (lua) then
        local _data = dailyDatasL2[index]
        lua.SetIndex(index)
        lua.SetClickCB(ClickDailyItemL2)  
        lua.SetSelect(currDailyIndexL2 == index,true)     
        lua.Refresh(_data)
    end
end

function LayoutCallBack4(index)
    local lua = layout4:GetItemLua(index)
    if (lua) then
        local _data = activityDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ClickActivityItem2)
        lua.Refresh(_data,OnEnterCB2)
    end
end

function OnEnterSound()
    CSAPI.PlayUISound("ui_page_battle");
end

function OnViewClosed(viewKey)
    if viewKey ~= "Section" and viewKey ~= "SpecialGuide" and viewKey ~= "Loading" then
        viewKeys[viewKey] = nil
        if CheckIsTop() then
            SpecialGuideMgr:ApplyShowView(spParent,"Section",SpecialGuideType.Start,lastGuideInfo)
            isStopSP = false
        end
    end
    isClickEnter = false
end

function OnViewOpened(viewKey)
    if viewKey ~= "Section" and viewKey ~= "SpecialGuide" and viewKey ~= "Loading" then
        viewKeys[viewKey] = 1
        if not isStopSP then
            SpecialGuideMgr:ApplyShowView(spParent,"Section",SpecialGuideType.StopAll)
            isStopSP = true 
        end
    end
end

function CheckIsTop()
    local isTop = true
    for k, v in pairs(viewKeys) do
        if v~=nil then
            isTop = false
            break
        end
    end
    return isTop
end

--index:指定章节
function OnMainLineUpdate(index)
    if index and index > 0 then
        currSectionIndex = index
        RefreshMainLineView()
        -- MoveToIndex(index,nil,200)
    else
        InitMainView()
    end
    if mainLinePanel then
        mainLinePanel.RefreshProgass(mainLineDatas[index + 1])
    end
end

function OnDailyPanelRefresh()
    if dailyPanel and currDailyIndexL2 > 0 then
        local lua = layout3:GetItemLua(currDailyIndexL2)
        if lua then
            dailyPanel.Refresh(lua.GetData())
            curDailyItemR = dailyPanel.GetItem(currDailyIndexR)
        end
    end
end
function OnGuideComplete()
    ContinueSpecGuide()
end

function OnInit()
    top = UIUtil:AddTop2("SectionView", topObj, OnClickReturn,nil,{10035});
end

function OnOpen()
    jumpData = data
    local baseScale = {1920, 1080}
	local curScale = CSAPI.GetMainCanvasSize()
    local fit1 =CSAPI.UIFitoffsetTop() and -CSAPI.UIFitoffsetTop() or 0
    local fit2 = CSAPI.UIFoffsetBottom() and -CSAPI.UIFoffsetBottom() or 0
    offset.x =  (curScale[0] - baseScale[1] + fit1 + fit2)/2
    offset.y = (curScale[1] - baseScale[2])/2 

    InitViewInfo()
    InitPanel()
    -- InitInfo() -- 右侧弹窗
    SetRed()

    if jumpData and jumpData.type then
        isViewJump = jumpData.isJump
        isJump = true
        JumpToView(jumpData)
        return
    end
    curState = 3
    ShowPanel()
end

function Update()
    if animTime > 0 then
        isAnim = true
        animTime = animTime - Time.deltaTime
    else
        isAnim = false
    end

    CSAPI.SetGOActive(clickMask, isAnim)

    if currType == 1 and mainLineDatas and #mainLineDatas > 0 then      
        local contentX = CSAPI.GetAnchor(content1) 
        UpdateItemAngle(contentX)
        UpdatePrograss(contentX)      
    end 

    if currType == 4 and items4 and #items4 > 0 then
        local contentX = CSAPI.GetAnchor(content4)      
        if contentX < 380 then           
            UpdateItemScale(math.abs(contentX))
            UpdateItemState(contentX)
        end
    end

    UpdateCheckSpecGuide()
    
    if isAnim then
        return
    end

    ShowDailyLine()
end

-- 初始化移动百分比 1.主页 2.次级页面 3以上.衍生页面
function InitViewInfo()
    viewInfo.Main = {{x= 0,y = -168},{x = 0,y = 0}}
    viewInfo.Daily = {{x = 270,y = 0}, {x = 0,y = 0}, {x = 178,y = 0}, {x = -660,y = 0}}
    viewInfo.Exercise = {{x=-270,y = 0},{x = 0,y = 0}}
    viewInfo.Activity = {{x=0,y=142},{x = 0,y = -749.5}}
end

function JumpToView(_data)
    if CSAPI.IsViewOpen("DungeonDetail") then
        local viewGO = CSAPI.GetView("DungeonDetail")
        local viewLua = ComUtil.GetLuaTable(viewGO)
        viewLua.CloseView()
    end
    
    if _data.type and _data.type == currType then    
        return
    end 
    
    if itemInfo and itemInfo.IsShow() then
        itemInfo.Show()
    end

    local goNames = {"SectionTypeItem1", "SectionTypeItem2", "SectionTypeItem3", "SectionTypeItem4"}
    OnClickTab(this[goNames[_data.type]].transform:GetChild(1).gameObject)
    
end

------------------------------------初始化-----------------------------------
-- 初始化界面
function InitPanel()
    InitMainView()
    InitDailyView()
    InitExerciseView()
    InitActivityView()
end

-- 初始化主线界面
function InitMainView()
    if not mainLinePanel then
        ResUtil:CreateUIGOAsync("Section/SectionMainLineView", mainLineNode, function(go)
            mainLinePanel = ComUtil.GetLuaTable(go)
            CSAPI.SetGOActive(go, false)
        end)
    end

    --追踪最新章节
    currSectionIndex = 1
    local allSectionDatas = DungeonMgr:GetAllSectionDatas()
    if allSectionDatas then
        for k, v in pairs(allSectionDatas) do
            if v:GetSectionType() == SectionType.MainLine then
                local hardLv = DungeonMgr:GetDungeonHardLv(v:GetID())
                if v:GetState(hardLv) > 0 then
                    currSectionIndex = currSectionIndex > v:GetID() and currSectionIndex or v:GetID()
                end               
            end
        end
    end

    RefreshMainLineView()
end

function RefreshMainLineView()
    --datas
    mainLineDatas = {}
    local mainLineCfgs = Cfgs.Section:GetGroup(SectionType.MainLine)
    if mainLineCfgs then
        for _, cfg in pairs(mainLineCfgs) do
            local sectionData = DungeonMgr:GetSectionData(cfg.id)
            if sectionData and sectionData:GetOpenState() > -2 then
                table.insert(mainLineDatas, sectionData)
            end
        end
    end
    table.sort(mainLineDatas, function(a, b)
        return a:GetID() < b:GetID()
    end)

    --用前后数据填充当做跳转按钮
    local firstData = mainLineDatas[1]
    local lastData = mainLineDatas[#mainLineDatas]
    table.insert(mainLineDatas,1,lastData)
    table.insert(mainLineDatas,firstData)
    
    if not IsNil(node1) and node1.gameObject.activeSelf then
        if currSectionIndex > 0 then
            layout1:IEShowList(#mainLineDatas, nil, currSectionIndex + 1)
            currSectionIndex = 0
        else
            layout1:IEShowList(#mainLineDatas)
        end
    end
end

-- 初始化日常界面
function InitDailyView()
    -- OnMaskRefresh(false)

    if not dailyPanel then
        ResUtil:CreateUIGOAsync("Section/SectionDailyView", dailyNode, function(go)
            dailyPanel = ComUtil.GetLuaTable(go)
            dailyPanel.SetClickCB(ClickDailyItemR)
            -- dailyPanel.SetDoubleCB(OnMaskRefresh)
            CSAPI.SetGOActive(go, false)
        end)
    end

    -- datas
    SetDailyDatas()
    SetDailyDatasL1()

    --point
    if #dailyDatasL1 > 0 then
        local d = #dailyDatasL1 > 1 and 496 / (#dailyDatasL1 - 1) or 0
        local idx = 1
        for i = 1, #dailyDatasL1 do
            ResUtil:CreateUIGOAsync("Section/SectionDailyPoint", pointParent1,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetSelect(false)
                lua.SetPos(-d * (i - 1))
                table.insert(dailyPoints, lua)
            end)
        end
    end 
end

function SetDailyDatas()
    dailyDatas = {}
    local dailyCfgs = Cfgs.Section:GetGroup(SectionType.Daily)
    if dailyCfgs then
        for _, cfg in pairs(dailyCfgs) do
            local sectionData = DungeonMgr:GetSectionData(cfg.id)
            if sectionData then
                local type = sectionData:GetDailyType()
                if type then
                    dailyDatas[type] = dailyDatas[type] or {}
                    table.insert(dailyDatas[type], sectionData)
                end
            end
        end
    end    

    for k, v in pairs(dailyDatas) do --排序
        table.sort(v,function (a,b)
            if a:GetOpen() == b:GetOpen() then
                if a:GetOpenState() == b:GetOpenState() then
                    return a:GetID() < b:GetID()
                else
                    if not a:GetOpen() then
                        return a:GetOpenState() < b:GetOpenState()
                    else
                        return a:GetOpenState() > b:GetOpenState()
                    end
                end
            else
                return a:GetOpen()
            end
        end)
    end
end

function SetDailyDatasL1()
    dailyDatasL1 = {}
    if dailyDatas then
        local lastType = nil
        for k, v in pairs(dailyDatas) do
            if lastType ~= k then
                table.insert(dailyDatasL1,v[1])
                lastType = k
            end
        end
    end

    -- table.sort(dailyDatasL1, function(a, b)
    --     if a:GetOpen() == b:GetOpen() then
    --         return a:GetCfg().pos < b:GetCfg().pos
    --     else
    --         return a:GetOpen()
    --     end
    -- end)

    table.sort(dailyDatasL1, function(a, b)
        return a:GetDailyType() < b:GetDailyType()
    end)
    
    --jump
    local _index = 0
    if jumpData and jumpData.type == SectionType.Daily then
        local sectionData = DungeonMgr:GetSectionData(jumpData.group)
        if sectionData then
            for k, v in ipairs(dailyDatasL1) do
                if  v:GetDailyType() == sectionData:GetDailyType() then
                    _index = k
                    break
                end
            end
        end
    end

    if node2.gameObject.activeSelf then
        layout2:IEShowList(#dailyDatasL1, nil, _index)
    end
end

function SetDailyDatasL2()
    dailyDatasL2 = {}
    if dailyDatasL1 and dailyDatasL1[currDailyIndexL1] then
        local sectionData = dailyDatasL1[currDailyIndexL1]
        if sectionData and dailyDatas and dailyDatas[sectionData:GetDailyType()] then
            dailyDatasL2 = dailyDatas[sectionData:GetDailyType()]
        end
    end

    --jump
    local _index = 0
    if jumpData and jumpData.type == SectionType.Daily then
        for k, v in ipairs(dailyDatasL2) do
            if  v:GetID() == jumpData.group then
                _index = k
                break
            end
        end
    end

    if node2.gameObject.activeSelf then
        layout3:IEShowList(#dailyDatasL2, nil, _index)
    end
end

-- 初始化军演界面
function InitExerciseView()
    if not exercisePanel then
        ResUtil:CreateUIGOAsync("Section/SectionExerciseView",exerciseNode,function (go)
            exercisePanel = ComUtil.GetLuaTable(go)
            exercisePanel.SetClickCB(OnExerciseChange)
            exercisePanel.Refresh()
            if currIndex < 2 or currType ~= 3 then
                CSAPI.SetGOActive(exerciseNode, false)
            end
        end)
    end
end

-- 初始化活动界面
function InitActivityView()
    -- datas
    RefreshActivityDatas()

    SetActivityItemNums()

    if items4 and #items4 > 0 then
        curActivityItem1 =items4[1] 
    end
end

------------------------------------主页-----------------------------------
function OnClickTab(child)
    if isViewDrop or (not child) then
        return  
    end
    local go = child.transform.parent.gameObject
    if go then
        local index = -1;
        local goNames = {"SectionTypeItem1", "SectionTypeItem2", "SectionTypeItem3", "SectionTypeItem4"}
        for idx, name in ipairs(goNames) do
            if go.name == name then
                index = idx
                break
            end
        end
        if index > 0 then
            if index == 3 and not isPvpRet then
                ArmyProto:GetSelfPracticeInfo()
            end
            currIndex = 2
            curState = 1
            ShowPanel(index)
        else
            LogError("点击了错误的按钮")
        end
    end
end

-- 1.主线 2.日常 3.军演 4.活动
function ShowPanel(type)
    currType = type
    local isShowAll = currIndex == 1
    if isShowAll then
        ShowMenuPanel()
    end
    if type then
        CSAPI.LoadImg(titleIcon,"UIs/Section/icon_" .. type ..".png", true, nil, true)
        LanguageMgr:SetText(txt_title, titleIds[type])
    end
    local nodeNames = {"node1", "node2", "node3", "node4"}
    local funcs = {ShowMainPanel, ShowDailyPanel, ShowExercisePanel, ShowActivityPanel}
    for i, name in ipairs(nodeNames) do
        if currIndex == 1 then
            CSAPI.SetGOActive(this[name].gameObject, true)
        end       
        if not rects[i] then
            rects[i] = ComUtil.GetCom(this[name].gameObject,"RectTransform")
        end
        if isShowAll or type == i then
            funcs[i]()
        end
    end

    if isJump then
        JumpAnim(type)
    else
        ShowAnim(type)
    end

    curState = 0

    --top
    local ids = {}
    if type == 2 and currIndex > 1 then --只有每日副本才会全显示
        --ids = {ITEM_ID.DIAMOND, ITEM_ID.GOLD, ITEM_ID.Hot}
        ids = {{ITEM_ID.DIAMOND,140001}, {ITEM_ID.GOLD,140014}, {ITEM_ID.Hot,140010}}
    else
        --ids = {nil, nil, ITEM_ID.Hot}
        ids = {{ITEM_ID.Hot,140010}}
    end
    if top then
        top.SetMoney(ids)   -- 需要加跳转id todo 
    end

    --question
    SetQuestion()

    isViewDrop = false

    --特殊引导
    CheckSpecGuide()
end

function ShowMenuPanel()
    --title
    SetTitle(false)

    CSAPI.SetLocalPos(moveNode,0,0)
    DailyDoubleRefresh()
end

function SetTitle(isShow,parent,delay)
    if isShow and currIndex ~= 1 then
        SetTitleAction(function ()
            CSAPI.SetParent(titleObj, parent)
            CSAPI.SetGOActive(titleObj,true)
            CSAPI.SetGOActive(titleAction,true)
        end,delay)
    else
        CSAPI.SetGOActive(titleObj, false)
        CSAPI.SetGOActive(titleAction, false)
    end
end

------------------------------------主线-----------------------------------
function ShowMainPanel()
    local pType = PivotType.Center 
    if currIndex == 1 then
        pType = PivotType.Down
    end

    -- move
    if viewInfo.Main == nil then
        InitViewInfo()
    end
    MoveTo(viewInfo.Main[currIndex], SectionViewType.MainLine, pType, 0)
    
    if currIndex == 1 then
        -- scale
        CSAPI.SetScale(sv1, 0.75, 0.75, 1)
    else
        --title
        SetTitle(true,mainLineNode,350)

        --新手引导
        EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "section_mainLine");
    end

    if mainLinePanel then
        CSAPI.SetGOActive(mainLinePanel.gameObject,currIndex > 1)
    end

    if mainLineDatas and #mainLineDatas > 0 then --返回主页复原旋转和大小
        for i, v in ipairs(mainLineDatas) do
            local lua = layout1:GetItemLua(i)
            if lua then
                 if currIndex == 1 then
                    lua.Init()
                    lua.ShowRed(false)
                 else
                    lua.ShowRed(true)
                 end
            end
        end
    end

    --mask
    CSAPI.SetGOActive(mask1,currIndex == 2)
    CSAPI.SetGOActive(mask2,currIndex == 2)

end

function ClickMainLineItem(item)
    if isClickEnter then
        return
    end
    isClickEnter = true
    MoveToIndex(item.GetIndex() - 1,function ()
        local id = item.GetID()
        CSAPI.OpenView("Dungeon", {
            id = id
        });
    end,200)
end

function UpdateItemAngle(x)
    for i, v in ipairs(mainLineDatas) do
        local lua = layout1:GetItemLua(i)
        if lua and lua.gameObject.activeSelf then
            local centerCount = -x + 602
            lua.SetAngle(centerCount)               
        end
    end
end

function UpdatePrograss(x)
    local idx = 2
    for i = 2, #mainLineDatas - 1 do --剔除前后两个跳转
        local posX = 0
        if not itemPos1[i - 1] then
            posX = (i-2) * 572
            itemPos1[i - 1] = posX
        else
            posX = itemPos1[i-1]
        end
        if posX + x >= -286 and posX + x < 286 then
            idx = i
            break
        end
    end
    if mainLinePanel and lastPrograssIdx ~= idx then
        mainLinePanel.RefreshProgass(mainLineDatas[idx])
        lastPrograssIdx = idx
    end
end

------------------------------------日常-----------------------------------
function ShowDailyPanel()
    local pType = PivotType.Center  
    local offsetX = -offset.x
    if currIndex == 1 then
        pType = PivotType.Right
        offsetX = 0
        RecycleLines()
    elseif currIndex > 2  then
        pType = PivotType.Left
        -- offsetX = offset.x
        offsetX = 0
    end

    -- move
    if curState > 0 then
        if viewInfo.Daily == nil then
            InitViewInfo()
        end
        MoveTo(viewInfo.Daily[currIndex], SectionViewType.Daily, pType, offsetX)    
        CSAPI.SetAnchor(dailyPanel.selectObj, offset.x + 920 , 0)  
        CSAPI.SetAnchor(sv3, offset.x + 310, -6.5)
    end

    -- scale
    if currIndex == 1 then
        CSAPI.SetScale(sv2, 0.7, 0.7, 1)
    else --刷新配置
        ConfigChecker:CfgDupDropCntAdd(Cfgs.CfgDupDropCntAdd:GetAll())
    end

    layout2:UpdateList()
    layout3:UpdateList()
    
    --panel
    if dailyPanel then
        CSAPI.SetGOActive(dailyPanel.gameObject,currIndex > 1)
    else
        LogError("DailyPanel为Nil")
    end

    if curState == 2 then --后退
        BackDailyPanel()
    end

    lastPosY= {0,0,0}

    DailyNewRefresh()
end

--次级界面
function ShowChildDaily()
    if currDailyIndexL1 > 0 then
        CSAPI.SetGOActive(sv3,true)
        SetDailyDatasL2()
    else
        layout3:UpdateList()
        CSAPI.SetGOActive(sv3,false)
    end
    -- CSAPI.SetGOActive(sv3, currDailyIndexL1 > 0)
end

function ShowChildDailyAnim()
    if dailyDatasL2 then
        for i, v in ipairs(dailyDatasL2) do
            local lua = layout3:GetItemLua(i)
            if lua then
                lua.PlayAnim()
            end
        end
    end
end

--返回
function BackDailyPanel()
    if currIndex == 3 then
        if itemInfo and itemInfo.IsShow() then
            if itemInfo then
                itemInfo.Show()            
            end
            if curDailyItemR then
                curDailyItemR.SetSelect(false)
                curDailyItemR= nil
                currDailyIndexR = 0
            end
            ShowLineAnim()
        end  
    elseif currIndex == 2 then
        if dailyPanel and dailyPanel.IsSelect() then
            dailyPanel.SetSelect(false)
            SetCurrDailyL2()
            ShowLineAnim()
        else
            if currDailyIndexL1 > 0 then
                SetCurrDailyL1()
                ShowChildDaily()
                SetDailyLine()
            end
        end
    elseif currIndex == 1 then
        SetCurrDailyL1()
        ShowChildDaily()
    end
end  

--实时跟踪线段生成及位置
function ShowDailyLine(isShow)
    if currType == 2 and dailyPanel then
        local y1,y2,y3,y4,y5,y6,x = 0,0,0,0,0,0,0
        if currDailyIndexL1 > 0 then
            local lua = layout2:GetItemLua(currDailyIndexL1)
            if lua then
                x,y1 = CSAPI.GetAnchor(lua.gameObject)
            end
            x,y2 = CSAPI.GetAnchor(Content2.gameObject)
        end
        if currDailyIndexL2 > 0 then
            local lua = layout3:GetItemLua(currDailyIndexL2)
            if lua then
                x,y3 = CSAPI.GetAnchor(lua.gameObject)
            end
            x,y4 = CSAPI.GetAnchor(Content3.gameObject)
        end
        if curDailyItemR then
            x,y5 = CSAPI.GetAnchor(curDailyItemR.gameObject)
            x,y6 = CSAPI.GetAnchor(dailyPanel.Content.gameObject)
        end
        if isShow or math.floor(y1+y2)  ~= lastPosY[1] or math.floor(y3+y4) ~= lastPosY[2] or math.floor(y5+y6) ~= lastPosY[3] then  
            lastPosY[1] = math.floor(y1+y2)
            lastPosY[2] = math.floor(y3+y4)
            lastPosY[3] = math.floor(y5+y6)
            SetDailyLine()
        end
    end
end

function SetDailyLine()        
    local count = SettingMgr:GetScreenCount() --屏幕收缩值
    local offsetX = -offset.x
    for i = 1, 3 do
        local line = nil
        if lineItems[i] then
            line = lineItems[i]
        else
            line = GetLine(lineParent2)
            table.insert(lineItems,line)
        end
        if i == 1 then
            if currDailyIndexL1 > 0 then
                --左右坐标初始位置
                local pos1,pos2 ={133 ,347.5},{300 - offsetX , 347.5}
                --pos1
                local _,contentY1 = CSAPI.GetAnchor(Content2)
                local lIndex = currDailyIndexL1
                local offsetY1 = (202 + 45) * lIndex - (202/2 + 45) - contentY1
                pos1[2] = pos1[2] - offsetY1

                --pos2
                local _,contentY2 = CSAPI.GetAnchor(Content3)
                local rIndex = currDailyIndexL2 > 0 and currDailyIndexL2 or 1
                local offsetY2 = (145 + 17) * rIndex - (145/2 + 17) - contentY2
                pos2[2] = pos2[2] - offsetY2

                line.Refresh(pos1,pos2)
            else
                CSAPI.SetGOActive(line.gameObject,false) 
            end 
        elseif i == 2 then  
            if currDailyIndexL2 > 0 then
                local pos1,pos2 ={947 - offsetX ,347.5},{1212 - offsetX, 170}

                --pos1
                local _,contentY1 = CSAPI.GetAnchor(Content3)
                local lIndex = currDailyIndexL2
                local offsetY1 = (145 + 17) * lIndex - (145/2 + 17) - contentY1
                pos1[2] = pos1[2] - offsetY1

                 --pos2
                local _,contentY2 = CSAPI.GetAnchor(dailyPanel.Content)
                local rIndex = currIndex < 4 and 1 or curDailyItemR.GetIndex()
                local offsetY2 = (93 + 1) * rIndex - (93/2 + 1) - contentY2
                pos2[2] = pos2[2] - offsetY2

                line.Refresh(pos1,pos2)
            else
                CSAPI.SetGOActive(line.gameObject,false) 
            end
        else
            if curDailyItemR then
                local pos1,pos2 ={1697 - offsetX ,170},{1925 - (offsetX + count) * 2, 375}
                --pos1
                local _,contentY1 = CSAPI.GetAnchor(dailyPanel.Content)
                local lIndex = curDailyItemR.GetIndex()
                local offsetY1 = (93 + 1) * lIndex - (93/2 + 1) - contentY1
                pos1[2] = pos1[2] - offsetY1

                line.Refresh(pos1,pos2) --pos2位置固定
            else
                CSAPI.SetGOActive(line.gameObject, false)
            end
        end
    end
end

function ClickDailyItemL1(item)
    if currIndex >= 2 and currDailyIndexL1 == item.GetIndex()  then
        return
    end
    SetCurrDailyL1(item)
    ShowChildDaily()
    ShowChildDailyAnim()
    ShowLineAnim()

    if currDailyIndexL2 > 0 and dailyPanel then
        OnClickBack()
    end
end

function SetCurrDailyL1(item)
    if currDailyIndexL1 > 0 then
        local lua = layout2:GetItemLua(currDailyIndexL1)
        if lua then
            lua.SetSelect(false)
        end 
        SetDailyPointSelect(currDailyIndexL1,false)
    end

    if item then
        currDailyIndexL1 = item.GetIndex()
        item.SetSelect(true)
        SetDailyPointSelect(currDailyIndexL1,true)
    else
        currDailyIndexL1 = 0
    end  
end

function SetDailyPointSelect(idx,b)
    if dailyPoints and dailyPoints[idx] then
        dailyPoints[idx].SetSelect(b)
    end
end

function ClickDailyItemL2(item)
    if currDailyIndexL2 == item.GetIndex()  then
        return
    end

    if not dailyPanel then -- 未加载完无法点击
        return
    end

    SetCurrDailyL2(item)

    curState = currIndex == 2 and 1 or 0
    if curState > 0 then
        currIndex = 3
    end
    ShowDailyPanel()
    curState = 0

    if dailyPanel then
        dailyPanel.SetSelect(true)
        dailyPanel.Refresh(item.GetData())
        dailyPanel.PlayAnim()
        if currIndex == 4 then --特殊切换关卡,清除部分缓存来启动部分动效和未选中
            curDailyItemR = nil
            if itemInfo then
                itemInfo.ClearLastItem()
            end
            dailyPanel.ClickItemByID()
        end
    else
        LogError("DailyPanel为Nil")
    end

    if currIndex ~= 4 then
        ShowLineAnim()
    end

    RefreshItemNew()
end

function RefreshItemNew()
    if currDailyIndexL1 then
        local lua = layout2:GetItemLua(currDailyIndexL1)
        if lua then
            lua.RefreshTag()
        end
    end   
    RedPointMgr:ApplyRefresh()
end

function SetCurrDailyL2(item)
    if currDailyIndexL2 > 0 then
        local lua = layout3:GetItemLua(currDailyIndexL2)
        if lua then
            lua.SetSelect(false)
            lua.SetText()
        end 
    end
    if item then
        currDailyIndexL2 = item.GetIndex()
        item.SetSelect(true)
        item.SetText()
    else
        currDailyIndexL2 = 0
    end  
end

function ClickDailyItemR(item)
    if curDailyItemR == item then
        return
    end
    if curDailyItemR then
        curDailyItemR.SetSelect(false)
    end
    curDailyItemR = item
    curDailyItemR.SetSelect(true)
    currDailyIndexR = curDailyItemR.GetIndex()

    curState = currIndex == 3 and 1 or 0
    currIndex = 4
    ShowDailyPanel()
    curState = 0

    ShowItemInfo(curDailyItemR)
    ShowLineAnim()
end

function JumpToDaily(group,id)
    curState = 1
    currIndex = 2
    currDailyIndexR = 0
    if curDailyItemR then
        curDailyItemR.SetSelect(false)
    end
    curDailyItemR = nil
    SetCurrDailyL2()
    if group then
        local sectionData = DungeonMgr:GetSectionData(group)
        if sectionData then
            currIndex = 3
            for k, v in pairs(dailyDatasL1) do
                if v:GetDailyType() == sectionData:GetDailyType() then
                    local lua1 = layout2:GetItemLua(k)
                    if lua1 then
                        if currDailyIndexL1 ~= lua1.GetIndex() then
                            SetCurrDailyL1(lua1)
                        end
                        ShowChildDaily()
                        FuncUtil:Call(function ()
                            if gameObject then
                                for i, m in ipairs(dailyDatasL2) do
                                    if group == m:GetID() then
                                        local lua2 = layout3:GetItemLua(i)
                                        if lua2 then
                                            if currDailyIndexL2 ~= lua2.GetIndex() then
                                                SetCurrDailyL2(lua2)
                                            end
                                            if dailyPanel then
                                                dailyPanel.SetSelect(true)
                                                dailyPanel.Refresh(lua2.GetData())
                                                if id and DungeonMgr:IsDungeonOpen(id) then
                                                    dailyPanel.ClickItemByID(id)
                                                end
                                            end
                                        end                                       
                                    end
                                end
                                SetDailyLine()
                            end
                        end,nil,100)
                    end
                end
            end
        end
    end
    ShowDailyPanel()
    curState = 0
end
------------------------------------军演-----------------------------------
function OnExerciseRefresh()
    isPvpRet = true
end

function ShowExercisePanel()
    local pType = PivotType.Center 
    if currIndex == 1 then
        pType = PivotType.Left
    end

    -- move
    MoveTo(viewInfo.Exercise[currIndex], SectionViewType.Exercise, pType, 0)

    if currIndex == 2 and curState == 1 then
        --title
        SetTitle(true,exerciseNode,350)
        if exercisePanel and isPvpRet then
            exercisePanel.Refresh()
        end
    end
    
    --view
    CSAPI.SetGOActive(exerciseNode, currIndex > 1)
end

function OnExerciseChange(index)
    ResUtil.SectionExercise:Load(imgExercise,"bg" .. index)
end
------------------------------------活动-----------------------------------
function RefreshActivityDatas()
    activityDatas2 = {}
    local dataList = DungeonActivityMgr:GetSectionDatasByType(true)
    local logStrs = {}
    local stateStr ={"未在活动开放时间内","","未达成开启条件","已开启"}
    for _, _type in pairs(SectionActivityType) do
        local typeDatas = dataList[_type]           
        if typeDatas and #typeDatas > 0 then
            for i, v in ipairs(typeDatas) do
                table.insert(logStrs,string.format("名字：%s, id：%s, 状态：%s",v:GetName(),v:GetID(),stateStr[v:GetOpenState()+3]))
                if v:GetOpenState() > -1 or v:IsResident() then
                    local _data = {
                        data = v,
                        type = _type,
                        chaperName = v:GetChaperName(),
                        pos = v:GetCfg().pos --顺序
                    }
                    if _type == SectionActivityType.Tower and TowerMgr:IsTowerMax() then
                        _data.pos = g_DioblosClearLevelSorting or 15
                    end
                    table.insert(activityDatas2,_data)
                end
            end
        end
    end
    LogTable(logStrs,"活动信息")
    if #activityDatas2 > 0 then
        table.sort(activityDatas2, function(a, b)      
            local pos1 = a.pos or 99
            local pos2 = b.pos or 99
            if pos1 == pos2 then
                local isResident1 = a.data:IsResident()
                local isResident2 = b.data:IsResident()
                if isResident1 == isResident2 then
                    if isResident1 then
                        return pos1 < pos2
                    else
                        local info1 = a.data:GetOpenInfo()
                        local info2 = b.data:GetOpenInfo()
                        if info1:GetStartTime() == info2:GetStartTime() then
                            return pos1 < pos2
                        else
                            return info1:GetStartTime() > info2:GetStartTime()
                        end
                    end
                else
                    return not isResident1
                end
            else
                return pos1 < pos2
            end
        end)
    end

    logStrs = {}
    for i, v in ipairs(activityDatas2) do
        table.insert(logStrs,string.format("ID:%s，Name:%s，Pos:%s，活动开始时间：%s",v.data:GetID(),v.data:GetName(),v.pos,v.data:IsResident() and "常驻不显示时间" or TimeUtil:GetTimeStr2(v.data:GetOpenInfo():GetStartTime(),true)))
    end
    LogTable(logStrs,"活动副本排序")

    RefreshActivityItems()
end

function RefreshActivityItems()
    items4 = ItemUtil.AddItems("Section/SectionActivityItem1", items4, activityDatas2, content4, ClickActivityItem1,1, OnEnterCB1)
end

function ShowActivityPanel()
    local pType = PivotType.Center 
    if currIndex == 1 then
        pType = PivotType.Up
    end
    if currIndex == 2 then
        RefreshActivityItems()
    end

    -- move
    CSAPI.SetLocalPos(activityNode,0,0)
    if viewInfo.Activity == nil then
        InitViewInfo()
    end
    MoveTo(viewInfo.Activity[currIndex], SectionViewType.Activity, pType, 0)

    if items4 and #items4>0 then
        for i, v in ipairs(items4) do
            if currIndex == 1 then
                v.SetScale(0.9)      
                v.SetSelect(false)         
            end
            v.ShowDowm(currIndex == 1, curActivityItem1 and curActivityItem1 == v)
        end
    end
    
    if currIndex == 1 then
        -- scale
        CSAPI.SetScale(sv4,  0.65,  0.65, 1)

        CSAPI.SetGOActive(imgObj4,true) 
        CSAPI.SetGOActive(imgObj5,false)
        -- CSAPI.SetGOActive(btnEnter,false)
        CSAPI.SetGOActive(activtiySecondView,false)

        RefreshItemNums()
        curActivityItem1 = nil
    end
  
    --title
    SetTitle(true,activityNode,350)
end

function OnActivityActionPlay()
    CSAPI.SetGOActive(imgObj4,false) 
    CSAPI.SetGOActive(imgObj5,true)
    -- CSAPI.SetGOActive(btnEnter,true)
end

function SetActivityItemNums()
    if items4 and #items4 > 0 then
        itemNums = {}
        for i = 1, #items4 do
            local go = nil
            if i == 1 then
                go = itemNum.gameObject
            else
                go = CSAPI.CloneGO(itemNum.gameObject, imgObj4.transform)
            end            
            local isOpen = true
            CSAPI.SetGOActive(go.transform:GetChild(0).gameObject,isOpen)
            CSAPI.SetGOActive(go.transform:GetChild(1).gameObject,not isOpen)
            CSAPI.SetGOActive(go.transform:GetChild(2).gameObject,false)
            table.insert(itemNums,go)
        end
    end
end

function RefreshItemNums()
    if itemNums and #itemNums>0 then
        for k, v in ipairs(items4) do
            local numGo = itemNums[k]
            if numGo then
                local isOpen = v.GetOpen()
                local isSel = curActivityItem1 and v == curActivityItem1
                CSAPI.SetGOActive(numGo.transform:GetChild(0).gameObject,isOpen and not isSel)
                CSAPI.SetGOActive(numGo.transform:GetChild(1).gameObject,not isOpen)
                CSAPI.SetGOActive(numGo.transform:GetChild(2).gameObject,isOpen and isSel)
            end          
        end
    end
end

function OnEnterCB1(item)
    local sectionData = item.GetData().data
    if IsNil(sectionData) then
        LogError("缺少章节数据!!!")
        return 
    end

    if not item:GetOpen() then
        local _,lockStr = sectionData:GetOpen()
        Tips.ShowTips(lockStr)
        isClickEnter = false
        return
    end

    local path = sectionData:GetPath() or ""
    if path == "" then
        LogError("缺少界面路径!!!" .. sectionData:GetCfg().id)
        return
    end
    if sectionData:GetType() == SectionActivityType.Tower or sectionData:GetType() == SectionActivityType.NewTower then
        CSAPI.OpenView(path)
    elseif sectionData:GetType() == SectionActivityType.Rogue then
        CSAPI.OpenView("RogueMain")
    elseif sectionData:GetType() == SectionActivityType.Trials then
        CSAPI.OpenView("TrialsMenu")
    else
        CSAPI.OpenView(path, {id = item.GetID()})
    end
end

function OnEnterCB2(item)
    if item.GetData():GetType() == SectionActivityType.Tower then
        CSAPI.OpenView("DungeonTower",{id = item.GetData():GetID()})
    end
end

function ClickActivityItem1(item)
    if isClickEnter then
        return
    end
    isClickEnter = true
    local time = 100
    local delayTime = 200
    if curActivityItem1 then
        time = math.abs(item.index - curActivityItem1.index) * time + 1
        delayTime = math.abs(item.index - curActivityItem1.index) > 0 and delayTime or 1
    end
    MoveToIndex(item.index,function ()
        FuncUtil:Call(function ()
            if gameObject then
                OnEnterCB1(item)
            end
        end, nil, delayTime)
    end, time)
end

function ClickActivityItem2(item)
    if curActivityItem2 then
        curActivityItem2.SetSelect(false)
    end

    curActivityItem2 = item
    curActivityItem2.SetSelect(true)
end

function UpdateItemState(x)
    local index = GetCurrIndex(math.abs(x))

    UpdateArrowActive(index) --更新箭头
    MoveToCenter(x, index, 10) --居中更新

    if isAnim then --播放动效
        return
    end
    --选中更新
    if IsNearByIndex(x, 100) then --判断距离，在范围内为选中
        if items4[index] and curActivityItem1 ~= items4[index]then
            if curActivityItem1 then
                curActivityItem1.SetSelect(false)
            end
            curActivityItem1 = items4[index]
            curActivityItem1.SetSelect(true)
            -- hasSecond = curActivityItem1.HasSecond()
            -- ShowSecondPanel(hasSecond and curActivityItem1 or nil)
        end
    else
        if curActivityItem1 then
            curActivityItem1.SetSelect(false)
        end
        curActivityItem1 = nil
        -- curActivityItem2 = nil
        -- ShowSecondPanel()
    end

    UpdateBtnState() --按钮状态更新
end

function ShowSecondPanel(item)
    CSAPI.SetGOActive(activtiySecondView, item ~= nil)
    if item then
        PlayAnim(200)
        activityDatas = item.GetData().data
        table.sort(activityDatas,function(a, b)
            return a.cfg.id < b.cfg.id
        end)

        layout4:IEShowList(#activityDatas)

        if not curActivityItem2 then
            local lua = layout4:GetItemLua(1)
            if lua then
                lua.OnClick()
            end
        end
    end
end

function UpdateBtnState()
    if curActivityItem1 then
        if hasSecond then
            btnCanvasGroup.alpha = curActivityItem2~=nil and 1 or 0.5
            return
        end
        btnCanvasGroup.alpha = 1
    else
        btnCanvasGroup.alpha = 0.5
    end
end

function UpdateItemScale(x)
    for i, v in ipairs(items4) do
        local itemX = v.GetItemX()
        local scale = 0.85
        local center = (381 * (i - 1))
        if math.abs(x - center) < 381 then
            scale = 1 - (math.abs(x - center) / 381) * 0.15
        end
        v.SetScale(scale)
    end
end

function UpdateArrowActive(idx)
    CSAPI.SetGOActive(activityArrow1, idx ~= 1)
    CSAPI.SetGOActive(activityArrow2, idx ~= #items4)
end

function OnClickEnter()
    if hasSecond then
        if not curActivityItem2 then
            return
        end
        curActivityItem2.OnClickEnter()
    else
        if not curActivityItem1 then
            return 
        end
        curActivityItem1.OnClickEnter()
    end
end

function OnClickArrowL()
    if curActivityItem1 and curActivityItem1.index - 1 > 0 then
        MoveToIndex(curActivityItem1.index - 1,nil,200)
    end
end

function OnClickArrowR()
    if curActivityItem1 and curActivityItem1.index + 1 <= #items4  then
        MoveToIndex(curActivityItem1.index + 1,nil,200)
    end
end
------------------------------------右侧信息栏-----------------------------------
function ShowItemInfo(item)    
    currItem = curDailyItemR
    if (itemInfo == nil) then --没有则异步创建
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo7", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            CSAPI.SetGOActive(itemInfo.bg, false)
            itemInfo.Show(curDailyItemR.GetCfg(),nil,OnLoadSuccess)
        end)
    else
        itemInfo.Show(curDailyItemR.GetCfg(),nil,OnLoadSuccess)
    end
end

function OnLoadSuccess()
    itemInfo.SetFunc("Button","OnClickEnter",OnBattleEnter)
    itemInfo.AddTeamReplace(true,OnBattleEnter,nil,nil,nil,0,16.5)
    SetInfoItemPos()
end

-- 进入
function OnBattleEnter()
    if (curDailyItemR) then
        EnterNextView(curDailyItemR)
    end
end

function EnterNextView(_item)
    -- if (itemInfo.IsCanAIMove()) then -- 自动寻路
    --     BattleMgr:SetAIMoveState(itemInfo.IsAIMove())
    -- end
    -- DungeonMgr:ShowAIMoveBtn(itemInfo.IsCanAIMove() and itemInfo.IsAIMove())
    -- 进入副本前编队
    if _item.GetCfg() and _item.GetCfg().arrForceTeam ~= nil then -- 强制上阵编队
        CSAPI.OpenView("TeamForceConfirm", {
            dungeonId = _item.GetCfg().id,
            teamNum = _item.GetCfg().teamNum or 1
        })
    else
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = _item.GetCfg().id,
            teamNum = _item.GetCfg().teamNum or 1
        }, TeamConfirmOpenType.Dungeon)
    end
end

function SetInfoItemPos()
    itemInfo.SetPanelPos("Title", 0, 407)
    itemInfo.SetPanelPos("Level", 0, 336)
    itemInfo.SetPanelPos("Target", 23, 298)
    itemInfo.SetPanelPos("Output", 23, -62)
    itemInfo.SetPanelPos("Details", -6, -228)
    itemInfo.SetPanelPos("Button", 6, -433)
    CSAPI.SetRTSize(itemInfo.layout, 579, -200)
end

------------------------------------移动-----------------------------------
--移动位置
function MoveTo(info, type, posType, offsetX)
    if curState <1 then
        return
    end
    local rect = rects[type]
    local x,y = CSAPI.GetLocalPos(rect.gameObject)
    local sizeDelta = rect.sizeDelta
    --pivot 
    local min,max = GetAnchors(posType)
    rect.anchorMin = UnityEngine.Vector2(min.x, min.y)
    rect.anchorMax = UnityEngine.Vector2(max.x, max.y)
    CSAPI.SetLocalPos(rect.gameObject, x, y)

    --pos
    if currIndex == 1 then
        CSAPI.SetAnchor(rect.gameObject, info.x + offsetX, info.y)
    else      
        local x1,y1 = CSAPI.GetAnchor(moveNode)
        local x2,y2 = CSAPI.GetAnchor(rect.gameObject)
        local distanceX = info.x + offsetX - x2
        local distanceY = info.y - y2 
        ActionMoveTo(x1, y1, distanceX, distanceY)
    end
    --1432
end
-- 0-中间 1-上 2-左 3-下 4-右
function GetAnchors(type)
    local min = {x=0.5, y=0.5}
    local max = {x=0.5, y=0.5}
    if type then
        if type == PivotType.Up then
            min.x,min.y = 0.5, 1
            max.x,max.y = 0.5, 1
        elseif type == PivotType.Left then
            min.x,min.y = 0, 0.5
            max.x,max.y = 0, 0.5
        elseif type == PivotType.Down then
            min.x,min.y = 0.5, 0
            max.x,max.y = 0.5, 0
        elseif type == PivotType.Right then
            min.x,min.y = 1, 0.5
            max.x,max.y = 1, 0.5
        end
    end
    return min,max
end

------------------------------------线条-----------------------------------
function GetLine(parent)
    if #linePool > 0 then
        local lua = table.remove(linePool, 1)
        CSAPI.SetParent(lua.gameObject, parent)
        CSAPI.SetGOActive(lua.gameObject, true)
        return lua
    end
    local go = ResUtil:CreateUIGO("Section/SectionLineItem", parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    return lua
end

function RecycleLines()
    if #lineItems >0 then
        for k, v in pairs(lineItems) do
            CSAPI.SetGOActive(v.gameObject, false)
            table.insert(linePool, v)
        end        
    end
    lineItems = {}
end

------------------------------------点击-----------------------------------

function OnClickBack()
    if currType == SectionViewType.Daily and currIndex > 2 then
        currIndex = currIndex - 1
        curState = 2
        ShowDailyPanel()
        curState = 0
        return
    end

    -- BackDailyPanel()
    local backFuncs = {nil, BackDailyPanel, nil, nil}
    local func = backFuncs[currType]
    if func then
        func()
    end
end

function OnClickReturn()  
    if currIndex >= 2 then
        if currIndex == 2 then
            if isViewJump then
                view:Close()
                return
            end
            ActionBack(function ()
                BackPanel()
            end)
        else
            BackPanel()
        end
    else
        view:Close()
    end
end

function BackPanel()
    local _type = currIndex > 2 and currType or nil
    currIndex = currIndex - 1    
    curState = 2    
    ShowPanel(_type)
end

------------------------------------UISV----------------------------------------
--sv移动
function MoveToIndex(idx, cb, time)
    if currType == 1 then
        PlayAnim(time)
        local targetPosX = -(30 + (520 + 52) * idx + 520/2 - 872)
        CSAPI.MoveTo(content1.gameObject, "UI_Local_Move", targetPosX, 0, 0, function ()
            if cb then
                cb()
            end
        end, time / 1000)
    elseif currType == 4 then
        PlayAnim(time)
        local targetPosX = -(381 * (idx - 1))
        CSAPI.MoveTo(content4.gameObject, "UI_Local_Move", targetPosX, 0, 0, function ()
            if cb then
                cb()
            end
        end, time / 1000)
    end   
end

--sv位置检测 x-content位置
function GetCurrIndex(x)
    local index = 0
    if currType == 4 then
        index = math.modf(x / 381) + 1
        local dis = x % 381
        if dis > 381 / 2 then
            index = index + 1
        end
    end
    return index
end

--靠近指定距离 x-content位置,d-指定范围
function IsNearByIndex(x,d)
    if currType == 4 then
        local dis = x % 381
        dis = dis > 381 / 2 and 381 - dis or dis
        if dis < d then
            return true
        end
    end
    return false
end

function OnDropBegin()
    isDrop = true
end

function OnDropEnd()
    isDrop = false
end

function MoveToCenter(x,idx,speed)
    if not isDrop then
        if currType == 4 then
            local targetX = -(381 * (idx - 1))
            if x ~= targetX then
                local contentX = x
                if contentX < targetX then
                    contentX = contentX + speed
                    contentX = contentX >= targetX and targetX or contentX
                elseif contentX > targetX then
                    contentX = contentX - speed
                    contentX = contentX <= targetX and targetX or contentX
                end
                CSAPI.SetAnchor(content4,contentX,0)
            end
        end
    end
end
------------------------------------动效----------------------------------------

function PlayAnim(time,cb)
    animTime = animTime + time / 1000
    FuncUtil:Call(function ()
        if gameObject then
            if cb then
                cb()
            end
        end       
    end,nil,time)
end

function InitAnim()
    moveAction =ComUtil.GetCom(nodeMove,"ActionMoveByCurve")
    menuFade = ComUtil.GetCom(menuAnim,"ActionFade")
    backFade = ComUtil.GetCom(backAnim,"ActionFade")
    fades = {}
    for i = 1, 4 do
        local fade = ComUtil.GetCom(this["nodeAnim" .. i].gameObject, "ActionFade")
        table.insert(fades, fade)
    end
    exerciseFade = ComUtil.GetCom(exerciseFade3, "ActionFade")
    activityFade = ComUtil.GetCom(activityFade1, "ActionFade")
end

function JumpAnim(type)
    if not type then
        ShowAnim()
        return
    end
    CSAPI.SetGOActive(menuView, false)
    CSAPI.SetGOActive(menuAction, false)
    local funcs = {ShowMainLineAnim,ShowDailyAnim,ShowExerciseAnim,ShowActivityAnim}
    local actions = {mainLineAction,dailyAction,exerciseAction,activityAction}
    for k, v in ipairs(funcs) do
        CSAPI.SetGOActive(actions[k].gameObject, false)
        if type ~= k then
            fades[k]:Play(1,0,100,0,function ()
                CSAPI.SetGOActive(this["node" .. k].gameObject,false)
            end)
        else                   
            v()
        end
    end

    PlayAnim(800,function()  
        CSAPI.SetGOActive(blackAciton, false)      
        isJump = false
    end)
end

function ShowAnim(type)  
    local animTime = 500
    if currIndex <3 then       
        ShowMenuAnim(type)          
        local funcs = {ShowMainLineAnim,ShowDailyAnim,ShowExerciseAnim,ShowActivityAnim}
        local actions = {mainLineAction,dailyAction,exerciseAction,activityAction}
        for k, v in ipairs(funcs) do
            CSAPI.SetGOActive(actions[k].gameObject, false)
            if type then
                if type ~= k then
                    fades[k]:Play(1,0,100,0,function ()
                        CSAPI.SetGOActive(this["node" .. k].gameObject,false)
                    end)
                else                   
                    v()
                end
            else
                fades[k]:SetAlpha(1)
            end
        end
        if type ~= nil then
            animTime = 600
        end
    end

    PlayAnim(animTime)
end

function ShowMenuAnim(type)
    local isMenu = type == nil
    CSAPI.SetGOActive(menuAction,isMenu)
    if isMenu then
        ShowAction(blackAciton)
        CSAPI.SetGOActive(menuView,true)
        menuFade:SetAlpha(1)
        exerciseFade:SetAlpha(1)
        MoveDailyItemL()     
    else  
        menuFade.target = this["SectionTypeItem" .. type].gameObject
        menuFade:Play(1,0,100,0)
        if curState == 1 then
            FuncUtil:Call(function ()
                if gameObject then
                    CSAPI.SetGOActive(menuView,false)
                end
            end,0,600)
        end    
    end   
end

function MoveDailyItemL()
    if dailyDatas and #dailyDatas > 0 then
        local index = 1
        for k, v in ipairs(dailyDatas) do
            local lua = layout2:GetItemLua(k)
            if lua then
                lua.PlayMove((index-1) * 50 + 100)
                index = index + 1
            end
        end
    end
end

function ShowMainLineAnim()
    CSAPI.SetGOActive(mainLineAction.gameObject, true)
    if mainLineDatas and #mainLineDatas>0 then
        for i = 1, #mainLineDatas do
            local lua = layout1:GetItemLua(i)
            if lua then
                lua.PlayAction()
            end
        end            
    end
end

function ShowDailyAnim()
    if curState == 1 then
        CSAPI.SetGOActive(dailyAction.gameObject, true)
    end

    -- jump
    if jumpData and jumpData.type == SectionType.Daily then
        JumpToDaily(jumpData.group, jumpData.id)
        jumpData = nil
    end
end

function ShowLineAnim()
    ShowDailyLine(true)
    if lineItems and #lineItems> 0 then    
        PlayAnim(400)       
        if currDailyIndexL1 > 0 then
            CSAPI.SetGOActive(lineItems[1].gameObject,true)
            lineItems[1].PlayAnim()
        end
        if currDailyIndexL2 > 0 then
            CSAPI.SetGOActive(lineItems[2].gameObject,true)
            lineItems[2].PlayAnim()
        end
        if curDailyItemR then
            CSAPI.SetGOActive(lineItems[3].gameObject,true)
            lineItems[3].PlayAnim()
        end     
    end
end

function ShowExerciseAnim()
    CSAPI.SetGOActive(exerciseAction.gameObject, true)
    exerciseFade:Play()
end

function ShowActivityAnim()
    activityFade:Play(1,0,200,0,function ()
        activityFade:SetAlpha(1)
        CSAPI.SetGOActive(activityAction.gameObject, true)

        if items4 and #items4 > 0 then
            for k, v in ipairs(items4) do
                v.PlayAnim()
            end
        end
        OnActivityActionPlay()
    end)
end

function SetTitleAction(cb,delay)
    FuncUtil:Call(function ()
        if gameObject and cb then
            cb()
        end
    end,nil,delay)
end

function ActionMoveTo(x1,y1,x2,y2)
    CSAPI.SetGOActive(clickMask, true)
    moveAction.startPos = UnityEngine.Vector3(x1, y1, 0)
    moveAction.targetPos = UnityEngine.Vector3(x2, y2, 0)
    moveAction:Play(function ()
        CSAPI.SetGOActive(clickMask, false)
    end)
end

function ActionBack(_cb)
    isAnim = true
    backFade:Play(0,1,200,0,function ()
        isAnim = false
        if _cb then
            _cb()
        end
    end)
end

function ShowAction(go)
    if not IsNil(go) then
        CSAPI.SetGOActive(go,false)
        CSAPI.SetGOActive(go,true)
    end
end

------------------------------------拖拽----------------------------------------
local startPosX = 0
local startPosY = 0

function OnDropBegin2(_type)
    if isAnim then
        return
    end
    isViewDrop = false
    startPosX = CS.UnityEngine.Input.mousePosition.x
    startPosY= CS.UnityEngine.Input.mousePosition.y
end

function OnDropEnd2(_type)
    if isAnim then
        return
    end
    _type = _type or SelectType.All
    local posX = CS.UnityEngine.Input.mousePosition.x
    local posY = CS.UnityEngine.Input.mousePosition.y
    local lenX = posX - startPosX
    local lenY = posY - startPosY
    if math.abs(lenX) - math.abs(lenY) > 0 then --左右滑
        if math.abs(lenX) > 100 then --距离限制
            if currIndex > 1 then --返回处理
                if lenX > 0 and currType == 2 then --日常
                    if currIndex <= 2 then
                        OnClickReturn()
                    end
                elseif lenX < 0 and currType == 3 then --军演
                    OnClickReturn()
                end
            else
                if lenX < 0 and (_type == SelectType.All or _type == SelectType.Daily) then --日常
                    ShowDropPanel(2)
                elseif lenX > 0 and (_type == SelectType.All or _type == SelectType.Exercise) then --军演
                    ShowDropPanel(3)
                end
            end
        end
    else --上下滑
        if math.abs(lenY) > 100 then --距离限制
            if currIndex > 1 then --返回处理
                if lenY < 0 and currType == 1 then --主线
                    OnClickReturn()
                elseif lenY > 0 and currType == 4 then --活动
                    OnClickReturn()
                end
            else
                if lenY > 0 and (_type == SelectType.All or _type == SelectType.MainLine) then --主线
                    ShowDropPanel(1)
                elseif lenY < 0 and (_type == SelectType.All or _type == SelectType.Activity) then --活动
                    ShowDropPanel(4)
                end
            end
        end
    end
end

function ShowDropPanel(type)
    if type == 3 and not isPvpRet then
        ArmyProto:GetSelfPracticeInfo()
    end
    currIndex = 2
    curState = 1
    isViewDrop = true
    ShowPanel(type)
end

-- 计算角度
function CountAngle(p1, p2)
    local p = {};
    p.x = p2[1] - p1[1]
    p.y = p2[2] - p1[2]
    local r = math.atan(p.y, p.x) * 180 / math.pi;
    return r;
end

---------------------------------------------red---------------------------------------------
function OnRedRefresh()
    SetRed()
    if currType == 1 then
        RefreshMainLineView()
    elseif currType == 4 then
        RefreshActivityDatas()
    end
end

function SetRed()
    CheckMainLineRed()
    CheckDailyRed()
    CheckExceriseRed()
    CheckActivityRed()
end

function CheckMainLineRed()
    local redData1 = RedPointMgr:GetData(RedPointType.SectionMain)
    UIUtil:SetRedPoint(SectionTypeItem1,redData1 ~= nil,146,26)
end

function CheckDailyRed()
    local isNew = SectionNewUtil:IsDoubleNew()
    if not isNew then
        isNew = SectionNewUtil:IsDailyNew()
    end
    UIUtil:SetNewPoint(SectionTypeItem2,isNew,129,13)
    local redData2= RedPointMgr:GetData(RedPointType.SectionDaily)
    if isNew then
        redData2 = nil
    end
    UIUtil:SetRedPoint(SectionTypeItem2,redData2 ~= nil,146,26)
end

function CheckExceriseRed()
    local isNew = ExerciseMgr:IsExerciseLNew()
    UIUtil:SetNewPoint(SectionTypeItem3,isNew,129,13)
    local redData3= DungeonMgr:IsExerciseRed() and 1 or nil
    if isNew then
        redData3 = nil
    end
    UIUtil:SetRedPoint(SectionTypeItem3,redData3 ~= nil,146,26) 
end

function CheckActivityRed()
    local isNew = DungeonActivityMgr:IsNew()
    UIUtil:SetNewPoint(SectionTypeItem4,isNew,129,13)
    local redData4= RedPointMgr:GetData(RedPointType.SectionActivity)
    if isNew then
        redData4 = nil
    end
    UIUtil:SetRedPoint(SectionTypeItem4,redData4 ~= nil,146,26)
end
---------------------------------------------new---------------------------------------------
function DailyNewRefresh()
    if currIndex > 1 and currType == 2 and SectionNewUtil:IsDoubleNew() then
        SectionNewUtil:RefreshDoubleNew()
        RedPointMgr:ApplyRefresh()
        FuncUtil:Call(function ()
            if gameObject then
                LanguageMgr:ShowTips(8012)
            end   
        end,nil, 600)
    end
    CheckDailyRed()
end
---------------------------------------------limitDouble---------------------------------------------
function OnDoubleRefresh()
    DailyDoubleRefresh()

    if currType == 2 then
        ShowDailyPanel()
    end
end

function DailyDoubleRefresh()
    UIUtil:SetDoublePoint(dailyDouble, IsLimitDouble())
end

function IsLimitDouble()
    if dailyDatas then
        for i, v in pairs(dailyDatas) do
            for k, m in ipairs(v) do
                if DungeonUtil.IsLimitDropAdd(m:GetID()) then
                    return true
                end
            end
        end
    end
    return false
end
---------------------------------------------question------------------------------------------
function SetQuestion()
    if currType == nil then
        CSAPI.SetGOActive(questionParent, false)
        return
    end
    CSAPI.SetGOActive(questionParent, true)
    local quesNames = {"StorySection","DailySection","ExerciseSection","ActivitySection"}

    UIUtil:AddQuestionItem(quesNames[currType], gameObject, questionParent)
end


function CheckModelOpen()
    if (MenuMgr:CheckOpenList()) then
        CSAPI.OpenView("MenuOpen")
    end 
end
---------------------------------------------SpecialGuide------------------------------------------
function CheckSpecGuide()
    if currType and currType == 1 then
        SpecialGuideMgr:ApplyShowView(spParent,"Section",SpecialGuideType.Finish,lastGuideInfo)
    elseif lastGuideInfo then
        SpecialGuideMgr:ApplyShowView(spParent,"Section",SpecialGuideType.Stop,lastGuideInfo)
    end
    lastGuideInfo = {index = currIndex,type = currType}
    SpecialGuideMgr:ApplyShowView(spParent,"Section",SpecialGuideType.Start,lastGuideInfo)
end

function ContinueSpecGuide()
    lastGuideInfo = {index = currIndex,type = currType}
    SpecialGuideMgr:ApplyShowView(spParent,"Section",SpecialGuideType.Start,lastGuideInfo)
end

function UpdateCheckSpecGuide()    
    if currType and currType == 1 and currIndex == 2 then
        if(CS.UnityEngine.Input.GetMouseButtonDown(0)) and not isStopSP then
            SpecialGuideMgr:ApplyShowView(spParent,"Section",SpecialGuideType.FinishOrRefresh,{index = 2,type = 1})
        end
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if isAnim then
        return
    end
    if  top.OnClickBack then
        top.OnClickBack();
        if not UIMask then
            UIMask = CSAPI.GetGlobalGO("UIClickMask")
        end
        CSAPI.SetGOActive(UIMask, false)
    end
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs()
    if not UIMask then
        UIMask = CSAPI.GetGlobalGO("UIClickMask")
    end
    CSAPI.SetGOActive(UIMask, false)
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    bg = nil;
    model = nil;
    modelNode = nil;
    ModelCamera = nil;
    goModelRaw = nil;
    node1 = nil;
    sv = nil;
    btnR = nil;
    btnL = nil;
    itemNode = nil;
    node2 = nil;
    sv2 = nil;
    Content = nil;
    txtWeek = nil;
    SectionTypeItem1 = nil;
    txt_main = nil;
    SectionTypeItem3 = nil;
    txt_pk = nil;
    SectionTypeItem2 = nil;
    txt_day = nil;
    topObj = nil;
    view = nil;
end
----#End#----
