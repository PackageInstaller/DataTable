local data = nil
local pSlide = nil
local isFinish = false
local cfgDungeon = nil

function Awake()
    pSlide = ComUtil.GetCom(sliderPrograss,"Slider")
end

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    data = _data    
    if data then
        cfgDungeon = Cfgs.MainLine:GetByID(data:GetDungeonId())
        SetIcon()
        SetPrograss()
        SetFinish()
    end
end

function SetIcon()
    local iconName= data:GetIcon() .. "_01"
    ResUtil.VirCat:Load(bg,iconName)
end

function SetPrograss()
    local cur,max = data:GetProgress()
    isFinish = cur <= 0
    CSAPI.SetText(txtPrograss, math.floor(cur / max * 10000 + 0.5) / 100 .. "")
    pSlide.value = cur / max
end

function SetFinish()
    CSAPI.SetGOActive(finishObj,isFinish)
end

function OnClick()
    if isFinish then
        return
    end
    if cb then
        cb(this)
    end
end

function GetCfg()
    return cfgDungeon
end

function GetProgress()
    local cur,max = 0,0
    if data then
        cur,max =data:GetProgress()
    end
    return cur,max
end

function GetData()
    return data
end

function IsKill()
    return data and data:IsPass()
end