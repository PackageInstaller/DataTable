-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterpreview/scene/CharacterPreviewSceneLight.lua

module("logic.extensions.characterpreview.scene.CharacterPreviewSceneLight", package.seeall)

local M = class("CharacterPreviewSceneLight", SceneComponentBase)
local kLightName = "character_directional_light"

function M:onInit()
	self._characterLightWrapper = nil
	self._viewrAndModLight = nil
end

function M:onEnterScene(sceneId, bornX, bornZ)
	return
end

function M:onExitScene()
	self._characterLightWrapper = nil
	self._viewrAndModLight = nil
end

function M:onEnterSceneFinished()
	self._goHero = self._scene.stage:getHero()

	self:_initCharacterLight()
	self:_addViewerAndModelLight(self._goHero)
	self:_setHeroHQShadow(self._goHero, true)
end

function M:_initCharacterLight()
	local light = self._scene.stage:getLight(kLightName)

	if not light or goutil.isNil(light) then
		return
	end

	self._characterLightWrapper = light
	self._characterLightWrapper.isRotationEnable = false
	self._viewrAndModLight = SpaceX.ViewerAndModLight.Get(self._characterLightWrapper.gameObject)
end

function M:_addViewerAndModelLight(prefabInst)
	local faceGo = CharacterUtil.getFaceBindGo(prefabInst)

	if goutil.isNil(faceGo) and isInEditorMode then
		printError("模型:" .. prefabInst.name .. "无法找到 face 绑点。")

		return
	end

	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local viewer = self._viewrAndModLight

	viewer.isReverse = true
	viewer.isEnalbleRotare = false
	viewer.offsetY = 40

	viewer:SetCamera(mainCameraTarget:getGO())
	viewer:SetMod(faceGo)
	viewer:SetReferentialMod(prefabInst.transform)
end

function M:_setHeroHQShadow(prefabInst, showShadow)
	if not self._characterLightWrapper or goutil.isNil(self._characterLightWrapper) then
		return
	end

	if not prefabInst or goutil.isNil(prefabInst) then
		return
	end

	local light = self._viewrAndModLight:CreateHBShadowLight()

	SpaceX.SceneRenderingSettings.Instance:ApplyHighQualityShadow(showShadow, prefabInst.gameObject, light)
end

return M
