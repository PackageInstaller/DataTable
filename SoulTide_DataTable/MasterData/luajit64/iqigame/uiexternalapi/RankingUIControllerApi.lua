-- chunkname: @IQIGame\\UIExternalApi\\RankingUIControllerApi.lua

RankingUIControllerApi = BaseLangApi:Extend()

function RankingUIControllerApi:Init()
	self:RegisterApi("RankingText", self.GetRankingText)
end

function RankingUIControllerApi:GetRankingText(ranking)
	if ranking == -1 then
		return "--"
	end

	if ranking == 0 then
		return "500+"
	end

	return ranking
end

RankingUIControllerApi:Init()
