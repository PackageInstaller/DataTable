-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BuffHudTotalDamage.lua

module("logicscene.scene.unit.component.battle.hud.BuffHudTotalDamage", package.seeall)

local BuffHudTotalDamage = class("BuffHudTotalDamage", BattleHudBase)

function BuffHudTotalDamage:ctor(damageGo, go, pool)
	BuffHudTotalDamage.super.ctor(self, go, pool)

	self.damageGo = damageGo
	self.damage = 0
	self._imageNum = self.damageGo:GetComponent("UIImgNumeralText")
	self._hudText = goutil.findChild(self.go, "txtNum/txtNum")
	self._tweenNode = goutil.findChild(self.go, "txtNum"):GetComponent("RectTransform")
	self._restriction = goutil.findChild(self.go, "txtNum/res"):GetComponent("RectTransform")
	self._canvasGroup = self._tweenNode:GetComponent("CanvasGroup")

	self.damageGo.transform:SetParent(self._hudText.transform)
	Framework.TransformUtil.SetLocalPos(self.damageGo.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self.damageGo.transform, 1, 1, 1)
end

function BuffHudTotalDamage:start()
	self._destDamage = self.damage

	if not self._currDamage then
		self._currDamage = 0
		self._canvasGroup.alpha = 0

		self:_updateDamageText()
		Framework.TransformUtil.SetLocalScale(self._tweenNode.transform, 1, 1, 1)
		UnityTweens.UITweenFadeIn.StartTween(self._tweenNode.gameObject, 0.1)
		self.go:SetActive(true)
	end

	self._speed = (self._destDamage - self._currDamage) / 0.3
	self.time = 0
end

function BuffHudTotalDamage:_updateDamage(deltaTime)
	if self._currDamage == self._destDamage then
		return
	end

	local delta = self._speed * deltaTime

	self._currDamage = self._currDamage + delta

	if self._destDamage > 0 then
		if self._currDamage > self._destDamage then
			self._currDamage = self._destDamage
		end
	elseif self._currDamage < self._destDamage then
		self._currDamage = self._destDamage
	end

	self:_updateDamageText()
end

function BuffHudTotalDamage:_updateDamageText()
	local txt = tostring(math.abs(math.ceil(self._currDamage)))

	self._imageNum:SetText(txt)

	local len = #txt
	local width = self._imageNum.horizontalSpace * len

	Framework.TransformUtil.SetLocalPos(self._imageNum.transform, width * 0.5, 0, 0)
end

function BuffHudTotalDamage:forcePositionOut()
	return
end

function BuffHudTotalDamage:isFadingIn()
	if not self.isLast then
		return true
	end

	if self._currDamage == self._destDamage then
		return
	end

	return true
end

function BuffHudTotalDamage:update(deltaTime)
	if self.isLast and self._currDamage == self._destDamage then
		self.time = self.time + deltaTime
	else
		self:_updateDamage(deltaTime)
	end
end

function BuffHudTotalDamage:isDone()
	return self.time >= 1
end

function BuffHudTotalDamage:finish()
	self._currDamage = nil
	self._destDamage = nil
	self._speed = nil
	self.damage = 0

	BuffHudTotalDamage.super.finish(self)
end

return BuffHudTotalDamage
