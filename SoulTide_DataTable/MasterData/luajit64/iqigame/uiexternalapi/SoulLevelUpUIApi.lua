-- chunkname: @IQIGame\\UIExternalApi\\SoulLevelUpUIApi.lua

SoulLevelUpUIApi = BaseLangApi:Extend()

function SoulLevelUpUIApi:Init()
	self:RegisterApi("goExpItemName", self.GetExpItemName)
	self:RegisterApi("goSelectedNum", self.GetSelectedNum)
	self:RegisterApi("goOwnNum", self.GetOwnNum)
end

function SoulLevelUpUIApi:GetOwnNum(ownCount)
	return ownCount
end

function SoulLevelUpUIApi:GetSelectedNum(num)
	return "x" .. num
end

function SoulLevelUpUIApi:GetExpItemName(name)
	return name
end

SoulLevelUpUIApi:Init()
