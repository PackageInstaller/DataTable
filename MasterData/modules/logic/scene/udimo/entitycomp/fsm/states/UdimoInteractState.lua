-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/states/UdimoInteractState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.states.UdimoInteractState", package.seeall)

local UdimoInteractState = class("UdimoInteractState", UdimoBaseState)

function UdimoInteractState:onFSMStart()
	self:_clearData()
end

function UdimoInteractState:_clearData()
	self.param = nil
end

function UdimoInteractState:onEnter(param)
	self._entity = self.fsm:getEntity()

	if self._entity then
		self._entity:checkAndAdjustPos()
		self._entity:refreshOrderLayer()

		local udimoId = self._entity:getId()

		UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Idle, true, true)
	end

	UdimoController.instance:playNextFriendInteractEmoji(param and param.friendId)
end

function UdimoInteractState:onUpdate()
	if self.param then
		if not self.param or not self._entity then
			return
		end

		self.param.emojiId = nil

		self._entity:playEmoji(self.param, self._playEmojiFinish, self)
	end
end

function UdimoInteractState:_playEmojiFinish()
	if self.param then
		UdimoController.instance:playNextFriendInteractEmoji(self.param)
	end
end

function UdimoInteractState:onExit()
	self:_clearData()
end

function UdimoInteractState:onFSMStop()
	self:_clearData()
end

function UdimoInteractState:onClear()
	self:_clearData()
end

return UdimoInteractState
