-- chunkname: @modules/logic/room/entity/comp/RoomEffectComp.lua

module("modules.logic.room.entity.comp.RoomEffectComp", package.seeall)

local RoomEffectComp = class("RoomEffectComp", LuaCompBase)

RoomEffectComp.SCENE_TRANSPARNET_OBJECT_KEY = "__transparent_set_layer_"

function RoomEffectComp:ctor(entity)
	self.entity = entity
	self.__willDestroy = false
end

function RoomEffectComp:init(go)
	self._scene = GameSceneMgr.instance:getCurScene()
	self.go = go
	self._paramDict = {}
	self._applyParamDict = {}
	self._goDict = self:getUserDataTb_()
	self._goTransformDict = self:getUserDataTb_()
	self._animatorDict = self:getUserDataTb_()
	self._resDict = {}
	self._goActiveDict = {}
	self._goHasDict = {}
	self._delayDestroyDict = {}
	self._delayDestroyMinTime = nil
	self._sameNameComponentsDic = {}
	self._typeComponentsData = RoomEffectCompCacheData.New(self)
	self._goSameNameChildsData = RoomEffectCompCacheData.New(self)
	self._goPathChildsData = RoomEffectCompCacheData.New(self)
	self._goSameNameChildsTrsData = RoomEffectCompCacheData.New(self)
	self._goPathChildsTrsData = RoomEffectCompCacheData.New(self)
	self.isEmulator = SDKMgr.instance:isEmulator()
end

function RoomEffectComp:addEventListeners()
	return
end

function RoomEffectComp:removeEventListeners()
	return
end

function RoomEffectComp:beforeDestroy()
	self.__willDestroy = true

	TaskDispatcher.cancelTask(self._delayDestroy, self)
	self:removeEventListeners()
	self:returnAllEffect()
end

function RoomEffectComp:isHasKey(key)
	if self._delayDestroyDict[key] then
		return false
	end

	if self._paramDict[key] == nil then
		return false
	end

	return true
end

function RoomEffectComp:addParams(params, delayDestroy)
	if self.__willDestroy then
		return
	end

	local curTime = Time.time

	for key, param in pairs(params) do
		self._paramDict[key] = param
		self._delayDestroyDict[key] = delayDestroy and delayDestroy > 0 and delayDestroy + curTime or nil
	end

	self:_refreshDelayDestroyTask()
end

function RoomEffectComp:_refreshDelayDestroyTask()
	local minTime

	for key, delayDestroy in pairs(self._delayDestroyDict) do
		if delayDestroy and (not minTime or delayDestroy < minTime) then
			minTime = delayDestroy
		end
	end

	minTime = minTime and minTime - Time.time

	if minTime == nil and self._delayDestroyMinTime then
		self._delayDestroyMinTime = nil

		TaskDispatcher.cancelTask(self._delayDestroy, self)
	end

	if minTime and (self._delayDestroyMinTime == nil or minTime < self._delayDestroyMinTime) then
		if self._delayDestroyMinTime then
			TaskDispatcher.cancelTask(self._delayDestroy, self)
		end

		self._delayDestroyMinTime = minTime

		TaskDispatcher.runDelay(self._delayDestroy, self, self._delayDestroyMinTime)
	end
end

function RoomEffectComp:_delayDestroy()
	local mintTime = Time.time + 0.001

	self._delayDestroyMinTime = nil

	local keyList = {}

	for key, delayDestroy in pairs(self._delayDestroyDict) do
		if delayDestroy and delayDestroy <= mintTime then
			table.insert(keyList, key)
		end
	end

	self:removeParams(keyList)
	self:refreshEffect()
end

function RoomEffectComp:changeParams(params)
	for key, param in pairs(params) do
		if self._paramDict[key] then
			for property, value in pairs(param) do
				self._paramDict[key][property] = value
			end
		end
	end
end

function RoomEffectComp:removeParams(keyList, delayDestroy)
	local curTime = Time.time

	for i, key in ipairs(keyList) do
		if delayDestroy and delayDestroy > 0 then
			self._delayDestroyDict[key] = delayDestroy + curTime
		else
			self._paramDict[key] = nil
			self._delayDestroyDict[key] = nil
		end
	end

	self:_refreshDelayDestroyTask()
end

function RoomEffectComp:getEffectGOTrs(key)
	return self._goTransformDict[key]
end

function RoomEffectComp:getEffectGO(key)
	return self._goDict[key]
end

function RoomEffectComp:getEffectRes(key)
	return self._resDict[key]
end

function RoomEffectComp:isSameResByKey(key, res)
	return self._resDict[key] == res
end

function RoomEffectComp:isHasEffectGOByKey(key)
	return self._goHasDict[key]
end

function RoomEffectComp:setActiveByKey(key, isActive)
	if self.__willDestroy or isActive == nil then
		return
	end

	local flag = not not isActive

	if self._goActiveDict[key] ~= flag then
		self._goActiveDict[key] = flag

		if self._goHasDict[key] then
			gohelper.setActive(self._goDict[key], flag)
		end
	end
end

function RoomEffectComp:playEffectAnimator(key, animName)
	if self.__willDestroy then
		return
	end

	local animator = self._animatorDict[key]

	if animator == nil then
		local go = self:getEffectGO(key)

		if go then
			animator = go:GetComponent(RoomEnum.ComponentType.Animator)
			self._animatorDict[key] = animator or false
		end
	end

	if animator then
		animator:Play(animName, 0, 0)

		return true
	end
end

function RoomEffectComp:getMeshRenderersByKey(key)
	return self:getComponentsByKey(key, RoomEnum.ComponentName.MeshRenderer)
end

function RoomEffectComp:getMeshRenderersByPath(key, path)
	return self:getComponentsByPath(key, RoomEnum.ComponentName.MeshRenderer, path)
end

function RoomEffectComp:getComponentsByPath(key, componentName, path)
	local type_component = RoomEnum.ComponentType[componentName]

	if not type_component then
		return
	end

	local tempCacheData = self:_getSameCacheData(componentName)
	local list = tempCacheData:getDataByKey(key, path)

	if self.__willDestroy then
		return list
	end

	if not list and self._goHasDict[key] then
		list = {}

		tempCacheData:addDataByKey(key, path, list)

		local tempGo = gohelper.findChild(self._goDict[key], path)

		if tempGo then
			local components = tempGo:GetComponentsInChildren(type_component, true)

			self:_cArrayToLuaTable(components, list)
		end
	end

	return list
end

function RoomEffectComp:_getSameCacheData(componentName)
	local tempCacheData = self._sameNameComponentsDic[componentName]

	if not tempCacheData then
		tempCacheData = RoomEffectCompCacheData.New(self)
		self._sameNameComponentsDic[componentName] = tempCacheData
	end

	return tempCacheData
end

function RoomEffectComp:getComponentsByKey(key, componentName)
	local type_component = RoomEnum.ComponentType[componentName]

	if not type_component then
		return
	end

	local list = self._typeComponentsData:getDataByKey(key, componentName)

	if self.__willDestroy then
		return list
	end

	if not list and self._goHasDict[key] then
		list = {}

		self._typeComponentsData:addDataByKey(key, componentName, list)

		local components = self._goDict[key]:GetComponentsInChildren(type_component, true)

		self:_cArrayToLuaTable(components, list)
	end

	return list
end

function RoomEffectComp:getGameObjectsByName(key, gameName)
	local list = self._goSameNameChildsData:getDataByKey(key, gameName)

	if self.__willDestroy then
		return list
	end

	if not list and self._goHasDict[key] then
		list = {}

		self._goSameNameChildsData:addDataByKey(key, gameName, list)

		if RoomEffectComp.SCENE_TRANSPARNET_OBJECT_KEY == gameName then
			local transformList = self:getMeshRenderersByKey(key)

			for i = 1, #transformList do
				local childTransform = transformList[i]
				local index = string.find(childTransform.name, "transparent")

				if index and index == 1 then
					table.insert(list, childTransform.gameObject)
				end
			end
		else
			RoomHelper.getGameObjectsByNameInChildren(self._goDict[key], gameName, list)
		end
	end

	return list
end

function RoomEffectComp:getGameObjectByPath(key, path)
	local list = self._goPathChildsData:getDataByKey(key, path)

	if not self.__willDestroy and not list and self._goHasDict[key] then
		list = {}

		self._goPathChildsData:addDataByKey(key, path, list)

		local tempGo = gohelper.findChild(self._goDict[key], path)

		if tempGo then
			table.insert(list, tempGo)
		end
	end

	if list then
		return list[1]
	end
end

function RoomEffectComp:getGameObjectsTrsByName(key, gameName)
	local list = self._goSameNameChildsTrsData:getDataByKey(key, gameName)

	if self.__willDestroy then
		return list
	end

	if not list and self._goHasDict[key] then
		local goList = self:getGameObjectsByName(key, gameName)

		if goList then
			list = {}

			self._goSameNameChildsTrsData:addDataByKey(key, gameName, list)

			for _, go in ipairs(goList) do
				table.insert(list, go.transform)
			end
		end
	end

	return list
end

function RoomEffectComp:getGameObjectTrsByPath(key, path)
	local list = self._goPathChildsTrsData:getDataByKey(key, path)

	if not self.__willDestroy and not list and self._goHasDict[key] then
		list = {}

		self._goPathChildsTrsData:addDataByKey(key, path, list)

		local tempGo = self:getGameObjectByPath(key, path)

		if tempGo then
			table.insert(list, tempGo)
		end
	end

	if list then
		return list[1]
	end
end

function RoomEffectComp:removeComponentsByKey(key)
	self._typeComponentsData:removeDataByKey(key)
	self._goSameNameChildsData:removeDataByKey(key)
	self._goPathChildsData:removeDataByKey(key)
	self._goSameNameChildsTrsData:removeDataByKey(key)
	self._goPathChildsTrsData:removeDataByKey(key)

	for componentName, cacheData in pairs(self._sameNameComponentsDic) do
		cacheData:removeDataByKey(key)
	end
end

function RoomEffectComp:refreshEffect()
	if self.__willDestroy then
		return
	end

	local pathfindingColliderChanged = false

	for key, res in pairs(self._resDict) do
		local param = self._paramDict[key]

		if not param or param.res ~= res then
			self:returnEffect(key, self._goDict[key], res)

			local applyParam = self._applyParamDict[key]

			if applyParam and applyParam.pathfinding then
				pathfindingColliderChanged = true
			end
		end
	end

	local needPathList = {}
	local isFromEditorDir = GameResMgr.IsFromEditorDir

	for key, param in pairs(self._paramDict) do
		if isFromEditorDir then
			table.insert(needPathList, param.res)
		else
			table.insert(needPathList, param.ab or param.res)
		end
	end

	local sceneLoader = GameSceneMgr.instance:getCurScene().loader

	sceneLoader:makeSureLoaded(needPathList, self._rebuildEffect, self)
	self:_tryClearClickCollider()

	if pathfindingColliderChanged then
		self:_tryUpdatePathfindingCollider()
	end
end

function RoomEffectComp:_rebuildEffect()
	if self.__willDestroy then
		return
	end

	local pathfindingColliderChanged = false
	local preloader = GameSceneMgr.instance:getCurScene().preloader
	local isFromEditorDir = GameResMgr.IsFromEditorDir

	for key, param in pairs(self._paramDict) do
		local go = self._goDict[key]
		local goTrs = self._goTransformDict[key]
		local isNoGo = not go
		local res = param.res
		local ab = param.ab

		if not param.localPos and isNoGo then
			::label_30_0::

			local localPos = Vector3.zero

			if not param.localRotation and isNoGo then
				::label_30_1::

				local localRotation = Vector3.zero

				if not param.localScale and isNoGo then
					::label_30_2::

					local localScale = Vector3.one
					local layer = param.layer
					local shadow = param.shadow
					local batch = param.batch
					local highlight = param.highlight
					local alphaThreshold = param.alphaThreshold
					local isInventory = param.isInventory
					local applyParam = self._applyParamDict[key]

					if isNoGo and preloader and preloader:exist(isFromEditorDir and res or ab or res) then
						local containerGO = self.entity.containerGO

						if param.containerGO then
							containerGO = param.containerGO
						end

						if not param.name then
							local name = key

							go = RoomGOPool.getInstance(res, containerGO, name, ab)
							goTrs = go.transform
							self._goDict[key] = go
							self._goTransformDict[key] = goTrs
							self._resDict[key] = res
							self._goHasDict[key] = true

							if param.pathfinding then
								pathfindingColliderChanged = true
							end

							if param.deleteChildPath then
								local deleteGo = gohelper.findChild(go, param.deleteChildPath)

								if deleteGo then
									gohelper.addChild(RoomGOPool.getPoolContainerGO(), deleteGo)
									gohelper.destroy(deleteGo)
								end
							end

							if self._goActiveDict[key] ~= nil then
								gohelper.setActive(go, self._goActiveDict[key])
							end
						end
					end

					if go then
						if param.containerGO then
							param.containerGO = nil
						end

						if param.localPos then
							transformhelper.setLocalPos(goTrs, param.localPos.x, param.localPos.y, param.localPos.z)
						end

						if localRotation then
							transformhelper.setLocalRotation(goTrs, localRotation.x, localRotation.y, localRotation.z)
						end

						if localScale then
							transformhelper.setLocalScale(goTrs, localScale.x, localScale.y, localScale.z)
						end

						if batch ~= nil and (not applyParam or applyParam.batch ~= batch) then
							self:setBatch(key, batch)
						end

						if layer ~= nil and (not applyParam or applyParam.layer ~= layer) and layer ~= UnityLayer.SceneOpaque then
							self:setLayer(key, layer)
						end

						CurveWorldRenderer.InitCurveWorldRenderer(go)

						if shadow ~= nil and (not applyParam or applyParam.shadow ~= shadow) then
							self:setShadow(key, shadow)
						end

						local mpbDirty = false
						local isDimdegeKey = false

						if not applyParam or highlight ~= nil and applyParam.highlight ~= highlight then
							mpbDirty = true
						end

						if not applyParam or isInventory ~= nil and applyParam.isInventory ~= isInventory then
							isDimdegeKey = isInventory
						end

						if (not applyParam or alphaThreshold ~= nil and applyParam.alphaThreshold ~= alphaThreshold or nil) and true then
							self:setMPB(key, highlight, alphaThreshold, param.alphaThresholdValue)
						end

						if isDimdegeKey then
							self:setDimdegeKey(key, false)
						end

						self._applyParamDict[key] = tabletool.copy(param)
					end
				end
			end
		end
	end

	self:_tryClearClickCollider()

	if self.entity.onEffectRebuild then
		self.entity:onEffectRebuild()
	end

	for i, compName in ipairs(RoomEnum.EffectRebuildCompNames) do
		local comp = self.entity[compName]

		if comp and comp.onEffectRebuild then
			comp:onEffectRebuild()
		end
	end

	if pathfindingColliderChanged then
		self:_tryUpdatePathfindingCollider()
	end
end

function RoomEffectComp:setLayer(key, layer)
	local go = self._goDict[key]

	if not go then
		return
	end

	local isOrthCameraRender = layer == UnityLayer.SceneOrthogonalOpaque

	if isOrthCameraRender then
		RenderPipelineSetting.SetChildRenderLayerMask(go, 7, 8, true)
		RenderPipelineSetting.SetChildRenderLayerMask(go, 0, 8, false)
	else
		RenderPipelineSetting.SetChildRenderLayerMask(go, 0, 8, true)
		RenderPipelineSetting.SetChildRenderLayerMask(go, 7, 8, false)
	end
end

function RoomEffectComp:setShadow(key, shadow)
	local meshRendererList = self:getMeshRenderersByKey(key)

	if meshRendererList then
		for i = 1, #meshRendererList do
			local meshRenderer = meshRendererList[i]

			if shadow then
				meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
				meshRenderer.receiveShadows = true
			else
				meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
				meshRenderer.receiveShadows = false
			end
		end
	end
end

function RoomEffectComp:setBatch(key, batch)
	local batchRendererEntityList = self:getComponentsByKey(key, RoomEnum.ComponentName.BatchRendererEntity)

	if batchRendererEntityList then
		for i = 1, #batchRendererEntityList do
			local batchRendererEntity = batchRendererEntityList[i]

			batchRendererEntity.enabled = batch
		end
	end
end

function RoomEffectComp:setMPB(key, highlight, alphaThreshold, alphaThresholdValue)
	local meshRendererList = self:getMeshRenderersByKey(key)
	local scene = GameSceneMgr.instance:getCurScene()
	local mpb

	if highlight or alphaThreshold then
		mpb = scene.mapmgr:getPropertyBlock()

		mpb:Clear()

		if highlight then
			mpb:SetVector("_Highlight", Vector4.New(0.3, 0.19, 0.06, 0))
		end

		if alphaThreshold then
			mpb:SetFloat("_AlphaThreshold", alphaThresholdValue or 0.6)
		end
	end

	if meshRendererList then
		for i = 1, #meshRendererList do
			local meshRenderer = meshRendererList[i]

			if alphaThreshold ~= nil then
				MaterialReplaceHelper.SetRendererKeyworld(meshRenderer, "_SCREENCOORD", alphaThreshold and true or false)
			end

			meshRenderer:SetPropertyBlock(mpb)
		end
	end
end

function RoomEffectComp:setDimdegeKey(key, open)
	local meshRendererList = self:getMeshRenderersByKey(key)

	if meshRendererList then
		local mpb = GameSceneMgr.instance:getCurScene().mapmgr:getPropertyBlock()

		mpb:Clear()
		mpb:SetFloat("_DimEdgeSize", open and 0 or 1)

		for i = 1, #meshRendererList do
			local meshRenderer = meshRendererList[i]

			meshRenderer:SetPropertyBlock(mpb)
		end
	end
end

function RoomEffectComp:setMaterialKeyword(rederer, keyword, flag)
	local materialList = self:_cArrayToLuaTable(rederer.materials)

	if materialList then
		for i = 1, #materialList do
			local material = materialList[i]

			if flag then
				material:EnableKeyword(keyword)
			else
				material:DisableKeyword(keyword)
			end
		end
	end
end

function RoomEffectComp:returnEffect(key, go, res)
	if not go or string.nilorempty(res) then
		return
	end

	local applyParam = self._applyParamDict[key]

	if applyParam then
		if applyParam.isInventory then
			self:setDimdegeKey(key, true)
		end

		if applyParam.layer and applyParam.layer ~= UnityLayer.SceneOpaque then
			self:setLayer(key, UnityLayer.SceneOpaque)
		end

		if applyParam.batch == false then
			self:setBatch(true)
		end

		if self._goActiveDict[key] == false then
			gohelper.setActive(self._goDict[key], true)
		end
	end

	for i, compName in ipairs(RoomEnum.EffectRebuildCompNames) do
		local comp = self.entity[compName]

		if comp and comp.onEffectReturn then
			comp:onEffectReturn(key, res)
		end
	end

	RoomGOPool.returnInstance(res, go)
	self:removeComponentsByKey(key)

	self._goDict[key] = nil
	self._resDict[key] = nil
	self._animatorDict[key] = nil
	self._applyParamDict[key] = nil
	self._goTransformDict[key] = nil
	self._goActiveDict[key] = nil
	self._goHasDict[key] = nil
end

function RoomEffectComp:returnAllEffect()
	TaskDispatcher.cancelTask(self._delayDestroy, self)

	for key, res in pairs(self._resDict) do
		self:returnEffect(key, self._goDict[key], res)
	end

	self._resDict = nil
	self._paramDict = nil
	self._applyParamDict = nil
end

function RoomEffectComp:_cArrayToLuaTable(carray, luaList)
	return RoomHelper.cArrayToLuaTable(carray, luaList)
end

function RoomEffectComp:_tryClearClickCollider()
	if self.entity.collider then
		self.entity.collider:clearColliderGOList()
	end
end

function RoomEffectComp:_tryUpdatePathfindingCollider()
	RoomScenePathComp.addEntityCollider(self.entity.go)
end

return RoomEffectComp
