-- chunkname: @IQIGame\\UIExternalApi\\LotteryGashaponUIApi.lua

LotteryGashaponUIApi = BaseLangApi:Extend()

function LotteryGashaponUIApi:Init()
	self:RegisterApi("durationMachine", self.GetDurationMachine)
	self:RegisterApi("durationShake", self.GetDurationShake)
	self:RegisterApi("durationEggOut", self.GetDurationEggOut)
	self:RegisterApi("durationEggShow", self.GetDurationEggShow)
end

function LotteryGashaponUIApi:GetDurationMachine()
	return 1.3
end

function LotteryGashaponUIApi:GetDurationShake()
	return 1
end

function LotteryGashaponUIApi:GetDurationEggOut()
	return 0.8
end

function LotteryGashaponUIApi:GetDurationEggShow()
	return 2
end

LotteryGashaponUIApi:Init()
