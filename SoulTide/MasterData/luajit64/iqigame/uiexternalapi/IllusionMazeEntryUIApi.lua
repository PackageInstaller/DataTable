-- chunkname: @IQIGame\\UIExternalApi\\IllusionMazeEntryUIApi.lua

IllusionMazeEntryUIApi = BaseLangApi:Extend()

function IllusionMazeEntryUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("LeftCountText", self.GetLeftCountText)
	self:RegisterApi("ChallengeBtnText", self.GetChallengeBtnText)
	self:RegisterApi("RestoreBtnText", self.GetRestoreBtnText)
	self:RegisterApi("EnergyCostText", self.GetEnergyCostText)
	self:RegisterApi("CollectionBtnText", self.GetCollectionBtnText)
	self:RegisterApi("DifficultyTipTitle", self.GetDifficultyTipTitle)
	self:RegisterApi("DifficultyTipContent", self.GetDifficultyTipContent)
	self:RegisterApi("Lv1DiffLabel", self.GetLv1DiffLabel)
	self:RegisterApi("RewardLabel", self.GetRewardLabel)
	self:RegisterApi("IllusionDifficulty", self.GetIllusionDifficulty)
end

function IllusionMazeEntryUIApi:GetTitleText()
	return self:GetCfgText(2500007)
end

function IllusionMazeEntryUIApi:GetTipText()
	return self:GetCfgText(2500003)
end

function IllusionMazeEntryUIApi:GetLeftCountText(leftCount, defaultMaxCount)
	return string.format(self:GetCfgText(2500004) .. "%s/%s", leftCount, defaultMaxCount)
end

function IllusionMazeEntryUIApi:GetChallengeBtnText()
	return self:GetCfgText(2500005)
end

function IllusionMazeEntryUIApi:GetRestoreBtnText()
	return self:GetCfgText(2500006)
end

function IllusionMazeEntryUIApi:GetEnergyCostText(needEnergy, playerEnergy)
	local color

	color = playerEnergy < needEnergy and "#ff5757" or "#ffffff"

	return tostring("<color=" .. color .. ">" .. needEnergy .. "</color>")
end

function IllusionMazeEntryUIApi:GetCollectionBtnText()
	return self:GetCfgText(2500009)
end

function IllusionMazeEntryUIApi:GetDifficultyTipTitle()
	return self:GetCfgText(2500010)
end

function IllusionMazeEntryUIApi:GetDifficultyTipContent()
	return self:GetCfgText(2500011)
end

function IllusionMazeEntryUIApi:GetLv1DiffLabel()
	return self:GetCfgText(2500012)
end

function IllusionMazeEntryUIApi:GetRewardLabel()
	return self:GetCfgText(2500013)
end

function IllusionMazeEntryUIApi:GetIllusionDifficulty(chapterOrder, maxChapterOrder)
	if chapterOrder >= 17 then
		return 7, chapterOrder - 16, 3
	elseif chapterOrder >= 14 then
		return 6, chapterOrder - 13, 3
	elseif chapterOrder >= 11 then
		return 5, chapterOrder - 10, 3
	elseif chapterOrder >= 8 then
		return 4, chapterOrder - 7, 3
	elseif chapterOrder >= 5 then
		return 3, chapterOrder - 4, 3
	elseif chapterOrder >= 3 then
		return 2, chapterOrder - 2, 2
	else
		return 1, chapterOrder, 2
	end
end

IllusionMazeEntryUIApi:Init()
