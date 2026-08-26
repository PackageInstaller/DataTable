-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUpDayItem1.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUpDayItem1", package.seeall)

local V3a6_WarmUpDayItem1 = class("V3a6_WarmUpDayItem1", V3a6_WarmUpDayItemBase)

function V3a6_WarmUpDayItem1:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txttag1 = gohelper.findChildText(self.viewGO, "#txt_tag1")
	self._txttag2 = gohelper.findChildText(self.viewGO, "#txt_tag2")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6_WarmUpDayItem1:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function V3a6_WarmUpDayItem1:removeEvents()
	self._btnClick:RemoveClickListener()
end

function V3a6_WarmUpDayItem1:ctor(...)
	V3a6_WarmUpDayItem1.super.ctor(self, ...)
end

function V3a6_WarmUpDayItem1:_editableInitView()
	V3a6_WarmUpDayItem1.super._editableInitView(self)
end

function V3a6_WarmUpDayItem1:onDestroyView()
	V3a6_WarmUpDayItem1.super.onDestroyView(self)
end

function V3a6_WarmUpDayItem1:setData(mo)
	V3a6_WarmUpDayItem1.super.setData(self, mo)
end

return V3a6_WarmUpDayItem1
