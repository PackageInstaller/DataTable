-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\ChooseEquipDefinePanel.lua

local strClassName = "BtnChooseEquipTemplete"
local BtnChooseEquipTemplete = Class(strClassName, UIControls.Child)

function BtnChooseEquipTemplete:ctor()
	self:initUI()
end

function BtnChooseEquipTemplete:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
	self.btnTips:setVisible(false)
end

function BtnChooseEquipTemplete:onBtnSelfClick()
	self.mParent:onBtnSelectClick(self.btnSelf)
end

function BtnChooseEquipTemplete:setEquipTemplete(equipTemplete)
	self.equipTemplete = equipTemplete
	self.equipTempleteGrid = UIControls.EquipTempleteGridChild(self, "GridEquipItemPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)

	self.equipTempleteGrid:setObj(self.equipTemplete)
end

function BtnChooseEquipTemplete:onBtnTipsClick()
	UIManager.getUI("equipTempleteTips"):show(self.equipTempleteGrid)
end

local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local EquipTipsStrenghPanel = require("UI/Common/Tips/EquipTipsStrenghPanel")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local strClassName = "ChooseEquipTipsPanel"
local ChooseEquipTipsPanel = Class(strClassName, UIControls.Panel)

function ChooseEquipTipsPanel:ctor()
	self:initUI()
end

function ChooseEquipTipsPanel:initUI()
	self.txtEquipName = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.panelStress = EquipTipsStrenghPanel(self, self.mPath .. "/StrengthPanel")
	self.panelSuit = UIControls.Image(self, self.mPath .. "/SuitPanel")
	self.txtRandSuit = UIControls.Label(self, self.mPath .. "/SuitPanel/TextTitle")
	self.suitPanels = {}

	for i = 1, 4 do
		local suitPanel = UIControls.Panel(self, self.mPath .. "/SuitPanel/SuitPanel" .. i)
		local imgSuit = UIControls.Image(self, self.mPath .. "/SuitPanel/SuitPanel" .. i .. "/Icon")
		local txtSuit = UIControls.Label(self, self.mPath .. "/SuitPanel/SuitPanel" .. i .. "/Text")

		table.insert(self.suitPanels, {
			imgSuit,
			txtSuit,
			suitPanel
		})
	end

	self.attrList = {}

	for i = 1, 2 do
		local attrPanel = HeroAttrPanel(self, self.mPath .. "/AttrPanel/Attr0" .. i)

		table.insert(self.attrList, attrPanel)
	end
end

function ChooseEquipTipsPanel:setEquipTemplete(equipTemplete)
	self.equipTemplete = equipTemplete

	self.txtEquipName:setText(self.equipTemplete.name)
	self.panelSuit:setVisible(self.equipTemplete.haveSuit == 1)
	self.panelStress:setEquip(self.equipTemplete)

	if self.equipTemplete.haveSuit == 1 then
		self.txtRandSuit:setVisible(#self.equipTemplete.suitIds ~= 1)

		for i, suitPanelInfo in ipairs(self.suitPanels) do
			if self.equipTemplete.suitIds[i] and ResEquipSuit[self.equipTemplete.suitIds[i]] then
				local suitInfo = ResEquipSuit[self.equipTemplete.suitIds[i]]
				local suitPath = CurAvatar:getSuitPath(self.equipTemplete.suitIds[i])

				suitPanelInfo[1]:setImage(suitPath[1], suitPath[2])
				suitPanelInfo[2]:setText(suitInfo.name)
				suitPanelInfo[3]:setVisible(true)
			else
				suitPanelInfo[3]:setVisible(false)
			end
		end
	end

	if self.equipTemplete.mainProp then
		local mainPropAttrList = {
			{
				propName = self.equipTemplete.mainProp,
				propValue = self.equipTemplete.mainPropValue
			},
			{
				propName = self.equipTemplete.mainProp2,
				propValue = self.equipTemplete.mainProp2Value
			}
		}

		for index, attrPanel in ipairs(self.attrList) do
			local mainPropAttr = mainPropAttrList[index]

			if mainPropAttr.propName and mainPropAttr.propValue then
				attrPanel:setVisible(true)

				local zhName, attrValue = ClientUtils.getRolePropZhNameByType(mainPropAttr.propName, mainPropAttr.propValue)
				local attriconInfo = ClientUtils.getRolePropIconByType(mainPropAttr.propName)

				attrPanel.imgIcon:setImage(attriconInfo[1], attriconInfo[2])
				attrPanel:setData(zhName, attrValue)
			else
				attrPanel:setVisible(false)
			end
		end
	else
		self.attrList[2]:setVisible(false)
		self.attrList[1].imgIcon:setImage(UIConst.COMMON_ICON_PATH .. "GridAtlas/GridEquipAtlas", "IconAttr00")
		self.attrList[1].txtOriValue:setText(Lang.get(30252))
	end
end

local ChoosePanel = require("UI/MainState/Item/OpenChoose/ChoosePanel")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "ChooseEquipDefinePanel"
local ChooseEquipDefinePanel = Class(strClassName, ChoosePanel)

function ChooseEquipDefinePanel:ctor()
	self:_initUI()
end

function ChooseEquipDefinePanel:_initUI()
	self.cells = {}
	self.panelTips = ChooseEquipTipsPanel(self, self.mPath .. "/TipsPanel")
end

function ChooseEquipDefinePanel:setItem(itemGift)
	self.itemGift = itemGift

	self.txtTitle:setText(self.itemGift.name)
	self.txtTimes:setText(self.itemGift.num)

	for i, random_id in ipairs(self.itemGift.resData.extend_args3) do
		if ResRandClient[random_id] and ResRandClient[random_id].show_ids then
			local equipTempleteId = ResRandClient[random_id].show_ids[1]
			local equipTempleteCell = BtnChooseEquipTemplete(self, self.mPath .. "/EquipListList/Content", "System/Bag/BtnChooseEquipSpe", 0, 0, true)
			local fakeEquipTemplete = BaseObject.GetObject(equipTempleteId)

			equipTempleteCell:setEquipTemplete(fakeEquipTemplete)

			self.btnList[i] = equipTempleteCell.btnSelf
			self.btnList[i].idx = i
			self.cells[i] = equipTempleteCell
		end
	end

	self:onBtnSelectClick(self.btnList[1])
end

function ChooseEquipDefinePanel:onBtnSelectClick(sender)
	for i, btn in ipairs(self.btnList) do
		self.btnList[i]:setEnable(sender ~= btn)

		if sender == btn then
			self.curSelectIdx = btn.idx

			self.panelTips:setEquipTemplete(self.cells[self.curSelectIdx].equipTemplete)
		end
	end
end

return ChooseEquipDefinePanel
