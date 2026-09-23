local data = nil
local isSel = false
local time,timer,refreshTime=0,0,0
local isOpen = false
local isOver = false
local cfgDungeon = nil

function Awake()
    InitAnim()
end

function SetIndex(idx)
   index = idx 
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(sel,b)
    CSAPI.SetGOActive(lock1,not b)
    CSAPI.SetGOActive(lock2,not b)
    SetPos()
    SetState()
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        LanguageMgr:SetText(txtTime,76211,TimeUtil:GetTimeStr10(time))  
        if time <= 0 then
            SetTime()
        end
    end
end

function Refresh(_data)
    data = _data
    if data then
        cfgDungeon = data:GetDungeonCfg()
        isOpen = data:IsOpen()
        isOver = data:IsOver()
        Log(string.format("Boss名：%s|开启时间：%s|结算时间：%s|结束时间：%s",cfgDungeon and cfgDungeon.name,TimeUtil:GetTimeStr2(data:GetStartTime()),TimeUtil:GetTimeStr2(data:GetDupOverTime()),TimeUtil:GetTimeStr2(data:GetEndTime())))
        SetPos()
        SetName()
        SetTime()
        SetState()
        SetIcon()
    end
end

function SetPos()
    CSAPI.SetLocalPos(move,isSel and 40 or 0,0)
end

function SetName()
    CSAPI.SetText(txtName,cfgDungeon and cfgDungeon.name)
end

function SetTime()
    time = 0
    if isOver then
        LanguageMgr:SetText(txtTime,76215)
    elseif isOpen then
        LanguageMgr:SetText(txtTime,76213)
    else
        refreshTime = data:GetStartTime()
        time = refreshTime - TimeUtil:GetTime()
    end
end

function SetState()
    CSAPI.SetTextColorByCode(txtName,isSel and "000000" or "ffffff")
    CSAPI.SetTextColorByCode(txtTime,isSel and "ff8400" or "b2b2b2")
    CSAPI.SetAnchor(txtName,isSel and -5 or -2,16)
    CSAPI.SetAnchor(txtTime,isSel and -16 or -13,-17)
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName and iconName~= "" then
        ResUtil.PeriodicBoss:Load(icon,iconName)
    end
end

function OnClick()
    if cb then
        cb(this)
    end
end

function GetData()
    return data
end

---------------------------------------------anim---------------------------------------------
local anim = nil
function InitAnim()
    anim = ComUtil.GetCom(move,"Animator")
end

function ShowSelAnim(b)
    if not IsNil(anim) then
        anim:Play(b and "BossItem1_Sel" or "BossItem1_Nsel")
    end
    SetSelect(b)
end