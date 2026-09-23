local sectionData = nil
local actionMove = nil
--time
local openInfo = nil
local timer = 0
local time = 0

function Awake()
    SetSelect(false)
    actionMove =ComUtil.GetCom(move,"ActionMoveByCurve")
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
            EventMgr.Dispatch(EventType.Trials_List_Refresh)
        end
    end
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg,b)
end

function Refresh(_data)
    sectionData = _data
    if sectionData then
        SetTime()
        SetName()
        SetIcon()
    end
end

function SetName()
    CSAPI.SetText(txtName,sectionData:GetName())
end

function SetIcon()
    local iconName = sectionData:GetIcon2()
    if iconName ~= nil and iconName ~= "" then
        ResUtil.TrialsPage:Load(icon,iconName)
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

---------------------------------------------anim
function ShowRefreshAction(delay)
    FuncUtil:Call(function ()
        if not IsNil(actionMove) then
            actionMove:Play()
        end
        UIUtil:SetObjFade(node,0,1,nil,240)
    end,this,delay)
end