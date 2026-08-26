-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/comp/ArcadeEntityMgr.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.comp.ArcadeEntityMgr", package.seeall)

local ArcadeEntityMgr = class("ArcadeEntityMgr", ArcadeBaseSceneComp)

function ArcadeEntityMgr:onInit()
	self:clearAllEntity(true, true)
	transformhelper.setLocalPos(self.trans, 0, 0, ArcadeGameEnum.Const.EntityZLevel)
end

function ArcadeEntityMgr:onPreGameStart()
	self:createCharacterEntity()
end

function ArcadeEntityMgr:createCharacterEntity()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local resPath = characterMO:getRes()

	self._scene.loader:loadRes(resPath, self._onLoadCharacterEntity, self)
end

function ArcadeEntityMgr:_onLoadCharacterEntity()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not characterMO then
		logError("ArcadeEntityMgr:_onLoadCharacterEntity error, characterMO is nil")

		return
	end

	local loadingCharacterId = characterMO:getId()
	local uid = characterMO:getUid()
	local resPath = characterMO:getRes()
	local characterPrefabAssetRes = self._scene.loader:getResource(resPath)

	if characterPrefabAssetRes then
		local goCharacterEntity = gohelper.create3d(self.go, string.format("character-%s", loadingCharacterId))

		self._characterEntity = MonoHelper.addNoUpdateLuaComOnceToGo(goCharacterEntity, ArcadeGameCharacterEntity, {
			uid = uid,
			id = loadingCharacterId,
			entityType = ArcadeGameEnum.EntityType.Character
		})

		local goPrefabParent = self._characterEntity:getPrefabParentGO()
		local goPrefab = gohelper.clone(characterPrefabAssetRes, goPrefabParent, characterPrefabAssetRes.name)

		self._characterEntity:addPrefabGO(goPrefab)
	end

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnLoadFinishGameCharacter)
end

function ArcadeEntityMgr:clearAllEntity(includeCharacter, includeGrid)
	if self._scene then
		local curRoom = self._scene.roomMgr:getCurRoom()

		if includeCharacter then
			if self._characterEntity then
				if self._scene then
					local mo = self._characterEntity:getMO()

					self._scene:removeEntityOccupyGrids(mo)
				end

				self._characterEntity:destroy()
			end

			self._characterEntity = nil
		end

		if includeGrid then
			if self._gridEntityDict then
				for _, entity in pairs(self._gridEntityDict) do
					entity:destroy()
				end
			end

			self._gridEntityDict = {}
		end

		if self._entityDict then
			for _, dict in pairs(self._entityDict) do
				for _, entity in pairs(dict) do
					if self._scene then
						local mo = entity:getMO()

						self._scene:removeEntityOccupyGrids(mo)
					end

					entity:destroy()
				end
			end
		end

		self._entityDict = {}
	end
end

function ArcadeEntityMgr:setAllEntityIsShow(isShow)
	gohelper.setActive(self.go, isShow)
end

function ArcadeEntityMgr:addEventListeners()
	return
end

function ArcadeEntityMgr:removeEventListeners()
	return
end

function ArcadeEntityMgr:addEntityByList(moList, canOverY, cb, cbObj)
	if self._scene then
		local curRoom = self._scene.roomMgr:getCurRoom()

		if not moList or #moList <= 0 or not self._scene then
			ArcadeGameHelper.callCallbackFunc(cb, cbObj)

			return
		end

		local resDict = {}
		local resList = {}
		local loadDataList = {}

		for i, mo in ipairs(moList) do
			local res = mo:getRes()

			if res and not resDict[res] then
				resDict[res] = true
				resList[#resList + 1] = res
			end

			loadDataList[i] = {
				entityType = mo:getEntityType(),
				uid = mo:getUid()
			}

			self._scene:tryAddEntityOccupyGrids(mo, canOverY)
		end

		self._scene.loader:loadResList(resList, self._onLoadEntityListRes, self, {
			loadDataList = loadDataList,
			cb = cb,
			cbObj = cbObj
		})
	end
end

function ArcadeEntityMgr:_onLoadEntityListRes(param)
	if self._scene then
		local curRoom = self._scene.roomMgr:getCurRoom()

		if not self._scene or not param then
			return
		end

		local loadDataList = param.loadDataList

		for _, loadData in ipairs(loadDataList) do
			local uid = loadData.uid
			local entityType = loadData.entityType
			local mo = ArcadeGameModel.instance:getMOWithType(entityType, uid)

			if mo then
				local id = mo:getId()
				local resPath = mo:getRes()
				local typeDict = self._entityDict[entityType]

				if not typeDict then
					typeDict = {}
					self._entityDict[entityType] = typeDict
				end

				local entityCls = ArcadeGameEnum.EntityTypeCls[entityType]

				if entityCls then
					local prefabAssetRes = self._scene.loader:getResource(resPath)

					if prefabAssetRes then
						local goEntity = gohelper.create3d(self.go, string.format("%s-%s-%s", entityType, id, uid))
						local entity = MonoHelper.addNoUpdateLuaComOnceToGo(goEntity, entityCls, {
							id = id,
							uid = uid,
							entityType = entityType
						})
						local goPrefabParent = entity:getPrefabParentGO()
						local goPrefab = gohelper.clone(prefabAssetRes, goPrefabParent, prefabAssetRes.name)

						entity:addPrefabGO(goPrefab)
						entity:refreshPosition()

						typeDict[uid] = entity
					else
						self._scene:removeEntityOccupyGrids(mo)
						logError(string.format("ArcadeEntityMgr:_onLoadEntityListRes error, resPath:%s no asset", resPath))
					end
				else
					self._scene:removeEntityOccupyGrids(mo)
					logError(string.format("ArcadeEntityMgr:_onLoadEntityListRes error, entityType:%s no cls define", entityType))
				end
			end
		end

		ArcadeGameHelper.callCallbackFunc(param.cb, param.cbObj)
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnLoadEntityFinished, loadDataList)
	end
end

function ArcadeEntityMgr:removeEntityWithType(entityType, uid, needWaitRemoveAnim)
	if self._scene then
		local curRoom = self._scene.roomMgr:getCurRoom()

		if entityType == ArcadeGameEnum.EntityType.Character then
			if self._characterEntity then
				if self._scene then
					local mo = self._characterEntity:getMO()

					self._scene:removeEntityOccupyGrids(mo)
				end

				self._characterEntity:destroy()
			end

			self._characterEntity = nil
		else
			local entity = self:getEntityWithType(entityType, uid)

			if entity then
				if self._scene then
					local mo = entity:getMO()

					self._scene:removeEntityOccupyGrids(mo)
				end

				if not needWaitRemoveAnim then
					entity:destroy()
				end

				self._entityDict[entityType][uid] = nil
			end
		end
	end
end

function ArcadeEntityMgr:changeEntityPrefab(entityType, uid, targetPrefabName)
	if not self._scene then
		return
	end

	local entity = self:getEntityWithType(entityType, uid)

	if not entity or string.nilorempty(targetPrefabName) then
		return
	end

	local hasPrefab = entity:isHasPrefab(targetPrefabName)

	if hasPrefab then
		entity:change2Prefab(targetPrefabName)
	else
		local resPath = ResUrl.getArcadeSceneRes(targetPrefabName)

		self._scene.loader:loadRes(resPath, self._onLoadChangePrefab, self, {
			entityType = entityType,
			uid = uid,
			targetPrefabName = targetPrefabName
		})
	end
end

function ArcadeEntityMgr:_onLoadChangePrefab(param)
	if not self._scene or not param then
		return
	end

	local entity = self:getEntityWithType(param.entityType, param.uid)

	if not entity then
		return
	end

	local targetPrefabName = param.targetPrefabName
	local resPath = ResUrl.getArcadeSceneRes(targetPrefabName)
	local prefabAssetRes = self._scene.loader:getResource(resPath)
	local goPrefabParent = entity:getPrefabParentGO()
	local goPrefab = gohelper.clone(prefabAssetRes, goPrefabParent, prefabAssetRes.name)

	entity:addPrefabGO(goPrefab)
	entity:change2Prefab(targetPrefabName)
end

function ArcadeEntityMgr:getEntityWithType(entityType, uid)
	if entityType == ArcadeGameEnum.EntityType.Character then
		return self:getCharacterEntity()
	elseif entityType == ArcadeGameEnum.EntityType.Grid then
		local gridX, gridY = ArcadeGameHelper.getGridXYById(uid)

		return self:getGridEntity(gridX, gridY)
	else
		local dict = self._entityDict[entityType]

		return dict and dict[uid]
	end
end

function ArcadeEntityMgr:getCharacterEntity()
	return self._characterEntity
end

function ArcadeEntityMgr:getGridEntity(gridX, gridY)
	local isOutSide = ArcadeGameHelper.isOutSideRoom(gridX, gridY)

	if isOutSide then
		return
	end

	local gridId = ArcadeGameHelper.getGridId(gridX, gridY)

	if not gridId then
		return
	end

	local gridEntity = self._gridEntityDict[gridId]

	if gridEntity then
		return gridEntity
	end

	gridEntity = self:_createGridEntity(gridX, gridY)
	self._gridEntityDict[gridId] = gridEntity

	return gridEntity
end

function ArcadeEntityMgr:_createGridEntity(gridX, gridY)
	local isOutSide = ArcadeGameHelper.isOutSideRoom(gridX, gridY)

	if isOutSide then
		return
	end

	if gohelper.isNil(self._gridRoot) then
		local goName = "GridRoot"
		local findGO = gohelper.findChild(self.go, goName)

		if gohelper.isNil(findGO) then
			findGO = gohelper.create3d(self.go, goName)
		end

		self._gridRoot = findGO

		gohelper.setAsFirstSibling(self._gridRoot)
	end

	local gridMO = ArcadeGameModel.instance:getGridMOByXY(gridX, gridY)
	local gridId = gridMO:getUid()
	local goGrid = gohelper.create3d(self._gridRoot, string.format("grid-%s", gridId))
	local gridEntity = MonoHelper.addNoUpdateLuaComOnceToGo(goGrid, ArcadeGameBaseEntity, {
		uid = gridId,
		id = gridId,
		entityType = ArcadeGameEnum.EntityType.Grid
	})

	gridEntity:refreshPosition()

	return gridEntity
end

function ArcadeEntityMgr:getEntityDictWithType(entityType)
	if entityType == ArcadeGameEnum.EntityType.Character then
		local characterEntity = self:getCharacterEntity()
		local uid = characterEntity and characterEntity:getUid()

		if uid then
			return {
				[uid] = characterEntity
			}
		end
	elseif entityType == ArcadeGameEnum.EntityType.Grid then
		return self._gridEntityDict
	else
		return self._entityDict[entityType]
	end
end

function ArcadeEntityMgr:getMonsterEntity(uid)
	return self:getEntityWithType(ArcadeGameEnum.EntityType.Monster, uid)
end

function ArcadeEntityMgr:onClear()
	return
end

return ArcadeEntityMgr
