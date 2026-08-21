-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\ChooseEquipPanel.lua

local strClassName = "BtnChooseEquipSet"
local BtnChooseEquipSet = Class(strClassName, UIControls.Child)

function BtnChooseEquipSet:ctor()
	self:initUI()
end

function BtnChooseEquipSet:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.txtName = UIControls.Label(self, "TextName")
	self.imgSelf = UIControls.Image(self, "Icon")
end

function BtnChooseEquipSet:onBtnSelfClick()
	self.mParent:onBtnSelectClick(self.btnSelf)
end

function BtnChooseEquipSet:setSuitInfo(suitInfo)
	self.suitInfo = suitInfo

	self.txtName:setText(self.suitInfo.name)
	self.imgSelf:setImage(UIConst.COMMON_ICON_PATH .. suitInfo.big_icon_path, suitInfo.big_icon)
end

local ChoosePanel = require("UI/MainState/Item/OpenChoose/ChoosePanel")
local ResRandClient = require("ClientData/ResRandClient")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local strClassName = "ChooseEquipPanel"
local ChooseEquipPanel = Class(strClassName, ChoosePanel)

function ChooseEquipPanel:ctor()
	self:_initUI()
end

function ChooseEquipPanel:_initUI()
	self.cells = {}
	self.txtTips = UIControls.Label(self, self.mPath .. "/TextTips")
end

function ChooseEquipPanel:setItem(itemGift)
	self.itemGift = itemGift

	self.txtTitle:setText(self.itemGift.name)
	self.txtTimes:setText(self.itemGift.num)

	for i, random_id in ipairs(self.itemGift.resData.extend_args3) do
		local suitId = ResRandClient[random_id].show_ids[1]
		local suitCell = BtnChooseEquipSet(self, self.mPath .. "/EquipList/Content", "System/Bag/BtnChooseEquipSet", 0, 0, true)

		suitCell:setSuitInfo(ResEquipSuit[suitId])

		self.cells[i] = suitCell
		self.btnList[i] = suitCell.btnSelf
		self.btnList[i].idx = i
	end

	self:onBtnSelectClick(self.btnList[1])
end

function ChooseEquipPanel:onBtnSelectClick(sender)
	for i, btn in ipairs(self.btnList) do
		self.btnList[i]:setEnable(sender ~= btn)

		if sender == btn then
			self.curSelectIdx = btn.idx

			self.txtTips:setText(self.cells[i].suitInfo.des)
		end
	end
end

return ChooseEquipPanel
