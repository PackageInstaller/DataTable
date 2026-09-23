local iconNames = {"btn_18_01.png", "btn_19_01.png"}

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_lanID, _curIndex)

    isSelect = index == _curIndex

    LanguageMgr:SetText(txtTitle1, _lanID)
    LanguageMgr:SetEnText(txtTitle2, _lanID)

    CSAPI.SetGOActive(bg, isSelect)

    CSAPI.LoadImg(icon, "UIs/Dorm2/" .. iconNames[index], true, nil, true)
end

function OnClick()
    if (cb) then
        cb(index)
    end
end
