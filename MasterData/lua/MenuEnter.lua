function Refresh(_cfg)
    cfg = _cfg
    key = "ActiveEntry" .. cfg.id

    -- lock 
    SetLock()
    -- icon 
    ResUtil.MenuEnter:Load(icon, cfg.mainBtn)
    SetIcon2();
    CSAPI.SetGOAlpha(icon, isOpen and 1 or 0.5)
    -- name 
    StringUtil:SetColorByName(txtName, cfg.name, isOpen and "ffffff" or "929296")
    -- red 
    SetRed()
    -- new
    SetNew()
end

function SetIcon2()
    local activeIcon2=false;
    if cfg and cfg.id==16 then
        local pet=PetActivityMgr:GetCurrPetInfo();
        if pet then
            local emojis=pet:GetEmojis();
            if emojis then
                local cfg=emojis[1]
                ResUtil.PetEmoji:Load(icon2,cfg.icon);
                activeIcon2=true;
            end
        end
    end
    CSAPI.SetGOActive(icon2,activeIcon2);
end

function SetLock()
    isOpen = true
    if (cfg.nConfigID) then
        local cfg = Cfgs[cfg.config]:GetByID(cfg.nConfigID)
        if (cfg) then
            local sid = 0
            if cfg.sectionID then
                sid = cfg.sectionID
            elseif cfg.infos and cfg.infos[1] and cfg.infos[1].sectionID then
                sid = cfg.infos[1].sectionID
            end
            local sectionData = DungeonMgr:GetSectionData(sid)
            if (sectionData ~= nil) then
                isOpen = sectionData:GetOpen()
            end
        end
    end
    CSAPI.SetGOActive(lock, not isOpen)

    -- txtLock 
    CSAPI.SetGOActive(txtLock, not isOpen)
    if (not isOpen) then
        CSAPI.SetText(txtLock, cfg.desc or "")
    end
end

function SetRed()
    isRed = false
    if (isOpen) then
        local data = nil
        if(key=="ActiveEntry26") then 
            data = ColosseumMgr:IsRed() 
        else
            data = RedPointMgr:GetData(key) 
        end 
        if (data and data ~= 0) then
            isRed = true
        end
    end
    UIUtil:SetRedPoint(clickNode, isRed, 39, 79.3, 0)
end

function SetNew()
    isNew = false
    if (not isRed) then
        isNew = MenuMgr:CheckIsNew(key, isOpen)
    end
    CSAPI.SetGOActive(newObj, isNew)
end

function OnClick()
    if (isOpen) then
        if (isNew) then
            isNew = false
            MenuMgr:SetIsNew(key, isOpen)
            CSAPI.SetGOActive(newObj, isNew)
        end
        if (cfg.JumpID) then
            Log("入口配置表信息:")
            Log(cfg)
            JumpMgr:Jump(cfg.JumpID)
        end
    end
end
