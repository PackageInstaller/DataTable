-- chunkname: @modules/logic/necrologiststory/game/v3a7/V3A7_RoleStoryEmailView.lua

module("modules.logic.necrologiststory.game.v3a7.V3A7_RoleStoryEmailView", package.seeall)

local V3A7_RoleStoryEmailView = class("V3A7_RoleStoryEmailView", BaseView)

function V3A7_RoleStoryEmailView:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A7_RoleStoryEmailView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3A7_RoleStoryEmailView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3A7_RoleStoryEmailView:_btnclickOnClick()
	if not self.tagId then
		return
	end

	self:closeThis()
	ViewMgr.instance:openView(ViewName.NecrologistStoryTipView, {
		tagId = self.tagId
	})
end

function V3A7_RoleStoryEmailView:_editableInitView()
	return
end

function V3A7_RoleStoryEmailView:onUpdateParam()
	return
end

function V3A7_RoleStoryEmailView:onOpen()
	self.tagId = self.viewParam.tagId

	TaskDispatcher.runDelay(self._btnclickOnClick, self, 0.5)
end

function V3A7_RoleStoryEmailView:onClose()
	TaskDispatcher.cancelTask(self._btnclickOnClick, self)
end

function V3A7_RoleStoryEmailView:onDestroyView()
	return
end

return V3A7_RoleStoryEmailView
