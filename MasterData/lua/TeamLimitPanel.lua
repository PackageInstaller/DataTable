function OnOpen()
    --local curData = RogueTMgr:GetFightData()
    cfg = Cfgs.MainLine:GetByID(data)--curData.nDuplicateID)
    SetDatas()
    -- 
    items = items or {}
    ItemUtil.AddItems("Team/TeamLimitItem", items, datas, Content)
end

function SetDatas()
    datas = {}
    local condition = TeamCondition.New()
    condition:Init(cfg.teamLimted)
    datas = condition:GetDesc()
    if cfg.tacticsSwitch then
        table.insert(list, LanguageMgr:GetByID(49028))
    end
end

function OnClickMask()
    view:Close()
end
