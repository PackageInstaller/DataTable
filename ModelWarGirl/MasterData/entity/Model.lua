-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Entity\\Model.lua

local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local ModelAuxType = typeof(Framework.Entity.ModelAux)
local LoaderMode = Framework.Resource.LoaderMode
local Model = Class("Model")

function Model:ctor(loadedCallback, entityId)
	self._hasParentEntity = true

	if not entityId then
		entityId = -1
		self._hasParentEntity = false
	end

	self._parentId = entityId
	self._isLoaded = false
	self._loadedCallback = {}
	self._partLoadedCallback = {}

	if loadedCallback then
		self:addLoadedCallback(loadedCallback)
	end
end

function Model:destroy()
	if self.isInCallback then
		self.destroyAfterCallback = true

		return
	end

	self._isLoaded = false
	self.modelAux = nil

	self:releaseGameObject()
	self:clearLoadedCallback()
	self:clearPartLoadedCallback()
end

function Model:setModelData(oriData)
	self._modelData = ModelTool.analyzeModelData(oriData)
end

function Model:setModelDataDefault(resModelId, animator, lod, scale)
	local oriData = {
		model_type = Const.MODEL_TYPE.Default,
		model_id = resModelId,
		animator = animator,
		use_lod = lod,
		scale = scale
	}

	self._modelData = ModelTool.analyzeModelData(oriData)
end

function Model:setModelDataSimple(modelPath, animator)
	local oriData = {
		model_type = Const.MODEL_TYPE.Simple,
		path = modelPath,
		animator = animator
	}

	self._modelData = ModelTool.analyzeModelData(oriData)
end

function Model:setModelDataShow(resModelId, showType, lod)
	local oriData = {
		model_type = showType,
		model_id = resModelId,
		use_lod = lod
	}

	self._modelData = ModelTool.analyzeModelData(oriData)
end

function Model:loadGameObject(isSync, needShow)
	if not self._modelData.avatar then
		return
	end

	if needShow == nil then
		needShow = true
	end

	self.showOnLoaded = needShow

	if not isSync then
		self._modelInsId = ModelFactory.CreateModelAll(self._modelData, Functor(self.onModelObjectLoaded, self), self.showOnLoaded, LoaderMode.Async)
	end
end

function Model:releaseGameObject()
	if self._modelInsId then
		self:_releaseStaticEffect()
		ModelFactory.ReleaseModel(self._modelInsId)

		self._modelInsId = nil
		self.modelGameObject = nil
	end
end

function Model:addLoadedCallback(func)
	table.insert(self._loadedCallback, func)
end

function Model:clearLoadedCallback()
	self._loadedCallback = {}
end

function Model:setVoicalGender()
	if self:modelAuxValid() and self._gender then
		self.modelAux:SetVoiceGender(self._gender)
	end
end

function Model:isLoaded()
	return self._isLoaded
end

function Model:onModelObjectLoaded(modelId)
	self._modelInsId = modelId
	self.modelGameObject = ModelFactory.GetModelObject(self._modelInsId)
	self.modelAux = self.modelGameObject:GetComponent(ModelAuxType)

	self:_scaleModel()

	self._isLoaded = true
	self.isInCallback = true

	if self._loadedCallback then
		for k, v in pairs(self._loadedCallback) do
			if v ~= nil then
				v(self)
			end
		end
	end

	self.isInCallback = false

	if self.destroyAfterCallback then
		self.destroyAfterCallback = nil

		self:destroy()
	end
end

function Model:onModelPartLoaded(partType)
	if partType == "avatar" then
		self.modelGameObject = ModelFactory.GetModelObject(self._modelInsId)
	end

	self:_handlePartLoadedEvent(partType)
end

function Model:addPartLoadedCallback(func, partType)
	self._partLoadedCallback[partType] = func
end

function Model:clearPartLoadedCallback()
	for partType, func in pairs(self._partLoadedCallback) do
		func = nil
	end

	self._partLoadedCallback = {}
end

function Model:_handlePartLoadedEvent(partType)
	local func = self._partLoadedCallback[partType]

	if func then
		self._partLoadedCallback[partType] = nil

		func(partType)
	end
end

function Model:changeAnimator(animatorPath)
	if not animatorPath then
		return
	end

	self._modelData.animator = animatorPath

	ModelFactory.AddModelPart(self._modelInsId, "animator", animatorPath)
end

function Model:changeAvatar(avatarPath)
	if not avatarPath then
		return
	end

	self._modelData.avatar = avatarPath

	ModelFactory.AddModelPart(self._modelInsId, "avatar", avatarPath)
end

function Model:changeBodyPart(partIndex, prefabPath, loadedFunc)
	if not partIndex or not self._modelInsId then
		return
	end

	if loadedFunc then
		self:addPartLoadedCallback(loadedFunc, partIndex)
	end

	local partType = ModelTool.getBodyPartType(partIndex)

	self._modelData.parts[partType] = prefabPath

	ModelFactory.AddModelPartWithCallback(self._modelInsId, partType, prefabPath, Slot(self.onModelPartLoaded, self, partType))
end

function Model:changeBodyParts(modelPartDict, loadedFunc)
	if not self._modelInsId then
		return
	end

	local partPathDict = {}

	for partIndex, prefabPath in pairs(modelPartDict) do
		local partType = ModelTool.getBodyPartType(partIndex)

		partPathDict[partType] = prefabPath
	end

	local function finishedCallback()
		for partType, _ in pairs(partPathDict) do
			self:onModelPartLoaded(partType)
		end

		if loadedFunc ~= nil then
			loadedFunc()
		end
	end

	ModelFactory.ChangeModelParts(self._modelInsId, partPathDict, true, finishedCallback)
end

function Model:changeModelAll(oriModelData, callback)
	self._modelData = ModelTool.analyzeModelData(oriModelData)

	ModelFactory.ReplaceModelAll(self._modelInsId, self._modelData, callback)
end

function Model:canReuse(resModelId, showType, lod)
	if not self._modelData or not self:isLoaded() then
		return false
	end

	local oriData = {
		model_type = showType,
		model_id = resModelId,
		use_lod = lod
	}
	local newModelData = ModelTool.analyzeModelData(oriData)

	return self._modelData.avatar == newModelData.avatar
end

function Model:changeModelByCommonModelId(resModelId, showType, animator, lod, loadedFunc, isSync)
	ModelTool.delBaseModel(self._modelInsId)

	if not self._modelData or not self._modelInsId then
		return
	end

	local oriData = {
		model_type = showType,
		model_id = resModelId,
		use_lod = lod,
		animator = animator
	}
	local newModelData = ModelTool.analyzeModelData(oriData)

	if self._modelData.avatar ~= newModelData.avatar then
		-- block empty
	end

	local changePart = {}

	if self._modelData.animator ~= newModelData.animator then
		changePart.animator = newModelData.animator
	end

	for partType, path in pairs(newModelData.parts) do
		changePart[partType] = path
	end

	local function finishedCallback()
		for partType, _ in pairs(changePart) do
			self:onModelPartLoaded(partType)
		end

		if loadedFunc ~= nil then
			loadedFunc()
		end
	end

	local loadMode = LoaderMode.Async

	if isSync then
		loadMode = LoaderMode.Sync
	end

	ModelFactory.ChangeModelParts(self._modelInsId, changePart, true, finishedCallback, loadMode)

	self._modelData = newModelData
end

function Model:showModel(needShow)
	ModelFactory.ShowModelAll(self._modelInsId, needShow)
end

function Model:getModelObject()
	if not self.modelGameObject then
		self.modelGameObject = ModelFactory.GetModelObject(self._modelInsId)
	end

	return self.modelGameObject
end

function Model:getModelInsId()
	if self._modelInsId then
		return self._modelInsId
	end
end

local AnimatorType = typeof(UnityEngine.Animator)

function Model:getAnimator()
	if self.modelGameObject then
		return self.modelGameObject:GetComponent(AnimatorType)
	end
end

function Model:getModelProp(propName)
	propName = "_" .. propName

	if self[propName] ~= nil then
		return self[propName]
	end
end

function Model:setModelLayer(layer)
	if self._modelInsId and layer ~= nil and layer >= 0 then
		ModelFactory.SetModelLayer(self._modelInsId, layer)

		self._modelInsLayer = layer
	end
end

function Model:getModelLayer(...)
	return self._modelInsLayer
end

function Model:manualRebindAnimator()
	if self._modelInsId then
		ModelFactory.ManualRebindAniamtor(self._modelInsId)
	end
end

function Model:addCommonEffect(effectPath, scale)
	if effectPath then
		self:_addStaticEffect(effectPath, "Common", scale or 1, self.showOnLoaded)
	end
end

function Model:releaseCommonEffect()
	self:_releaseStaticEffect("Common")
end

function Model:setPositionXYZ(x, y, z)
	local curPos = self:getPositionVector3()
	local targetPosition = Vector3(x or curPos.x, y or curPos.y, z or curPos.z)

	self:setPositionVector3(targetPosition)
end

function Model:setPositionVector3(pos)
	if self.modelGameObject then
		if self._hasParentEntity then
			self.modelGameObject.transform.localPosition = pos
		else
			self.modelGameObject.transform.position = pos
		end
	end

	self._position = pos
end

function Model:getPositionVector3()
	if self.modelGameObject then
		if self._hasParentEntity then
			return self.modelGameObject.transform.localPosition
		else
			return self.modelGameObject.transform.position
		end
	end
end

function Model:setVisible(isVisible)
	local go = self.modelGameObject

	if go then
		local param = 0

		if isVisible then
			param = 1
		end

		Framework.Tools.LuaToolkit.SetGoActive(go, param)
	end

	self._visible = isVisible
end

function Model:setScale(scale)
	self._modelData.scale = scale

	self:_scaleModel()
end

function Model:getScale()
	return self._modelData.scale or 1
end

function Model:setModelVisible(visible)
	if self:modelAuxValid() then
		if visible then
			self.modelAux:ReshowModel()
		else
			self.modelAux:HideModel(false)
		end
	end
end

function Model:setModelGray(isGray)
	if self:modelAuxValid() then
		if isGray then
			self.modelAux:SetMaterialKeyword("_SETGRAY_ON", isGray)
		else
			self.modelAux:ResetMaterialKeyword("_SETGRAY_ON")
		end
	end
end

function Model:setAllVisible(visible)
	if self.modelGameObject then
		self.modelGameObject:SetActive(visible and true or false)
	end
end

function Model:setEnableShadowReceive(enable)
	if self:modelAuxValid() then
		self.modelAux:SetShadowReceiveEnabled(enable and true or false)
	end
end

function Model:playAnimation(animName, updateNow)
	if self:modelAuxValid() then
		if updateNow then
			self.modelAux:PlayAnimatorNow(animName)
		else
			self.modelAux:PlayAnimator(animName)
		end
	end
end

function Model:playAnimationWithNTime(animName, normalizedTime)
	if self:modelAuxValid() then
		normalizedTime = normalizedTime or 0

		self.modelAux:PlayAnimatorWithNTime(animName, normalizedTime)
		self:updateAnimationNow()
	end
end

function Model:playAnimationWithDuration(animName, duration)
	if self:modelAuxValid() then
		duration = duration or 0

		self.modelAux:PlayAnimatorByDuration(animName, duration)
	end
end

function Model:getAnimatorStateInfo()
	if self:modelAuxValid() then
		local normalizedTime = self.modelAux:GetCurStateTime()
		local nameHash = self.modelAux:GetCurStateNamehash()

		return nameHash, normalizedTime
	end
end

function Model:updateAnimationNow()
	local animator = self:getAnimator()

	if animator then
		animator:Update(0.001)
	end
end

function Model:setAnimSpeed(speedParamName, animSpeed)
	if self:modelAuxValid() then
		self.modelAux:SetFloatParam(speedParamName, animSpeed)
	end
end

function Model:setModelAlwaysAnim()
	if self:modelAuxValid() then
		self.modelAux:SetAnimatorNoCulling()
	end
end

function Model:resetModelCullingMode()
	if self:modelAuxValid() then
		self.modelAux:ResetCullingMode()
	end
end

function Model:animatorToOverride()
	if self:modelAuxValid() then
		self.modelAux:AnimatorToOverride()
	end
end

function Model:calcForceQualityLevel()
	if self._forceLod then
		return 0
	end
end

function Model:addMaterial(materialPath)
	if self:modelAuxValid() then
		self.modelAux:AddMaterial(materialPath, false)
	end
end

function Model:delMaterial(materialPath)
	if self:modelAuxValid() then
		self.modelAux:DelMaterial(materialPath, false)
	end
end

function Model:changeMaterial(partString, materialPath)
	if self:modelAuxValid() then
		self.modelAux:ChangeMaterial(partString, materialPath)
	end
end

function Model:recoverMaterial(...)
	if self:modelAuxValid() then
		self.modelAux:RecoverMaterials()
	end
end

function Model:setMaterialTransparency()
	if self:modelAuxValid() then
		self.modelAux:SetMaterialTransparency()
	end
end

function Model:revertMaterialTransparency(...)
	if self:modelAuxValid() then
		self.modelAux:RevertMaterialTransparency()
	end
end

function Model:smoothSetMaterialTrans(startValue, endValue, duration, callback)
	if self:modelAuxValid() then
		self.modelAux:SmoothSetBlendAlpha(startValue, endValue, duration, callback)
	end
end

function Model:mirrorModel(needMirror)
	if self:modelAuxValid() then
		if needMirror then
			self.modelAux:MirrorModel()
		else
			self.modelAux:ResetMirror()
		end
	end
end

function Model:setOutline(isOn)
	return
end

function Model:setTonemapping(isOn)
	if self:modelAuxValid() then
		self.modelAux:SetTonemapping(false)
	end
end

function Model:setRainyMat(isOn)
	if self:modelAuxValid() then
		self.modelAux:SetRainyAdjust(isOn)
	end
end

function Model:setFootStep(groupId)
	if self:modelAuxValid() then
		self.modelAux:SetFootStepGroup(groupId)
	end
end

function Model:setMute(soundIsMute, vocalIsMute)
	if self:modelAuxValid() then
		self.modelAux:SetModelMute(soundIsMute, vocalIsMute)
	end
end

function Model:modelAuxValid()
	return self.modelAux and not tolua.isnull(self.modelAux)
end

function Model:_scaleModel()
	local modelScale = self._modelData.scale

	if modelScale and modelScale ~= 1 then
		ModelFactory.ScaleModelAll(self._modelInsId, modelScale)
	end
end

function Model:_addStaticEffect(effectPath, bindType, scale, showOnLoaded, isWaken, mount)
	if not self.modelGameObject and not self:getModelObject() then
		return
	end

	if not self._staticEffects then
		self._staticEffects = {
			Common = {},
			Body = {}
		}
	end

	local effectForceLevel = self:calcForceQualityLevel()
	local effectPathList = Model.ParseEffectList(effectPath)

	if effectPathList then
		for index, effectPath in ipairs(effectPathList) do
			local insId = EffectManager:playStaticEffectAsync(self._parentId, self.modelGameObject.transform, effectPath, mount, nil, nil, scale, showOnLoaded, nil, true, Slot(self._staticEffectCallback, self), Const.EFFECT_LIFE_MODE.LogicControl)

			if self._staticEffects[bindType] then
				table.insert(self._staticEffects[bindType], insId)
			end
		end
	end
end

function Model:_staticEffectCallback(effectController)
	if self._useShaderLodHigh then
		local go = effectController.gameObject
		local modelAux = go:AddComponent(ModelAuxType)
	end
end

function Model:_releaseStaticEffect(bindType)
	if not self._staticEffects then
		return
	end

	if bindType ~= nil then
		if self._staticEffects[bindType] then
			for i, insId in ipairs(self._staticEffects[bindType]) do
				EffectManager:releaseEffect(insId)
			end

			self._staticEffects[bindType] = {}
		end
	else
		for k, insList in pairs(self._staticEffects) do
			self._staticEffects[k] = {}
		end

		EffectManager:clearStaticEffect(self._parentId)
	end
end

function Model.ParseEffectList(originalEffectPath)
	if not originalEffectPath or type(originalEffectPath) ~= "string" then
		return
	end

	local effectPathList = {}
	local splitIndex = string.find(originalEffectPath, ",")

	while splitIndex and splitIndex >= 1 do
		local path = string.sub(originalEffectPath, 1, splitIndex - 1)

		table.insert(effectPathList, path)

		originalEffectPath = string.sub(originalEffectPath, splitIndex + 1, #originalEffectPath)
		splitIndex = string.find(originalEffectPath, ",")
	end

	table.insert(effectPathList, originalEffectPath)

	return effectPathList
end

return Model
