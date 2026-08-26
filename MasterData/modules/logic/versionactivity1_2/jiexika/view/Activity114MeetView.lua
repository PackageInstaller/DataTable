-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114MeetView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetView", package.seeall)

local Activity114MeetView = class("Activity114MeetView", BaseView)

function Activity114MeetView:onInitView()
	self._itemParents = gohelper.findChild(self.viewGO, "root/items")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_right")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagehuimianpu1 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_huimianpu1")
	self._simagehuimianpu3 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_huimianpu3")
	self._simagehuimianpu4 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_huimianpu4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114MeetView:addEvents()
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Activity114MeetView:removeEvents()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function Activity114MeetView:_btnleftOnClick()
	self:updatePage(self.curPage - 1)
end

function Activity114MeetView:_btnrightOnClick()
	self:updatePage(self.curPage + 1)
end

function Activity114MeetView:_btncloseOnClick()
	self:closeThis()
end

function Activity114MeetView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getAct114MeetIcon("bg"))
	self._simagehuimianpu1:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu1"))
	self._simagehuimianpu3:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu3"))
	self._simagehuimianpu4:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu4"))

	self.meetList = {}

	for i = 1, 6 do
		local itemGo = gohelper.findChild(self._itemParents, "#go_characteritem" .. i)

		self.meetList[i] = Activity114MeetItem.New(itemGo)

		self:addChildView(self.meetList[i])
	end

	self:updatePage(1)
end

function Activity114MeetView:updatePage(page)
	self.curPage = page

	local meetList = Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)
	local len = #meetList
	local totalPage = math.ceil(len / 6)

	for i = 1, 6 do
		self.meetList[i]:updateMo(meetList[i + (self.curPage - 1) * 6])
	end

	gohelper.setActive(self._btnleft.gameObject, page > 1)
	gohelper.setActive(self._btnright.gameObject, page < totalPage)
end

function Activity114MeetView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_meeting_book_open)
end

function Activity114MeetView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_meeting_book_close)
end

function Activity114MeetView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagehuimianpu1:UnLoadImage()
	self._simagehuimianpu3:UnLoadImage()
	self._simagehuimianpu4:UnLoadImage()
end

return Activity114MeetView
