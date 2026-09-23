local ud = 1

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    cg_ud1 = ComUtil.GetCom(objUD1, "CanvasGroup")
    cg_ud2 = ComUtil.GetCom(objUD2, "CanvasGroup")
end

function Refresh(_data, _elseData)
    data = _data
    elseData = _elseData
    if (elseData[1] == index) then
        ud = elseData[2]
    else
        ud = 1
    end

    CSAPI.SetText(txtName, data.sName)
    SetSelect()
end

function SetSelect()
    isSelect = index == elseData[1]
    CSAPI.SetGOActive(select, isSelect)

    cg_ud1.alpha = ud == 1 and 1 or 0.2
    cg_ud2.alpha = ud == 2 and 1 or 0.2
end

function OnClick()
    local sort = {1, 1}
    if (isSelect) then
        sort[1] = index
        sort[2] = ud == 1 and 2 or 1
    else
        sort[1] = index
        sort[2] = ud
    end
    if (cb) then
        cb(sort)
    end
end
