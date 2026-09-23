function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end
function Refresh(data)
    local str = index < 10 and "0" .. index or index .. ""
    CSAPI.SetText(txt_index, str)
    CSAPI.SetText(txt_desc, data.desc)
end

function OnClick()
    cb(index)
end
