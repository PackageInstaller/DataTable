local data =nil
local slider = nil
function Awake()
    slider = ComUtil.GetCom(numSlider,"Slider")
end

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index = idx
end

--AchievementListData
function Refresh(_data)
    data = _data
    if data then
        SetIcon()
        SetName()
        SetNum()
    end
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName~= nil and iconName~="" then
        ResUtil.AchievementType:Load(icon,iconName)
    end
end

function SetName()
    CSAPI.SetText(txtName,data:GetName())   
end

function SetNum()
    local cur,max = data:GetCount()
    CSAPI.SetText(txtNum1,"/"..max)
    CSAPI.SetText(txtNum2,cur.."")
    slider.value = cur/max
end

function GetData()
    return data
end

function OnClick()
    if cb then
        cb(this)
    end
end