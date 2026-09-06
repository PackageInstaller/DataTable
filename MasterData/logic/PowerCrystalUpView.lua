-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalUpView.lua

module("logic.extensions.powercrystal.view.PowerCrystalUpView", package.seeall)

local PowerCrystalUpView = class("PowerCrystalUpView", ViewComponent)

function PowerCrystalUpView:ctor()
	PowerCrystalUpView.super.ctor(self)
end

function PowerCrystalUpView:destroyUI()
	PowerCrystalUpView.super.destroyUI(self)
end

function PowerCrystalUpView:onExitFinished()
	PowerCrystalUpView.super.onExitFinished(self)
end

function PowerCrystalUpView:onEnterFinished()
	PowerCrystalUpView.super.onEnterFinished(self)
end

function PowerCrystalUpView:unbindEvents()
	PowerCrystalUpView.super.unbindEvents(self)
end

function PowerCrystalUpView:bindEvents()
	PowerCrystalUpView.super.bindEvents(self)
end

function PowerCrystalUpView:onExit()
	PowerCrystalUpView.super.onExit(self)
	self:clearEffect()
end

function PowerCrystalUpView:buildUI()
	PowerCrystalUpView.super.buildUI(self)

	self._txtPre = goutil.findChildTextComponent(self.mainGO, "txtPre")
	self._txtLast = goutil.findChildTextComponent(self.mainGO, "txtLast")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._imgHeadIcon = goutil.findChild(self.mainGO, "imgHeadIcon")
	self._cell = self:getGo("cell")
	self._txtTips.text = "精灵能力已提升至力量勇士中的最低等级"
	self._point_bg = self:getGo("point_bg")
	self._point_tishengchenggong = self:getGo("point_tishengchenggong")
end

function PowerCrystalUpView:onEnter()
	PowerCrystalUpView.super.onEnter(self)
	self:_updateUI()
end

function PowerCrystalUpView:_updateUI()
	local slotId = self:getFirstParam()
	local info = PowerCrystalModel.instance:getSlotInfo(slotId)

	if info then
		local data = BagPetsFacade.instance:getPetInfo(info.petId)

		if data then
			local component = ItemPet.AddOnce(self._cell)

			component:Init(data)
			component:setGray(false)
		end

		self._txtPre.text = info.originalLv .. "级\n" .. CharacterConfig.instance:getTalentName(data.raceId, info.originalTalent)
		self._txtLast.text = info.curLv .. "级\n" .. CharacterConfig.instance:getTalentName(data.raceId, info.curTalent)
	end

	self:updateEffect()
end

function PowerCrystalUpView:updateEffect()
	self:clearEffect()

	local effect
	local parentTrans = self._point_bg.transform

	effect = UIEffectManager.instance:playEffect(self, "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab", parentTrans, 0, 0, true, false, nil, function(uiEffect)
		effect:setParent(parentTrans)
		effect:setScale(1)
		effect:setLocalPos()
	end)
	self.effect = effect

	local effect2
	local parentTrans2 = self._point_tishengchenggong.transform

	effect2 = UIEffectManager.instance:playEffect(self, "fx_ui_tishengchenggong/fx_ui_tishengchenggong.prefab", parentTrans2, 0, 0, true, false, nil, function(uiEffect)
		effect2:setParent(parentTrans2)
		effect2:setScale(1)
		effect2:setLocalPos()
	end)
	self.effect2 = effect2
end

function PowerCrystalUpView:clearEffect()
	if self.effect then
		UIEffectManager.instance:stopEffect(self.effect)

		self.effect = nil
	end

	if self.effect2 then
		UIEffectManager.instance:stopEffect(self.effect2)

		self.effect2 = nil
	end
end

return PowerCrystalUpView
