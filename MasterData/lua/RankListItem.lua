local data = nil

function Awake()
    SetSelect()
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb =_cb
end

function SetSelect(b)
    CSAPI.SetGOActive(normal,not b)
    CSAPI.SetGOActive(sel,b)
end

function Refresh(_data)
    data = _data
    if data then
        SetTitle()
    end
end

function SetTitle()
    if data.cfg then
        CSAPI.SetText(txtNol,data.title or "")
        CSAPI.SetText(txtSel,data.title or "")
    end
end

function OnClick()
    if cb then
        cb(this)
    end
end