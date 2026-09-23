function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(cfg, curTopIndex)
    local scale = cfg.id == 0 and 1 or 0.38
    CSAPI.SetScale(icon,scale,scale,1)
    if (cfg.id == 0) then
        -- 全部
        ResUtil.RogueBuff:Load(icon, cfg.icon or 1000,true)
    else
        -- bg 
        -- ResUtil.RogueBuff:Load(iconBg, cfg.quality or 2)
        -- icon 
        ResUtil.RogueBuff:Load(icon, cfg.icon or 1001,true)
    end
    CSAPI.SetGOActive(select, index == curTopIndex)
    CSAPI.SetGOAlpha(icon, index == curTopIndex and 1 or 0.5)
end

function OnClick()
    cb(index)
end
