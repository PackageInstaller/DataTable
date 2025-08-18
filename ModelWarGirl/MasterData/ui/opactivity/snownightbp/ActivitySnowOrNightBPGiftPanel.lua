-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SnowNightBP\\ActivitySnowOrNightBPGiftPanel.lua

local ActivityBPGiftPage = require("UI/OpActivity/ActivityBPGiftPage")
local RechargeManager = require("System/Recharge/RechargeManager")
local SnowOrNightBPGiftItem = require("UI/OpActivity/SnowNightBp/SnowOrNightBPGiftItem")
local strClassName = "ActivitySnowOrNightBPGiftPanel"
local ActivitySnowOrNightBPGiftPanel = Class(strClassName, ActivityBPGiftPage)

function ActivitySnowOrNightBPGiftPanel:initUI()
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cells = {}
	self.scrollItems = UIControls.ScrollViewLoopV(self, "TaskPaidList", 0, self._onCellChanged)
end

function ActivitySnowOrNightBPGiftPanel:_setData()
	self.actData = self.actObj.actData

	if not self.achieveToGift then
		self:setAchieveToGift()
	end

	if not self.objGift then
		self.objGift = {}

		local relateId = self.actObj.templateData.relate_act and self.actObj.templateData.relate_act[1]

		if relateId then
			self.objGift = CurAvatar:getActivityObj(relateId)
		end
	end

	self.cellsData = self.actData:getGiftAchieveDataList()

	table.sort(self.cellsData, function(a, b)
		return a.param < b.param
	end)
end

function ActivitySnowOrNightBPGiftPanel:setTarget(noRefreshAll)
	ActivitySnowOrNightBPGiftPanel.super.setTarget(self, noRefreshAll)

	if self.actData.cacheNewUnlockGift then
		for idx, bpGiftCell in pairs(self.bpGiftCells) do
			if idx == self.actData.cacheNewUnlockGift then
				bpGiftCell:setPayPartLockShow()
				bpGiftCell:playUnlock()
			end
		end

		self.actData:setNewUnlockGift()

		local activitySnowOrNightBPDlg = UIManager.getUI("activitySnowOrNightBPDlg", nil, false)

		if activitySnowOrNightBPDlg then
			activitySnowOrNightBPDlg.iconGiftNewOpen:setVisible(false)
		end

		self.actObj:checkNew()
	end
end

function ActivitySnowOrNightBPGiftPanel:getTargetPoint()
	local targetIndex = self.actObj.actData.cacheNewUnlockGift

	if targetIndex == nil then
		for i, data in ipairs(self.cellsData) do
			local rechargeId = self.achieveToGift[data.type] and self.achieveToGift[data.type][data.index] and self.achieveToGift[data.type][data.index][1] or nil

			if rechargeId then
				local svrDataGift = self.objGift.actData.serverData[rechargeId]
				local count = svrDataGift and svrDataGift.count or 0
				local product = RechargeManager.getProductByRechargeId(rechargeId)
				local canBuyCount = product.buyTimesMax - count

				if canBuyCount > 0 then
					targetIndex = i

					break
				end
			end
		end
	end

	if targetIndex and targetIndex > 1 then
		return targetIndex - 1
	else
		return 1
	end
end

function ActivitySnowOrNightBPGiftPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		local prefabFolderPath = "System/Activity/ActivitySnowOrNightBP12204"

		if self.replaceableCellPath and self.replaceableCellPath[1] then
			prefabFolderPath = "System/Activity/" .. self.replaceableCellPath[1]
		end

		targetCell = SnowOrNightBPGiftItem(sender, prefabFolderPath .. "/SnowOrNightBPGiftItem", newIdx, 0, 0)
		targetCell.mEventClickFree = Slot(self.onBtnFreeClick, self)
		targetCell.mEventClickPay = Slot(self.onBtnPayClick, self)
	else
		self.bpGiftCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.bpGiftCells[newIdx] = targetCell

	local clientData = self.cellsData[newIdx]
	local rechargeId

	if self.achieveToGift[clientData.type] and self.achieveToGift[clientData.type][clientData.index] then
		rechargeId = self.achieveToGift[clientData.type][clientData.index][1]
	end

	self.bpGiftCells[newIdx]:setData(clientData, self.actData, self.objGift, rechargeId, self.cellsData[newIdx - 1], newIdx)
end

function ActivitySnowOrNightBPGiftPanel:onBtnCloseClick()
	self.mWindow:setVisible(false)
end

return ActivitySnowOrNightBPGiftPanel
