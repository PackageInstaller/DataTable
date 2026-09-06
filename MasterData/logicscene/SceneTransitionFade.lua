-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/transition/SceneTransitionFade.lua

module("logicscene.scene.SceneTransitionFade", package.seeall)

local SceneTransitionFade = class("SceneTransitionFade", SceneTransitionBase)
local colorId = UnityEngine.Shader.PropertyToID("_Color")

function SceneTransitionFade:ctor()
	local res = rescache:GetResourceNoLoadIfNotExists(CommonResPath.SceneTransitionFade)
	local mainAsset = res:GetMainAsset()

	self._transitionGo = goutil.clone(mainAsset, "TransitionFade")
	self._transitionGo.layer = SceneLayer.UI_Value

	self._transitionGo:SetActive(false)

	res = rescache:GetResourceNoLoadIfNotExists(CommonResPath.SceneTransitionOutEff)
	mainAsset = res:GetMainAsset()
	self._transitionOutEff = goutil.clone(mainAsset, "TransitionOutEff")

	self._transitionOutEff:SetActive(false)
	Framework.TransformUtil.SetLocalScale(self._transitionOutEff.transform, 0.1, 0.1, 0.1)
	GoUtil.SetSortingOrder(self._transitionOutEff, 10)
end

function SceneTransitionFade:prepareTransition(preScene, currScene, isSwitchFestival)
	SceneTransitionFade.super.prepareTransition(self, preScene, currScene, isSwitchFestival)
	self:_clear()
	self:_playTranstionOutEff()
	self:_startLoadResources()
end

function SceneTransitionFade:onEnterFinished()
	ScenePreLoaderMgr.instance:clearExcept(self._currScene:getSceneId())

	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	self._fadeOut = AMFadeObject.StartFade(self._transitionGo, colorId, 0.5, 12, 0.5, 0, false)

	self._fadeOut:AddListener(self._onFadeoutFinish, self)
	SceneTransitionFade.super.onEnterFinished(self)
end

function SceneTransitionFade:_playTranstionOutEff()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	local go = mainPlayer.go
	local posx, posy, posz = Framework.TransformUtil.GetPos(go.transform, nil, nil, nil)

	Framework.TransformUtil.SetPos(self._transitionOutEff.transform, posx, posy, posz)
	mainPlayer:setVisible(self._isSwitchFestival or false)
	self._transitionOutEff:SetActive(not self._isSwitchFestival)
	settimer(0.5, self._onTransitionOutEffFinished, self)
end

function SceneTransitionFade:_onTransitionOutEffFinished()
	removetimer(self._onTransitionOutEffFinished, self)
	self:_captureScreen()
end

function SceneTransitionFade:_captureScreen()
	if not self._currScene then
		return
	end

	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()
	local snapshot = SceneSnapshot.SnapshotToTarget(mainCam.gameObject, self._transitionGo, 0, (SceneMgr.instance:isTransitionQualityHigh() or nil) and 0)

	snapshot:AddListener(self._onScreenCaptureFinish, self)
end

function SceneTransitionFade:_checkTransitionIn()
	if self._isLoadingFinished and self._birthOutEffFinished then
		self._transitionGo:SetActive(true)
		removetimer(self._startTransitionIn, self)
		settimer(0, self._startTransitionIn, self)
	end
end

function SceneTransitionFade:_startTransitionIn()
	removetimer(self._startTransitionIn, self)

	if not self._currScene then
		return
	end

	SceneMgr.instance:notifyEnterFinished()
end

function SceneTransitionFade:_onScreenCaptureFinish()
	if not self._currScene then
		return
	end

	self._birthOutEffFinished = true

	local uiCam = GlobalModel.instance.uiCamera
	local camSizeH = uiCam.orthographicSize * 2
	local camSizeW = uiCam.aspect * camSizeH
	local cx, cy, cz = Framework.TransformUtil.GetPos(uiCam.transform, nil, nil, nil)

	Framework.TransformUtil.SetPos(self._transitionGo.transform, cx, cy, cz + 1)
	Framework.TransformUtil.SetLocalScale(self._transitionGo.transform, camSizeW, camSizeH, 1)
	self:_checkTransitionIn()
end

function SceneTransitionFade:_startLoadResources()
	LoadingFacade.instance:setLoadingListener()
	self._currScene.stage:load(self._currScene:getSceneId(), self._onLoadingFinished, self)
end

function SceneTransitionFade:_onFadeoutFinish()
	self:_clear()
end

function SceneTransitionFade:_onLoadingFinished(progress, finished)
	if finished and progress >= 1 then
		self._isLoadingFinished = true

		self:_checkTransitionIn()
	end
end

function SceneTransitionFade:_clear()
	if self._fadeOut then
		self._fadeOut:RemoveListener()
		goutil.destroy(self._fadeOut)

		self._fadeOut = nil
	end

	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()

	SceneSnapshot.Clear(mainCam.gameObject)

	if self._transitionGo then
		self._transitionGo:SetActive(false)
	end

	if self._transitionOutEff then
		self._transitionOutEff:SetActive(false)
	end

	removetimer(self._startTransitionIn, self)
	removetimer(self._onTransitionOouEffFinished, self)

	self._isLoadingFinished = false
	self._birthOutEffFinished = false
end

function SceneTransitionFade:clear()
	if self._preScene then
		self._preScene:onExitFinished()
		self._preScene.stage:unload()
	end

	self:_clear()
	SceneTransitionFade.super.clear(self)
end

SceneTransitionFade.instance = SceneTransitionFade.New()

return SceneTransitionFade
