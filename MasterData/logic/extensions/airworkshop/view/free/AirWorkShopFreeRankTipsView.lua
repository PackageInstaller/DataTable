-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/free/AirWorkShopFreeRankTipsView.lua

module("logic.extensions.airworkshop.view.free.AirWorkShopFreeRankTipsView", package.seeall)

local M = class("AirWorkShopFreeRankTipsView", ViewComponent)

M.RankId = AirWorkShopEnum.FreeEndlessRankId
M.LoadingStatus = {
	WaitLoad = 4,
	WaitContinureDrag = 2,
	WaitRelease = 3,
	Loaded = 5,
	None = 1
}
M.OnePageItemCount = 20
M.LoadTipsHeight = 40

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._btnClose = self:getBtn("3&universal_second_tips_common_bg_1201003252")
	self._cellPlayerRank = Astral.SimpleLuaComponentContainer.Add(self:getGo("1&challenge_schema_rank_item_-1101876018"), AirWorkShopRankItemCell)
	self._scroll = self:getUIComponent("challenge_schema_rank_tips_-1705253791", UIComponentType.ScrollRect)
	self._defualtOffsetMin = self._scroll.viewport.offsetMin

	RectTransformUtils.ForceRebuildLayoutImmediate(self:getUIComponent("challenge_schema_rank_tips_-1705253791", UIComponentType.RectTransform))

	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)
	self._loopList:AddDragListener(self._onDrag, self)
	self._loopList:AddEndDragListener(self._onEndDrag, self)
end

function M:destroyUI()
	self._loopList:RemoveDragListener()
	self._loopList:RemoveEndDragListener()
	self._loopList:Dispose()

	self._loopList = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true
	self._lastReqTs = 0
	self._canvasGroup.interactable = true

	self:_setLoadingStatus(M.LoadingStatus.None)

	self._scroll.verticalNormalizedPosition = 1

	self:setEvent(true)
	self:refreshView()
	self:reqFromServer(1, 20)
end

function M:onExit()
	self._isEnter = false
	self._canvasGroup.interactable = false

	self:_setLoadingStatus(nil)
	self:setEvent(false)
	self._loopList:ClearCells()

	self._waitForReply = false
end

function M:reqFromServer(startIndex, endIndex)
	self._waitForReply = true

	RankAgent.instance:sendGetRankListRequest(M.RankId, startIndex, endIndex)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.RANK_INFO_UPDATE, self._handleOnRankChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.RANK_INFO_UPDATE, self._handleOnRankChange, self)
	end
end

function M:_handleOnRankChange(e, rankId)
	if not self._isEnter then
		return
	end

	if rankId ~= M.RankId then
		return
	end

	self._waitForReply = false
	self._lastReqTs = ServerTime.now()

	local resetPos = true
	local loadingStatus = self:_getLoadingStatus()

	if loadingStatus == M.LoadingStatus.WaitLoad then
		self:_setLoadingStatus(M.LoadingStatus.None)

		resetPos = false
	end

	self._loopList:GetLoopListView().ScrollRect:StopMovement()
	self:refreshView(resetPos)
end

function M:_onClickClose()
	self:close()
end

function M:_setLoadingStatus(status)
	self._loadingTipsStatus = status
end

function M:_getLoadingStatus()
	return self._loadingTipsStatus or M.LoadingStatus.None
end

function M:_onDrag()
	if not self._isEnter then
		return
	end

	if self._waitForReply then
		return
	end

	local showItemCount = self._loopList:GetLoopListView().ShownItemCount

	if showItemCount == 0 then
		return
	end

	local len = self._rankList and #self._rankList or 0

	if len == 0 then
		return
	end

	local item = self._loopList:GetLoopListView():GetShownItemByItemIndex(len - 1)

	if not item or goutil.isNil(item) then
		return
	end

	local viewPortSize = self._loopList:GetLoopListView().ViewPortSize
	local y = self._loopList:GetLoopListView():GetItemCornerPosInViewPort(item, SuperScrollView.ItemCornerEnum.LeftBottom).y

	if y + viewPortSize > M.LoadTipsHeight then
		if self:_getLoadingStatus() ~= M.LoadingStatus.None then
			return
		end

		self:_setLoadingStatus(M.LoadingStatus.WaitRelease)
	else
		if self:_getLoadingStatus() ~= M.LoadingStatus.WaitRelease then
			return
		end

		self:_setLoadingStatus(M.LoadingStatus.None)
	end
end

function M:_onEndDrag()
	if not self._isEnter then
		return
	end

	local showItemCount = self._loopList:GetLoopListView().ShownItemCount
	local len = self._rankList and #self._rankList or 0

	if showItemCount == 0 then
		return
	end

	local loadingStatus = self:_getLoadingStatus()

	if loadingStatus ~= M.LoadingStatus.WaitRelease then
		return
	end

	self:_setLoadingStatus(M.LoadingStatus.WaitLoad)
	self:_reqMoreData(M.OnePageItemCount)
end

function M:_reqMoreData(count)
	local passTime = ServerTime.now() - self._lastReqTs

	if passTime >= 1 then
		local maxCount = AirWorkShopEnum.DefaultMaxRankShow
		local len = self._rankList and #self._rankList or 0
		local startIndex = len == 0 and 1 or len
		local endIndex = len + count

		endIndex = maxCount < endIndex and maxCount or endIndex

		if passTime >= AirWorkShopEnum.DefaultRankReqTimeInterval then
			startIndex = 1
		end

		self:reqFromServer(startIndex, endIndex)
	else
		self:_setLoadingStatus(M.LoadingStatus.None)
	end
end

function M:refreshView(resetPos)
	self._rankList = RankNetModel.instance:getRankListById(M.RankId)

	local rankPlayer = RankNetModel.instance:getMyRankById(M.RankId)

	self._cellPlayerRank:updateData(rankPlayer)

	self._playerRank = rankPlayer and rankPlayer:getRank() or 9999

	local len = self._rankList and #self._rankList or 0

	if len > 0 then
		self._loopList:SetListItemCount(len, resetPos)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._rankList[curIndex]
	local class = AirWorkShopRankItemCell
	local prefabName = "challenge_schema_rank_item"
	local item = self._loopList:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, class)

	if shower == nil then
		shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, class)
	end

	shower:setHandler(self)
	shower:updateData(data)

	return item
end

return M
