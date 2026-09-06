-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallPropMgr.lua

module("logic.extensions.pinball.view.PinBallPropMgr", package.seeall)

local PinBallPropMgr = class("PinBallPropMgr")

function PinBallPropMgr:ctor()
	self.propDirect = Vector2.New(0, -1)
	self._propPoolMap = {}
	self._propMap = {}
	self._complateInstanceMap = {}
	self._parentGo = nil
	self._curCollectPrizeMap = {}
	self._collectPrizeMap = {}
end

function PinBallPropMgr:initParamas(parentGo)
	self._parentGo = parentGo
	self._curCollectPrizeMap = {}
end

function PinBallPropMgr:getCurCollectPrizeMap()
	return self._curCollectPrizeMap
end

function PinBallPropMgr:addCurCollectPrizeMap(prizeId, addPrizeNum)
	self._curCollectPrizeMap[prizeId] = checknumber(self._curCollectPrizeMap[prizeId]) + addPrizeNum
end

function PinBallPropMgr:curGameHasPrize()
	for _, num in pairs(self._collectPrizeMap) do
		if num > 0 then
			return true
		end
	end

	return false
end

function PinBallPropMgr:getCollectPrizeMap()
	return self._collectPrizeMap
end

function PinBallPropMgr:addCollectPrizeMap(prizeId, addPrizeNum)
	self._collectPrizeMap[prizeId] = checknumber(self._collectPrizeMap[prizeId]) + addPrizeNum
end

function PinBallPropMgr:clear()
	self._parentGo = nil

	for k, item in pairs(self._propMap) do
		local type = item:getType()

		self._propPoolMap[type]:returnObject(item)
	end

	for _, pool in pairs(self._propPoolMap) do
		pool:clear()
	end

	self._propPoolMap = {}
	self._propMap = {}
	self._complateInstanceMap = {}
end

function PinBallPropMgr:update()
	for _, item in pairs(self._propMap) do
		item:update()

		if item:isOutScreen() or item:isUsed() then
			local type = item:getType()

			self._propPoolMap[type]:returnObject(item)

			self._propMap[item] = nil
		end
	end
end

function PinBallPropMgr:pauseGame()
	for _, item in pairs(self._propMap) do
		item:setSpeed(0)
	end
end

function PinBallPropMgr:continueGame()
	for _, item in pairs(self._propMap) do
		item:setSpeed(1)
	end
end

function PinBallPropMgr:setComplateInstance(propTag, propInstance)
	if not propInstance then
		printError("无对象实例，请检查是否有正确设置模板实例。 propTag: ", propTag)
	else
		GameUtil.SetActive(propInstance, true)

		self._complateInstanceMap[propTag] = propInstance

		GameUtil.SetActive(propInstance, false)
	end
end

function PinBallPropMgr:getProp(type, posX, posY, extParam)
	if not self._propPoolMap[type] then
		local createFunc = self:_getPropCreatFunc(type, posX, posY)

		local function disposeFunc(item)
			item:destroy()
		end

		local function resetFunc(item)
			item:reset()
		end

		if self._propPoolMap[type] == nil then
			self._propPoolMap[type] = ObjectPool.New(10, createFunc, disposeFunc, resetFunc)
		end
	end

	local prop = self._propPoolMap[type]:fetchObject()

	prop:initParam(posX, posY, 130, 50, type)

	if extParam then
		prop:initExtParam(extParam)
	end

	self._propMap[prop] = prop

	return prop
end

function PinBallPropMgr:_getPropCreatFunc(type, posX, posY)
	local createFunc
	local propInstance = self._complateInstanceMap[type]

	if propInstance then
		function createFunc()
			local item

			if type == PinBallEnum.PropType.AddBall then
				local go = goutil.cloneAndSetParent(propInstance, self._parentGo.transform, type .. "_Prop_" .. posX .. "_" .. posY)

				return (PinBallPropAddBall.New(go))
			elseif type == PinBallEnum.PropType.AddBoardLen then
				local go = goutil.cloneAndSetParent(propInstance, self._parentGo.transform, type .. "_Prop_" .. posX .. "_" .. posY)

				return (PinBallPropAddBoardLen.New(go))
			elseif type == PinBallEnum.PropType.GetPrize then
				local go = goutil.cloneAndSetParent(propInstance, self._parentGo.transform, type .. "_Prop_" .. posX .. "_" .. posY)

				return (PinBallPropGetPrize.New(go))
			else
				printError("创建了未知类型的砖块，未设置, propType: ", type)
			end
		end
	else
		printError("没用该类型的砖块实例， propType: ", type)
	end

	return createFunc
end

PinBallPropMgr.instance = PinBallPropMgr.New()

return PinBallPropMgr
