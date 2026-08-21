-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankPanelBase.lua

module("logic.extensions.rank.view.RankPanelBase", package.seeall)

local M = class("RankPanelBase", DynamicFragmentView)
local rankTypeToRankCell = {
	[CommEnum.RankEnum.Collection] = CollectionRankCell,
	[CommEnum.RankEnum.Level] = LevelRankCell,
	[CommEnum.RankEnum.ClimbTower] = ClimbTowerRankCell,
	[CommEnum.RankEnum.AirWorkShop] = AirWorkShopRankCell,
	[CommEnum.RankEnum.MainLine] = MainLineRankCell
}

function M:ctor()
	M.super.ctor(self)

	self._showRankIdList = {}
	self._lastRankId = nil
	self._subToggleList = nil
	self._subNormalNameList = nil
	self._subSelectNameList = nil
	self._loopList = nil
	self._lastRankToggle = nil
	self._curRankToggle = nil
	self._lastRequireIndex = 0
	self._curShowRankId = nil
	self._lastRankListCount = 0
	self._myRankGo = nil
	self._tempItemName = nil
	self._showTeamBtn = nil
end

function M:bindEvents()
	if self._subToggleList then
		for index, toggle in ipairs(self._subToggleList) do
			toggle:AddListener(function(_, isOn, IsEnable)
				self:_clickRank(index, isOn, IsEnable)
			end, nil)
		end
	end

	if self._lastRankToggle then
		self._lastRankToggle:AddListener(self._onToggleLastRank, self)
	end

	if self._curRankToggle then
		self._curRankToggle:AddListener(self._onToggleCurRank, self)
	end

	if self._showTeamBtn then
		self._showTeamBtn:AddClickListener(self._onClickShowTeam, self)
	end
end

function M:unbindEvents()
	if self._subToggleList then
		for index, toggle in ipairs(self._subToggleList) do
			toggle:RemoveListener()
		end
	end

	if self._lastRankToggle then
		self._lastRankToggle:RemoveListener()
	end

	if self._curRankToggle then
		self._curRankToggle:RemoveListener()
	end

	if self._showTeamBtn then
		self._showTeamBtn:RemoveClickListener()
	end
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.RANK_INFO_UPDATE, self._refreshRank, self)
	GlobalDispatcher:addEventListener(EventType.GET_VALID_RANK, self._onGetValidRank, self)
	self:_updateShowTeamState()
	self:_updateSubRank()
	self:_updateDefaultRank()
	self:_updateLastRankTabState()
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.RANK_INFO_UPDATE, self._refreshRank, self)
	GlobalDispatcher:removeEventListener(EventType.GET_VALID_RANK, self._onGetValidRank, self)
end

function M:_updateDefaultRank()
	if #self._showRankIdList > 0 and self._subToggleList then
		if self._subToggleList[1].IsOn then
			self:_resetRankScrollList(self._showRankIdList[1])
		else
			self._subToggleList[1].IsOn = true
		end
	elseif self._lastRankId and self._lastRankToggle then
		if self._lastRankToggle.IsOn then
			self:_resetRankScrollList(self._lastRankId)
		else
			self._lastRankToggle.IsOn = true
		end
	else
		local curShowRankId = self._showRankIdList[1]

		self:_resetRankScrollList(curShowRankId)
	end
end

function M:_updateShowTeamState()
	if self._showTeamBtn and self.changeShowTeamState then
		local isShow = RankController.instance:getIsShowTeam()

		self:changeShowTeamState(isShow)
	end
end

function M:_updateSubRank()
	self:_updateSubRankData()
	self:_updateSubRankTab()
end

function M:getRankId()
	return self._curShowRankId
end

function M:registerSubRankToggle(subToggleList, subNormalNameList, subSelectNameList)
	self._subToggleList = subToggleList
	self._subNormalNameList = subNormalNameList
	self._subSelectNameList = subSelectNameList
end

function M:registerScrollView(goScrollView)
	self._loopList = LoopGridViewHelper.New(goScrollView)

	self._loopList:InitGridView(0, self._onCellUpdate, self)

	local itemPrefabs = self._loopList:GetLoopGridView().ItemPrefabDataList

	if itemPrefabs.Count > 0 then
		local scrollTrans = goScrollView:GetComponent(UIComponentType.RectTransform)
		local tempPrefab = itemPrefabs[0].mItemPrefab

		self._tempItemName = tempPrefab.name

		local tempItemTrans = tempPrefab:GetComponent(UIComponentType.RectTransform)

		goutil.setWidth(tempItemTrans, goutil.getWidth(scrollTrans))
	end
end

function M:registerRankToggle(lastRankToggle, curRankToggle)
	self._lastRankToggle = lastRankToggle
	self._curRankToggle = curRankToggle
end

function M:registerMyRank(myRankGo)
	self._myRankGo = myRankGo
end

function M:registerShowTeamBtn(showTeamBtn)
	self._showTeamBtn = showTeamBtn
end

function M:_updateSubRankData()
	local rankType = self.params[1]
	local rankIds = RankNetModel.instance:getValidRankIds(rankType)

	table.clear(self._showRankIdList)

	self._lastRankId = nil

	if not rankIds then
		return
	end

	for _, rankId in ipairs(rankIds) do
		if RankConfig.instance:isLastRank(rankId) then
			self._lastRankId = rankId
		else
			table.insert(self._showRankIdList, rankId)
		end
	end

	table.sort(self._showRankIdList, function(a, b)
		return a < b
	end)
end

function M:_updateSubRankTab()
	if self._subToggleList then
		for i = 1, #self._subToggleList do
			local go = self._subToggleList[i].gameObject
			local rankId = self._showRankIdList[i]

			if rankId then
				local rankName = RankConfig.instance:getRankName(rankId)

				if self._subNormalNameList[i] then
					self._subNormalNameList[i].text = rankName
				end

				if self._subSelectNameList[i] then
					self._subSelectNameList[i].text = rankName
				end
			end

			goutil.setActive(go, rankId ~= nil)
		end
	end

	if self._lastRankToggle then
		self._lastRankToggle.IsEnable = true
	end

	if self._curRankToggle then
		self._curRankToggle.IsEnable = true
	end
end

function M:_updateLastRankTabState()
	if self._lastRankToggle then
		self._lastRankToggle.IsEnable = self._lastRankId ~= nil and self._lastRankId > 0
	end

	if self._curRankToggle then
		self._curRankToggle.IsEnable = self._showRankIdList ~= nil and #self._showRankIdList > 0
	end
end

function M:_resetRankScrollList(rankId)
	if not rankId then
		return
	end

	self._curShowRankId = rankId
	self._lastRequireIndex = 0

	self._loopList:MoveToItemIndex(0)

	local leftValue, rightValue = RankConfig.instance:getRefreshRankInterval(rankId, 0, true)

	if leftValue <= rightValue then
		RankAgent.instance:sendGetRankListRequest(rankId, leftValue, rightValue)
	end
end

function M:_refreshRank(_, rankId)
	if self._curShowRankId ~= rankId then
		return
	end

	self:_refreshRankScrollList(rankId)
	self:_refreshMyRank(rankId)
end

function M:_onGetValidRank(_, validRanks)
	self:_updateSubRank()

	if #self._showRankIdList <= 0 and self._lastRankId and self._lastRankToggle then
		self._lastRankToggle.IsOn = true
	end

	self:_updateLastRankTabState()
end

function M:_refreshRankScrollList(rankId)
	local rankMoList = RankNetModel.instance:getRankListById(rankId)

	if not self._loopList or not rankMoList then
		return
	end

	if #rankMoList ~= self._lastRankListCount then
		self._loopList:SetListItemCount(#rankMoList, false)
	end

	self._loopList:RefreshAllShownItem()
end

function M:_refreshMyRank(rankId)
	if self._myRankGo then
		local rankType = RankConfig.instance:getRankType(rankId)
		local myRankData = RankNetModel.instance:getMyRankById(rankId)
		local cell = rankTypeToRankCell[rankType]

		if cell and myRankData then
			local shower = Astral.LuaComponentContainer.Add(self._myRankGo, cell)

			shower:updateData(myRankData)
		end
	end
end

function M:_clickRank(index, isOn, IsEnable)
	if not isOn then
		return
	end

	local curShowRankId = self._showRankIdList[index]

	if not curShowRankId then
		return
	end

	self:_resetRankScrollList(curShowRankId)
end

function M:_onToggleLastRank(_, isOn, IsEnable)
	if not IsEnable then
		FloatWordMgr.instance:show(lang("rank_no_open"))

		return
	end

	if not isOn then
		return
	end

	self:_resetRankScrollList(self._lastRankId)
end

function M:_onToggleCurRank(_, isOn, IsEnable)
	if not IsEnable then
		FloatWordMgr.instance:show(lang("rank_no_open"))

		return
	end

	if not isOn then
		return
	end

	local curShowRankId = self._showRankIdList[1]

	self:_resetRankScrollList(curShowRankId)
end

function M:_onClickShowTeam()
	local isShow = not RankController.instance:getIsShowTeam()

	RankController.instance:setIsShowTeam(isShow)
	GlobalDispatcher:dispatchEvent(EventType.RANK_SHOW_TEAM, self._curShowRankId)

	if self.changeShowTeamState then
		self:changeShowTeamState(isShow)
	end
end

function M:_onCellUpdate(curIndex)
	if not self._curShowRankId then
		return
	end

	curIndex = curIndex + 1

	self:_refreshRankPage(curIndex, self._curShowRankId)

	local rankType = RankConfig.instance:getRankType(self._curShowRankId)
	local rankList = RankNetModel.instance:getRankListById(self._curShowRankId)
	local cell = rankTypeToRankCell[rankType]
	local item = self._loopList:NewListViewItem(self._tempItemName)

	item.gameObject.name = cell.__cname .. curIndex

	if cell and rankList and rankList[curIndex] then
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, cell)

		shower:updateData(rankList[curIndex])
	end

	return item
end

function M:_refreshRankPage(curIndex, curShowRankId)
	if curIndex % RankConfig.refreshDot == 0 and curIndex ~= self._lastRequireIndex then
		local leftValue, rightValue = RankConfig.instance:getRefreshRankInterval(curShowRankId, curIndex)

		if leftValue <= rightValue then
			RankAgent.instance:sendGetRankListRequest(curShowRankId, leftValue, rightValue)

			self._lastRequireIndex = curIndex
		end
	end
end

function M:destroyUI()
	self._showRankIdList = nil
	self._lastRankId = nil
	self._subToggleList = nil
	self._subNormalNameList = nil
	self._subSelectNameList = nil
	self._loopList = nil
	self._lastRankToggle = nil
	self._curRankToggle = nil
	self._lastRequireIndex = nil
	self._curShowRankId = nil
	self._lastRankListCount = nil
	self._showTeamBtn = nil
end

return M
