-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\BagGridAddDlg.lua

local ResBagMisc = require("ClientData/ResBagMisc")
local strClassName = "BagGridAddDlg"
local BagGridAddDlg = Class(strClassName, UIControls.Window)
local ConsumeTips = require("System/ConsumeTips")

function BagGridAddDlg:ctor()
	self:initUI()
end

function BagGridAddDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnClose:addEventClick(self.onCloseClick)

	self.txtGridNum = UIControls.Label(self, "BgPanel/TextGridNum")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "TextNum")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgIconMoney = UIControls.Image(self, "BgPanel/BtnConfirm/TextNum/IconMoney")
	self.txtUnlockNum = UIControls.Label(self, "BgPanel/NumPanel/TextNum")
	self.btnNumAdd = UIControls.Button(self, "BgPanel/NumPanel/BtnNumAdd")

	self.btnNumAdd:addEventClick(self.onBtnNumAddClick)

	self.btnNumMin = UIControls.Button(self, "BgPanel/NumPanel/BtnNumMin")

	self.btnNumMin:addEventClick(self.onBtnNumMinClick)

	self.txtTitle = UIControls.Label(self, "TextTitle")
end

function BagGridAddDlg:onBtnNumAddClick()
	if self.curAddTimes * self.bagGridInfo.slots + CurAvatar:getBagSize(self.bagType) < CurAvatar:getBagMaxSize(self.bagType) then
		local realPreSize = CurAvatar:getBagSize(self.bagType, true) + self.curAddTimes * self.bagGridInfo.slots

		for _, costInfo in ipairs(self.bagGridInfo.diamond_cost) do
			if realPreSize < costInfo.up_limit then
				self.totalCost = self.totalCost + costInfo.cost

				break
			end
		end

		self.curAddTimes = self.curAddTimes + 1

		self:refreshShow()
	else
		self.btnNumAdd:interruptHoldEvent()
		MsgManager.notice(Lang.get(30494))
	end
end

function BagGridAddDlg:onBtnNumMinClick()
	if self.curAddTimes > 1 then
		local realPreSize = CurAvatar:getBagSize(self.bagType, true) + self.curAddTimes * self.bagGridInfo.slots

		for _, costInfo in ipairs(self.bagGridInfo.diamond_cost) do
			if realPreSize <= costInfo.up_limit then
				self.totalCost = self.totalCost - costInfo.cost

				break
			end
		end

		self.curAddTimes = self.curAddTimes - 1

		self:refreshShow()
	else
		self.btnNumMin:interruptHoldEvent()
		MsgManager.notice(Lang.get(30495))
	end
end

function BagGridAddDlg:onBtnConfirmClick()
	ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, self.totalCost, Slot(self.showtips, self), self, nil, self.goRechargeCallback)
end

function BagGridAddDlg:showtips(...)
	ConsumeTips.showTipsDiamond(self.totalCost, Const.CONSUME_DIAMOND_UPGRADE_BAG, self.curAddTimes, Slot(self.bagSizeExtend, self))
end

function BagGridAddDlg:bagSizeExtend()
	RPC.bagSizeExtend(self.bagType, self.curAddTimes)
	self:setVisible(false)
end

function BagGridAddDlg:setBagType(bag_type)
	self.bagType = bag_type

	self.txtTitle:setText(string.format(Lang.get(30493), Const.BAG_TYPE_NAME[self.bagType]))

	local curMaxCount = CurAvatar:getBagSize(self.bagType)

	self.bagGridInfo = ResBagMisc[Const.BAG_TYPE_ID[self.bagType]]

	local totalMaxCount = CurAvatar:getBagMaxSize(self.bagType)
	local totalNum = totalMaxCount - curMaxCount
	local blankNum = CurAvatar:getBagBlankByBagType(self.bagType)

	self.txtGridNum:setText(utils.format(Lang.get(45547), blankNum, totalNum))

	local realPreSize = CurAvatar:getBagSize(self.bagType, true)

	for _, costInfo in ipairs(self.bagGridInfo.diamond_cost) do
		if realPreSize < costInfo.up_limit then
			self.totalCost = costInfo.cost

			break
		end
	end

	self.curAddTimes = 1

	local moneyID = Const.MONEY_TYPE2ID[Const.MONEY_TYPE_DIAMOND] or 0
	local moneyInfo = UIConst.MONEY_ID2INFO[moneyID]

	if moneyInfo then
		self.imgIconMoney:setImage(moneyInfo[1], moneyInfo[2])
	end

	self:refreshShow()
end

function BagGridAddDlg:refreshShow()
	self.txtUnlockNum:setText("+" .. self.curAddTimes * self.bagGridInfo.slots)
	self.btnConfirm:setText(self.totalCost)
end

function BagGridAddDlg:onCloseClick()
	self:setVisible(false)
end

function BagGridAddDlg:setGoRechargeCallback(cb)
	self.goRechargeCallback = cb
end

return BagGridAddDlg
