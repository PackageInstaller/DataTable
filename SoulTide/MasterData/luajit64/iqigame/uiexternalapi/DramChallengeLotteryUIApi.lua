-- chunkname: @IQIGame\\UIExternalApi\\DramChallengeLotteryUIApi.lua

DramChallengeLotteryUIApi = BaseLangApi:Extend()

function DramChallengeLotteryUIApi:Init()
	self:RegisterApi("PeizeDrawMoreBtnText", self.GetPeizeDrawMoreBtnText)
	self:RegisterApi("TotalityAndRemainderText", self.GetTotalityAndRemainderText)
	self:RegisterApi("RewardCountText", self.GetRewardTextCount)
	self:RegisterApi("PeizeDrawPriceText", self.GetPeizeDrawPriceText)
end

function DramChallengeLotteryUIApi:GetPeizeDrawMoreBtnText(count)
	return string.format("抽%s次", count)
end

function DramChallengeLotteryUIApi:GetPeizeDrawPriceText(count)
	return string.format("x%s", count)
end

function DramChallengeLotteryUIApi:GetTotalityAndRemainderText(currentcount, count)
	if currentcount <= 0 then
		return string.format("%s/%s", self.TextColor[41] .. currentcount .. self.TextColor[0], count)
	end

	return string.format("%s/%s", currentcount, count)
end

function DramChallengeLotteryUIApi:GetRewardTextCount(currentcount, count)
	if currentcount <= 0 then
		return string.format("%s/%s", self.TextColor[41] .. currentcount .. self.TextColor[0], count)
	end

	return string.format("%s/%s", currentcount, count)
end

DramChallengeLotteryUIApi:Init()
