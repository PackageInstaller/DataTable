-- chunkname: @IQIGame\\UIExternalApi\\DoubleFightRewardUIApi.lua

DoubleFightRewardUIApi = BaseLangApi:Extend()

function DoubleFightRewardUIApi:Init()
	self:RegisterApi("TextInfoTitle", self.GetTextInfoTitle)
	self:RegisterApi("outBattleBtnTxt", self.GetOutBattleBtnTxt)
	self:RegisterApi("TextHurt", self.GetTextHurt)
end

function DoubleFightRewardUIApi:GetTextHurt(num)
	return self:GetCfgText(1213055) .. num
end

function DoubleFightRewardUIApi:GetOutBattleBtnTxt()
	return self:GetCfgText(1228005)
end

function DoubleFightRewardUIApi:GetTextInfoTitle()
	return self:GetCfgText(3505005)
end

DoubleFightRewardUIApi:Init()
