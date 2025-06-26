-- chunkname: @IQIGame\\UIExternalApi\\IllusionMazeMainUIApi.lua

IllusionMazeMainUIApi = BaseLangApi:Extend()
IllusionMazeMainUIApi.EmotionFragmentItemCids = {
	10711,
	10712,
	10713,
	10714
}

function IllusionMazeMainUIApi:Init()
	self:RegisterApi("StartTitleText", self.GetStartTitleText)
	self:RegisterApi("StartTipText", self.GetStartTipText)
	self:RegisterApi("BagBtnText", self.GetBagBtnText)
	self:RegisterApi("EmotionIcons", self.GetEmotionIcons)
	self:RegisterApi("EmotionParamId", self.GetEmotionParamId)
	self:RegisterApi("EmotionOverloadValue", self.GetEmotionOverloadValue)
	self:RegisterApi("EmotionBubblePath", self.GetEmotionBubblePath)
	self:RegisterApi("EmotionFragmentItemCids", self.GetEmotionFragmentItemCids)
	self:RegisterApi("MazeIntroductionText", self.GetMazeIntroductionText)
end

function IllusionMazeMainUIApi:GetStartTitleText()
	return self:GetCfgText(2200015)
end

function IllusionMazeMainUIApi:GetStartTipText(conditionsDesc)
	return ""
end

function IllusionMazeMainUIApi:GetBagBtnText()
	return self:GetCfgText(1234002)
end

function IllusionMazeMainUIApi:GetEmotionIcons()
	return {
		self:GetResUrl(1108001),
		self:GetResUrl(1108002),
		self:GetResUrl(1108003),
		self:GetResUrl(1108004)
	}
end

function IllusionMazeMainUIApi:GetEmotionParamId(index)
	if index == 1 then
		return 82000105
	elseif index == 2 then
		return 82000106
	elseif index == 3 then
		return 82000107
	elseif index == 4 then
		return 82000108
	end
end

function IllusionMazeMainUIApi:GetEmotionOverloadValue(index)
	if index == 1 then
		return 20
	elseif index == 2 then
		return 20
	elseif index == 3 then
		return 20
	elseif index == 4 then
		return 20
	end
end

function IllusionMazeMainUIApi:GetEmotionBubblePath(playerParamId, overloadNum)
	if overloadNum > 1 then
		return self:GetResUrl(1108010)
	end

	if playerParamId == 82000105 then
		return self:GetResUrl(1108012)
	elseif playerParamId == 82000106 then
		return self:GetResUrl(1108013)
	elseif playerParamId == 82000107 then
		return self:GetResUrl(1108011)
	elseif playerParamId == 82000108 then
		return self:GetResUrl(1108014)
	end
end

function IllusionMazeMainUIApi:GetEmotionFragmentItemCids()
	return IllusionMazeMainUIApi.EmotionFragmentItemCids
end

function IllusionMazeMainUIApi:GetMazeIntroductionText()
	return self:GetCfgText(2500008)
end

IllusionMazeMainUIApi:Init()
