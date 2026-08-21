-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneLight.lua

module("logic.extensions.mainui.scene.component.MainSceneLight", package.seeall)

local M = class("MainSceneLight", SceneComponentBase)
local LightOriginRotation = Vector3.New(20, 140, 0)

function M:onInit()
	self._dirtyMark = {}
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self:_setEvent(true)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:_updateAirtightTime()
end

function M:onExitScene()
	self:_releaseTween()
	self:_setEvent(false)

	self._characterLightWrapper = nil
end

function M:onLeaveScene(needUnloadRes)
	self:_releaseTween()

	self._characterLightWrapper = nil
end

function M:onReturnScene(needUnloadRes)
	return
end

function M:onReturnSceneFinished(needUnloadRes)
	self:onEnterScene(self._scene:getSceneId(), self._scene:getBornX(), self._scene:getBornZ())
end

function M:_releaseTween()
	if self._tweenLight then
		self._tweenLight:Kill(false)
	end

	self._tweenLight = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAirtightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_SHOW_UP, self._handleHeroShowUp, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_LIGHT_ENABLE_ROTATE, self._handleViewModelLightAutoRotate, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_LIGHT_SET_DIRTY, self._handleLightSetDirty, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_LIGHT_RESET, self._handleLightReset, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_SET_HQ_SHADOW, self._handleHeroSetHQShadow, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAirtightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_SHOW_UP, self._handleHeroShowUp, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_LIGHT_ENABLE_ROTATE, self._handleViewModelLightAutoRotate, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_LIGHT_SET_DIRTY, self._handleLightSetDirty, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_LIGHT_RESET, self._handleLightReset, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_SET_HQ_SHADOW, self._handleHeroSetHQShadow, self)
	end
end

function M:_handleAirtightStateChange(e, isInAirtightTime, airtightEndTS)
	self:_updateAirtightTime(isInAirtightTime, 1)
end

function M:_handleHeroShowUp(e, pointId, heroId, unitHero, defaultAnimState)
	local p = MainPerformEnum.ElementPointAdjutant

	if pointId == p then
		local unitAdjutant = unitHero

		if not unitAdjutant then
			return
		end

		local prefabInst = unitAdjutant.meshModel:getResInst(MainPerformEnum.ResTyp.Model)

		self:addViewerAndModelLight(prefabInst)
		self:_setHeroHQShadow(prefabInst, true)
	end
end

function M:_handleViewModelLightAutoRotate(_, enable)
	self:_initCharacterLight()

	if self._viewrAndModLight and not goutil.isNil(self._viewrAndModLight) then
		self._viewrAndModLight.enabled = enable
	end

	if self._characterLightWrapper and not goutil.isNil(self._characterLightWrapper) then
		if not enable then
			self._characterLightWrapper:ApplyOriginalColorAndRotation()
		end

		self._characterLightWrapper.isRotationEnable = not enable
	end
end

function M:_handleLightSetDirty(e, info)
	local dirtyMark = info.dirtyMark
	local isSet = info.setDirty

	if isSet then
		self._dirtyMark[dirtyMark] = 1
	elseif self._dirtyMark[dirtyMark] then
		self._dirtyMark[dirtyMark] = nil

		if TableUtil.getLen(self._dirtyMark) == 0 then
			self:_resetLightWrapper()
			self:_handleHeroSetHQShadow()
		end
	end
end

function M:_handleLightReset(e)
	self:_resetLightWrapper()
end

function M:_handleHeroSetHQShadow(e)
	local unitAdjutant = MainScenePerformUtil.getUnitHeroByPoint(MainPerformEnum.ElementPointAdjutant)

	if unitAdjutant then
		local prefabInst = unitAdjutant.meshModel:getResInst(MainPerformEnum.ResTyp.Model)

		self:_setHeroHQShadow(prefabInst, true)
	end
end

function M:_resetLightWrapper()
	local lightWrapper = self:getCharacterLight()

	if not lightWrapper or goutil.isNil(lightWrapper) then
		return
	end

	lightWrapper:ApplyOriginalColorAndRotation()

	lightWrapper.intensityScale = 100

	self:_updateAirtightTime()
end

function M:_updateAirtightTime(inTime, duration)
	duration = 0

	self:_tweenCharacterLightIntensityScale(0.8, duration)
end

function M:_initCharacterLight()
	if not self._characterLightWrapper or goutil.isNil(self._characterLightWrapper) then
		local scene = SceneMgr.instance:getScene(SceneType.Room)
		local lightRoot = scene.stage:getSceneLight()

		self._characterLightWrapper = goutil.findChildComponent(lightRoot, "character_directional_light", typeof(SpaceX.LightWrapper))
		self._characterLightWrapper.isRotationEnable = true

		self:setOriginalRotation()

		self._viewrAndModLight = SpaceX.ViewerAndModLight.Get(self._characterLightWrapper.gameObject)
	end
end

function M:getCharacterLight()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return nil
	end

	self:_initCharacterLight()

	return self._characterLightWrapper
end

function M:setCharacterLightRotation(rot)
	if not goutil.isNil(self._characterLightWrapper) then
		self._characterLightWrapper:SetOriginalRotation(rot.x, rot.y, rot.z)
	end
end

function M:setOriginalRotation()
	self:setCharacterLightRotation(LightOriginRotation)
end

function M:_tweenCharacterLightIntensityScale(scale, duration)
	self:_releaseTween()

	local lightWrapper = self:getCharacterLight()

	if not lightWrapper or goutil.isNil(lightWrapper) then
		return
	end

	if duration > 0 then
		local startValue = lightWrapper.originalIntensity

		self._tweenLight = TweenNumberUtils.FloatTo(startValue, scale, duration, self.setCharacterLightIntensityScale, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	else
		self:setCharacterLightIntensityScale(scale)
	end
end

function M:setCharacterLightIntensityScale(scale)
	local lightWrapper = self:getCharacterLight()

	if not lightWrapper or goutil.isNil(lightWrapper) then
		return
	end

	lightWrapper.originalIntensity = scale
end

function M:_setHeroHQShadow(prefabInst, showShadow)
	self:_initCharacterLight()

	if not self._characterLightWrapper or goutil.isNil(self._characterLightWrapper) then
		return
	end

	if not prefabInst or goutil.isNil(prefabInst) then
		return
	end

	local light = self._viewrAndModLight:CreateHBShadowLight()

	SpaceX.SceneRenderingSettings.Instance:ApplyHighQualityShadow(showShadow, prefabInst.gameObject, light)
end

function M:addViewerAndModelLight(prefabInst)
	local curScene = SceneMgr.instance:getCurScene()
	local sceneId = curScene:getSceneId()

	if sceneId ~= 9001 then
		return
	end

	self:_initCharacterLight()

	if not self._viewrAndModLight then
		return
	end

	local faceGo = CharacterUtil.getFaceBindGo(prefabInst)

	if goutil.isNil(faceGo) and isInEditorMode then
		printError("模型:" .. prefabInst.name .. "无法找到 face 绑点。")

		return
	end

	local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	local viewer = self._viewrAndModLight

	viewer.isReverse = true
	viewer.offsetY = 40

	viewer:SetCamera(mainCameraTarget:getGO())
	viewer:SetMod(faceGo)
	viewer:SetReferentialMod(prefabInst.transform)

	viewer.enabled = false
end

return M
