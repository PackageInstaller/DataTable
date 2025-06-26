-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyPlayerCallPhoneUIApi.lua

MonsterAcademyPlayerCallPhoneUIApi = BaseLangApi:Extend()

function MonsterAcademyPlayerCallPhoneUIApi:Init()
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("BtnHangUpLabel", self.GetBtnHangUpLabel)
end

function MonsterAcademyPlayerCallPhoneUIApi:GetTextDes()
	return self:GetCfgText(3420328)
end

function MonsterAcademyPlayerCallPhoneUIApi:GetBtnHangUpLabel()
	return self:GetCfgText(3420329)
end

MonsterAcademyPlayerCallPhoneUIApi:Init()
