-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneCameraComp.lua

module("modules.logic.scene.survival.comp.SurvivalSceneCameraComp", package.seeall)

local SurvivalSceneCameraComp = class("SurvivalSceneCameraComp", CommonSceneCameraComp)

function SurvivalSceneCameraComp:onInit()
	self._scene = self:getCurScene()
	self._rawcameraTrace = CameraMgr.instance:getCameraTrace()
	self._cameraTrace = self._rawcameraTrace
	self._cameraCO = nil
end

function SurvivalSceneCameraComp:_onScreenResize()
	local focusTrs = CameraMgr.instance:getFocusTrs()
	local x, y, z = transformhelper.getPos(focusTrs)

	self._cameraTrace:SetTargetFocusPos(x, y, z)

	if self._nowFov then
		self:setFov(self._nowFov)
		self._cameraTrace:ApplyDirectly()
	end
end

function SurvivalSceneCameraComp:onSceneStart(...)
	self._rawcameraTrace.enabled = false
	self._cameraTrace = gohelper.onceAddComponent(self._rawcameraTrace, typeof(ZProj.ExploreCameraTrace))

	self._cameraTrace:SetEaseTime(SurvivalConst.CameraTraceTime)

	self.sceneType = GameSceneMgr.instance:getCurSceneType()

	if self.sceneType == SceneType.SurvivalShelter or self.sceneType == SceneType.SurvivalCollectionRoom then
		local mapCo = SurvivalConfig.instance:getShelterMapCo()

		self.mapMinX = mapCo.minX + 2
		self.mapMaxX = mapCo.maxX - 2
		self.mapMinY = mapCo.minY
		self.mapMaxY = mapCo.maxY - 2
		self.maxDis = 10
		self.minDis = 4.5
		self._mapMaxPitch = 60
		self._mapMinPitch = 45
	elseif self.sceneType == SceneType.Survival then
		local mapCo = SurvivalMapModel.instance:getCurMapCo()

		self.mapMinX = mapCo.minX
		self.mapMaxX = mapCo.maxX
		self.mapMinY = mapCo.minY
		self.mapMaxY = mapCo.maxY
		self.maxDis = SurvivalConst.MapCameraParams.MaxDis
		self.minDis = SurvivalConst.MapCameraParams.MinDis
	end

	SurvivalSceneCameraComp.super.onSceneStart(self, ...)
end

function SurvivalSceneCameraComp:onScenePrepared(sceneId, levelId)
	self._cameraTrace.EnableTrace = true

	self:checkIsInMiasma(true)

	if self.sceneType == SceneType.SurvivalShelter or self.sceneType == SceneType.SurvivalCollectionRoom then
		self:setDistance(10)
		self:setRotate(0, 45)

		local playerMo = SurvivalShelterModel.instance:getPlayerMo()
		local playerPos = playerMo and playerMo:getPos()

		if playerPos then
			if playerPos then
				local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(playerPos.q or 0, playerPos.r or 0)
				local targetPos = Vector3(x, y, z)

				self:setFocus(targetPos.x, targetPos.y, targetPos.z)
			end
		end
	elseif self.sceneType == SceneType.Survival then
		local scale = SurvivalMapModel.instance.save_mapScale

		self:setDistance(self.maxDis - (self.maxDis - self.minDis) * scale)

		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local targetPos = Vector3(sceneMo.player:getWorldPos())

		self:setFocus(targetPos.x, targetPos.y, targetPos.z)
	elseif self.sceneType == SceneType.SurvivalSummaryAct then
		self:setDistance(6)
		self:setRotate(0)
		self:setPitchAngle(45)

		local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(0, 0)

		self:setFocus(x + 0.5, y, z)
		self:setFov(35)
	end
end

function SurvivalSceneCameraComp:setFocus(x, y, z)
	local focusTrs = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(focusTrs, x, y, z)
	self._cameraTrace:SetTargetFocusPos(x, y, z)
	self._cameraTrace:ApplyDirectly()
end

function SurvivalSceneCameraComp:setFov(fov)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	fovRatio = math.max(fovRatio, 1)
	self._nowFov = fov

	self._cameraTrace:SetTargetFov(fov * fovRatio)
end

function SurvivalSceneCameraComp:checkIsInMiasma(isFirst)
	local isInMiasma = SurvivalMapModel.instance:isInMiasma()

	if isFirst then
		local dir = isInMiasma and math.random(5) or 0

		if dir > 2 then
			dir = dir - 6
		end

		self:setRotate(dir * 60)
		self._cameraTrace:ApplyDirectly()

		self._isInMiasma = isInMiasma
	elseif self._isInMiasma ~= isInMiasma then
		self._isInMiasma = isInMiasma
	else
		return false
	end

	return true
end

function SurvivalSceneCameraComp:setRotate(yawAngle, pitchAngle)
	if self._cameraCO then
		if not self._cameraCO.pitch then
			local pitch = 40

			self.yaw = yawAngle

			self._cameraTrace:SetTargetRotate(yawAngle, pitch)
		end
	end
end

function SurvivalSceneCameraComp:setPitchAngle(pitchAngle)
	self._cameraTrace:SetTargetRotate(self.yaw, pitchAngle)
end

function SurvivalSceneCameraComp:onSceneClose(...)
	self._isInMiasma = false
	self._rawcameraTrace.enabled = true

	gohelper.destroy(self._cameraTrace)

	self._cameraTrace = self._rawcameraTrace

	SurvivalSceneCameraComp.super.onSceneClose(self, ...)
end

return SurvivalSceneCameraComp
