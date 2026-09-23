function Refresh(id)
    local cfg = Cfgs.CfgRogueBuff:GetByID(id)
    -- bg 
    ResUtil.RogueBuff:Load(iconBg, cfg.quality)
    -- icon 
    ResUtil.RogueBuff:Load(icon, cfg.icon)
end

function OnClick()
    CSAPI.OpenView("RogueBuffDetail")
end
