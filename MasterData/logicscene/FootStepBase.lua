-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/footstep/FootStepBase.lua

module("logicscene.scene.unit.component.footstep.FootStepBase", package.seeall)

local FootStepBase = class("FootStepBase")
local stepResMap = {
	"scene/misc/prefabs/foot_step_p.prefab",
	"scene/misc/prefabs/foot_grass_p.prefab",
	"scene/misc/prefabs/foot_step_p.prefab",
	"scene/misc/prefabs/foot_step_p.prefab",
	"scene/misc/prefabs/foot_step_p.prefab",
	"scene/misc/prefabs/foot_step_p.prefab",
	"scene/misc/prefabs/foot_step_p.prefab"
}

function FootStepBase:ctor(stepType, unit)
	self._unit = unit
	self.stepType = stepType
	self._resPath = stepResMap[stepType + 1]

	local scene = SceneMgr.instance:getCurScene()

	self._resCache = scene.resCache
end

function FootStepBase:onDestroy()
	if self._footStep then
		self._resCache:recycleObject(self._footStep)
	end

	self._footStep = nil
	self._resPath = nil
	self._resCache = nil
end

function FootStepBase:update(deltaTime)
	return
end

function FootStepBase:showOneFootStep(x, y, rot, idx, bridgeId, isUnderBridge, bridgeZPos)
	self._footStep = self._footStep or self._resCache:newObject(self._resPath, self._onFootStepResLoaded, self)

	if bridgeId == 0 or isUnderBridge then
		self._footStep:setSortingOrder(-501)
	else
		self._footStep:setSortingOrder(0)
	end

	self._footStep:setActive(true)
	self._footStep:setPos(x, y, (bridgeZPos or nil) and bridgeZPos - 0.01)
	self._footStep:setLayer(self._unit.go.layer)
end

function FootStepBase:recycle()
	if self._footStep then
		self._resCache:recycleObject(self._footStep)

		self._footStep = nil
	end
end

function FootStepBase:_onFootStepResLoaded(resObject)
	return
end

return FootStepBase
