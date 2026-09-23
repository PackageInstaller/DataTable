local cfg =nil
local sid = nil

function Refresh(_cfg,_sid)
    cfg = _cfg
    sid = _sid
    if cfg and sid then
        SetIcon()
        SetPos()
    end
end

function SetIcon()
    if cfg.dateImg~=nil and cfg.dateImg~="" then
        ResUtil.LovePlus:Load(gameObject, sid .. "/" .. cfg.dateImg)
    end
end

function SetPos()
    local x,y,angle = cfg.x or 0,cfg.y or 0,cfg.rotate or 0
    CSAPI.SetAnchor(gameObject,x,y)
    CSAPI.SetAngle(gameObject,0,0,angle)
end