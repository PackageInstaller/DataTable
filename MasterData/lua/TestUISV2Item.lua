function SetIndex(_index)
    index = _index
end

function Refresh(_data, _curSelect, _cb)
    data = _data
    cb = _cb
    CSAPI.SetText(txt, data .. "")
    isSelect = index == _curSelect
    SetItemScale()
end

function SetItemScale()
    size = isSelect and 200 or 100
    CSAPI.SetRTSize(gameObject, 100, size)
end

function OnClick()
    isSelect = not isSelect
    SetItemScale()

    cb(index)
end
