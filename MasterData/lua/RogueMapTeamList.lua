local teamData = nil
local items = {}
local info = nil
local coolTime = 0
local time, timer = 0, 0
local isCool = false

function Awake()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(selObj, b)
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = coolTime - TimeUtil:GetTime()
        CSAPI.SetText(txtTime,TimeUtil:GetTimeStr(time))
        if time <= 0 then
            SetCool()
        end
    end
end

-- teamData: TeamData
function Refresh(_data,_elseData)
    teamData = _data
    info = _elseData or {}
    if teamData then
        SetName()
        SetFight()
        SetItems()
        SetCool()
    end
end

function SetName()
    CSAPI.SetText(txtName, teamData:GetTeamName())
end

function SetFight()
    local haloStrength = teamData:GetHaloStrength();
    CSAPI.SetText(txtFight, tostring(teamData:GetTeamStrength() + haloStrength));
end

function SetItems()
    local num = 0
    for i = 1, 5 do
        if i > #items then
            ResUtil:CreateUIGOAsync("TeamConfirm/TeamConfirmGrid", itemParent, function(go)
                table.insert(items, ComUtil.GetLuaTable(go));
                num = num + 1
                if num == 5 then
                    OnItemLoadSuccess()
                end
            end);
        end
    end
end

function OnItemLoadSuccess()
    if #items > 0 then
        local data = nil
        for i, v in ipairs(items) do
            data = teamData:GetItemByIndex(i);
            v.Refresh(data, i);
            if data == nil then
                v.SetDisable(true)
            end
        end
    end
end

function SetCool()
    coolTime = (info and info.times) and info.times[index] or 0
    if coolTime > 0 then
        time = coolTime - TimeUtil:GetTime()
        isCool = time > 0
    else
        isCool = false
    end
    CSAPI.SetGOActive(coolObj, isCool)
end

function GetTeamIndex()
    return teamData:GetIndex()
end

function GetGridId()
    return info and info.id
end

function IsCool()
    return isCool
end

function OnClick()
    if isCool then
        return
    end
    if cb then
        cb(this)
    end
end
