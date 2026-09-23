local cfg = nil
function Awake()
    SetSelect(false)
end

function SetSelect(b)
    CSAPI.SetGOActive(selObj,b)
end

function Refresh(_cfg)
    cfg = _cfg
    if cfg then
        SetIcon()
    end
end

function SetIcon()
    if cfg.icon3 and cfg.icon3 ~= "" then
        ResUtil.BuffBattle:Load(icon3,cfg.icon3)
    end
    if cfg.icon2 and cfg.icon2 ~= "" then
        ResUtil.BuffBattle:Load(icon2,cfg.icon2)
    end
    if cfg.icon1 and cfg.icon1 ~= "" then
        ResUtil.BuffBattle:Load(icon1,cfg.icon1)
    end
    CSAPI.SetGOActive(icon1,cfg.icon1 ~= nil)
end