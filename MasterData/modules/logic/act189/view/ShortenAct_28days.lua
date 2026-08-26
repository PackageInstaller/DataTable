-- chunkname: @modules/logic/act189/view/ShortenAct_28days.lua

module("modules.logic.act189.view.ShortenAct_28days", package.seeall)

local ShortenAct_28days = class("ShortenAct_28days", ShortenActStyleItem_impl)

function ShortenAct_28days:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "2/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShortenAct_28days:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ShortenAct_28days:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ShortenAct_28days:ctor(...)
	ShortenAct_28days.super.ctor(self, ...)
end

function ShortenAct_28days:_editableInitView()
	ShortenAct_28days.super._editableInitView(self)
end

function ShortenAct_28days:onDestroyView()
	ShortenAct_28days.super.onDestroyView(self)
end

function ShortenAct_28days:_btnclickOnClick()
	BpController.instance:openBattlePassView()
end

return ShortenAct_28days
