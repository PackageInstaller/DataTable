-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/gamestep/XugoujiGameStepSetHp.lua

module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepSetHp", package.seeall)

local XugoujiGameStepSetHp = class("XugoujiGameStepSetHp", XugoujiGameStepBase)

function XugoujiGameStepSetHp:start()
	self:finish()
end

function XugoujiGameStepSetHp:finish()
	local hp = self.originData.hp

	Activity188Model.instance:setHp(hp)
	XugoujiController.instance:dispatchEvent(Va3ChessEvent.CurrentHpUpdate)
	XugoujiGameStepSetHp.super.finish(self)
end

return XugoujiGameStepSetHp
