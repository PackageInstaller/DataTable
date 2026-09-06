-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/model/TreasureNewModel.lua

module("logic.extensions.treasurenew.model.TreasureNewModel", package.seeall)

local TreasureNewModel = class("TreasureNewModel", BaseModel)

function TreasureNewModel:ctor()
	return
end

function TreasureNewModel:onInit()
	self:onReset()
end

function TreasureNewModel:onReset()
	self._state = 0
	self._mapType = 1
	self._targetId = 0
	self._turnTableId = 0
	self._matchIndex = nil
end

function TreasureNewModel:updateAfterGetInfo(msg)
	if msg == nil or table.nums(msg) == 0 then
		printError("Get Empty Msg")

		return
	end

	self:onReset()

	self._state = msg.state
	self._mapType = checkint(msg.info.treasureType)
	self._targetId = checkint(msg.info.targetId)
	self._turnTableId = checkint(msg.info.turntableId)
end

function TreasureNewModel:updateFinishDig(msg)
	if msg == nil or table.nums(msg) == 0 then
		printError("Get Empty Msg")

		return
	end

	self._state = 2
end

function TreasureNewModel:updatePrize(msg)
	if msg == nil or table.nums(msg) == 0 then
		printError("Get Empty Msg")

		return
	end

	self:onReset()

	self._state = 0
	self._matchIndex = checkint(msg.index)
end

function TreasureNewModel:updateUseMapRes(msg)
	if msg == nil or table.nums(msg) == 0 then
		printError("Get Empty Msg")

		return
	end

	self:onReset()

	self._state = 1
	self._mapType = checkint(msg.info.treasureType)
	self._targetId = checkint(msg.info.targetId)
	self._turnTableId = checkint(msg.info.turntableId)
end

function TreasureNewModel:getState()
	return self._state
end

function TreasureNewModel:getTargetCfg()
	return TreasureNewConfig.instance:getTargetCfgById(self._targetId)
end

function TreasureNewModel:getCurTurnTableCfgs()
	return TreasureNewConfig.instance:getTurnTableCfgsById(self._turnTableId)
end

function TreasureNewModel:getMatchIndex()
	return self._matchIndex
end

function TreasureNewModel:getTurnTableId()
	return self._turnTableId
end

TreasureNewModel.instance = TreasureNewModel.New()

return TreasureNewModel
