local sectionData = nil
local mSlider = nil
local info = nil
local actionMove = nil
--time
local openInfo = nil
local timer = 0
local time = 0

function Awake()
    mSlider = ComUtil.GetCom(slider,"Slider")

    actionMove = ComUtil.GetCom(move,"ActionMoveByCurve")
end

function Update()
    if not sectionData or not openInfo then
        return
    end

    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = openInfo:GetUpTime(sectionData:GetID())
        local timeTab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 37043, timeTab[1],timeTab[2])
        if time <= 0 then
            RefreshPanel()
        end
    end
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    sectionData = _data
    if sectionData then
        info = sectionData:GetInfo()
        SetTime()
        SetIcon()
        SetMission()
        SetTitle()
    end
end

function RefreshPanel()
    SetTime()
    SetIcon()
    SetMission()
    SetTitle()
end

function SetTitle()
    CSAPI.SetText(txtName,StringUtil:SetByColor(sectionData:GetName(),time > 0 and "ffc146" or "ffffff"))
end

function SetIcon()
    local iconName = sectionData:GetIcon()
    if iconName ~= nil and iconName ~= "" then
        ResUtil.TrialsHead:Load(bgIcon,iconName)
    end
    local iconName3 = sectionData:GetIcon3()
    if iconName3 ~= nil and iconName3 ~= "" then
        if time > 0 then
            ResUtil.TrialsHead:Load(bossIcon,iconName3 .. "_02")
        else
            ResUtil.TrialsHead:Load(bossIcon,iconName3 .. "_01")
        end
    end
end

function SetMission()
    CSAPI.SetGOActive(missionObj,time > 0)
    if time > 0 then
        if info and info.taskType then
            local missionDatas = MissionMgr:GetActivityDatas(info.taskType,sectionData:GetID()) or {}
            local cur,max = 0,1
            if #missionDatas > 0 then
                max = #missionDatas
                for i, v in ipairs(missionDatas) do
                    if v:IsFinish() then
                        cur = cur + 1
                    end
                end
            end
            CSAPI.SetText(txtPercent, math.floor(cur/max * 100) .. "%")
            mSlider.value = cur/max
        end
    end
end

function SetTime()
    openInfo = sectionData:GetOpenInfo()
    if openInfo then
        time = openInfo:GetUpTime(sectionData:GetID())
    end
    CSAPI.SetGOActive(timeObj,time>0)
end

function GetData()
    return sectionData
end

function OnClick()
    if cb then
        cb(this)
    end
end

---------------------------------------------anim---------------------------------------------
function ShowRefreshAction(delay)
    UIUtil:SetObjFade(node,0,1,nil,240,delay)
    FuncUtil:Call(function ()
        if not IsNil(actionMove) then
            actionMove:Play()
        end
    end,this,delay)
end