-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\PrivilegeMonthCardResultDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResRecharge = require("ClientData/ResRecharge")
local ResCardClient = require("ClientData/ResCardClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResPrivilege = require("ClientData/ResPrivilege")
local PrivilegeMonthCardResultCell = Class("PrivilegeMonthCardResultCell", UIControls.Child)

function PrivilegeMonthCardResultCell:ctor(...)
	self:initUI()
end

function PrivilegeMonthCardResultCell:initUI(...)
	self.imgIcon = UIControls.Image(self, "Icon")
	self.imgSel = UIControls.Image(self, "ImgSel")
	self.btnStorePrivilege = UIControls.Button(self, "BtnStorePrivilege")

	self.btnStorePrivilege:addEventClick(self.onBtnStorePrivilegeClick)
end

function PrivilegeMonthCardResultCell:setObj(item)
	self.object = item

	if item.resData and item.resData.extend_args1 and ResPrivilege[item.resData.extend_args1] then
		local resData = ResPrivilege[item.resData.extend_args1]

		if resData.desc then
			self.desc = resData.desc
		end

		if resData.icon and resData.icon_path then
			self.imgIcon:setVisible(true)
			self.imgIcon:setImage("Atlas/StoreAtlas/" .. resData.icon_path, resData.icon)
		end
	end
end

function PrivilegeMonthCardResultCell:setSelect(flag)
	self.imgSel:setVisible(flag)
end

function PrivilegeMonthCardResultCell:onBtnStorePrivilegeClick()
	if self.mEventClick then
		self.mEventClick(self)
	end
end

local strClassName = "PrivilegeMonthCardResultDlg"
local PrivilegeMonthCardResultDlg = Class(strClassName, UIControls.Window)

function PrivilegeMonthCardResultDlg:ctor(...)
	self:initUI()
end

function PrivilegeMonthCardResultDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.icon = UIControls.Image(self, "Bg/Icon")
	self.imgGet = UIControls.Image(self, "Bg/AwardPanel/EverydayAwardPanel/ImgGet")
	self.panelBuyAward = UIControls.Panel(self, "Bg/AwardPanel/BuyAwardPanel")
	self.gridItems = {}
	self.privilegeAwardItems = {}
	self.hasDayAwards = false
	self.recharge2id = {}

	for _, data in pairs(ResCardClient) do
		for _, rId in ipairs(data.recharge_id or {}) do
			self.recharge2id[rId] = data
		end
	end

	self._slot4ClickCell = Slot(self.onCellClick, self)
	self.privilegeAttrInfoPanel = UIControls.Image(self, "Bg/PrivilegeAttrInfoPanel")
	self.txtPrivilege = UIControls.Label(self, "Bg/PrivilegeAttrInfoPanel/Text")
end

function PrivilegeMonthCardResultDlg:setData(rechargeId, normalAwards, dayAwards, closeCB)
	self.closeCB = closeCB

	local data = self.recharge2id[rechargeId]

	self.icon:setImage(data.icon_path, data.icon_icon)

	local rechargeData = ResRecharge[rechargeId]

	if rechargeData.result_title then
		self.txtTitle:setText(rechargeData.result_title)
	else
		self.txtTitle:setText(string.format(Lang.get(51871), rechargeData.product_name))
	end

	for _, itemN in ipairs(self.gridItems) do
		itemN:setVisible(false)
	end

	for _, itemD in ipairs(self.privilegeAwardItems) do
		itemD:setVisible(false)
	end

	local products = {}

	if data.recharge_id then
		for _, recharge_id in ipairs(data.recharge_id) do
			local product = RechargeManager.getProductByRechargeId(recharge_id)

			if product then
				table.insert(products, product)
			end
		end
	end

	local normalIndex = 0
	local privilegeIndex = 0

	for _, product in ipairs(products) do
		local buyAwardData = ResRandClient[product.randId]

		for idx, award in ipairs(buyAwardData.show_nums) do
			local obj = BaseObject.GetObject(buyAwardData.show_ids[idx], buyAwardData.show_nums[idx])

			if obj then
				if obj.subType then
					if obj.subType == Const.ITEM_STYPE_PRIVILEGE then
						privilegeIndex = privilegeIndex + 1

						if not self.privilegeAwardItems[privilegeIndex] then
							self.privilegeAwardItems[privilegeIndex] = PrivilegeMonthCardResultCell(self, "Bg/AwardPanel/EverydayAwardPanel", "System/Store/BtnStorePrivilege")
						end

						self.privilegeAwardItems[privilegeIndex].index = privilegeIndex

						self.privilegeAwardItems[privilegeIndex]:setVisible(true)
						self.privilegeAwardItems[privilegeIndex]:setObj(obj)

						self.privilegeAwardItems[privilegeIndex].mEventClick = self._slot4ClickCell
					elseif obj.subType == Const.ITEM_STYPE_TIMEAPPEND then
						if obj.resData and obj.resData.extend_args1 then
							local relaObj = BaseObject.GetObject(obj.resData.extend_args1)

							if relaObj then
								normalIndex = normalIndex + 1

								if not self.gridItems[normalIndex] then
									self.gridItems[normalIndex] = UIControls.getGridChild(relaObj, self, "Bg/AwardPanel/BuyAwardPanel")
								end

								self.gridItems[normalIndex]:setVisible(true)
								self.gridItems[normalIndex]:setObj(relaObj)

								self.gridItems[normalIndex].mDisableWays = true
							end
						end
					else
						normalIndex = normalIndex + 1

						if not self.gridItems[normalIndex] then
							self.gridItems[normalIndex] = UIControls.getGridChild(obj, self, "Bg/AwardPanel/BuyAwardPanel")
						end

						self.gridItems[normalIndex]:setVisible(true)
						self.gridItems[normalIndex]:setObj(obj)

						self.gridItems[normalIndex].mDisableWays = true
					end
				else
					normalIndex = normalIndex + 1

					if not self.gridItems[normalIndex] then
						self.gridItems[normalIndex] = UIControls.getGridChild(obj, self, "Bg/AwardPanel/BuyAwardPanel")
					end

					self.gridItems[normalIndex]:setVisible(true)
					self.gridItems[normalIndex]:setObj(obj)

					self.gridItems[normalIndex].mDisableWays = true
				end
			end
		end
	end
end

function PrivilegeMonthCardResultDlg:onCellClick(sender)
	for index, grid in ipairs(self.privilegeAwardItems) do
		self.privilegeAwardItems[index]:setSelect(index == sender.index)
	end

	self.privilegeAttrInfoPanel:setVisible(true)
	self.txtPrivilege:setText(sender.desc)
end

function PrivilegeMonthCardResultDlg:onClose(...)
	PrivilegeMonthCardResultDlg.super.onClose(self)
end

return PrivilegeMonthCardResultDlg
