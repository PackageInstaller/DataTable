local cfg = nil

function Refresh(_data)
    cfg = Cfgs.cfgGlobalBossBuffBattle:GetByID(_data)
    if cfg then
        SetIcon()
    end
end

function SetIcon()
    if cfg.icon2 and cfg.icon2~="" then
        ResUtil.GlobalBoss:Load(icon, cfg.icon2)
    end
end