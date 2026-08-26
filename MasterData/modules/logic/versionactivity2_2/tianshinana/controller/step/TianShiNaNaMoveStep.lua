-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaMoveStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaMoveStep", package.seeall)

local TianShiNaNaMoveStep = class("TianShiNaNaMoveStep", TianShiNaNaStepBase)

function TianShiNaNaMoveStep:onStart()
	local entity = TianShiNaNaEntityMgr.instance:getEntity(self._data.id)

	if not entity then
		logError("步骤Move 找不到元件ID" .. self._data.id)
		self:onDone(true)

		return
	end

	self._isPlayer = TianShiNaNaModel.instance:getHeroMo().co.id == self._data.id

	if self._isPlayer then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_foot)
	end

	entity:moveTo(self._data.x, self._data.y, self._data.direction, self._onMoveEnd, self)
end

function TianShiNaNaMoveStep:_onMoveEnd()
	if self._isPlayer then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.stop_ui_youyu_foot)
		TianShiNaNaEffectPool.instance:getFromPool(self._data.x, self._data.y, 1, 0, 0.4)
	end

	self:onDone(true)
end

return TianShiNaNaMoveStep
