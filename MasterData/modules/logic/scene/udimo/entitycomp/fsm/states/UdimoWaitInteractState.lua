-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/states/UdimoWaitInteractState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.states.UdimoWaitInteractState", package.seeall)

local UdimoWaitInteractState = class("UdimoWaitInteractState", UdimoBaseState)

function UdimoWaitInteractState:onFSMStart()
	self:_clearData()

	self._interactWaitTime = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.InteractWaitTime, true) or 0
end

function UdimoWaitInteractState:_clearData()
	self._enterTime = nil
end

function UdimoWaitInteractState:onEnter(param)
	self._entity = self.fsm:getEntity()

	if not self._entity then
		return
	end

	self._entity:refreshOrderLayer()
	self._entity:checkAndAdjustPos()

	local udimoId = self._entity:getId()
	local useBg = UdimoItemModel.instance:getUseBg()
	local interactId = UdimoModel.instance:getUdimoInteractId(udimoId)
	local emojiId = UdimoConfig.instance:getInteractEmoji(useBg, interactId)

	self._entity:playEmoji(emojiId)
	UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Idle, true, true)

	self._enterTime = Time.realtimeSinceStartup
end

function UdimoWaitInteractState:onUpdate()
	local elapseTime

	if self._enterTime then
		elapseTime = Time.realtimeSinceStartup - self._enterTime
	end

	if not elapseTime or elapseTime >= self._interactWaitTime then
		if self._entity then
			local udimoId = self._entity:getId()

			if udimoId then
				UdimoController.instance:udimoWaitInteractOverTime(udimoId)
			end
		end
	end
end

function UdimoWaitInteractState:onExit()
	self:_clearData()
end

function UdimoWaitInteractState:onFSMStop()
	self:_clearData()
end

function UdimoWaitInteractState:onClear()
	self:_clearData()
end

return UdimoWaitInteractState
