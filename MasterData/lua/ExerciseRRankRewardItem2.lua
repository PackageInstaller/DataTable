function Awake()
    slider = ComUtil.GetCom(Slider, "Slider")
end

-- 段位奖励
function Refresh1(_cfg)
    cfg = _cfg
    local rewardInfo = ExerciseRMgr:GetRewardInfo()
    local get_rank_lv_id = rewardInfo.get_rank_lv_id or 1
    -- 
    LanguageMgr:SetText(txtDesc, 90052, cfg.name)
    CSAPI.SetGOActive(success, cfg.id <= get_rank_lv_id)
    SetReward(cfg.jAward)
end

-- 排名奖励
function Refresh2(_cfg)
    cfg = _cfg
    -- local rewardInfo = ExerciseRMgr:GetRewardInfo()
    -- local jion_cnt = rewardInfo.jion_cnt or 0
    -- local get_jion_cnt_id = rewardInfo.get_jion_cnt_id or 0
    -- 
    --local str = cfg.rankNum[1] == cfg.rankNum[2] and cfg.rankNum[1] or cfg.rankNum[1] .. "~" .. cfg.rankNum[2]
    LanguageMgr:SetText(txtDesc, 90045, cfg.rankShowNum)
    CSAPI.SetGOActive(success, false)
    SetReward(cfg.jAward)
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