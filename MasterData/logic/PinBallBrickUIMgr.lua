-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBrickUIMgr.lua

module("logic.extensions.pinball.view.PinBallBrickUIMgr", package.seeall)

local PinBallBrickUIMgr = class("PinBallBrickUIMgr")

function PinBallBrickUIMgr:ctor()
	self._complateInstanceMap = {}
	self._brickUIPoolMap = {}
	self._brickUIMap = {}
	self._brickUIRoot = nil
end

function PinBallBrickUIMgr:initParam(go)
	self._brickUIRootGo = go
end

function PinBallBrickUIMgr:setComplateInstance(brickTag, brickInstance)
	if not brickInstance then
		printError("无对象实例，请检查是否有正确设置模板实例。 brickTag: ", brickTag)
	else
		GameUtil.SetActive(brickInstance, true)

		self._complateInstanceMap[brickTag] = brickInstance

		GameUtil.SetActive(brickInstance, false)
	end
end

function PinBallBrickUIMgr:clear()
	for k, brickUiList in pairs(self._brickUIMap) do
		if brickUiList then
			for i, item in ipairs(brickUiList) do
				self._brickUIPoolMap[item:getType()]:returnObject(item)
			end
		end
	end

	for _, pool in pairs(self._brickUIPoolMap) do
		pool:clear()
	end

	self._complateInstanceMap = {}
	self._brickUIPoolMap = {}
	self._brickUIMap = {}
	self._brickUIRootGo = nil
end

function PinBallBrickUIMgr:creatUI()
	return
end

function PinBallBrickUIMgr:createBrickUI(type, paramTable)
	if not self._brickUIPoolMap[type] then
		local createFunc = self:_getBrickUICreatFunc(type, paramTable)

		local function disposeFunc(item)
			item:destroy()
		end

		local function resetFunc(item)
			return
		end

		if self._brickUIPoolMap[type] == nil then
			self._brickUIPoolMap[type] = ObjectPool.New(100, createFunc, disposeFunc, resetFunc)
		end
	end

	local obj = self._brickUIPoolMap[type]:fetchObject()

	if type == PinBallEnum.BrickType.Line then
		local key = "init"

		if paramTable then
			key = paramTable.key
		end

		self._brickUIMap[key] = self._brickUIMap[key] or {}

		table.insert(self._brickUIMap[key], obj)
		obj:initParam(paramTable.health, paramTable.posX, paramTable.posY, paramTable.width, paramTable.height, type)
	end

	return obj
end

function PinBallBrickUIMgr:_getBrickUICreatFunc(type, paramTable)
	local createFunc
	local brickUIInstance = self._complateInstanceMap[type]

	if brickUIInstance then
		function createFunc()
			local item

			if type == PinBallEnum.BrickType.Line then
				local go = goutil.cloneAndSetParent(brickUIInstance, self._brickUIRootGo.transform)

				item = PinBallBrickUILine.New(go)

				GameUtil.SetActive(go, true)
			else
				printError("创建了未知类型的砖块UI，未设置, brickType: ", type)
			end

			return item
		end
	else
		printError("没用该类型的砖块UI实例， brickType: ", type)
	end

	return createFunc
end

PinBallBrickUIMgr.instance = PinBallBrickUIMgr.New()

return PinBallBrickUIMgr
