-- chunkname: @modules/logic/room/entity/RoomMapBlockEntity.lua

module("modules.logic.room.entity.RoomMapBlockEntity", package.seeall)

local RoomMapBlockEntity = class("RoomMapBlockEntity", RoomBaseBlockEntity)

function RoomMapBlockEntity:ctor(entityId)
	RoomMapBlockEntity.super.ctor(self, entityId)

	self._placingHereRotation = nil
	self._pathfindingEnabled = true
	self._highlightDic = {}
end

function RoomMapBlockEntity:getTag()
	return SceneTag.RoomMapBlock
end

function RoomMapBlockEntity:init(go)
	RoomMapBlockEntity.super.init(self, go)
	self:addAmbientAudio()
end

function RoomMapBlockEntity:initComponents()
	RoomMapBlockEntity.super.initComponents(self)

	if RoomController.instance:isDebugPackageMode() then
		self:addComp("debugpackageui", RoomDebugPackageUIComp)
	end

	self:addComp("nightlight", RoomNightLightComp)
	self:addComp("birthday", RoomMapBlockBirthdayComp)
	self.nightlight:setEffectKey(RoomEnum.EffectKey.BlockLandKey)
end

function RoomMapBlockEntity:onStart()
	RoomMapBlockEntity.super.onStart(self)
	RoomMapController.instance:registerCallback(RoomEvent.ResourceLight, self._refreshLightEffect, self)
	RoomMapController.instance:registerCallback(RoomEvent.StartPlayAmbientAudio, self.playAmbientAudio, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, self.refreshPackage, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageOrderChanged, self.refreshPackage, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageListShowChanged, self.refreshPackage, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageFilterChanged, self.refreshPackage, self)
end

function RoomMapBlockEntity:setLocalPos(x, y, z)
	RoomMapBlockEntity.super.setLocalPos(self, x, y, z)
	self:refreshName()
end

function RoomMapBlockEntity:onEffectRebuild()
	RoomMapBlockEntity.super.onEffectRebuild(self)
	self:_refreshLandLightEffect()
	self:_refreshLinkGO()

	local mo = self:getMO()

	self:_refreshWaterGradient(mo)
	self.birthday:refreshBirthday()
end

function RoomMapBlockEntity:refreshBlock()
	RoomMapBlockEntity.super.refreshBlock(self)

	local blockMO = self:getMO()

	if blockMO.blockState == RoomBlockEnum.BlockState.Temp then
		if not self.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockTempPlaceKey) then
			self.effect:addParams({
				[RoomEnum.EffectKey.BlockTempPlaceKey] = {
					res = RoomScenePreloader.ResEffectB
				}
			})
		end
	elseif self.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockTempPlaceKey) then
		self.effect:removeParams({
			RoomEnum.EffectKey.BlockTempPlaceKey
		})

		self._placingHereRotation = nil
	end

	local isInBack = blockMO:getOpState() == RoomBlockEnum.OpState.Back
	local isWaterForm = RoomWaterReformModel.instance:isWaterReform()

	if isWaterForm then
		::label_8_0::

		local isWaterReformSelect = RoomWaterReformModel.instance:isBlockInSelect(blockMO)

		if isInBack or isWaterReformSelect then
			local resPath

			if isWaterReformSelect then
				local hasRiver = blockMO:hasRiver()

				resPath = hasRiver and RoomScenePreloader.ResEffectD03 or RoomScenePreloader.ResEffectD04
			elseif isInBack then
				local isCanBack = blockMO:getOpStateParam()

				resPath = isCanBack and RoomScenePreloader.ResEffectD03 or RoomScenePreloader.ResEffectD04
			end

			if resPath and self._lastSelectEffPath ~= resPath then
				self._lastSelectEffPath = resPath

				self.effect:addParams({
					[RoomEnum.EffectKey.BlockBackBlockKey] = {
						res = resPath
					}
				})
			end
		elseif self.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBlockKey) then
			self._lastSelectEffPath = nil

			self:removeParamsAndPlayAnimator({
				RoomEnum.EffectKey.BlockBackBlockKey
			}, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
		end

		self:_refreshLightEffect()
		self:refreshPackage()
		self.effect:refreshEffect()
		self:_refreshLinkGO()
		self.birthday:refreshBirthday()
	end
end

function RoomMapBlockEntity:checkBlockLandShow(pMO)
	if pMO and pMO.blockCleanType == RoomBlockEnum.CleanType.CleanLand then
		return false
	end

	return true
end

function RoomMapBlockEntity:refreshBackBuildingEffect(pMO)
	local isshow = false

	if RoomMapBlockModel.instance:isBackMore() then
		local blockMO = pMO or self:getMO()

		if blockMO and RoomMapBuildingModel.instance:getBuildingParam(blockMO.hexPoint.x, blockMO.hexPoint.y) then
			isshow = true
		end
	end

	if isshow then
		if not self.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBuildingKey) then
			self.effect:addParams({
				[RoomEnum.EffectKey.BlockBackBuildingKey] = {
					res = RoomScenePreloader.ResEffectD06
				}
			})
			self.effect:refreshEffect()
		end
	elseif self.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBuildingKey) then
		self:removeParamsAndPlayAnimator({
			RoomEnum.EffectKey.BlockBackBuildingKey
		}, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function RoomMapBlockEntity:_refreshLinkGO()
	local blockMO = self:getMO()

	if not blockMO then
		return
	end

	local resourceList = blockMO:getResourceList()

	for direction = 1, #resourceList do
		local resourceId = resourceList[direction]

		if RoomResourceEnum.ResourceLinkGOPath[resourceId] and RoomResourceEnum.ResourceLinkGOPath[resourceId][direction] then
			local linkGO = self.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomResourceEnum.ResourceLinkGOPath[resourceId][direction])

			if linkGO then
				local nearBlockResId, nearBlockId = blockMO:getNeighborBlockLinkResourceId(direction, true)

				gohelper.setActive(linkGO, resourceId == nearBlockResId)
			end
		end
	end

	local blockType = blockMO:getDefineBlockType()

	if RoomBlockEnum.BlockLinkEffectGOPath[blockType] then
		local linkGO = self.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomBlockEnum.BlockLinkEffectGOPath[blockType])

		if linkGO then
			local isSame = blockMO:hasNeighborSameBlockType()

			gohelper.setActive(linkGO, isSame)
		end
	end
end

function RoomMapBlockEntity:refreshPackage()
	if not RoomController.instance:isDebugPackageMode() or not RoomDebugController.instance:isDebugPackageListShow() then
		self.effect:removeParams({
			RoomEnum.EffectKey.BlockPackageEffectKey
		})
		self.effect:refreshEffect()

		return
	end

	local blockMO = self:getMO()
	local packageId = blockMO.packageId
	local selectPackageId = RoomDebugPackageListModel.instance:getFilterPackageId()

	if not selectPackageId or selectPackageId == 0 or not packageId or packageId == 0 then
		self.effect:removeParams({
			RoomEnum.EffectKey.BlockPackageEffectKey
		})
		self.effect:refreshEffect()

		return
	end

	local mainRes = blockMO:getMainRes()

	if not mainRes or mainRes < 0 then
		mainRes = RoomResourceEnum.ResourceId.Empty
	end

	if RoomDebugController.instance:isEditPackageOrder() then
		local selectMainRes = RoomDebugPackageListModel.instance:getFilterMainRes()

		selectMainRes = selectMainRes or RoomResourceEnum.ResourceId.Empty

		if mainRes ~= selectMainRes or selectPackageId ~= packageId then
			self.effect:removeParams({
				RoomEnum.EffectKey.BlockPackageEffectKey
			})
		else
			self.effect:addParams({
				[RoomEnum.EffectKey.BlockPackageEffectKey] = {
					res = RoomScenePreloader.ResDebugPackageColorDict[mainRes]
				}
			})
		end
	elseif selectPackageId ~= packageId then
		self.effect:addParams({
			[RoomEnum.EffectKey.BlockPackageEffectKey] = {
				res = RoomScenePreloader.ResDebugPackageColorOther
			}
		})
	else
		self.effect:addParams({
			[RoomEnum.EffectKey.BlockPackageEffectKey] = {
				res = RoomScenePreloader.ResDebugPackageColorDict[mainRes]
			}
		})
	end

	self.effect:refreshEffect()
end

function RoomMapBlockEntity:refreshTempOccupy()
	RoomMapBlockEntity.super.refreshTempOccupy(self)
	self:_refreshLandLightEffect()
end

function RoomMapBlockEntity:playSmokeEffect()
	local blockMO = self:getMO()

	if not blockMO then
		return
	end

	local var_14_0 = {}
	local var_14_1 = {}

	var_14_1.res = RoomScenePreloader.BlockTypeSmokeDict[blockMO:getDefineBlockType()] or RoomScenePreloader.ResSmoke
	var_14_1.containerGO = self.staticContainerGO
	var_14_0[RoomEnum.EffectKey.BlockSmokeEffectKey] = var_14_1

	self.effect:addParams(var_14_0, 2)
	self.effect:refreshEffect()
end

function RoomMapBlockEntity:playVxWaterEffect()
	local effectGO = self.effect:getEffectGO(RoomEnum.EffectKey.BlockVxWaterKey)

	if effectGO then
		gohelper.setActive(effectGO, false)
		gohelper.setActive(effectGO, true)
	end

	self.effect:addParams({
		[RoomEnum.EffectKey.BlockVxWaterKey] = {
			res = RoomScenePreloader.ResVXWater,
			containerGO = self.containerGO
		}
	}, 3)
	self.effect:refreshEffect()
end

function RoomMapBlockEntity:_refreshLightEffect()
	self:_refreshLandLightEffect()
end

function RoomMapBlockEntity:_refreshLandLightEffect()
	local blockMO = self:getMO()

	if not blockMO or not blockMO:isHasLight() then
		return
	end

	local hexPoint = blockMO.hexPoint
	local scene = GameSceneMgr.instance:getCurScene()
	local mpb = scene.mapmgr:getPropertyBlock()

	mpb:SetVector("_Highlight", Vector4.New(0.3, 0.19, 0.06, 0))

	local riveCount = blockMO:getRiverCount()
	local isRiverLight = false
	local isFullWater = blockMO:isFullWater()
	local resourcePointPaths = RoomEnum.EffectPath.ResourcePointLightPaths
	local blockKeys = RoomEnum.EffectKey.BlockKeys
	local landKey = RoomEnum.EffectKey.BlockLandKey
	local tRoomConfig = RoomConfig.instance
	local blockRotate = blockMO:getRotate()
	local lightMeshPath = RoomEnum.EffectPath.LightMeshPath
	local tRoomResourceModel = RoomResourceModel.instance
	local resIdRiver = RoomResourceEnum.ResourceId.River
	local halfLakeKeys = RoomEnum.EffectKey.BlockHalfLakeKeys
	local isHalfLakeWater = blockMO:isHalfLakeWater()
	local isHalfLakeLight = isHalfLakeWater and tRoomResourceModel:isLightResourcePoint(hexPoint.x, hexPoint.y, 0) == resIdRiver

	for i = 1, 6 do
		local direction = RoomRotateHelper.rotateDirection(i, blockRotate)
		local isLight = tRoomResourceModel:isLightResourcePoint(hexPoint.x, hexPoint.y, direction)

		if isLight and isLight == resIdRiver then
			isRiverLight = true
		end

		local resourceId = blockMO:getResourceId(direction)

		if isFullWater and resourceId == resIdRiver then
			self:_setLightEffectByPath(blockKeys[i], lightMeshPath, isLight, mpb)

			if riveCount < 6 then
				self:_setLightEffectByPath(landKey, resourcePointPaths[i], isLight, mpb)
			end
		elseif tRoomConfig:isLightByResourceId(resourceId) then
			self:_setLightEffectByPath(landKey, resourcePointPaths[i], isLight, mpb)
		end

		if isHalfLakeWater and resourceId ~= resIdRiver then
			self:_setLightEffectByPath(halfLakeKeys[i], lightMeshPath, isHalfLakeLight, mpb)
		end
	end

	if not isFullWater and riveCount > 0 and riveCount < 6 then
		self:_setLightEffectByPath(RoomEnum.EffectKey.BlockRiverKey, lightMeshPath, isRiverLight, mpb)
	end
end

function RoomMapBlockEntity:_setLightEffectByPath(key, path, isLight, mpb)
	local rendererList = self.effect:getMeshRenderersByPath(key, path)

	if rendererList and #rendererList > 0 and self:_isUpdateLight(key, path, isLight) then
		for i, renderer in ipairs(rendererList) do
			if isLight then
				renderer:SetPropertyBlock(mpb)
			else
				renderer:SetPropertyBlock(nil)
			end
		end
	end
end

function RoomMapBlockEntity:_isUpdateLight(key, path, isLight)
	local param = self._highlightDic[key]
	local flag = true

	if param then
		if param.isLight == isLight and param.path == path and param.effectRes == self.effect:getEffectRes(key) then
			flag = false
		end
	else
		param = {}
		self._highlightDic[key] = param
	end

	if flag then
		param.isLight = isLight
		param.path = path
		param.effectRes = self.effect:getEffectRes(key)
	end

	return flag
end

function RoomMapBlockEntity:beforeDestroy()
	if self.ambientAudioId and self.ambientAudioId ~= AudioEnum.None then
		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, self.go, false)
	end

	AudioMgr.instance:UnregisterGameObj(self.go)
	RoomMapBlockEntity.super.beforeDestroy(self)
	self:removeEvent()
end

function RoomMapBlockEntity:removeEvent()
	RoomMapController.instance:unregisterCallback(RoomEvent.ResourceLight, self._refreshLightEffect, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.StartPlayAmbientAudio, self.playAmbientAudio, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, self.refreshPackage, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageOrderChanged, self.refreshPackage, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageListShowChanged, self.refreshPackage, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageFilterChanged, self.refreshPackage, self)
end

function RoomMapBlockEntity:getMO()
	local mo = RoomMapBlockModel.instance:getFullBlockMOById(self.id)

	if mo then
		mo.replaceDefineId = nil
		mo.replaceRotate = nil

		if mo.hexPoint then
			local tempRoomMapBuildingModel = RoomMapBuildingModel.instance
			local param = tempRoomMapBuildingModel:getBuildingParam(mo.hexPoint.x, mo.hexPoint.y)

			if not param and not RoomBuildingController.instance:isPressBuilding() then
				param = tempRoomMapBuildingModel:getTempBuildingParam(mo.hexPoint.x, mo.hexPoint.y)
			end

			mo.replaceDefineId = param and param.blockDefineId

			local var_22_0

			if param then
				::label_22_0::

				var_22_0 = param.blockDefineId and param.blockRotate
			end

			mo.replaceRotate = var_22_0
		end
	end

	return mo
end

function RoomMapBlockEntity:addAmbientAudio()
	gohelper.addAkGameObject(self.go)
	AudioMgr.instance:RegisterGameObj(self.go)

	local mo = self:getMO()
	local resourceIdCountDict = {}

	for i = 1, 6 do
		local resourceId = mo:getResourceId(i)

		if resourceId ~= RoomResourceEnum.ResourceId.None and resourceId ~= RoomResourceEnum.ResourceId.Empty then
			resourceIdCountDict[resourceId] = resourceIdCountDict[resourceId] or 0
			resourceIdCountDict[resourceId] = resourceIdCountDict[resourceId] + 1
		end
	end

	local selectResCount = 0
	local selectResPriority = 0
	local selectResId = 0

	for resourceId, count in pairs(resourceIdCountDict) do
		if selectResCount < count then
			selectResCount = count
			selectResPriority = RoomResourceEnum.ResourceAudioPriority[resourceId] or 0
			selectResId = resourceId
		elseif count == selectResCount and (RoomResourceEnum.ResourceAudioPriority[resourceId] or selectResPriority < 0) then
			selectResCount = count
			selectResPriority = RoomResourceEnum.ResourceAudioPriority[resourceId] or 0
			selectResId = resourceId
		end
	end

	self.ambientAudioId = RoomResourceEnum.ResourceAudioId[selectResId]
end

function RoomMapBlockEntity:playAmbientAudio()
	if self.ambientAudioId and self.ambientAudioId ~= AudioEnum.None then
		AudioMgr.instance:trigger(self.ambientAudioId, self.go, false)
	end
end

function RoomMapBlockEntity:getCharacterMeshRendererList()
	return self.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BlockLandKey)
end

function RoomMapBlockEntity:getGameObjectListByName(goName)
	return self.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, goName)
end

return RoomMapBlockEntity
