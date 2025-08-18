-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\BuyCapacityDlg.lua

local ResPowerMisc = require("ClientData/ResPowerMisc")
local ResStageMisc = require("ClientData/ResStageMisc")
local ResRandClient = require("ClientData/ResRandClient")
local ResPower = require("ClientData/ResPower")
local ResItem = require("ClientData/ResItem")
local RecoverItemGridContainer = Class("RecoverItemGridContainer", UIControls.GridMultiContainerChild)
local ConsumeTips = require("System/ConsumeTips")
local BUY_TYPE_POWER = 1
local BUY_TYPE_STAGE_ENERGY = 2

function RecoverItemGridContainer:setObj(item)
	RecoverItemGridContainer.super.setObj(self, item)
	self.grid:setIconGray(self.grid.object.num <= 0)
end

local strClassName = "BuyUseItemPanel"
local BuyUseItemPanel = Class(strClassName, UIControls.Panel)

function BuyUseItemPanel:ctor()
	self:initUI()
end

function BuyUseItemPanel:initUI()
	self.btnFunc = UIControls.Button(self, self.mPath .. "/BtnFunc")

	self.btnFunc:addEventClick(self.onBtnFuncClick)

	self.txtCanGetNum = UIControls.Label(self, "Bg/UseItemPanel/GetPanel/TextNum")
	self.imgGetItem = UIControls.Image(self, "Bg/UseItemPanel/GetPanel/Icon")
	self.useItemDic = {}
	self.containerList = {}
end

function BuyUseItemPanel:initItemData(buyType)
	self.buyType = buyType

	local items = {}
	local moneyInfo = ClientUtils.getMoneyIcon(Const.MONEY_ID_POWER)

	if self.buyType == BUY_TYPE_STAGE_ENERGY then
		items = ResStageMisc[1].recover_item_ids
		moneyInfo = ClientUtils.getMoneyIcon(Const.MONEY_ID_STAGE_ENERGY)
	else
		items = ResPowerMisc[1].recover_item_ids
	end

	self.imgGetItem:setImage(moneyInfo[1], moneyInfo[2])

	for _, itemId in ipairs(items) do
		local gridContainer = RecoverItemGridContainer(self, "Bg/UseItemPanel/ItemPanel", "System/Common/Grid/GridMultiContainer", 0, 0, true)
		local item = BaseObject.GetObject(itemId, CurAvatar:getItemNumById(itemId))

		gridContainer:setObj(item)
		gridContainer:setSelectCallback(Slot(self.selectMaterial, self))
		table.insert(self.containerList, gridContainer)
	end

	self:refreshUseItemPanel()
end

function BuyUseItemPanel:selectMaterial(sender, isAdd)
	local item = sender.grid.object

	if not self.useItemDic[item.id] then
		self.useItemDic[item.id] = 0
	end

	local plusNum = isAdd and 1 or -1

	self.useItemDic[item.id] = self.useItemDic[item.id] + plusNum

	if self.useItemDic[item.id] <= 0 then
		self.useItemDic[item.id] = nil
	end

	self:refreshUseItemPanel()
end

function BuyUseItemPanel:refreshUseItemPanel()
	self.totalWillGet = 0

	for itemId, count in pairs(self.useItemDic) do
		local addValue = ResRandClient[ResItem[itemId].extend_args3[1]].show_nums[1]

		self.totalWillGet = self.totalWillGet + addValue * count
	end

	self.txtCanGetNum:setText(self.totalWillGet)
end

function BuyUseItemPanel:clearUseItemPanel()
	for _, gridContainer in ipairs(self.containerList) do
		gridContainer:clearSelect()
	end

	self.useItemDic = {}

	self:refreshUseItemPanel()
end

function BuyUseItemPanel:onBtnFuncClick()
	if self.totalWillGet <= 0 then
		MsgManager.clientNotice(183)
	elseif self.buyType == BUY_TYPE_POWER and self.totalWillGet + CurAvatar.realPowerNum >= ResPowerMisc[1].power_max then
		MsgManager.clientNotice(186)
	else
		local useList = {}

		for itemId, count in pairs(self.useItemDic) do
			local use = {}

			use.id = itemId
			use.num = count

			table.insert(useList, {
				data = use
			})
		end

		RPC.itemUse(useList)
		self.mWindow:setVisible(false)
	end
end

local strClassName = "BuyUseDiamondPanel"
local BuyUseDiamondPanel = Class(strClassName, UIControls.Panel)

function BuyUseDiamondPanel:ctor()
	self:initUI()
end

function BuyUseDiamondPanel:initUI()
	self.btnFunc = UIControls.Button(self, self.mPath .. "/BtnFunc")

	self.btnFunc:addEventClick(self.onBtnFuncClick)

	self.txtCounterLimit = UIControls.Label(self, "Bg/BuyPanel/LimitPanel/TextLimit")
	self.txtRefreshTime = UIControls.Label(self, "Bg/BuyPanel/LimitPanel/Time")
	self.txtCanGetNum = UIControls.Label(self, "Bg/BuyPanel/GetPanel/TextNum")
	self.txtWillCostDiamond = UIControls.Label(self, "Bg/BuyPanel/CostPanel/TextNum")

	self:initUseDiamondPanel()
	self:refreshUseDiamondPanel()
end

function BuyUseDiamondPanel:initUseDiamondPanel()
	if ClientUtils.getServerTime() < ClientUtils.getServerTimeNextDay() then
		local remainTime = ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime() + 5

		ClientTimerManager.AddSecondFormatTickUI(self.txtRefreshTime, remainTime, false, Lang.get(48660), Slot(self.timeDownCallBack, self))
	end
end

function BuyUseDiamondPanel:timeDownCallBack()
	self.delayTimer = Timer.New(Slot(self._delayRefreshUseDiamondPanel, self), 1, 1)

	self.delayTimer:Start()
end

function BuyUseDiamondPanel:_delayRefreshUseDiamondPanel()
	self:refreshUseDiamondPanel()
	self:initUseDiamondPanel()
end

function BuyUseDiamondPanel:refreshUseDiamondPanel()
	local remainTimes = CurAvatar:getPowerBuyMaxCount() - CurAvatar:getPowerCounter(Const.DayPowerCountId)

	self.txtCounterLimit:setText(utils.format(Lang.get(30201), remainTimes, CurAvatar:getPowerBuyMaxCount()))

	local buyPowerInfo = ResPower[CurAvatar:getPowerCounter(Const.DayPowerCountId)]

	if remainTimes > 0 and ResPower[CurAvatar:getPowerCounter(Const.DayPowerCountId) + 1] then
		buyPowerInfo = ResPower[CurAvatar:getPowerCounter(Const.DayPowerCountId) + 1]
	end

	self.totalWillGet = buyPowerInfo.award

	self.txtCanGetNum:setText(self.totalWillGet)

	self.willCostDiamond = buyPowerInfo.cost

	self.txtWillCostDiamond:setText(self.willCostDiamond)
end

function BuyUseDiamondPanel:onBtnFuncClick()
	if self.totalWillGet + CurAvatar.realPowerNum >= ResPowerMisc[1].power_max then
		MsgManager.clientNotice(186)
	elseif CurAvatar:getPowerBuyMaxCount() - CurAvatar:getPowerCounter(Const.DayPowerCountId) <= 0 then
		MsgManager.clientNotice(187)
	else
		ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, self.willCostDiamond, Slot(self.buyFishBoneTips, self), self.mParent, true)
	end
end

function BuyUseDiamondPanel:buyFishBoneTips(...)
	ConsumeTips.showTipsDiamond(self.willCostDiamond, Const.CONSUME_DIAMOND_BUY_FISHBONE, 1, Slot(self.buyPowerByDiamond, self))
end

function BuyUseDiamondPanel:buyPowerByDiamond()
	RPC.powerExchange()
end

local strClassName = "BuyCapacityDlg"
local BuyCapacityDlg = Class(strClassName, UIControls.Window)

function BuyCapacityDlg:ctor()
	self:initUI()
end

function BuyCapacityDlg:initUI()
	self.textTitle = UIControls.Label(self, "Bg/TitlePanel/TextTitle")
	self.txtRemainTime = UIControls.Label(self, "Bg/TitlePanel/TextTime")
	self.btnTapItem = UIControls.Button(self, "Bg/TabPanel/BtnTab1")

	self.btnTapItem:addEventClick(self.onBtnTapItemClick)

	self.btnTapDiamond = UIControls.Button(self, "Bg/TabPanel/BtnTab2")

	self.btnTapDiamond:addEventClick(self.onBtnDiamondClick)

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelUseItem = BuyUseItemPanel(self, "Bg/UseItemPanel")
	self.panelUseDiamond = BuyUseDiamondPanel(self, "Bg/BuyPanel")
end

function BuyCapacityDlg:initBuyType(buyType)
	if buyType == BUY_TYPE_STAGE_ENERGY then
		self.buyType = BUY_TYPE_STAGE_ENERGY

		self.textTitle:setText(Lang.get(30203))
		self.btnTapDiamond:setVisible(false)
		self:onBtnTapItemClick()
	else
		self.buyType = BUY_TYPE_POWER

		self.textTitle:setText(Lang.get(845))
		self.btnTapDiamond:setVisible(true)

		local haveRecoverItem = false

		for _, itemId in ipairs(ResPowerMisc[1].recover_item_ids) do
			if CurAvatar:getItemNumById(itemId) > 0 then
				haveRecoverItem = true

				break
			end
		end

		if haveRecoverItem then
			self:onBtnTapItemClick()
		else
			self:onBtnDiamondClick()
		end
	end

	self.panelUseItem:initItemData(self.buyType)
	self:refreshBuyPowerShow()
end

function BuyCapacityDlg:refreshBuyPowerShow()
	if self.buyType == BUY_TYPE_POWER and CurAvatar.realPowerNum < CurAvatar:getPowerResumeMax() then
		local oldValue = CurAvatar:getMoneyByType(Const.MONEY_TYPE_POWER)
		local totalRecoverTime = (CurAvatar:getPowerResumeMax() - oldValue) * CurAvatar:getPowerResumeSeconds()
		local remainTime = CurAvatar.powerResumeTime + totalRecoverTime - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtRemainTime, remainTime, false, Lang.get(48661), Slot(self.timeDownCallBack, self))
	elseif self.buyType == BUY_TYPE_STAGE_ENERGY and CurAvatar.realEnergyNum < Const.ENERGY_MAX then
		local oldValue = CurAvatar:getMoneyByType(Const.MONEY_TYPE_ENERGY)
		local totalRecoverTime = (Const.ENERGY_MAX - oldValue) * Const.ENERGY_RECOVERY_TIME
		local remainTime = CurAvatar.energyResumeTime + totalRecoverTime - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtRemainTime, remainTime, false, Lang.get(48661), Slot(self.timeDownCallBack, self))
	else
		self:timeDownCallBack()
		ClientTimerManager.RemoveSecondTickUI(self.txtRemainTime)
	end
end

function BuyCapacityDlg:timeDownCallBack()
	self.txtRemainTime:setText(Lang.get(30205))
end

function BuyCapacityDlg:onClose(...)
	if self.panelUseDiamond.delayTimer then
		self.panelUseDiamond.delayTimer:Stop()
	end

	BuyCapacityDlg.super.onClose(self)
end

function BuyCapacityDlg:onBtnCloseClick()
	self:setVisible(false)
end

function BuyCapacityDlg:onBtnTapItemClick()
	self.panelUseItem:setVisible(true)
	self.panelUseDiamond:setVisible(false)
	self.btnTapItem:setEnable(false)
	self.btnTapDiamond:setEnable(true)
end

function BuyCapacityDlg:onBtnDiamondClick()
	self.panelUseDiamond:setVisible(true)
	self.panelUseItem:setVisible(false)
	self.btnTapItem:setEnable(true)
	self.btnTapDiamond:setEnable(false)
end

return BuyCapacityDlg
