local sectionData = nil
local mapView = nil
local currHardLv = 0
local loadCB = nil -- 检测阶段任务弹窗回调
-- listItem
local currListItem = nil
local listItems = {}
local groupDatas = {}
-- item
local items = nil
local selItem = nil
local itemInfo = nil
-- story
local isStoryFirst = false
-- box
local currStarNum = 0
local sliderObj = nil
local isCanGet = false
local isOpenBoxs = true -- 打开宝箱奖励条件
-- next
local isNextScetion = false
local changeID = nil -- 自跳转的章节ID
local changeHard = nil -- 自跳转的章节难度
local changeInfo = nil
local changeIndex = 1
-- sp
local openViewKey = nil
--bg
local bgType = DungeonBgType.Normal
--shop
local shopPageData = nil
local shopRefreshTime = 0
local shopTime,timer = 0,0

function Awake()
    sliderObj = ComUtil.GetCom(slider, "Slider");

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.Dungeon_Box_Refresh, InitBox)
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Dungeon_MainLine_Guide_Refresh, SetJumpInfo2)

    CSAPI.SetGOActive(spParent, false)
    InitInfo()
end

function OnViewClosed(viewKey)
    -- or viewKey =="Plot"
    if viewKey == "TeamConfirm" or viewKey == "TeamForceConfirm" then
        CSAPI.SetGOActive(mapView.ModelCamera, true);
    elseif viewKey == "Plot" then
        CSAPI.SetGOActive(mapView.ModelCamera, true);
        FuncUtil:Call(function()
            if not gameObject then
                return
            end
            -- bgm
            local bgm = sectionData:GetBGM()
            if bgm and bgm ~= "" then
                CSAPI.PlayBGM(bgm)
            end
        end, nil, 100)
    elseif viewKey == "ActivityListView" then
        RefreshItems()
    end

    if viewKey ~= "Dungeon" and viewKey ~= "SpecialGuide" and openViewKey == viewKey then
        SpecialGuideMgr:ApplyShowView(spParent, "Dungeon", SpecialGuideType.Start)
        openViewKey = nil
    end
end

function OnViewOpened(viewKey)
    if viewKey ~= "Dungeon" and viewKey ~= "SpecialGuide" and openViewKey == nil then
        SpecialGuideMgr:ApplyShowView(spParent, "Dungeon", SpecialGuideType.StopAll)
        openViewKey = viewKey
    end
end

function OnLoadComplete()
    if loadCB then
        loadCB()
        loadCB = nil
    end
end

function OnInit()
    UIUtil:AddTop2("DungeonView", topObj, OnClickBack, OnClickHome)
end

function OnDestroy()
    -- CSAPI.PlayBGM("Sys_Lobby",1)
    EventMgr.Dispatch(EventType.Replay_BGM);
    eventMgr:ClearListener();
end

function Update()
    if timer < Time.time then
        timer=Time.time + 1
        UpdateShopTime()
    end
end

function OnOpen()
    --点触礼包
    PopupPackMgr:CheckByCondition({1,4,6})
    --
    if (data) then
        sectionData = DungeonMgr:GetSectionData(data.id)
        if not sectionData then
            return
        end

        -- bgm
        local bgm = sectionData:GetBGM()
        if bgm then
            CSAPI.PlayBGM(bgm, 1)
        end

        if not mapView then
            local path = "SectionMapView"
            if sectionData:GetBGType() == 2 then
                path = "SectionMapView2"
                bgType = DungeonBgType.Change
            end
            ResUtil:CreateUIGOAsync("SectionMap/" .. path, mapParent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.Init(sectionData)
                mapView = lua
                InitPanel()
            end)
        else
            mapView.Init(sectionData)
            InitPanel()
        end
    else
        LogError("打开副本界面失败！参数无效")
    end
end
-----------------------------------------------初始化-----------------------------------------------
-- 初始化右侧栏
function InitInfo()
    if (itemInfo == nil) then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            -- itemInfo.SetClickCB(OnBattleEnter)
        end)
    end
end

function InitPanel()
    InitShop()
    
    DungeonMgr:SetMultiReward(false) -- 进入主线章节关闭多倍

    Refresh()

    -- 点线段
    CreateAllLine()

    -- 初始化大小
    for i, v in pairs(listItems) do
        v.SetScale(mapView.curScale)
    end

    -- 进入状态
    SetOpenState()
end

-- 打开界面状态
function SetOpenState()
    local _id = LoadDungeonID()
    local state = data.state or DungeonOpenType.Normal
    if state == DungeonOpenType.Jump and data.itemId then -- 跳转
        SetJumpInfo(data.itemId)
    elseif state == DungeonOpenType.Retreat or state == DungeonOpenType.Finish then -- 撤退 或 完成关卡
        if _id > 0 then
            SetJumpInfo(_id)
        end
    else -- 正常打开
        if not CheckShowPassTips(_id) then
            if DungeonMgr:GetCurrDungeonIsFirst() then -- 首次通关
                CheckNextDungeonMission(_id) -- 任务检测
                CheckDungeonPassTips(_id) -- 通关提示
                DungeonMgr:SetCurrDungeonNoFirst() -- 避免再次进入
            end
            if currListItem and currListItem.IsOpenTime() then
                mapView.MoveToTarget(currListItem, mapView.curScale)
                OnClickListItem(currListItem)
            else
                -- list
                SetDotAction(true)
                SetListItemAction()
                -- 线段
                ShowLine(true)
            end
        end
    end
end

-- 跳转时设置信息 --外部跳转进来 --同章节跳转 --不同章节跳转 --
function SetJumpInfo(val3)
    if (val3) then
        local cfg = Cfgs.MainLine:GetByID(val3)
        if cfg and cfg.type ~= currHardLv  then
            SwitchHard(cfg.type)
        end
        if listItems then
            for _, listItem in pairs(listItems) do
                local groups = listItem:GetGroups()
                for _, id in ipairs(groups) do
                    if val3 == id then
                        currListItem = listItem
                        break
                    end
                end
            end
            if currListItem and mapView then
                mapView.MoveToTarget(currListItem, mapView.curScale)
                ClickEnter(val3, function()
                    FuncUtil:Call(function()
                        if gameObject and items then
                            local item = items[val3]
                            if item then
                                OnClickItem(item)
                            end
                        end
                    end, nil, 200)
                end)
            end
        end
    end
end

--只跳转到关卡组
function SetJumpInfo2(groupId)
    if groupId and groupDatas and #groupDatas > 0 then
        for k, groupData in ipairs(groupDatas) do
            if groupData:GetID() == groupId and listItems and listItems[k] then
                SwitchHard(listItems[k].IsHard() and 2 or 1)
                OnClickListItem(listItems[k])
                break
            end
        end
    end
end

----------------------------------------------主方法----------------------------------------------
function Refresh()
    -- 判断当前章节是否开通困难
    SetHard()

    -- datas
    groupDatas = DungeonMgr:GetDungeonGroupDatas(data.id, currHardLv == 2)

    -- list
    RefreshListItems()

    -- 宝箱
    -- local dungeonCfgs = sectionData:GetDungeonCfgs(currHardLv)
    -- CheckStar(dungeonCfgs)
    currStarNum = DungeonMgr:GetMainSectionStar(sectionData:GetID(), currHardLv)
    InitBox()
end

-- 困难
function SetHard()
    currHardLv = DungeonMgr:GetDungeonHardLv(sectionData:GetID())
    local cfgs = sectionData:GetDungeonCfgs(2);
    if cfgs then
        isOpen, tips = DungeonMgr:IsDungeonOpen(cfgs[1].id);
    end
    CSAPI.SetGOActive(txt_lockHard, not isOpen);
    CSAPI.SetText(txt_hard, isOpen and LanguageMgr:GetByID(15016) or "")
    if isOpen ~= true then
        if currHardLv == 2 then
            currHardLv = 1;
            DungeonMgr:SetDungeonHardLv(sectionData:GetID(), currHardLv);
        end
    end
    local isEasy = currHardLv == 1
    CSAPI.SetAnchor(hardSel, isEasy and -51 or 107, 52)
    local color1 = isEasy and {255, 255, 255, 255} or {255, 255, 255, 125}
    local color2 = not isEasy and {255, 255, 255, 255} or {255, 255, 255, 125}
    CSAPI.SetImgColor(btnSelEasy, color1[1], color1[2], color1[3], color1[4])
    CSAPI.SetImgColor(btnSelHard, color2[1], color2[2], color2[3], color2[4])
end
---------------------------------------------listItem---------------------------------------------
function RefreshListItems()
    -- 回收
    RecycleListItems()
    -- 创建关卡组
    listItems = {}
    if groupDatas and #groupDatas > 0 then
        for i, data in ipairs(groupDatas) do
            local lua = GetListItem()
            lua.SetClickCB(OnClickListItem)
            lua.SetIndex(i)
            lua.Refresh(data)
            table.insert(listItems, lua)
            -- 改变难度重新获取最新关卡组
            if currListItem and (currListItem.IsHard() ~= data:IsHard()) then
                currListItem = nil
            end
            if data:IsCurrNew() and currListItem == nil then
                currListItem = lua
            end
        end
    end
end

-- 单独显示关卡组 -id为负时全显示
function OnlyShowListItem(item)
    if listItems then
        for k, v in pairs(listItems) do
            if item then
                v.ShowRoot(v == item)
            else
                v.SetRootScale(mapView.rootScale)
                v.ShowRoot(true)
            end
        end
    end
end

-- 点击关卡组回调
function OnClickListItem(item)
    if mapView.currIdx < 2 then
        currListItem = item
        -- 拉进场景
        ClickEnter()
    end
end

-- 难度切换
function SwitchHard(targetHardLv)
    if currHardLv == targetHardLv then
        return
    end
    if groupDatas and #groupDatas > 0 then
        local gourpData = groupDatas[1]
        gourpData:SetHard(targetHardLv == 2)
        local isOpen, str = gourpData:IsOpen()
        if isOpen then
            DungeonMgr:SetDungeonHardLv(sectionData:GetID(), targetHardLv);
            Refresh()
            if mapView.currIdx == 2 then
                ClickSwitch(currListItem.GetIndex())
            end
        else
            gourpData:SetHard(targetHardLv ~= 2)
            if str ~= nil then
                Tips.ShowTips(str);
            end
        end
    end

    EventMgr.Dispatch(EventType.Dungeon_MainLine_Update, sectionData:GetID())
end

-- 普通
function OnClickEasy()
    SwitchHard(1);
end

-- 困难
function OnClickHard()
    SwitchHard(2);
end

-- 获取关卡组
function GetListItem()
    if listItemPool and #listItemPool > 0 then
        local FirstIndex = 1
        local targetItem = table.remove(listItemPool, FirstIndex)
        CSAPI.SetGOActive(targetItem.gameObject, true)
        return targetItem
    end

    local go = ResUtil:CreateUIGO("Dungeon/DungeonListItem", mapView.listNode.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.SetPivot(bgType)
    return lua
end

-- 回收关卡组
function RecycleListItems()
    if listItems == nil then
        return
    end

    listItemPool = listItemPool or {}
    for _, listItem in pairs(listItems) do
        table.insert(listItemPool, listItem)
        CSAPI.SetGOActive(listItem.gameObject, false)
    end
    listItems = nil;
end
-----------------------------------------------line-----------------------------------------------
-- 创建全部线段
function CreateAllLine()
    RecycleLines()
    -- 从第二个关卡开始连接
    if groupDatas and #groupDatas > 1 then
        local lastID = 0
        for k, v in ipairs(groupDatas) do
            if k ~= 1 then
                local x1, y1 = CSAPI.GetLocalPos(listItems[lastID].gameObject)
                local x2, y2 = CSAPI.GetLocalPos(listItems[k].gameObject)
                local scale = CSAPI.GetSizeOffset()
                local pos = {{x1, y1}}
                if v:GetTurnPos() and #v:GetTurnPos() > 0 then
                    for _, _pos in ipairs(v:GetTurnPos()) do
                        table.insert(pos, {_pos[1] * scale, _pos[2] * scale})
                    end
                end
                table.insert(pos, {x2, y2})
                local lua = GetLine();
                lua.SetLock(v:IsOpen())
                lua.SetLine(pos)
                listLines = listLines or {}
                table.insert(listLines, lua)
            end
            lastID = k
        end
    end
end

-- 所有线段显示
function ShowLine(isShow, isTween)
    if listLines and #listLines > 0 then
        for k, v in pairs(listLines) do
            v.SetLineAction(isShow)
        end
    end
end

function GetLine()
    if (linePool and #linePool > 0) then
        local FirstIndex = 1
        local targetLine = table.remove(linePool, FirstIndex)
        CSAPI.SetGOActive(targetLine.gameObject, true)
        return targetLine
    end

    local go = ResUtil:CreateUIGO("Dungeon/DotLine", mapView.lineNode.transform)
    local lua = ComUtil.GetLuaTable(go)
    return lua
end

-- 回收连线
function RecycleLines()
    if listLines == nil then
        return
    end

    linePool = linePool or {}
    for _, line in pairs(listLines) do
        CSAPI.SetGOActive(line.gameObject, false)
        table.insert(linePool, line)
    end
    listLines = nil
end
-----------------------------------------------item-----------------------------------------------
-- 刷新物体
function RefreshItems()
    if items then
        for k, v in pairs(items) do
            v.Set(v.GetCfg())
        end
    end
end

-- 按钮控制
function ShowBtn(_isOpen)
    CSAPI.SetGOActive(btnMask, _isOpen)
    CSAPI.SetGOActive(btnRoot, _isOpen)
    if _isOpen then
        local isLeft = true
        local isRight = true
        if currListItem then
            local idx = currListItem.GetIndex()
            if (idx == 1 or not groupDatas[idx - 1]:IsOpen()) then
                isLeft = false
            end
            if (idx == #groupDatas or (idx + 1 <= #groupDatas and not groupDatas[idx + 1]:IsOpen())) then
                isRight = false
            end
        end
        CSAPI.SetGOActive(btnLast, isLeft)
        CSAPI.SetGOActive(btnNext, isRight)
    end
end

-- 显示关卡
function ShowDungeon(_id)
    RecycleItems()
    local groups = currListItem.GetGroups()
    if groups and #groups > 0 then
        for i, v in pairs(groups) do
            local cfg = Cfgs.MainLine:GetByID(v)
            if cfg then
                local lua = GetItem()
                items = items or {}
                items[cfg.id] = lua
                lua.Set(cfg)
                lua.SetNext(i ~= #groups)
                lua.SetSort(i)
                CSAPI.SetGOActive(lua.gameObject, true)
            else
                LogError("没找到关卡表数据！！！id:" .. v)
            end
        end
        local cur, max = currListItem.GetPassCount()
        CSAPI.SetText(txtPrograss, math.floor(cur / max * 100) .. "%")
        -- 少数量控制长度
        -- CSAPI.SetRTSize(mapView.itemNode, 565, #groups < 5 and 124 + (#groups * 148) or 754)
        CSAPI.SetRTSize(itemNode, 565, #groups < 5 and 124 + (#groups * 148) or 754)
        CSAPI.SetGOActive(scrollBar, #groups > 4)
    end
    ShowItemsPos(_id)
end

-- 设置面板位置 
function ShowItemsPos(_id)
    local targetData = nil
    local targetData1 = nil
    local targetData2 = nil
    if items then
        if _id then -- 指定关卡
            for _, _item in pairs(items) do
                if _item.GetID() == _id then
                    targetData = {
                        index = _item.GetSort(),
                        item = _item
                    }
                    break
                end
            end
        else -- 获取未通关的主线或支线，主线优先级高于支线
            local itemID = 0
            local subItemID = 0
            for _, _item in pairs(items) do
                if not _item.IsPass() then -- 未通关 
                    if not _item.IsSub() then -- 主线
                        if (itemID == 0) or (_item.cfg.key < itemID) then
                            targetData1 = {
                                index = _item.GetSort(),
                                item = _item
                            }
                        end
                        itemID = _item.cfg.key
                    else
                        if (subItemID == 0) or (_item.cfg.key < subItemID) then
                            targetData2 = {
                                index = _item.GetSort(),
                                item = _item
                            }
                        end
                        subItemID = _item.cfg.key
                    end
                end
            end
            targetData = targetData1 and targetData1 or targetData2
        end
        local groups = currListItem.GetGroups()
        if targetData == nil then
            targetData = {
                index = items[groups[#groups]].GetSort(),
                item = items[groups[#groups]]
            }
        end
        local y1 = -((32 + 114.54 / 2) + (25 + 114.54) * (targetData.index))
        local y2 = (#groups * (114.54)) + ((#groups - 1) * 25) + 32 + 30
        SetContentPos(y1, y2)
    end
end

-- 设置关卡位置
function SetContentPos(posY1, posY2)
    local _posX, _posY = CSAPI.GetAnchor(itemParent)
    local arr1 = CSAPI.GetRTSize(itemSv)
    local y = 0
    if math.abs(posY1) <= (arr1[1] / 2) then
        y = 0
    elseif math.abs(posY1) >= posY2 - (arr1[1] / 2) then
        y = posY2 - arr1[1] - 1
    else
        y = math.abs(posY1) - (arr1[1] / 2)
    end
    CSAPI.SetAnchor(itemParent, _posX, y)
end

-- 获取item
function GetItem()
    if (itemPool and #itemPool > 0) then
        -- local lastItem = #itemPool
        local firstItem = 1
        local targetItem = table.remove(itemPool, firstItem)
        return targetItem
    end

    local go = ResUtil:CreateUIGO("Dungeon/DungeonItem", itemParent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.SetClickCallBack(OnClickItem)
    return lua
end

-- 回收关卡
function RecycleItems()
    if (items == nil) then
        return
    end

    itemPool = itemPool or {}
    for _, item in pairs(items) do
        table.insert(itemPool, item)
        local isFight = (item.GetID() == DungeonMgr:GetCurrFightId())
        CSAPI.SetGOActive(item.gameObject, false)
    end
    items = nil
end

function OnClickItem(item)
    if (item ~= nil and not item.IsOpen()) then
        ShowInfo();
        return;
    end
    if (selItem) then
        selItem.SetSel(false)
        selItem = nil
    end

    selItem = item
    selItem.SetSel(true)
    ShowInfo(selItem)
end
---------------------------------------------itemInfo---------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    local cfg = item and item.GetCfg() or nil
    local type = item and item.GetType() or nil
    CSAPI.SetGOActive(infoMask, isActive)
    CSAPI.SetGOActive(normal, not isActive)
    CSAPI.SetGOActive(boxBtnObj, not isActive)
    CSAPI.SetGOActive(mapView.boxObj, not isActive)
    CSAPI.SetGOActive(spParent, isActive)
    SpecialGuideMgr:ApplyShowView(spParent, "Dungeon", SpecialGuideType.StopAll)
    itemInfo.Show(cfg, type, OnLoadSuccess)
end

function OnLoadSuccess()
    itemInfo.SetFunc("Button","OnClickEnter",OnBattleEnter)
    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
    if selItem then
        itemInfo.AddTeamReplace(selItem.GetType() == DungeonInfoType.Normal,OnBattleEnter)
    end
    if selItem and selItem.GetType() == DungeonInfoType.Normal then
        SpecialGuideMgr:ApplyShowView(spParent, "Dungeon", SpecialGuideType.Start)
    end
end

-- 进入
function OnBattleEnter()
    if (selItem) then
        if selItem.GetCfg().arrForceTeam ~= nil then -- 强制上阵编队
            CSAPI.OpenView("TeamForceConfirm", {
                dungeonId = selItem.GetID(),
                teamNum = selItem.GetTeamNum()
            })
        else
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = selItem.GetID(),
                teamNum = selItem.GetTeamNum()
            }, TeamConfirmOpenType.Dungeon)
        end
        CSAPI.SetGOActive(mapView.ModelCamera, false);
        SaveDungeonID(selItem.GetID())
        if CSAPI.IsADV() or CSAPI.IsDomestic() then
            if selItem.GetID() == 1001 then
                BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_01_START)
            elseif selItem.GetID() == 1002 then
                BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_02_START)
            end
        else
            BuryingPointMgr:TrackEvents("main_fight", {
                reason = "进入副本",
                world_id = sectionData:GetID(),
                card_id = selItem.GetID()
            })
        end
    end
    SpecialGuideMgr:ApplyShowView(spParent, "Dungeon", SpecialGuideType.Finish)
end

function OnStoryCB(_isStoryFirst)
    isStoryFirst = _isStoryFirst
    if not isStoryFirst then
        return
    end
    selItem.Set(selItem.cfg);

    if currListItem.IsPass() then
        currListItem.SetNew(false)
        if CheckShowPassTips(selItem.GetID()) then
            ShowDungeon()
            SetHard()
            return
        end
        if isStoryFirst then
            OnClickNext()
            return
        end
    end
    ShowDungeon()
end

---------------------------------------------动效---------------------------------------------
-- 关卡组动画
function SetListItemAction(_item, _cb)
    if _item then
        _item.SetAction(_cb)
    else
        for k, v in pairs(listItems) do
            v.SetAction()
        end
    end
end

-- 关卡组中心点动画
function SetDotAction(isOpen)
    for i, v in pairs(listItems) do
        v.SetDotAction(isOpen)
    end
end

---------------------------------------------控制---------------------------------------------
-- itemId 指定显示id
function ClickEnter(itemId, cb)
    if mapView then
        local startFunc = function()
            -- 显示
            OnlyShowListItem(currListItem)

            -- list		
            currListItem.ShowRoot(false)
            SetDotAction(false)

            -- 线段
            ShowLine(false)
        end
        local finshFunc = function()
            -- list
            currListItem.SetRootScale(mapView.rootScale)
            currListItem.ShowRoot(true)
            currListItem.SetSel(true)

            mapView.isMove = true
            SetListItemAction(currListItem, function()
                mapView.isMove = false
            end)

            -- click
            ShowBtn(true)

            -- item	
            CSAPI.SetGOActive(itemNode, true)
            -- CSAPI.SetGOActive(mapView.itemNode, true)
            ShowDungeon(itemId)

            if cb then
                cb()
            end
        end
        mapView.Enter(currListItem, startFunc, finshFunc)
    end
end

function ClickBack()
    if mapView then
        local startFunc = function()
            -- list
            currListItem.ShowRoot(false)
            currListItem.SetSel(false)

            -- item
            CSAPI.SetGOActive(itemNode, false)
            -- CSAPI.SetGOActive(mapView.itemNode, false)
            -- click
            ShowBtn(false)
        end
        local finshFunc = function()
            -- 显示
            OnlyShowListItem()

            -- list
            SetDotAction(true)
            SetListItemAction()

            -- 线段
            ShowLine(true)
        end
        mapView.Back(currListItem, startFunc, finshFunc)
    end
end

function ClickSwitch(idx)
    if currListItem == nil or listItems == nil or listItems[idx] == nil then
        return
    end
    if not listItems[idx].IsOpenTime() then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(8049)
        CSAPI.OpenView("Prompt",dialogData)
        return
    end
    if mapView then
        currListItem.ShowRoot(false)
        currListItem.SetSel(false)
        currListItem = listItems[idx]
        currListItem.ShowRoot(false)
        -- item
        CSAPI.SetGOActive(itemNode, false)
        -- CSAPI.SetGOActive(mapView.itemNode, false)
        -- click
        ShowBtn(true)
        mapView.Switch(currListItem, nil, function()
            mapView.isMove = true
            -- list
            currListItem.SetRootScale(mapView.rootScale)
            currListItem.ShowRoot(true)
            currListItem.SetSel(true)
            SetListItemAction(currListItem, function()
                mapView.isMove = false
            end)

            -- item
            CSAPI.SetGOActive(itemNode, true)
            -- CSAPI.SetGOActive(mapView.itemNode, true)
            ShowDungeon()
        end)
    end
end

-- 返回
function OnClickItemBack()
    ClickBack()
end

-- 下一个
function OnClickNext()
    ClickSwitch(currListItem.GetIndex() + 1)
end

-- 上一个
function OnClickLast()
    ClickSwitch(currListItem.GetIndex() - 1)
end
-----------------------------------------状态本地缓存-----------------------------------------
-- 选中id本地缓存
function SaveDungeonID(_id)
    local ids = {
        id = _id or 0
    }
    FileUtil.SaveToFile("CurrID.txt", ids)
end

-- 读取上一次选中id
function LoadDungeonID()
    local ids = FileUtil.LoadByPath("CurrID.txt") or {}
    local id = ids.id or 0
    return id
end

---------------------------------------------关卡宝箱-----------------------------------------------
-- 检测当前星数
function CheckStar(_cfgs)
    local starNums = 0
    if _cfgs and #_cfgs > 0 then
        for _, _cfg in pairs(_cfgs) do
            if _cfg.sub_type ~= 1 then
                local dungeonData = DungeonMgr:GetDungeonData(_cfg.id)
                starNums = dungeonData == nil and starNums or starNums + dungeonData:GetStar()
            end
        end
    end
    return starNums
end

-- 初始化宝箱信息
function InitBox()
    boxData = DungeonBoxMgr:GetData(sectionData:GetStarRewardID())
    if boxData:GetCfg() then
        -- 星数
        local totalStarNum = boxData:GetStarNum()
        local num = currStarNum
        CSAPI.SetText(txt_star, num .. "")
        CSAPI.SetText(txt_maxStar, "/" .. totalStarNum)
        -- slider
        local starNum = currStarNum > totalStarNum and totalStarNum or currStarNum
        sliderObj.value = starNum / totalStarNum;
        -- 阶段
        local cur, max = boxData:GetStage()
        if cur <= max then
            CSAPI.SetGOActive(img_tip, totalStarNum <= num)
        else
            CSAPI.SetGOActive(img_tip, false)
        end
        cur = cur > max and max or cur
        CSAPI.SetText(txt_stage, cur .. "")
        CSAPI.SetText(txt_maxStage, "/" .. max)

        -- panel
        SetBoxPanel()
    else
        LogError("获取不到当前宝箱信息！")
    end
    SetRed()
end

-- 宝箱弹窗
function SetBoxPanel()
    if isOpenBoxs and boxData then
        -- star
        local maxStarNum = boxData:GetMaxStarNum()
        local num = currStarNum > maxStarNum and maxStarNum or currStarNum
        CSAPI.SetText(txt_boxStar, num .. "")
        CSAPI.SetText(txt_boxMaxStar, maxStarNum .. "")

        -- boxs
        BoxListItems = BoxListItems or {}
        if BoxListItems and #BoxListItems > 0 then
            for i = 1, #BoxListItems do
                CSAPI.SetGOActive(BoxListItems[i].gameObject, false)
            end
        end

        local boxDatas = boxData:GetInfos(currStarNum)

        if #boxDatas > 0 then
            for i, v in ipairs(boxDatas) do
                if i <= #BoxListItems then
                    CSAPI.SetGOActive(BoxListItems[i].gameObject, true)
                    BoxListItems[i].Refresh(v)
                else
                    ResUtil:CreateUIGOAsync("Dungeon/DungeonBoxListItem", boxContent, function(go)
                        local lua = ComUtil.GetLuaTable(go)
                        lua.Refresh(v)
                        table.insert(BoxListItems, lua)
                    end)
                end
            end
        end

        -- btn
        if not btnGetCG then
            btnGetCG = ComUtil.GetCom(btnAllGet, "CanvasGroup")
        end
        isCanGet = false
        for i, v in ipairs(BoxListItems) do
            if v.GetCanGet() then
                isCanGet = true
                break
            end
        end
        btnGetCG.alpha = isCanGet and 1 or 0.5
    end
end

function OnClickBox()
    if not boxFadeT then
        boxFadeT = ComUtil.GetCom(boxNode, "ActionFadeT")
    end
    if isOpenBoxs then
        CSAPI.SetGOActive(boxObj, isOpenBoxs)
        boxFadeT:Play(function()
            SetBoxPanel()
            isOpenBoxs = not isOpenBoxs
        end)
    else
        CSAPI.SetGOActive(boxObj, isOpenBoxs)
        isOpenBoxs = not isOpenBoxs
    end
end

function OnClickAllGet()
    if not isCanGet then
        return
    end

    if not boxData:GetCfg() then
        return
    end

    local datas = {}
    local indexs = boxData:GetIndexs()
    for i = 1, #boxData:GetArr() do
        if not indexs or indexs[i] == nil then
            local info = boxData:GetInfo(i)
            if currStarNum >= info.starNum then
                local _data = {
                    id = sectionData:GetStarRewardID(),
                    -- type = DungeonMgr:GetDungeonHardLv(),
                    index = info.index
                }
                table.insert(datas, _data)
            end
        end
    end
    if #datas > 0 then
        -- 开启宝箱		
        ClientProto:GetDupSumStarReward(datas) -- 领取宝箱
        -- ClientProto:DupSumStarRewardInfo({sectionData:GetStarRewardID()})  --刷新宝箱
        -- InitBox()
        OnClickBox()
    end
end

-------------------------------------------检查章节是否完成-----------------------------------------------
function CheckShowPassTips(_id) -- 检查弹出开启窗口
    local dungeonData = DungeonMgr:GetDungeonData(_id) -- 通关后必有数据
    if dungeonData then
        changeInfo = {};
        changeIndex = 1;
        changeID = nil;

        -- 关卡非首次通关
        if (not DungeonMgr:GetCurrDungeonIsFirst() and not dungeonData:IsStory()) then
            return false
        end

        -- 剧情非首次通关
        if (not isStoryFirst and dungeonData:IsStory()) then
            return false
        end

        local isShow = false

        -- 要显示的信息
        local passStrs = dungeonData:GetPassDesc()
        if passStrs then
            isShow = true
            table.insert(changeInfo, {
                title = passStrs[1] or "",
                content = passStrs[2] or ""
            })
        end

        local nextOpenStrs = dungeonData:GetNextOpenDesc()
        if nextOpenStrs then
            isShow = true
            table.insert(changeInfo, {
                title = nextOpenStrs[1] or "",
                content = nextOpenStrs[2] or ""
            })
        end

        if dungeonData:GetJumpId() then
            isShow = true
            changeID = dungeonData:GetJumpId()
        end

        if not isShow then
            return
        end

        if isActive then
            ShowInfo(nil);
            if selItem then
                selItem.SetSel(false)
                selItem = nil
            end
        end
        if mapView.currIdx == 2 and not mapView.isMove then
            ClickBack()
        end

        -- changeIndex = 1;
        SetPassObj(changeIndex);
        CSAPI.SetGOActive(passObj, true);
        return true
    end
    return false
end

function SetPassObj(index)
    if changeInfo ~= nil and index and index <= #changeInfo then
        CSAPI.SetText(txt_passTitle, changeInfo[index].title);
        CSAPI.SetText(txt_passTips, changeInfo[index].content);
    end
end

function OnClickPassOther()
    if mapView.isMove then
        return
    end
    if changeIndex < #changeInfo then
        changeIndex = changeIndex + 1;
        SetPassObj(changeIndex);
    else
        SaveDungeonID()
        CSAPI.SetGOActive(passObj, false);
        if changeID then
            local jumpCfg = Cfgs.CfgJump:GetByID(changeID)
            if jumpCfg then
                JumpMgr:Jump(jumpCfg.id)
                EventMgr.Dispatch(EventType.Dungeon_MainLine_Update, jumpCfg.val1)
            end
        end
    end
end

function CheckNextDungeonMission(_id)
    local cfg = Cfgs.MainLine:GetByID(_id)
    if cfg and cfg.lasChapterID and cfg.lasChapterID[1] and not DungeonMgr:IsDungeonOpen(cfg.lasChapterID[1]) then
        local nextCfg = Cfgs.MainLine:GetByID(cfg.lasChapterID[1])
        if nextCfg and nextCfg.LockMission then
            local lockInfo = nextCfg.LockMission[1]
            loadCB = function()
                local dialogData = {}
                dialogData.content = LanguageMgr:GetByID(15107, lockInfo[2] + 1,
                    nextCfg.chapterID .. " " .. nextCfg.name)
                dialogData.okCallBack = function()
                    JumpMgr:Jump(180002)
                end
                CSAPI.OpenView("Dialog", dialogData)
            end
        end
    end
end

function CheckDungeonPassTips(_id)
    local cfg = Cfgs.MainLine:GetByID(_id)
    if cfg and cfg.passTips then
        local _loadCB = loadCB
        loadCB = function()
            FuncUtil:Call(function()
                if gameObject then
                    LanguageMgr:ShowTips(cfg.passTips)
                end
            end, nil, 200)
            if _loadCB then
                _loadCB()
            end
        end
    end
end

-- 关闭界面
function OnClickBack()
    if mapView and not mapView.isMove then
        if isActive then
            ShowInfo(nil);
            if selItem then
                selItem.SetSel(false)
                selItem = nil
            end
        else
            if mapView.currIdx == 2 then -- 返回大地图
                ClickBack()
            else -- 退回选章
                view:Close()
                SaveDungeonID()
            end
        end
    end
end

-- 回到主菜单
function OnClickHome()
    if mapView and not mapView.isMove then
        UIUtil:ToHome()
        SaveDungeonID()
    else
        UIUtil:ToHome()
    end
end

function SetRed()
    local isNolRed = DungeonBoxMgr:CheckRed(sectionData:GetID(), 1)
    UIUtil:SetRedPoint(btnSelEasy, isNolRed, 65, 9)

    local isHardRed = DungeonBoxMgr:CheckRed(sectionData:GetID(), 2)
    -- local isHardRed = CheckRed(sectionData:GetID(), 2)
    UIUtil:SetRedPoint(btnSelHard, isHardRed, 65, 9)
end
-------------------------------------------商店-----------------------------------------------
function InitShop()
    CSAPI.SetGOActive(btnShop,sectionData:GetShopId() ~= nil)
    if sectionData:GetShopId() ~= nil then
        shopPageData = ShopMgr:GetPageByID(sectionData:GetShopId())
        if shopPageData and shopPageData:GetOpenTimeData() and shopPageData:GetOpenTimeData() ~= 0 and shopPageData:GetOpenTimeData() < TimeUtil:GetTime() then
            CSAPI.SetGOActive(shopTimeObj, true)
            SetShopTime()
        elseif not shopPageData or shopPageData:GetCloseTimeData() < TimeUtil:GetTime() then
            CSAPI.SetGOActive(btnShop,false)
        end
    end
end

function SetShopTime()
    shopRefreshTime = shopPageData:GetCloseTimeData() or 0
    shopTime = shopRefreshTime - TimeUtil:GetTime()
    if shopTime <= 0 then
        CSAPI.SetGOActive(btnShop,false)
    end
end

function UpdateShopTime()
    if shopTime > 0 then
        shopTime = shopRefreshTime - TimeUtil:GetTime()
        local tab = TimeUtil:GetTimeTab(shopTime)
        LanguageMgr:SetText(txtShopTime, 34039, tab[1], tab[2], tab[3])
        if shopTime <= 0 then
            SetShopTime()
        end
    end
end

function OnClickShop()
    CSAPI.OpenView("ShopView", shopPageData:GetID())
end