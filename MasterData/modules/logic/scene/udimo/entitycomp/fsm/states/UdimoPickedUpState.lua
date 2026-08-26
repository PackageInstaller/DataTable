-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/states/UdimoPickedUpState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.states.UdimoPickedUpState", package.seeall)

local UdimoPickedUpState = class("UdimoPickedUpState", UdimoBaseState)

function UdimoPickedUpState:onFSMStart()
	self:_clearData()
end

function UdimoPickedUpState:_clearData()
	self.param = nil
end

function UdimoPickedUpState:onEnter(param)
	self._entity = self.fsm and self.fsm:getEntity()

	if not self._entity then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_tiqi)
	self._entity:refreshOrderLayer()

	local clickPos = param and param.clickPos

	self:_setEntityPos(clickPos)

	local udimoId = self._entity:getId()
	local emojiId = UdimoConfig.instance:getStateEmoji(udimoId, self.name)

	self._entity:playEmoji(emojiId)
	UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Catch, true, true)
end

function UdimoPickedUpState:onUpdate()
	if self.param then
		self:_setEntityPos(self.param)
	end
end

function UdimoPickedUpState:_setEntityPos(screenPos)
	if not screenPos or not self._entity then
		return
	end

	self._entity:setPosition(nil, nil, nil, true)

	local worldPos = UdimoHelper.changeScreenPos2UdimoWroldPos(screenPos, self._entity)

	self._entity:setPosition(worldPos.x, worldPos.y, nil, true)
	UdimoController.instance:dispatchEvent(UdimoEvent.OnDraggingUdimo, screenPos)
end

function UdimoPickedUpState:onExit()
	self:_clearData()
	AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_songkai)
end

function UdimoPickedUpState:onFSMStop()
	self:_clearData()
end

function UdimoPickedUpState:onClear()
	self:_clearData()
end

return UdimoPickedUpState
