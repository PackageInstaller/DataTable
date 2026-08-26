-- chunkname: @modules/logic/weekwalk/view/WeekWalkGuideView.lua

module("modules.logic.weekwalk.view.WeekWalkGuideView", package.seeall)

local WeekWalkGuideView = class("WeekWalkGuideView", BaseView)

function WeekWalkGuideView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate1")
	self._simagedecorate3 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate3")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_look")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkGuideView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function WeekWalkGuideView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function WeekWalkGuideView:_btnlookOnClick()
	self:closeThis()
end

function WeekWalkGuideView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("yd_yindaodi_1.png"))
	self._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	self._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function WeekWalkGuideView:onUpdateParam()
	return
end

function WeekWalkGuideView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function WeekWalkGuideView:onClose()
	return
end

function WeekWalkGuideView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate3:UnLoadImage()
end

return WeekWalkGuideView
