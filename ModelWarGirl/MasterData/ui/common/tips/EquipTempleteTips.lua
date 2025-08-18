-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\EquipTempleteTips.lua

local SingleEquipTempleteTipsChild = require("UI/Common/Tips/SingleEquipTempleteTipsChild")
local SingleRandomEquipTempleteTipsChild = require("UI/Common/Tips/SingleRandomEquipTempleteTipsChild")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResEquipMainProp = require("ClientData/ResEquipMainProp")
local strClassName = "EquipTempleteTips"
local EquipTempleteTips = Class(strClassName, UIControls.Tips)

function EquipTempleteTips:ctor(prefabPath, order, needShow)
	self:initUI()
end

function EquipTempleteTips:initUI()
	self.panelRandomInfo = UIControls.Panel(self, "BgPanel/RandomInfoPanel")
	self.btnHideRandom = UIControls.Button(self, "BgPanel/RandomInfoPanel/UIClickThrough")

	self.btnHideRandom:addEventClick(self.onBtnHideRandomClick)

	self.randomMainAttr = {}
	self.randomAttr = {}
	self.panelRandomAttr = UIControls.Panel(self, "BgPanel/RandomInfoPanel/Bg/ContentAttr")
	self.txtAttrMainTitle = UIControls.Label(self, "BgPanel/RandomInfoPanel/Bg/ContentAttrMain/TextTitle")

	for i = 1, 10 do
		local mainAttr = UIControls.Label(self, "BgPanel/RandomInfoPanel/Bg/ContentAttrMain/Attr" .. i)

		self.randomMainAttr[i] = mainAttr

		local attr = UIControls.Label(self, "BgPanel/RandomInfoPanel/Bg/ContentAttr/Attr" .. i)

		self.randomAttr[i] = attr
	end
end

function EquipTempleteTips:_setObj(grid)
	self.equipTemplete = grid.object

	if not self.panelEquipInfo then
		if self.equipTemplete.prop then
			self.panelEquipInfo = SingleEquipTempleteTipsChild(self, "BgPanel", "System/Common/Tips/EquipInfoPanel", 0, 0, true)
		else
			self.panelEquipInfo = SingleRandomEquipTempleteTipsChild(self, "BgPanel", "System/Common/Tips/EquipRandomInfoPanel", 0, 0, true)
		end
	end

	self.panelEquipInfo:setItem(self.equipTemplete)

	local mainPropIds, propIds = self.equipTemplete:getRandPropIds()
	local mainPropTitle = #mainPropIds == 1 and Lang.get(30231) or Lang.get(30232)

	self.txtAttrMainTitle:setText(mainPropTitle)

	for idx, attr in ipairs(self.randomMainAttr) do
		if mainPropIds[idx] then
			attr:setVisible(true)

			local zhName, zhValue = ClientUtils.getRolePropZhNameByType(mainPropIds[idx], 0)

			attr:setText(zhName)
		else
			attr:setVisible(false)
		end
	end

	if self.equipTemplete.haveProps == 1 then
		for idx, attr in ipairs(self.randomAttr) do
			if propIds[idx] then
				attr:setVisible(true)

				local zhName, zhValue = ClientUtils.getRolePropZhNameByType(propIds[idx], 0)

				attr:setText(zhName)
			else
				attr:setVisible(false)
			end
		end

		self.panelRandomAttr:setVisible(true)
	else
		self.panelRandomAttr:setVisible(false)
	end
end

function EquipTempleteTips:showRandomInfoPanel()
	self.panelRandomInfo:setVisible(true)
end

function EquipTempleteTips:onBtnHideRandomClick()
	self.panelRandomInfo:setVisible(false)
end

return EquipTempleteTips
