-- chunkname: @IQIGame\\UIExternalApi\\MazeScoreLevelUpUIApi.lua

MazeScoreLevelUpUIApi = BaseLangApi:Extend()

function MazeScoreLevelUpUIApi:Init()
	self:RegisterApi("ScoreLevelLabel", self.GetScoreLevelLabel)
	self:RegisterApi("ScoreLevelImages", self.GetScoreLevelImages)
end

function MazeScoreLevelUpUIApi:GetScoreLevelLabel()
	return self:GetCfgText(1315033)
end

function MazeScoreLevelUpUIApi:GetScoreLevelImages()
	return {
		self:GetResUrl(1102001),
		self:GetResUrl(1102001),
		self:GetResUrl(1102002),
		self:GetResUrl(1102003),
		self:GetResUrl(1102004),
		self:GetResUrl(1102005)
	}
end

MazeScoreLevelUpUIApi:Init()
