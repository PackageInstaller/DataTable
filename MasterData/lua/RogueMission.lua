curIndex1, curIndex2 = 1, 1 -- 父index,子index
local ids = {}
local idIndex = -1
local timer = 0
local time = 0
local curDatas = {}

function Awake()
    UIUtil:AddTop2("RogueMission", gameObject, function()
        view:Close()
    end, nil, {})

    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    layout = ComUtil.GetCom(sv, "UIInfinite")
    layout:Init("UIs/Rogue/RogueMissionItem", LayoutCallBack, true)
end

function OnInit()
    UIUtil:AddTop2("MissionView", gameObject, function()
        view:Close()
    end)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if (not _data) then
            RefreshPanel()
            return
        end
        local rewards = _data[2]
        RefreshPanel()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
    end)
end

function OnDisable()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data,CloseCB)
    end
end

function CloseCB()
    view:Close()
end

function OnTabChanged(_index)
    idIndex = _index + 1
    SetItems2()
end

function OnOpen()
    -- time
    timer = 0
    time = RogueMgr:GetRogueTime()
    CSAPI.SetGOActive(txtTime, time > 0)

    InitTabs()
    InitLeftPanel()
    RefreshPanel()
end

function Update()
    if (time > 0 and Time.time > timer) then
        timer = Time.time + 1
        time = RogueMgr:GetRogueTime()
        local timeData = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 50001, timeData[1], timeData[2], timeData[3])
        if (time <= 0) then
            curIndex1 = 1
            InitLeftPanel()
            RefreshPanel()
            CSAPI.SetGOActive(txtTime, time > 0)
        end
    end
end

function InitTabs()
    local tzDatas = RogueMgr:GetDatas(2)
    for k, v in ipairs(tzDatas) do
        ids[k] = v:GetID()
        CSAPI.SetText(this["txtItem" .. k], v:GetCfg().name)
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = time > 0 and {{50003, "Rogue/img_02_03"}, {50004, "Rogue/img_02_04"}} or
                          {{50003, "Rogue/img_02_03"}}
    local leftChildDatas = {}
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    CSAPI.SetGOActive(btnGetAll, curIndex1 == 1)
    CSAPI.SetGOActive(tabs, curIndex1 == 2)
    CSAPI.SetGOActive(white1, curIndex1 == 1)
    CSAPI.SetGOActive(white2, curIndex1 == 1)
    -- items 
    SetItems()
    -- 侧边动画
    leftPanel.Anim()
    -- btn 
    SetBtn()
    -- 
    CSAPI.SetGOActive(timeObj, curIndex1 == 2)
    -- 红点
    SetRed()
end

-- 红点添加或者移除
function SetRed()
    -- 
    local hadRed = RogueMgr:IsRed()
    for i, v in ipairs(leftPanel.leftItems) do
        local isRed = false
        if (hadRed) then
            isRed = MissionMgr:CheckRed2(eTaskType.Rogue, i)
        end
        v.SetRed(isRed)
    end
    -- 
    if (curIndex1 == 2) then
        for k = 1, 7 do
            local isRed = false
            for p, v in ipairs(allDatas) do
                if (v:GetCfg().nStage == ids[k]) then
                    if (v:CheckIsOpen() and v:IsFinish() and not v:IsGet()) then
                        isRed = true
                        break
                    end
                end
            end
            UIUtil:SetRedPoint(this["item" .. k], isRed, 83, 28, 0)
        end
    end
end

function SetItems()
    curDatas = {}
    allDatas = MissionMgr:GetArr({eTaskType.Rogue},true)
    if (curIndex1 == 1) then
        for k, v in ipairs(allDatas) do
            if (v:GetCfg().nStage == nil) then
                table.insert(curDatas, v)
            end
        end
        layout:IEShowList(#curDatas)
    else
        if (idIndex == -1) then
            tab.selIndex = 0
        else
            SetItems2()
        end
    end
end

function SetItems2()
    if (curIndex1 ~= 2) then
        return
    end
    curDatas = {}
    local id = ids[idIndex]
    for k, v in ipairs(allDatas) do
        if (v:GetCfg().nStage == id) then
            table.insert(curDatas, v)
        end
    end
    layout:IEShowList(#curDatas)
end

function SetBtn()
    isHad = false
    for i, v in ipairs(curDatas) do
        local get = v:IsGet()
        local finish = v:IsFinish()
        if (not get and finish) then
            isHad = true
            break
        end
    end
    local canvasGroup = ComUtil.GetOrAddCom(btnGetAll, "CanvasGroup")
    canvasGroup.alpha = isHad and 1 or 0.3
end

function OnClickGetAll()
    if (isHad) then
        TaskProto:GetRewardByType(eTaskType.Rogue, curDatas[1]:GetCfg().nGroup)
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
