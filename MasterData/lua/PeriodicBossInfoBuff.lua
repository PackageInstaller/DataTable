local cfg = nil

function SetBuff(buffId)
    cfg = Cfgs.cfgPeriodicBossBuffBattle:GetByID(buffId)
    if cfg then
        CSAPI.SetText(txtName,cfg.name)
        CSAPI.SetText(txtDesc,cfg.desc)
        if cfg.icon2 then
            ResUtil.BuffPeridicBoss:Load(icon,cfg.icon2)
        end
    end
end