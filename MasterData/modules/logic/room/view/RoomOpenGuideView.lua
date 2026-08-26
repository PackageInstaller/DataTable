-- chunkname: @modules/logic/room/view/RoomOpenGuideView.lua

module("modules.logic.room.view.RoomOpenGuideView", package.seeall)

local RoomOpenGuideView = class("RoomOpenGuideView", BaseView)

function RoomOpenGuideView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_look")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate1")
	self._simagedecorate3 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomOpenGuideView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function RoomOpenGuideView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function RoomOpenGuideView:_btnlookOnClick()
	self:closeThis()
end

function RoomOpenGuideView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	self._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	self._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function RoomOpenGuideView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function RoomOpenGuideView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate3:UnLoadImage()
end

return RoomOpenGuideView
