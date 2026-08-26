-- chunkname: @modules/logic/versionactivity1_9/fairyland/model/FairyLandModel.lua

module("modules.logic.versionactivity1_9.fairyland.model.FairyLandModel", package.seeall)

local FairyLandModel = class("FairyLandModel", BaseModel)

function FairyLandModel:onInit()
	self:reInit()
end

function FairyLandModel:reInit()
	self.stairIndex = 1
	self.passPuzzleDict = {}
	self.dialogDict = {}
	self.finishElementDict = {}
	self.hasInfo = false
end

function FairyLandModel:onGetFairylandInfoReply(info)
	self:clear()
	self:updateInfo(info.info)
end

function FairyLandModel:onResolvePuzzleReply(info)
	self:updateInfo(info.info)
end

function FairyLandModel:onRecordDialogReply(info)
	self:updateInfo(info.info)
end

function FairyLandModel:onRecordElementReply(info)
	self:updateInfo(info.info)
end

function FairyLandModel:updateInfo(info)
	self.hasInfo = true
	self.passPuzzleDict = {}
	self.dialogDict = {}
	self.finishElementDict = {}

	if not info then
		return
	end

	for i = 1, #info.passPuzzleId do
		self.passPuzzleDict[info.passPuzzleId[i]] = true
	end

	for i = 1, #info.dialogId do
		self.dialogDict[info.dialogId[i]] = true
	end

	for i = 1, #info.finishElementId do
		self.finishElementDict[info.finishElementId[i]] = true
	end
end

function FairyLandModel:setFinishDialog(dialogId)
	if not self.dialogDict then
		return
	end

	self.dialogDict[dialogId] = true
end

function FairyLandModel:setPos(stairIndex, isMove)
	self.stairIndex = stairIndex

	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetStairPos, isMove)
end

function FairyLandModel:getStairPos()
	return self.stairIndex or 1
end

function FairyLandModel:caleCurStairPos()
	local pos = 0
	local elements = FairyLandConfig.instance:getElements()

	for i = #elements, 1, -1 do
		local config = elements[i]
		local elementType = FairyLandEnum.ConfigType2ElementType[config.type]

		if elementType ~= FairyLandEnum.ElementType.NPC and self:isFinishElement(config.id) then
			pos = tonumber(config.pos)

			break
		end
	end

	return pos
end

function FairyLandModel:isFinishElement(elementId)
	return self.finishElementDict[elementId]
end

function FairyLandModel:isPassPuzzle(id)
	return self.passPuzzleDict[id]
end

function FairyLandModel:isFinishDialog(id)
	return id == 0 or self.dialogDict[id]
end

function FairyLandModel:getCurPuzzle()
	local elements = FairyLandConfig.instance:getElements()

	for i, v in ipairs(elements) do
		local elementType = FairyLandEnum.ConfigType2ElementType[v.type]

		if elementType == FairyLandEnum.ElementType.NPC then
			local puzzleIds = string.splitToNumber(v.puzzleId, "#")

			for _, npcPuzzleId in ipairs(puzzleIds) do
				local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(npcPuzzleId)

				if not self:isPuzzleAllStepFinish(puzzleConfig.id) and (puzzleConfig.beforeTalkId == 0 or self:isFinishDialog(puzzleConfig.beforeTalkId)) and self:isPuzzleAllStepFinish(npcPuzzleId - 1) then
					return puzzleConfig.id
				end
			end
		end
	end

	return 0
end

function FairyLandModel:getLatestFinishedPuzzle()
	local elements = FairyLandConfig.instance:getElements()

	for i, v in ipairs(elements) do
		local elementType = FairyLandEnum.ConfigType2ElementType[v.type]

		if elementType == FairyLandEnum.ElementType.NPC then
			local puzzleIds = string.splitToNumber(v.puzzleId, "#")

			for _, npcPuzzleId in ipairs(puzzleIds) do
				local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(npcPuzzleId)

				if self:isPuzzleAllStepFinish(puzzleConfig.id) then
					return puzzleConfig.id
				end
			end
		end
	end

	return 0
end

function FairyLandModel:isPuzzleAllStepFinish(puzzleId)
	local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(puzzleId)

	if not puzzleConfig then
		return true
	end

	local beforeFinish = self:isFinishDialog(puzzleConfig.beforeTalkId)
	local successFinish = self:isFinishDialog(puzzleConfig.successTalkId)
	local storyFinish = self:isFinishDialog(puzzleConfig.storyTalkId)
	local puzzleFinish = self:isPassPuzzle(puzzleId)

	return beforeFinish and successFinish and storyFinish and puzzleFinish
end

function FairyLandModel:getDialogElement(type)
	local container = ViewMgr.instance:getContainer(ViewName.FairyLandView)

	if container then
		return container:getElement(type)
	end
end

function FairyLandModel:isFinishFairyLand()
	local elements = FairyLandConfig.instance:getElements()

	for i = #elements, 1, -1 do
		if not self:isFinishElement(elements[i].id) then
			return false
		end
	end

	return true
end

FairyLandModel.instance = FairyLandModel.New()

return FairyLandModel
