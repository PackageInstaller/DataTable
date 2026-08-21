-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterpreview/scene/CharacterPreviewSceneStage.lua

module("logic.extensions.characterpreview.scene.CharacterPreviewSceneStage", package.seeall)

local M = class("CharacterPreviewSceneStage", SceneStageBase)
local kAirtightGo = "Main scene enviroment wrapper"
local kDefaultAnim = MainPerformEnum.AnimFullName.ChoukaIdle

function M:onInit()
	self._resLoader = false
	self._sceneName = false
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self.super.onEnterScene(self, sceneId, bornX, bornZ)
	self:_setEvent(true)
end

function M:onExitScene()
	self.super.onExitScene(self)
	self:_setEvent(false)
end

function M:load(sceneId)
	self._resLoader = self._resLoader or MultiResLoader.New()

	local sceneCO = SceneConfig.instance:getSceneCO(sceneId)

	self._sceneName = SceneCOUtil.getSceneName(sceneCO)

	local scenePath = GameUrl.getSceneUrl(sceneCO.resPath)

	self._heroId = CharacterPreviewModel.instance:getCurHeroId()

	local heroCfgInfo = CharacterConfig.instance:getCfgInfoByID(self._heroId)

	self._modelId = heroCfgInfo.modelId

	local modelCO = ModelConfig.instance:getModelConfig(self._modelId)

	self._modelPath = GameUrl.getMainSceneMeshModelUrl(modelCO.mainSceneResName)
	self._idleAnimPath = GameUrl.getMainSceneMeshModelClipUrl(modelCO.mainSceneResName, kDefaultAnim)
	self._resList = {
		scenePath,
		self._idleAnimPath,
		self._modelPath
	}

	self._resLoader:setResPaths(self._resList)
	self._resLoader:load(self._onAllResourceLoaded, nil, self)
end

function M:_onAllResourceLoaded()
	if not self._resLoader:isAllSuccess() and enableErrorLog then
		printError("character preview scene load failed!")
	end

	SceneLoadUtils.SetActiveScene(self._sceneName)
	GameObjectUtils.SetSceneActive(self._sceneName, true)
	self:_onSceneResReady()
	self:_onAllLoaded()
end

function M:unload()
	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:onLeaveScene()
	self:onExitScene()
end

function M:onReturnScene()
	self:load(self._scene:getSceneId())
end

function M:getSceneEnviromentAnimation()
	if goutil.isNil(self._sceneEnviromentAnimation) then
		local goAirtightAnim = GameObjectUtils.FindChildRecursivelyBySceneName(self._sceneName, 2, kAirtightGo)

		self._sceneEnviromentAnimation = goAirtightAnim:GetComponent(ComponentType.Animation)
	end

	return self._sceneEnviromentAnimation
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HERO_PREVIEW_CAM_CTRL, self._onCamCtrl, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_PREVIEW_CAM_CTRL, self._onCamCtrl, self)
	end
end

function M:_onSceneResReady()
	self._resInstance = {}

	local modelRes = self:_getResource(self._modelPath)
	local modelGo = goutil.clone(modelRes:GetMainAsset())

	self:_setHeroPos(modelGo)
	self:_setHeroAnim(modelGo)
	self:_setAnchor(modelGo)
	self:_setMagicCloth(modelGo)
	self:_setCamera()
	self:_setLookAtIK(modelGo)
end

function M:_setHeroPos(modelGo)
	self._resInstance[self._modelPath] = modelGo

	local transfInfo = CharacterPreviewConfig.instance:getPreviewTransfInfo(self._heroId)
	local pos = transfInfo.pos
	local rot = transfInfo.rot

	Astral.TransformUtil.SetLocalPos(modelGo.transform, pos.x, pos.y, pos.z)
	Astral.TransformUtil.SetLocalRotation(modelGo.transform, rot.x, rot.y, rot.z)
end

function M:_setHeroAnim(modelGo)
	local animationPlayer = AnimationPlayer.Get(modelGo)
	local animRes = self:_getResource(self._idleAnimPath)

	if animRes then
		local animClip = animRes:GetMainAsset()

		animationPlayer:ReplaceClip(kDefaultAnim, animClip)
		animationPlayer:PlayAnimation(kDefaultAnim, true, true)
		animationPlayer:Evaluate()
	end
end

function M:_setAnchor(modelGo)
	local xinMao = Astral.SimpleLuaComponentContainer.Add(modelGo.gameObject, UnitCompHeroXinMao)

	xinMao:setJudgeAirtightPreviewState(true)
	xinMao:setInfo(self._modelId, modelGo.gameObject)
end

function M:_setLookAtIK(modelGo)
	local lookAtIK = Astral.SimpleLuaComponentContainer.Add(modelGo.gameObject, UnitCompHeroLookAtIK)

	lookAtIK:setEnableLookAtIk(false)
end

function M:_setCamera()
	local camCo = CharacterPreviewConfig.instance:getCameraCo(self._heroId)
	local camPos = camCo.pos
	local camRot = camCo.rot

	VirtualCameraMgr.instance:forceSetFollowPosition(camPos.x, camPos.y, camPos.z)

	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

	if virtualCamera:getMainGO() and not goutil.isNil(virtualCamera:getMainGO()) then
		VirtualCameraMgr.instance:setFieldOfView(camCo.fov)
		virtualCamera:doRotation(camRot.x, camRot.y, camRot.z, 0)
	else
		virtualCamera:setLoadedCallback(self._onCameraLoad, self)
	end
end

function M:_onCameraLoad()
	local camCo = CharacterPreviewConfig.instance:getCameraCo(self._heroId)
	local rot = camCo.rot
	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

	VirtualCameraMgr.instance:setFieldOfView(camCo.fov)
	virtualCamera:doRotation(rot.x, rot.y, rot.z, 0)
	virtualCamera:setLoadedCallback(nil, nil)
end

function M:_getResource(resPath)
	return self._resLoader:getResource(resPath)
end

function M:_onCamCtrl(_, camCo)
	local pos = camCo.pos
	local rot = camCo.rot

	VirtualCameraMgr.instance:forceSetFollowPosition(pos.x, pos.y, pos.z)
	VirtualCameraMgr.instance:setFieldOfView(camCo.fov)

	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

	virtualCamera:doRotation(rot.x, rot.y, rot.z, 0)
end

function M:_setMagicCloth(modelGo)
	local magicalCloth = SpaceX.MagicaCloth2Utils.Get(modelGo)

	magicalCloth:SetEnableAllMagicaCloth(true)
end

function M:getLight(lightName)
	local goLight = GameObjectUtils.FindChildRecursivelyBySceneName(self._sceneName, 5, lightName)

	if goLight then
		return goLight:GetComponent(typeof(SpaceX.LightWrapper))
	end

	return nil
end

function M:getHero()
	return self._resInstance[self._modelPath]
end

return M
