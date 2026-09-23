local data = nil
local isSel = false
local isLock = false
local names = {}

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
    SetState()
end

function Refresh(_data,elseData)
    data =_data
    if data then
        SetLock()
        SetTitle()
        SetState()
        SetGet()
        SetSelect(elseData == index)
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle,LanguageMgr:GetByID(22081) .. StringUtil:IntToRoman(index))
end

function SetGet()
    CSAPI.SetGOActive(getImg,data:IsOver())
end

function SetState()
    CSAPI.SetGOActive(selImg,isSel)
    CSAPI.SetGOActive(nolImg,not isSel)
end

function SetLock()
    isLock =false
    if data:GetPreLimitID() then
        local _itemData = ShopMgr:GetFixedCommodity(data:GetPreLimitID())
        if _itemData and not _itemData:IsOver() then
            isLock = true
        end
    end
    CSAPI.SetGOActive(lockImg,false)
    CSAPI.SetGOAlpha(node,isLock and 0.5 or 1)
end

function OnClick()
    if cb then
        cb(this)
    end
end
