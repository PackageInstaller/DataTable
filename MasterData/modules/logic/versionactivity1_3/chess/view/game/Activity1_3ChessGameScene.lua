-- chunkname: @modules/logic/versionactivity1_3/chess/view/game/Activity1_3ChessGameScene.lua

module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameScene", package.seeall)

local Activity1_3ChessGameScene = class("Activity1_3ChessGameScene", Va3ChessGameScene)

function Activity1_3ChessGameScene:_editableInitView()
	self._btnEffect1ClickArea = gohelper.findChildButton(self.viewGO, "btn_effect1ClickArea")
	self._btnEffect2ClickArea = gohelper.findChildButton(self.viewGO, "btn_effect2ClickArea")
	self._fireTileMap = {}
	self._sightTileMap = {}

	Activity1_3ChessGameScene.super._editableInitView(self)
end

function Activity1_3ChessGameScene:addEvents()
	Activity1_3ChessGameScene.super.addEvents(self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.ObjMoveStep, self._onObjMove, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.ObjMoveEnd, self._onObjMoveEnd, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, self._onEnterNextMap, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, self._onHpUpdate, self)
	self.addEventCb(self, Activity1_3ChessGameController.instance, Activity1_3ChessEvent.UpdateGameScene, self._onMapUpdate, self)
	self.addEventCb(self, Activity1_3ChessGameController.instance, Activity1_3ChessEvent.InitGameScene, self._onSceneInit, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, self._onResetGame, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, self._onReadGame, self)
	self._btnEffect1ClickArea:AddClickListener(self._onClickEffect1, self)
	self._btnEffect2ClickArea:AddClickListener(self._onClickEffect2, self)
end

function Activity1_3ChessGameScene:removeEvents()
	Activity1_3ChessGameScene.super.removeEvents(self)
	self.removeEventCb(self, Activity1_3ChessGameController.instance, Activity1_3ChessEvent.UpdateGameScene, self._onMapUpdate, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.ObjMoveStep, self._onObjMove, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.ObjMoveEnd, self._onObjMoveEnd, self)
	self.removeEventCb(self, Activity1_3ChessGameController.instance, Activity1_3ChessEvent.InitGameScene, self._onSceneInit, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, self._onEnterNextMap, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, self._onHpUpdate, self)
	self.removeEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, self._onResetGame, self)
	self.removeEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, self._onReadGame, self)
	self._btnEffect1ClickArea:RemoveClickListener()
	self._btnEffect2ClickArea:RemoveClickListener()
end

function Activity1_3ChessGameScene:onRefreshViewParam()
	local camera = CameraMgr.instance:getMainCamera()
	local unitCamera = CameraMgr.instance:getUnitCamera()

	unitCamera.orthographic = true
	unitCamera.orthographicSize = camera.orthographicSize

	gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
	PostProcessingMgr.instance:setUnitActive(true)
	PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
	PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
end

function Activity1_3ChessGameScene:initCamera()
	return
end

function Activity1_3ChessGameScene:resetCamera()
	return
end

function Activity1_3ChessGameScene:loadRes()
	UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getCurrentSceneUrl())
	self._loader:addPath(Va3ChessEnum.SceneResPath.GroundItem)
	self._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	self._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	self:onLoadRes()
	self._loader:startLoad(self.loadResCompleted, self)
end

function Activity1_3ChessGameScene:onLoadRes()
	self._loader:addPath(Activity1_3ChessEnum.SceneResPath.FireTile)
	self._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile1)
	self._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile2)
	self._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile3)
	self._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightEdgeTile)
end

function Activity1_3ChessGameScene:createAllInteractObjs()
	if not Va3ChessGameController.instance.interacts then
		return
	end

	local list = Va3ChessGameController.instance.interacts:getList()

	table.sort(list, Va3ChessInteractMgr.sortRenderOrder)

	for _, interactObj in ipairs(list) do
		if interactObj:GetIgnoreSight() then
			self:createInteractObj(interactObj)
		end
	end

	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.AllObjectCreated, self.createAllInteractObjs, self)
end

function Activity1_3ChessGameScene:onloadResCompleted(loader)
	local fogGo = gohelper.findChild(self._sceneGo, "Obj-Plant/scence_smoke")

	gohelper.setActive(fogGo, true)

	self._sceneSight = UnityEngine.GameObject.New("sight")

	transformhelper.setLocalPos(self._sceneSight.transform, 0, 0, -2.5)

	self._sceneFire = UnityEngine.GameObject.New("fire")

	transformhelper.setLocalPos(self._sceneFire.transform, 0, 0, -1)
	self._sceneSight.transform:SetParent(self._sceneGo.transform, false)
	self._sceneFire.transform:SetParent(self._sceneGo.transform, false)

	self._sceneEffect1 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/vx_click_quan")
	self._sceneEffect2 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/vx_click_eye")

	if self._sceneEffect1 then
		local uiCamera = CameraMgr.instance:getUICamera()
		local mainCamera = CameraMgr.instance:getMainCamera()
		local effectPos = Vector3.New()

		effectPos.x, effectPos.y, effectPos.z = transformhelper.getPos(self._sceneEffect1.transform)

		local localPos = recthelper.worldPosToAnchorPos(effectPos, self.viewGO.transform, uiCamera, mainCamera)
		local effectPos2 = Vector3.New()

		effectPos2.x, effectPos2.y, effectPos2.z = transformhelper.getPos(self._sceneEffect2.transform)
		self._btnEffect1ClickArea.transform.localPosition = localPos
		self._btnEffect2ClickArea.transform.localPosition = recthelper.worldPosToAnchorPos(effectPos2, self.viewGO.transform, uiCamera, mainCamera)

		gohelper.setActive(self._sceneEffect1, false)
		gohelper.setActive(self._sceneEffect2, false)
	else
		gohelper.setActive(self._btnEffect1ClickArea.gameObject, false)
		gohelper.setActive(self._btnEffect2ClickArea.gameObject, false)
	end

	self:_onSceneInit()
end

function Activity1_3ChessGameScene:_onSceneInit()
	self:removeFireTiles()
	self:removeSightTiles()

	local sightMap = Activity122Model.instance:getCurEpisodeSightMap()

	for posIndex, sightData in pairs(sightMap) do
		local x, y = Va3ChessMapUtils.calPosXY(posIndex)

		self:createSightTileItem(x, y)

		local len, result = Va3ChessGameController.instance:searchInteractByPos(x, y)

		if len == 1 then
			local objOnTile = result

			if objOnTile then
				self:createInteractObj(objOnTile)
			end
		elseif len > 1 then
			local objsOnTile = result

			for _, obj in pairs(objsOnTile) do
				self:createInteractObj(obj)
			end
		end
	end

	local fireMap = Activity122Model.instance:getCurEpisodeFireMap()

	for posIndex, fireData in pairs(fireMap) do
		local x, y = Va3ChessMapUtils.calPosXY(posIndex)

		self:createFireTileItem(x, y)
	end

	local mapId = Va3ChessGameModel.instance:getMapId()

	Activity1_3ChessGameController.instance:dispatchEvent(Activity1_3ChessEvent.GameSceneInited, mapId)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameViewOpened, self.viewParam)
end

function Activity1_3ChessGameScene:onOpenFinish()
	return
end

function Activity1_3ChessGameScene:onChessStateUpdate(state)
	Activity1_3ChessGameScene.super.onChessStateUpdate(self)

	if state == Va3ChessEnum.GameEventType.Normal then
		-- block empty
	end
end

function Activity1_3ChessGameScene:_onMapUpdate(mapData)
	local addFires = mapData.addFires
	local isCreateFire = false

	if addFires then
		for _, fireData in ipairs(addFires) do
			self:createFireTileItem(fireData.x, fireData.y)

			isCreateFire = true
		end
	end

	if isCreateFire then
		AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.FireSpread)
	end

	local removeFires = mapData.removeFires

	if removeFires then
		for _, fireData in ipairs(removeFires) do
			self:hideFireTileItem(fireData.x, fireData.y)
		end
	end

	local sights = mapData.addSights

	if sights then
		for _, sightData in ipairs(sights) do
			self:createSightTileItem(sightData.x, sightData.y)

			local len, result = Va3ChessGameController.instance:searchInteractByPos(sightData.x, sightData.y)

			if len == 1 then
				if len == 1 then
					if not result[1] then
						local objOnTile = result

						if objOnTile and not self._avatarMap[objOnTile.id] then
							self:createInteractObj(objOnTile)
						end
					end
				end
			elseif len > 1 then
				for _, objOnTile in pairs(result) do
					if not self._avatarMap[objOnTile.id] then
						self:createInteractObj(objOnTile)
					end
				end
			end
		end
	end
end

function Activity1_3ChessGameScene:_onObjMove(objId, targetX, targetY)
	local targetPosIndex = Va3ChessMapUtils.calPosIndex(targetX, targetY)
	local isTargetPosInSight = Activity122Model.instance:checkPosIndexInSight(targetPosIndex)

	if not isTargetPosInSight then
		return
	end

	if self._avatarMap[objId] then
		local interactMgr = Va3ChessGameController.instance.interacts
		local interactObj = interactMgr:get(objId)
		local handler = interactObj:getHandler()

		handler:setAlertActive(true)
		gohelper.setActive(self._avatarMap[objId].sceneGo, true)

		return
	end

	local interactMgr = Va3ChessGameController.instance.interacts
	local interactObj = interactMgr:get(objId)

	self:createInteractObj(interactObj)
end

function Activity1_3ChessGameScene:_onObjMoveEnd(objId, targetX, targetY)
	local targetPosIndex = Va3ChessMapUtils.calPosIndex(targetX, targetY)
	local isTargetPosInSight = Activity122Model.instance:checkPosIndexInSight(targetPosIndex)

	if not isTargetPosInSight then
		if not self._avatarMap[objId] then
			return
		end

		gohelper.setActive(self._avatarMap[objId].sceneGo, false)

		local interactMgr = Va3ChessGameController.instance.interacts
		local interactObj = interactMgr:get(objId)
		local handler = interactObj:getHandler()

		handler:setAlertActive(false)
	end
end

function Activity1_3ChessGameScene:_onHpUpdate()
	local interactMgr = Va3ChessGameController.instance.interacts
	local interactObj = interactMgr:getMainPlayer()

	if interactObj and interactObj:getHandler() then
		interactObj:getHandler():showHitAni()
	end
end

function Activity1_3ChessGameScene:_onClickEffect1()
	if not self._sceneEffect1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.DrumHit)
	gohelper.setActive(self._sceneEffect1, false)
	gohelper.setActive(self._sceneEffect1, true)
end

function Activity1_3ChessGameScene:_onClickEffect2()
	if not self._sceneEffect2 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.MonsterCroaking)
	gohelper.setActive(self._sceneEffect2, false)
	gohelper.setActive(self._sceneEffect2, true)
end

function Activity1_3ChessGameScene:createFireTileItem(x, y)
	local fireTileObj
	local tileIndex = Va3ChessMapUtils.calPosIndex(x, y)

	if self._fireTileMap[tileIndex] then
		fireTileObj = self._fireTileMap[tileIndex]
	end

	if not fireTileObj then
		fireTileObj = self:getUserDataTb_()

		local assetItem = self._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath.FireTile)
		local itemGo = gohelper.clone(assetItem:GetResource(), self._sceneFire, "fireTile" .. x .. "_" .. y)

		fireTileObj.go = itemGo
		fireTileObj.sceneTf = itemGo.transform
		self._fireTileMap[tileIndex] = fireTileObj

		Activity1_3ChessGameController.instance:dispatchEvent(Activity1_3ChessEvent.GameSceneFireCreated, tileIndex)
	end

	gohelper.setActive(fireTileObj.go, true)
	self:setTileBasePosition(fireTileObj, x, y)

	return fireTileObj
end

function Activity1_3ChessGameScene:hideFireTileItem(x, y)
	local tileIndex = Va3ChessMapUtils.calPosIndex(x, y)

	if self._fireTileMap[tileIndex] then
		gohelper.setActive(self._fireTileMap[tileIndex].go, false)
	end
end

function Activity1_3ChessGameScene:removeFireTiles()
	for _, tileObj in pairs(self._fireTileMap) do
		UnityEngine.GameObject.Destroy(tileObj.go)

		tileObj.sceneTf = nil
	end

	self._fireTileMap = {}
end

function Activity1_3ChessGameScene:createSightTileItem(x, y)
	local sightTileObj
	local tileIndex = Va3ChessMapUtils.calPosIndex(x, y)

	if self._sightTileMap[tileIndex] then
		sightTileObj = self._sightTileMap[tileIndex]
	end

	if not sightTileObj then
		local isEdgeTile = Va3ChessMapUtils.IsEdgeTile(x, y)

		sightTileObj = self:getUserDataTb_()

		local assetItem

		if isEdgeTile then
			assetItem = self._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath.SightEdgeTile)
		else
			local randomIndex = math.random(3)

			assetItem = self._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath["SightTile" .. randomIndex])
		end

		local itemGo = gohelper.clone(assetItem:GetResource(), self._sceneSight, "sightTile" .. x .. "_" .. y)

		sightTileObj.go = itemGo
		sightTileObj.sceneTf = itemGo.transform
		self._sightTileMap[tileIndex] = sightTileObj
	end

	gohelper.setActive(sightTileObj.go, true)
	self:setTileBasePosition(sightTileObj, x, y)

	return sightTileObj
end

function Activity1_3ChessGameScene:hideSightTileItem(x, y)
	local tileIndex = Va3ChessMapUtils.calPosIndex(x, y)

	if self._sightTileMap[tileIndex] then
		gohelper.setActive(self._sightTileMap[tileIndex].go, false)
	end
end

function Activity1_3ChessGameScene:removeSightTiles()
	for _, tileObj in pairs(self._sightTileMap) do
		UnityEngine.GameObject.Destroy(tileObj.go)

		tileObj.sceneTf = nil
	end

	self._sightTileMap = {}
end

function Activity1_3ChessGameScene:_onResetGame()
	self:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function Activity1_3ChessGameScene:_onReadGame()
	self:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function Activity1_3ChessGameScene:_onEnterNextMap()
	self:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function Activity1_3ChessGameScene:handleResetByResult()
	self:removeFireTiles()
	self:removeSightTiles()
	self:resetTiles()
	Activity1_3ChessGameScene.super.handleResetByResult(self)
end

function Activity1_3ChessGameScene:onDestroyView()
	self:removeFireTiles()
	self:removeSightTiles()
	self:removeEvents()
	Activity1_3ChessGameScene.super.onDestroyView(self)
end

return Activity1_3ChessGameScene
