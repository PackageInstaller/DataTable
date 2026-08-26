-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaDialogStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDialogStep", package.seeall)

local TianShiNaNaDialogStep = class("TianShiNaNaDialogStep", TianShiNaNaStepBase)

function TianShiNaNaDialogStep:onStart(context)
	local targetEntity = TianShiNaNaEntityMgr.instance:getEntity(self._data.interactId)

	if targetEntity and targetEntity.checkActive then
		targetEntity._unitMo:setActive(true)
		targetEntity:checkActive()
	end

	if self._data.dialogueId == 0 then
		return self:onDone(true)
	end

	self:beginPlayDialog()
end

function TianShiNaNaDialogStep:beginPlayDialog()
	local co = TianShiNaNaConfig.instance:getBubbleCo(VersionActivity2_2Enum.ActivityId.TianShiNaNa, self._data.dialogueId)

	if not co then
		logError("天使娜娜对话配置不存在" .. self._data.dialogueId)
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
	ViewMgr.instance:openView(ViewName.TianShiNaNaTalkView, co)
end

function TianShiNaNaDialogStep:_onViewClose(viewName)
	if viewName == ViewName.TianShiNaNaTalkView then
		self:onDone(true)
	end
end

function TianShiNaNaDialogStep:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

return TianShiNaNaDialogStep
