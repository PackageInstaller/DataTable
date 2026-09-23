local cb = nil
local canClick = true
local quality = nil

function Awake()
    image_bg = ComUtil.GetCom(bg, "Image")
end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function ActiveClick(isActive)
    image_bg.raycastTarget = isActive
end

function Refresh(_data)
    data = _data
    if data ~= nil and data.data ~= nil then
        SetIcon(data:GetIcon())
        SetLv(data:GetLv())
        SetQuality(data:GetQuality())
        CSAPI.SetGOActive(nilObj, true)
    else
        InitNull()
    end
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if iconName then
        ResUtil.RoleCard:Load(icon, iconName)
    end
end

function SetLv(lv)
    CSAPI.SetGOActive(lvObj, lv ~= nil)
    if lv then
        CSAPI.SetText(txt_lv, tostring(lv))
    end
end

function SetQuality(_quality)
    if quality ~= _quality then
        quality = _quality or 1
        local frame = TeamSeletFrame[quality]
        ResUtil.CardBorder:Load(bg, frame)
        local idx = _quality > 2 and quality or 3
        ResUtil.CardBorder:Load(qualityImg, "img_02_0" .. idx)
    end
end

function InitNull()
    SetQuality(1)
    SetIcon()
    SetLv()
    CSAPI.SetGOActive(nilObj, true)
    ActiveClick(false)
end

-- 点击
function OnClick()
    if cb then
        cb(this)
    end
end


function HideLv(b)
    CSAPI.SetGOActive(txt_lv, b) 
end