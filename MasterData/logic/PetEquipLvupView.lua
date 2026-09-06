-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetEquipLvupView.lua

module("logic.extensions.starequipment.view.PetEquipLvupView", package.seeall)

local PetEquipLvupView = class("PetEquipLvupView", ViewComponent)

function PetEquipLvupView:ctor()
	PetEquipLvupView.super.ctor(self)
end

function PetEquipLvupView:destroyUI()
	PetEquipLvupView.super.destroyUI(self)
end

function PetEquipLvupView:onExitFinished()
	PetEquipLvupView.super.onExitFinished(self)
end

function PetEquipLvupView:onEnterFinished()
	PetEquipLvupView.super.onEnterFinished(self)
end

function PetEquipLvupView:unbindEvents()
	PetEquipLvupView.super.unbindEvents(self)
end

function PetEquipLvupView:bindEvents()
	PetEquipLvupView.super.bindEvents(self)
end

function PetEquipLvupView:onExit()
	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}

	PetEquipLvupView.super.onExit(self)
end

function PetEquipLvupView:buildUI()
	PetEquipLvupView.super.buildUI(self)

	local level = self:getGo("level")

	self._leftEquip = EquipCell.New(goutil.findChild(level, "leftEquip"))
	self._rightEquip = EquipCell.New(goutil.findChild(level, "rightEquip"))
	self._txtLeftLv = goutil.findChildTextComponent(level, "txtLeftLv")
	self._txtRightLv = goutil.findChildTextComponent(level, "txtRightLv")
	self._txtLeftPower = goutil.findChildTextComponent(self.mainGO, "power/txtLeftPower")
	self._txtRightPower = goutil.findChildTextComponent(self.mainGO, "power/txtRightPower")
	self._attrs = ItemEquipAttrs.New(self:getGo("attrs/gridAttrs"))
end

local effPaths = {
	{
		loop = false,
		goPath = "point_1",
		path = "fx_ui_xingshentisheng/fx_ui_xingshentisheng_saoguang.prefab"
	},
	{
		loop = false,
		goPath = "point_2",
		path = "fx_ui_tianfutisheng/fx_ui_tisheng.prefab"
	},
	{
		loop = false,
		goPath = "point_3",
		path = "fx_ui_tianfutisheng/fx_ui_tisheng_02.prefab"
	},
	{
		loop = false,
		goPath = "point_4",
		path = "fx_ui_xingshentisheng/fx_ui_xingshentisheng_chixu.prefab"
	}
}

function PetEquipLvupView:onEnter()
	PetEquipLvupView.super.onEnter(self)
	PetUpgradeController.instance:localNotify("PetUpLeafViewEntered")

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local params = self:getOpenParam()

	self._mo = params[1]
	self._preMo = params[2]

	local equipDatas = params[3]

	self._equipMo = equipDatas.equipMo
	self._preLv = equipDatas.preLv

	local cfg = StarEquipmentConfig.instance:getEquipCfg(self._equipMo.equipmentId)

	self._leftEquip:onSetMo(cfg, self._preLv)
	self._rightEquip:onSetMo(cfg, self._equipMo.level)

	self._txtLeftLv.text = string.format("Lv.%s", self._preLv)
	self._txtRightLv.text = string.format("Lv.%s", self._equipMo.level)
	self._txtLeftPower.text = self._preMo:getFightingPower()
	self._txtRightPower.text = self._mo:getFightingPower()

	self._attrs:onSetMo(self._equipMo.equipmentId, self._preLv, self._equipMo.level)
end

return PetEquipLvupView
