local landIDs = {72002, 72003, 72004}

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id)
    id = _id
    -- 
    local cfg = Cfgs.CfgIconEmote:GetByID(id)
    --
    LanguageMgr:SetText(txtTitle, landIDs[index])
    --
    SetIcon(cfg)
    -- color 
    SetColors()
end

function SetIcon(cfg)
    CSAPI.SetGOActive(icon, cfg.picture ~= nil)
    CSAPI.SetGOActive(effectParent, cfg.avatareffect ~= nil)
    local picture = cfg.picture
    local avatareffect = cfg.avatareffect
    if (picture ~= nil) then
        ResUtil.HeadFace:Load(icon, picture[1], true)
        ResUtil.HeadFace:Load(icon2, picture[2], true)
        local textPos = cfg.textPos or {0, 0}
        CSAPI.SetAnchor(icon2, textPos[1], textPos[2])
    else
        if (effectGO) then
            if (effectGO.name == avatareffect) then
                return
            end
            CSAPI.RemoveGO(effectGO)
        end
        ResUtil:CreateEffect(avatareffect, 0, 0, 0, effectParent, function(go)
            effectGO = go
            effectGO.name = avatareffect
        end)
    end
end

function OnClick()
    if (cb) then
        cb(this)
    end
end

function SetColors()
    local nameClor = index == 1 and "ffffff" or "000000"
    local nameBgColor = "img_12_2"
    if (index > 1) then
        nameBgColor = index == 2 and "img_12_1" or "img_12_3"
    end
    CSAPI.SetTextColorByCode(txtTitle, nameClor)
    CSAPI.LoadImg(titleBG, "UIs/HeadFrame/" .. nameBgColor..".png", true, nil, true)
end


function SetClickNodeRaycastTarget(b)
    local clickNodeImg = ComUtil.GetCom(clickNode, "Image")
    clickNodeImg.raycastTarget = b
end