-- chunkname: @modules/logic/jump/model/JumpModel.lua

module("modules.logic.jump.model.JumpModel", package.seeall)

local JumpModel = class("JumpModel", BaseModel)

function JumpModel:onInit()
	self:reInit()
end

function JumpModel:reInit()
	self._recordFarmItem = nil
	self.jumpFromFightScene = nil
	self.jumpFromFightSceneParam = nil
end

function JumpModel:setRecordFarmItem(recordFarmItem)
	self._recordFarmItem = recordFarmItem
end

function JumpModel:getRecordFarmItem()
	return self._recordFarmItem
end

function JumpModel:clearRecordFarmItem()
	self._recordFarmItem = nil
end

JumpModel.instance = JumpModel.New()

return JumpModel
