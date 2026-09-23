local info = nil
local comm = nil
local isGet,isCurDay,isLock = false,false,false

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
    CSAPI.SetGOActive(selImg1,b)
    CSAPI.SetGOActive(selImg2,b)
end

function Refresh(_data,_elseData)
    info = _data
    local day = _elseData and _elseData.day
    if info then
        comm = ShopMgr:GetFixedCommodity(info.goodsId)
        isGet = index <= day and comm:IsOver()
        isCurDay = index == day
        isLock = index > day
        SetText()
        SetIcon()
        SetState()
    end
end

function SetText()
    LanguageMgr:SetText(txtDay,311001,index)
end

function SetIcon()
    local iconName = comm:GetIcon()
    if iconName and iconName~= "" then
        ResUtil.IconGoods:Load(icon,iconName)
    end
end

function SetState()
    CSAPI.SetGOActive(get,isGet)
    CSAPI.SetGOActive(lock,isLock)
    CSAPI.SetGOActive(nol,isCurDay or isGet)
    CSAPI.SetGOAlpha(iconParent,(isCurDay or isGet) and 1 or 0.5)
end

function GetComm()
    return comm
end

function OnClick()
    if cb then
        cb(this)
    end
end