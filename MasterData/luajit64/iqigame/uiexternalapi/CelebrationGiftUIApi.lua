-- chunkname: @IQIGame\\UIExternalApi\\CelebrationGiftUIApi.lua

CelebrationGiftUIApi = BaseLangApi:Extend()

function CelebrationGiftUIApi:Init()
	self:RegisterApi("TextTime", self.GetTextTime)
end

function CelebrationGiftUIApi:GetTextTime(timeStr)
	return string.format(self:GetCfgText(2900402), timeStr)
end

CelebrationGiftUIApi:Init()
