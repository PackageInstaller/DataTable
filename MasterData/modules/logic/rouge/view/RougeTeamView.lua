-- chunkname: @modules/logic/rouge/view/RougeTeamView.lua

module("modules.logic.rouge.view.RougeTeamView", package.seeall)

local RougeTeamView = class("RougeTeamView", BaseView)

function RougeTeamView:onInitView()
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_view")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._goevent = gohelper.findChild(self.viewGO, "#go_event")
	self._gogreen = gohelper.findChild(self.viewGO, "#go_event/#go_green")
	self._goblue = gohelper.findChild(self.viewGO, "#go_event/#go_blue")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_event/#go_topright")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_event/#go_topright/#txt_num")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_event/#btn_confirm")
	self._gounenough = gohelper.findChild(self.viewGO, "#go_event/#go_unenough")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTeamView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function RougeTeamView:removeEvents()
	self._btnconfirm:RemoveClickListener()
end

function RougeTeamView:_btnconfirmOnClick()
	if self._selctedNum == 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RougeTeamSelectedHeroConfirm, MsgBoxEnum.BoxType.Yes_No, self._onConfirm, nil, nil, self)

		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeTeamViewConfirm")
	gohelper.setActive(self._btnconfirm, false)
	RougeController.instance:dispatchEvent(RougeEvent.OnTeamViewSelectedHeroPlayEffect, self._teamType)
	TaskDispatcher.runDelay(self._onConfirm, self, (self._teamType == RougeEnum.TeamType.Assignment or nil) and 0.6)
end

function RougeTeamView:_onConfirm()
	local result = RougeTeamListModel.instance:getSelectedHeroList()

	if self._callback then
		self._callback(self._callbackTarget, result)
	end

	self:closeThis()
end

function RougeTeamView:_editableInitView()
	self.addEventCb(self, RougeController.instance, RougeEvent.OnTeamViewSelectedHero, self._onTeamViewSelectedHero, self)
end

function RougeTeamView:_onTeamViewSelectedHero()
	self:_updateSelected()
end

function RougeTeamView:onOpen()
	RougeTeamListModel.addAssistHook()

	self._heroNum = self.viewParam.heroNum or 1
	self._teamType = self.viewParam.teamType
	self._callback = self.viewParam.callback
	self._callbackTarget = self.viewParam.callbackTarget
	self._selctedNum = 0

	gohelper.setActive(self._golefttop, self._teamType == RougeEnum.TeamType.View)
	RougeTeamListModel.instance:initList(self._teamType, self._heroNum)
	self:_initTitle()
	self:_initEvent()
	self:_updateSelected()
	self:setContentAnchor()
end

function RougeTeamView:_initTitle()
	if self._teamType == RougeEnum.TeamType.View then
		self._txtTitle.text = formatLuaLang("p_rougeteamview_txt_title")
	elseif self._teamType == RougeEnum.TeamType.Treat then
		self._txtTitle.text = formatLuaLang("rouge_teamview_treat_title", self._heroNum)
	elseif self._teamType == RougeEnum.TeamType.Revive then
		self._txtTitle.text = formatLuaLang("rouge_teamview_revive_title", self._heroNum)
	elseif self._teamType == RougeEnum.TeamType.Assignment then
		self._txtTitle.text = formatLuaLang("rouge_teamview_assignment_title", self._heroNum)
	end
end

function RougeTeamView:_initEvent()
	if self._teamType == RougeEnum.TeamType.View then
		return
	end

	gohelper.setActive(self._goevent, true)
	gohelper.setActive(self._gotopright, true)

	if self._teamType == RougeEnum.TeamType.Assignment then
		gohelper.setActive(self._goblue, true)
	else
		gohelper.setActive(self._gogreen, true)
	end
end

function RougeTeamView:_updateSelected()
	if self._teamType == RougeEnum.TeamType.View then
		return
	end

	self._selctedNum = tabletool.len(RougeTeamListModel.instance:getSelectedHeroMap())

	local colorNum = string.format("<#C66030>%s</COLOR>", self._selctedNum)

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_teamview_selected_num"), {
		colorNum,
		self._heroNum
	})

	if self._teamType == RougeEnum.TeamType.Assignment then
		local isEnough = self._selctedNum >= self._heroNum

		gohelper.setActive(self._btnconfirm, isEnough)
		gohelper.setActive(self._gounenough, not isEnough)
	else
		gohelper.setActive(self._btnconfirm, true)
	end
end

function RougeTeamView:setContentAnchor()
	local rectContent = gohelper.findChildComponent(self.viewGO, "#go_rolecontainer/#scroll_view/Viewport/Content", gohelper.Type_RectTransform)

	recthelper.setAnchorX(rectContent, 18)
end

function RougeTeamView:onClose()
	RougeTeamListModel.removeAssistHook()
	TaskDispatcher.cancelTask(self._onConfirm, self)
	UIBlockMgr.instance:endBlock("RougeTeamViewConfirm")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function RougeTeamView:onDestroyView()
	return
end

return RougeTeamView
