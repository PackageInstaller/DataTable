-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/balanceball/UnitBall.lua

module("logic.extensions.balanceball.UnitBall", package.seeall)

local UnitBall = class("UnitBall")

function UnitBall:ctor(componetContainer)
	self.go = componetContainer.gameObject
	self._param = BalanceBallModel.instance:getParamByControlType()
	self._rigidbody = self.go:GetComponent("Rigidbody")
	self._rigidbody.mass = self._param.mass
	self._rigidbody.drag = self._param.drag
	self._rigidbody:GetComponent("Collider").material.bounciness = self._param.bounciness
	self._controlType = -1
	self._curDirection = {
		top = 0,
		left = 0,
		bottom = 0,
		right = 0
	}
	self._onClickUp = false
	self._moveHorizontal = 0
	self._moveVertical = 0
	self._isEnd = false

	GlobalDispatcher:addListener(GlobalNotify.BallDirectionChange, self.setDirection, self)
end

function UnitBall:OnDestroy()
	self._getVectorFunc = nil

	GlobalDispatcher:removeListener(GlobalNotify.BallDirectionChange, self.setDirection, self)
end

function UnitBall:setDirection(func, handler)
	self._getVectorFunc = func
	self._getVectorHandler = handler
end

function UnitBall:setControlType(type)
	self._controlType = type
end

function UnitBall:Update()
	if self._isEnd then
		return
	end

	if not self._getVectorFunc then
		return
	end

	if self._controlType == 0 or self._controlType == 2 then
		self._moveHorizontal = 0
		self._moveVertical = 0

		local h, v, maginitude = self._getVectorFunc(self._getVectorHandler)

		self._moveHorizontal = h * maginitude
		self._moveVertical = v * maginitude
	elseif self._controlType == 1 then
		local vec = Vector3.New(0, 0, 0)
		local vec2 = UnityEngine.Input.acceleration

		vec.x = vec2.x <= self._param.balanceFactor and vec2.x >= -1 * self._param.balanceFactor and 0 or vec2.x
		vec.z = vec2.y <= self._param.balanceFactor and vec2.y >= -1 * self._param.balanceFactor and 0 or vec2.y
		self._moveHorizontal = vec.x
		self._moveVertical = vec.z
	end

	local movement = Vector3.New(self._moveHorizontal, 0, self._moveVertical)

	movement = movement * self:_getSpeed()

	self._rigidbody:AddForce(movement)

	if self.go.transform.position.y < -3 then
		self._isEnd = true

		local isAddStar = false

		GlobalDispatcher:dispatch(GlobalNotify.BallEnd, isAddStar)
	end
end

function UnitBall:_getSpeed()
	return self._param.force
end

function UnitBall:OnTriggerEnter(collider)
	if collider.name == "collectstar" then
		local addScore = 1

		GlobalDispatcher:dispatch(GlobalNotify.BallScoreUpdate, addScore)
		collider.gameObject:SetActive(false)
	elseif collider.name == "gameover" then
		local isAddStar = true

		GlobalDispatcher:dispatch(GlobalNotify.BallEnd, isAddStar)
		collider.gameObject:SetActive(false)
	end
end

return UnitBall
