-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/config/FamilyTechConfig.lua

module("logic.extensions.familytech.config.FamilyTechConfig", package.seeall)

local FamilyTechConfig = class("FamilyTechConfig", BaseConfig)

function FamilyTechConfig:onInit()
	FamilyTechConfig.super.onInit(self)

	self._cfgDic = {}
end

function FamilyTechConfig:getNames()
	return {
		"family_tech",
		"family_tech_level_define"
	}
end

function FamilyTechConfig:handleConfig(name, content)
	if not string.nilorempty(name) then
		self._cfgDic[name] = content
	end
end

function FamilyTechConfig:getFamilyTechCfgs()
	return self._cfgDic.family_tech.dataList
end

function FamilyTechConfig:getFamilyTechCfg(techId)
	local t = self._cfgDic.family_tech

	if t then
		return t[techId]
	end
end

function FamilyTechConfig:getFamilyTechLvCfg(techId, level)
	print("techId = " .. techId .. "level = " .. level)

	local t = self._cfgDic.family_tech_level_define

	if t[techId] then
		return t[techId][level]
	end
end

FamilyTechConfig.instance = FamilyTechConfig.New()

return FamilyTechConfig
