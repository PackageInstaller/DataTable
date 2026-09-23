local data = nil
local isPass = false
local isSel = false
local cfgDungeon = nil

function Awake()
    SetSelect()
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
end

function Refresh(_data)
    data = _data
    if data then
        isPass = data:IsPass()
        cfgDungeon = Cfgs.MainLine:GetByID(data:GetDungeonId())
        SetIcon()
        SetPass()
    end
end

function SetIcon()
    local iconName= data:GetIcon() .. "_02"
    ResUtil.VirCat:Load(icon,iconName)
end

function SetPass()
    CSAPI.SetGOActive(clearObj,isPass)
end

function OnClick()
    -- if isPass then
    --     return
    -- end
    if cb then
        cb(this)
    end
end

function GetData()
    return data
end

function GetName()
    return cfgDungeon and cfgDungeon.name
end

function GetID()
    return data and data:GetID()
end

function IsKill()
    return data and data:IsPass()
end