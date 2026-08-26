-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepBuffUpdate.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepBuffUpdate", package.seeall)

local XugoujiGameStepBuffUpdate = class("XugoujiGameStepBuffUpdate", XugoujiGameStepBase)

function XugoujiGameStepBuffUpdate:start()
	local isSelf = self._stepData.isSelf
	local buffsInfo = self._stepData.buffs

	Activity188Model.instance:setBuffs(buffsInfo, isSelf)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.BuffUpdated, isSelf)
	self:finish()
end

function XugoujiGameStepBuffUpdate:finish()
	XugoujiGameStepBuffUpdate.super.finish(self)
end

return XugoujiGameStepBuffUpdate
