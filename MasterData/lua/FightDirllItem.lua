-- 训练物体
local cfg = nil

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    cfg = _data
    SetSel(_elseData == index)
    if cfg then
        -- name 
        CSAPI.SetText(txtName, cfg.name)
        -- desc
        CSAPI.SetText(txtDesc, cfg.desc)
        -- icon
        if cfg.icon then
            ResUtil.RoleCard:Load(icon, cfg.icon)
            CSAPI.SetScale(icon, 0.68, 0.68)
        end
    end
end

function GetIndex()
    return index
end

function SetSel(_isSel)
    CSAPI.SetGOActive(sel, _isSel)
end

function OnClick()
    if cb then
        cb(this)
    end
end
