local UIVotingContext = BaseClass("UIVotingContext", BaseContext)
local M = UIVotingContext
local VotingTimer = EnumConst.VotingTimer
local MessageId = Proto.MessageId
local tSort = table.sort
-- UIVoting
function M:Init()
end

function M:Open()
    if VotingDataMgr:GetInstance():GetNowState() == VotingTimer.Timer2 or VotingDataMgr:GetInstance():GetNowState() == VotingTimer.Timer4 then
        self:HeroRankReq()
    else
        self:_Show()
    end
end

function M.SortData(data1, data2)
    if data1.Ticket ~= data2.Ticket then
        return data1.Ticket > data2.Ticket
    end
    if data1.rare ~= data2.rare then
        return data1.rare > data2.rare
    end
    return data1.heroId < data2.heroId
end

function M:UpdateHeroData(heroDatas)
    self.heroDatas = heroDatas

    for i = 1, #self.heroDatas do
        self.heroDatas[i].heroId = self.heroDatas[i].HeroId
        self.heroDatas[i].rare = ConfigHelper.GetCfgPropByLua("hero", self.heroDatas[i].HeroId, "rare")
    end

    tSort(self.heroDatas, self.SortData)
end

function M:GetHeroDatas()
    return self.heroDatas or {}
end

------------------------------------Start-------------------------------------------
-- 请求英雄排行
function M:HeroRankReq()
    Logger.Log("请求英雄排行Req")

    self._ResponseHeroRankCallback = NetPack:RegistResponse(MessageId.ResponseHeroRank, Bind(self, self.ResponseHeroRankCallback))
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    NetPack:SendMessage(MessageId.RequestHeroRank, request)
end

function M:ResponseHeroRankCallback(_, result, msg)
    Logger.Log("请求英雄排行Ack")
    NetPack:UnRegistResponse(MessageId.ResponseHeroRank, self._ResponseHeroRankCallback)
    self._ResponseHeroRankCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end

    self:UpdateHeroData(msg.Data)
    self:_Show()
end

------------------------------------End-------------------------------------------

function M:OnClose()
    M.super.OnClose(self)
end
return UIVotingContext
