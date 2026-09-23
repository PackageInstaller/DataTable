RankMgr = MgrRegister("RankMgr")
local this = RankMgr;
RankData = require "RankData"

function this:Init()
    self:Clear()
    self:InitRankMax()
end

function this:Clear()
    self.datas = {}
    self.clearTime = {}
    self.cur_rank = {}
    self.rankInfos = {}
    self.myRank = {}
    self.myTurnNum = {}
    self.myDamage = {}
    self.myScore = {}
    self.max_rank = {}
    self.rankTime = {}
    self.dungeonTeams = {}
    self.rankReward = {}
    self.rankStr = {}
    self.isRequest = false
end

function this:InitRankMax()
    local cfgs = Cfgs.CfgRankTeam:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            if v.rankNum then
                self.max_rank[v.id] = v.rankNum
            end
        end
    end
end

-- 本地清空
function this:ClearRankData(type)
    if type == nil then
        return
    end
    if type == eRankId.Exercise then
        ExerciseMgr:ClearRankData()
    end
    self.clearTime[type] = self.clearTime[type] or 0
    if (self.clearTime[type] <= TimeUtil:GetTime()) then
        self.cur_rank = {}
        self.rankInfos = {}
        self.myRank = {}
        self.myTurnNum = {}
        self.myDamage = {}
        self.myScore = {}
        self.clearTime[type] = self.rankTime[type]
    end
end

-- 服务器发协议清空
function this:ClearRank(proto)
    if proto and proto.rank_type then
        self.cur_rank[proto.rank_type] = nil
        self.rankInfos[proto.rank_type] = nil
        self.myRank[proto.rank_type] = nil
        self.myScore[proto.rank_type] = nil
        self.myTurnNum[proto.rank_type] = nil
        self.myDamage[proto.rank_type] = nil
        EventMgr.Dispatch(EventType.Activity_Rank_Update)
    end
end

-- 获取排行榜信息
function this:GetRank(idx, type)
    if type == eRankId.GlobalBoss then
        FightProto:GetGlobalBossRank(idx)
    elseif type == eRankId.Exercise then
        ExerciseMgr:AddNextRankList()
    elseif type == eRankId.t then
        
    else
        PlayerProto:GetRank(idx, type)
    end
end

function this:GetRankRet(proto)
    if proto and proto.rank_type then
        if (proto.data and #proto.data > 0) then
            self.rankInfos = self.rankInfos or {}
            self.rankInfos[proto.rank_type] = self.rankInfos[proto.rank_type] or {}
            for k, v in ipairs(proto.data) do
                local info = RankData.New()
                info:Init(v)
                self.rankInfos[proto.rank_type][v.rank] = info
            end
        end
        self.myRank[proto.rank_type] = proto.rank or self.myRank[proto.rank_type]
        self.myScore[proto.rank_type] = proto.score or self.myScore[proto.rank_type]
        self.myTurnNum[proto.rank_type] = proto.turn_num or self.myTurnNum[proto.rank_type]
        self.myDamage[proto.rank_type] = proto.nDamage or self.myDamage[proto.rank_type]
        self.rankTime[proto.rank_type] = proto.next_refresh_time and proto.next_refresh_time + 10 or 0 -- 延后10秒用于获取服务器数据
        self.rankStr[proto.rank_type] = proto.erank
        if proto.reward_issue and #proto.reward_issue > 0 then
            self.rankReward[proto.rank_type] = self.rankReward[proto.rank_type] or {}
            for k, v in ipairs(proto.reward_issue) do
                self.rankReward[proto.rank_type][v.index] = {
                    cur = v.cnt or 0, -- -1 表示不限且不统计
                    max = v.limit or 0,
                }
            end
        end
    end
    EventMgr.Dispatch(EventType.Activity_Rank_Update)
end

function this:GetRankInfos(type)
    local arr = {}
    if self.rankInfos and self.rankInfos[type] then
        for i, v in pairs(self.rankInfos[type]) do
            table.insert(arr, v)
        end
    end
    if (#arr > 0) then
        table.sort(arr, function(a, b)
            return a:GetRank() < b:GetRank()
        end)
    end
    self.cur_rank[type] = #arr
    if type == eRankId.Exercise then --兼容军演
        ExerciseMgr.cur_rank = #arr
    end
    return arr
end

function this:AddNextRankList(type)
    self.cur_rank[type] = self.cur_rank[type] or 0
    self.max_rank[type] = self.max_rank[type] or g_ExploringRankRule
    if (self.cur_rank[type] < (self.max_rank[type] - 1)) then
        local curPage = math.modf((self.cur_rank[type] / 10)) + 1
        -- curPage = curPage + 1 > 10 and curPage or curPage + 1
        self:GetRank(curPage, type)
    end
end

function this:RefreshRankList(type)
    self.cur_rank[type] = self.cur_rank[type] or 0
    local curPage = math.modf((self.cur_rank[type] / 10))
    self:GetRank(curPage, type)
end

function this:GetMyRank(type)
    local cfgDungeon = DungeonMgr:GetLastPassDungeon(type)
    local data = {
        id = PlayerClient:GetUid(),
        name = PlayerClient:GetName(),
        level = PlayerClient:GetLv(),
        rank = self.myRank[type] or 0,
        icon_id = PlayerClient:GetIconId(),
        icon_frame = PlayerClient:GetHeadFrame(),
        score = self.myScore[type] or 0,
        turn_num = self.myTurnNum[type] or 0,
        dupId = cfgDungeon and cfgDungeon.id or 0,
        sel_card_ix = PlayerClient:GetSex(),
        icon_title = PlayerClient:GetIconTitle(),
        -- icon_card = PlayerClient:GetIconCard(),
        nDamage = self.myDamage[type] or 0,
        erank = self.rankStr[type]
    } 
    local info = RankData.New()
    info:Init(data)
    return info
end

function this:GetRankTime(type)
    if self.rankTime[type] and self.rankTime[type] > TimeUtil.GetTime() then
        return self.rankTime[type] - TimeUtil.GetTime()
    end
    return 0
end

-- -1 表示不限且不统计
function this:GetRankRewardCount(type,index)
    if self.rankReward[type] and self.rankReward[type][index] then
        return self.rankReward[type][index].cur,self.rankReward[type][index].max
    end
    return -1,0
end

return this