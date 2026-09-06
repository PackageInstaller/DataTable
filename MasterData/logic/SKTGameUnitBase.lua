-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/game/SKTGameUnitBase.lua

module("logic.extensions.saintknighttian.view.game.SKTGameUnitBase", package.seeall)

local SKTGameUnitBase = class("SKTGameUnitBase", BaseLuaOnce)

function SKTGameUnitBase:ctor(go)
	SKTGameUnitBase.super.ctor(self, go)
end

function SKTGameUnitBase:buildUI()
	SKTGameUnitBase.super.buildUI(self)

	self._transform = self.mainGO.transform
	self._hp = 0
	self._tweenXOffset = 0
	self._tweenYOffset = 0
	self._radius = math.ceil(self._transform.sizeDelta.x / 2)
	self._imgNumCom = self:getGo(self:_getImgNumPath()):GetComponent(ComponentType.UIImgNumeralText)
end

function SKTGameUnitBase:bindEvents()
	SKTGameUnitBase.super.bindEvents(self)
end

function SKTGameUnitBase:unbindEvents()
	SKTGameUnitBase.super.unbindEvents(self)
end

function SKTGameUnitBase:onEnter()
	SKTGameUnitBase.super.onEnter(self)
end

function SKTGameUnitBase:onExit()
	SKTGameUnitBase.super.onExit(self)
	UnityTweens.TweenPosition.StopTween(self.mainGO)
	removetimer(self._updateHit, self)
end

function SKTGameUnitBase:getScreenPosX()
	return (Framework.TransformUtil.GetLocalPos(self._transform, 0, 0, 0))
end

function SKTGameUnitBase:getRadius()
	return self._radius
end

function SKTGameUnitBase:update(delta)
	return
end

function SKTGameUnitBase:getHP()
	return self._hp
end

function SKTGameUnitBase:addHP(hp)
	self._hp = self._hp + hp

	self:_setHpText()
end

function SKTGameUnitBase:reduceHP(hp)
	self._hp = self._hp - hp

	if self._hp <= 0 then
		self._hp = 0
	end

	self:playHitEffect()
	self:_setHpText()
end

function SKTGameUnitBase:setAnchoredPos(x, y)
	Framework.TransformUtil.SetAnchoredPos(self._transform, x, y)
end

function SKTGameUnitBase:createTween(duration, targetX, targetY)
	local from = self._transform.localPosition
	local toPosx = targetX or from.x + self:_getTweenXOffset()
	local toPosy = targetY or from.y + self:_getTweenYOffset()
	local to = Vector3.New(toPosx, toPosy, 0)
	local tween = self.mainGO:GetComponent(UnityTweensType.TweenPosition)

	if not tween then
		tween = UnityTweens.TweenPosition.Create(self.mainGO, from, to, duration)
	else
		tween.from = from
		tween.to = to
		tween.time = duration
	end

	return tween
end

function SKTGameUnitBase:_getTweenXOffset()
	return self._tweenXOffset
end

function SKTGameUnitBase:_getTweenYOffset()
	return self._tweenYOffset
end

function SKTGameUnitBase:setTweenXOffset(offset)
	self._tweenXOffset = offset
end

function SKTGameUnitBase:setTweenYOffset(offset)
	self._tweenYOffset = offset
end

function SKTGameUnitBase:_setHpText()
	goutil.setActive(self._imgNumCom.gameObject, self._hp > 0)
	self._imgNumCom:SetNum(self._hp)
end

function SKTGameUnitBase:_getImgNumPath()
	return ""
end

function SKTGameUnitBase:playHitEffect()
	if self:_getHitEffectGo() then
		self._updateHitTime = 0
		self._updateHitCount = 0

		settimer(0.01, self._updateHit, self, true)
		self:_updateHit()
	end
end

function SKTGameUnitBase:_updateHit()
	self._updateHitTime = self._updateHitTime + Time.deltaTime
	self._updateHitCount = self._updateHitCount + 1

	if self._updateHitTime >= 0.05 then
		self:_stopHitEffect()

		return
	end

	local go = self:_getHitEffectGo()

	goutil.setActive(go, self._updateHitCount % 2 == 1)
end

function SKTGameUnitBase:_stopHitEffect()
	local go = self:_getHitEffectGo()

	goutil.setActive(go, false)
	removetimer(self._updateHit, self)
end

function SKTGameUnitBase:_getHitEffectGo()
	return false
end

function SKTGameUnitBase:creatShakeTween(duration)
	local to = Vector3.New(10, 0, 0)
	local tween = self.mainGO:GetComponent(UnityTweensType.TweenShakePosition)

	if not tween then
		tween = UnityTweens.TweenShakePosition.Create(self.mainGO, to, duration)
	else
		tween.shakeRange = to
		tween.time = duration
	end

	tween:Begin()
end

return SKTGameUnitBase
