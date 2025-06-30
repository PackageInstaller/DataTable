-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkGameAnswerUIApi.lua

AmusementParkGameAnswerUIApi = BaseLangApi:Extend()

function AmusementParkGameAnswerUIApi:Init()
	self:RegisterApi("TextSchedule", self.GetTextSchedule)
	self:RegisterApi("TextLock", self.GetTextLock)
end

function AmusementParkGameAnswerUIApi:GetTextLock(name, needLV)
	return string.format(self:GetCfgText(3830090), name, needLV)
end

function AmusementParkGameAnswerUIApi:GetTextSchedule(num, totalNum, rightNum)
	return string.format(self:GetCfgText(3830091), rightNum, totalNum)
end

AmusementParkGameAnswerUIApi:Init()
