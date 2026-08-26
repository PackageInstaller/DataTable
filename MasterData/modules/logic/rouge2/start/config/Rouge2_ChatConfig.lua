-- chunkname: @modules/logic/rouge2/start/config/Rouge2_ChatConfig.lua

module("modules.logic.rouge2.start.config.Rouge2_ChatConfig", package.seeall)

local Rouge2_ChatConfig = class("Rouge2_ChatConfig", BaseConfig)

function Rouge2_ChatConfig:onInit()
	return
end

function Rouge2_ChatConfig:reqConfigNames()
	return {
		"rouge_speaker",
		"rouge_talk"
	}
end

function Rouge2_ChatConfig:onConfigLoaded(configName, configTable)
	return
end

function Rouge2_ChatConfig:getSpeakerConfig(speakerId)
	local speakerCo = lua_rouge_speaker.configDict[speakerId]

	if not speakerCo then
		logError(string.format("肉鸽对话人配置不存在 speakerId = %s", speakerId))
	end

	return speakerCo
end

function Rouge2_ChatConfig:getSpeakerName(speakerId)
	local speakerCo = self:getSpeakerConfig(speakerId)

	return speakerCo and speakerCo.name
end

function Rouge2_ChatConfig:getTalkConfig(talkId)
	local talkCo = lua_rouge_talk.configDict[talkId]

	if not talkCo then
		logError(string.format("肉鸽对话配置不存在 talkId = %s", talkId))
	end

	return talkCo
end

function Rouge2_ChatConfig:getTalkDesc(talkId)
	local talkCo = self:getTalkConfig(talkId)

	return talkCo and talkCo.desc
end

Rouge2_ChatConfig.instance = Rouge2_ChatConfig.New()

return Rouge2_ChatConfig
