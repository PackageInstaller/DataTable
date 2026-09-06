-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudHurtNum.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudHurtNum", package.seeall)

local BattleHudHurtNum = class("BattleHudHurtNum", BattleHudBase)

function BattleHudHurtNum:ctor(damageGo, go, pool)
	BattleHudHurtNum.super.ctor(self, go, pool)

	self.damageGo = damageGo
	self.damage = 0
	self._imageNum = self.damageGo:GetComponent("UIImgNumeralText")
	self._hudText = goutil.findChild(self.go, "txtNum/txtNum"):GetComponent("SpringHUDText")
	self._hudText.tweenScale = false
	self._restriction = goutil.findChild(self.go, "txtNum/txtNum/res")
	self._restrictionState = self._restriction:GetComponent("UIImageSpriteChange")
	self._restrictionImage = self._restriction:GetComponent("Image")
	self._imageNum.manual = true
	self._hudTransform = self._imageNum.transform

	self.damageGo.transform:SetParent(self._hudText.transform)
	Framework.TransformUtil.SetLocalPos(self.damageGo.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self.damageGo.transform, 1, 1, 1)
end

function BattleHudHurtNum:start()
	local txt = tostring(self.damage)

	if self.isTreated or self.damage > 0 then
		txt = "+" .. txt
	end

	self._imageNum:SetText(txt)

	if self.sprite then
		self._restriction:SetActive(true)
		self._restrictionState:ChangeStateNow(self.sprite)
		self._restrictionImage:SetNativeSize()
	else
		self._restriction:SetActive(false)
	end

	self._hudText:SetDelayTimeout(self.isLast and 0.5 or -1)
	self._hudText:StartSpring()
	self:_prepareTween()
	self:_appear(0)
	self.go:SetActive(true)
end

function BattleHudHurtNum:forcePositionOut()
	self._hudText:ForcePositionOut()
end

function BattleHudHurtNum:isFadingIn()
	return self._hudText:IsFadingIn()
end

function BattleHudHurtNum:isDone()
	return self._hudText:IsStop() and self._currIndex > self._activeCount
end

function BattleHudHurtNum:finish()
	return
end

function BattleHudHurtNum:update(deltaTime)
	self._time = self._time + deltaTime

	if self._time >= 0.05 and self._currIndex <= self._activeCount then
		self._time = self._time - 0.05
		self._currIndex = self._currIndex + 1

		if self._currIndex < self._activeCount then
			self:_appear(self._currIndex)
		end
	end
end

function BattleHudHurtNum:_prepareTween()
	self._activeCount = self._imageNum.Count
	self._currIndex = 0
	self._time = 0

	for i = 0, self._activeCount - 1 do
		self._hudTransform:GetChild(i).gameObject:SetActive(false)
	end
end

function BattleHudHurtNum:_appear(i)
	local go = self._hudTransform:GetChild(i).gameObject
	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, nil, nil, nil)
	local sy = math.random(-40, 40)

	UnityTweens.TweenPosition.StartTween(go, Vector3.New(x, sy, z), Vector3.New(x, y, z), 0.2, UnityTweens.EaseType.easeInOutBack)
	go:SetActive(true)
end

return BattleHudHurtNum
