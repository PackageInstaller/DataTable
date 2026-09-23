local data = nil
local items = nil

function Awake()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetClickCB2(_cb)
    cb2 = _cb
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(selObj, b)
end

function Refresh(_data)
    data = _data
    if data then
        SetTitle()
        SetTime()
        SetDamage()
        SetReward()
        SetCards()
    end
end

function SetTitle()
    LanguageMgr:SetText(txtName, 380071, index)
end

function SetTime()
    CSAPI.SetText(txtTime,TimeUtil:GetTimeHMS(data:GetTime(),"%Y.%m.%d"))
end

function SetDamage()
    CSAPI.SetText(txtDamage,LanguageMgr:GetByID(380063) .. data:GetDamage())
end

function SetReward()
    local rewards = data:GetRewards()
    if rewards and rewards[1] then
        CSAPI.SetText(txtReward,LanguageMgr:GetByID(380064) .. rewards[1].num)
    end
end

function SetCards()
    items = items or {}
    local datas = data:GetCards()
    ItemUtil.AddItems("VirtualCataclysm/VirtualCataclysmCard", items, datas, gridParent)
end

function OnClick()
    if cb then
        cb(this)
    end
end

function OnClickReplace()
    if cb2 then
        cb2(this)
    end
end

function GetDataIndex()
    return data and data:GetIndex()
end
