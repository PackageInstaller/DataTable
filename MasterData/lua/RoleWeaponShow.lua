-- data : weaponChildCfg
function OnOpen()
    ResUtil.RoleWeaponImg:Load(img,data.icon)
end

function OnClickMask()
    view:Close()
end
