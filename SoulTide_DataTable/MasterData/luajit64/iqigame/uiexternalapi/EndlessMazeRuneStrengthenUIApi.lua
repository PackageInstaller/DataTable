-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneStrengthenUIApi.lua

EndlessMazeRuneStrengthenUIApi = BaseLangApi:Extend()

function EndlessMazeRuneStrengthenUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("LeftCountText", self.GetLeftCountText)
	self:RegisterApi("LevelText", self.GetLevelText)
	self:RegisterApi("DescLabelText", self.GetDescLabelText)
end

function EndlessMazeRuneStrengthenUIApi:GetTitleText()
	return self:GetCfgText(2200070)
end

function EndlessMazeRuneStrengthenUIApi:GetLeftCountText(count)
	return self:GetCfgText(2200071) .. count
end

function EndlessMazeRuneStrengthenUIApi:GetLevelText(level)
	return self:GetCfgText(1215002) .. level
end

function EndlessMazeRuneStrengthenUIApi:GetDescLabelText()
	return self:GetCfgText(2200072)
end

EndlessMazeRuneStrengthenUIApi:Init()
