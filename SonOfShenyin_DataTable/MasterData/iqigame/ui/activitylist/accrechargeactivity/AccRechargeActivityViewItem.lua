-- chunkname: @IQIGame\\UI\\ActivityList\\AccRechargeActivity\\AccRechargeActivityViewItem.lua

local Item = {
	rewardItems = {}
}

function Item.New(gameObject)
	local obj = Clone(Item)

	obj:__Init(gameObject)

	return obj
end

function Item:__Init(gameObject)
	self.view = gameObject

	LuaCodeInterface.BindOutlet(self.view, self)
	ForTransformChild(self.ItemRoot.transform, function(_trans, _index)
		local itemCell = ItemCell.New(_trans.gameObject, true, true, true)

		itemCell.showMoneyNum = true

		table.insert(self.rewardItems, itemCell)
	end)
	UIEventUtil.AddClickEventListener_Button(self, "CanReceiveBtn", self.__OnCanReceiveBtnClickHandler)
end

function Item:__OnCanReceiveBtnClickHandler()
	if self.state ~= Constant.RechargeActivityItemState.Open then
		return
	end

	ActivityModule.GetActivityRechargeRewards(self.activityChargeData.Activityid, self.activityChargeData.Id)
end

function Item:Show(activityChargeData)
	self.activityChargeData = activityChargeData

	local activityPOD = ActivityModule.GetActivityPodByID(activityChargeData.Activityid)

	self.state = self:__GetRechargeActivityItemState(activityChargeData, activityPOD)

	self.ReceivedBg.gameObject:SetActive(self.state == Constant.RechargeActivityItemState.Finished)
	self.ReceivedMask.gameObject:SetActive(self.state == Constant.RechargeActivityItemState.Finished)
	self.ReceivedRoot.gameObject:SetActive(self.state == Constant.RechargeActivityItemState.Finished)
	self.CanReceiveBg.gameObject:SetActive(self.state == Constant.RechargeActivityItemState.Open)
	self.CanReceiveBtn.gameObject:SetActive(self.state == Constant.RechargeActivityItemState.Open)
	self.NormalBtn.gameObject:SetActive(self.state == Constant.RechargeActivityItemState.Disable)

	self.TitleText:GetComponent("Text").text = string.format("累计充值%s元", activityChargeData.RechargeLevel)

	local cellIndex = 1

	ForArrayCustomStep(activityChargeData.Prizes, function(_index, _itemCid)
		local itemCnt = TryToNumber(activityChargeData.Prizes[_index + 1], 0)

		if itemCnt == 0 then
			return true
		end

		local itemCell = self.rewardItems[cellIndex]

		if itemCell == nil then
			return true
		end

		itemCell:SetItemByCid(_itemCid, itemCnt)
		itemCell:Show()

		cellIndex = cellIndex + 1
	end, 2)
	ForArray(self.rewardItems, function(_index, _itemCell)
		if _index < cellIndex then
			return
		end

		_itemCell:Hide()
	end)
end

function Item:__GetRechargeActivityItemState(activityChargeData, activityPOD)
	if activityPOD == nil then
		return Constant.RechargeActivityItemState.Disable
	end

	if activityPOD.activityRecharge == nil then
		return Constant.RechargeActivityItemState.Disable
	end

	if activityChargeData.RechargeLevel > activityPOD.activityRecharge.totalRecharge then
		return Constant.RechargeActivityItemState.Disable
	end

	if ValueInArray(activityPOD.activityRecharge.getRewardsList, activityChargeData.Id) then
		return Constant.RechargeActivityItemState.Finished
	end

	return Constant.RechargeActivityItemState.Open
end

function Item:HasUnclaimedRewards(activityId)
	if not ActivityModule.IsOpenByTime(activityId) then
		return false
	end

	local activityPOD = ActivityModule.GetActivityPodByID(activityId)

	if not activityPOD or not activityPOD.activityRecharge then
		return false
	end

	local dataList = {}

	ForPairs(CfgActivityChargeTable, function(_cid, _cfg)
		if _cfg.Activityid == activityId then
			table.insert(dataList, _cfg)
		end
	end)

	for _, cfg in ipairs(dataList) do
		local state = self:__GetRechargeActivityItemState(cfg, activityPOD)

		if state == Constant.RechargeActivityItemState.Open then
			return true
		end
	end

	return false
end

function Item:Dispose()
	UIEventUtil.ClearEventListener(self)
	ForPairs(self.rewardItems, function(k, v)
		v:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return Item
