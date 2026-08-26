-- chunkname: @modules/logic/notice/view/NoticeView.lua

module("modules.logic.notice.view.NoticeView", package.seeall)

local NoticeView = class("NoticeView", BaseView)

function NoticeView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btncloseBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#simage_bg/top/#btn_closeBtn")
	self._scrollnotice = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_notice")
	self._gonormal = gohelper.findChild(self.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_normal")
	self._goselect = gohelper.findChild(self.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_select")
	self._goredtip = gohelper.findChild(self.viewGO, "left/#scroll_notice/Viewport/Content/noticeItem/#go_redtip")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_content")
	self._gotoptitle = gohelper.findChild(self.viewGO, "right/#scroll_content/Viewport/Content/#go_toptitle")
	self._txttitle = gohelper.findChildText(self.viewGO, "right/#scroll_content/Viewport/Content/#go_toptitle/#txt_title")
	self._simagecontent = gohelper.findChildSingleImage(self.viewGO, "right/#scroll_content/Viewport/Content/#simage_content")
	self._txtcontentTitle = gohelper.findChildText(self.viewGO, "right/#scroll_content/Viewport/Content/contentTitle/#txt_contentTitle")
	self._txtcontent = gohelper.findChildText(self.viewGO, "right/#scroll_content/Viewport/Content/#txt_content")
	self._simagenotice = gohelper.findChildSingleImage(self.viewGO, "right/#simage_notice")
	self._gocontentMask = gohelper.findChild(self.viewGO, "right/#scroll_content/#go_contentMask")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NoticeView:addEvents()
	self._btncloseBtn:AddClickListener(self._btncloseBtnOnClick, self)
	self._btncloseview:AddClickListener(self._btncloseBtnOnClick, self)
	self._scrollcontent:AddOnValueChanged(self._onContentScrollValueChanged, self)
end

function NoticeView:removeEvents()
	self._btncloseBtn:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
	self._scrollcontent:RemoveOnValueChanged()
end

function NoticeView:_btncloseBtnOnClick()
	self:closeThis()
end

function NoticeView:createToggleItem(goToggle, type)
	local toggleItem = self:getUserDataTb_()

	toggleItem.type = type
	toggleItem.goToggle = goToggle
	toggleItem.click = gohelper.getClick(goToggle)
	toggleItem.selectLabel = gohelper.findChild(goToggle, "selectLabel")
	toggleItem.unselectLabel = gohelper.findChild(goToggle, "unselectLabel")
	toggleItem.goReddot = gohelper.findChild(goToggle, "unselectLabel/reddot")

	toggleItem.click:AddClickListener(self._toggleBeSelect, self)
	toggleItem.click:AddClickDownListener(self._toggleBeClickDown, self, toggleItem)
	toggleItem.click:AddClickUpListener(self._toggleBeClickUp, self, toggleItem)
	gohelper.addUIClickAudio(goToggle, AudioEnum.UI.play_ui_feedback_open)
	table.insert(self.toggleItemList, toggleItem)

	return toggleItem
end

function NoticeView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getNoticeBg("bg_announcement"))

	self._goContent = gohelper.findChild(self._scrollcontent.gameObject, "Viewport/Content")
	self.toggleItemList = {}
	self.goToggle1 = gohelper.findChild(self.viewGO, "right/#toggleGroup/Toggle1")
	self.goToggle2 = gohelper.findChild(self.viewGO, "right/#toggleGroup/Toggle2")
	self.goToggle3 = gohelper.findChild(self.viewGO, "right/#toggleGroup/Toggle3")
	self.goToggle4 = gohelper.findChild(self.viewGO, "right/#toggleGroup/Toggle4")

	self:createToggleItem(self.goToggle1, NoticeType.Activity)
	self:createToggleItem(self.goToggle2, NoticeType.Game)
	self:createToggleItem(self.goToggle3, NoticeType.System)
	self:createToggleItem(self.goToggle4, NoticeType.Information)

	self._scrollContentHeight = recthelper.getHeight(self._goContent.transform)
end

function NoticeView:onDestroy()
	return
end

function NoticeView:onUpdateParam()
	return
end

function NoticeView:onOpen()
	NoticeModel.instance:onOpenNoticeView()
	self:_addEvent()
	self:updateUI()
	NavigateMgr.instance:addEscape(ViewName.NoticeView, self._btncloseBtnOnClick, self)
end

function NoticeView:_addEvent()
	NoticeController.instance:registerCallback(NoticeEvent.OnSelectNoticeItem, self._onSelectNoticeItem, self)
	self.addEventCb(self, NoticeController.instance, NoticeEvent.OnGetNoticeInfo, self.updateUI, self)
	self.addEventCb(self, NoticeController.instance, NoticeEvent.OnRefreshRedDot, self.refreshRedDot, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.EnterScene, self._enterScene, self)
end

function NoticeView:_enterScene(sceneType, sceneId)
	self:closeThis()
end

function NoticeView:onClose()
	self:_removeEvent()
	NoticeModel.instance:onCloseNoticeView()
end

function NoticeView:_removeEvent()
	NoticeController.instance:unregisterCallback(NoticeEvent.OnSelectNoticeItem, self._onSelectNoticeItem, self)
end

function NoticeView:updateUI()
	local firstType = self.viewContainer:getFirstShowNoticeType()

	NoticeModel.instance:switchNoticeType(firstType)

	for _, toggleItem in ipairs(self.toggleItemList) do
		gohelper.setActive(toggleItem.goToggle, #NoticeModel.instance:getNoticesByType(toggleItem.type) > 0)
	end

	self:refreshRedDot()
	self.viewContainer:selectFirstNotice()
	self:_toggleBeSelect()
end

function NoticeView:refreshRedDot()
	for _, toggleItem in ipairs(self.toggleItemList) do
		gohelper.setActive(toggleItem.goReddot, not NoticeModel.instance:getNoticeTypeIsRead(toggleItem.type))
	end
end

function NoticeView:_onSelectNoticeItem(noticeMO)
	NoticeContentListModel.instance:setNoticeMO(noticeMO)

	self._scrollcontent.verticalNormalizedPosition = 1

	self:_refreshScrollContent()
end

function NoticeView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, toggleItem in ipairs(self.toggleItemList) do
		toggleItem.click:RemoveClickListener()
		toggleItem.click:RemoveClickDownListener()
		toggleItem.click:RemoveClickUpListener()
	end

	self.toggleItemList = nil
end

function NoticeView:_toggleBeSelect()
	local type = NoticeModel.instance:getSelectType()

	for _, toggleItem in ipairs(self.toggleItemList) do
		gohelper.setActive(toggleItem.selectLabel, type == toggleItem.type)
		gohelper.setActive(toggleItem.unselectLabel, type ~= toggleItem.type)
	end
end

function NoticeView:_toggleBeClickDown(toggleItem)
	UIColorHelper.setGameObjectPressState(self, toggleItem.goToggle, true)
end

function NoticeView:_toggleBeClickUp(toggleItem)
	UIColorHelper.setGameObjectPressState(self, toggleItem.goToggle, false)
end

function NoticeView:_refreshScrollContent()
	ZProj.UGUIHelper.RebuildLayout(self._goContent.transform)

	local contentHeight = recthelper.getHeight(self._goContent.transform)

	self._couldScroll = contentHeight > self._scrollContentHeight

	gohelper.setActive(self._gocontentMask, self._couldScroll)
end

function NoticeView:_onContentScrollValueChanged(value)
	gohelper.setActive(self._gocontentMask, self._couldScroll and gohelper.getRemindFourNumberFloat(self._scrollcontent.verticalNormalizedPosition) > 0)
end

return NoticeView
