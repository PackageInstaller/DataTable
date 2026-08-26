-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TravelView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelView", package.seeall)

local Activity114TravelView = class("Activity114TravelView", BaseView)

function Activity114TravelView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "#simage_maskbg")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._simagebg3 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg3")
	self._simagebg5 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg5")
	self._simageqianbi = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_qianbi")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114TravelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Activity114TravelView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity114TravelView:_btncloseOnClick()
	self:closeThis()
end

function Activity114TravelView:_editableInitView()
	self._simagemaskbg:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_beijing"))
	self._simagebg1:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang1"))
	self._simagebg2:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang2"))
	self._simagebg3:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang3"))
	self._simagebg5:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang5"))
	self._simageqianbi:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_qianbi"))

	self.entrances = {}

	for i = 1, 6 do
		self.entrances[i] = Activity114TravelItem.New(gohelper.findChild(self.viewGO, "entrances/entrance" .. i), i)
	end
end

function Activity114TravelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
end

function Activity114TravelView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_delete)
end

function Activity114TravelView:onDestroyView()
	self._simagemaskbg:UnLoadImage()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simagebg3:UnLoadImage()
	self._simagebg5:UnLoadImage()
	self._simageqianbi:UnLoadImage()

	for i = 1, 6 do
		self.entrances[i]:onDestroy()
	end
end

return Activity114TravelView
