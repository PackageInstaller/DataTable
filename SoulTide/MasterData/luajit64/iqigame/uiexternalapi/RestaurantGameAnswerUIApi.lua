-- chunkname: @IQIGame\\UIExternalApi\\RestaurantGameAnswerUIApi.lua

RestaurantGameAnswerUIApi = BaseLangApi:Extend()

function RestaurantGameAnswerUIApi:Init()
	self:RegisterApi("TextSchedule", self.GetTextSchedule)
end

function RestaurantGameAnswerUIApi:GetTextSchedule(num, totalNum, rightNum)
	return string.format(self:GetCfgText(3810061), num, totalNum, rightNum)
end

RestaurantGameAnswerUIApi:Init()
