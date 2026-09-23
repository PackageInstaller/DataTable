local cfg = nil
function Awake()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    CSAPI.SetGOActive(selImg,b)
end

function Refresh(_data)
    cfg = _data
    if cfg then
        SetName()
        SetDesc()
        SetIcon()
    end
end

function SetName()
    CSAPI.SetText(txtName,cfg.name)
end

function SetDesc()
    CSAPI.SetText(txtDesc,cfg.desc)
end

function SetIcon()
    if cfg.icon and cfg.icon ~= "" then
        ResUtil.BuffChain:Load(icon,cfg.icon)
    end
end

function OnClick()
    if cb then
        cb(this)
    end
end