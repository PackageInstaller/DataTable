-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\ModelStage.lua

local UIUtils = require("Framework.UI.UIUtils")
local ModelFactory = Framework.Entity.ModelFactory
local ResHero = require("ClientData/ResHero")
local ModelTool = require("Entity/ModelTool")
local ModelAuxType = typeof(Framework.Entity.ModelAux)
local CustomShadowManager = require("System/CustomShadowManager")
local LoaderMode = Framework.Resource.LoaderMode
local DEF_SCALE = 400
local strClassName = "ModelStage"
local ModelStage = Class(strClassName)

function ModelStage:ctor(prefabPath, loadedCallback)
	self.prefabPath = prefabPath
	self._models = {}
	self._modelsActive = {}
	self._modelsVisible = {}
	self._modelInsIds = {}
	self._skipShadowModels = {}
	self.loadedCallback = loadedCallback
end

function ModelStage:startLoad(pos)
	self.id = UIUtils.CreateModelStage(self.prefabPath, pos, self, 0)
end

function ModelStage:destroy()
	if self.id then
		self:_activeInRenderStack(false)
		self:_activeCustomShadow(false)
		UIUtils.DestroyModelStage(self.id)

		self._obj = nil
	end
end

function ModelStage:registerParentUI(parentUID)
	self.parentUID = parentUID

	UIUtils.SetModelStageParentUI(true, self.id, parentUID)
end

function ModelStage:unregisterParentUI()
	if self.parentUID then
		UIUtils.SetModelStageParentUI(false, self.id, self.parentUID)

		self.parentUID = nil
	end
end

function ModelStage:onDestroy()
	for modelInsId, _ in pairs(self._modelInsIds) do
		ModelFactory.ReleaseModel(modelInsId)
	end
end

function ModelStage:OnCtorEnd(id, obj)
	self.id = id
	self._obj = obj

	self:_onLoadedCustomShadow()
end

function ModelStage:OnDestroyEnd()
	self:onDestroy()
end

function ModelStage:OnOprEvent(eventType, delta)
	if eventType == "Click" then
		if self.mEventOprClick then
			self.mEventOprClick(delta)
		end
	elseif eventType == "DragStart" then
		if self.mEventOprDragStart then
			self.mEventOprDragStart()
		end
	elseif eventType == "DragEnd" then
		if self.mEventOprDragEnd then
			self.mEventOprDragEnd()
		end
	elseif eventType == "Drag" then
		if self.mEventOprDrag then
			self.mEventOprDrag(delta)
		end
	elseif eventType == "FingerDown" then
		if self.mEventOprFingerDown then
			self.mEventOprFingerDown()
		end
	elseif eventType == "FingerUp" then
		if self.mEventOprFingerUp then
			self.mEventOprFingerUp()
		end
	elseif eventType == "Pinch" and self.mEventOprPinch then
		self.mEventOprPinch(delta)
	end
end

function ModelStage:onModelLoaded(modelInsId)
	local model = ModelFactory.GetModelObject(modelInsId)
	local modelAux = model:GetComponent(ModelAuxType)

	self._models[modelInsId] = modelAux

	if self._modelsActive[modelInsId] ~= nil then
		-- block empty
	end

	if self._modelsVisible[modelInsId] ~= nil then
		self:setModelVisible(modelInsId, self._modelsVisible[modelInsId])
	end
end

function ModelStage:pauseRender()
	if self._obj then
		self._obj:PauseRender(true)
	end
end

function ModelStage:resumeRender(...)
	if self._obj then
		self._obj:PauseRender(false)
	end
end

function ModelStage:pause()
	if self._obj then
		self._obj:PauseUpdate(true)
	end
end

function ModelStage:resume()
	if self._obj then
		self._obj:PauseUpdate(false)
	end
end

function ModelStage:setHide(isHide)
	if self._obj then
		self._obj:SetHide(isHide)
		self:_activeCustomShadow(not isHide)
	end
end

function ModelStage:getHide()
	if self._obj then
		return self._obj:GetHideState()
	end
end

function ModelStage:setLightHide(isHide)
	if self._obj then
		self._obj:SetLightHide(isHide)

		if isHide then
			self:_activeCustomShadow(false)
			self:_activeInRenderStack(false)
		end
	end
end

function ModelStage:connectImage(img)
	if self._obj then
		self._obj:SetRawImage(img:getComObj())
		self:ensureLightmap()
		self:_activeCustomShadow(true)
		self:_activeInRenderStack(true)
		self:forceRefresh()
	end
end

function ModelStage:setRTScale(scale)
	if self._obj then
		self._obj:SetRenderTextureScale(scale)
	end
end

function ModelStage:skipRenderMode(step)
	if self._obj then
		self._obj:SetRenderStep(step)
	end
end

function ModelStage:setRTAntiAliasing(antiLevel)
	if self._obj then
		self._obj:SetRenderTextureAntiAliasing(antiLevel)
	end
end

function ModelStage:changeReflectCamera(cam)
	if self._obj then
		if cam then
			self._obj:SetReflectCam(cam)
		else
			self._obj:RevertReflectCam()
		end
	end
end

function ModelStage:manualActiveShadow(isActive)
	self:_activeCustomShadow(isActive)
end

function ModelStage:forceRefresh(...)
	if self._obj then
		self._obj:Refresh()
	end
end

function ModelStage:initOperation(panel, rotateSpeed, zoomSpeed)
	if self._obj then
		self._obj:SetOperationInfo(panel:getGameObject(), rotateSpeed or 500, zoomSpeed or 100)
	end
end

function ModelStage:initSlideOperation(panel, step, endCallback)
	if self._obj then
		self._obj:SetOperationInfoSlider(panel:getGameObject(), step or 0.1, endCallback)
	end
end

function ModelStage:setOperateModel(modelInsId)
	if self._obj then
		self._obj:SetOperationModel(modelInsId)
	end
end

function ModelStage:initOperationDefault(panel)
	if self._obj then
		self._obj:SetOperationDefault(panel:getGameObject())
	end
end

function ModelStage:getCamera()
	if not self.stageCamera and self._obj then
		self.stageCamera = self._obj:GetStageCamera()
	end

	return self.stageCamera
end

function ModelStage:moveCamera(pos, rotate)
	if pos == nil then
		return
	end

	if self._obj then
		self._obj:CameraMoveTo(Vector3(pos[1], pos[2], pos[3]), Vector3(rotate[1], rotate[2], rotate[3]))
	end
end

function ModelStage:moveCameraLocal(localPos, localRotate)
	if localPos == nil then
		return
	end

	if self._obj then
		self._obj:CameraLocalMoveTo(Vector3(localPos[1], localPos[2], localPos[3]), Vector3(localRotate[1], localRotate[2], localRotate[3]))
	end
end

function ModelStage:moveCameraSmooth(pos, durTime)
	if pos == nil then
		return
	end

	local moveFilter = Vector3(pos[1] == nil and 0 or 1, pos[2] == nil and 0 or 1, pos[3] == nil and 0 or 1)

	if self._obj then
		self._obj:SmoothCameraMoveTo(Vector3(pos[1], pos[2], pos[3]), durTime, moveFilter, Vector3.zero, false)
	end
end

function ModelStage:moveRotateCameraSmooth(pos, rotate, durTime)
	if pos == nil then
		return
	end

	local needRotate = true

	if rotate == nil then
		needRotate = false
		rotate = Vector3.zero
	else
		rotate = Vector3(rotate[1], rotate[2], rotate[3])
	end

	local moveFilter = Vector3(pos[1] == nil and 0 or 1, pos[2] == nil and 0 or 1, pos[3] == nil and 0 or 1)

	if self._obj then
		self._obj:SmoothCameraMoveTo(Vector3(pos[1], pos[2], pos[3]), durTime, moveFilter, rotate, needRotate)
	end
end

function ModelStage:playCameraAnimator(animName)
	if self._obj then
		self._obj:PlayCameraAnimator(animName)
	end
end

function ModelStage:playCameraAnimation(animPath)
	if self._obj then
		self._obj:PlayCameraAnimation(animPath)
	end
end

function ModelStage:stopCameraAnimation()
	if self._obj then
		self._obj:StopCameraAnimation()
	end
end

function ModelStage:playNodeAnimator(nodePath, animName)
	if self._obj then
		self._obj:PlayGameObjectAnimator(nodePath, animName)
	end
end

function ModelStage:fadeCamera(callback)
	if self._obj then
		local timeWait = 0.5
		local timeFade = 0.5

		self._obj:CameraFadeTo(callback, timeWait, timeFade)
	end
end

function ModelStage:playPostProcessing(cueId)
	if not self.stageCamera and self._obj then
		self.stageCamera = self._obj:GetStageCamera()
	end

	if self.stageCamera then
		CueManager.playPostProcess(cueId, self.stageCamera)
	end
end

function ModelStage:revertPostProcessing()
	if self.stageCamera then
		CueManager.revertImageEffects(self.stageCamera)
	end
end

function ModelStage:setCameraFov(fov, keepHorinzonal)
	if self._obj then
		self._obj:SetCameraFov(fov, keepHorinzonal or false)
	end
end

function ModelStage:setCameraClipPlane(near, far)
	if self._obj then
		self._obj:SetCameraClippingPlane(near, far)
	end
end

function ModelStage:setCameraDepth(isHighPrecision)
	if self._obj then
		self._obj:SetCameraDepth(isHighPrecision)
	end
end

function ModelStage:playTimelineByIndex(index)
	if self._obj then
		self._obj:PlayTimeline(index, 0)
	end
end

function ModelStage:resetTimeline(index, immediately)
	if self._obj then
		self._obj:ResetTimelie(index, 0, immediately or false)
	end
end

function ModelStage:switchEnvData(index)
	if self._obj then
		self._obj:SwitchEnv(index)
	end
end

function ModelStage:ensureLightmap()
	if self._obj then
		self._obj:EnsureLightmap()
	end
end

function ModelStage:resetShadow(...)
	if self._obj then
		self._obj:ResetShadow()
	end
end

function ModelStage:registerLight(isOn)
	if self._obj and self._obj.gameObject then
		CustomShadowManager.manualRegisterModelStageLight(isOn, self._obj.gameObject)
	end
end

function ModelStage:forceRegisterCamera()
	if self._obj then
		CustomShadowManager.forceRegisterCamera(self._obj)
	end
end

local SKIP_CUSTOM_SHADOW = {
	["ModelStage/LoginModelStage"] = true
}

function ModelStage:_isCustomShadowDisabled()
	if SKIP_CUSTOM_SHADOW[self.prefabPath] then
		return true
	end

	return false
end

function ModelStage:_activeCustomShadow(active)
	if self:_isCustomShadowDisabled() then
		if active then
			CustomShadowManager.clearShadow()
		end

		return
	end

	if active then
		if self._obj then
			CustomShadowManager.setModelStageShadowActive(true, self._obj)
		end

		if self._models then
			for insId, modelAux in pairs(self._models) do
				if not self._skipShadowModels[insId] then
					CustomShadowManager.registerModelStageGameObject(modelAux.gameObject, true)
				end
			end
		end

		if self._anchorModels then
			for _, modelAux in pairs(self._anchorModels) do
				CustomShadowManager.registerModelStageGameObject(modelAux.gameObject, true)
			end
		end
	else
		if self._obj then
			CustomShadowManager.setModelStageShadowActive(false, self._obj)
		end

		if self._models then
			for insId, modelAux in pairs(self._models) do
				if not self._skipShadowModels[insId] then
					CustomShadowManager.registerModelStageGameObject(modelAux.gameObject, false)
				end
			end
		end

		if self._anchorModels then
			for _, modelAux in pairs(self._anchorModels) do
				CustomShadowManager.registerModelStageGameObject(modelAux.gameObject, false)
			end
		end
	end

	ModelStageManager.activeShadow(self, active)
end

function ModelStage:_onLoadedCustomShadow()
	if self:_isCustomShadowDisabled() then
		return
	end

	CustomShadowManager.onModelStageLoaded(self._obj.gameObject)
end

function ModelStage:_activeInRenderStack(active)
	ModelStageManager.activeRender(self, active)
end

function ModelStage:addModel(modelData, pos, rotate, scale, idx, callback, skipShadow)
	if self._obj == nil then
		return
	end

	local function addModelFinished(modelInsId)
		self:onModelLoaded(modelInsId)
		self:jumpModel(modelInsId, pos, rotate, scale, idx)

		local modelAux = self._models[modelInsId]

		if modelAux and not skipShadow then
			CustomShadowManager.registerModelStageGameObject(modelAux.gameObject, true)
		end

		self._skipShadowModels[modelInsId] = skipShadow

		if callback then
			callback(modelInsId)
		end
	end

	local modelInsId = self._obj:AddModel(modelData, addModelFinished, true, LoaderMode.Async)

	self._modelInsIds[modelInsId] = idx or true

	return modelInsId
end

function ModelStage:delModel(modelInsId)
	if self._obj then
		self._modelsVisible[modelInsId] = nil
		self._models[modelInsId] = nil
		self._modelInsIds[modelInsId] = nil
		self._skipShadowModels[modelInsId] = nil

		return self._obj:DelModel(modelInsId)
	end
end

function ModelStage:getModel(modelInsId)
	return self._models[modelInsId]
end

function ModelStage:setTonemapping(modelInsId, isOn)
	local modelAux = self._models[modelInsId]

	if modelAux then
		modelAux:SetTonemapping(isOn)
	end
end

function ModelStage:jumpModel(modelInsId, pos, rotate, scale, idx)
	if self._obj == nil then
		return
	end

	if pos == nil then
		pos = {
			x = 0,
			y = 0
		}
	end

	self._obj:ModelJumpTo(modelInsId, idx or 1, pos.x, pos.y, rotate or 0, scale or 1)
end

function ModelStage:setModelVisible(modelInsId, visible)
	self._modelsVisible[modelInsId] = visible

	if self._obj == nil then
		return
	end

	self._obj:VisibleModel(modelInsId, visible)
end

function ModelStage:setModelActive(modelInsId, active)
	local modelAux = self._models[modelInsId]

	self._modelsActive[modelInsId] = active

	if modelAux then
		if active then
			modelAux:ResetMaterialKeyword("AVG_ADJUST_ON")
		else
			modelAux:SetMaterialKeyword("AVG_ADJUST_ON", true)
		end
	end
end

function ModelStage:showHeroById(heroID, showType, idx, callback, forceLod, showIndex)
	local heroData = ResHero[heroID] or {}
	local modelResID = heroData.model

	local function addModelFinished(mid)
		if callback then
			callback(mid, modelResID)
		end
	end

	return self:showModelById(modelResID, showType, idx, addModelFinished, forceLod)
end

function ModelStage:showHeroByModId(modelResID, showType, idx, callback, forceLod, baseId, showSeasonEfx)
	local function addModelFinished(mid)
		if callback then
			callback(mid, baseId)
		end

		if showSeasonEfx then
			self:showSeasonEfx(mid)
		end
	end

	return self:showModelById(modelResID, showType, idx, addModelFinished, forceLod)
end

function ModelStage:showModelById(modelResID, showType, idx, callback, forceLod)
	local modelData = ModelTool.analyzeModelData({
		model_type = showType,
		model_id = modelResID,
		use_lod = forceLod
	})

	if modelData then
		local pos = {
			x = 0,
			y = 0
		}
		local rotate = 0
		local scale = modelData.scale or 1

		return self:addModel(modelData, pos, rotate, scale, idx, callback)
	end
end

function ModelStage:showModelByModelData(prefabPath, animator, pos, rotate, scale, idx, callback, skipShadow)
	local modelData = {
		avatar = prefabPath,
		animator = animator,
		parts = {}
	}

	if modelData then
		return self:addModel(modelData, pos, rotate, scale, idx, callback, skipShadow)
	end
end

function ModelStage:showModelByModelDataDirect(modelData, idx, callback, forceLod, skipShadow)
	if modelData then
		local pos = {
			x = 0,
			y = 0
		}
		local rotate = 0
		local scale = modelData.scale or 1

		return self:addModel(modelData, pos, rotate, scale, idx, callback, skipShadow)
	end
end

function ModelStage:playAnimByIndex(idx, animName)
	for modelInsId, modelIdx in pairs(self._modelInsIds) do
		if modelIdx == idx then
			local modelAux = self._models[modelInsId]

			if modelAux then
				ModelTool.modelPlayAnimation(modelInsId, animName, modelAux)
			end
		end
	end
end

function ModelStage:playAnimByModelInsId(modelInsId, animName)
	local modelAux = self._models[modelInsId]

	if modelAux then
		ModelTool.modelPlayAnimation(modelInsId, animName, modelAux)
	end
end

function ModelStage:showSeasonEfx(mid)
	if ModelFactory.GetModelObject(mid) then
		local root = ModelFactory.GetModelObject(mid)

		if root then
			local efx1 = root.transform:Find("efx_Scene_Seaso01")

			if efx1 then
				efx1.gameObject:SetActive(true)
			end

			local efx2 = root.transform:Find("efx_Scene_Seaso02")

			if efx2 then
				efx2.gameObject:SetActive(true)
			end
		end
	end
end

function ModelStage:playAnimByAnchor(idx, animName, duration)
	if self._obj == nil then
		return
	end

	duration = duration or 0.1

	self._obj:PlayAnchorModelAnimator(idx, animName, duration)
end

function ModelStage:setTonemappingByAnchor(idx, isOn)
	if self._obj == nil then
		return
	end

	self._obj:SetAnchorTonemapping(idx, isOn)
end

function ModelStage:_getModelAuxByAnchor(idx)
	if self._obj == nil then
		return
	end

	return self._obj:GetAnchorModelAux(idx)
end

function ModelStage:initAnchorModels(idxList)
	idxList = idxList or {
		1,
		2,
		3,
		4,
		5
	}
	self._anchorModels = {}

	for _, idx in ipairs(idxList) do
		local modelAux = self:_getModelAuxByAnchor(idx)

		if modelAux then
			self._anchorModels[idx] = modelAux
		end
	end
end

function ModelStage:getAnchorModels(idx)
	if not self._anchorModels then
		return
	end

	return self._anchorModels[idx]
end

function ModelStage:alignToStage(tgtModelStageId)
	if self._obj then
		self._obj:AlignToAnother(tgtModelStageId)
	end
end

function ModelStage:alignToStageByName(prefabPath)
	local targetStageId = ModelStageManager.getModelStageId(prefabPath)

	if targetStageId then
		self:alignToStage(targetStageId)
	end
end

function ModelStage:setPosition(pos)
	if self._obj then
		self._obj.transform.position = Vector3(pos[1], pos[2], pos[3])
	end
end

return ModelStage
