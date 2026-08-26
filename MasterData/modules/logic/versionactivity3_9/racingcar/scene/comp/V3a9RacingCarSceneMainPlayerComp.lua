-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/comp/V3a9RacingCarSceneMainPlayerComp.lua

module("modules.logic.versionactivity3_9.racingcar.scene.comp.V3a9RacingCarSceneMainPlayerComp", package.seeall)

local V3a9RacingCarSceneMainPlayerComp = class("V3a9RacingCarSceneMainPlayerComp", BaseSceneComp)
local VehicleVisualScale = 4

function V3a9RacingCarSceneMainPlayerComp:onScenePrepared(sceneId, levelId)
	self._scene = GameSceneMgr.instance:getCurScene()
	self._sceneGo = self._scene.level:getSceneGo()

	self:_initTrackElements()
	self:_initMainPlayer()
	self:_initAIRacer()
	self:_initElementPickup()
	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.OnRestartGame, self._onRestartGame, self)
	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.OnRaceBegin, self._onRaceBegin, self)
	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.ChangeSpeedLine, self._onChangeSpeedLine, self)

	self._mainCamera = CameraMgr.instance:getMainCamera()
	self._unitCamera = CameraMgr.instance:getUnitCamera()

	if self._unitCamera then
		self._oriUnitCameraFov = self._unitCamera.fieldOfView or nil
	end

	self:_syncUnitCameraFov()
	LateUpdateBeat:Add(self._lateUpdate, self)
end

function V3a9RacingCarSceneMainPlayerComp:_initTrackElements()
	local trackConfig = V3a9RacingCarModel.instance:getTrackConfig()

	if not trackConfig then
		return
	end

	self._trackPath = TrackPath.FromConfig(trackConfig.path)
	self._elementSpawner = RacingTrackElementSpawner.New()

	local generatedElements = self._elementSpawner:generate(trackConfig, self._trackPath, self._sceneGo)

	V3a9RacingCarModel.instance:setElementSpawner(self._elementSpawner)
	V3a9RacingCarModel.instance:setGeneratedElements(generatedElements)
end

function V3a9RacingCarSceneMainPlayerComp:_initElementPickup()
	local trackConfig = V3a9RacingCarModel.instance:getTrackConfig()
	local generatedElements = V3a9RacingCarModel.instance:getGeneratedElements()

	if not trackConfig or not self._playerController then
		return
	end

	self._elementPickupManager = RacingTrackElementPickupManager.New()

	self._elementPickupManager:initialize(trackConfig, generatedElements, self._playerController, self._aiRacers, self._trackPath)
	V3a9RacingCarModel.instance:setElementPickupManager(self._elementPickupManager)
end

function V3a9RacingCarSceneMainPlayerComp:_initAIRacer()
	local trackConfig = V3a9RacingCarModel.instance:getTrackConfig()
	local generatedElements = V3a9RacingCarModel.instance:getGeneratedElements()
	local aiRacers = V3a9RacingCarModel.instance:getAiRacers()
	local aiRacersList = string.splitToNumber(aiRacers, "#")

	self._aiRacers = {}
	self._aiTailWakeFeedbacks = {}
	self._aiPresentations = {}

	for i, v in ipairs(trackConfig.aiRacers) do
		local aiRacerConfig = lua_racing_racer.configDict[aiRacersList[i]]

		if not aiRacerConfig then
			logError("aiRacerConfig not found: ", tostring(aiRacersList[i]), i, tostring(aiRacers))

			aiRacerConfig = V3a9RacingCarModel.instance:getMainPlayerRacer()
		end

		local aiRacer = self._scene.preloader:getResource(V3a9RacingCarScenePreloadGOWork.getDolphinPrefab(aiRacerConfig.dolphinPrefab))
		local aiRacerGo = gohelper.clone(aiRacer, self._sceneGo, "aiRacer" .. i)

		aiRacerGo.transform.localScale = Vector3(VehicleVisualScale, VehicleVisualScale, VehicleVisualScale)

		local aiRacerController = MonoHelper.addLuaComOnceToGo(aiRacerGo, AiRacerController)

		aiRacerController:initRacerConfig(aiRacerConfig)

		local startLane = i

		aiRacerController:initialize(trackConfig, v, self._trackPath, generatedElements, nil, startLane)
		self:_addAIRacerPresentation(aiRacerGo, aiRacerController)
		table.insert(self._aiRacers, aiRacerController)
	end

	V3a9RacingCarModel.instance:setAIRacers(self._aiRacers)
end

function V3a9RacingCarSceneMainPlayerComp:_addAIRacerPresentation(aiRacerGo, aiRacerController)
	if gohelper.isNil(aiRacerGo) or not aiRacerController then
		return
	end

	local tailWakeFeedback = MonoHelper.addNoUpdateLuaComOnceToGo(aiRacerGo, RacingBurstFeedback)

	if tailWakeFeedback then
		tailWakeFeedback:initializeTailWakeOnly(aiRacerController)
		table.insert(self._aiTailWakeFeedbacks, tailWakeFeedback)
	else
		logError("V3a9RacingCarSceneMainPlayerComp:_addAIRacerPresentation tail wake failed")
	end

	local presentation = MonoHelper.addNoUpdateLuaComOnceToGo(aiRacerGo, RacingSpecialTrackAirbornePresentation)

	if presentation then
		presentation:initialize(aiRacerController)
		table.insert(self._aiPresentations, presentation)
	else
		logError("V3a9RacingCarSceneMainPlayerComp:_addAIRacerPresentation vehicle presentation failed")
	end
end

function V3a9RacingCarSceneMainPlayerComp:_initMainPlayer()
	local path = V3a9RacingCarScenePreloadGOWork.getDolphinPrefab(V3a9RacingCarModel.instance:getMainPlayerRacer().dolphinPrefab)
	local mainPlayer = self._scene.preloader:getResource(path)

	self._mainPlayerGo = gohelper.clone(mainPlayer, self._sceneGo, "mainPlayer")
	self._mainPlayerGo.transform.localScale = Vector3(VehicleVisualScale, VehicleVisualScale, VehicleVisualScale)

	self:_addPlayerVehicleController()
	self:_addPlayerCameraController()
	self:_addBurstFeedback()
	self:_addLaunchFeedback()
	self:_addSpecialTrackAirbornePresentation()
	self:_addUltimatePresentation()
end

function V3a9RacingCarSceneMainPlayerComp:_lateUpdate()
	if V3a9RacingCarModel.instance:isRaceFinished() then
		return
	end

	local deltaTime = Time.deltaTime
	local isRacing = V3a9RacingCarModel.instance:isRacing()

	if not isRacing and self._playerController then
		self._playerController:updateVisualPose()
	end

	if self._cameraController then
		self._cameraController:lateUpdate(deltaTime)
	end

	if not isRacing then
		self:_syncUnitCameraFov()

		return
	end

	if self._burstFeedback then
		self._burstFeedback:lateUpdate(deltaTime)
	end

	if self._launchFeedback then
		self._launchFeedback:lateUpdate(deltaTime)
	end

	if self._ultimatePresentation then
		self._ultimatePresentation:lateUpdate(deltaTime)
	end

	if self._specialTrackAirbornePresentation then
		self._specialTrackAirbornePresentation:lateUpdate(deltaTime)
	end

	if self._aiTailWakeFeedbacks then
		for _, feedback in ipairs(self._aiTailWakeFeedbacks) do
			feedback:lateUpdate(deltaTime)
		end
	end

	if self._aiPresentations then
		for _, presentation in ipairs(self._aiPresentations) do
			presentation:lateUpdate(deltaTime)
		end
	end

	if self._elementPickupManager then
		self._elementPickupManager:update(deltaTime)
	end

	self:_syncUnitCameraFov()
end

function V3a9RacingCarSceneMainPlayerComp:_syncUnitCameraFov()
	if self._unitCamera and self._mainCamera then
		self._unitCamera.fieldOfView = self._mainCamera.fieldOfView
	end
end

function V3a9RacingCarSceneMainPlayerComp:_addPlayerVehicleController()
	if gohelper.isNil(self._mainPlayerGo) then
		return
	end

	local controller = MonoHelper.addLuaComOnceToGo(self._mainPlayerGo, PlayerVehicleController)

	self._playerController = controller

	self._playerController:initRacerConfig(V3a9RacingCarModel.instance:getMainPlayerRacer())
	controller:initialize(self._trackPath)
	V3a9RacingCarModel.instance:setPlayerVehicleController(controller)
end

function V3a9RacingCarSceneMainPlayerComp:_addPlayerCameraController()
	self.cameraTrace = CameraMgr.instance:getCameraTrace()
	self.cameraTrace.EnableTrace = false

	local camera = CameraMgr.instance:getMainCamera()

	self._cameraController = MonoHelper.addNoUpdateLuaComOnceToGo(self._mainPlayerGo, RacingChaseCamera, camera)

	local trackConfig = V3a9RacingCarModel.instance:getTrackConfig()

	if trackConfig then
		self._cameraController:initialize(trackConfig)
	end

	self._cameraController:setTarget(self._playerController)

	local animatorInst = self._scene.preloader:getResource(V3a9RacingCarScenePreloader.CameraAnim)
	local animator = CameraMgr.instance:getCameraRootAnimator()

	animator.runtimeAnimatorController = animatorInst
	animator.enabled = false
	self._cameraRootAnimator = animator
end

function V3a9RacingCarSceneMainPlayerComp:_addBurstFeedback()
	if gohelper.isNil(self._mainPlayerGo) or not self._playerController then
		return
	end

	self._burstFeedback = MonoHelper.addNoUpdateLuaComOnceToGo(self._mainPlayerGo, RacingBurstFeedback)

	if not self._burstFeedback then
		logError("V3a9RacingCarSceneMainPlayerComp:_addBurstFeedback failed")

		return
	end

	self._burstFeedback:initialize(self._playerController)
end

function V3a9RacingCarSceneMainPlayerComp:_addLaunchFeedback()
	if gohelper.isNil(self._mainPlayerGo) or not self._playerController then
		return
	end

	self._launchFeedback = MonoHelper.addNoUpdateLuaComOnceToGo(self._mainPlayerGo, RacingLaunchFeedback)

	if not self._launchFeedback then
		logError("V3a9RacingCarSceneMainPlayerComp:_addLaunchFeedback failed")

		return
	end

	self._launchFeedback:initialize(self._playerController)
end

function V3a9RacingCarSceneMainPlayerComp:_addSpecialTrackAirbornePresentation()
	if gohelper.isNil(self._mainPlayerGo) or not self._playerController then
		return
	end

	self._specialTrackAirbornePresentation = MonoHelper.addNoUpdateLuaComOnceToGo(self._mainPlayerGo, RacingSpecialTrackAirbornePresentation)

	if not self._specialTrackAirbornePresentation then
		logError("V3a9RacingCarSceneMainPlayerComp:_addSpecialTrackAirbornePresentation failed")

		return
	end

	self._specialTrackAirbornePresentation:initialize(self._playerController)
end

function V3a9RacingCarSceneMainPlayerComp:_addUltimatePresentation()
	if gohelper.isNil(self._mainPlayerGo) or not self._playerController or not self._specialTrackAirbornePresentation then
		return
	end

	self._ultimatePresentation = MonoHelper.addNoUpdateLuaComOnceToGo(self._mainPlayerGo, RacingUltimatePresentation)

	if not self._ultimatePresentation then
		logError("V3a9RacingCarSceneMainPlayerComp:_addUltimatePresentation failed")

		return
	end

	self._ultimatePresentation:initialize(self._playerController, self._specialTrackAirbornePresentation)
end

function V3a9RacingCarSceneMainPlayerComp:onSceneClose(sceneId, levelId)
	LateUpdateBeat:Remove(self._lateUpdate, self)

	self.cameraTrace = CameraMgr.instance:getCameraTrace()
	self.cameraTrace.EnableTrace = true

	if self._unitCamera and self._oriUnitCameraFov then
		self._unitCamera.fieldOfView = self._oriUnitCameraFov
	end

	self._unitCamera = nil
	self._mainCamera = nil
	self._oriUnitCameraFov = nil

	V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.OnRestartGame, self._onRestartGame, self)
	V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.OnRaceBegin, self._onRaceBegin, self)
	V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.ChangeSpeedLine, self._onChangeSpeedLine, self)

	if self._burstFeedback then
		self._burstFeedback:onDestroy()
	end

	if self._launchFeedback then
		self._launchFeedback:onDestroy()
	end

	if self._ultimatePresentation then
		self._ultimatePresentation:onDestroy()
	end

	if self._specialTrackAirbornePresentation then
		self._specialTrackAirbornePresentation:onDestroy()
	end

	if self._aiTailWakeFeedbacks then
		for _, feedback in ipairs(self._aiTailWakeFeedbacks) do
			feedback:onDestroy()
		end
	end

	if self._aiPresentations then
		for _, presentation in ipairs(self._aiPresentations) do
			presentation:onDestroy()
		end
	end

	if not gohelper.isNil(self._mainPlayerGo) then
		gohelper.destroy(self._mainPlayerGo)

		self._mainPlayerGo = nil
	end

	self._playerController = nil
	self._cameraController = nil
	self._specialTrackAirbornePresentation = nil
	self._ultimatePresentation = nil
	self._burstFeedback = nil
	self._launchFeedback = nil
	self._aiTailWakeFeedbacks = nil
	self._aiPresentations = nil

	if self._elementPickupManager then
		self._elementPickupManager:dispose()

		self._elementPickupManager = nil
	end

	if self._elementSpawner then
		self._elementSpawner:dispose()

		self._elementSpawner = nil
	end

	self._aiRacers = nil
	self._trackPath = nil

	if self._cameraRootAnimator then
		self._cameraRootAnimator.enabled = true

		self._cameraRootAnimator:Play("v3a9_jingsu_sdx_reset", 0, 0)

		self._cameraRootAnimator.runtimeAnimatorController = nil
		self._cameraRootAnimator = nil
	end
end

function V3a9RacingCarSceneMainPlayerComp:_onRestartGame()
	if self._cameraController then
		self._cameraController:resetForRestart()
	end

	if self._burstFeedback then
		self._burstFeedback:resetForRestart()
	end

	if self._launchFeedback then
		self._launchFeedback:resetForRestart()
	end

	if self._ultimatePresentation then
		self._ultimatePresentation:resetForRestart()
	end

	if self._specialTrackAirbornePresentation then
		self._specialTrackAirbornePresentation:resetForRestart()
	end

	if self._aiTailWakeFeedbacks then
		for _, feedback in ipairs(self._aiTailWakeFeedbacks) do
			feedback:resetForRestart()
		end
	end

	if self._aiPresentations then
		for _, presentation in ipairs(self._aiPresentations) do
			presentation:resetForRestart()
		end
	end

	if self._cameraRootAnimator.enabled then
		self._cameraRootAnimator:Play("v3a9_jingsu_sdx_reset", 0, 0)
	end
end

function V3a9RacingCarSceneMainPlayerComp:_onChangeSpeedLine(value)
	if self._cameraRootAnimator then
		self._cameraRootAnimator.enabled = true

		if value <= 0 or value > 2 then
			self._cameraRootAnimator:Play("v3a9_jingsu_sdx_reset", 0, 0)
		else
			self._cameraRootAnimator:Play("v3a9_jingsu_sdx" .. value, 0, 0)
		end
	end
end

function V3a9RacingCarSceneMainPlayerComp:_onRaceBegin()
	local skillMgr = RacingCarSkillManager.instance

	if self._playerController then
		skillMgr:clearPassiveSkills(self._playerController)

		local talentList = V3a9RacingTalentModel.instance:getUnlockTalents()

		for i, v in pairs(talentList) do
			if SLFramework.FrameworkSettings.IsEditor then
				logNormal("executeTalentSkills talent id: " .. v.gift_point .. " effect: " .. v.effect)
			end

			local talentSkills = string.splitToNumber(v.effect, "|")

			skillMgr:executeInitSkills(self._playerController, talentSkills)
		end

		local playerEffectIds = self:_getInitEffectIds(self._playerController)

		skillMgr:executeInitSkills(self._playerController, playerEffectIds)

		if SLFramework.FrameworkSettings.IsEditor then
			logNormal("executeInitSkills", tostring(table.concat(playerEffectIds, ",")))
		end
	end

	if self._aiRacers then
		for _, aiCtrl in ipairs(self._aiRacers) do
			if aiCtrl then
				skillMgr:clearPassiveSkills(aiCtrl)

				local aiEffectIds = self:_getInitEffectIds(aiCtrl)

				skillMgr:executeInitSkills(aiCtrl, aiEffectIds)
			end
		end
	end
end

function V3a9RacingCarSceneMainPlayerComp:_getInitEffectIds(controller)
	local racerConfig = controller:getRacerConfig()

	if racerConfig and racerConfig.initialEffect then
		return string.splitToNumber(racerConfig.initialEffect, "|")
	end

	return nil
end

return V3a9RacingCarSceneMainPlayerComp
