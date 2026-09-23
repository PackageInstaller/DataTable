-- 头像框+表frame_effectObj
local frame_effectObj
local head_effectObj

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Head_Frame_Change, function(proto)
        Refresh(scale, proto.icon_frame, iconID, sel_card_ix)
    end)
    eventMgr:AddListener(EventType.Head_Icon_Change, function(proto)
        Refresh(scale, frameID, proto.icon_id, sel_card_ix)
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_scale, _frameID, _iconID, _sel_card_ix)
    scale = _scale
    frameID = _frameID or 1
    iconID = _iconID
    sel_card_ix = _sel_card_ix or 1

    CSAPI.SetScale(node, scale, scale, scale)
    -- 头像框
    CSAPI.SetGOActive(frame, frameID ~= 1)
    if (frameID ~= 1) then
        local cfg = Cfgs.AvatarFrame:GetByID(frameID)
        CSAPI.SetGOActive(frame_icon, cfg.type == 1)
        CSAPI.SetGOActive(frame_effect, cfg.type == 2)
        local picture = sel_card_ix == 2 and cfg.picture2 or cfg.picture
        local avatareffect = sel_card_ix == 2 and cfg.avatareffect2 or cfg.avatareffect
        if (cfg.type == 1) then
            ResUtil.HeadFrame:Load(frame_icon, picture, true)
        else
            local needAdd = true
            if (frame_effectObj) then
                if (frame_effectObj.name == avatareffect) then
                    needAdd = false
                else
                    CSAPI.RemoveGO(frame_effectObj)
                end
            end
            if (needAdd) then
                ResUtil:CreateEffect(avatareffect, 0, 0, 0, frame_effect, function(go)
                    frame_effectObj = go
                    frame_effectObj.name = avatareffect
                end)
            end
        end
    end
    -- 头像 
    if (Cfgs.CfgAvatar:GetByID(iconID) ~= nil) then
        SetHead1()
    else
        SetHead2()
    end
end

-- 头像表
function SetHead1()
    local cfg = Cfgs.CfgAvatar:GetByID(iconID)
    CSAPI.SetGOActive(head_icon, cfg.type == 1)
    CSAPI.SetGOActive(head_effect, cfg.type == 2)
    if (cfg.type == 1) then
        ResUtil.Head:Load(head_icon, cfg.picture, true)
    else
        if (head_effectObj) then
            if (head_effectObj.name == cfg.avatareffect) then
                return
            end
            CSAPI.RemoveGO(head_effectObj)
        end
        ResUtil:CreateEffect(cfg.avatareffect, 0, 0, 0, head_effect, function(go)
            head_effectObj = go
            head_effectObj.name = cfg.avatareffect
        end)
    end
end

-- 模型表 
function SetHead2()
    CSAPI.SetGOActive(head_icon, true)
    CSAPI.SetGOActive(head_effect, false)
    local modelCfg = Cfgs.character:GetByID(iconID)
    if (modelCfg and modelCfg.icon) then
        ResUtil.RoleCard:Load(head_icon, modelCfg.icon)
    end
end

