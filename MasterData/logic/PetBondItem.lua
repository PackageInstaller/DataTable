-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/model/PetBondItem.lua

module("logic.extensions.petrelation.model.PetBondItem", package.seeall)

local PetBondItem = class("PetBondItem")

function PetBondItem:ctor(container)
	self._go = container.gameObject
	self._contentText = nil
	self._bg = nil
	self._rt = nil
	self._originPos = Vector3.zero
	self._lastTween = nil
	self.gameObject = self._go
	self._lifeTime = 0
	self._bond = goutil.findChild(self._go, "bond")
	self._pet_1 = goutil.findChild(self._go, "bond/pet_1")
	self._pet_2 = goutil.findChild(self._go, "bond/pet_2")
	self._txtName = goutil.findChildTextComponent(self._go, "bond/txtName")
	self._form = goutil.findChild(self._go, "form")
	self._icon = goutil.findChild(self._go, "form/icon/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtForm = goutil.findChildTextComponent(self._go, "form/txt")
end

function PetBondItem:Awake()
	self._rt = self._go.transform
	self._originPos = self._rt.localPosition
	self._cg = self._go:GetComponent("CanvasGroup")
end

function PetBondItem:getBg()
	self._bg = self._bg or self._go:GetComponent(typeof(UnityEngine.UI.Image))

	return self._bg
end

function PetBondItem:setBondInfo(showPetFaceId1, showPetFaceId2, showBondName)
	goutil.setActive(self._form, false)
	goutil.setActive(self._bond, false)
	uGuiUtil.clearImage(self._pet_1)
	uGuiUtil.clearImage(self._pet_2)

	self._txtName.text = showBondName

	local modelCo = CharacterConfig.instance:getModelCo(showPetFaceId1)

	uGuiUtil.setSpriteToImage(self._pet_1, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

	modelCo = CharacterConfig.instance:getModelCo(showPetFaceId2)

	uGuiUtil.setSpriteToImage(self._pet_2, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName), function()
		goutil.setActive(self._bond, true)
	end, self)
end

function PetBondItem:setFormInfo(info)
	goutil.setActive(self._bond, false)

	local cfg = BattleConfig.instance:getFormStrengthLvCfg(info.formStrengthId, info.formStrengthLv)

	self._icon:SetState(info.formStrengthId - 1)

	local nameStr = cfg.name
	local lvStr = info.formStrengthLv .. "级"
	local attrList = FightingPowerFormula.instance:parseAttrValues(cfg.properties)
	local attrStr = ""

	for key, value in pairs(attrList) do
		local name, showValue = GameUtil.getPropertyInfo(key, value)

		attrStr = attrStr .. string.format("\n%s  <color=#20C744FF>%s</color>", name, showValue)
	end

	self._txtForm.text = string.format("%s  <color=#20C744FF>%s</color>", nameStr, lvStr) .. attrStr

	goutil.setActive(self._form, true)
end

function PetBondItem:reset()
	if self._lastTween then
		self._lastTween:Kill()

		self._lastTween = nil
	end

	self._rt.localPosition = self._originPos

	if self._contentText then
		self._contentText.text = ""
	end

	if self._tweenAlpha then
		self._tweenAlpha:Kill(false)

		self._tweenAlpha = nil
	end

	if self._tweenScale then
		self._tweenScale:Kill(false)

		self._tweenScale = nil
	end

	self._lifeTime = 0

	uGuiUtil.clearImage(self._pet_1)
	uGuiUtil.clearImage(self._pet_2)
end

function PetBondItem:_resetAlpha()
	local _dieAlphaTime = PetRelationController.instance:getDieAlphaTime()

	self._tweenAlpha = TweenUtil.ValueTo(1, 0, _dieAlphaTime, function(val)
		self._cg.alpha = val
	end, function()
		self._tweenAlpha = nil
	end, self, DG.Tweening.Ease.InCirc)
end

function PetBondItem:_bornScale()
	if not self._go then
		return
	end

	self._tweenScale = TweenUtil.ValueTo(1.3, 1, 0.3, function(val)
		GameUtil.setLocalScale(self._go, val, val, val)
	end, function()
		self._tweenScale = nil
	end, self, DG.Tweening.Ease.OutCubic)
end

function PetBondItem:born()
	self._lifeTime = 1.6

	if Framework.OSDef.isEditor then
		local _dieAlphaTime = PetRelationController.instance:getDieAlphaTime()

		if _dieAlphaTime > self._lifeTime then
			error("self._lifeTime < _dieAlphaTime")
		end
	end

	self._cg.alpha = 1

	self:_bornScale()
end

function PetBondItem:dying()
	if self._lifeTime <= 0 then
		return
	end

	local _dieAlphaTime = PetRelationController.instance:getDieAlphaTime()

	self._lifeTime = self._lifeTime - _dieAlphaTime

	if self._lifeTime == _dieAlphaTime then
		self:_resetAlpha()
	end
end

function PetBondItem:isLiving()
	return self._lifeTime > 0
end

return PetBondItem
