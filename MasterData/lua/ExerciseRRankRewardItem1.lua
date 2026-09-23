function SetClickCB(_cb)
    cb = _cb
end
function Awake()
    slider = ComUtil.GetCom(Slider, "Slider")
end
function Refresh(_cfg, _type)
    cfg = _cfg
    type = _type
    local rewardInfo = ExerciseRMgr:GetRewardInfo()
    if (type == ePVPTaskType.Join) then
        join_cnt = rewardInfo.join_cnt or 0
        get_join_cnt_id = rewardInfo.get_join_cnt_id or 0
    else
        join_cnt = rewardInfo.win_cnt or 0
        get_join_cnt_id = rewardInfo.get_win_cnt_ix or 0
    end
    -- 
    CSAPI.SetText(txtDesc, cfg.sDescription)
    CSAPI.SetText(txtCount, join_cnt .. "/" .. cfg.order)
    slider.value = join_cnt / cfg.order
    CSAPI.SetGOActive(success, cfg.index <= get_join_cnt_id)
    CSAPI.SetGOActive(btn, cfg.index > get_join_cnt_id)
    if (cfg.index > get_join_cnt_id) then
        CSAPI.SetGOActive(btnBg1, join_cnt >= cfg.order)
        CSAPI.SetGOActive(btnBg2, join_cnt < cfg.order)
        LanguageMgr:SetText(txtBtn1, join_cnt >= cfg.order and 6011 or 90049)
        CSAPI.SetGOAlpha(btn, join_cnt >= cfg.order and 1 or 0.3)
    end
    SetReward(cfg.jAward)
    SetRed()
end

function SetReward(rewards)
    grids = grids and grids or {}
    for i, v in ipairs(grids) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    local item, go = nil, nil
    for k, v in ipairs(rewards) do
        if (k <= #grids) then
            item = grids[k]
            CSAPI.SetGOActive(item.gameObject, true)
        else
            go, item = ResUtil:CreateRewardGrid(hLayout.transform)
            table.insert(grids, item)
        end
        local data = {
            id = v[1],
            num = v[2],
            type = v[3]
        }
        local result, clickCB = GridFakeData(data)
        item.Refresh(result)
        item.SetClickCB(clickCB)
        item.SetCount(data.num)
    end
end

function SetRed()
    UIUtil:SetRedPoint2("Common/Red2", btn, btnBg1.activeSelf, 99.6, 29, 0)
end

function OnClick()
    if (btnBg1.activeSelf) then
        local ids = GetIDs()
        ArmyProto:GetPvpReward(type, ids, function()
            if (cb ~= nil) then
                cb()
            end
        end)
    end
end

function GetIDs()
    local ids = {}
    if (type == ePVPTaskType.Join) then
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(1)
        local join_cnt = ExerciseRMgr:GetProto().reward_info.join_cnt or 0
        local get_join_cnt_id = ExerciseRMgr:GetProto().reward_info.get_join_cnt_id or 0
        ids = ExerciseRMgr:GetIDs(cfg, join_cnt, get_join_cnt_id)
    else
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(2)
        local win_cnt = ExerciseRMgr:GetProto().reward_info.win_cnt or 0
        local get_win_cnt_ix = ExerciseRMgr:GetProto().reward_info.get_win_cnt_ix or 0
        ids = ExerciseRMgr:GetIDs(cfg, win_cnt, get_win_cnt_ix)
    end
    return ids
end