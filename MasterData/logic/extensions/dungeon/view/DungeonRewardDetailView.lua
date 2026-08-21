-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonRewardDetailView.lua

module("logic.extensions.dungeon.view.DungeonRewardDetailView", package.seeall)

local M = class("DungeonRewardDetailView", ViewComponent)

M.kType = {
	FirstPass = 1,
	Random = 3,
	Normal = 2
}

function M:buildUI()
	self._btnReturn = self:getBtnByPath("brnClose")
	self._btnCloseOutSide = self:getBtn("empty_mask_tips_29887572")
	self._scrollMiddlePanel = self:getUIComponent("settle_details_view_181799860", UIComponentType.ScrollRect)
	self._comps = {}
	self._comps[self.kType.FirstPass] = {
		getDataFunc = self.getRewardLstFirstPass,
		goRoot = self:getGo("settle_details_view_161394186"),
		goLst = self:getGo("settle_details_view_1442752100"),
		goText1 = self:getGo("settle_details_view_1837928725")
	}
	self._comps[self.kType.Normal] = {
		getDataFunc = self.getRewardLstNormal,
		goRoot = self:getGo("settle_details_view_712178973"),
		goLst = self:getGo("settle_details_view_741967645")
	}
	self._comps[self.kType.Random] = {
		getDataFunc = self.getRewardLstRandom,
		goRoot = self:getGo("settle_details_view_1592464312"),
		goLst = self:getGo("settle_details_view_658090033")
	}

	for _, compG in pairs(self._comps) do
		self:_fixLayOutConstraintCount(compG)
	end
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnCloseOutSide = nil
	self._comps = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	self._dungeonId = self:getFirstParam()
	self._dungeonMo = DungeonModel.instance:getDungeonMoById(self._dungeonId)

	self:_refreshView()

	self._scrollMiddlePanel.verticalNormalizedPosition = 1
end

function M:getCompGroup(typ)
	return self._comps[typ]
end

function M:_refreshView()
	self:_refreshRewardLstPanel(self.kType.FirstPass)
	self:_refreshRewardLstPanel(self.kType.Normal)
	self:_refreshRewardLstPanel(self.kType.Random)
end

function M:getRewardItemPrefab()
	return self:getResInstance(ResName.Common_Backpack_Item)
end

function M:isFirstPassRewardGot()
	return self._dungeonMo:hasPassed()
end

function M:_collectFirstPassRewardItemData(rewardList, reward)
	for i, v in ipairs(reward and reward or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
			local itemData = ItemUtil.createItemData({
				itemId = v.code
			})

			itemData:setCount(v.num)

			itemData.count = v.num
			itemData.rewardStatus = self:isFirstPassRewardGot() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
			itemData.itemSign = self:isFirstPassRewardGot() and CommEnum.BackPackItemSignTyp.Get or CommEnum.BackPackItemSignTyp.None

			table.insert(rewardList, itemData)
		end
	end
end

function M:getRewardLstFirstPass()
	local rewardLst = {}
	local rewardCode = self._dungeonMo:getFristPassReward()

	if rewardCode > 0 then
		local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.reward)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward1)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward2)
		self:_collectFirstPassRewardItemData(rewardLst, rewardCO.randomReward3)
	end

	return rewardLst
end

function M:getRewardLstNormal()
	return DungeonUtil.getRewardLstNormal(self._dungeonMo)
end

function M:getRewardLstRandom()
	return DungeonUtil.getRewardLstRandom(self._dungeonMo)
end

function M:_refreshRewardLstPanel(typ)
	local compG = self:getCompGroup(typ)

	if compG then
		goutil.clearChildren(compG.goLst)

		local rewardList = compG.getDataFunc and compG.getDataFunc(self) or {}
		local len = #rewardList

		if len > 0 then
			table.sort(rewardList, ItemUtil.commonSortFunc)

			for i, itemData in ipairs(rewardList) do
				local obj = self:getRewardItemPrefab()

				obj:SetActive(true)

				local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)

				goutil.addChildToParent(obj, compG.goLst)

				local rewardData = RewardData.New({
					code = itemData:getPrefabId() or itemData:getItemId(),
					count = itemData.count,
					rewardStatus = itemData.rewardStatus,
					itemSign = itemData.itemSign,
					name = itemData:getName()
				})

				objBeh:updateData(rewardData)
				objBeh:getComponent("cellComp"):setIsFackD6(true)
			end
		end

		goutil.setActive(compG.goRoot, len > 0)
	else
		printError(string.format("无法找到typ[%s]的组件组", typ))
	end
end

function M:_onClickReturn()
	settimer(0, self._dispatch, self, false)
	self:back()
end

function M:_dispatch()
	DungeonDispatcher:dispatchEvent(DungeonEventType.Reward_Detail_Click_Close)
end

function M:_fixLayOutConstraintCount(compG)
	local viewPort = self._scrollMiddlePanel.viewport
	local width = math.ceil(RectTransformUtils.GetWidth(viewPort))
	local verticalLayoutGroup = compG.goRoot:GetComponent(UIComponentType.VerticalLayoutGroup)

	width = width - verticalLayoutGroup.padding.left

	local gridLayoutGroup = compG.goLst:GetComponent(UIComponentType.GridLayoutGroup)
	local itemWidth = gridLayoutGroup.cellSize.x
	local itemSpacing = gridLayoutGroup.spacing.x
	local maxCount = 0
	local sizeCache = 0

	while sizeCache <= width do
		local needWidth = maxCount > 0 and itemWidth + itemSpacing or itemWidth

		if width >= sizeCache + needWidth then
			maxCount = maxCount + 1
		end

		sizeCache = sizeCache + needWidth
	end

	gridLayoutGroup.constraintCount = maxCount
end

return M
