local info = nil
local elseData = nil
local rankType = nil
local items = {}

function Refresh(_data,_elseData,_rankType)
    info = _data
    elseData = _elseData
    rankType = _rankType
    if info then
        SetRankReward()
    end
end

function SetRankReward()
    local cur,max = -1,0
    if rankType then
        cur,max = RankMgr:GetRankRewardCount(rankType, info.index)
    end
    CSAPI.SetText(txtName,(info.des or "") .. (cur >= 0 and LanguageMgr:GetByID(312027,cur,max) or "" ))

    if info.mailId then
        local cfgMail = Cfgs.CfgMail:GetByID(info.mailId)
        if cfgMail and cfgMail.rewards then
            ShowReward(cfgMail.rewards)
        end
    elseif info.reward then
        ShowReward(info.reward)
    end
end

function ShowReward(rewards)
    local gridDatas = GridUtil.GetGridObjectDatas2(rewards)
    items = items or {}
    ItemUtil.AddItems("Rank/RankRewardGrid", items, gridDatas, grid,
    GridClickFunc.OpenInfoSmiple, 1, IsGet())
end

function IsGet()
    if elseData and elseData.damage and info.damage then
        return elseData.damage >= info.damage
    end
    return false
end