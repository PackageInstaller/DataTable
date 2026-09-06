-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/data/FruitNinjaBaseCell.lua

module("logic.extensions.fruitninja.data.FruitNinjaBaseCell", package.seeall)

local FruitNinjaBaseCell = class("FruitNinjaBaseCell")

function FruitNinjaBaseCell:ctor(entityId)
	self._entityId = entityId
	self._boundingBox2D = BoundingBox2D.New()
	self._velocity = Vector2.New()
	self._angularVelocity = 0

	self:onReset()
end

function FruitNinjaBaseCell:onReset()
	self._state = FruitNinjaEnum.CellState_Standing
	self._mainGo = nil
	self._fruitId = 0
	self._view = nil
	self._imgIcon = nil
	self._colliderBox = nil
	self._colliderBoxRectTran = nil
	self._effRoot = nil
	self._baseGravityScale = 0
	self._baseScale = 1
	self._rigidBody = nil
	self._fruitData = nil

	self._velocity:Set(0, 0)

	self._angularVelocity = 0
end

function FruitNinjaBaseCell:onDispose()
	self._entityId = nil
	self._boundingBox2D = nil
end

function FruitNinjaBaseCell:onInit(mainGo, fruitId, view)
	self._mainGo = mainGo
	self._fruitId = fruitId
	self._view = view
	self._imgIcon = self._mainGo
	self._effRoot = goutil.findChild(mainGo, "effRoot")
	self._colliderBox = goutil.findChild(mainGo, "colliderBox")
	self._colliderBoxRectTran = self._colliderBox:GetComponent(goutil.Type_RectTransform)
	self._rigidBody = self._mainGo:GetComponent(ComponentType.Rigidbody2D)
	self._fruitData = FruitNinjaConfig.instance:getFruitData(fruitId) or {}

	if not string.nilorempty(self._fruitData.iconPath) then
		local spriteName = GameUrl.getBigbgPngUrl(self._fruitData.iconPath)

		uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, spriteName, function()
			self._imgIcon:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end)
	end

	self._baseGravityScale = self._fruitData.gravityScale or 0.1
	self._baseScale = self._fruitData.scale

	if self._baseScale <= 0 then
		self._baseScale = 1
	end

	self:setScale(self._baseScale)
end

function FruitNinjaBaseCell:onUnInit()
	if not goutil.isNil(self._imgIcon) then
		uGuiUtil.clearImage(self._imgIcon)
	end
end

function FruitNinjaBaseCell:onTicking(deltaTime)
	if self._state == FruitNinjaEnum.CellState_Standing then
		-- block empty
	elseif self._state == FruitNinjaEnum.CellState_Running then
		self._velocity:Set(self._rigidBody.velocity.x, self._rigidBody.velocity.y)

		self._angularVelocity = self._rigidBody.angularVelocity

		self:updateBoundingBox2D()
	elseif self._state == FruitNinjaEnum.CellState_Ending then
		-- block empty
	elseif self._state == FruitNinjaEnum.CellState_Ended then
		-- block empty
	end
end

function FruitNinjaBaseCell:startRunning()
	GameUtil.SetActive(self._imgIcon, true)
	self:_changeState(FruitNinjaEnum.CellState_Running)
end

function FruitNinjaBaseCell:tryTrickHit(boundBox2D, pointerId)
	if self._state ~= FruitNinjaEnum.CellState_Running then
		return
	end

	if boundBox2D then
		if not self:getBoundingBox2D():intersects(boundBox2D) then
			return
		end
	end

	self:_changeState(FruitNinjaEnum.CellState_Ending)
	GameUtil.SetActive(self._imgIcon, false)
	AudioPlayerEx.instance:playEffect(30001)
	self:_changeState(FruitNinjaEnum.CellState_Ended)
	GlobalDispatcher:dispatch(GlobalNotify.FruitNinjaFruitTrickHit, pointerId, self._entityId)
end

function FruitNinjaBaseCell:trickOutBound()
	self:_changeState(FruitNinjaEnum.CellState_Ended)
end

function FruitNinjaBaseCell:trickClearScreen()
	self:_changeState(FruitNinjaEnum.CellState_Ended)
end

function FruitNinjaBaseCell:getEntityId()
	return self._entityId
end

function FruitNinjaBaseCell:getFruitId()
	return self._fruitId
end

function FruitNinjaBaseCell:getGameObject()
	return self._mainGo
end

function FruitNinjaBaseCell:getRigidBody()
	return self._rigidBody
end

function FruitNinjaBaseCell:getState()
	return self._state
end

function FruitNinjaBaseCell:_changeState(state)
	self._state = state
end

function FruitNinjaBaseCell:getGoWorldPos()
	if self._mainGo then
		return Framework.TransformUtil.GetPos(self._mainGo.transform, 0, 0, 0)
	else
		return 0, 0, 0
	end
end

function FruitNinjaBaseCell:getGoLocalPos()
	if self._mainGo then
		return Framework.TransformUtil.GetLocalPos(self._mainGo.transform, 0, 0, 0)
	else
		return 0, 0, 0
	end
end

function FruitNinjaBaseCell:setGoPos(x, y, z)
	if self._mainGo then
		Framework.TransformUtil.SetPos(self._mainGo.transform, x, y, z)
	end
end

function FruitNinjaBaseCell:getBaseScale()
	return self._baseScale
end

function FruitNinjaBaseCell:setScale(value)
	GameUtil.setLocalScale(self._imgIcon, value, value, value)
end

function FruitNinjaBaseCell:getBaseGravityScale()
	return self._baseGravityScale
end

function FruitNinjaBaseCell:setGravityScale(value)
	if self._rigidBody then
		self._rigidBody.gravityScale = value
	end
end

function FruitNinjaBaseCell:getActive()
	return GameUtil.GetActive(self._mainGo)
end

function FruitNinjaBaseCell:setActive(isActive)
	GameUtil.SetActive(self._mainGo, isActive)
end

function FruitNinjaBaseCell:recoverMotion()
	self._rigidBody.velocity = self._velocity
	self._rigidBody.angularVelocity = self._angularVelocity
end

function FruitNinjaBaseCell:addForce(velocity, mode)
	if self._rigidBody then
		self._rigidBody:AddForce(velocity, mode)
	end
end

function FruitNinjaBaseCell:AddTorque(torque, mode)
	if self._rigidBody then
		self._rigidBody:AddTorque(torque, mode)
	end
end

function FruitNinjaBaseCell:getBoundingBox2D()
	return self._boundingBox2D
end

function FruitNinjaBaseCell:updateBoundingBox2D()
	local cellX, cellY, cellZ = self:getGoLocalPos()
	local boxX, boxY, boxZ = Framework.TransformUtil.GetLocalPos(self._colliderBox.transform, 0, 0, 0)
	local scaleX = Framework.TransformUtil.GetLocalScale(self._mainGo.transform, 0, 0, 0)

	self._boundingBox2D:setSize(self._colliderBoxRectTran.rect.width * scaleX, self._colliderBoxRectTran.rect.height * scaleX)
	self._boundingBox2D:setCenter(cellX + boxX, cellY + boxY)
end

return FruitNinjaBaseCell
