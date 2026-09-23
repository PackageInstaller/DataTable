function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id)
    id = _id
    local cfg = Cfgs.CfgRogueBuff:GetByID(id)
    -- bg 
    local bgName = "img_29_0" .. cfg.quality
    CSAPI.LoadImg(iconBg, "UIs/Rogue/" .. bgName .. ".png", true, nil, true)
    -- icon 
    ResUtil.RogueBuff:Load(icon, cfg.icon)
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- desc 
    CSAPI.SetText(txtDesc, cfg.desc)
    -- 
    CSAPI.SetGOActive(colorful, cfg.quality >= 6)
end

function Select(b)
    CSAPI.SetGOActive(select, b)
end

function OnClick()
    cb(this)
end
