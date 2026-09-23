local data = nil
local isLock = false
local isHas = false

function SetIndex(idx)
    index= idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)
    data = _data
    isLock = _elseData
    if data then
        SetIcon()
        SetName()
        SetState()
    end
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName~=nil and iconName~="" then
        ResUtil.IconGoods:Load(icon,iconName)
    end
    ResUtil.LovePlusShop:Load(border,"img_08_0" .. (data:GetQuality() or 1))
end

function SetName()
    CSAPI.SetText(txtName,data:GetName())
end

function SetState()
    local num = BagMgr:GetCount(data:GetID())
    isHas = num > 0
    CSAPI.SetGOActive(lockObj,num <= 0 and isLock)
    CSAPI.SetGOActive(getObj,num > 0)
end

function OnClick()
    if isHas then
        return
    end
    if cb then
        cb(this)
    end
end