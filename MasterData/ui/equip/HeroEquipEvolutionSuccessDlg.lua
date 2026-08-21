-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\HeroEquipEvolutionSuccessDlg.lua

local Equip = require("Common/Object/Equip")
local strClassName = "HeroEquipEvolutionSuccessDlg"
local HeroEquipEvolutionSuccessDlg = Class(strClassName, UIControls.Window)

function HeroEquipEvolutionSuccessDlg:ctor()
	self:initUI()
end

function HeroEquipEvolutionSuccessDlg:initUI()
	self.txtName = UIControls.Label(self, "BgPanel/TextName")
	self.panelLock = UIControls.Panel(self, "BgPanel/TextAttrPanel/AttrState")
	self.txtNum = UIControls.Label(self, "BgPanel/TextAttrPanel/TextNum")
	self.imgAttrIcon = UIControls.Image(self, "BgPanel/TextAttrPanel/Icon")
	self.txtAttrName = UIControls.Label(self, "BgPanel/TextAttrPanel/TextTitle")
	self.efxBg = UIControls.LazyEffectPlayer(self, "EfxBg")
	self.imgAttr3Bg = UIControls.Image(self, "BgPanel/TextAttrPanel/Bg")
	self.iconMainAttr3 = UIControls.Image(self, "BgPanel/TextAttrPanel/Icon")
	self.textMainAttr3Name = UIControls.Label(self, "BgPanel/TextAttrPanel/TextTitle")
	self.textMainAttr3Num = UIControls.Label(self, "BgPanel/TextAttrPanel/TextNum")
end

function HeroEquipEvolutionSuccessDlg:setEquip(equip)
	self.equip = equip

	self.txtName:setText(self.equip.name)

	if not self.gridEquip then
		self.gridEquip = UIControls.EquipGridChild(self, "BgPanel/GridPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)
	end

	self.gridEquip:setObj(self.equip)

	self.gridEquip.mEnableTips = false

	local oriServerData = utils.deepcopy(self.equip._serverData)

	oriServerData.evolve = oriServerData.evolve - 1
	self.oriEquip = Equip(oriServerData)

	local curMainPropValue = self.equip.mainProp3Value or 0
	local oriMainPropValue = self.oriEquip.mainProp3Value or 0
	local mainIcon = ClientUtils.getRolePropIconByType(self.equip.mainProp3)

	if mainIcon then
		self.imgAttrIcon:setImage(mainIcon[1], mainIcon[2])
	end

	local attr3Color = self.equip:getAttr3Color()

	if attr3Color then
		self.textMainAttr3Name:setColorByRGBA(attr3Color[1] / 255, attr3Color[2] / 255, attr3Color[3] / 255)
		self.textMainAttr3Num:setColorByRGBA(attr3Color[1] / 255, attr3Color[2] / 255, attr3Color[3] / 255)
		self.iconMainAttr3:setColorByRGBA(attr3Color[1], attr3Color[2], attr3Color[3])
	end

	local imgBackPath = self.equip:getAttr3BackImgPath()

	if imgBackPath then
		self.imgAttr3Bg:setImage(imgBackPath[1], imgBackPath[2])
	end

	local zhName, zhValue = ClientUtils.getRolePropZhNameByType(self.equip.mainProp3, curMainPropValue)
	local zhOriName, zhOriValue = ClientUtils.getRolePropZhNameByType(self.equip.mainProp3, oriMainPropValue)

	self.txtAttrName:setText(zhName)

	local efxPath = self.equip.evolve == 1 and "Effects/UI/efx_ui_HeroEquipEvolutionSuccess01.prefab" or "Effects/UI/efx_ui_HeroEquipEvolutionSuccess02.prefab"

	self.efxBg:playEffectByPath(efxPath)

	if self.equip.evolve == 1 then
		self.txtNum:setText(zhValue)
		self.panelLock:setVisible(true)
	else
		self.panelLock:setVisible(false)
		self.txtNum:setText(zhOriValue)

		self.timerChangeValue = Timer.New(Functor(self._delayChangePropValue, self, zhValue), 1.07, 1)

		self.timerChangeValue:Start()
	end
end

function HeroEquipEvolutionSuccessDlg:onDestroy()
	if self.timerChangeValue then
		self.timerChangeValue:Stop()

		self.timerChangeValue = nil
	end

	HeroEquipEvolutionSuccessDlg.super.onDestroy(self)
end

function HeroEquipEvolutionSuccessDlg:_delayChangePropValue(valueStr)
	self.txtNum:setText(valueStr)
end

return HeroEquipEvolutionSuccessDlg
