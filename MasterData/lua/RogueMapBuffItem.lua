local data = nil
local cfg = nil

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    data = _data
    if data then
        cfg = Cfgs.BufferConfig:GetByID(data.id)
        SetIcon()
        SetName()
        SetDesc()
        SetRound()
        SetNum()
    end
end

function SetIcon()
    if cfg.icon then
        ResUtil.RogueMapBuff:Load(icon,cfg.icon)
    end
    if cfg.icon_Type then
        ResUtil.RogueBuff:Load(iconBg,cfg.icon_Type)
    end
end

function SetName()
    CSAPI.SetText(txtName,cfg.name)
end

function SetDesc()
    CSAPI.SetText(txtDesc,cfg.desc)
end

function SetRound()
    CSAPI.SetText(txtRound,data.num  .. "")
end

function SetNum()
    CSAPI.SetText(txtNum,data.count  .. "")
end