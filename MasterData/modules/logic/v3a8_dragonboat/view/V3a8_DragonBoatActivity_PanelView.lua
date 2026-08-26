-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_PanelView.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_PanelView", package.seeall)

local V3a8_DragonBoatActivity_PanelView = class("V3a8_DragonBoatActivity_PanelView", BaseView)

function V3a8_DragonBoatActivity_PanelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Root/txtbg/#txt_desc")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_DragonBoatActivity_PanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V3a8_DragonBoatActivity_PanelView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V3a8_DragonBoatActivity_PanelView:_btncloseOnClick()
	self:closeThis()
end

function V3a8_DragonBoatActivity_PanelView:onClickModalMask()
	self:closeThis()
end

function V3a8_DragonBoatActivity_PanelView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_btnItemList")

	self._redBtnItem = nil
	self._blueBtnItem = nil
end

function V3a8_DragonBoatActivity_PanelView:_editableInitView()
	self._voteResultInfo = {}
	self._redGo = gohelper.findChild(self.viewGO, "Root/Btn/red")
	self._blueGo = gohelper.findChild(self.viewGO, "Root/Btn/blue")
	self._redBtnItem = self:_create_V3a8_DragonBoatActivity_PanelView_Btn(self._redGo)
	self._blueBtnItem = self:_create_V3a8_DragonBoatActivity_PanelView_Btn(self._blueGo)
	self._btnItemList = {
		self._blueBtnItem,
		self._redBtnItem
	}
	self._scroll_lineGo = gohelper.findChild(self.viewGO, "Root/scroll_line")
	self._scrllLine = self.viewContainer:create_V3a8_DragonBoatActivity_ScrollLine(self, self._scroll_lineGo)
end

function V3a8_DragonBoatActivity_PanelView:actId()
	return (self.viewContainer:actId())
end

function V3a8_DragonBoatActivity_PanelView:onUpdateParam()
	self._scrllLine:onUpdateMO()
	self:_refreshBtnList()
	self:_refreshCurMaxTicket()
end

function V3a8_DragonBoatActivity_PanelView:_refreshCurMaxTicket()
	local maxNum = self.viewContainer:displayMaxTicketNum()

	for _, item in ipairs(self._btnItemList) do
		item:setSettings(1, maxNum)
	end

	self._txtdesc.text = string.format(luaLang("V3a8_DragonBoatActivity_FullView_txtdesc"), maxNum)
end

function V3a8_DragonBoatActivity_PanelView:onOpen()
	self._voteResultInfo = {}

	self:onUpdateParam()
	self.viewContainer:play_ui_shiji_vote_open()
	GlobalVoteController.instance:registerCallback(GlobalVoteEvent.onReceiveGlobalVoteGetInfoReply, self._onReceiveGlobalVoteGetInfoReply, self)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.Low)
end

function V3a8_DragonBoatActivity_PanelView:onClose()
	GlobalVoteController.instance:unregisterCallback(GlobalVoteEvent.onReceiveGlobalVoteGetInfoReply, self._onReceiveGlobalVoteGetInfoReply, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self:_tryRefreshFullView()
end

function V3a8_DragonBoatActivity_PanelView:_onUpdateActivity()
	local isOpenedVoteFinal = self.viewContainer:isOpenedVoteFinal()

	if isOpenedVoteFinal then
		self:closeThis()
	end
end

function V3a8_DragonBoatActivity_PanelView:_onDailyRefresh()
	self.viewContainer:doOnDailyRefresh()
end

function V3a8_DragonBoatActivity_PanelView:OnDoneDailyRefresh()
	self._bRefreshFullView = true

	local isOpenedVoteFinal = self.viewContainer:isOpenedVoteFinal()

	if isOpenedVoteFinal then
		self:closeThis()

		return
	end

	self:_refreshProgress()
	self:_refreshCurMaxTicket()
end

function V3a8_DragonBoatActivity_PanelView:_refreshBtnList()
	local optionList = self.viewContainer:getOptionList()

	if isDebugBuild then
		assert(#self._btnItemList == #optionList)
	end

	local displayMaxTicketNum = self.viewContainer:displayMaxTicketNum()

	for i, CO in ipairs(optionList) do
		local item

		if CO.optionId == V3a8_DragonBoatEnum.Op.Blue then
			item = self._blueBtnItem
		elseif CO.optionId == V3a8_DragonBoatEnum.Op.Red then
			item = self._redBtnItem
		else
			assert(false, "[V3a8_DragonBoatActivity_PanelView] unsupported")
		end

		item:setSettings(1, displayMaxTicketNum, displayMaxTicketNum)
		item:onUpdateMO(CO)
	end
end

function V3a8_DragonBoatActivity_PanelView:onNumChanged(item)
	self:_refreshCurMaxTicket()
end

function V3a8_DragonBoatActivity_PanelView:_create_V3a8_DragonBoatActivity_PanelView_Btn(srcGo)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a8_DragonBoatActivity_PanelView_Btn.New(ctroParams)

	item:init(srcGo)

	return item
end

function V3a8_DragonBoatActivity_PanelView:onNumOkClick(item)
	local voteNum = item:num()

	if voteNum <= 0 then
		return
	end

	local lua_activity241_option_CO = item._mo
	local optionId = lua_activity241_option_CO.optionId

	self.viewContainer:sendAct241Vote(voteNum, optionId, self._onSendAct241VoteCb, self)
end

function V3a8_DragonBoatActivity_PanelView:_onSendAct241VoteCb(_, resultCode, msg)
	if resultCode == 0 then
		if msg.activityId ~= self:actId() then
			return
		end

		local voteNum = msg.voteNum
		local optionId = msg.optionId

		self._bRefreshFullView = true
		self._voteResultInfo[optionId] = self._voteResultInfo[optionId] or 0
		self._voteResultInfo[optionId] = self._voteResultInfo[optionId] + voteNum

		self.viewContainer:sendGlobalVoteGetInfo()
	end

	self:closeThis()
end

function V3a8_DragonBoatActivity_PanelView:_refreshProgress()
	self._scrllLine:refresh()
end

function V3a8_DragonBoatActivity_PanelView:_onReceiveGlobalVoteGetInfoReply()
	self:_refreshProgress()
	self:_refreshCurMaxTicket()
end

function V3a8_DragonBoatActivity_PanelView:_tryRefreshFullView()
	if not self._bRefreshFullView then
		return
	end

	self._bRefreshFullView = nil

	local kViewName = ViewName.V3a8_DragonBoatActivity_FullView
	local c = ViewMgr.instance:getContainer(kViewName)

	if not c then
		return
	end

	if not ViewMgr.instance:isOpen(kViewName) then
		return
	end

	c:doFlowFromPanel(self._voteResultInfo)
end

return V3a8_DragonBoatActivity_PanelView
