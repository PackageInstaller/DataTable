function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    isSelect = _elseData == index
    local code = isSelect and "ffci46" or "929296"
    local str = CRoleDisplayMgr:GetYSName(index)
    local alpha = isSelect and 1 or 0.5
    local imgName = isSelect and "img9_11_01.png" or "img9_11_02.png"
    StringUtil:SetColorByName(txtName, str, code)
    CSAPI.SetImgColorByCode(lines, code, true)
    CSAPI.SetGOAlpha(lines, alpha)
    CSAPI.LoadImg(bg, "UIs/CRoleDisplay/" .. imgName, false, nil, true)
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
