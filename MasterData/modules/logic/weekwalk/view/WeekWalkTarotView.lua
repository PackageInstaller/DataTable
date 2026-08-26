-- chunkname: @modules/logic/weekwalk/view/WeekWalkTarotView.lua

module("modules.logic.weekwalk.view.WeekWalkTarotView", package.seeall)

local WeekWalkTarotView = class("WeekWalkTarotView", BaseView)

function WeekWalkTarotView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrolltarot = gohelper.findChildScrollRect(self.viewGO, "#scroll_tarot")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkTarotView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function WeekWalkTarotView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function WeekWalkTarotView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalkTarotView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_beibao00.png"))
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function WeekWalkTarotView:onUpdateParam()
	return
end

function WeekWalkTarotView:onOpen()
	return
end

function WeekWalkTarotView:onClose()
	return
end

function WeekWalkTarotView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return WeekWalkTarotView
