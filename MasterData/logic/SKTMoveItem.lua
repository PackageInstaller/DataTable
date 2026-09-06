-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/game/SKTMoveItem.lua

module("logic.extensions.saintknighttian.view.game.SKTMoveItem", package.seeall)

local SKTMoveItem = class("SKTMoveItem", SKTGameUnitBase)

function SKTMoveItem:ctor(go)
	SKTMoveItem.super.ctor(self, go)
end

function SKTMoveItem:buildUI()
	SKTMoveItem.super.buildUI(self)

	self._iconGo = self:getGo("icon")
	self._shadowGo = self:getGo("shadow")
	self._iconCZGo = self:getGo("iconCZ")
	self._txtScore = self:getText("txtScore")
	self._effectHitGo = self:getGo("imgHit")

	self:setTweenXOffset(50)
end

function SKTMoveItem:bindEvents()
	SKTMoveItem.super.bindEvents(self)
end

function SKTMoveItem:unbindEvents()
	SKTMoveItem.super.unbindEvents(self)
end

function SKTMoveItem:onEnter(cfgId)
	SKTMoveItem.super.onEnter(self)
	self:reset()

	self._cfg = nil

	if cfgId > 0 then
		self._cfg = SaintKnightTianConfig.instance:getGameSlotCfg(cfgId)
		self._isEmpty = self._cfg.typeId == GameEnum.FBBSlotType.Empty
		self._slotType = self._cfg.typeId

		if not self._isEmpty then
			self._hp = self._cfg.power
		end
	end

	local isEmpty = self._isEmpty
	local isCZ = not isEmpty and self._slotType == GameEnum.FBBSlotType.Scoop

	goutil.setActive(self._iconGo, not isCZ and not isEmpty)
	goutil.setActive(self._iconCZGo, isCZ)
	goutil.setActive(self._shadowGo, not isEmpty)
	self:_setHpText()

	if not isCZ and not isEmpty and not string.nilorempty(self._cfg.resPath) then
		uGuiUtil.setSpriteToImage(self._iconGo, nil, GameUrl.getIconFolderUrl("headicon", self._cfg.resPath))
	end
end

function SKTMoveItem:onExit()
	SKTMoveItem.super.onExit(self)
	self:reset()
end

function SKTMoveItem:reset()
	uGuiUtil.clearImage(self._iconGo)

	self._isHit = false
	self._isEmpty = true
	self._hp = 0
	self._slotType = GameEnum.FBBSlotType.Empty

	goutil.setActive(self._iconGo, false)
	goutil.setActive(self._iconCZGo, false)
	goutil.setActive(self._shadowGo, false)
	self:setTweenXOffset(50)
	self:setTweenYOffset(0)
	Framework.TransformUtil.SetLocalScale(self._transform, 1, 1, 1)
	self:_setHpText()
end

function SKTMoveItem:hasBeenHit()
	return self._isHit
end

function SKTMoveItem:setIsHit()
	self._isHit = true
end

function SKTMoveItem:isEmptySlot()
	return self._isEmpty
end

function SKTMoveItem:getSlotType()
	return self._slotType
end

function SKTMoveItem:_getImgNumPath()
	return "imgNum"
end

function SKTMoveItem:_setHpText()
	goutil.setActive(self._imgNumCom.gameObject, self._hp > 0 and self:getSlotType() == GameEnum.FBBSlotType.JL)
	self._imgNumCom:SetNum(self._hp)
end

function SKTMoveItem:createScaleTween(duration)
	local from = Vector3.New(1, 1, 1)
	local to = Vector3.New(0, 0, 0)
	local tween = self.mainGO:GetComponent(UnityTweensType.TweenScale)

	if not tween then
		tween = UnityTweens.TweenScale.Create(self.mainGO, from, to, duration)
	else
		tween.from = from
		tween.to = to
		tween.time = duration
	end

	tween:Begin()

	return tween
end

function SKTMoveItem:_getHitEffectGo()
	return self._effectHitGo
end

return SKTMoveItem
