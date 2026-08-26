-- chunkname: @modules/logic/teach/config/TeachNoteConfig.lua

module("modules.logic.teach.config.TeachNoteConfig", package.seeall)

local TeachNoteConfig = class("TeachNoteConfig", BaseConfig)

function TeachNoteConfig:ctor()
	self.topicConfig = nil
	self.levelConfig = nil
end

function TeachNoteConfig:reqConfigNames()
	return {
		"instruction_topic",
		"instruction_level"
	}
end

function TeachNoteConfig:onConfigLoaded(configName, configTable)
	if configName == "instruction_topic" then
		self.topicConfig = configTable
	elseif configName == "instruction_level" then
		self.levelConfig = configTable
	end
end

function TeachNoteConfig:getInstructionTopicCos()
	return self.topicConfig.configDict
end

function TeachNoteConfig:getInstructionLevelCos()
	return self.levelConfig.configDict
end

function TeachNoteConfig:getInstructionTopicCO(id)
	return self.topicConfig.configDict[id]
end

function TeachNoteConfig:getInstructionLevelCO(id)
	return self.levelConfig.configDict[id]
end

TeachNoteConfig.instance = TeachNoteConfig.New()

return TeachNoteConfig
