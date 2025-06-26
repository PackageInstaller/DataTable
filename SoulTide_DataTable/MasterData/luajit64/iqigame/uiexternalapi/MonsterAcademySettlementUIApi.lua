-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademySettlementUIApi.lua

MonsterAcademySettlementUIApi = BaseLangApi:Extend()

function MonsterAcademySettlementUIApi:Init()
	self:RegisterApi("BtnCloseLabel", self.GetBtnCloseLabel)
	self:RegisterApi("TextDes", self.GetTextDes)
end

function MonsterAcademySettlementUIApi:GetTextDes(state)
	if state > 0 then
		return self:GetCfgText(3420110)
	end

	return self:GetCfgText(3420111)
end

function MonsterAcademySettlementUIApi:GetBtnCloseLabel()
	return self:GetCfgText(3420081)
end

MonsterAcademySettlementUIApi:Init()
