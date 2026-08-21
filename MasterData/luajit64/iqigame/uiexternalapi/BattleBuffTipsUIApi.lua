-- chunkname: @IQIGame\\UIExternalApi\\BattleBuffTipsUIApi.lua

BattleBuffTipsUIApi = BaseLangApi:Extend()

function BattleBuffTipsUIApi:Init()
	self:RegisterApi("CDText", self.GetCDText)
	self:RegisterApi("DescText", self.GetDescText)
end

function BattleBuffTipsUIApi:GetCDText(count)
	if count ~= -1 then
		return count
	end

	return "∞"
end

function BattleBuffTipsUIApi:GetDescText(name, desc)
	if name == "" then
		return desc
	else
		return "[" .. name .. "]" .. desc
	end
end

BattleBuffTipsUIApi:Init()
