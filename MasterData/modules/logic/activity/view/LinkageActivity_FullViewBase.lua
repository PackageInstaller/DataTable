-- chunkname: @modules/logic/activity/view/LinkageActivity_FullViewBase.lua

module("modules.logic.activity.view.LinkageActivity_FullViewBase", package.seeall)

local LinkageActivity_FullViewBase = class("LinkageActivity_FullViewBase", LinkageActivity_BaseView)

function LinkageActivity_FullViewBase:ctor(...)
	LinkageActivity_FullViewBase.super.ctor(self, ...)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)

	self._inited = false
end

function LinkageActivity_FullViewBase:onDestroyView()
	self._inited = false

	LinkageActivity_FullViewBase.super.onDestroyView(self)
end

function LinkageActivity_FullViewBase:onUpdateParam()
	self:_refresh()
end

function LinkageActivity_FullViewBase:onOpen()
	if not self._inited then
		self:internal_onOpen()

		self._inited = true
	else
		self:_refresh()
	end
end

function LinkageActivity_FullViewBase:addEvents()
	LinkageActivity_FullViewBase.super.addEvents(self)
end

function LinkageActivity_FullViewBase:removeEvents()
	LinkageActivity_FullViewBase.super.removeEvents(self)
end

return LinkageActivity_FullViewBase
