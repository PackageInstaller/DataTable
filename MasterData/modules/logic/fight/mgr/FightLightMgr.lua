-- chunkname: @modules/logic/fight/mgr/FightLightMgr.lua

module("modules.logic.fight.mgr.FightLightMgr", package.seeall)

local FightLightMgr = class("FightLightMgr", FightBaseClass)

function FightLightMgr:onConstructor()
	local cameraRoot = CameraMgr.instance:getCameraRootGO()

	self.directLight = gohelper.findChildComponent(cameraRoot, "main/VirtualCameras/light/direct", typeof(UnityEngine.Light))
	self.lightTransform = self.directLight.transform

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
end

function FightLightMgr:onLevelLoaded(levelId)
	local renderShadows = lua_fight_scene_level_camera_shadow.configDict[levelId]

	if renderShadows then
		self.setShadow = true
		self.rotationX, self.rotationY, self.rotationZ = transformhelper.getLocalRotation(self.lightTransform)

		if not renderShadows.rotation[1] then
			if not renderShadows.rotation[2] then
				local y = 0

				if not renderShadows.rotation[3] then
					local z = 0

					transformhelper.setLocalRotation(self.lightTransform, renderShadows.rotation[1], y, z)

					self.directLight.shadows = UnityEngine.LightShadows.Soft
					self.lightShadowResolution = CameraMgr.instance:getMainLightShadowmapResolution()

					CameraMgr.instance:setMainLightShadowmapResolution(renderShadows.lightShadowResolution)

					self.shadowDepthBias = CameraMgr.instance:getShadowDepthBias()

					CameraMgr.instance:setShadowDepthBias(renderShadows.shadowDepthBias)

					self.shadowNormalBias = CameraMgr.instance:getShadowNormalBias()

					CameraMgr.instance:setShadowNormalBias(renderShadows.shadowNormalBias)
				end
			end
		end
	end
end

function FightLightMgr:onDestructor()
	if self.setShadow then
		transformhelper.setLocalRotation(self.lightTransform, self.rotationX, self.rotationY, self.rotationZ)

		self.directLight.shadows = UnityEngine.LightShadows.None
	end

	if self.lightShadowResolution then
		CameraMgr.instance:setMainLightShadowmapResolution(self.lightShadowResolution)
	end

	if self.shadowDepthBias then
		CameraMgr.instance:setShadowDepthBias(self.shadowDepthBias)
	end

	if self.shadowNormalBias then
		CameraMgr.instance:setShadowNormalBias(self.shadowNormalBias)
	end
end

return FightLightMgr
