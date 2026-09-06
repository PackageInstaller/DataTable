-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsPropSpawner.lua

module("logic.extensions.catchprops.view.CatchPropsPropSpawner", package.seeall)

local CatchPropsPropSpawner = class("CatchPropsPropSpawner", ObjectPool)
local rateBase = 10000
local minYPosition = -600

function CatchPropsPropSpawner:ctor(defaultProp, view, effParent, choosePetRaceId)
	CatchPropsPropSpawner.super.ctor(self, 100, function()
		return CatchPropsProp.New()
	end, function(prop)
		prop:dispose()
	end, function(prop)
		return prop:reset()
	end)

	self._view = view
	self._effParent = effParent.transform
	self._gameObjectsCache = {}
	self._props = {}
	self._defaultProp = defaultProp
	self._tempProps = {}
	self._choosePetRaceId = choosePetRaceId

	self:_initParams()
end

function CatchPropsPropSpawner:_initParams()
	self._specialAppearPropNum = 0
	self._maxSpecialPropNum = CatchPropsConfig.instance:getSpecialPropsMaxNum()
	self._normalPropAssetPath = CatchPropsModel.instance:getNormalPropAsset()
	self._specialPropAssetPath = CatchPropsModel.instance:getSpecialPropAsset()

	local appearSpeed = CatchPropsConfig.instance:getPropAppearSpeed()

	self._minAppearPropSpd = checknumber(appearSpeed[1])
	self._maxAppearPropSpd = checknumber(appearSpeed[2])
	self._curAppearPropSpd = 0
	self._appearPropSpdTime = 0
	self._appearSpecialRate = CatchPropsConfig.instance:getSpecialAppearRate()
	self._currPeridAppearNum = 0

	local maxGmaeTime = CatchPropsConfig.instance:getOneGamePlayTime()

	self._appearSpecialInsRate = math.ceil((rateBase - self._appearSpecialRate) / (maxGmaeTime * self._minAppearPropSpd))
	self._appearPropDeltaTime = 0
	self._appearOneTimeCount = 0
	self._currSpecialRate = self._appearSpecialRate

	local propSpace = CatchPropsConfig.instance:getPropSpace()

	self._propSpaceMinX = checknumber(propSpace[1])
	self._propSpaceMaxX = checknumber(propSpace[2])
	self._rangeMinX = 0
	self._rangeMaxX = 0
	self._lastPropAppearX = 0
	self._collisionYPos = 0

	local fallSpd = CatchPropsConfig.instance:getPropFallSpeed()

	self._fallMinSpeed = checknumber(fallSpd[1])
	self._fallMaxSpeed = checknumber(fallSpd[2])
	self._isHaveCrazyModel = self:_judgeHaveCrazyModel()
	self._crazyModel = CatchPropsConfig.instance:getCrazyModel()
	self._crazyTime = CatchPropsConfig.instance:getCrazyTime()

	local appearCrazySpeed = CatchPropsConfig.instance:getCrazyPropAppearSpeed()

	self._minAppearPropCrazySpd = checknumber(appearCrazySpeed[1])
	self._maxAppearPropCrazySpd = checknumber(appearCrazySpeed[2])
	self._isCrazyTip = true
	self._crazyTipTime = CatchPropsConfig.instance:getCrazyTipTime()
end

function CatchPropsPropSpawner:setObjectParent(objectParent)
	self._objectParent = objectParent
end

function CatchPropsPropSpawner:setMoveRange(rangeMinX, rangeMaxX, rangeMinY, rangeMaxY)
	self._rangeMinX = rangeMinX
	self._rangeMaxX = rangeMaxX
	self._rangeMinY = rangeMinY
	self._rangeMaxY = rangeMaxY
end

function CatchPropsPropSpawner:setCollisionYPos(collisionYPos)
	self._collisionYPos = collisionYPos
end

function CatchPropsPropSpawner:update(deltaTime)
	if not self._props then
		return
	end

	self:_checkCreateProps(deltaTime)
	self:_updateProps(deltaTime)
end

function CatchPropsPropSpawner:_updateProps(deltaTime)
	table.clear(self._tempProps)

	self._tempProps = table.values(self._props)

	if self:_isCrazyModel(deltaTime) then
		deltaTime = deltaTime * self._crazyModel
	end

	for i = 1, #self._tempProps do
		self._tempProps[i]:update(deltaTime)

		if self._tempProps[i]:isOutOfBound(minYPosition) then
			self:returnObject(self._tempProps[i])
		end
	end
end

function CatchPropsPropSpawner:getProps()
	table.clear(self._tempProps)

	self._tempProps = table.values(self._props)

	return self._tempProps
end

function CatchPropsPropSpawner:createProp(propType)
	local obj = self:fetchObject()
	local go = self:_getGameObject(propType)

	if go then
		go.transform:SetParent(self._objectParent)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
		go:SetActive(true)
	end

	obj:setPropType(propType)
	obj:setChoosePetRaceId(self._choosePetRaceId)
	obj:setGameObject(go)
	obj:setView(self._view)
	obj:setEffParent(self._effParent)

	local x = self:_calPropXPos()
	local spd = math.random(self._fallMinSpeed, self._fallMaxSpeed)
	local startY = self._rangeMaxY + spd

	obj:setStartPosition(x, startY)

	if propType == CatchPropsPropType.AddTime or propType == CatchPropsPropType.ChoosePetRedBag then
		self._specialAppearPropNum = self._specialAppearPropNum + 1
	end

	self._currPeridAppearNum = self._currPeridAppearNum + 1

	table.insert(self._props, obj)

	return obj
end

function CatchPropsPropSpawner:_calPropXPos()
	local deltaX = math.random(self._propSpaceMinX, self._propSpaceMaxX)
	local x = self._lastPropAppearX + deltaX
	local isInvalid

	if x < self._rangeMinX then
		isInvalid = true
	elseif x > self._rangeMaxX then
		isInvalid = true
	end

	if isInvalid then
		x = math.random(self._rangeMinX, self._rangeMaxX)
	end

	self._lastPropAppearX = x

	return x
end

function CatchPropsPropSpawner:clear()
	table.clear(self._tempProps)

	self._tempProps = table.values(self._props)

	for k, v in pairs(self._tempProps) do
		self:returnObject(v)
	end

	self._props = nil

	CatchPropsPropSpawner.super.clear(self)

	if self._gameObjectsCache then
		for k, v in pairs(self._gameObjectsCache) do
			for k1, v1 in pairs(v) do
				goutil.destroy(v1)
			end
		end

		self._gameObjectsCache = nil
	end

	self._tempProps = nil
	self._props = nil
end

function CatchPropsPropSpawner:_disposeObject(obj)
	local go = obj:getGameObject()

	if go then
		goutil.destroy(go)
	end

	CatchPropsPropSpawner.super._disposeObject(self, obj)
end

function CatchPropsPropSpawner:_resetObject(obj)
	local go = obj:getGameObject()
	local propType = obj:getPropType()

	if go then
		go:SetActive(false)

		self._gameObjectsCache[propType] = self._gameObjectsCache[propType] or {}

		table.insert(self._gameObjectsCache[propType], go)
	end

	table.removebyvalue(self._props, obj)
	CatchPropsPropSpawner.super._resetObject(self, obj)
end

function CatchPropsPropSpawner:_getGameObject(propType)
	local gameObjects = self._gameObjectsCache[propType]
	local go

	if gameObjects then
		go = gameObjects[1]

		if gameObjects[1] then
			table.remove(gameObjects, 1)
		end
	end

	if go then
		return go
	end

	local assetPath
	local res = rescache:GetResourceNoLoadIfNotExists(propType == CatchPropsPropType.Normal and self:_checkNormalPath() or propType == CatchPropsPropType.AddTime and self._specialPropAssetPath or CatchPropsModel.instance:getOtherSpecialPropAssetByType(propType))

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	go = goutil.clone(mainAsset) or self._defaultProp and goutil.clone(self._defaultProp)

	return go
end

function CatchPropsPropSpawner:_checkCreateProps(deltaTime)
	self:_calPropAppearSpd(deltaTime)

	if self._currPeridAppearNum >= self._curAppearPropSpd then
		return
	end

	self._appearOneTimeCount = self._appearOneTimeCount + deltaTime

	while self._appearOneTimeCount >= self._appearPropDeltaTime do
		self._appearOneTimeCount = self._appearOneTimeCount - self._appearPropDeltaTime

		self:_checkCreateOneProp()
	end
end

function CatchPropsPropSpawner:_calPropAppearSpd(deltaTime)
	self._appearPropSpdTime = self._appearPropSpdTime + deltaTime

	if self._curAppearPropSpd == 0 or self._appearPropSpdTime >= 1 then
		while self._currPeridAppearNum < self._curAppearPropSpd do
			self:_checkCreateOneProp()
		end

		self._curAppearPropSpd = self:_getCurAppearPropSpd(deltaTime)
		self._appearPropSpdTime = 0
		self._currPeridAppearNum = 0
		self._appearPropDeltaTime = 1 / self._curAppearPropSpd
		self._appearOneTimeCount = 0
	end
end

function CatchPropsPropSpawner:_checkCreateOneProp()
	if self._specialAppearPropNum < self._maxSpecialPropNum and math.random(1, rateBase) <= self._currSpecialRate then
		local randomSpecial = self:_chooseRandomSpecial()

		if randomSpecial then
			self._currSpecialRate = self._appearSpecialRate

			self:createProp(CatchPropsPropType.AddTime)
		else
			self._currSpecialRate = self._appearSpecialRate

			self:createProp(CatchPropsPropType.ChoosePetRedBag)
		end
	else
		self._currSpecialRate = self._currSpecialRate + self._appearSpecialInsRate

		self:createProp(CatchPropsPropType.Normal)
	end
end

function CatchPropsPropSpawner:_chooseRandomSpecial()
	local randomNum = math.random(1, 11)

	return randomNum <= 5
end

function CatchPropsPropSpawner:_checkNormalPath()
	local len = #self._normalPropAssetPath
	local index = math.random(1, len)

	return self._normalPropAssetPath[index]
end

function CatchPropsPropSpawner:_judgeHaveCrazyModel()
	local actId = CatchPropsModel.instance:getActivityId()
	local actCfg = CatchPropsConfig.instance:getActivityCo(actId)

	return actCfg.isHaveCrazyModel
end

function CatchPropsPropSpawner:_getCurAppearPropSpd(deltaTime)
	if self:_isCrazyModel(deltaTime) then
		return math.random(self._minAppearPropCrazySpd, self._maxAppearPropCrazySpd)
	end

	return math.random(self._minAppearPropSpd, self._maxAppearPropSpd)
end

function CatchPropsPropSpawner:_isCrazyModel(deltaTime)
	local gamingTime = CatchPropsModel.instance:getGamingTime() - deltaTime

	if self._isHaveCrazyModel and gamingTime <= checknumber(self._crazyTime) then
		return true
	end

	return false
end

function CatchPropsPropSpawner:CrazyModelTips(deltaTime)
	if self._isHaveCrazyModel and self._isCrazyTip then
		local gamingTime = CatchPropsModel.instance:getGamingTime() - deltaTime

		if gamingTime <= checknumber(self._crazyTime) + self._crazyTipTime then
			self._isCrazyTip = false

			GlobalDispatcher:dispatch(GlobalNotify.OnCatchPropsCrazyTip)
		end
	end
end

return CatchPropsPropSpawner
