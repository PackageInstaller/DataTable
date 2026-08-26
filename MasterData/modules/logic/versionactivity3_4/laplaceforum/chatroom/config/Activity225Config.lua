-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/config/Activity225Config.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.config.Activity225Config", package.seeall)

local Activity225Config = class("Activity225Config", BaseConfig)

function Activity225Config:ctor()
	self._constConfig = nil
	self._npcConfig = nil
	self._npcInteractConfig = nil
	self._questionConfig = nil
	self._answerConfig = nil
	self._redenvelopeConfig = nil
	self._fingerGameConfig = nil
	self._fingerGameDifficultyConfig = nil
end

function Activity225Config:reqConfigNames()
	return {
		"meme",
		"activity225_const",
		"activity225_npc",
		"activity225_npc_interactive",
		"activity225_question",
		"activity225_answer",
		"activity225_red_envelope_rain",
		"activity225_rock_paper_scissors",
		"activity225_rock_paper_scissors_difficult"
	}
end

function Activity225Config:onConfigLoaded(configName, configTable)
	if configName == "activity225_const" then
		self._constConfig = configTable
	elseif configName == "meme" then
		self._memeConfig = configTable
	elseif configName == "activity225_npc" then
		self._npcConfig = configTable

		self:buildChatRoomNpcTypeListData()
	elseif configName == "activity225_npc_interactive" then
		self._npcInteractConfig = configTable
	elseif configName == "activity225_question" then
		self._questionConfig = configTable
	elseif configName == "activity225_answer" then
		self._answerConfig = configTable
	elseif configName == "activity225_red_envelope_rain" then
		self._redenvelopeConfig = configTable
	elseif configName == "activity225_rock_paper_scissors" then
		self._fingerGameConfig = configTable
	elseif configName == "activity225_rock_paper_scissors_difficult" then
		self._fingerGameDifficultyConfig = configTable
	end
end

function Activity225Config:getConstValue(constId, isNum, isLang)
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	local config = self._constConfig.configDict[actId][constId]

	if isLang then
		if not config.value2 then
			local value = config.value

			return isNum and not isLang and tonumber(value) or value
		end
	end
end

function Activity225Config:buildChatRoomNpcTypeListData()
	self.chatRoomNpcTypeCoMap = {}

	for _, config in ipairs(self._npcConfig.configList) do
		self.chatRoomNpcTypeCoMap[config.npcType] = self.chatRoomNpcTypeCoMap[config.npcType] or {}

		if config.activityId == VersionActivity3_4Enum.ActivityId.LaplaceChatRoom then
			table.insert(self.chatRoomNpcTypeCoMap[config.npcType], config)
		end
	end
end

function Activity225Config:getChatRoomNpcCoListByType(npcType)
	return self.chatRoomNpcTypeCoMap[npcType]
end

function Activity225Config:getNpcCosByType(npcId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	return self._npcConfig.configDict[actId][npcId]
end

function Activity225Config:getNpcInteractCo(interactId)
	return self._npcInteractConfig.configDict[interactId]
end

function Activity225Config:getQuestionCos(actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	return self._questionConfig.configDict[actId]
end

function Activity225Config:getQuestionCo(questionId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	return self._questionConfig.configDict[actId][questionId]
end

function Activity225Config:getAnswerCo(answerId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	return self._answerConfig.configDict[answerId]
end

function Activity225Config:getRedEnvelopRainCos(actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	return self._redenvelopeConfig.configDict[actId]
end

function Activity225Config:getRedEnvelopRainCo(rainId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	return self._redenvelopeConfig.configDict[actId][rainId]
end

function Activity225Config:getFingerGameCo(actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	return self._fingerGameConfig.configDict[actId]
end

function Activity225Config:getGamePoint(resultType, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	local cfg = self:getFingerGameCo(actId)

	if resultType == ChatRoomEnum.GameResultType.Victory then
		return cfg.winBonus
	elseif resultType == ChatRoomEnum.GameResultType.Defeat then
		return cfg.loseBonus
	elseif resultType == ChatRoomEnum.GameResultType.Draw then
		return cfg.drawBonus
	end
end

function Activity225Config:getFingerGameDifficultyCos()
	return self._fingerGameDifficultyConfig.configDict
end

function Activity225Config:getFingerGameDifficultyCo(day)
	return self._fingerGameDifficultyConfig.configDict[day]
end

function Activity225Config:getMemeConfig(id)
	return self._memeConfig.configDict[id]
end

function Activity225Config:getMemeConfigList()
	return self._memeConfig.configList
end

Activity225Config.instance = Activity225Config.New()

return Activity225Config
