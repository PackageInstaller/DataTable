local data = nil
local mDatas = {}
local rDatas1 = {}
local rDatas2 = {}
local count = 0
local itemsL1 = nil
local itemsL2 = nil
local nextRefreshTime = 0
local time, timer = 0, 0
local arrowUtil = nil

function Awake()
    arrowUtil = ArrowUtil.New()
    arrowUtil:Init(sv, content, arrorL, arrorR)

    eventMgr = ViewEvent.New()
end

function OnEnable()
    eventMgr:AddListener(EventType.Mission_List, OnMissionRefresh);
end

function OnMissionRefresh(_data)
    if not _data then
        RefreshLeftPanel()
        return
    end

    local rewards = _data[2]
    RefreshLeftPanel()
    if (#rewards > 0 and not CSAPI.IsViewOpen("MissionActivity")) then
        UIUtil:OpenReward({rewards})
    end
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    arrowUtil:Update()

    UpdateTime()
end

function Refresh(_data, _elseData)
    data = _data
    if data then
        SetTime()
        RefreshLeftPanel()
        RefreshRightPanel()
    end
end

function SetTime()
    local sTime, eTime = data:GetStartTime(), data:GetEndTime()
    if sTime > 0 and eTime > 0 then
        local str1 = TimeUtil:GetTimeHMS(sTime, "%Y.%m.%d")
        local str2 = TimeUtil:GetTimeHMS(eTime, "%Y.%m.%d")
        CSAPI.SetText(txtTime1, str1 .. "-" ..str2)
        nextRefreshTime = TimeUtil:GetTime() > sTime and eTime or sTime
        local _time = GetRefreshTime()
        nextRefreshTime = (_time > 0 and nextRefreshTime > _time) and _time or nextRefreshTime
        time = nextRefreshTime - TimeUtil:GetTime()
    end
end

function GetRefreshTime()
    local infos = data:GetSummaryInfo() or {}
    local sTime, eTime = nil, nil
    local time = 0
    for i, v in ipairs(infos) do
        if v.sTime and v.eTime then
            sTime, eTime = TimeUtil:GetTimeStampBySplit(v.sTime), TimeUtil:GetTimeStampBySplit(v.eTime)
            if time == 0 or (time > sTime) then
                time = sTime
            end
            if time == 0 or (time > eTime) then
                time = eTime
            end
        end
    end
    return time
end

function UpdateTime()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = nextRefreshTime - TimeUtil:GetTime()
        if time <= 0 then
            SetTime()
            RefreshRightPanel()
        end
    end
end

function RefreshLeftPanel()
    SetMission()
    SetProgress()
    -- SetLAnimState()
    SetLItems()
    SetRed()
end

function SetMission()
    local info = data:GetMissionInfo()
    if info then
        mDatas = MissionMgr:GetActivityDatas(info[1], info[2],nil,true)
    end
end

function SetProgress()
    local cur, max = 0, #mDatas
    if max > 0 then
        for i, v in ipairs(mDatas) do
            if v:IsFinish() then
                cur = cur + 1
            end
        end
    end
    CSAPI.SetText(txtProgress1, cur .. "")
    CSAPI.SetText(txtProgress2, max .. "")
end

function SetLAnimState()
    for i = 1, 4 do
        if mDatas and mDatas[i] then
            CSAPI.SetGOActive(this["anim" .. i].gameObject, mDatas[i]:IsGet())
        end
    end
end

function SetLItems()
    for i = 0, 3 do
        local child = gridParent.transform:GetChild(i)
        if child and not IsNil(child.gameObject) then
            CSAPI.SetGOActive(child.gameObject, false)
        end
    end
    if #mDatas > 0 then
        local child, lua = nil, nil
        for i, v in ipairs(mDatas) do
            child = gridParent.transform:GetChild(i - 1)
            if child and not IsNil(child.gameObject) then
                CSAPI.SetGOActive(child.gameObject, true)
                lua = ComUtil.GetLuaTable(child.gameObject)
                if lua then
                    lua.Refresh(v)
                end
            end
        end
    end
end

function SetRed()
    UIUtil:SetRedPoint(redParentL,AnniversaryMgr:CheckRed(data:GetID()))
end

function RefreshRightPanel()
    SetDatas()
    SetRItems()
    SetSvWidth()
end

function SetDatas()
    local infos = data:GetSummaryInfo() or {}
    count = #infos
    rDatas2 = {}
    rDatas1 = {}
    if count > 0 then
        for i = 1, count do
            if i % 2 == 0 then -- 下边
                table.insert(rDatas2, infos[i])
            else
                table.insert(rDatas1, infos[i])
            end
        end
    end
end

function SetRItems()
    itemsL1 = itemsL1 or {}
    ItemUtil.AddItems("Anniversary1/AnniversaryTimestItem2", itemsL1, rDatas1, itemParent1, OnItemClickCB,1,{group = data:GetGroup(),posType = 1})
    itemsL2 = itemsL2 or {}
    ItemUtil.AddItems("Anniversary1/AnniversaryTimestItem2", itemsL2, rDatas2, itemParent2, OnItemClickCB,1,{group = data:GetGroup(),posType = 2})
end

function OnItemClickCB(item)
    if item.GetJumpId() then
        JumpMgr:Jump(item.GetJumpId())
    end
end

function SetSvWidth()
    local width = 2303 + (count * 283)
    local size = CSAPI.GetRTSize(content)
    CSAPI.SetRTSize(content, width, size[1])
    arrowUtil:RefreshLen()
end

function OnClickJump()
    local info = data:GetMissionInfo()
    if info then
        CSAPI.OpenView("MissionActivity", {
            type = info[1],
            group = info[2]
        })
    end
    AnniversaryMgr:TrackEvents("anniversary_mission_button")
end
