-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SingleEquipTempleteTipsChild.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local EquipTempleteTipsAttrCell = Class("EquipTempleteTipsAttrCell", UIControls.Panel)

function EquipTempleteTipsAttrCell:ctor()
	self.textName = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.textNumber = UIControls.Label(self, self.mPath .. "/TextNum")
end

function EquipTempleteTipsAttrCell:setAttr(attrType, value)
	self.textName:setText(attrType)
	self.textNumber:setText(value)
end

local MAX_NUMBER_ASSIST_ATTR = 4
local SingleEquipTipsChild = require("UI/Common/Tips/SingleEquipTipsChild")
local SingleEquipTempleteTipsChild = Class("SingleEquipTempleteTipsChild", SingleEquipTipsChild)

function SingleEquipTempleteTipsChild:ctor()
	self.assistCells = {}

	for i = 1, MAX_NUMBER_ASSIST_ATTR do
		local cell = EquipTempleteTipsAttrCell(self, "AttrPanel/Attr0" .. i)

		table.insert(self.assistCells, cell)
	end
end

function SingleEquipTempleteTipsChild:setItem(equip)
	self.gridEquip = UIControls.EquipTempleteGridChild(self, "GridPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)
	self.gridEquip.mEnableTips = false

	self.gridEquip:setObj(equip)
	self.textName:setText(equip.name or "")

	local partInfo = UIConst.EQUIP_PART_CONFIG[equip.position]

	if partInfo then
		self.textPart:setText(partInfo[1])
	end

	self.textDesc:setText(equip:getDesc() or "")

	local mainIcon = ClientUtils.getRolePropIconByType(equip.mainProp)

	if mainIcon then
		self.iconMainAttr:setImage(mainIcon[1], mainIcon[2])
	end

	local zhName, zhValue = ClientUtils.getRolePropZhNameByType(equip.mainProp, equip.mainPropValue)

	self.textMainAttrName:setText(zhName)
	self.textMainAttrNum:setText(zhValue)

	if equip.mainProp2 then
		self.panelMainAttr2:setVisible(true)

		local mainIcon = ClientUtils.getRolePropIconByType(equip.mainProp2)

		if mainIcon then
			self.iconMainAttr2:setImage(mainIcon[1], mainIcon[2])
		end

		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(equip.mainProp2, equip.mainProp2Value)

		self.textMainAttr2Name:setText(zhName)
		self.textMainAttr2Num:setText(zhValue)
	else
		self.panelMainAttr2:setVisible(false)
	end

	for index, cell in ipairs(self.assistCells) do
		local info = equip.prop[index]

		if info then
			cell:setVisible(true)
			cell:setAttr(info.type, info.value)
		else
			cell:setVisible(false)
		end
	end

	if #equip.suitIds == 1 then
		local suitInfo = ResEquipSuit[equip.suitIds[1]]

		if suitInfo then
			local needNum = suitInfo.need_num

			self.panelSuit:setVisible(true)
			self.textSuitName:setText(suitInfo.name)
			self.textSuitDesc:setText(suitInfo.des)
			self.imgSuit:setImage(UIConst.COMMON_ICON_PATH .. suitInfo.iconPath, suitInfo.icon)
			self.textSuitNumber:setText("0" .. "/" .. needNum)
		else
			self.panelSuit:setVisible(false)
		end
	end
end

return SingleEquipTempleteTipsChild
