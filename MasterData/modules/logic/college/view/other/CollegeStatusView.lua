-- chunkname: @modules/logic/college/view/other/CollegeStatusView.lua

module("modules.logic.college.view.other.CollegeStatusView", package.seeall)

local CollegeStatusView = class("CollegeStatusView", BaseView)
local MaxScrollHeight = 400
local OffsetY = 100

function CollegeStatusView:onInitView()
	self._goBuffContainer = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buffinfocontainer/#btn_click")
	self._goScrollBuff = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/#scroll_buff")
	self._goBuffContent = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/#scroll_buff/viewport/content/#go_BuffContent")
	self._goBuffItem = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/#scroll_buff/viewport/content/#go_BuffContent/#go_buffitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeStatusView:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateState, self.refreshUI, self)
end

function CollegeStatusView:removeEvents()
	self._btnClick:RemoveClickListener()
end

function CollegeStatusView:_btnClickOnClick()
	self:closeThis()
end

function CollegeStatusView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)

	self._tranContent = self._goBuffContent.transform
	self._tranScroll = self._goScrollBuff.transform
	self._tranBuffContainer = self._goBuffContainer.transform
	self._canvasgroup = gohelper.onceAddComponent(self._goBuffContainer, gohelper.Type_CanvasGroup)
	self._canvasgroup.alpha = 0
end

function CollegeStatusView:onOpen()
	self._baseScreenPos = self.viewParam and self.viewParam.baseScreenPos
	self._statusBox = CollegeModel.instance:getSceneMo().player.statusBox

	self:refreshUI()
	TaskDispatcher.runDelay(self.updatePosition, self, 0.01)
end

function CollegeStatusView:refreshUI()
	local statuses = self._statusBox.statuses

	if statuses then
		self._statusesNum = #statuses or 0
	end

	local hasStatus = self._statusesNum > 0

	gohelper.setActive(self._goScrollBuff, hasStatus)

	if not hasStatus then
		return
	end

	gohelper.CreateObjList(self, self._refreshStatusItem, statuses, self._goBuffContent, self._goBuffItem)
	ZProj.UGUIHelper.RebuildLayout(self._tranContent)
end

function CollegeStatusView:_refreshStatusItem(goBuff, statusMo, index)
	local imageIcon = gohelper.findChildImage(goBuff, "title/simage_icon")
	local txtName = gohelper.findChildText(goBuff, "title/txt_name")
	local txtTime = gohelper.findChildText(goBuff, "title/txt_time")
	local txtDesc = gohelper.findChildText(goBuff, "txt_desc")
	local goLine = gohelper.findChild(goBuff, "txt_desc/image_line")

	txtName.text = statusMo.co.name
	txtDesc.text = statusMo.co.desc
	txtTime.text = statusMo:getRoundStr()

	UISpriteSetMgr.instance:setBuffSprite(imageIcon, statusMo.co.icon, true)
	gohelper.setActive(goLine, index < self._statusesNum)
end

function CollegeStatusView:updatePosition()
	local contentHeight = recthelper.getHeight(self._tranContent)
	local scrollHeight = math.min(contentHeight, MaxScrollHeight)

	recthelper.setHeight(self._tranScroll, scrollHeight)
	ZProj.UGUIHelper.RebuildLayout(self._tranContent)

	local uiPosX, uiPosY = recthelper.screenPosToAnchorPos2(self._baseScreenPos, self._tranBuffContainer)

	recthelper.setAnchor(self._tranScroll, uiPosX, uiPosY + scrollHeight / 2 + OffsetY)

	self._canvasgroup.alpha = 1
end

function CollegeStatusView:onClose()
	TaskDispatcher.cancelTask(self.updatePosition, self)
end

return CollegeStatusView
