local data =nil

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    local id =_data and _data.id or 0
    data =AchievementMgr:GetData(id)
    if data then
        SetBG()
        SetIcon()
        SetName()
    end
end

function SetBG()
    local num = data:GetQuality() or 1
    num = num < 10 and "0" .. num or num .. ""
    local bgName = "img_" .. num .. "_01"
    ResUtil.AchievementQua:Load(bg,bgName)
end

function SetIcon()
    local iconName1 = data:GetIcon()
    CSAPI.SetGOActive(icon1,iconName1~=nil and iconName1~="")
    if iconName1~=nil and iconName1~="" then
        ResUtil.Achievement:Load(icon1, iconName1)
    end
    local iconName2 = data:GetIcon2()
    CSAPI.SetGOActive(icon2,iconName2~=nil and iconName2~="")
    if iconName2~=nil and iconName2~="" then
        ResUtil.Achievement:Load(icon2, iconName2)
    end
end

function SetName()
    CSAPI.SetText(txtName, data:GetName())
    CSAPI.SetGOActive(txt_next,data:GetPostposition() ~= nil)
end

function SetSibling(_index)
    _index = _index or 0
    if _index == -1 then
        transform:SetAsLastSibling()
    else
        transform:SetSiblingIndex(_index)
    end
end

function GetData()
    return data
end
