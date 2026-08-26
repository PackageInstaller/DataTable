-- chunkname: @modules/logic/act189/view/ShortenAct_35days.lua

module("modules.logic.act189.view.ShortenAct_35days", package.seeall)

local ShortenAct_35days = class("ShortenAct_35days", ShortenActStyleItem_impl)

function ShortenAct_35days:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShortenAct_35days:addEvents()
	return
end

function ShortenAct_35days:removeEvents()
	return
end

function ShortenAct_35days:ctor(...)
	ShortenAct_35days.super.ctor(self, ...)
end

function ShortenAct_35days:_editableInitView()
	ShortenAct_35days.super._editableInitView(self)
end

function ShortenAct_35days:onDestroyView()
	ShortenAct_35days.super.onDestroyView(self)
end

return ShortenAct_35days
