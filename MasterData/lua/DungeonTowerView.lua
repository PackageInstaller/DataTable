local resetTime = 0
local towerDatas = nil
local m_Slider = nil
local layout = nil
local currItem1 = nil
local currItem2 = nil
local itemInfo = nil
local jumpID = 0
local sectionData = nil
local sectionDatas = nil
local selIndex = 0
local jumpData = nil
local offsetW = 0

-- sv
local scrollRect = nil
local items = nil
local left = 233
local cell = 330
local spacing = 232
local lastItem = nil
local startIndex = 1 -- 初始位置，用于居中

-- mask
local UIMask = nil

local isAnim = false
local animTime = 0

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Tower_Update_Data, OnPanelRefresh)
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
    eventMgr:AddListener(EventType.Mission_List, OnTowerRefresh)
    eventMgr:AddListener(EventType.CfgActiveEntry_Change, OnTowerRefresh)

    m_Slider = ComUtil.GetCom(slider, "Slider")

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/DungeonTower/DungeonTowerItem2", LayoutCallBack, true)
    -- layout:AddBarAnim(0.3, false)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    scrollRect = ComUtil.GetCom(sv, "ScrollRect")
    UIMask = CSAPI.GetGlobalGO("UIClickMask")
end

function OnPanelRefresh(info)
    RefresTopPanel(info)
    OnTowerRefresh()
end

function OnRedPointRefresh()
    -- 任务
    local _data = RedPointMgr:GetData(RedPointType.MissionTower)
    UIUtil:SetRedPoint2("Common/Red2", btnMission, _data[eTaskType.DupTower] == 1, 39, 36, 0)
end

function OnTowerRefresh()
    InitTowerItems()
    layout:UpdateList()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = towerDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ClickItemCB2)
        lua.Refresh(_data)

        if selIndex > 0 then
            lua.SetSelect(selIndex == index)
        end
    end
end

function OnInit()
    UIUtil:AddTop2("DungeonTower", topObj, OnClickReturn,nil,{nil,nil,10035});
    InitInfo()
end

-- 初始化右侧栏
function InitInfo()
    if (itemInfo == nil) then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.SetClickCB(OnBattleEnter)
            itemInfo.SetClickMaskCB(OnClickBack)
        end)
    end
end

-- 进入
function OnBattleEnter()
    if (currItem2) then
        if currItem2.IsLock() then
            return
        end
        local info = TowerMgr:GetTowerData()
        local isMax = info.cur >= info.max
        local isAddToMax = info.cur + currItem2.GetFangJing() > info.max
        if isMax or isAddToMax then
            local dialogData = {}
            dialogData.content = isMax and LanguageMgr:GetByID(15079) or LanguageMgr:GetByID(15078)
            dialogData.okText = LanguageMgr:GetByID(1031)
            dialogData.cancelText = LanguageMgr:GetByID(1003)
            dialogData.okCallBack = function()
                EnterNextView(currItem2)
            end
            CSAPI.OpenView("Dialog", dialogData)
        else
            EnterNextView(currItem2)
        end
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

function Update()
    if animTime > 0 then
        animTime = animTime - Time.deltaTime
        CSAPI.SetGOActive(UIMask, true)
    else
        CSAPI.SetGOActive(UIMask, false)
    end


    if TimeUtil:GetTime() > resetTime then
        local info = TowerMgr:GetTowerData()
        info = TowerMgr:AddTowerCur(-info.cur)
        RefresTopPanel(info)
        resetTime = resetTime + 604800 -- 7天秒数
        PlayerProto:GetTowerData()
        EventMgr.Dispatch(EventType.Activity_Open_State)
    end

    if (resetTime >= 0) then
        LanguageMgr:SetText(txtTime, 36006, TimeUtil:GetTimeStr3(resetTime - TimeUtil:GetTime()))
    end
end

function OnOpen()
    offsetW = (CSAPI.GetMainCanvasSize()[0] - 1920) / 2
    left = left + offsetW
    selIndex = 0
    if data then
        SetJump()
    end
    CSAPI.SetGOActive(second, false)
    OnRedPointRefresh()
    InitTowerItems()

    PlayAnim(500 + (#sectionDatas - 1) * 100)
end

function InitTowerItems()
    local datas = DungeonMgr:GetAllSectionDatas()
    sectionDatas = {}
    if datas then
        for k, v in pairs(datas) do
            if v:GetType() == SectionActivityType.Tower then
                local openInfo = DungeonMgr:GetActiveOpenInfo2(v:GetID())
                if openInfo then
                    if openInfo:IsOpen() then
                        table.insert(sectionDatas, v)
                    end
                else
                    table.insert(sectionDatas, v)
                end
            end
        end
    end

    if #sectionDatas > 0  then
        table.sort(sectionDatas,function (a,b)
            return a:GetID() < b:GetID()
        end)
    end

    ShowItems(sectionDatas)

    -- topLeft
    local iconName = ITEM_ID.BIND_DIAMOND .. ""
    if iconName ~= "" then
        ResUtil.IconGoods:Load(icon, iconName, true)
        CSAPI.SetScale(icon, 0.7, 0.7, 1)
    end
    local info = TowerMgr:GetTowerData()
    RefresTopPanel(info)
end

-- 刷新每周信息
function RefresTopPanel(info)
    if info then
        CSAPI.SetText(txtNum, info.cur .. "")
        CSAPI.SetText(txtMaxNum, info.max .. "")
        -- time
        resetTime = info.resetTime
        -- slider
        local prograss = info.cur / info.max
        m_Slider.value = prograss
    end
end

function ShowItems(datas)
    if datas and #datas > 0 then
        startIndex = 1
        if #datas < 3 then
            startIndex = #datas % 2 == 1 and 2 or 1.5
        end
        -- startIndex = 1
        items = items or {}
        if #items > 0 then
            for k, v in ipairs(items) do
                CSAPI.SetGOActive(v.gameObject, false)
            end
        end
        for k, v in ipairs(datas) do
            if #items < k then
                ResUtil:CreateUIGOAsync("DungeonTower/DungeonTowerItem1", content, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.SetIndex(k)
                    lua.SetClickCB(ClickItemCB1)
                    lua.Refresh(v)
                    table.insert(items, lua)
                    CSAPI.SetAnchor(go, left + cell / 2 + (k - 1 + (startIndex - 1)) * (spacing + cell), 0)
                    -- anim
                    if k < 4 then
                        lua.PlayAnim()
                    end
                    -- jump
                    if k == #datas then
                        JumpToItem1(k)
                    end
                end)
            else
                local lua = items[k]
                CSAPI.SetGOActive(lua.gameObject, true)
                lua.SetIndex(k)
                lua.SetClickCB(ClickItemCB1)
                lua.Refresh(v)
                CSAPI.SetAnchor(lua.gameObject, left + cell / 2 + (k - 1+ (startIndex - 1)) * (spacing + cell), 0)
                if k == #datas then
                    JumpToItem1(k)
                end
            end

            -- sv
            if k == #datas then
                CSAPI.SetRTSize(content, left + (k + startIndex - 1) * (spacing + cell) - spacing, 0)
            end
        end
    end
end

function ClickItemCB1(item)
    if currItem1 == item then
        return
    end
    if currItem1 then
        currItem1.SetSelect(false)
        lastItem = currItem1
    end
    currItem1 = item
    currItem1.SetSelect(true)

    scrollRect.enabled = false
    local index = item.GetIndex()
    MoveToIndex(index, function()
        ShowSecond(index, 571)
        CSAPI.SetGOActive(clickBack, true)
    end)
end

function MoveToIndex(index, cb)
    PlayAnim(100)
    if index and index > 0 then
        local x = -(cell + spacing) * (index - 1 + (startIndex - 1))
        local _, y = CSAPI.GetLocalPos(content.gameObject)
        CSAPI.MoveTo(content.gameObject, "UI_Local_Move", x, y, 0, function()
            if cb then
                cb()
            end
        end, 0.15)
    end
end

function ShowSecond(index, w, cb)
    PlayAnim(150)

    PlayFades(index ~= nil)
    if lastItem then -- 复位
        local currIdx = lastItem.GetIndex()
        lastItem = nil
        if items and #items > 0 then
            ShowSecondView()
            for k, v in ipairs(items) do
                if k > currIdx then
                    local x = left + cell / 2 + (k - 1 + (startIndex - 1)) * (spacing + cell)
                    CSAPI.MoveTo(v.gameObject, "UI_Local_Move", x, 0, 0, nil, 0.15)
                end
            end
            FuncUtil:Call(function()
                if gameObject then
                    CSAPI.SetRTSize(content, left + (#items + startIndex - 1) * (spacing + cell) - spacing, 0)
                    ShowSecond(index, w)
                    if cb then
                        cb()
                    end
                end
            end, nil, 150)
        end
        return
    end

    if not index or index <= 0 then
        return
    end

    PlayAnim(150)
    
    if items and #items > 0 then -- 移位
        CSAPI.SetRTSize(content, left + (#items + startIndex - 1) * (spacing + cell) - spacing + w, 0)
        for k, v in ipairs(items) do
            if k > index then
                local x = left + cell / 2 + (k - 1) * (spacing + cell) + w --固定移动到位置1
                CSAPI.MoveTo(v.gameObject, "UI_Local_Move", x, 0, 0, nil, 0.15)
            end
        end
        FuncUtil:Call(function()
            if gameObject then
                ShowSecondView(index)
            end
        end, nil, 100)
    end
end

function ShowSecondView(index)
    CSAPI.SetGOActive(second, index ~= nil)
    if not index then
        if itemInfo.IsShow() then
            itemInfo.Show()
        end
    else
        local lua = items[index]
        if lua then
            local list = {}
            local cfgGroup = lua.GetCfgDungeons()
            if (cfgGroup) then
                for _, cfg in pairs(cfgGroup) do
                    if (TowerMgr:IsTowerOpen(cfg.id)) then -- 检测开启时间
                        local itemData = {
                            cfg = cfg,
                            isUnLock = DungeonMgr:IsDungeonOpen(cfg.id)
                        }
                        table.insert(list, itemData)
                    end
                end
            end
            towerDatas = list
            JumpToItem2()
        end
    end
end

function ClickItemCB2(item)
    if item.index == selIndex then
        return
    end
    if currItem2 then
        currItem2.SetSelect(false)
        currItem2 = nil
    end

    currItem2 = item
    currItem2.SetSelect(true)
    selIndex = currItem2.index
    if itemInfo then
        itemInfo.Show(item.GetCfg(), DungeonInfoType.Tower,OnLoadSuccess)
    end
end

function OnLoadSuccess()
    itemInfo.AddTeamReplace(true,OnBattleEnter,nil,nil,nil,0,-158)
end

-----------------------------------------------anim-----------------------------------------------
function PlayAnim(delay)
    animTime = animTime + (delay / 1000)
    -- CSAPI.SetGOActive(UIMask, true)
    -- FuncUtil:Call(function()
    --     CSAPI.SetGOActive(UIMask, false)
    -- end, nil, delay)
end

function PlayFades(isFade)
    if not currItem1 then
        return
    end
    if items and #items > 0 then
        for i, v in ipairs(items) do
            if v ~= currItem1 then
                v.PlayFade(isFade)
            end
        end
    end
end

-----------------------------------------------跳转-----------------------------------------------
function SetJump()
    jumpData = {
        sID = data.id,
        id = data.itemId
    }
    if CSAPI.IsViewOpen("MissionActivity") then
        local go = CSAPI.GetView("MissionActivity")
        local view = ComUtil.GetLuaTable(go)
        if view then
            view.Close()
        end
    end
    if itemInfo and itemInfo.IsShow() then
        itemInfo.Show()
    end
    if currItem1 then
        currItem1.SetSelect(false)
        currItem1 = nil
    end
    if currItem2 then
        currItem2.SetSelect(false)
        currItem2 = nil
    end
end

function JumpToItem1(k)
    if jumpData and jumpData.sID then -- 跳转
        for i, item in ipairs(items) do
            if item.data:GetID() == jumpData.sID then
                item.OnClick()
                break
            end
        end
        if not jumpData.id then
            jumpData = nil
        end
    end
end

function JumpToItem2()
    if jumpData then -- 跳转
        local jumpIndex = 0
        for k, v in ipairs(towerDatas) do
            if v.cfg.id == jumpData.id then
                jumpIndex = k
                break
            end
        end
        if jumpIndex > 0 then
            layout:IEShowList(#towerDatas, nil, jumpIndex)
            -- tlua:AnimAgain()
            local lua = layout:GetItemLua(jumpIndex)
            if lua then
                lua.OnClick()
            end
            jumpData = nil
            return
        end
    end
    layout:IEShowList(#towerDatas, nil, 1)
    -- tlua:AnimAgain()
    local lua = layout:GetItemLua(1)
    if lua then
        lua.OnClick()
    end
end

function OnClickBack()
    CSAPI.SetGOActive(clickBack, false)
    PlayFades()
    if (currItem1) then
        currItem1.SetSelect(false)
        lastItem = currItem1
        currItem1 = nil
    end
    if currItem2 then
        currItem2.SetSelect(false)
        currItem2 = nil
        selIndex = 0
    end

    scrollRect.enabled = true
    ShowSecond()
end

function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.DupTower,
        title = LanguageMgr:GetByID(6019)
    })
end

function OnClickReturn()
    if itemInfo and itemInfo.IsShow() then
        OnClickBack()
        return
    end
    view:Close()
end

function OnDestroy()
    eventMgr:ClearListener()
end
