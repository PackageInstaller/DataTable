function Refresh(_index, _elseData)
    _curIndex = _elseData[1]
    _animNum = _elseData[2]
    local isCur = _index == _curIndex
    local isPass = _index < _curIndex

    CSAPI.SetGOActive(imgGo, not isCur)
    CSAPI.SetGOActive(imgGoCur, isCur)
    CSAPI.SetGOActive(line, isCur)
    if (not isCur) then
        CSAPI.SetRTSize(gameObject, 54, 48)
        local name1 = isPass and "UIs/Rogue/img_22_01.png" or "UIs/Rogue/img_22_02.png"
        CSAPI.LoadImg(imgGo, name1, true, nil, true)
        local name2 = isPass and "UIs/Rogue/img_22_06.png" or "UIs/Rogue/img_22_07.png"
        CSAPI.LoadImg(imgPoint, name2, false, nil, true)
    else
        CSAPI.SetRTSize(gameObject, 118, 118)
        CSAPI.SetText(txtGoCur, _curIndex .. "")
        local whide = CSAPI.GetAnchor(gameObject) - 27
        CSAPI.SetRTSize(line, whide, 2)
    end
    -- 
    if (_animNum ~= nil and imgGoCur.activeInHierarchy) then
        if (_animNum == 1) then
            UIUtil:SetObjScale(imgGoCur1, 1.5, 1, 1.5, 1, 1, 1, nil, 300, 300)
            UIUtil:SetObjFade2(imgGoCur1, 0, 1, nil, 100, 300)
        else
            UIUtil:SetObjScale(imgGoCur1, 1.5, 1, 1.5, 1, 1, 1, nil, 400, 200)
            UIUtil:SetObjFade2(imgGoCur1, 0, 1, nil, 200, 200)
        end
    end
end
