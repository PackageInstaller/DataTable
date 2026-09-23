-- 称号
local effectObj
local isMy = false 

function Awake()
    if (eventMgr) then
        eventMgr:ClearListener()
    end
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Head_Title_Change, function(proto)
        Refresh(scale, proto.icon_title, isMy)
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_scale, _titleID, _isMy)
    scale = _scale
    titleID = _titleID or 1
    isMy = _isMy

    CSAPI.SetGOActive(node, titleID ~= 1)
    if(titleID~=1) then 
        CSAPI.SetScale(node, scale, scale, scale)
        local cfg = Cfgs.CfgIconTitle:GetByID(titleID)
        CSAPI.SetGOActive(icon, cfg.type == 1)
        CSAPI.SetGOActive(effect, cfg.type == 2)
        if (cfg.type == 1) then
            ResUtil.HeadTitle:Load(icon, cfg.picture, true)
        else
            if (effectObj) then
                if (effectObj.name == cfg.avatareffect) then
                    return
                end
                CSAPI.RemoveGO(effectObj)
            end
            ResUtil:CreateEffect(cfg.avatareffect, 0, 0, 0, effect, function(go)
                effectObj = go
                effectObj.name = cfg.avatareffect
            end)
        end
    end 
end

