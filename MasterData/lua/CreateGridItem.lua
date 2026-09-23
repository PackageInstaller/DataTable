function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

-- data : CRoleInfo
function Refresh(_data)
    data = _data
    -- bg
    SetBg(data:GetQuality())
    -- icon
    SetIcon(data:GetIcon())
end

function SetBg(quality)
    local q = quality > 6 and 6 or quality
    CSAPI.LoadImg(bg, "UIs/Grid/img_29_0" .. q .. ".png", true, nil, true)
end

function SetCount(num)
    CSAPI.SetText(txt_count, num .. "")
end

function SetIcon(_iconName)
    if (_iconName) then
        ResUtil.IconGoods:Load(icon, _iconName .. "", false, function()
            CSAPI.SetGOActive(icon, true)
        end)
    end
end

