local data = nil
local cfg = nil

function Refresh(_data)
    data = _data
    if data then
        cfg = Cfgs.BufferConfig:GetByID(data.id)
        SetIcon()
        SetNum()
        SetCount()
    end
end

function SetIcon()
    if cfg and cfg.icon then
        ResUtil.RogueMapBuff:Load(icon,cfg.icon)
    end
    if cfg.icon_Type then
        ResUtil.RogueBuff:Load(iconBg,cfg.icon_Type)
    end
end
 
function SetNum()
    local num = data.num or 0
    CSAPI.SetText(txtNum,num.."")
end

function SetCount()
    CSAPI.SetGOActive(countObj,data.count > 1)
    CSAPI.SetText(txtCount,data.count.."")
end