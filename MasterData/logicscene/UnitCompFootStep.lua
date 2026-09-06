-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompFootStep.lua

module("logicscene.scene.unit.component.UnitCompFootStep", package.seeall)

local UnitCompFootStep = class("UnitCompFootStep", UnitComponentBase)

function UnitCompFootStep:onInit()
	self._footStep = {}
	self._freeStepObjects = {}
	self._timeDelta = 0
end

function UnitCompFootStep:onDestroy()
	self:clearFootSteps()

	self._footStep = nil
	self._timeDelta = nil
end

function UnitCompFootStep:onUnitVisible(go)
	self._isClipping = nil
end

function UnitCompFootStep:onUnitInVisible(go)
	self._isClipping = true

	self:clearFootSteps()
end

function UnitCompFootStep:setActive(visible)
	return
end

function UnitCompFootStep:update(deltaTime)
	if self._footStep then
		local cnt = #self._footStep
		local i = 1

		while i <= cnt do
			local ft = self._footStep[i]

			if ft:update(deltaTime) then
				self._freeStepObjects = self._freeStepObjects or {}

				local freeObjs = self._freeStepObjects[ft.stepType]

				if not freeObjs then
					freeObjs = {}
					self._freeStepObjects[ft.stepType] = freeObjs
				end

				table.insert(freeObjs, ft)
				table.remove(self._footStep, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end

	if self._unit.spine:getAnimState() ~= MainPlayerAnimState.Move then
		self._timeDelta = 0
		self._currStepIdx = 1

		return
	end

	self._timeDelta = self._timeDelta + deltaTime

	if self._timeDelta > 0.3 then
		self._timeDelta = 0
		self._currStepIdx = self._currStepIdx + 1

		local x, y = self._unit.transform:getPos()
		local rot = self._unit.transform:getRoatationY()

		self:_showOneFootStep(x, y, 360 - rot)
	end
end

function UnitCompFootStep:_showOneFootStep(x, y, rot)
	local scene = SceneMgr.instance:getCurScene()
	local cellType = scene.stage.wholeScene:GetCellType(x, y)
	local ft
	local footSteps = self._freeStepObjects[cellType]

	if footSteps and #footSteps > 0 then
		ft = footSteps[1]

		table.remove(footSteps, 1)
	end

	ft = ft or cellType == GameEnum.FootStep.GRASS and FootStepGrass.New(self._unit) or FootStepRoad.New(self._unit)

	table.insert(self._footStep, ft)
	ft:showOneFootStep(x, y, rot, self._currStepIdx, self._onBridgeId, self._isUnderBridge, self._bridgeZPos)
end

function UnitCompFootStep:clearFootSteps()
	for i = 1, #self._footStep do
		self._footStep[i]:onDestroy()
	end

	for k, v in pairs(self._freeStepObjects) do
		for i = 1, #v do
			v[i]:onDestroy()
		end
	end

	table.clear(self._footStep)
	table.clear(self._freeStepObjects)
end

function UnitCompFootStep:onBridgeStateChange(isUnder)
	self._isUnderBridge = isUnder
end

function UnitCompFootStep:onBridgeChange(bridgeId, zPos)
	self._onBridgeId = bridgeId or 0
	self._bridgeZPos = zPos
end

function UnitCompFootStep:clearBridgeState()
	self._isUnderBridge = false
	self._onBridgeId = nil
	self._bridgeZPos = nil
end

return UnitCompFootStep
