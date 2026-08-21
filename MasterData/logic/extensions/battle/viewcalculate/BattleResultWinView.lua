-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleResultWinView.lua

module("logic.extensions.battle.viewcalculate.BattleResultWinView", package.seeall)

local M = class("BattleResultWinView", ViewComponent)

function M:buildUI()
	self._successPanel = goutil.findChild(self.mainGO, "success")
	self._rtGo = goutil.findChild(self.mainGO, "rt")
	self._rawImage = self._rtGo:GetComponent(UIComponentType.RawImage)
	self._canvasGroup = self._rtGo:GetComponent(ComponentType.CanvasGroup)
	self._photo = Astral.PhotoBase.Add(self._rawImage.gameObject)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._captureTexture2D = false

	local failGo = goutil.findChild(self.mainGO, "fail")

	goutil.setActive(failGo, false)

	local failPanel = goutil.findChild(self.mainGO, "failPanel")

	goutil.setActive(failPanel, false)

	local rt = goutil.findChild(self.mainGO, "common_blur_rt")

	goutil.setActive(rt, false)
end

function M:destroyUI()
	self._successPanel = false
	self._rtGo = false
	self._rawImage = false
	self._canvasGroup = false
	self._photo = false
	self._guiAnimation = false
end

function M:onEnter()
	self._normalExit = false

	self:_startPlayAnimation()
end

function M:onExit()
	if not self._normalExit then
		BattleCalculateMgr.instance:stopVictoryPerformance()
	end

	self:_destroyCaptureTexture()
	self._canvasGroup:DOKill()
	removetimer(self._captureAndFadeOut, self)
	self._photo:TurnOff()
end

function M:_startPlayAnimation()
	goutil.setActive(self._successPanel, true)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("success")
	BattleAudioUtil.playSEByName("ui_battle_diaochawancheng")
	goutil.setActive(self._rtGo, false)
	settimer(2.8, self._captureAndFadeOut, self, false)
end

function M:_captureAndFadeOut()
	goutil.setActive(self._successPanel, false)
	goutil.setActive(self._rtGo, true)
	self:_tryCaptureWithData()
	self._rtGo.transform:DOScale(1.3, 0.5)

	local fadeoutTime = 1

	self._normalExit = false

	self._canvasGroup:DOFade(0, fadeoutTime):OnComplete(self._onShowFadeOutFinish, self)
	BattleCalculateMgr.instance:startVictoryPerformance()
end

function M:_onShowFadeOutFinish()
	self._normalExit = true

	self:close()
	ViewMgr.instance:open(ViewName.BattleCalculateNew)
end

function M:_updateImageSize()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform
	local width = math.ceil(rectTransform.rect.width)
	local height = math.ceil(rectTransform.rect.height)

	RectTransformUtils.SetSize(self._rawImage.transform, width, height)

	return width, height
end

function M:_tryCaptureWithData()
	local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	local position = kMainCamera.transform.position
	local eulerAngles = kMainCamera.transform.eulerAngles
	local fieldOfView = kMainCamera.fieldOfView
	local pX = position.x
	local pY = position.y
	local pZ = position.z
	local rX = eulerAngles.x
	local rY = eulerAngles.y
	local rZ = eulerAngles.z
	local fov = fieldOfView
	local width, height = self:_updateImageSize()

	goutil.setActive(self._rawImage.gameObject, true)
	self._photo:TurnOn(width, height, UnityEngine.RenderTextureFormat.ARGB32, 2)

	local cam = PhotoBaseExtension.GetCamera(self._photo)
	local offsetX, offsetY, offsetZ = TransformUtils.GetLocalPosition(cam.transform.parent, 0, 0, 0)

	PhotoBaseExtension.SetCameraTag(self._photo, "RTCamera")
	PhotoBaseExtension.SetCameraPerspective(self._photo, fov)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, true, SceneLayer.Default_Value)

	cam.cullingMask = Astral.LayerUtil.GetLayerMask(SceneLayer.Default_Value, SceneLayer.Unit_Value, Astral.LayerUtil.NameToLayer("UI"), Astral.LayerUtil.NameToLayer(SceneLayer.HighImportance))

	self._photo:SetCameraPosition(pX - offsetX, pY - offsetY, pZ - offsetZ)
	self._photo:SetCameraRotation(rX, rY, rZ)

	local captureRect = UnityEngine.Rect.New(0, 0, width, height)

	URPCameraUtils.CaptureScreenShotToFile(cam, captureRect, nil, self._onCaptureFinish, self)
end

function M:_onCaptureFinish(texture2D)
	if not self._rawImage then
		return
	end

	self:_destroyCaptureTexture()

	self._captureTexture2D = texture2D
	self._rawImage.texture = texture2D

	self._photo:TurnOff()
end

function M:_destroyCaptureTexture()
	if self._captureTexture2D then
		goutil.destroy(self._captureTexture2D)

		self._captureTexture2D = false
	end
end

return M
