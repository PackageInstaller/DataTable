local item = nil
local isSel = false

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
    isSel = b
    if item ~= nil then
        item.SetSelect(isSel)
    end
    SetState()
end

function Refresh(_cfg)
    cfg = _cfg
    if cfg then
        SetItem()
        SetName()
        SetDesc()
        SetScore()
    end
end

function SetItem()
    if item == nil then
        local go = ResUtil:CreateUIGO("BuffBattle/BuffBattleItem2",iconParent.transform)
        item = ComUtil.GetLuaTable(go)
    end
    item.Refresh(cfg)
end

function SetState()
    CSAPI.SetGOActive(nol,not isSel)
    CSAPI.SetGOActive(sel,isSel)
    CSAPI.SetTextColorByCode(txtDesc,isSel and "ffc146" or "ffffff")
    CSAPI.SetTextColorByCode(txtName,isSel and "ffc146" or "ffffff")
    CSAPI.SetTextColorByCode(txtScore,isSel and "ffc146" or "ffffff")
end

function SetName()
    -- CSAPI.SetText(txtDesc,cfg.name or "")
end

function SetDesc()
    CSAPI.SetText(txtDesc,cfg.desc or "")
end

function SetScore()
    CSAPI.SetText(txtScore,cfg.points .. "" or "")
end

function OnClick()
    if cb then
        cb(this)
    end
end