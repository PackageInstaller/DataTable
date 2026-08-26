-- chunkname: @modules/logic/necrologiststory/model/NecrologistV3A3MO.lua

module("modules.logic.necrologiststory.model.NecrologistV3A3MO", package.seeall)

local NecrologistV3A3MO = class("NecrologistV3A3MO", NecrologistStoryGameBaseMO)

function NecrologistV3A3MO:onInit()
	return
end

function NecrologistV3A3MO:onUpdateData()
	local data = self:getData()

	self.fireStage = data.fireStage or 1
	self.letterOpened = data.letterOpened or false
end

function NecrologistV3A3MO:onSaveData()
	local data = self:getData()

	if self.fireStage then
		data.fireStage = self.fireStage
	end

	if self.letterOpened then
		data.letterOpened = self.letterOpened
	end
end

function NecrologistV3A3MO:getFireStage()
	return self.fireStage
end

function NecrologistV3A3MO:setFireStage(fireStage)
	self.fireStage = fireStage

	self:setDataDirty()
end

function NecrologistV3A3MO:getLetterOpened()
	return self.letterOpened
end

function NecrologistV3A3MO:setLetterOpened(letterOpened)
	self.letterOpened = letterOpened

	self:setDataDirty()
end

return NecrologistV3A3MO
