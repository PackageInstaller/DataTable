-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\ConfirmPrivilegePanel.lua

local CommonCostPanel = require("UI/Common/CommonCostPanel")
local ResShopExchg = require("ClientData/ResShopExchg")
local strClassName = "ConfirmPrivilegePanel"
local ConfirmPrivilegePanel = Class(strClassName, UIControls.Panel)

function ConfirmPrivilegePanel:ctor()
	self:initUI()
end

function ConfirmPrivilegePanel:initUI()
	self.panelCost = CommonCostPanel(self, self.mPath .. "/BtnConfirm/CostPanel")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgIcon = UIControls.Image(self, self.mPath .. "/Icon")
end

function ConfirmPrivilegePanel:setPrivilegeInfo(priId, callBack)
	self.priId = priId
	self.callBack = callBack

	local shopItemId = Const.PRIVILEGE_SHOP_ITEM_ID_DIC[self.priId]

	if shopItemId and ResShopExchg[shopItemId].exchg and ResShopExchg[shopItemId].exchg[1] and ResShopExchg[shopItemId].exchg[1].key then
		local shopResInfo = ResShopExchg[shopItemId]

		if shopResInfo and shopResInfo.exchg and shopResInfo.exchg[1].key then
			local itemId = shopResInfo.exchg[1].key
			local moneyInfo = ClientUtils.getMoneyIcon(itemId)

			if moneyInfo then
				self.imgIcon:setImage(moneyInfo[1], moneyInfo[2])
			end
		end

		if shopResInfo.use and shopResInfo.use[1] then
			self.panelCost:setItem(shopResInfo.use[1].ID, shopResInfo.use[1].discount or 0)
		end
	end

	if self.priId == Const.EQUIP_OFF_PRIVILEGE_ID then
		self.txtTitle:setText(ClientUtils.getClientNotice(424))
	end
end

function ConfirmPrivilegePanel:onBtnConfirmClick()
	if self.callBack then
		self.callBack()
	end

	self.mWindow:setVisible(false)
end

return ConfirmPrivilegePanel
