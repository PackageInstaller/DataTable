-- chunkname: @IQIGame\\UIExternalApi\\SoulLockUIApi.lua

SoulLockUIApi = BaseLangApi:Extend()

function SoulLockUIApi:Init()
	self:RegisterApi("goBtnClose", self.GetBtnCloseTxt)
	self:RegisterApi("goSoulName", self.GetSoulName)
	self:RegisterApi("goSoulNameEng", self.GetSoulNameEng)
	self:RegisterApi("goSoulTitle", self.GetSoulTitle)
	self:RegisterApi("goSoulDesc", self.GetSoulDesc)
	self:RegisterApi("goCvName", self.GetCvName)
	self:RegisterApi("goToggle", self.GetToggleTxt)
	self:RegisterApi("goPrefabName", self.GetPrefabName)
	self:RegisterApi("goPrefabDesc", self.GetPrefabDesc)
	self:RegisterApi("goSkillTitle", self.GetSkillTitle)
	self:RegisterApi("goStoryTitle", self.GetStoryTitle)
	self:RegisterApi("typeSort", self.GetTypeSort)
	self:RegisterApi("cvDesc", self.GetCvDesc)
end

function SoulLockUIApi:GetTypeSort()
	return {
		1,
		2,
		3,
		4
	}
end

function SoulLockUIApi:GetCvDesc()
	return self:GetCfgText(2300802) .. ":"
end

function SoulLockUIApi:GetStoryTitle()
	return self:GetCfgText(2300800)
end

function SoulLockUIApi:GetSkillTitle()
	return self:GetCfgText(2300801)
end

function SoulLockUIApi:GetPrefabName(name)
	return name
end

function SoulLockUIApi:GetPrefabDesc(desc)
	return desc
end

function SoulLockUIApi:GetToggleTxt(index)
	if index == 1 then
		return self:GetCfgText(1224001)
	else
		return self:GetCfgText(1224002)
	end
end

function SoulLockUIApi:GetBtnCloseTxt()
	return self:GetCfgText(1224003)
end

function SoulLockUIApi:GetSoulName(name)
	return name
end

function SoulLockUIApi:GetSoulNameEng(name)
	return name
end

function SoulLockUIApi:GetSoulTitle(title)
	return title
end

function SoulLockUIApi:GetSoulDesc(desc)
	return desc
end

function SoulLockUIApi:GetCvName(name)
	return name
end

SoulLockUIApi:Init()
