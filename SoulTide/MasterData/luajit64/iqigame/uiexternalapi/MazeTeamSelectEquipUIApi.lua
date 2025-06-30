-- chunkname: @IQIGame\\UIExternalApi\\MazeTeamSelectEquipUIApi.lua

MazeTeamSelectEquipUIApi = BaseLangApi:Extend()

function MazeTeamSelectEquipUIApi:Init()
	self:RegisterApi("WearingText", self.GetWearingText)
	self:RegisterApi("EquipBtnText", self.GetEquipBtnText)
	self:RegisterApi("UnloadBtnText", self.GetUnloadBtnText)
	self:RegisterApi("SortBtnText", self.GetSortBtnText)
end

function MazeTeamSelectEquipUIApi:GetWearingText()
	return self:GetCfgText(1001028)
end

function MazeTeamSelectEquipUIApi:GetEquipBtnText()
	return self:GetCfgText(1211042)
end

function MazeTeamSelectEquipUIApi:GetUnloadBtnText()
	return self:GetCfgText(1314052)
end

function MazeTeamSelectEquipUIApi:GetSortBtnText(type)
	if type == 1 then
		return self:GetCfgText(1314318)
	elseif type == 2 then
		return self:GetCfgText(1314319)
	elseif type == 3 then
		return self:GetCfgText(1314320)
	end

	return "???"
end

MazeTeamSelectEquipUIApi:Init()
