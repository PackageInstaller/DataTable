-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonTransPoints.lua

module("logicscene.scene.component.season.SceneCompSeasonTransPoints", package.seeall)

local SceneCompSeasonTransPoints = class("SceneCompSeasonTransPoints", SceneComponentBase)

function SceneCompSeasonTransPoints:onEnterScene(sceneId, bornX, bornZ)
	SceneCompSeasonTransPoints.super.onEnterScene(self, sceneId, bornX, bornZ)
end

function SceneCompSeasonTransPoints:onEnterSceneFinished(sceneId, bornX, bornZ)
	local seasonId = SeasonModel.instance:getSeasonId()

	self._rainBows = {}
	self._transpoints = {}

	local evtCfgs = SeasonConfig.instance:getAllEvts(seasonId)

	for k, v in pairs(evtCfgs) do
		if v.eventType == SeasonGridEvtTypes.EVT_RAINBOW then
			local elementId = checknumber(v.linkObjIds)

			if elementId > 0 then
				local row, col = self._scene:getCellRowAndColIndexByElementId(elementId)

				self._rainBows[v.id] = SeasonPathFindingDataModel.instance:grid2Id(row, col)
			end
		elseif v.eventType == SeasonGridEvtTypes.EVT_CONVEY then
			local elementId = checknumber(v.linkObjIds)

			if elementId > 0 then
				local row, col = self._scene:getCellRowAndColIndexByElementId(elementId)

				self._transpoints[v.id] = SeasonPathFindingDataModel.instance:grid2Id(row, col)
			end
		end
	end
end

function SceneCompSeasonTransPoints:getPathWithtranspoints(startX, startY, destX, destY)
	local agent = SeasonPathFindingAgent.New(self._rainBows, self._transpoints, self._scene.pathFinder)

	return agent:getPathWithTranspoints(startX, startY, destX, destY)
end

function SceneCompSeasonTransPoints:getNearestTransmitGroupPos(startX, startY, endX, endY)
	self:clearLocks()

	return self:_doGetNearestTransmitGroupPos(startX, startY, endX, endY)
end

function SceneCompSeasonTransPoints:_doGetNearestTransmitGroupPos(startX, startY, endX, endY)
	self._tryCount = self._tryCount or 0
	self._tryCount = self._tryCount + 1

	if self._tryCount > 10 then
		return
	end

	local maxDistance = math.sqrt((startX - endX) * (startX - endX) + (startY - endY) * (startY - endY))
	local isFound = false
	local sx, sy, dx, dy, p_id

	for k, v in pairs(self._rainBows) do
		local dist, s_possx, s_posy, d_possx, d_posy, posId = self:_getTransmitGroupPos(maxDistance, startX, startY, endX, endY, k, v)

		if dist and self:_hasPath(startX, startY, endX, endY, s_possx, s_posy, d_possx, d_posy) then
			maxDistance = dist
			isFound = true
			sx = s_possx
			sy = s_posy
			dx = d_possx
			dy = d_posy
			p_id = posId

			self:_lock(posId)
		end
	end

	for k, v in pairs(self._transpoints) do
		local dist, s_possx, s_posy, d_possx, d_posy, posId = self:_getTransmitGroupPos(maxDistance, startX, startY, endX, endY, k, v)

		if dist and self:_hasPath(startX, startY, endX, endY, s_possx, s_posy, d_possx, d_posy) then
			maxDistance = dist
			isFound = true
			sx = s_possx
			sy = s_posy
			dx = d_possx
			dy = d_posy
			p_id = posId

			self:_lock(posId)
		end
	end

	return isFound, sx, sy, dx, dy, p_id
end

function SceneCompSeasonTransPoints:_getTransmitGroupPos(maxDistance, startX, startY, endX, endY, startId, destId)
	if self:_isLock(startId) then
		return
	end

	local s_row, s_col = SeasonPathFindingDataModel.instance:id2Grid(startId)
	local d_row, d_col = SeasonPathFindingDataModel.instance:id2Grid(destId)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, startId)

	if evtCfg and evtCfg.eventType == SeasonGridEvtTypes.EVT_CONVEY then
		local mapData = SeasonModel.instance:getMapInfoById(evtCfg.id)

		if mapData and mapData:isLock() then
			return
		end
	end

	local s_possx, s_posy = SeasonPathFindingDataModel.instance:grid2Pos(s_row, s_col)
	local d_possx, d_posy = SeasonPathFindingDataModel.instance:grid2Pos(d_row, d_col)
	local dist = math.sqrt((startX - s_possx) * (startX - s_possx) + (startY - s_posy) * (startY - s_posy)) + math.sqrt((endX - d_possx) * (endX - d_possx) + (endY - d_posy) * (endY - d_posy))

	if dist < maxDistance then
		return dist, s_possx, s_posy, d_possx, d_posy, startId
	end
end

function SceneCompSeasonTransPoints:_hasPath(startX, startY, destX, destY, t_sx, t_sy, t_dx, t_dy)
	local runningPath = self._scene.pathFinder:getPath(nil, startX, startY, t_sx, t_sy)

	if not runningPath or #runningPath == 0 then
		return
	end

	runningPath = self._scene.pathFinder:getPath(nil, t_dx, t_dy, destX, destY)

	if not runningPath or #runningPath == 0 then
		return
	end

	return true
end

function SceneCompSeasonTransPoints:_lock(id)
	self._lockTrans = self._lockTrans or {}
	self._lockTrans[id] = true
end

function SceneCompSeasonTransPoints:clearLocks()
	if self._lockTrans then
		table.clear(self._lockTrans)
	end

	self._tryCount = 0
end

function SceneCompSeasonTransPoints:_isLock(id)
	return self._lockTrans and self._lockTrans[id]
end

return SceneCompSeasonTransPoints
