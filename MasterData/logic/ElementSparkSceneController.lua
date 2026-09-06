-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/controller/ElementSparkSceneController.lua

module("logic.extensions.elementspark.controller.ElementSparkSceneController", package.seeall)

local ElementSparkSceneController = class("ElementSparkSceneController", BaseController)

function ElementSparkSceneController:ctor()
	return
end

function ElementSparkSceneController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.EleSparkGetInfoRes, self._loadDataRes, self)
	self:onReset()
end

function ElementSparkSceneController:onReset()
	self._enterSceneAfterLoadData = false
	self._isInElementScene = false
	self._lastSelectChunkId = -1
	self._cacheChunkBounds = nil
	self._locationChunkId = -1
	self._chunkId2InsId = {}
	self._camp2chunkId = {}

	removetimer(self._checkLocationChunkVisible, self)
	removetimer(self._sendGetResourceReq, self)
end

function ElementSparkSceneController:enterScene()
	local stageType = ElementSparkController.instance:getActivityStage()

	if stageType == GameEnum.ElementSparkStageType.Notopen then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	self:_initCamp2ChunkId()
	self:_loadData()
end

function ElementSparkSceneController:enterElementSpark()
	ElementSparkController.instance:setActivityId()

	local stageType = ElementSparkController.instance:getActivityStage()

	if stageType == GameEnum.ElementSparkStageType.Notopen then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	UIStateManager.instance:push(ViewName.ElementSparkStageView)
end

function ElementSparkSceneController:_loadData()
	self._enterSceneAfterLoadData = true

	local activityId = ElementSparkController.instance:getActivityId()

	ElementSparkController.instance:sendPM_EleSparkGetInfoReq(activityId)
end

function ElementSparkSceneController:_loadDataRes()
	if self._enterSceneAfterLoadData then
		self:_enterScene()
	end

	self:updateChunks()
end

function ElementSparkSceneController:_enterScene()
	self._enterSceneAfterLoadData = false
	self._isInElementScene = true

	SceneStatusMgr.instance:saveStatus()
	self:_initParams()
	settimer(3600, self._sendGetResourceReq, self)
	SceneMgr.instance:enter(SceneType.ElementSpark, 100, 0, 0)
end

function ElementSparkSceneController:levevScene()
	SceneStatusMgr.instance:popStatus(ViewName.MainUI)
	ElementSparkController.instance:sendPM_EleSparkExitReq()
	self:onReset()
end

function ElementSparkSceneController:onSelectUnitId(eleInsId)
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	local unit = SceneMgr.instance:getCurScene().unitFactory:getUnit(UnitTag.TilingSceneElem, eleInsId)

	if unit then
		local chunkId = unit.chunkId

		if ElementSparkModel.instance:isTagMode() then
			GlobalDispatcher:dispatch(GlobalNotify.ElementSparkClickChunkWithTag, unit)

			return
		end

		local planId = ElementSparkController.instance:getMapPlanId()
		local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, chunkId)
		local belong = ElementSparkModel.instance:getChunkBelong(chunkId)
		local belongMe = ElementSparkModel.instance:getChunlBelongMe(chunkId)

		self._lastSelectChunkId = chunkId

		if chunkCfg.chunkType == "camp" then
			if belong ~= ElementSparkModel.instance:getMyCampId() then
				FloatWordMgr.instance:show("非己方阵营，无法查看")

				return
			end

			UIStateManager.instance:push(ViewName.ElementSparkInfoView, ElementSparkInfoView.TabConst.Info)

			return
		end

		if chunkCfg.chunkType == "blank" then
			return
		end

		if chunkCfg.chunkType == "petShop" then
			UIStateManager.instance:push(ViewName.ElementsparkpetshopView, chunkId)

			return
		end

		if chunkCfg.chunkType == "resource" then
			if not belongMe then
				FloatWordMgr.instance:show("该资源地尚未占领")

				return
			end

			UIStateManager.instance:push(ViewName.ElementSparkInfoView, ElementSparkInfoView.TabConst.Resource)

			return
		end

		if chunkCfg.chunkType == "spark" then
			UIStateManager.instance:push(ViewName.ElementsparkpopView)

			return
		end

		if chunkCfg.chunkType == "guard" then
			if belong == ElementSparkModel.instance:getMyCampId() then
				UIStateManager.instance:push(ViewName.ElementSparkCampView, chunkId)
			else
				self:_onSelectNotBelongMeGuardChunk(chunkCfg)
			end
		end
	end
end

function ElementSparkSceneController:_onSelectNotBelongMeGuardChunk(chunkCfg)
	local isProtect = ElementSparkModel.instance:getChunkInProtect(chunkCfg.chunkId)

	if isProtect then
		FloatWordMgr.instance:show("地块属于保护期，无法进入")

		return
	end

	local hasBelongMe, isInprotect = self:_hasChunkBelongMeAround(chunkCfg)

	if hasBelongMe then
		UIStateManager.instance:push(ViewName.ElementSparkBossView, chunkCfg.chunkId)
	elseif isInprotect then
		FloatWordMgr.instance:show("相邻地块正处于保护期,暂时无法攻打")
	else
		FloatWordMgr.instance:show("己方阵营暂未占领相邻地块,暂时无法攻打")
	end
end

function ElementSparkSceneController:_hasChunkBelongMeAround(chunkCfg)
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)
	local isInprotect = false
	local nearList = {}
	local campId = ElementSparkModel.instance:getMyCampId()

	for i, v in pairs(chunkCfgs) do
		if chunkCfg.chunkId ~= v.chunkId then
			local belong = ElementSparkModel.instance:getChunkBelong(v.chunkId)

			if belong == campId and self:_isCellAInCellB(chunkCfg, v.pos, v.anotherPos) then
				table.insert(nearList, v.chunkId)

				local inProtect = ElementSparkModel.instance:getChunkInProtect(v.chunkId)

				if inProtect then
					isInprotect = true
				else
					return true
				end
			end
		end
	end

	if Framework.OSDef.isEditor then
		local belong = ElementSparkModel.instance:getChunkBelong(chunkCfg.chunkId)

		print("==========lgj?????", "想输出啥", "当前点击格子：", chunkCfg.chunkId, " 属于：", belong)

		for i, v in pairs(chunkCfgs) do
			if chunkCfg.chunkId ~= v.chunkId and self:_isCellAInCellB(chunkCfg, v.pos, v.anotherPos) then
				belong = ElementSparkModel.instance:getChunkBelong(v.chunkId)

				print("==========lgj?????", "想输出啥", "附近格子:", v.chunkId, " 属于：", belong)
			end
		end
	end

	return false, isInprotect
end

function ElementSparkSceneController:_isCellAInCellB(chunkCfg, pos, anotherPos)
	local startX_A = chunkCfg.pos[1]
	local startY_A = chunkCfg.pos[2]
	local endX_A = chunkCfg.anotherPos[1]
	local endY_A = chunkCfg.anotherPos[2]
	local startX_B = pos[1]
	local startY_B = pos[2]
	local endX_B = anotherPos[1]
	local endY_B = anotherPos[2]

	if startY_A == endY_B + 1 and startX_B <= startX_A and endX_A <= endX_B then
		return true
	end

	if endY_A == startY_B - 1 and startX_B <= startX_A and endX_A <= endX_B then
		return true
	end

	if endX_A == startX_B - 1 and startY_B <= startY_A and endY_A <= endY_B then
		return true
	end

	if startX_A == endX_B + 1 and startY_B <= startY_A and endY_A <= endY_B then
		return true
	end

	return false
end

function ElementSparkSceneController:isInScene()
	return self._isInElementScene
end

function ElementSparkSceneController:isInActivityTime()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ElementSpark)

	return activityId > 0
end

function ElementSparkSceneController:updateChunks()
	local currScene = SceneMgr.instance:getCurScene()

	if currScene and currScene:getSceneType() == SceneType.ElementSpark then
		currScene.unitFactory:updateAllEle()
	end
end

function ElementSparkSceneController:getCurrSelectChunkId()
	return self._lastSelectChunkId
end

function ElementSparkSceneController:_initParams()
	local activityId = ElementSparkController.instance:getActivityId()
	local actCfg = ElementSparkConfig.instance:getActivityCfgById(activityId)
	local mapSize = actCfg.mapSize

	ElementSparkElemsMgr.TotalRow = mapSize[1]
	ElementSparkElemsMgr.TotalCol = mapSize[2]
	self.ltx, self.lty = self:getBgTilePos(0, 0, false)
	self.rbx, self.rby = self:getBgTilePos(ElementSparkElemsMgr.TotalRow - 1, ElementSparkElemsMgr.TotalCol - 1, false)
	self.lbx, self.lby = self:getBgTilePos(ElementSparkElemsMgr.TotalRow - 1, 0, false)
	self.rtx, self.rty = self:getBgTilePos(0, ElementSparkElemsMgr.TotalCol - 1, false)
	ElementSparkElemsMgr.OffsetX = math.abs(self.lbx - self.ltx) + ElementSparkElemsMgr.TileBoundX
	ElementSparkElemsMgr.OffsetY = math.abs(self.lty - self.rby) + ElementSparkElemsMgr.TileBoundY
	ElementSparkElemsMgr.MapSizeX = math.abs(self.lbx - self.rtx) + ElementSparkElemsMgr.TileBoundX
	ElementSparkElemsMgr.MapSizeY = math.abs(self.lty - self.rby) + ElementSparkElemsMgr.TileBoundY
end

function ElementSparkSceneController:getBgTilePos(row, col, needOffset)
	if needOffset == nil then
		needOffset = true
	end

	local offsetX, offsetY = 0, 0

	if needOffset then
		offsetY = ElementSparkElemsMgr.OffsetY
		offsetX = ElementSparkElemsMgr.OffsetX
	end

	local boundX = ElementSparkElemsMgr.TileStep.x
	local boundY = ElementSparkElemsMgr.TileStep.y
	local curRowX = col * boundX
	local curRowY = (-col - row) * boundY
	local centerX = -boundX * row

	x = curRowX + centerX + offsetX
	y = curRowY + offsetY

	return x, y
end

function ElementSparkSceneController:getTilePos(pos, anotherPos)
	if pos[1] == anotherPos[1] and pos[2] == anotherPos[2] then
		return self:getBgTilePos(pos[1], pos[2])
	end

	local x1, y1 = self:getBgTilePos(pos[1], pos[2])
	local x2, y2 = self:getBgTilePos(anotherPos[1], anotherPos[2])
	local minX = math.min(x1, x2)
	local maxY = math.max(y1, y2)
	local x = math.abs(x2 - x1) / 2 + minX
	local y = maxY - math.abs(y2 - y1) / 2

	return x, y
end

function ElementSparkSceneController:getVectexPos()
	return self.ltx + ElementSparkElemsMgr.OffsetX, self.lty + ElementSparkElemsMgr.OffsetY, self.lbx + ElementSparkElemsMgr.OffsetX, self.lby + ElementSparkElemsMgr.OffsetY, self.rtx + ElementSparkElemsMgr.OffsetX, self.rty + ElementSparkElemsMgr.OffsetY, self.rbx + ElementSparkElemsMgr.OffsetX, self.rby + ElementSparkElemsMgr.OffsetY
end

function ElementSparkSceneController:getNearCameraChunkId()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()
	local camSizeH = mainCam.orthographicSize * 2
	local camSizeW = mainCam.aspect * camSizeH
	local camX, camY = Framework.TransformUtil.GetPos(mainCamera:getGO().transform, 0, 0, 0)
	local cameraBounds = UnityEngine.Rect.New(camX - camSizeW / 2, camY - camSizeH / 2, camSizeW, camSizeH)

	if not self._cacheChunkBounds then
		self._cacheChunkBounds = {}

		local planId = ElementSparkController.instance:getMapPlanId()
		local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)

		for k, v in pairs(chunkCfgs) do
			local x, y = self:getTilePos(v.pos, v.anotherPos)
			local size = ElementSparkElemsMgr.TileBoundX * math.max(v.anotherPos[2] - v.pos[2] + 1, v.anotherPos[1] - v.pos[1] + 1)
			local bounds = UnityEngine.Rect.New(x - size / 2, y - size / 2, size, size)

			self._cacheChunkBounds[v.chunkId] = {
				bounds = bounds,
				x = x,
				y = y
			}
		end
	end

	local nearChunId = 0
	local minDistance = -1

	for chunkId, v in pairs(self._cacheChunkBounds) do
		if self:_isDetected(cameraBounds, v.bounds) then
			local dis = self:_getDistance(cameraBounds, v.bounds)

			if minDistance == -1 or dis < minDistance then
				minDistance = dis
				nearChunId = chunkId
			end
		end
	end

	return nearChunId
end

function ElementSparkSceneController:_isDetected(cameraBounds, bounds)
	return cameraBounds:Overlaps(bounds)
end

function ElementSparkSceneController:_getDistance(bounds1, bounds2)
	return math.pow(bounds1.center.x - bounds2.center.x, 2) + math.pow(bounds1.center.y - bounds2.center.y, 2)
end

function ElementSparkSceneController:setLocationChunkId(chunkId)
	self._locationChunkId = chunkId
end

function ElementSparkSceneController:getLocationChunkId()
	return self._locationChunkId
end

function ElementSparkSceneController:moveChunkToCenterAndLocation(chunkId)
	self:setLocationChunkId(chunkId)
	GlobalDispatcher:dispatch(GlobalNotify.ElementSparkMoveChunkToCenter, chunkId)

	self._locationTime = 0

	settimer(0, self._checkLocationChunkVisible, self)
end

function ElementSparkSceneController:_checkLocationChunkVisible()
	local chunkId = self:getLocationChunkId()

	if chunkId <= 0 then
		removetimer(self._checkLocationChunkVisible, self)

		return
	end

	self._locationTime = self._locationTime + Time.deltaTime

	if self._locationTime >= 0.5 then
		removetimer(self._checkLocationChunkVisible, self)
		self:setLocationChunkId(-1)

		return
	end

	local insId = self:getInsId(chunkId)

	if insId then
		local unit = SceneMgr.instance:getCurScene().unitFactory:getUnit(UnitTag.TilingSceneElem, insId)

		if unit and unit.updateHud then
			unit:updateHud()
			removetimer(self._checkLocationChunkVisible, self)

			return
		end
	end
end

function ElementSparkSceneController:addUnit(chunkId, insId)
	self._chunkId2InsId[chunkId] = insId
end

function ElementSparkSceneController:removeUnit(chunkId, insId)
	self._chunkId2InsId[chunkId] = insId
end

function ElementSparkSceneController:getInsId(chunkId)
	return self._chunkId2InsId[chunkId]
end

function ElementSparkSceneController:_sendGetResourceReq()
	local activityId = ElementSparkController.instance:getActivityId()

	ElementSparkController.instance:sendPM_EleSparkGetResourceInfoReq(activityId)
end

function ElementSparkSceneController:_initCamp2ChunkId()
	local activityId = ElementSparkController.instance:getActivityId()

	if activityId <= 0 then
		return
	end

	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)

	self._camp2chunkId = {}

	if chunkCfgs then
		for i, v in pairs(chunkCfgs) do
			if v.chunkType == GameEnum.ElementSparkChunkType.Camp then
				self._camp2chunkId[v.initCamp] = v.chunkId
			end
		end
	end
end

function ElementSparkSceneController:getWinnerChunkId()
	local winId = ElementSparkModel.instance:getWinnerCampId()

	return self._camp2chunkId[winId] or 0
end

ElementSparkSceneController.instance = ElementSparkSceneController.New()

return ElementSparkSceneController
