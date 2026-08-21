-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoRankTips.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoRankTips", package.seeall)

local M = class("AirWorkShopRodeoRankTips", ViewComponent)

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
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._btnExit = self:getBtnByPath("middle_tips_common_bg/clickExit")
	self._cellPlayerRank = Astral.SimpleLuaComponentContainer.Add(self:getGo("air_workshop_sports_rank_tips_2111739764"), AirWorkShopRodeoRankItemCell)
	self._scroll = self:getUIComponent("air_workshop_sports_rank_tips_-1207928752", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)
	self._loopList:AddDragListener(self._onDrag, self)
	self._loopList:AddEndDragListener(self._onEndDrag, self)

	self._tabComp = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "allContent/left_tab_list").gameObject, LeftTabListComp)

	self._tabComp:resetTabList()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	self._tabPartIds = {
		0
	}

	local minLv, maxLv = AirWorkShopConfig.instance:getRodeoPartLvRange()

	for i = maxLv, minLv, -1 do
		table.insert(self._tabPartIds, i)
	end

	for _, _lv in ipairs(self._tabPartIds) do
		local tabName = self:getTabName(_lv)
		local tabCell = self._tabComp:createTabCell(LeftTabListCellMO.New({
			tabName = tabName,
			iconType = IconType.activityTabIcon,
			redDotKeyList = {},
			redDotParentKeyLsit = {}
		}))

		self._toggleTabControl:addToggleTab(tabCell:getToggleTab())
	end
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopList:RemoveDragListener()
	self._loopList:RemoveEndDragListener()
	self._loopList:Dispose()

	self._loopList = nil
	self._cellRound = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnExit:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnExit:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true
	self._canvasGroup.interactable = true

	self:_setLoadingStatus(M.LoadingStatus.None)
	self:setEvent(true)
	self._tabComp:onEnter()

	local defualtTabIndex = 1

	self._toggleTabControl:selectTab(defualtTabIndex)
end

function M:onExit()
	self._isEnter = false
	self._canvasGroup.interactable = false

	self:_setLoadingStatus(nil)

	local info = self:getFirstParam() or {}

	self:setEvent(false)
	self._tabComp:onExit()

	self._activeIndex = nil

	self._loopList:ClearCells()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_RANK_CHANGE, self._handleOnRecordRankChange, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_RANK_CHANGE, self._handleOnRecordRankChange, self)
	end
end

function M:_handleOnRecordRankChange(e)
	if self._activeIndex then
		local resetPos = true
		local loadingStatus = self:_getLoadingStatus()

		if loadingStatus == M.LoadingStatus.WaitLoad then
			self:_setLoadingStatus(M.LoadingStatus.None)

			resetPos = false
		end

		self:refreshView(self._activeIndex, resetPos)
	end
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

function M:_onClickClose()
	self:close()
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:refreshView(self._activeIndex, true)

		self._scroll.verticalNormalizedPosition = 1
	end
end

function M:getTabName(lv)
	if lv == 0 then
		return lang("tip_air_rank_tab_all")
	else
		return AirWorkShopConfig.instance:getRodeoPartLvName(lv)
	end
end

function M:_reqMoreData(count)
	local week = AirWorkShopUtil.getClosestLastSettleWeek()
	local part = self._tabPartIds[self._activeIndex]
	local exitCount, isMax = AirWorkShopChallengeModel.instance:getRankListCount(week, part)
	local maxCount = AirWorkShopChallengeModel.instance:getMaxShowRankCount(week, part)
	local canReq, passTime = AirWorkShopChallengeModel.instance:canReqNewRankDataFromServer(week, part)

	if canReq then
		local startIndex = exitCount > 0 and exitCount + 1 or 1
		local endIndex = exitCount > 0 and startIndex + count - 1 or count

		if passTime then
			startIndex = 1
		end

		endIndex = maxCount < endIndex and maxCount or endIndex

		AirWorkShopAtkAgent.instance:sendGetRodeoRankRequest(week, part, startIndex, endIndex)
	else
		self:_setLoadingStatus(M.LoadingStatus.None)
	end
end

function M:refreshView(index, resetPos)
	local curMaxOfWeek = AirWorkShopChallengeModel.instance:getMaxOfWeek()
	local lastSettleWeek = AirWorkShopChallengeModel.instance:getLastSettleWeek()
	local week = AirWorkShopUtil.getClosestLastSettleWeek()
	local part = self._tabPartIds[index]
	local mo = AirWorkShopChallengeModel.instance:getRodeoRankPartMo(week, part)

	if not mo then
		AirWorkShopAtkAgent.instance:sendGetRodeoRankRequest(week, part, 1, M.OnePageItemCount)

		return
	end

	if lastSettleWeek == week and mo:getPlayerRankScore() ~= curMaxOfWeek then
		if Astral.OSDef.isEditor then
			printWarn(string.format("[工坊-竞技-排名],week[%s],记录的玩家分数[%s]和当前maxOfWeek[%s]不一致,清空week的排名记录,重新获取", week, mo:getPlayerRankScore(), curMaxOfWeek))
		end

		AirWorkShopChallengeModel.instance:clearRodeoRankPartMo(week)
		AirWorkShopAtkAgent.instance:sendGetRodeoRankRequest(week, part, 1, M.OnePageItemCount)

		return
	end

	local rankPlayer = mo:getPlayerRankMO()

	self._cellPlayerRank:updateData(rankPlayer)

	self._rankList = mo:getRankList()

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
	local class = AirWorkShopRodeoRankItemCell
	local prefabName = "rank_item"
	local item = self._loopList:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, class)

	if shower == nil then
		shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, class)
	end

	shower:updateData(data)

	return item
end

return M
