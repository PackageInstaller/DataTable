-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetStarLvupView.lua

module("logic.extensions.starequipment.view.PetStarLvupView", package.seeall)

local PetStarLvupView = class("PetStarLvupView", ViewComponent)

function PetStarLvupView:ctor()
	PetStarLvupView.super.ctor(self)
end

function PetStarLvupView:destroyUI()
	PetStarLvupView.super.destroyUI(self)
end

function PetStarLvupView:onExitFinished()
	PetStarLvupView.super.onExitFinished(self)
end

function PetStarLvupView:onEnterFinished()
	PetStarLvupView.super.onEnterFinished(self)
end

function PetStarLvupView:unbindEvents()
	PetStarLvupView.super.unbindEvents(self)
end

function PetStarLvupView:bindEvents()
	PetStarLvupView.super.bindEvents(self)
end

function PetStarLvupView:onExit()
	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}

	PetStarLvupView.super.onExit(self)
end

function PetStarLvupView:buildUI()
	PetStarLvupView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._stars = {}

	local stars = self:getGo("bg/stars").transform
	local childCount = stars.childCount

	for i = 1, childCount do
		local go = stars:GetChild(i - 1).gameObject

		table.insert(self._stars, go)
	end

	self._attrs = ItemEquipAttrs.New(self:getGo("bg/attrs/gridAttrs"))
end

local effPaths = {
	{
		loop = false,
		goPath = "point_1",
		path = "fx_ui_shengxingchenggong/fx_ui_shengxingchenggong_saoguang.prefab"
	},
	{
		loop = false,
		goPath = "point_4",
		path = "fx_ui_shengxingchenggong/fx_ui_shengxingchenggong_chixu.prefab"
	}
}

function PetStarLvupView:onEnter()
	PetStarLvupView.super.onEnter(self)
	PetUpgradeController.instance:localNotify("PetUpLeafViewEntered")

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local params = self:getOpenParam()

	self._petMo = params[1]
	self._preMo = params[2]

	self._attrs:onSetMoStarLvup(self._petMo.raceId, math.max(0, self._petMo._starLevel - 1))

	for i = 1, #self._stars do
		goutil.setActive(self._stars[i], i <= self._petMo._starLevel)
	end
end

return PetStarLvupView
