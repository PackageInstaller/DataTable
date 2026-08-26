-- chunkname: @modules/logic/versionactivity3_0/karong/flow/KaRongDialogStep.lua

module("modules.logic.versionactivity3_0.karong.flow.KaRongDialogStep", package.seeall)

local KaRongDialogStep = class("KaRongDialogStep", BaseWork)

function KaRongDialogStep:ctor(data)
	self._data = data
	self._dialogueId = tonumber(data.param)
end

function KaRongDialogStep:onStart(context)
	if self._data.param == 0 then
		return self:onDone(true)
	end

	self:beginPlayDialog()
end

function KaRongDialogStep:beginPlayDialog()
	local co = Activity176Config.instance:getBubbleCo(VersionActivity3_0Enum.ActivityId.KaRong, self._dialogueId)

	if not co then
		logError("纸信圈儿对话配置不存在" .. self._dialogueId)
		self:onDone(true)

		return
	end

	KaRongDrawController.instance:registerCallback(KaRongDrawEvent.OnFinishDialog, self._onFinishDialog, self)

	local dialogPosX, dialogPosY = self:_getDialogPos()
	local params = {
		co = co,
		dialogPosX = dialogPosX,
		dialogPosY = dialogPosY
	}

	KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.OnStartDialog, params)
end

function KaRongDialogStep:_getDialogPos()
	local pawnPosX, pawnPosY = KaRongDrawController.instance:getLastPos()
	local pawnAnchorX, pawnAnchorY = KaRongDrawModel.instance:getObjectAnchor(pawnPosX, pawnPosY)

	return pawnAnchorX, pawnAnchorY + 100
end

function KaRongDialogStep:_onFinishDialog()
	KaRongDrawController.instance:unregisterAllCallback(KaRongDrawEvent.OnFinishDialog, self._onFinishDialog, self)
	self:onDone(true)
end

function KaRongDialogStep:clearWork()
	KaRongDrawController.instance:unregisterCallback(KaRongDrawEvent.OnFinishDialog, self._onFinishDialog, self)
end

return KaRongDialogStep
