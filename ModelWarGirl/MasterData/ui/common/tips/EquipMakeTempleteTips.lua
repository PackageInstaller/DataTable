-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\EquipMakeTempleteTips.lua

local SingleEquipTempleteTipsChild = require("UI/Common/Tips/SingleEquipTempleteTipsChild")
local SingleRandomEquipTempleteTipsChild = require("UI/Common/Tips/SingleRandomEquipTempleteTipsChild")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResEquipMainProp = require("ClientData/ResEquipMainProp")
local ResEquipCustomize = require("ClientData/ResEquipCustomize")
local SingleRandomEquipTempleteTipsChild = require("UI/Common/Tips/SingleRandomEquipTempleteTipsChild")
local strClassName = "EquipMakeInfoChild"
local EquipMakeInfoChild = Class(strClassName, SingleRandomEquipTempleteTipsChild)

function EquipMakeInfoChild:ctor()
	return
end

function EquipMakeInfoChild:setItem(equip, params)
	self.gridEquip = UIControls.EquipTempleteGridChild(self, "GridPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)
	self.gridEquip.mEnableTips = false

	self.gridEquip:setObj(equip)

	self.equip = equip

	self.textName:setText(equip.name or "")

	local partInfo = UIConst.EQUIP_PART_CONFIG[equip.position or equip.resData.position]

	if partInfo then
		self.textPart:setText(partInfo[1])
	end

	self.textDesc:setText(equip:getDesc() or "")
	self.btnTips:setVisible(true)

	if params.mainProp then
		self.textMainAttrNum:setVisible(true)

		local mainIcon = ClientUtils.getRolePropIconByType(params.mainProp)

		if mainIcon then
			self.iconMainAttr:setImage(mainIcon[1], mainIcon[2])
		end

		local mainPropValue = utils.getEquipMainPropValue(equip, 0, params.mainProp)
		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(params.mainProp, mainPropValue)

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
	else
		self.iconMainAttr:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconAttr00")
		self.textMainAttrName:setText(Lang.get(90262))
		self.textMainAttrNum:setVisible(false)
		self.panelMainAttr2:setVisible(false)
	end

	if params.suitId then
		self.imgSuitStar:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconEquipStar02Nml")
		self.txtSuitStar:setText(Lang.get(942))
		self.imgBgLine:setVisible(true)

		for idx, suitPanel in ipairs(self.suitPanels) do
			if idx == 1 then
				suitPanel:setVisible(true)
				suitPanel:setSuit(params.suitId)
			else
				suitPanel:setVisible(false)
			end
		end
	else
		self.imgBgLine:setVisible(false)
		self.imgSuitStar:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconEquipStar02Dis")
		self.txtSuitStar:setText(Lang.get(90263))

		for idx, suitPanel in ipairs(self.suitPanels) do
			suitPanel:setVisible(false)
		end
	end

	self.suitSpePanel:setVisible(false)
	self.panelStress:setEquip(equip)
end

local strClassName = "EquipMakeTempleteTips"
local EquipMakeTempleteTips = Class(strClassName, UIControls.Tips)

function EquipMakeTempleteTips:ctor(prefabPath, order, needShow)
	self:initUI()
end

function EquipMakeTempleteTips:initUI()
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

function EquipMakeTempleteTips:_setObj(grid, params)
	self.equip = grid.object

	if not self.panelEquipInfo then
		self.panelEquipInfo = EquipMakeInfoChild(self, "BgPanel", "System/Common/Tips/EquipRandomInfoPanel", 0, 0, true)
	end

	self.panelEquipInfo:setItem(self.equip, params)

	local mainPropIds = {}

	if params.mainProp ~= nil then
		self.txtAttrMainTitle:setText(Lang.get(30231))

		mainPropIds = {
			params.mainProp,
			self.equip.mainProp2
		}
	else
		self.txtAttrMainTitle:setText(Lang.get(90262))

		mainPropIds = ResEquipCustomize[self.equip.id] ~= nil and ResEquipCustomize[self.equip.id].prop_range or {}
	end

	for idx, attr in ipairs(self.randomMainAttr) do
		if mainPropIds[idx] then
			attr:setVisible(true)

			local zhName, zhValue = ClientUtils.getRolePropZhNameByType(mainPropIds[idx], 0)

			attr:setText(zhName)
		else
			attr:setVisible(false)
		end
	end

	self.equipTemplete = BaseObject.GetObject(self.equip.id + 300000)

	local mainProps, propIds = self.equipTemplete:getRandPropIds()

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

function EquipMakeTempleteTips:showRandomInfoPanel()
	self.panelRandomInfo:setVisible(true)
end

function EquipMakeTempleteTips:onBtnHideRandomClick()
	self.panelRandomInfo:setVisible(false)
end

return EquipMakeTempleteTips
