local sectionData = nil
local info = nil
local actionMove = nil
--badge
local items = nil
local currX,lastX = 0,1
local len,svLen = 0,0
--time
local openInfo = nil
local timer = 0
local time = 0


function Awake()
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
    SetMission()
    SetTitle()
end

function SetIcon()
    local iconName = sectionData:GetIcon1()
    if iconName ~= nil and iconName ~= "" then
        ResUtil.TrialsList:Load(icon,iconName)
    end
end

function SetMission()
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
            CSAPI.SetGOActive(txtMax, true)
            CSAPI.SetText(txtMax,"/" .. max)
            CSAPI.SetText(txtCur,"" .. cur)
        else
            CSAPI.SetGOActive(txtMax, false)
        end
    else
        CSAPI.SetGOActive(txtMax, false)
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle,StringUtil:SetByColor(sectionData:GetName(),time > 0 and "ffc146" or "ffffff"))
    CSAPI.SetAnchor(txtTitle,239,time > 0 and 21 or 0)
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
