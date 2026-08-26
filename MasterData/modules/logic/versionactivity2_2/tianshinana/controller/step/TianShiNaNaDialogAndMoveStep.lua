-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaDialogAndMoveStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDialogAndMoveStep", package.seeall)

local TianShiNaNaDialogAndMoveStep = class("TianShiNaNaDialogAndMoveStep", TianShiNaNaDialogStep)

function TianShiNaNaDialogAndMoveStep:onStart(context)
	if self._data.isMonsterMove == 1 then
		return self:beginPlayDialog()
	end

	local playerMo = TianShiNaNaModel.instance:getHeroMo()

	if not playerMo then
		logError("对话时，角色不存在")

		return self:onDone(true)
	end

	local playerEntity = TianShiNaNaEntityMgr.instance:getEntity(playerMo.co.id)

	self._targetEntity = TianShiNaNaEntityMgr.instance:getEntity(self._data.interactId)

	if not playerEntity then
		logError("对话时，角色不存在")

		return self:onDone(true)
	end

	if not self._targetEntity then
		logError("对话时，目标不存在")

		return self:onDone(true)
	end

	return playerEntity:moveToHalf(self._targetEntity._unitMo.x, self._targetEntity._unitMo.y, self._onEndMove, self)
end

function TianShiNaNaDialogAndMoveStep:_onEndMove()
	local playerMo = TianShiNaNaModel.instance:getHeroMo()

	self._targetEntity:changeDir(playerMo.x, playerMo.y)
	self:beginPlayDialog()
end

return TianShiNaNaDialogAndMoveStep
