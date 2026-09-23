local data = nil
local time, timer, nextRefreshTime = 0, 0, 0
local arrowUtil = nil
-- left
local mCfgs = nil
local score = 0
local proSlider = nil
local items1 = nil
--right
local rDatas = nil
local items2 = nil

function Awake()
    proSlider = ComUtil.GetCom(sliderPro,"Slider")

    arrowUtil = ArrowUtil.New()
    arrowUtil:Init(sv, content, arrorL, arrorR)

    eventMgr = ViewEvent.New()
end

function OnEnable()
    eventMgr:AddListener(EventType.Mission_List, RefreshLeftPanel);
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    arrowUtil:Update()

    UpdateTime()
end

function Refresh(_data)
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
        CSAPI.SetText("txtTime1", TimeUtil:GetTimeHMS(sTime, "%m/%d"))
        CSAPI.SetText("txtTime2", TimeUtil:GetTimeHMS(sTime, "%H:%M"))
        CSAPI.SetText("txtTime3", TimeUtil:GetTimeHMS(eTime, "%m/%d"))
        CSAPI.SetText("txtTime4", TimeUtil:GetTimeHMS(eTime, "%H:%M"))
        nextRefreshTime = TimeUtil:GetTime() > sTime and eTime or sTime
        local _time = GetRefreshTime()
        nextRefreshTime = (_time > 0 and nextRefreshTime > _time) and _time or nextRefreshTime
        time = nextRefreshTime - TimeUtil:GetTime()
    end
end

function GetRefreshTime()
    local infos = data:GetSummaryInfo() or {}
    local sTime, eTime = nil, nil
    local _time = 0
    for i, v in ipairs(infos) do
        if v.sTime and v.eTime then
            sTime, eTime = TimeUtil:GetTimeStampBySplit(v.sTime), TimeUtil:GetTimeStampBySplit(v.eTime)
            if _time == 0 or (_time > sTime) then
                _time = sTime
            end
            if _time == 0 or (_time > eTime) then
                _time = eTime
            end
        end
    end
    return _time
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
    SetTime()
    SetProgress()
    SetLItems()
    SetRed()
end

function SetTime()
    local sTime, eTime = data:GetStartTime(), data:GetEndTime()
    CSAPI.SetText(txtTime1, TimeUtil:GetTimeHMS(sTime, "%m/%d"))
    CSAPI.SetText(txtTime2, TimeUtil:GetTimeHMS(sTime, "%H:%M"))
    CSAPI.SetText(txtTime3, TimeUtil:GetTimeHMS(eTime, "%m/%d"))
    CSAPI.SetText(txtTime4, TimeUtil:GetTimeHMS(eTime, "%H:%M"))
end

function SetProgress()
    local info = data:GetMissionInfo()
    if info then
        score = MissionMgr:GetAnniversaryInfo(info[2])
        local cfgReward = Cfgs.CfgAnniversaryStarReward:GetByID(info[2])
        if cfgReward and cfgReward.infos then
            mCfgs = {}
            local cur = 0
            for i, v in ipairs(cfgReward.infos) do
                if v.star and score >= v.star then
                    cur = cur + 1
                end
                table.insert(mCfgs,v)
            end
            CSAPI.SetText(txtNum2,"/" .. #mCfgs)
            CSAPI.SetText(txtNum1,"" .. cur)
            proSlider.value = cur / #mCfgs
        end
        CSAPI.SetText(txtGood,"x" .. score)
    end
end

function SetLItems()
    items1 = items1 or {}
    ItemUtil.AddItems("Anniversary3/AnniversaryMain2Item",items1,mCfgs,itemParent1,nil,1,score)
end

function SetRed()
    UIUtil:SetRedPoint(redParent,AnniversaryMgr:CheckRed(data:GetID()))
end

function RefreshRightPanel()
    SetDatas()
    SetRItems()
    SetSvWidth()
end

function SetDatas()
    rDatas = data:GetSummaryInfo() or {}
end

function SetRItems()
    items2 = items2 or {}
    ItemUtil.AddItems("Anniversary3/AnniversaryMain2Item2",items2,rDatas,itemParent2,OnItemClickCB,1,{group = data:GetGroup()})
end

function OnItemClickCB(item)
    if item.GetJumpId() then 
        JumpMgr:Jump(item.GetJumpId())
    end
end

function SetSvWidth()
    local w1 = 2328 + (#rDatas * 424) + 200
    CSAPI.SetRTSize(content,w1,0)
    CSAPI.SetRTSize(bgContent, 409 + (#rDatas * 424) + 200,820)
    arrowUtil:RefreshLen()
end

function OnClickJump()
    local info = data:GetMissionInfo()
    if info then
        CSAPI.OpenView("AnniversaryMission", data)
    end
end
