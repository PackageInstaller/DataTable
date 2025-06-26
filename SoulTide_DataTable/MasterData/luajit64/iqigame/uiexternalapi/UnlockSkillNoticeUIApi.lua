-- chunkname: @IQIGame\\UIExternalApi\\UnlockSkillNoticeUIApi.lua

UnlockSkillNoticeUIApi = BaseLangApi:Extend()

function UnlockSkillNoticeUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goSignNew", self.GetSignNew)
end

function UnlockSkillNoticeUIApi:GetSignNew()
	return self:GetCfgText(1320001)
end

function UnlockSkillNoticeUIApi:GetTitle()
	return self:GetCfgText(1320002)
end

UnlockSkillNoticeUIApi:Init()
