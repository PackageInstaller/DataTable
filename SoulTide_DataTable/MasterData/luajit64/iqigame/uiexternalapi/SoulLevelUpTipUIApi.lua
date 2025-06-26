-- chunkname: @IQIGame\\UIExternalApi\\SoulLevelUpTipUIApi.lua

SoulLevelUpTipUIApi = BaseLangApi:Extend()

function SoulLevelUpTipUIApi:Init()
	self:RegisterApi("goLvUpTitle", self.GetLvUpTitle)
	self:RegisterApi("goLvUpTitleEng", self.GetLvUpTitleEng)
	self:RegisterApi("goAttTitle", self.GetAttTitle)
	self:RegisterApi("goLvPre", self.GetLvPre)
	self:RegisterApi("goLvCur", self.GetLvCur)
	self:RegisterApi("goAttName", self.GetAttName)
	self:RegisterApi("goAttValuePre", self.GetAttValuePre)
	self:RegisterApi("goAttValueCur", self.GetAttValueCur)
end

function SoulLevelUpTipUIApi:GetLvUpTitle()
	return self:GetCfgText(2300551)
end

function SoulLevelUpTipUIApi:GetLvUpTitleEng()
	return self:GetCfgText(2300552)
end

function SoulLevelUpTipUIApi:GetAttTitle()
	return self:GetCfgText(2300553)
end

function SoulLevelUpTipUIApi:GetLvPre(lv)
	return "<size=24>Lv.</size>" .. tostring(lv)
end

function SoulLevelUpTipUIApi:GetLvCur(lv)
	return tostring(lv)
end

function SoulLevelUpTipUIApi:GetAttName(name)
	return name
end

function SoulLevelUpTipUIApi:GetAttValuePre(value)
	return value
end

function SoulLevelUpTipUIApi:GetAttValueCur(value)
	return value
end

SoulLevelUpTipUIApi:Init()
