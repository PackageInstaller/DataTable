-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/config/ForceSlideConfig.lua

module("logic.extensions.forceslide.config.ForceSlideConfig", package.seeall)

local ForceSlideConfig = class("ForceSlideConfig", BaseConfig)

function ForceSlideConfig:onInit()
	ForceSlideConfig.super.onInit(self)

	self._force_slide_tab = nil
	self._force_slide_word = nil
	self._force_slide_common = nil
end

function ForceSlideConfig:getNames()
	return {
		"force_slide_tab",
		"force_slide_word",
		"force_slide_common"
	}
end

function ForceSlideConfig:handleConfig(name, content)
	if name == "force_slide_tab" then
		self._force_slide_tab = content
	elseif name == "force_slide_word" then
		self._force_slide_word = content
	elseif name == "force_slide_common" then
		self._force_slide_common = content
	end
end

function ForceSlideConfig:getCommonValue(key)
	local conf = self._force_slide_common[key]

	if conf then
		return conf.value
	end

	return ""
end

function ForceSlideConfig:getActCfg()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.ForceSlide)

	for _, item in pairs(cfgs) do
		return item
	end

	return nil
end

function ForceSlideConfig:getActId()
	local cfg = self:getActCfg()

	if cfg then
		return cfg.activityId
	end

	return -2
end

function ForceSlideConfig:getJumpConf(activityId, index)
	return
end

function ForceSlideConfig:getTabConf(activityId, index)
	return self._force_slide_tab[activityId][index]
end

function ForceSlideConfig:getWordConfs(activityId)
	return self._force_slide_word[activityId]
end

ForceSlideConfig.instance = ForceSlideConfig.New()

return ForceSlideConfig
