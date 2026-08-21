-- baoruichang
-- 2021/12/9 20:10:14
local UIVotingHeroContext = BaseClass("UIVotingHeroContext", BaseContext)
local M = UIVotingHeroContext
local MessageId = Proto.MessageId

function M:Init()
    self.heroRank = {}
    self.eventHero = EventMgr:AddListener(UIMessageNames.VOTING_HEROVOTE, Bind(self, self.OnVotingHero))
    self.refTimer = ConfigHelper.GetSystemParam(212)
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:Open(heroId, selectAllHeroData, voteState)
    self.selectAllHeroData = selectAllHeroData
    self:_Show(heroId, voteState)
end

function M:OnVotingHero(data)
    self:VoteReq(data.heroId, data.num)
end

function M:GetHeroNum()
    if not self.selectAllHeroData then
        return 0
    end

    return #self.selectAllHeroData
end

function M:GetAHeroData(HeroId)
    if not self.selectAllHeroData then
        return
    end
    for _, heroData in pairs(self.selectAllHeroData) do
        if heroData.heroId == HeroId then
            return heroData
        end
    end
end

function M:GetHeroId(heroId, left)
    local selectAllHeroData = self.selectAllHeroData
    local oldHeroKey

    for k, v in ipairs(selectAllHeroData) do
        if v.heroId == heroId then
            oldHeroKey = k
            break
        end
    end

    if not oldHeroKey then
        return selectAllHeroData[1].heroId
    end

    if left then
        if oldHeroKey > 1 then
            return selectAllHeroData[oldHeroKey - 1].heroId
        else
            return selectAllHeroData[#selectAllHeroData].heroId
        end
    end

    if oldHeroKey < #selectAllHeroData then
        return selectAllHeroData[oldHeroKey + 1].heroId
    else
        return selectAllHeroData[1].heroId
    end
end

-- 获取英雄的贡献排行榜信息
function M:GetHeroRankData(heroId)
    local heroRankData = self.heroRank[heroId]

    if not heroRankData then
        return
    end

    local NowTimer = TimeUtil.GetNowTimeStamp()

    if NowTimer - heroRankData.Timer > self.refTimer then
        return
    end
    local nowState = VotingDataMgr:GetInstance():GetNowState()
    if nowState ~= heroRankData.nowState then
        return
    end
    return heroRankData
end

-- local function SortTicket(data1, data2)
--     return data1.VoteCnt > data2.VoteCnt
-- end

----------------------------------Req--Start-------------------------------------------

-- 票选Req
function M:VoteReq(heroId, num)
    if self._ResponseVoteCallback then
        NetPack:UnRegistResponse(MessageId.ResponseVote, self._ResponseVoteCallback)
    end

    Logger.Log("英雄选票Req" .. heroId .. "     " .. num)
    self._ResponseVoteCallback = NetPack:RegistResponse(MessageId.ResponseVote, Bind(self, self.ResponseVoteCallback))
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    request.HeroId = heroId
    request.Ticket = num

    NetPack:SendMessage(MessageId.RequestVote, request)
end

-- 请求玩家的贡献榜
function M:HeroSupportRankReq(heroId)
    self._ResponseHeroSupportRankCallback = NetPack:RegistResponse(MessageId.ResponseHeroSupportRank, Bind(self, self.ResponseHeroSupportRankCallback))
    self.selectHeroId = heroId
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    request.HeroId = heroId
    Logger.Log("请求玩家对英雄贡献Req" .. heroId)
    NetPack:SendMessage(MessageId.RequestHeroSupportRank, request)
end

-- 请求自己对该英雄的贡献榜
function M:RequestVoteInfo(heroId)
    self.selectHeroId = heroId
    self._ResponseVoteInfoCallback = NetPack:RegistResponse(MessageId.ResponseVoteInfo, Bind(self, self.ResponseVoteInfoCallback))
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    request.HeroId = heroId

    NetPack:SendMessage(MessageId.RequestVoteInfo, request)
end

----------------------------------Req--End-------------------------------------------

----------------------------------Ack--Start-------------------------------------------

-- 票选Ack
function M:ResponseVoteCallback(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseVote, self._ResponseHeroSupportRankCallback)
    Logger.Log("票选Ack")
    self._ResponseHeroSupportRankCallback = nil

    if result ~= 0 then
        return
    end

    if msg.Award then
        local awardData = {}

        for i = 1, #msg.Award do
            local award = msg.Award[i]
            awardData[award.Id] = award.Cnt
        end
        GameHelper.ShowGetItems(awardData)
    end

    UIContextMgr:GetInstance():Close(UIDefine.UIVotingVote)
    EventMgr:Broadcast(UIMessageNames.VOTING_HEROVOTEREF)
    -- 票选红点变化
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.VotingVoteChecker)
    RedPointMgr:ForceCheck(CS.GameX.RedPointConst.ExchangeRedPointChecker)
end

function M:ResponseHeroSupportRankCallback(_, result, msg)
    -- Logger.LogError("请求玩家对英雄贡献Ack")
    NetPack:UnRegistResponse(MessageId.ResponseHeroSupportRank, self._ResponseHeroSupportRankCallback)
    self._ResponseHeroSupportRankCallback = nil

    if result ~= 0 then
        return
    end

    local data = {}
    data.Data = msg.Data
    -- table.sort(data.Data, SortTicket)

    for i = 1, #data.Data do
        data.Data[i].index = i
    end

    data.Timer = TimeUtil.GetNowTimeStamp()
    data.nowState = VotingDataMgr:GetInstance():GetNowState()
    self.heroRank[self.selectHeroId] = data
    self:GetCtrl():UpdateHeroRankList(msg.Data)
end

-- 请求自己对英雄贡献Ack
function M:ResponseVoteInfoCallback(messagId, result, msg)
    Logger.Log("请求自己对英雄贡献Ack")
    NetPack:UnRegistResponse(MessageId.ResponseVoteInfo, self._ResponseVoteInfoCallback)

    if result ~= 0 then
        Logger.LogError("请求自己对英雄贡献Ack错误，错误码：" .. result)
        return
    end

    local data = {heroId=self.selectHeroId, cnt=msg.Cnt, rank=msg.Rank}
    self:GetCtrl():UpdateSelfHeroRankList(data)
end
----------------------------------Ack--End-------------------------------------------
return UIVotingHeroContext
