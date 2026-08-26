-- chunkname: @modules/logic/versionactivity1_5/peaceulu/config/PeaceUluConfig.lua

module("modules.logic.versionactivity1_5.peaceulu.config.PeaceUluConfig", package.seeall)

local PeaceUluConfig = class("PeaceUluConfig", BaseConfig)

function PeaceUluConfig:ctor()
	self._act145taskList = {}
	self._act145bonusList = {}
	self._act145voiceList = {}
end

function PeaceUluConfig:reqConfigNames()
	return {
		"activity145_task",
		"activity145_task_bonus",
		"activity145_game",
		"activity145_const",
		"activity145_movement"
	}
end

function PeaceUluConfig:onInit()
	return
end

function PeaceUluConfig:onConfigLoaded(configName, configTable)
	if configName == "activity145_task_bonus" then
		for _, bonusCo in ipairs(configTable.configList) do
			table.insert(self._act145bonusList, bonusCo)
		end
	elseif configName == "activity145_task" then
		for _, taskCo in ipairs(configTable.configList) do
			table.insert(self._act145taskList, taskCo)
		end
	elseif configName == "activity145_movement" then
		for _, voiceCo in ipairs(configTable.configList) do
			table.insert(self._act145voiceList, voiceCo)
		end
	end
end

function PeaceUluConfig:getBonusCoList()
	return self._act145bonusList
end

function PeaceUluConfig:getBonusCount()
	return #self._act145bonusList
end

function PeaceUluConfig:getVoiceList()
	return self._act145voiceList
end

function PeaceUluConfig:getVoiceConfigByType(type)
	for key, voiceCo in pairs(self._act145voiceList) do
		if type == voiceCo.type then
			return voiceCo
		end
	end
end

function PeaceUluConfig:getMaxProgress()
	local co = self._act145bonusList[#self._act145bonusList]
	local temp = string.split(co.needProgress, "#")

	return temp[3]
end

function PeaceUluConfig:getProgressByIndex(index)
	if index < 1 and index > #self._act145bonusList then
		return
	end

	local co = self._act145bonusList[index]
	local temp = string.split(co.needProgress, "#")

	return tonumber(temp[3])
end

function PeaceUluConfig:getTaskCoList()
	return self._act145taskList
end

function PeaceUluConfig:getTaskCo(id)
	for i, v in ipairs(self._act145taskList) do
		if v.id == id then
			return v
		end
	end

	return self._act145taskList[id]
end

function PeaceUluConfig:getGameTimes()
	return 3
end

PeaceUluConfig.instance = PeaceUluConfig.New()

return PeaceUluConfig
