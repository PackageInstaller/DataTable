-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStorySuccessView.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStorySuccessView", package.seeall)

local V3A1_RoleStorySuccessView = class("V3A1_RoleStorySuccessView", BaseView)

function V3A1_RoleStorySuccessView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A1_RoleStorySuccessView:addEvents()
	return
end

function V3A1_RoleStorySuccessView:removeEvents()
	return
end

function V3A1_RoleStorySuccessView:_editableInitView()
	return
end

function V3A1_RoleStorySuccessView:onClickModalMask()
	if not self.animFinish then
		return
	end

	self:closeThis()
end

function V3A1_RoleStorySuccessView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_tangren_win1)

	self.animFinish = false

	TaskDispatcher.runDelay(self._onAnimFinish, self, 1.5)
end

function V3A1_RoleStorySuccessView:_onAnimFinish()
	self.animFinish = true
end

function V3A1_RoleStorySuccessView:onDestroyView()
	TaskDispatcher.cancelTask(self._onAnimFinish, self)
end

return V3A1_RoleStorySuccessView
