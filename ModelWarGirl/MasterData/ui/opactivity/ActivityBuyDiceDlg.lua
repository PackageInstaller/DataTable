-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBuyDiceDlg.lua

local BaseObject = require("Common/Object/BaseObject")
local ResItem = require("ClientData/ResItem")
local NumControlPanel = require("UI/MainState/Item/NumControlPanel")
local strClassName = "ActivityBuyDiceDlg"
local ActivityBuyDiceDlg = Class(strClassName, UIControls.Window)

function ActivityBuyDiceDlg:ctor()
	self.imgItem = UIControls.Image(self, "BgPanel/ItemPanel/Icon")
	self.textItem = UIControls.Label(self, "BgPanel/ItemPanel/BgName/TextName")
	self.numPanel = NumControlPanel(self, "BgPanel/NumPanel")
	self.numPanel.mEventNumChanged = Slot(self.onNumChanged, self)
	self.textCost = UIControls.Label(self, "BgPanel/CostPanel/TextNum")
	self.iconCost = UIControls.Image(self, "BgPanel/CostPanel/Icon")
	self.textCan = UIControls.Label(self, "BgPanel/TextNum")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickConfirm)

	self.btnDeny = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnDeny:addEventClick(self.onClickDeny)
end

function ActivityBuyDiceDlg:onNumChanged(num)
	self.nowNum = num

	self.textCost:setText(num * self.costNum)
end

local BUY_TYPE_MONOPOLY_NORMAL = 1

function ActivityBuyDiceDlg:setData(itemId, canBuyNum, moneyID, costNum, buyType, actOpId)
	self.buyType = BUY_TYPE_MONOPOLY_NORMAL
	self.actOpId = actOpId

	local iconPath = BaseObject.getItemIconPath(itemId)

	if iconPath then
		self.imgItem:setImage(iconPath[1], iconPath[2])
	end

	local itemData = ResItem[itemId]

	if itemData and itemData.name then
		self.textItem:setText(itemData.name)
	end

	self.moneyID = moneyID

	local moneyIcon = BaseObject.getItemIconPath(moneyID)

	if moneyIcon then
		self.iconCost:setImage(moneyIcon[1], moneyIcon[2])
	end

	self.costNum = costNum
	self.canBuyNum = canBuyNum

	if self.canBuyNum then
		self.textCan:setText(string.format(Lang.get(30610), self.canBuyNum))
	else
		self.textCan:setText("")
	end

	local buyMax = math.max(self.canBuyNum, 1)

	self.numPanel:onShow(buyMax, 1, Lang.get(132), Lang.get(30611))
end

function ActivityBuyDiceDlg:_doBuy()
	if self.buyType == BUY_TYPE_MONOPOLY_NORMAL then
		RPC.monopolyExchange(self.actOpId, "kDiceTypeNormal", self.nowNum)
	end

	self:setVisible(false)
end

function ActivityBuyDiceDlg:onClickConfirm()
	if self.canBuyNum and self.canBuyNum <= 0 then
		MsgManager.notice(Lang.get(30612))
	else
		ClientUtils.checkMoneyChange(self.moneyID, self.nowNum * self.costNum, Slot(self._doBuy, self), nil, true)
	end
end

function ActivityBuyDiceDlg:onClickDeny()
	self:setVisible(false)
end

return ActivityBuyDiceDlg
