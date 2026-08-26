-- chunkname: @modules/logic/social/view/SocialSearchView.lua

module("modules.logic.social.view.SocialSearchView", package.seeall)

local SocialSearchView = class("SocialSearchView", BaseView)

function SocialSearchView:onInitView()
	self._gorecommend = gohelper.findChild(self.viewGO, "container/#go_recommend")
	self._gonorecommend = gohelper.findChild(self.viewGO, "container/#go_recommend/#go_norecommend")
	self._gohaverecommend = gohelper.findChild(self.viewGO, "container/#go_recommend/#go_haverecommend")
	self._gosearchresults = gohelper.findChild(self.viewGO, "container/#go_searchresults")
	self._btnchangerecommend = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_recommend/#go_haverecommend/#btn_change")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "search/#btn_return")
	self._btnsearch = gohelper.findChildButtonWithAudio(self.viewGO, "search/#btn_search")
	self._inputsearch = gohelper.findChildTextMeshInputField(self.viewGO, "search/#input_search")
	self._gonosearch = gohelper.findChild(self.viewGO, "container/#go_searchresults/#go_nosearch")
	self._scrollsearch = gohelper.findChildScrollRect(self.viewGO, "container/#go_searchresults/scrollview")
	self._scrollrecommend = gohelper.findChildScrollRect(self.viewGO, "container/#go_recommend/scrollview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialSearchView:addEvents()
	self._btnchangerecommend:AddClickListener(self._btnchangeOnClick, self)
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
	self._btnsearch:AddClickListener(self._btnsearchOnClick, self)
end

function SocialSearchView:removeEvents()
	self._btnchangerecommend:RemoveClickListener()
	self._btnreturn:RemoveClickListener()
	self._btnsearch:RemoveClickListener()
end

function SocialSearchView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(self._btnsearch.gameObject, AudioEnum.UI.UI_Common_Click)
end

function SocialSearchView:_btnchangeOnClick()
	if self._searchFriendCD then
		GameFacade.showToast(ToastEnum.SocialSearch2)
	else
		self._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(self._onTimeEnd, self, self._searchFriendCD)
		self:_switchTab(1)
		SocialModel.instance:clearRecommendList()
		FriendRpc.instance:sendGetRecommendRequest(self._playSwitchAnim, self)
	end
end

function SocialSearchView:_inputValueChanged()
	local inputValue = self._inputsearch:GetText()

	if inputValue == self._searchValue then
		return
	end

	self._searchValue = GameUtil.utf8sub(inputValue, 1, math.min(GameUtil.utf8len(inputValue), 18))

	self._inputsearch:SetText(self._searchValue)
end

function SocialSearchView:_btnreturnOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
	self:_resetView()
end

function SocialSearchView:_btnsearchOnClick()
	if string.nilorempty(self._searchValue) then
		GameFacade.showToast(ToastEnum.SocialSearch1)

		return
	end

	if self._searchFriendCD then
		GameFacade.showToast(ToastEnum.SocialSearch2)
	else
		self._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(self._onTimeEnd, self, self._searchFriendCD)
		self:_switchTab(2)
		SocialModel.instance:clearSearchList()
		SocialController.instance:dispatchEvent(SocialEvent.SearchInfoChanged)
		FriendRpc.instance:sendSearchRequest(self._searchValue, self._playSwitchAnim, self)
	end
end

function SocialSearchView:_playSwitchAnim()
	if self._viewAnim then
		self._viewAnim:Play("switch", 0, 0)
	end
end

function SocialSearchView:_onTimeEnd()
	self._searchFriendCD = nil
end

function SocialSearchView:_switchTab(index, open)
	self._selectIndex = index

	SocialController.instance:dispatchEvent(SocialEvent.SubTabSwitch, index)
	gohelper.setActive(self._gorecommend, index == 1)
	gohelper.setActive(self._gosearchresults, index == 2)
	gohelper.setActive(self._btnreturn.gameObject, index == 2)
	self:_refreshUI(open)
end

function SocialSearchView:onOpen()
	self._inputsearch:AddOnValueChanged(self._inputValueChanged, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.RecommendChanged, self._refreshUI, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.SearchInfoChanged, self._refreshUI, self)

	if self._notFirst then
		self:_resetView()
	else
		self:_resetView(true)
	end

	self._notFirst = true
end

function SocialSearchView:_resetView(open)
	self._searchValue = ""

	self._inputsearch:SetText(self._searchValue)
	self:_switchTab(1, open)

	if UnityEngine.Time.realtimeSinceStartup - SocialModel.instance.leftSendRecommendReqDt > SocialEnum.SearchFriendCD then
		SocialModel.instance:clearRecommendList()
		FriendRpc.instance:sendGetRecommendRequest()

		self._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(self._onTimeEnd, self, self._searchFriendCD)
	end
end

function SocialSearchView:_refreshUI(open)
	local recommendCount = SocialModel.instance:getRecommendCount()
	local searchCount = SocialModel.instance:getSearchCount()

	gohelper.setActive(self._gonorecommend, not open and recommendCount <= 0)
	gohelper.setActive(self._gohaverecommend, not open and recommendCount > 0)
	gohelper.setActive(self._gonosearch, not open and searchCount <= 0)

	if self._selectIndex == 1 then
		self._scrollrecommend.verticalNormalizedPosition = 1
	elseif self._selectIndex == 2 then
		self._scrollsearch.verticalNormalizedPosition = 1
	end
end

function SocialSearchView:onClose()
	self._inputsearch:RemoveOnValueChanged()
	self.removeEventCb(self, SocialController.instance, SocialEvent.RecommendChanged, self._refreshUI, self)
	self.removeEventCb(self, SocialController.instance, SocialEvent.SearchInfoChanged, self._refreshUI, self)
end

function SocialSearchView:onDestroyView()
	TaskDispatcher.cancelTask(self._onTimeEnd, self)
end

return SocialSearchView
