-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameBoatCon.lua

module("logic.extensions.fishinggame.model.FishingGameBoatCon", package.seeall)

local FishingGameBoatCon = class("FishingGameBoatCon")
local FrozenBlinkInterval = 0.25
local DamageColorDuration = 0.5

function FishingGameBoatCon:ctor(container)
	self.container = container

	if not self.container then
		printError("FishingGameBoatCon:ctor container is nil")

		return
	end

	self:buildUI()
end

function FishingGameBoatCon:getContainer()
	return self.container
end

function FishingGameBoatCon:setUnit(unit)
	self._unit = unit

	if self.container then
		self:updateUI()
	end
end

function FishingGameBoatCon:buildUI()
	self._fishRod = goutil.findChild(self.container, "fishRod")
	self._imgHook = goutil.findChild(self.container, "fishRod/imgHook")
	self._imgShow = goutil.findChild(self.container, "imgShow")
	self._head = goutil.findChild(self.container, "head")

	if self._imgShow then
		self._imgShowComp = self._imgShow:GetComponent(ComponentType.RawImage)
	end

	self._normalColor = GameUtil.getColorByHexColor("FFFFFF")
	self._frozenColor = GameUtil.getColorByHexColor("FF6565")
	self._frozenBlinkTimer = 0
	self._damageColorTimer = 0
	self._isFrozenColorRed = false
end

function FishingGameBoatCon:updateUI(deltaTime)
	if not self.container then
		return
	end

	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)
		self:updateRotation(self._unit.angle)
		self:updateLength(self._unit.length)
		self:_updateFrozenColor(deltaTime)
		goutil.setActive(self.container, true)
	else
		self:reset()
	end
end

function FishingGameBoatCon:reset()
	self:_resetFrozenColor()

	if self.container then
		goutil.setActive(self.container, false)
	end

	self._unit = nil
end

function FishingGameBoatCon:destroy()
	self:reset()

	if self.container then
		goutil.destroy(self.container)

		self.container = nil
	end
end

function FishingGameBoatCon:updatePosition(x, y)
	GameUtil.setAnchoredPos(self.container, x, y)
end

function FishingGameBoatCon:updateRotation(angle)
	GameUtil.setLocalRotation(self._fishRod, 0, 0, angle)
end

function FishingGameBoatCon:updateLength(length)
	GameUtil.setWidth(self._fishRod, length)
end

function FishingGameBoatCon:getHeadPosition()
	if not self._unit or not self._head then
		return nil, nil
	end

	local localPosition = self._head.transform.localPosition

	return self._unit.position.x + checknumber(localPosition.x), self._unit.position.y + checknumber(localPosition.y)
end

function FishingGameBoatCon:playDamageColor(duration)
	local colorDuration = checknumber(duration)

	if colorDuration <= 0 then
		colorDuration = DamageColorDuration
	end

	self._damageColorTimer = colorDuration
end

function FishingGameBoatCon:_updateFrozenColor(deltaTime)
	if not self._imgShowComp then
		return
	end

	if self._damageColorTimer > 0 then
		self._damageColorTimer = math.max(0, self._damageColorTimer - checknumber(deltaTime))
	end

	local isColorPlaying = true
	local isColorPlaying

	if self._damageColorTimer <= 0 then
		isColorPlaying = self._unit and self._unit:isFrozen()
	end

	if isColorPlaying then
		self._frozenBlinkTimer = checknumber(self._frozenBlinkTimer) + checknumber(deltaTime)

		if self._frozenBlinkTimer >= FrozenBlinkInterval then
			self._frozenBlinkTimer = 0
			self._isFrozenColorRed = not self._isFrozenColorRed
		end

		if self._isFrozenColorRed then
			self._imgShowComp.color = self._frozenColor or self._normalColor
		end

		self._isFrozenColorPlaying = true
	elseif self._isFrozenColorPlaying then
		self:_resetFrozenColor()
	end
end

function FishingGameBoatCon:_resetFrozenColor()
	if self._imgShowComp then
		self._imgShowComp.color = self._normalColor
	end

	self._frozenBlinkTimer = 0
	self._damageColorTimer = 0
	self._isFrozenColorRed = false
	self._isFrozenColorPlaying = false
end

function FishingGameBoatCon:getHookGo()
	return self._imgHook
end

return FishingGameBoatCon
