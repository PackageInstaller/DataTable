-- 战斗表情，战斗中使用
-- id  ：表情id CfgIconEmote
function Refresh(id, _isLeft)
    isLeft = _isLeft
    -- 
    local cfg = Cfgs.CfgIconEmote:GetByID(id)
    --
    SetIcon(cfg)

    CSAPI.SetAngle(icon, 0, isLeft and 0 or 180, 0)
    -- 
    if (cfg.sound) then
        RoleAudioPlayMgr:PlayById(nil, cfg.sound)
    end
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
        CSAPI.SetAngle(icon2, 0, isLeft and 0 or 180, 0)
    else
        if (effectGO) then
            if (effectGO.name == avatareffect) then
                return
            end
            CSAPI.RemoveGO(effectGO)
        end
        CSAPI.SetAngle(effectParent, 0, isLeft and 0 or 180, 0)
        ResUtil:CreateEffect(avatareffect, 0, 0, 0, effectParent, function(go)
            effectGO = go
            effectGO.name = avatareffect
            -- 翻转
            local descIcon = effectGO.transform:Find("root/Text/Icon").gameObject
            CSAPI.SetAngle(descIcon, 0, isLeft and 0 or 180, 0)
        end)
    end
end
