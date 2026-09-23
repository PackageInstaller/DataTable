-- 家具描述
function OnOpen()
    curThemeType = data[1]
    themeData = data[2]
    if (curThemeType == ThemeType.Sys) then
        local cfg = Cfgs.CfgFurnitureTheme:GetByID(themeData.id)
        name = cfg.sName
        desc = cfg.desc
        comfort = cfg.comfort
        SetIcon(cfg.icon)
        CSAPI.SetScale(icon, 1.5, 1.5, 1)
        CSAPI.SetGOActive(btnC, true)
        CSAPI.SetGOActive(btnB, false)
    else
        name = themeData.name
        desc = ""
        comfort = themeData.comfort
        DormIconUtil.SetIcon(icon, themeData.img)
        CSAPI.SetScale(icon, 2, 2, 1)
        CSAPI.SetGOActive(btnC, false)
        CSAPI.SetGOActive(btnB, true)
    end

    -- name
    CSAPI.SetText(txtName, name)
    -- desc
    CSAPI.SetText(txtDesc, desc)
    -- comfort
    CSAPI.SetText(txtComfort, comfort .. "")
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        -- ResUtil.IconGoods:Load(icon, iconName .. "") --todo 
        ResUtil:LoadBigImg(icon, "UIs/Dorm/" .. iconName, true)
    end
end

function OnClickMask()
    view:Close()
end

function OnClickC()
    view:Close()
end

-- 一键布置      
-- 主题对应的家具是否齐全 todo
-- local b = DormMgr:CheckEnoughByThemeID(curThemeType, themeData.id)
function OnClickB()
    local roleNum = DormMgr:GetCurRoomData():GetNum()
    local handNun = 256 - roleNum
    local fNum = DormMgr:GetSaveThemeGridNun(themeData.id)
    if(fNum>=handNun) then 
        LanguageMgr:ShowTips(21035)
        return  
    end 
    -- 
    EventMgr.Dispatch(EventType.Dorm_Theme_Change, {ThemeType.Save, themeData})
    LanguageMgr:ShowTips(21026)
    view:Close()
end
