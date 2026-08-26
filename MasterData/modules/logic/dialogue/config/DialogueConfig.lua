-- chunkname: @modules/logic/dialogue/config/DialogueConfig.lua

module("modules.logic.dialogue.config.DialogueConfig", package.seeall)

local DialogueConfig = class("DialogueConfig", BaseConfig)

function DialogueConfig:ctor()
	return
end

function DialogueConfig:reqConfigNames()
	return {
		"dialog_group",
		"dialog",
		"dialog_step",
		"dialogue_chess_info"
	}
end

function DialogueConfig:onConfigLoaded(configName, configTable)
	if configName == "dialog" then
		self.dialogueDict = configTable
	elseif configName == "dialog_step" then
		self:initDialogueStepList(configTable.configList)
	elseif configName == "dialogue_chess_info" then
		self:initChessInfo(configTable.configList)
	end
end

function DialogueConfig:initDialogueStepList(stepList)
	self.dialogueGroup2StepList = {}

	for _, stepCo in ipairs(stepList) do
		local tempStepList = self.dialogueGroup2StepList[stepCo.groupId]

		if not tempStepList then
			tempStepList = {}
			self.dialogueGroup2StepList[stepCo.groupId] = tempStepList
		end

		table.insert(tempStepList, stepCo)
	end

	for _, tempStepList in pairs(self.dialogueGroup2StepList) do
		table.sort(tempStepList, DialogueConfig.sortStepFunc)
	end
end

function DialogueConfig.sortStepFunc(stepCo1, stepCo2)
	return stepCo1.id < stepCo2.id
end

function DialogueConfig:initChessInfo(chessCoList)
	self.dialogueId2ChessCoList = {}

	for _, chessCo in ipairs(chessCoList) do
		local chessList = self.dialogueId2ChessCoList[chessCo.dialogueId]

		if not chessList then
			chessList = {}
			self.dialogueId2ChessCoList[chessCo.dialogueId] = chessList
		end

		table.insert(chessList, chessCo)
	end
end

function DialogueConfig:getDialogueCo(dialogueId)
	return self.dialogueDict.configDict[dialogueId]
end

function DialogueConfig:getDialogueStepList(groupId)
	local stepList = self.dialogueGroup2StepList[groupId]

	if not stepList then
		logError("not found group step , group id : " .. tostring(groupId))
	end

	return stepList
end

function DialogueConfig:getChessCoList(dialogueId)
	return self.dialogueId2ChessCoList[dialogueId]
end

DialogueConfig.instance = DialogueConfig.New()

return DialogueConfig
