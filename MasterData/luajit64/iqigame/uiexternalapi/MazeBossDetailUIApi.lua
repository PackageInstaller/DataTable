-- chunkname: @IQIGame\\UIExternalApi\\MazeBossDetailUIApi.lua

MazeBossDetailUIApi = BaseLangApi:Extend()

function MazeBossDetailUIApi:Init()
	self:RegisterApi("NoFormations", self.GetNoFormations)
	self:RegisterApi("TitleName", self.GetTitleName)
	self:RegisterApi("TextMonsterList", self.GetTextMonsterList)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("UnlockError", self.GetUnlockError)
	self:RegisterApi("OpenEXBoss", self.GetOpenEXBoss)
end

function MazeBossDetailUIApi:GetOpenEXBoss()
	return self:GetCfgText(3100501)
end

function MazeBossDetailUIApi:GetUnlockError()
	return self:GetCfgText(3100401)
end

function MazeBossDetailUIApi:GetTextReward(type)
	if type == 1 then
		return self:GetCfgText(3100502)
	end

	return self:GetCfgText(3100503)
end

function MazeBossDetailUIApi:GetTextMonsterList()
	return self:GetCfgText(3100504)
end

function MazeBossDetailUIApi:GetTitleName()
	return self:GetCfgText(2000078)
end

function MazeBossDetailUIApi:GetNoFormations()
	return self:GetCfgText(1213047)
end

MazeBossDetailUIApi:Init()
