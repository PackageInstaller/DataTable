local data = nil
local isLock = false
local isHas = false
local isSelect=false;

function SetIndex(idx)
    index= idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)
    data = _data
    isSelect = _elseData
    if data then
        SetIcon()
        SetName()
        SetState()
    end
    SetSelect(isSelect)
end

function SetSelect(_isSelect)
    isSelect=_isSelect
    CSAPI.SetGOActive(selectObj,_isSelect==true)
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName~=nil and iconName~="" then
        ResUtil.IconGoods:Load(icon,iconName)
    end
    ResUtil.GoodsBorder:Load(border,"btn_1_0" .. (data:GetQuality() or 1))
end

function SetName()
    CSAPI.SetText(txt_name,data:GetName())
end

function SetState()
    local num = BagMgr:GetCount(data:GetID())
    isHas = num > 0
    CSAPI.SetGOActive(lockObj,num <= 0 and isLock)
    if isHas then
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(18068));
    elseif isLock then
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(18185));
    end
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