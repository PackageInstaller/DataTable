-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackAnimationComponent.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackAnimationComponent", package.seeall)

local M = class("EchoCardUnpackAnimationComponent")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._isUp = false
	self._isLeft = false
end

function M:Awake()
	return
end

function M:OnEnable()
	local time = math.random(1, 5) / 10

	settimer(time, self._playAnimation, self, false)
end

function M:OnDisable()
	removetimer(self._playAnimation, self)

	if self._tweener then
		self._tweener:Kill(false)
	end
end

function M:OnDestroy()
	return
end

function M:_playAnimation()
	if self._isUp then
		self._targetY = math.random(5, 10) / 10
	else
		self._targetY = math.random(-5, -10) / 10
	end

	self._isUp = not self._isUp
	self._targetX = math.random(-10, 10) / 10
	self._rotationX = math.random(-0.3, 0.3)
	self._rotationY = math.random(-0.3, 0.3)

	if self._isLeft then
		self._rotationZ = math.random(0, 10) / 10
	else
		self._rotationZ = math.random(-10, 0) / 10
	end

	self._isLeft = not self._isLeft

	local startX, startY, startZ = GameUtils.getLocalPos(self._go)
	local rX, rY, rZ = GameUtils.getLocalRotation(self._go)

	rX = rX > 270 and rX - 360 or rX
	rY = rY > 270 and rY - 360 or rY
	rZ = rZ > 270 and rZ - 360 or rZ

	local moveX = self._targetX - startX
	local moveY = self._targetY - startY
	local rotationX = self._rotationX - rX
	local rotationY = self._rotationY - rY
	local rotationZ = self._rotationZ - rZ

	self._time = 1

	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = DoTweenUtil.ToWithEase(0, 1, 2, DG.Tweening.Ease.Linear, function(value)
		local x = startX + value * moveX
		local y = startY + value * moveY

		GameUtils.setLocalPos(self._go, x, y, startZ)

		local _rotationX = rX + value * rotationX
		local _rotationY = rY + value * rotationY
		local _rotationZ = rZ + value * rotationZ

		GameUtils.setLocalRotation(self._go, _rotationX, _rotationY, _rotationZ)
	end)

	self._tweener:OnComplete(function()
		self:_playAnimation()
	end)
	self._tweener:SetTarget(self._go)
end

return M
