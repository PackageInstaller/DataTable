function SetClickCB(_cb)
    cb =_cb
end

function Refresh(_data)
    data = _data
    if data then
        SetIcon(data.icon1,data.icon2)
    end
end

function SetIcon(iconName1,iconName2)
    if iconName1 and iconName1~="" then
        ResUtil.BuffChain:Load(icon1,iconName1)
    end
    if iconName2 and iconName2~="" then
        ResUtil.RoleCard:Load(icon2,iconName2)
    end
end

function OnClick()
    if cb then
        cb(this)
    end
end