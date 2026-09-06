-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudBuffDamage.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudBuffDamage", package.seeall)

local BattleHudBuffDamage = class("BattleHudBuffDamage", BattleHudBase)

function BattleHudBuffDamage:ctor(damageGo, go, pool)
	BattleHudBuffDamage.super.ctor(self, go, pool)

	self._hudText = goutil.findChild(go, "txtNum/Nums"):GetComponent("SpringHUDText")
	self._hudText.tweenScale = false

	local imageComp = goutil.findChild(go, "txtNum/Nums/text")

	self._imageComp = imageComp:GetComponent("Image")
	self._imageState = imageComp:GetComponent("UIImageSpriteChange")
	self._imageRect = imageComp:GetComponent("RectTransform")
	self.damageGo = damageGo
	self.damage = 0
	self._imageNum = self.damageGo:GetComponent("UIImgNumeralText")
	self._imageNum.manual = true
	self._hudTransform = self._hudText.transform

	self.damageGo.transform:SetParent(self._hudTransform)
	Framework.TransformUtil.SetLocalPos(self.damageGo.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self.damageGo.transform, 1, 1, 1)
end

function BattleHudBuffDamage:start()
	local txt = tostring(self.damage)

	if self.isTreated or self.damage > 0 then
		txt = "+" .. txt
	end

	self._imageNum:SetText(txt)

	if self.sprite then
		self._imageComp.gameObject:SetActive(true)
		self._imageState:ChangeStateNow(self.sprite)
		self._imageComp:SetNativeSize()

		local spacing = self._imageNum.horizontalSpace
		local width = #txt * spacing
		local imgWidth = self._imageRect.sizeDelta.x

		Framework.TransformUtil.SetLocalPos(self._imageComp.transform, -0.5 * width, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._imageNum.transform, 0.5 * imgWidth, 0, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._imageNum.transform, 0, 0, 0)
		self._imageComp.gameObject:SetActive(false)
	end

	self._hudText:StartSpring()
	self:_prepareTween()
	self:_appear(1)
	self.go:SetActive(true)
end

function BattleHudBuffDamage:forcePositionOut()
	self._hudText:ForcePositionOut()
end

function BattleHudBuffDamage:isFadingIn()
	return self._hudText:IsFadingIn()
end

function BattleHudBuffDamage:isDone()
	return self._hudText:IsStop() and self._currIndex > self._activeCount
end

function BattleHudBuffDamage:update(deltaTime)
	self._time = self._time + deltaTime

	if self._time >= 0.05 and self._currIndex <= self._activeCount then
		self._time = self._time - 0.05
		self._currIndex = self._currIndex + 1

		if self._currIndex <= self._activeCount then
			self:_appear(self._currIndex)
		end
	end
end

function BattleHudBuffDamage:_prepareTween()
	self._childrens = self._childrens or {}

	table.clear(self._childrens)

	if self._imageComp.gameObject.activeSelf then
		table.insert(self._childrens, self._imageComp.gameObject)
	end

	local activeCount = self._imageNum.Count - 1
	local imgNumTf = self._imageNum.transform

	self._currIndex = 0
	self._time = 0

	for i = 0, activeCount do
		local go = imgNumTf:GetChild(i).gameObject

		go:SetActive(false)
		table.insert(self._childrens, go)
	end

	self._activeCount = #self._childrens
	self._currIndex = 1
	self._time = 0
end

function BattleHudBuffDamage:_appear(i)
	local go = self._childrens[i]
	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, nil, nil, nil)
	local sy = math.random(-40, 40)

	UnityTweens.TweenPosition.StartTween(go, Vector3.New(x, sy, z), Vector3.New(x, y, z), 0.2, UnityTweens.EaseType.easeInOutBack)
	go:SetActive(true)
end

return BattleHudBuffDamage
