function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_lv, _elseData)
    lv = _lv
    breakLv = _elseData
    --
    local alpha = breakLv >= lv and 1 or 0.3
    CSAPI.SetGOAlpha(normal, alpha)
    CSAPI.SetGOActive(sel, breakLv == lv)

    local imgName = breakLv >= lv and "img_1_0" or "img_2_0"
    ResUtil.RoleCard_BG:Load(normal, imgName .. lv)
end

function SetItemAnim(_target)
    local x1, y1, z1 = CSAPI.GetPos(_target)
    CSAPI.SetPos(normal, x1, y1, z1)
    local x2, y2 = CSAPI.GetAnchor(normal)
    CSAPI.SetGOIgnoreAlpha(normal, true)
    UIUtil:SetPObjMove(normal, x2, 0,y2, 0, 0, 0, nil, 300, 1)
    UIUtil:SetObjScale(normal, 0.6, 1, 0.6, 1, 1, 1, function()
        CSAPI.SetGOIgnoreAlpha(normal, false)
    end, 300, 0)
end

function OnClick()
    cb(this)
end

