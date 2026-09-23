local timer = nil

function OnOpen()
    local cfg = Cfgs.cfgPhysicalRewardGroup:GetByID(data.id)
    if (cfg) then
        local childCfg = cfg.infos[data.index]
        local pic = childCfg.pic
        CSAPI.LoadImg(icon, "UIs/Anniversary2/" .. childCfg.pic .. ".png", true, nil, true)
        --
        LanguageMgr:SetText(txtName, 180003, childCfg.name)
    end
    timer = Time.time + 3
end

function OnClickMask()
    if (timer and Time.time > timer) then
        view:Close()
    end
end
