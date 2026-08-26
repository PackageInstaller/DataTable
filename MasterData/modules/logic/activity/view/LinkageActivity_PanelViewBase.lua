-- chunkname: @modules/logic/activity/view/LinkageActivity_PanelViewBase.lua

module("modules.logic.activity.view.LinkageActivity_PanelViewBase", package.seeall)

local LinkageActivity_PanelViewBase = class("LinkageActivity_PanelViewBase", LinkageActivity_BaseView)

function LinkageActivity_PanelViewBase:ctor(...)
	LinkageActivity_PanelViewBase.super.ctor(self, ...)

	self._inited = false

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function LinkageActivity_PanelViewBase:onDestroyView()
	LinkageActivity_PanelViewBase.super.onDestroyView(self)

	self._inited = false
end

function LinkageActivity_PanelViewBase:onUpdateParam()
	self:_refresh()
end

function LinkageActivity_PanelViewBase:onOpen()
	self:internal_set_actId(self.viewParam.actId)

	if not self._inited then
		self:internal_onOpen()

		self._inited = true
	else
		self:_refresh()
	end
end

function LinkageActivity_PanelViewBase:addEvents()
	LinkageActivity_PanelViewBase.super.addEvents(self)
end

function LinkageActivity_PanelViewBase:removeEvents()
	LinkageActivity_PanelViewBase.super.removeEvents(self)
end

return LinkageActivity_PanelViewBase
