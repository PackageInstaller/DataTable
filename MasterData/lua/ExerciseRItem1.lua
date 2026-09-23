local rank_colors = {"191919", "191919", "ffffff"}

-- sFreeArmyRank
function Refresh(data)
    local rank = data.rank==0 and 4 or data.rank
    local join_cnt = data.join_cnt or 1
    local rankStr = join_cnt>0 and  rank.."" or "--"
    CSAPI.SetText(txtRank, rankStr)
    --
    UIUtil:AddHeadByID(hfParent, 1, data.icon_frame, data.icon_id, data.sel_card_ix)
    -- 
    UIUtil:AddTitleByID(titleParent, 1, data.icon_title)
    CSAPI.SetText(txtLevel, data.level .. "")
    CSAPI.SetText(txtName, data.name)
    local rankLv = GCalHelp:CalFreeMatchRankLv(data.score or 0)
    local rankCfg = Cfgs.CfgPvpRankLevel:GetByID(rankLv)
    CSAPI.SetText(txtScore1, rankCfg and rankCfg.name or "")
    CSAPI.SetText(txtScore2, data.score .. "")
    --
    local nodeName =  rank < 4 and "img_07_0" ..  rank or "img_07_04"
    CSAPI.LoadImg(node, "UIs/ExerciseR/" .. nodeName .. ".png", false, nil, true)
    --
    local color1 = rank <= 2 and rank_colors[rank] or "ffffff"
    local color2 = rankCfg and rankCfg.rankColor or "5d5d5d"
    CSAPI.SetTextColorByCode(txtRank, color1)
    CSAPI.SetTextColorByCode(txtScore1, color2)
end

function RefreshMySelf()
    local data = {}
    data.join_cnt = ExerciseRMgr:GetRewardInfo().join_cnt or 0
    data.rank = ExerciseRMgr:GetProto().rank
    data.score = ExerciseRMgr:GetProto().score or 0
    data.name = PlayerClient:GetName()
    data.icon_title = PlayerClient:GetIconTitle()
    data.icon_id = PlayerClient:GetIconId()
    data.icon_frame = PlayerClient:GetHeadFrame()
    data.sel_card_ix = PlayerClient:GetSex()
    data.level = PlayerClient:GetLv()
    Refresh(data)
end
