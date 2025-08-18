-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\ConsumeEquipTipsDlg.lua

local SingleEquipTipsChild = require("UI/Common/Tips/SingleEquipTipsChild")
local ResEquipReturn = require("ClientData/ResEquipReturn")
local ResClientNotice = require("ClientData/ResClientNotice")
local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local strClassName = "ConsumeEquipTipsDlg"
local ConsumeEquipTipsDlg = Class(strClassName, UIControls.Tips)

function ConsumeEquipTipsDlg:ctor()
	self:initUI()
end

function ConsumeEquipTipsDlg:initUI()
	self.panelEquipInfo = SingleEquipTipsChild(self, "BgMain/EquipInfo", "System/Hero/EquipInfoConfirmPanel", 0, 0, true)
	self.txtConfirm = UIControls.Label(self, "BgMain/TxtConfirm")
	self.txtReturn = UIControls.Label(self, "BgMain/BgReturn/ItemReturnPanel/TextReturn")
	self.bgReturn = UIControls.Panel(self, "BgReturn")
	self.btnConfirm = UIControls.Button(self, "BgMain/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnDeny = UIControls.Button(self, "BgMain/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)
end

function ConsumeEquipTipsDlg:setData(grid, content, yesFunc, isShowReturn)
	self.yesFunc = yesFunc
	self.grid = grid
	self.equip = grid.object
	self.equipList = self.equip.equipList

	self.panelEquipInfo:setItem(self.equip, self.equipList)
	self.bgReturn:setVisible(isShowReturn)
	self.txtConfirm:setText(content)

	if isShowReturn then
		self.txtReturn:setText(ResClientNotice[617].notice)

		self.returnGridList = {}

		local evoReturnData = ResEquipReturn[self.grid.object.evolve][self.grid.object.part]

		for i, v in ipairs(evoReturnData.ret_item or {}) do
			local returnGrid = UIControls.ItemGridChild(self, "BgMain/BgReturn/ItemReturnPanel/ItemReturn", "System/Common/Grid/GridMaterialItem", 0, 0, true)
			local item = BaseObject.GetObject(v.id, v.num)

			returnGrid:setObj(item)

			if returnGrid.btnSensor then
				returnGrid.btnSensor:setEnable(false)
			end
		end
	end
end

function ConsumeEquipTipsDlg:onBtnConfirmClick(sender)
	if self.yesFunc ~= nil then
		self.yesFunc()
	end

	self:setVisible(false)
end

function ConsumeEquipTipsDlg:onBtnDenyClick(sender)
	self:setVisible(false)
end

return ConsumeEquipTipsDlg
