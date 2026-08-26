-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandGameScene.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameScene", package.seeall)

local CooperGarlandGameScene = class("CooperGarlandGameScene", BaseView)
local BEGIN_CUBE_SWITCH_TIME = 0.83
local BEGIN_ENTER_NEXT_ROUND_TIME = 1.8

function CooperGarlandGameScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CooperGarlandGameScene:addEvents()
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.ChangePanelAngle, self._onChangePanelAngle, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, self._onPlayEnterNextRoundAnim, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, self._onRemoveModeChange, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, self._onResetGame, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onFinishGuide, self)
end

function CooperGarlandGameScene:removeEvents()
	if self._panelAnimEvent then
		self._panelAnimEvent:RemoveEventListener("panelIn")
	end

	if self._sceneAnimEvent then
		self._sceneAnimEvent:RemoveEventListener("showBall")
	end

	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.ChangePanelAngle, self._onChangePanelAngle, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, self._onPlayEnterNextRoundAnim, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, self._onRemoveModeChange, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, self._onResetGame, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onFinishGuide, self)
end

function CooperGarlandGameScene:_onChangePanelAngle(x, y, lerpScale, isForceSet)
	if gohelper.isNil(self._transCube) then
		return
	end

	local isDoingClickGuide = GuideModel.instance:isDoingClickGuide()
	local isForbidGuides = GuideController.instance:isForbidGuides()
	local isInGuide = isDoingClickGuide and not isForbidGuides
	local isStopGame = CooperGarlandGameModel.instance:getIsStopGame()
	local isCanShowBall = CooperGarlandGameModel.instance:getSceneOpenAnimShowBall()

	if not isForceSet and (isStopGame or isInGuide or not isCanShowBall) then
		return
	end

	local angleX = y * self._cubeMaxAngle
	local angleY = -x * self._cubeMaxAngle

	TaskDispatcher.cancelTask(self._lerpRotation, self)

	if lerpScale and lerpScale > 0 then
		self._targetLerpAngle = {
			x = angleX,
			y = angleY,
			lerpScale = lerpScale
		}

		TaskDispatcher.runRepeat(self._lerpRotation, self, 0.01)
	else
		transformhelper.setLocalRotation(self._transCube, angleX, angleY, 0)
	end
end

function CooperGarlandGameScene:_lerpRotation()
	local curX, curY = transformhelper.getLocalRotation(self._transCube)

	if self._targetLerpAngle then
		if self._targetLerpAngle then
			local targetY = self._targetLerpAngle.y

			if not self._targetLerpAngle or curX == self._targetLerpAngle and curY == targetY then
				self._targetLerpAngle = nil

				TaskDispatcher.cancelTask(self._lerpRotation, self)

				return
			end

			transformhelper.setLocalRotationLerp(self._transCube, self._targetLerpAngle, targetY, 0, Time.deltaTime * self._targetLerpAngle.lerpScale)
		end
	end
end

function CooperGarlandGameScene:_onPlayEnterNextRoundAnim()
	local hasAnimPlay = false

	if self._sceneAnimator then
		self._sceneAnimator:Play("switch", 0, 0)

		hasAnimPlay = true

		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_pkls_star_light)
	end

	local gameId = CooperGarlandGameModel.instance:getGameId()
	local cubeSwitchAnim = CooperGarlandConfig.instance:getCubeSwitchAnim(gameId)

	if not string.nilorempty(cubeSwitchAnim) and self._cubeAnimator and self._cubeAnimatorPlayer then
		TaskDispatcher.cancelTask(self._playCubeSwitchAnim, self)
		TaskDispatcher.runDelay(self._playCubeSwitchAnim, self, BEGIN_CUBE_SWITCH_TIME)

		hasAnimPlay = true
	end

	if hasAnimPlay then
		TaskDispatcher.cancelTask(CooperGarlandController.enterNextRound, CooperGarlandController.instance)
		TaskDispatcher.runDelay(CooperGarlandController.enterNextRound, CooperGarlandController.instance, BEGIN_ENTER_NEXT_ROUND_TIME)
	else
		CooperGarlandController.instance:enterNextRound()
	end

	self:refresh()
end

function CooperGarlandGameScene:_playCubeSwitchAnim()
	local gameId = CooperGarlandGameModel.instance:getGameId()
	local cubeSwitchAnim = CooperGarlandConfig.instance:getCubeSwitchAnim(gameId)

	self._cubeAnimator.enabled = true

	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_cube_turn)
	self._cubeAnimatorPlayer:Play(cubeSwitchAnim, self._playCubeAnimFinished, self)
end

function CooperGarlandGameScene:_onRemoveModeChange()
	self:refresh()
end

function CooperGarlandGameScene:_onResetGame()
	self:refresh()
end

function CooperGarlandGameScene:_onFinishGuide(guideId)
	local mapId = CooperGarlandGameModel.instance:getMapId()
	local compId = CooperGarlandConfig.instance:getStoryCompId(mapId, guideId)

	if compId then
		CooperGarlandGameEntityMgr.instance:removeComp(compId)
		CooperGarlandController.instance:setStopGame(false)
	end
end

function CooperGarlandGameScene:_editableInitView()
	self._targetLerpAngle = nil
	self._originalFOV = nil
	self._cubeMaxAngle = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubeMaxAngle, true)
	self._originalGravity = UnityEngine.Physics.gravity

	local gravity = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.Gravity, true)

	UnityEngine.Physics.gravity = Vector3.New(0, 0, gravity)

	self:createScene()
	MainCameraMgr.instance:addView(self.viewName, self.initCamera, nil, self)
end

function CooperGarlandGameScene:initCamera()
	local mainCamera = CameraMgr.instance:getMainCamera()
	local cameraTrs = CameraMgr.instance:getMainCameraTrs()

	self._originalFOV = self._originalFOV or mainCamera.fieldOfView

	local configFov = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CameraFOV, true)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	mainCamera.fieldOfView = Mathf.Clamp(configFov * fovRatio, configFov, CooperGarlandEnum.Const.CameraMaxFov)

	local posZ = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CameraPosZ, true)

	transformhelper.setLocalPos(cameraTrs, 0, 0, posZ)
	transformhelper.setLocalRotation(cameraTrs, 0, 0, 0)
end

function CooperGarlandGameScene:createScene()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New(self.__cname)

	gohelper.addChild(sceneRoot, self._sceneRoot)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	if self._loader then
		self._loader:dispose()
	end

	self._loader = PrefabInstantiate.Create(self._sceneRoot)

	local gameId = CooperGarlandGameModel.instance:getGameId()
	local sceneUrl = CooperGarlandConfig.instance:getScenePath(gameId)

	if not string.nilorempty(sceneUrl) then
		UIBlockMgr.instance:startBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)
		self._loader:startLoad(sceneUrl, self._onLoadSceneFinish, self)
	end
end

function CooperGarlandGameScene:_onLoadSceneFinish()
	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)

	if not self._loader then
		return
	end

	self._sceneGo = self._loader:getInstGO()
	self._sceneAnimator = self._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	self._sceneAnimEvent = self._sceneGo:GetComponent(gohelper.Type_AnimationEventWrap)

	self._sceneAnimEvent:AddEventListener("showBall", self._onShowBall, self)

	self._cubeGo = gohelper.findChild(self._sceneGo, "#go_cube")
	self._transCube = self._cubeGo.transform
	self._cubeAnimator = self._cubeGo:GetComponent(typeof(UnityEngine.Animator))
	self._cubeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._cubeGo)

	local cubePosStr = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubePos)
	local cubePos = string.splitToNumber(cubePosStr, "#")

	transformhelper.setLocalPos(self._transCube, cubePos[1], cubePos[2], cubePos[3])

	self._uiNode = gohelper.findChild(self._sceneGo, "#go_cube/#go_ui")

	local ballRoot = gohelper.findChild(self._sceneGo, "#go_cube/#go_ball")

	CooperGarlandGameEntityMgr.instance:tryInitMap(self._uiNode, ballRoot, self._onInitMap, self)

	local sceneAnim = "open"
	local gameId = CooperGarlandGameModel.instance:getGameId()
	local cubeOpenAnim = CooperGarlandConfig.instance:getCubeOpenAnim(gameId)

	if self._cubeAnimatorPlayer and self._cubeAnimator then
		if string.nilorempty(cubeOpenAnim) then
			self:_playCubeAnimFinished()
		else
			sceneAnim = "open1"

			AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_cube_turn)
			self._cubeAnimatorPlayer:Play(cubeOpenAnim, self._playCubeAnimFinished, self)
		end
	end

	if self._sceneAnimator then
		self._sceneAnimator:Play(sceneAnim, 0, 0)
	end
end

function CooperGarlandGameScene:_onInitMap()
	local panelGo = CooperGarlandGameEntityMgr.instance:getPanelGo()

	if gohelper.isNil(panelGo) then
		return
	end

	self._panelCanvas = panelGo:GetComponent(typeof(UnityEngine.Canvas))

	local camera = CameraMgr.instance:getMainCamera()

	if camera then
		self._panelCanvas.worldCamera = camera
	end

	self._simgPanel = gohelper.findChildSingleImage(panelGo, "")

	if self._simgPanel then
		local gameId = CooperGarlandGameModel.instance:getGameId()
		local panelImg = CooperGarlandConfig.instance:getPanelImage(gameId)

		self._simgPanel:LoadImage(panelImg)
	end

	self._goRemoveModeMask = gohelper.findChild(panelGo, "#go_removeModeMask")
	self._panelAnimEvent = panelGo:GetComponent(gohelper.Type_AnimationEventWrap)

	self._panelAnimEvent:AddEventListener("panelIn", self._onPanelIn, self)
	self:refresh()
end

function CooperGarlandGameScene:_playCubeAnimFinished()
	if self._cubeAnimator then
		self._cubeAnimator.enabled = false
	end
end

function CooperGarlandGameScene:_onPanelIn()
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_next)
end

function CooperGarlandGameScene:_onShowBall()
	CooperGarlandGameModel.instance:setSceneOpenAnimShowBall(true)
	CooperGarlandGameEntityMgr.instance:resetBall()
end

function CooperGarlandGameScene:onUpdateParam()
	return
end

function CooperGarlandGameScene:onOpen()
	return
end

function CooperGarlandGameScene:refresh()
	self:refreshRemoveModeMask()
end

function CooperGarlandGameScene:refreshRemoveModeMask()
	local isRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(self._goRemoveModeMask, isRemoveMode)
end

function CooperGarlandGameScene:onClose()
	TaskDispatcher.cancelTask(self._lerpRotation, self)
	TaskDispatcher.cancelTask(self._playCubeSwitchAnim, self)
	TaskDispatcher.cancelTask(CooperGarlandController.enterNextRound, CooperGarlandController.instance)
end

function CooperGarlandGameScene:onDestroyView()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._simgPanel then
		self._simgPanel:UnLoadImage()
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end

	self:resetCamera()

	UnityEngine.Physics.gravity = self._originalGravity
	self._originalGravity = nil

	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)
end

local ORIGINAL_FOV = 35

function CooperGarlandGameScene:resetCamera()
	local mainCamera = CameraMgr.instance:getMainCamera()
	local cameraTrs = CameraMgr.instance:getMainCameraTrs()

	mainCamera.fieldOfView = self._originalFOV or ORIGINAL_FOV

	transformhelper.setLocalPos(cameraTrs, 0, 0, 0)

	self._originalFOV = nil
end

return CooperGarlandGameScene
