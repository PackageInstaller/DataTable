-- chunkname: @modules/logic/fight/mgr/FightUnitCameraMgr.lua

module("modules.logic.fight.mgr.FightUnitCameraMgr", package.seeall)

local FightUnitCameraMgr = class("FightUnitCameraMgr", FightBaseClass)

function FightUnitCameraMgr:onConstructor()
	self.unitCamera = CameraMgr.instance:getUnitCamera()
	self.unitCameraGO = CameraMgr.instance:getUnitCameraGO()
	self.unitCameraTrs = CameraMgr.instance:getUnitCameraTrs()

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
end

function FightUnitCameraMgr:onLevelLoaded(levelId)
	local renderShadows = lua_fight_scene_level_camera_shadow.configDict[levelId]

	if renderShadows then
		self.setShadow = true
		self.shadowDistance = CameraMgr.instance:getShadowDistance()

		CameraMgr.instance:setShadowDistance(renderShadows.shadowDistance)

		UnityEngine.Rendering.Universal.CameraExtensions.GetUniversalAdditionalCameraData(self.unitCamera).renderShadows = true
	end
end

function FightUnitCameraMgr:onDestructor()
	if self.setShadow then
		CameraMgr.instance:setShadowDistance(self.shadowDistance)

		UnityEngine.Rendering.Universal.CameraExtensions.GetUniversalAdditionalCameraData(self.unitCamera).renderShadows = false
	end
end

return FightUnitCameraMgr
