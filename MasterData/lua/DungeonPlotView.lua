local currItem = nil
local listLines = nil
local linePool = nil
local sectionData = nil
local datas = nil
local groupDatas = nil
local listItemPool = nil
local listItems = nil
local jumpID = 0 -- 用于区分进入时是否有新关卡
local openInfo = nil
-- hard
local currHardLv = 1
local hardData = nil
local isHardOpen = false
local isHardChange = false
local hardTips = nil
-- danger
local currDanger = 1
-- extre
local extreData = nil
-- bg
local canvasW = 0
local bgWidth = 0
local itemWidth = 1
local lastPosX = 0
-- effect
local animInfo = nil
local animPlayTime = 0
local effectPosOffset = 925

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Bag_Update, function()
        CSAPI.SetText(txtGoods, BagMgr:GetCount(10015) .. "")
    end)
end

function OnLoadComplete()
    InitEnterState()
    -- PlayAnim(100, InitEnterState)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnInit()
    UIUtil:AddTop2("DungeonPlot", topObj, OnClickReturn);
end

function Update()
    if IsNil(bgImg) or IsNil(bgImg.gameObject) then
        return
    end
    -- item和背景移动百分比相同
    if bgWidth < canvasW or itemWidth < canvasW then
        return
    end
    local bgPos_x = CSAPI.GetLocalPos(bgImg.gameObject) or 0
    local bgPrecent = math.abs(bgPos_x) / (bgWidth - canvasW)
    local x = -(bgPrecent * (itemWidth - canvasW))
    if lastPosX ~= x then
        lastPosX = x
        CSAPI.SetAnchor(lineNode.gameObject, x, 0)
        CSAPI.SetAnchor(itemParent.gameObject, x, 0)
    end

    if animPlayTime > 0 then
        animPlayTime = animPlayTime - Time.deltaTime
    else
        animPlayTime = 2.267
        CSAPI.SetAnchor(effect.gameObject, effectPosOffset + math.abs(bgPos_x), 0)
    end

    -- 困难本等待开启
    UpdateHardOpen()
end

function UpdateHardOpen()
    if openInfo == nil then
        return
    end

    if isHardChange then
        return
    end

    if not isHardOpen and openInfo:IsHardOpen() then
        isHardChange = true
        SetHard()
    end
end

function OnOpen()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())

        InitPanel()
        RefreshPanel()
        if openSetting == nil then
            PlayAnim(100, InitEnterState)
        end
    end
end

function InitPanel()
    data.itemId = data.itemId or 0
    currHardLv = 1
    -- good
    CSAPI.SetText(txtGoods, BagMgr:GetCount(10015) .. "")
    CSAPI.SetGOActive(infoMask, false)

    InitSize()
    InitAnim()
    InitDatas()
end

function InitSize()
    canvasW = CSAPI.GetMainCanvasSize()[0] or 0
    bgWidth = CSAPI.GetRTSize(bgImg.gameObject)[0] or 0

    local scale = CSAPI.GetMainCanvasSize()[1] / 1080 -- 特效根据高度适配
    CSAPI.SetScale(effObj, scale, scale)
end

function InitAnim()
    -- local anim = ComUtil.GetComInChildren(effect, "Animator")
    -- if anim then
    --     animInfo = anim:GetCurrentAnimatorStateInfo(0)
    -- end
end

function InitDatas()
    datas = {}
    local _datas = DungeonMgr:GetDungeonGroupDatas(data.id)
    if #_datas > 0 then
        for k, v in ipairs(_datas) do
            if v:GetCfg() and v:GetCfg().type then
                datas[v:GetCfg().type] = datas[v:GetCfg().type] or {}
                table.insert(datas[v:GetCfg().type], v)
                if data.itemId and v:GetDungeonGroups() and v:GetDungeonGroups()[1] == data.itemId then
                    currHardLv = v:GetCfg().type
                end
            end
        end
        table.sort(datas[1], function(a, b) -- 普通关排序
            return a.cfg.id < b.cfg.id
        end)
        if datas[2] then
            table.sort(datas[2], function(a, b) -- 困难关排序
                return a.cfg.id < b.cfg.id
            end)
            hardData = datas[2][1]
        end
        if datas[3] then
            table.sort(datas[3], function(a, b) -- EX关排序
                return a.cfg.id < b.cfg.id
            end)
            extreData = datas[3][1]
        end

        if data.itemId == 0 then
            if datas[1] and not IsCurrTypePass(datas[1]) then
                currHardLv = 1
            elseif datas[2] and not IsCurrTypePass(datas[2]) then
                currHardLv = 2
            elseif datas[3] and not IsCurrTypePass(datas[3]) then
                currHardLv = 3
            end
        end

        -- 未开启取消跳转
        if currHardLv == 2 and not openInfo:IsHardOpen() then
            currHardLv = 1
            data.itemId = 0
        elseif currHardLv == 3 and not openInfo:IsExtreOpen() then
            currHardLv = 2
            data.itemId = 0
        end

        -- 判断困难本开启
        if openInfo and openInfo:IsHardOpen() then
            isHardChange = true
        end
    end
end

-- 进入界面时的状态
function InitEnterState()
    JumpToItem() -- 有可以跳转的id
end

function JumpToItem()
    if jumpID <= 0 and data.itemId > 0 then
        jumpID = data.itemId -- 覆盖成跳转id
    end
    if jumpID > 0 and listItems and #listItems > 0 then
        for k, v in ipairs(listItems) do
            if v:GetGroups() then
                for i, m in ipairs(v:GetGroups()) do
                    if m == jumpID then
                        SetJump(k,v)
                        currDanger = i
                        break
                    end
                end
            end
        end
    end
end

function SetJump(k, v)
    local itemPos_x = CSAPI.GetAnchor(v.gameObject)
    local itemPrecent = (math.abs(itemPos_x)) / itemWidth
    local _, bgLocalY = CSAPI.GetLocalPos(bgImg.gameObject)
    local x = -(bgWidth * itemPrecent) + canvasW / 2
    CSAPI.SetLocalPos(bgImg.gameObject, x, bgLocalY)
    if data.itemId > 0 and jumpID == data.itemId then -- 新关卡和跳转关卡是同一关卡
        v.OnClick()
    end
    -- 首次开启关卡动效
    local infos = GetFirstOpenInfos()
    if jumpID and (not IsCurrTypePass(groupDatas) or data.itemId <= 0) and (not infos[jumpID] or infos[jumpID] == 0) then
        PlayAnim(300, function()
            local line = listLines[k]
            if line then
                line.PlayAnim()
            end

            if k > 1 then
                local lastItem = listItems[k - 1]
                if lastItem then
                    lastItem.SetColor(true, false, currHardLv == 2)
                end
                v.SetColor(true, true, currHardLv == 2)
                v.SetNew(true)
                currItem = v
            end
            SaveFirstOpenInfo(jumpID, true)
        end)
    end
end

function RefreshPanel()
    SetHard()
    -- SetExtre()
    RefreshDatas()
    CreateAllLine()
end

-- 困难
function SetHard()
    CSAPI.SetGOActive(hardObj, hardData ~= nil)

    if not openInfo:IsDungeonOpen() then -- 关卡开启
        isHardOpen = false
        hardTips = LanguageMgr:GetTips(24003)
    else
        isHardOpen = true
    end

    if isHardOpen then
        isHardOpen, hardTips = openInfo:IsHardOpen() -- 时间开启
    end

    if isHardOpen and hardData then -- 副本开启
        isHardOpen, hardTips = hardData:IsOpen()
    end

    CSAPI.SetGOActive(lockImg1, not isHardOpen);
    local isEasy = currHardLv == 1
    CSAPI.SetAnchor(hardSel, isEasy and -51 or 107, 52)
    local color1 = isEasy and {255, 255, 255, 255} or {255, 255, 255, 125}
    local color2 = not isEasy and {255, 255, 255, 255} or {255, 255, 255, 125}
    CSAPI.SetImgColor(btnSelEasy, color1[1], color1[2], color1[3], color1[4])
    CSAPI.SetImgColor(btnSelHard, color2[1], color2[2], color2[3], color2[4])
end

function SetExtre()
    -- 待定
end
-----------------------------------------------item-----------------------------------------------

function RefreshDatas()
    groupDatas = datas[currHardLv] or {}
    table.sort(groupDatas, function(a, b)
        return a:GetID() < b:GetID()
    end)
    itemWidth = groupDatas[#groupDatas]:GetPos().x + 340
    CSAPI.SetRTSize(itemParent, itemWidth, 0)
    CSAPI.SetAnchor(itemParent, 0, 0)

    RecycleListItems()
    listItems = {}
    local infos = GetFirstOpenInfos()
    if groupDatas and #groupDatas > 0 then
        local index = 1
        for i, _data in ipairs(groupDatas) do
            _data:SetHard(currHardLv == 2)
            local lua = GetListItem()
            lua.SetClickCB(OnItemClickCB)
            lua.SetIndex(index)
            lua.Refresh(_data)
            lua.SetNew(lua.IsOpen() and not lua.IsPass())
            table.insert(listItems, lua)

            if lua.IsOpen() and not lua.IsPass() then
                jumpID = lua.GetDungeonID()
                if (not infos[lua.GetDungeonID()] or infos[lua.GetDungeonID()] == 0) and index > 1 then -- 未播放
                    lua.SetNew(false)
                    lua.SetColor(false, false, currHardLv == 2)
                    local lastItem = listItems[index - 1]
                    if lastItem then
                        lastItem.SetColor(true, true, currHardLv == 2)
                    end
                end
            end
            index = index + 1
        end
    end
end

function OnItemClickCB(item)
    if currItem then
        currItem.SetSel(false)
    end
    currItem = item
    currItem.SetSel(true)
    ShowInfo(item)
end

-- 获取关卡组
function GetListItem()
    if listItemPool and #listItemPool > 0 then
        local FirstIndex = 1
        local targetItem = table.remove(listItemPool, FirstIndex)
        CSAPI.SetGOActive(targetItem.gameObject, true)
        return targetItem
    end

    local go = ResUtil:CreateUIGO("DungeonActivity1/DungeonPlotItem", itemParent.transform)
    local lua = ComUtil.GetLuaTable(go)
    return lua
end

-- 回收关卡组
function RecycleListItems()
    if listItems == nil then
        return
    end

    listItemPool = listItemPool or {}
    for _, listItem in pairs(listItems) do
        CSAPI.SetGOActive(listItem.gameObject, false)
        table.insert(listItemPool, listItem)
    end
    listItems = nil;
end

-- 获取第一次开启信息
function GetFirstOpenInfos()
    local infos = FileUtil.LoadByPath("DungeonPlotFirstPass_" .. data.id .. ".txt") or {}
    return infos
end

-- 保存第一次开启信息
function SaveFirstOpenInfo(itemId, isNoFirst)
    local infos = GetFirstOpenInfos()
    infos[itemId] = isNoFirst and 1 or 0
    FileUtil.SaveToFile("DungeonPlotFirstPass_" .. data.id .. ".txt", infos)
end

-- 当前难度全通关
function IsCurrTypePass(_groupDatas)
    if _groupDatas and #_groupDatas > 0 then
        for i, v in ipairs(_groupDatas) do
            if not v:IsPass() then
                return false
            end
        end
    end
    return true
end
-----------------------------------------------line-----------------------------------------------
-- 创建全部线段
function CreateAllLine()
    RecycleLines()
    -- 位于Y轴上方线段处于下方，反之相反
    if groupDatas and #groupDatas > 1 then
        local infos = GetFirstOpenInfos()
        local newOpenItem = nil
        for k, v in ipairs(groupDatas) do
            local pos = {}
            if k ~= 1 then
                local x2, y2 = CSAPI.GetLocalPos(listItems[k - 1].gameObject)
                if y2 >= 0 then
                    table.insert(pos, {x2 + 24, y2 - 51})
                else
                    table.insert(pos, {x2 + 24, y2 + 51})
                end
            end
            local x1, y1 = CSAPI.GetLocalPos(listItems[k].gameObject)
            if y1 >= 0 then
                table.insert(pos, {x1 - 24, y1 - 51})
                table.insert(pos, {x1 + 24, y1 - 51})
            else
                table.insert(pos, {x1 - 24, y1 + 51})
                table.insert(pos, {x1 + 24, y1 + 51})
            end
            local lua = GetLine();
            lua.SetLine(pos)
            lua.SetLock(v:IsOpen())
            listLines = listLines or {}
            table.insert(listLines, lua)

            -- 初始化开启动效
            if not v:IsPass() and v:IsOpen() and
                (not infos[v:GetDungeonGroups()[1]] or infos[v:GetDungeonGroups()[1]] == 0) and k ~= 1 then -- 获取最新关卡item
                newOpenItem = lua
            end
        end
        if newOpenItem then
            newOpenItem.InitAnim()
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

    local go = ResUtil:CreateUIGO("DungeonActivity1/DotLine", lineParent.transform)
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

---------------------------------------------itemInfo---------------------------------------------
-- 关卡信息
function ShowInfo(item)
    isActive = item ~= nil;
    local _cfg = item and item.GetCfg() or nil
    local type = item and item.GetType() or nil
    CSAPI.SetGOActive(infoMask, isActive)
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo7", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(_cfg, type, OnLoadCallBack)
        end)
    else
        itemInfo.Show(_cfg, type, OnLoadCallBack)
    end
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    itemInfo.CallFunc("PlotButton", "SetStoryCB", OnStoryCB)
    if currItem then
        itemInfo.AddTeamReplace(currItem.GetType() == DungeonInfoType.Normal)
        itemInfo.CallFunc("Danger","ShowDangeLevel",currItem.IsDanger(),currItem.GetCfgs(),currDanger)
    end
    SetInfoItemPos()
end

function SetInfoItemPos()
    itemInfo.SetPanelPos("Title", 0, 449)
    itemInfo.SetPanelPos("Level", 0, 363)
    itemInfo.SetPanelPos("Target", 23, 308)
    itemInfo.SetPanelPos("Output", 23, -71)
    itemInfo.SetPanelPos("Details", -6, -250)
    itemInfo.SetPanelPos("Button", 6, -444)
    itemInfo.SetPanelPos("Plot", 23, 322)
    itemInfo.SetPanelPos("Danger", 0, -69)
    if currItem then
        itemInfo.SetPanelPos("Output", 23, currItem.IsStory() and 15 or -71)
    end
    itemInfo.SetPanelPos("PlotButton", 6, -349)
end

-- 进入
function OnBattleEnter()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if (currItem) then
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
                cfg = cfgs[itemInfo.CallFunc("Danger","GetCurrDanger")]
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

function OnStoryCB(isStoryFirst)
    if not isStoryFirst then
        return
    end

    if currItem.GetData() == groupDatas[#groupDatas] and isStoryFirst then
        if currHardLv == 1 and openInfo:IsHardOpen() then
            currHardLv = 2
        elseif currHardLv == 2 and openInfo:IsExtreOpen() then
            currHardLv = 3
        end
    end
    if isActive then
        ShowInfo()
    end
    if currItem then
        currItem.SetSel(false)
        currItem = nil
    end
    RefreshPanel()
    JumpToItem()

    local bgPos_x = CSAPI.GetLocalPos(bgImg.gameObject)
    local bgPrecent = math.abs(bgPos_x) / (bgWidth - canvasW)
    local x = -(bgPrecent * (itemWidth - canvasW))
    lastPosX = x
    CSAPI.SetAnchor(lineNode.gameObject, x, 0)
    CSAPI.SetAnchor(itemParent.gameObject, x, 0)
end
-----------------------------------btn-----------------------------------
function OnClickReturn()
    if currItem then
        currItem.SetSel(false)
        currItem = nil
    end
    if itemInfo and itemInfo.IsShow() then
        ShowInfo()
        return
    end
    view:Close()
end

function OnClickEasy()
    SwitchHard(1)
end

function OnClickHard()
    if isHardOpen then
        SwitchHard(2)
    else
        Tips.ShowTips(hardTips)
    end
end

function OnClickShop()
    CSAPI.OpenView("ShopView", 901)
end

-- 难度切换
function SwitchHard(targetHardLv)
    if currHardLv ~= targetHardLv then
        if itemInfo and itemInfo.IsShow() then
            currItem.SetSel(false)
            currItem = nil
            ShowInfo()
        end
        currHardLv = targetHardLv
        RefreshPanel()
    end
end

-----------------------------------------------anim-----------------------------------------------

function PlayAnim(time, cb)
    AnimStart()
    FuncUtil:Call(function()
        if gameObject then
            AnimEnd()
            if cb then
                cb()
            end
        end
    end, nil, time)
end

function AnimStart()
    CSAPI.SetGOActive(clickMask.gameObject, true)
end

function AnimEnd()
    CSAPI.SetGOActive(clickMask.gameObject, false)
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
