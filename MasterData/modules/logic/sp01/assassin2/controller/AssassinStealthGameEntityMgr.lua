-- chunkname: @modules/logic/sp01/assassin2/controller/AssassinStealthGameEntityMgr.lua

module("modules.logic.sp01.assassin2.controller.AssassinStealthGameEntityMgr", package.seeall)

local AssassinStealthGameEntityMgr = class("AssassinStealthGameEntityMgr", BaseController)

function AssassinStealthGameEntityMgr:onInit()
	self:clearAll()
end

function AssassinStealthGameEntityMgr:reInit()
	self:clearAll()
end

function AssassinStealthGameEntityMgr:clearAll()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._hasLoadedRes = false

	UIBlockMgr.instance:endBlock(AssassinEnum.BlockKey.LoadGameRes)
	self:clearAllEntity(true)
	self:clearMap()
end

function AssassinStealthGameEntityMgr:clearAllEntity(includeHero)
	if includeHero then
		if self._heroDict then
			for _, heroEntity in pairs(self._heroDict) do
				heroEntity:destroy()
			end
		end

		self._heroDict = {}
	end

	if self._enemyDict then
		for _, enemyEntity in pairs(self._enemyDict) do
			enemyEntity:destroy()
		end
	end

	self._enemyDict = {}
end

function AssassinStealthGameEntityMgr:clearMap()
	self._gridDict = self:getUserDataTb_()
	self._horWallDict = self:getUserDataTb_()
	self._verWallDict = self:getUserDataTb_()
	self._goGridDecors = nil
	self._goEntities = nil
	self._goGridEffs = nil
	self._goInfo = nil
	self._transGridDecors = nil
	self._transEntities = nil
	self._transGridEffs = nil
	self._transInfo = nil
end

function AssassinStealthGameEntityMgr:onInitBaseMap(goMap)
	self:clearAll()
	self:_initMap(goMap)
	self:_startLoadRes()
	UnityEngine.Canvas.ForceUpdateCanvases()
end

function AssassinStealthGameEntityMgr:_initMap(goMap)
	self._gridDict = {}
	self._horWallDict = {}
	self._verWallDict = {}

	local allGridList = {}
	local allHorWallList = {}
	local allVerWallList = {}
	local mapSize = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.MapSize, true)

	for y = 1, mapSize do
		local strLeftVerWallId = string.format("%s%s%s", AssassinEnum.StealthConst.VerWallSign, 0, y)

		allVerWallList[#allVerWallList + 1] = tonumber(strLeftVerWallId)
	end

	for x = 1, mapSize do
		local strBottomHorWallId = string.format("%s%s%s", AssassinEnum.StealthConst.HorWallSign, x, 0)

		allHorWallList[#allHorWallList + 1] = tonumber(strBottomHorWallId)

		for y = 1, mapSize do
			local strGridId = string.format("%s%s", x, y)
			local strHorWallId = string.format("%s%s%s", AssassinEnum.StealthConst.HorWallSign, x, y)
			local strVerWallId = string.format("%s%s%s", AssassinEnum.StealthConst.VerWallSign, x, y)

			allGridList[#allGridList + 1] = tonumber(strGridId)
			allHorWallList[#allHorWallList + 1] = tonumber(strHorWallId)
			allVerWallList[#allVerWallList + 1] = tonumber(strVerWallId)
		end
	end

	local goGridParent = gohelper.findChild(goMap, "#go_grids")
	local goGrid = gohelper.findChild(goMap, "#go_grids/#go_gridItem")
	local goHorParent = gohelper.findChild(goMap, "#go_walls/#go_hor")
	local goHorWall = gohelper.findChild(goMap, "#go_walls/#go_hor/#go_horWall")
	local goVerParent = gohelper.findChild(goMap, "#go_walls/#go_ver")
	local goVerWall = gohelper.findChild(goMap, "#go_walls/#go_ver/#go_verWall")

	self._goGridDecors = gohelper.findChild(goMap, "#go_gridDecors")
	self._goEntities = gohelper.findChild(goMap, "#go_entities")
	self._goGridEffs = gohelper.findChild(goMap, "#go_gridEffs")
	self._goInfo = gohelper.findChild(goMap, "#go_infos")
	self._transGridDecors = self._goGridDecors.transform
	self._transEntities = self._goEntities.transform
	self._transGridEffs = self._goGridEffs.transform
	self._transInfo = self._goInfo.transform

	gohelper.CreateObjList(self, self._onCreateGridItem, allGridList, goGridParent, goGrid, AssassinStealthGameGridItem)
	gohelper.CreateObjList(self, self._onCreateHorWallItem, allHorWallList, goHorParent, goHorWall, AssassinStealthGameWallItem)
	gohelper.CreateObjList(self, self._onCreateVerWallItem, allVerWallList, goVerParent, goVerWall, AssassinStealthGameWallItem)
end

function AssassinStealthGameEntityMgr:_onCreateGridItem(obj, data, _)
	obj:initData(data)
	obj:setEffParent(self._goGridEffs, self._transGridEffs)

	self._gridDict[data] = obj
end

function AssassinStealthGameEntityMgr:_onCreateHorWallItem(obj, data, _)
	obj:initData(data, true)

	self._horWallDict[data] = obj
end

function AssassinStealthGameEntityMgr:_onCreateVerWallItem(obj, data, _)
	obj:initData(data, false)

	self._verWallDict[data] = obj
end

function AssassinStealthGameEntityMgr:_startLoadRes()
	if self._loader then
		self._loader:dispose()
	end

	self._hasLoadedRes = false
	self._loader = MultiAbLoader.New()

	if string.nilorempty(next(AssassinEnum.StealthRes)) then
		self:_loadResFinished()
	else
		for _, path in pairs(AssassinEnum.StealthRes) do
			self._loader:addPath(path)
		end

		UIBlockMgr.instance:startBlock(AssassinEnum.BlockKey.LoadGameRes)
		self._loader:startLoad(self._loadResFinished, self)
	end
end

function AssassinStealthGameEntityMgr:_loadResFinished()
	UIBlockMgr.instance:endBlock(AssassinEnum.BlockKey.LoadGameRes)

	self._hasLoadedRes = true

	self:setupMap()
end

function AssassinStealthGameEntityMgr:setupMap()
	self:_setMap()
	self:_initEntities()
end

function AssassinStealthGameEntityMgr:_setMap()
	UnityEngine.Canvas.ForceUpdateCanvases()

	local mapId = AssassinStealthGameModel.instance:getMapId()

	for _, grid in pairs(self._gridDict) do
		grid:setMap(mapId)
	end

	for _, horWall in pairs(self._horWallDict) do
		horWall:setMap(mapId)
	end

	for _, verWall in pairs(self._verWallDict) do
		verWall:setMap(mapId)
	end

	local stairList = AssassinConfig.instance:getMapStairList(mapId)
	local goStair = gohelper.findChild(self._goGridDecors, "#go_stair")

	gohelper.CreateObjList(self, self._onCreateStairItem, stairList, self._goGridDecors, goStair)
end

function AssassinStealthGameEntityMgr:_onCreateStairItem(obj, data, _)
	local stairTrans = obj.transform
	local gridId = data.gridId
	local dir = data.dir
	local gridItem = self:getGridItem(gridId, true)
	local stairNodeTrans = gridItem and gridItem:getEntranceNodeTrans(dir)

	if stairNodeTrans then
		stairTrans.pivot = stairNodeTrans.pivot
		stairTrans.anchorMin = stairNodeTrans.anchorMin
		stairTrans.anchorMax = stairNodeTrans.anchorMax

		local rotation = stairNodeTrans.rotation

		transformhelper.setRotation(stairTrans, rotation.x, rotation.y, rotation.z, rotation.w)

		local worldPos = stairNodeTrans.position
		local pos = self._transGridDecors:InverseTransformPoint(worldPos)

		transformhelper.setLocalPosXY(stairTrans, pos.x, pos.y)
	end

	obj.name = string.format("%s-%s", gridId, dir)
end

function AssassinStealthGameEntityMgr:_initEntities()
	self:clearAllEntity(true)

	local heroAssetItem = self._loader:getAssetItem(AssassinEnum.StealthRes.HeroEntity)

	if heroAssetItem then
		local heroUidList = AssassinStealthGameModel.instance:getHeroUidList()

		for _, uid in ipairs(heroUidList) do
			local goHero = gohelper.clone(heroAssetItem:GetResource(), self._goEntities)

			self._heroDict[uid] = MonoHelper.addNoUpdateLuaComOnceToGo(goHero, AssassinStealthGameHeroEntity, uid)
		end
	end

	local enemyAssetItem = self._loader:getAssetItem(AssassinEnum.StealthRes.EnemyEntity)

	if enemyAssetItem then
		local enemyUidList = AssassinStealthGameModel.instance:getEnemyUidList()

		self:addEnemyEntityByList(enemyUidList)
	end
end

function AssassinStealthGameEntityMgr:addEnemyEntityByList(enemyUidList)
	local enemyAssetItem = self._loader:getAssetItem(AssassinEnum.StealthRes.EnemyEntity)

	if not enemyAssetItem then
		logError("AssassinStealthGameEntityMgr:addEnemyEntityByList error, no enemyAssetItem")

		return
	end

	for _, enemyUid in ipairs(enemyUidList) do
		self:addEnemyEntity(enemyUid, enemyAssetItem)
	end
end

function AssassinStealthGameEntityMgr:addEnemyEntity(enemyUid, enemyAssetItem)
	local repeatedEntity = self:getEnemyEntity(enemyUid)

	if repeatedEntity then
		logError(string.format("AssassinStealthGameEntityMgr:addEnemyEntity error, enemy repeated, enemyUid:%s", enemyUid))

		return
	end

	enemyAssetItem = enemyAssetItem or self._loader:getAssetItem(AssassinEnum.StealthRes.EnemyEntity)

	if not enemyAssetItem then
		logError("AssassinStealthGameEntityMgr:addEnemyEntity error, no enemyAssetItem")

		return
	end

	local goEnemy = gohelper.clone(enemyAssetItem:GetResource(), self._goEntities)

	self._enemyDict[enemyUid] = MonoHelper.addNoUpdateLuaComOnceToGo(goEnemy, AssassinStealthGameEnemyEntity, enemyUid)
end

function AssassinStealthGameEntityMgr:removeEnemyEntity(enemyUid)
	local enemyEntity = self:getEnemyEntity(enemyUid, true)

	if enemyEntity then
		enemyEntity:playRemove()
	end

	self._enemyDict[enemyUid] = nil
end

function AssassinStealthGameEntityMgr:changeSkillPropTargetLayer(parentTrans)
	local hasTarget = false

	for gridId, gridItem in pairs(self._gridDict) do
		local isCanUseSkillProp2Grid = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(gridId)

		if isCanUseSkillProp2Grid then
			hasTarget = true

			gridItem:changeHighlightClickParent(parentTrans)
		else
			gridItem:changeHighlightClickParent()
		end
	end

	for heroUid, heroEntity in pairs(self._heroDict) do
		local isCanUseSkillProp2Hero = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToHero(heroUid)

		if isCanUseSkillProp2Hero then
			hasTarget = true

			heroEntity:changeParent(parentTrans)
		else
			heroEntity:changeParent(self._transEntities)
		end
	end

	for enemyUid, enemyEntity in pairs(self._enemyDict) do
		local isCanUseSkillProp2Enemy = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(enemyUid)

		if isCanUseSkillProp2Enemy then
			hasTarget = true

			enemyEntity:changeParent(parentTrans)
		else
			enemyEntity:changeParent(self._transEntities)
		end
	end

	return hasTarget
end

function AssassinStealthGameEntityMgr:refreshSkillPropTargetPos()
	local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not selectedSkillPropId then
		return
	end

	local targetType = AssassinConfig.instance:getSkillPropTargetType(selectedSkillPropId, selectedIsSkill)

	if targetType == AssassinEnum.SkillPropTargetType.Grid then
		for gridId, gridItem in pairs(self._gridDict) do
			local isCanUseSkillProp2Grid = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(gridId)

			if isCanUseSkillProp2Grid then
				gridItem:refreshHighlightPos()
			end
		end
	end

	if targetType == AssassinEnum.SkillPropTargetType.Hero then
		for heroUid, heroEntity in pairs(self._heroDict) do
			local isCanUseSkillProp2Hero = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToHero(heroUid)

			if isCanUseSkillProp2Hero then
				heroEntity:refreshPos()
			end
		end
	end

	if targetType == AssassinEnum.SkillPropTargetType.Enemy then
		for enemyUid, enemyEntity in pairs(self._enemyDict) do
			local isCanUseSkillProp2Enemy = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(enemyUid)

			if isCanUseSkillProp2Enemy then
				enemyEntity:refreshPos()
			end
		end
	end
end

function AssassinStealthGameEntityMgr:changeEnemyParent(enemyUid, parentTrans)
	local enemyEntity = self:getEnemyEntity(enemyUid, true)

	if not enemyEntity then
		return
	end

	enemyEntity:changeParent(parentTrans or self._transEntities)
end

function AssassinStealthGameEntityMgr:refreshAllGrid()
	for _, gridItem in pairs(self._gridDict) do
		gridItem:refresh()
	end
end

function AssassinStealthGameEntityMgr:refreshGrid(gridId, effectId)
	local gridItem = self:getGridItem(gridId, true)

	if gridItem then
		gridItem:refresh(effectId)
	end
end

function AssassinStealthGameEntityMgr:refreshAllHeroEntities()
	for _, heroEntity in pairs(self._heroDict) do
		heroEntity:refresh()
	end
end

function AssassinStealthGameEntityMgr:refreshHeroEntity(uid, effectId)
	local entity = self:getHeroEntity(uid, true)

	if entity then
		entity:refresh(effectId)
	end
end

function AssassinStealthGameEntityMgr:refreshAllEnemyEntities()
	for _, enemyEntity in pairs(self._enemyDict) do
		enemyEntity:refresh()
	end
end

function AssassinStealthGameEntityMgr:refreshEnemyEntity(uid, effectId)
	local entity = self:getEnemyEntity(uid, true)

	if entity then
		entity:refresh(effectId)
	end
end

function AssassinStealthGameEntityMgr:playHeroEff(heroUid, effectId)
	local heroEntity = self:getHeroEntity(heroUid, true)

	if not heroEntity then
		return
	end

	heroEntity:playEffect(effectId)
end

function AssassinStealthGameEntityMgr:playEnemyEff(enemyUid, effectId, finishCb, finishCbObj, finishCbParam, blockKey)
	local enemyEntity = self:getEnemyEntity(enemyUid, true)

	if not enemyEntity then
		return
	end

	enemyEntity:playEffect(effectId, finishCb, finishCbObj, finishCbParam, blockKey)
end

function AssassinStealthGameEntityMgr:playGridScanEff(gridId, finishCb, finishCbObj, finishCbParam)
	local gridItem = self:getGridItem(gridId, true)
	local isShowGrid = gridItem and gridItem:isShow()

	if not isShowGrid then
		return
	end

	gridItem:playEffect(AssassinEnum.EffectId.ScanEffectId, finishCb, finishCbObj, finishCbParam)
end

function AssassinStealthGameEntityMgr:playGridEff(gridId, effectId)
	local gridItem = self:getGridItem(gridId, true)
	local isShowGrid = gridItem and gridItem:isShow()

	if not isShowGrid then
		return
	end

	gridItem:playEffect(effectId)
end

function AssassinStealthGameEntityMgr:getGridItem(gridId, nilError)
	local gridItem = self._gridDict[gridId]

	if not gridId and nilError then
		logError(string.format("AssassinStealthGameEntityMgr:getGridItem error, no grid Item, gridId:%s", gridId))
	end

	return gridItem
end

function AssassinStealthGameEntityMgr:getGridPointGoPosInEntityLayer(gridId, pointIndex, transParent)
	local pos = Vector2.zero
	local gridItem = self:getGridItem(gridId, true)
	local pointTrans = gridItem and gridItem:getPointTrans(pointIndex)

	if pointTrans then
		local worldPos = pointTrans.position

		pos = not gohelper.isNil(transParent) and transParent:InverseTransformPoint(worldPos) or self._transEntities:InverseTransformPoint(worldPos)
	end

	return pos
end

function AssassinStealthGameEntityMgr:getHeroEntity(uid, nilError)
	local result = self._heroDict[uid]

	if not result and nilError then
		logError(string.format("AssassinStealthGameEntityMgr:getHeroEntity error, no entity uid:%s", uid))
	end

	return result
end

function AssassinStealthGameEntityMgr:getEnemyEntity(uid, nilError)
	local result = self._enemyDict[uid]

	if not result and nilError then
		logError(string.format("AssassinStealthGameEntityMgr:getEnemyEntity error, no entity uid:%s", uid))
	end

	return result
end

function AssassinStealthGameEntityMgr:getEnemyLocalPos(enemyUid)
	local enemyEntity = self:getEnemyEntity(enemyUid, true)

	if not enemyEntity then
		return
	end

	return enemyEntity:getLocalPos()
end

function AssassinStealthGameEntityMgr:getInfoTrans()
	return self._transInfo
end

AssassinStealthGameEntityMgr.instance = AssassinStealthGameEntityMgr.New()

return AssassinStealthGameEntityMgr
