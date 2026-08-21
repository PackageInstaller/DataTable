-- baoruichang
-- 2021/12/9 11:57:05
local UIVotingEight2Context = BaseClass("UIVotingEight2Context", BaseContext)
local M = UIVotingEight2Context
local MessageId = Proto.MessageId
local tSort = table.sort

function M:Init()
end

function M:Open()
    if not self.nextRefTimer or TimeUtil.GetNowTimeStamp() > self.nextRefTimer then
        self:HeroRankReq()
    else
        self:_Show(self:GetHeroDatas())
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

function M:GetNextRefTimer()
    return self.nextRefTimer or 0
end

------------------------------------Start-------------------------------------------
-- 请求英雄排行
function M:HeroRankReq()
    self._ResponseHeroRankCallback = NetPack:RegistResponse(MessageId.ResponseHeroRank, Bind(self, self.ResponseHeroRankCallback))
    local request = {}
    request.ActivityId = VotingDataMgr:GetInstance():GetActivityId()
    NetPack:SendMessage(MessageId.RequestHeroRank, request)
end

function M:ResponseHeroRankCallback(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseHeroRank, self._ResponseHeroRankCallback)
    self._ResponseHeroRankCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self.nextRefTimer = TimeUtil.GetNowTimeStamp() + msg.Countdown
    self:UpdateHeroData(msg.Data)
    self:_Show(self:GetHeroDatas())
end

------------------------------------End-------------------------------------------

return UIVotingEight2Context
