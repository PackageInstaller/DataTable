-- chunkname: @IQIGame\\UIExternalApi\\CombatFormationUIApi.lua

CombatFormationUIApi = BaseLangApi:Extend()

function CombatFormationUIApi:Init()
	self:RegisterApi("GetTextTitle01", self.GetTextTitle_1)
	self:RegisterApi("Default", self.GetTextTitle_2)
	self:RegisterApi("Quality", self.GetTextTitle_3)
end

function CombatFormationUIApi:GetTextTitle_1()
	return self:GetCfgText(1600002) .. "."
end

function CombatFormationUIApi:GetTextTitle_2()
	return self:GetCfgText(1600023)
end

function CombatFormationUIApi:GetTextTitle_3()
	return self:GetCfgText(1600003)
end

function CombatFormationUIApi:SortArrPath(isUp)
	if isUp then
		return UIGlobalApi.ImagePath .. "/Formation/Main/Formation_main19"
	end
end

function CombatFormationUIApi:GetAttack(isRed)
	if isRed then
		return self:GetResUrl(1100015)
	else
		return self:GetResUrl(1100016)
	end
end

CombatFormationUIApi:Init()
