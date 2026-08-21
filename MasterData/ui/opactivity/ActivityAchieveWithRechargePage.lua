-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityAchieveWithRechargePage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResItem = require("ClientData/ResItem")
local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local RechargeManager = require("System/Recharge/RechargeManager")
local AchieveWithRechargeCell = Class("AchieveWithRechargeCell", UIControls.ScrollViewLoopCell)

function AchieveWithRechargeCell:ctor()
	self.freeGrids = {}
	self.rechargeGrids = {}
	self.textRule = UIControls.Label(self, "TextRule")
	self.btnNmlGet = UIControls.Button(self, "BtnGet1")

	self.btnNmlGet:addEventClick(self.onNmlGetClick)

	self.btnRechargeGet = UIControls.Button(self, "BtnGet2")

	self.btnRechargeGet:addEventClick(self.onRechargeGetClick)

	self.aniCell = UIControls.UIAni(self, "")
end

function AchieveWithRechargeCell:setData(info, nmlState, rechargeState)
	self.data = info
	self.state = nmlState
	self.rechargeState = rechargeState
	self.miscInfo = self.mParent.miscInfo

	self.textRule:setText(info.desc_name or "")
	self.btnNmlGet:setVisible(nmlState == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.btnRechargeGet:setVisible(rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH)

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[2] then
		self.gridPrefabPath = self.mParent.replaceableCellPath[2]
	end

	ClientUtils.CreateActivityBonusGrid(self, self.freeGrids, "AwardFreePanel", info.award, self.gridPrefabPath)

	for _, grid in ipairs(self.freeGrids) do
		grid:setState(nmlState)
	end

	ClientUtils.CreateActivityBonusGrid(self, self.rechargeGrids, "AwardPaidPanel", info.recharge_award, self.gridPrefabPath)

	for _, grid in ipairs(self.rechargeGrids) do
		grid:setState(rechargeState)
	end

	if nmlState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self:playStateAnimator("NmlTaskPaidCell")
	elseif nmlState == Const.ACT_ACHIEVE_STATE_ENOUGH or rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self:playStateAnimator("HighTaskPaidCell")
	else
		self:playStateAnimator("DisTaskPaidCell")
	end
end

function AchieveWithRechargeCell:onNmlGetClick()
	if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.opId, self.data.index, self.data.type), self.mParent.opId)
	end
end

function AchieveWithRechargeCell:onRechargeGetClick()
	if self.rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.opId, self.data.index, self.data.type), self.mParent.opId)
	end
end

local AchieveOnlyRechargeCell = Class("AchieveOnlyRechargeCell", UIControls.ScrollViewLoopCell)

function AchieveOnlyRechargeCell:ctor()
	self.rechargeGrids = {}
	self.textRule = UIControls.Label(self, "TextRule")
	self.btnRechargeGet = UIControls.Button(self, "BtnConfirm")

	self.btnRechargeGet:addEventClick(self.onRechargeGetClick)

	self.aniCell = UIControls.UIAni(self, "")
	self.panelComplete = UIControls.Panel(self, "TxtReceive")
end

function AchieveOnlyRechargeCell:setData(info, nmlState, rechargeState)
	self.data = info
	self.rechargeState = rechargeState

	self.textRule:setText(info.desc_name or "")
	self.btnRechargeGet:setVisible(rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH)

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[2] then
		self.gridPrefabPath = self.mParent.replaceableCellPath[2]
	end

	ClientUtils.CreateActivityBonusGrid(self, self.rechargeGrids, "AwardPaidPanel", info.recharge_award, self.gridPrefabPath)

	for _, grid in ipairs(self.rechargeGrids) do
		grid:setState(rechargeState)
	end

	self.panelComplete:setVisible(rechargeState == Const.ACT_ACHIEVE_STATE_GOT)
	self.btnRechargeGet:setVisible(rechargeState ~= Const.ACT_ACHIEVE_STATE_GOT)
	self.btnRechargeGet:setEnable(rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH)

	if rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self:playStateAnimator("HighTaskPaidCell")
	elseif rechargeState == Const.ACT_ACHIEVE_STATE_GOT then
		self:playStateAnimator("DisTaskPaidCell")
	else
		self:playStateAnimator("NmlTaskPaidCell")
	end
end

function AchieveOnlyRechargeCell:onRechargeGetClick()
	if self.rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.opId, self.data.index, self.data.type), self.mParent.opId)
	end
end

local classNameStr = "ActivityAchieveWithRechargePage"
local ActivityAchieveWithRechargePage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityAchieveWithRechargePage, ActivityPanelMixin)

function ActivityAchieveWithRechargePage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.scrollItems = UIControls.ScrollViewLoopV(self, "InfoPanel/TaskPaidList", 0, self._onCellChanged)
	self.cells = {}
	self.panelPaid = UIControls.Panel(self, "InfoPanel/PaidPanel")
	self.textPaidBtn = UIControls.Label(self, "InfoPanel/PaidPanel/TextPrice")
	self.btnPaid = UIControls.Button(self, "InfoPanel/PaidPanel/BtnFunc")

	self.btnPaid:addEventClick(self.onPaidClick)

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "InfoPanel/PaidPanel/TextPrice/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "InfoPanel/PaidPanel/TextPrice/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function ActivityAchieveWithRechargePage:onPaidClick()
	RechargeManager.startRecharge(self.actObj.actData.connectRechargeId, nil, nil)
end

function ActivityAchieveWithRechargePage:_setData(pageData)
	self.opId = self.actObj.opId
	self.achData = {}

	local actData = self.actObj.actData
	local actId = self.actObj.actId

	for actType, cData in pairs(self.actObj.actData.clientData) do
		self.activityType = actType
		self.miscInfo = ResOpActivityAchieveMisc[actId][self.activityType]
		self.achData = cData

		break
	end

	self.maxTargetCellIdx = #self.achData - 3

	if self.achData[1] and self.achData[1].award then
		self.onlyRecharge = false
		self.cellClass = AchieveWithRechargeCell
	else
		self.onlyRecharge = true

		self.textTime:setVisible(false)

		self.textGiftTime = UIControls.Label(self, "InfoPanel/PaidPanel/BgTime/TextTime")

		local rechargeId = actData.connectRechargeId
		local lastTime = RechargeManager.getProductRemainTime(rechargeId)

		if lastTime then
			ClientTimerManager.AddSecondFormatTickUI(self.textGiftTime, lastTime, false, Lang.get(48655))
		else
			self.textGiftTime:setText("")
		end

		self.cellClass = AchieveOnlyRechargeCell
	end
end

function ActivityAchieveWithRechargePage:_onShow()
	if not self.actObj.actData.connectRechargeId then
		return
	end

	self.recharged = self.actObj.actData.hasRecharged == 1

	if self.recharged then
		self.panelPaid:setVisible(false)
	else
		self.panelPaid:setVisible(true)

		local product = RechargeManager.getProductByRechargeId(self.actObj.actData.connectRechargeId)

		if product then
			self.textPaidBtn:setText(product.priceText or Const.RECHARGE_PRICE_UNKNOWN)
		else
			self.textPaidBtn:setText(Const.RECHARGE_PRICE_UNKNOWN)
		end
	end

	for idx, data in ipairs(self.achData) do
		local state = self.actObj.actData:getAchieveState(self.activityType, idx)

		if state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH or state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			self.toGetCellIdx = idx

			break
		end

		state = self.actObj.actData:getAchieveState(self.activityType, idx, true)

		if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			self.toGetCellIdx = idx

			break
		end
	end

	local idx

	if self.toGetCellIdx then
		idx = self.toGetCellIdx - 2
		idx = idx <= 0 and 1 or idx
	end

	if idx and idx > self.maxTargetCellIdx then
		idx = self.maxTargetCellIdx
	end

	idx = idx and idx or self.maxTargetCellIdx
	self.targetCellIdx = idx

	self.scrollItems:setTotalCount(#self.achData, self.targetCellIdx)
end

function ActivityAchieveWithRechargePage:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		if self.replaceableCellPath and self.replaceableCellPath[1] then
			targetCell = self.cellClass(sender, self.replaceableCellPath[1], newIdx, 0, 0)
		else
			targetCell = self.cellClass(sender, "System/Activity/TaskPaidCell", newIdx, 0, 0)
		end
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	if self.toGetCellIdx and newIdx == self.toGetCellIdx then
		targetCell.isNextToGet = true
	else
		targetCell.isNextToGet = false
	end

	self.cells[newIdx] = targetCell

	self.cells[newIdx]:setData(self.achData[newIdx], self.actObj.actData:getAchieveState(self.activityType, newIdx), self.actObj.actData:getAchieveState(self.activityType, newIdx, true))
end

function ActivityAchieveWithRechargePage:onActivityDataRefresh(actObj)
	self:_onShow()
end

return ActivityAchieveWithRechargePage
