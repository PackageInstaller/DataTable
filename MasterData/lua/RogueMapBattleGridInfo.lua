local data = nil
local bossTime, time = 0, 0
local supTime, time3 = 0, 0
local timer = 0
local isSupport = false

function Update()
    if timer < Time.time then
        timer = Time.time + 1
        UpdateSupportTime()
        UpdateBossTime()
    end
end

function Refresh(_data)
    data = _data
    if data then
        RefreshPanel()
    end
end

function RefreshPanel()
    SetSupport()
    SetBoss()
    if data.type == eRogueMapPosType.SpecialBoss then
        CSAPI.SetGOActive(txtObj1, time3 > 0 or time > 0)
    else
        CSAPI.SetGOActive(txtObj1,false)
    end
end

function SetSupport()
    supTime = data.supTime or 0
    if supTime and supTime > 0 then
        time3 = supTime - TimeUtil:GetTime() 
    end
end

function UpdateSupportTime()
    if time3 > 0 then
        time3 = supTime - TimeUtil:GetTime()
        CSAPI.SetText(txtTime1, TimeUtil:GetTimeStr(time3))
        if time3 <= 0 then
            RefreshPanel()
        end
    end
end

function SetBoss()
    if data.specTime and not IsSupport() then
        bossTime = data.specTime
        time = bossTime - TimeUtil:GetTime()
    end
end

function UpdateBossTime()
    if IsSupport() then -- 有支援
        return
    end
    if time > 0 then
        time = bossTime - TimeUtil:GetTime()
        CSAPI.SetText(txtTime1, TimeUtil:GetTimeStr(time))
        if time <= 0 then
            RefreshPanel()
        end
    end
end

function IsSupport()
    return time3 > 0
end

