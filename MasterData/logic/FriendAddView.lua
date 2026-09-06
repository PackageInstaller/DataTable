-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendAddView.lua

module("logic.extensions.friend.view.FriendAddView", package.seeall)

local FriendAddView = class("FriendAddView", TableViewComponent)

function FriendAddView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "SrlC_Search"
	}
end

function FriendAddView:buildUI()
	FriendAddView.super.buildUI(self)

	self._Input_Search = self:getInput("InputC_Search")
	self._Btn_Search = self:getBtn("Btn_Search")
	self._Btn_Back = self:getBtn("Btn_Back")
	self._Btn_IgnoreAll = self:getBtn("bottom/Btn_IgnoreAll")
	self._Btn_AgreeAll = self:getBtn("bottom/Btn_AgreeAll")
	self._bottom = self:getGo("bottom")
	self._Btn_Refresh = self:getGo("Btn_Refresh")
	self._txtApplyCount = goutil.findChildTextComponent(self._bottom, "txtApplyCount")
	self._emptyTips = self:getGo("EmptyTips")
	self.Image = self:getGo("EmptyTips/Image")

	GameUtil.SetActive(self.Image, false)

	self._txtEmptyTips = self:getTxt("EmptyTips/Text")
end

local FriendAddViewState = {
	Recommend = 2,
	Searching = 3,
	Request = 1
}

function FriendAddView:ctor()
	FriendAddView.super.ctor(self)

	self._viewState = 0
end

function FriendAddView:bindEvents()
	self._Btn_Search:AddClickListener(self._onClickSearch, self)
	self._Btn_Back:AddClickListener(self._onClickBack, self)
	self._Btn_IgnoreAll:AddClickListener(self._onClickIgnoreAll, self)
	self._Btn_AgreeAll:AddClickListener(self._onClickAgreeAll, self)
	GameUtil.addClickHandler(self._Btn_Refresh, self._onClickRefresh, self)
	FriendController.instance:registerLocalNotify("FriendApplyUpdate", self._onFriendApplyUpdate, self)
	FriendController.instance:registerLocalNotify("RefreshRecomend", self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendAdd, self._refresh, self)
end

function FriendAddView:unbindEvents()
	self._Btn_Search:RemoveClickListener()
	self._Btn_Back:RemoveClickListener()
	self._Btn_IgnoreAll:RemoveClickListener()
	self._Btn_AgreeAll:RemoveClickListener()
	GameUtil.rmClickHandler(self._Btn_Refresh)
	FriendController.instance:unregisterLocalNotify("FriendApplyUpdate", self._onFriendApplyUpdate, self)
	FriendController.instance:unregisterLocalNotify("RefreshRecomend", self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendAdd, self._refresh, self)
end

function FriendAddView:_numInView()
	return (self._curViewDatas or nil) and (#self._curViewDatas or 0)
end

function FriendAddView:_cellSize()
	return 1074, 100
end

function FriendAddView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1
	cell.index = idx

	local component = ItemFriendAdd.AddOnce(cell.gameObject)
	local applyOrAdd = self._viewState == FriendAddViewState.Request

	component:onSetMo(data, applyOrAdd)

	return cell
end

function FriendAddView:destroyUI()
	return
end

function FriendAddView:onEnter()
	FriendAddView.super.onEnter(self)
	self._Input_Search:SetText("")
	self:_checkInitViewState()
	self:_refresh()
end

function FriendAddView:onEnterFinished()
	return
end

function FriendAddView:onExit()
	return
end

function FriendAddView:onExitFinished()
	return
end

function FriendAddView:_checkInitViewState()
	local data = FriendModel.instance:getRequests()

	self._viewState = data and #data > 0 and FriendAddViewState.Request or FriendAddViewState.Recommend
	self._initViewState = self._viewState
end

function FriendAddView:_refresh(viewState)
	if goutil.isNil(self._emptyTips) then
		return
	end

	viewState = checknumber(viewState)

	if viewState >= 1 and viewState <= 3 then
		self._viewState = viewState
	end

	self:_updateList()
	self:_updateUIState()
end

function FriendAddView:_updateList()
	goutil.setActive(self._Btn_Refresh, false)

	self._curViewDatas = {}

	if self._viewState == FriendAddViewState.Recommend then
		goutil.setActive(self._Btn_Refresh, true)

		self._curViewDatas = FriendModel.instance:getRecommends()
		self._txtEmptyTips.text = lang("当前没有可推荐的好友")
	elseif self._viewState == FriendAddViewState.Request then
		self._curViewDatas = FriendModel.instance:getRequests()

		local maxCount = FriendConfig.instance:getCommonValue("MAX_UNHANDLE_REQUEST")

		self._txtApplyCount.text = string.format("申请数量：%s/%s", #self._curViewDatas, maxCount)
		self._txtEmptyTips.text = lang("当前没有好友申请")
	elseif self._viewState == FriendAddViewState.Searching then
		self._curViewDatas = FriendModel.instance:getSearchs()
		self._txtEmptyTips.text = lang("搜索不到该名奥奇")
	end

	self._emptyTips:SetActive(not self._curViewDatas or #self._curViewDatas == 0)
	self:reloadData()
	goutil.setActive(self._bottom, self._viewState == FriendAddViewState.Request)
end

function FriendAddView:_updateUIState()
	self._Btn_Back.btn.gameObject:SetActive(self._viewState == FriendAddViewState.Searching)
end

function FriendAddView:_onClickChange()
	self:_refreshRecommeds()
end

function FriendAddView:_refreshRecommeds()
	FriendController.instance:RefreshRecommendBuddies(function()
		self:_refresh(FriendAddViewState.Recommend)
	end, self)
end

function FriendAddView:_onClickSearch()
	local content = self._Input_Search:GetText()

	if content and #content > 0 then
		FriendAgent.instance:sendSearchUserReq(content, nil, function()
			self:_refresh(FriendAddViewState.Searching)
		end, self)
	end
end

function FriendAddView:_onClickBack()
	self._Input_Search:SetText("")
	self:_refresh(self._initViewState)
end

function FriendAddView:_onClickRefresh()
	FriendController.instance:sendRefreshRecommend()
end

function FriendAddView:_onClickAgreeAll()
	FriendController.instance:batchHandleBuddyRequest(true)
end

function FriendAddView:_onClickIgnoreAll()
	FriendController.instance:batchHandleBuddyRequest(false)
end

function FriendAddView:_onFriendApplyUpdate()
	if goutil.isNil(self._emptyTips) then
		return
	end

	if self._viewState ~= FriendAddViewState.Request then
		return
	end

	self:_checkInitViewState()

	if #self._curViewDatas == 0 and self._viewState == FriendAddViewState.Recommend then
		self:_refreshRecommeds()
	else
		self:_refresh()
		self._emptyTips:SetActive(not self._curViewDatas or #self._curViewDatas == 0)
	end
end

return FriendAddView
