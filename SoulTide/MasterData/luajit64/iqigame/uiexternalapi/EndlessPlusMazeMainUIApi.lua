-- chunkname: @IQIGame\\UIExternalApi\\EndlessPlusMazeMainUIApi.lua

EndlessPlusMazeMainUIApi = BaseLangApi:Extend()

function EndlessPlusMazeMainUIApi:Init()
	self:RegisterApi("MazeNameText", self.GetMazeNameText)
	self:RegisterApi("LayerLabel", self.GetLayerLabel)
	self:RegisterApi("EngravingBtnText", self.GetEngravingBtnText)
	self:RegisterApi("MazeTopRightRuneNoticeTypeText", self.GetMazeTopRightRuneNoticeTypeText)
	self:RegisterApi("StartTitleText", self.GetStartTitleText)
	self:RegisterApi("StartTipText", self.GetStartTipText)
	self:RegisterApi("NextRewardTipDescText", self.GetNextRewardTipDescText)
	self:RegisterApi("StartRuneEffectCid", self.GetStartRuneEffectCid)
	self:RegisterApi("FlyRuneEffectCid", self.GetFlyRuneEffectCid)
end

function EndlessPlusMazeMainUIApi:GetMazeNameText(chapterOrder, order, name)
	return name
end

function EndlessPlusMazeMainUIApi:GetLayerLabel()
	return self:GetCfgText(3410970)
end

function EndlessPlusMazeMainUIApi:GetEngravingBtnText()
	return self:GetCfgText(2200010)
end

function EndlessPlusMazeMainUIApi:GetMazeTopRightRuneNoticeTypeText(type)
	if type == 2 then
		return self:GetCfgText(2200011)
	elseif type == 3 then
		return self:GetCfgText(2200012)
	elseif type == 4 then
		return self:GetCfgText(2200013)
	elseif type == 5 then
		return self:GetCfgText(2200014)
	end
end

function EndlessPlusMazeMainUIApi:GetStartTitleText()
	return self:GetCfgText(2200015)
end

function EndlessPlusMazeMainUIApi:GetStartTipText(conditionsDesc)
	return ""
end

function EndlessPlusMazeMainUIApi:GetNextRewardTipDescText(score, rewardScore)
	return self:GetCfgText(2200016) .. rewardScore - score .. self:GetCfgText(2200017)
end

function EndlessPlusMazeMainUIApi:GetStartRuneEffectCid(quality)
	if quality == 1 then
		return 9001641
	elseif quality == 2 then
		return 9001642
	elseif quality == 3 then
		return 9001643
	end
end

function EndlessPlusMazeMainUIApi:GetFlyRuneEffectCid(quality)
	if quality == 1 then
		return 9001644
	elseif quality == 2 then
		return 9001645
	elseif quality == 3 then
		return 9001646
	end
end

EndlessPlusMazeMainUIApi:Init()
