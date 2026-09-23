-- 家具描述
function OnOpen()
    cfg = data

    -- icon
    SetIcon(cfg.icon)
    -- scale
    SetScale()
    -- name
    CSAPI.SetText(txtName, cfg.sName)
    -- desc
    CSAPI.SetText(txtDesc, cfg.desc)
    -- comfort
    CSAPI.SetText(txtComfort, "+" .. cfg.comfort)
end

function SetScale()
    local itemCfg = Cfgs.ItemInfo:GetByID(cfg.itemId)
    CSAPI.SetGOActive(imgScale, itemCfg.seizeIcon ~= nil)
    if (itemCfg.seizeIcon) then
        ResUtil.FurnitureSeize:Load(imgScale, itemCfg.seizeIcon)
    end
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.Furniture:Load(icon, iconName .. "")
    end
end

function OnClickC()
    view:Close()
end
function OnClickMask()
    view:Close()
end

