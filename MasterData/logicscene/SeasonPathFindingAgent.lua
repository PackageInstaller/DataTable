-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SeasonPathFindingAgent.lua

module("logicscene.scene.component.season.SeasonPathFindingAgent", package.seeall)

local SeasonPathFindingAgent = class("SeasonPathFindingAgent")

function SeasonPathFindingAgent:ctor(rainBows, transpoints, pathFinder, lockTrans)
	self._lockTrans = lockTrans
	self._rainBows = rainBows
	self._transpoints = transpoints
	self._pathFinder = pathFinder
end

function SeasonPathFindingAgent:getPathWithTranspoints(startX, startY, destX, destY)
	self._allPaths = {}

	local oringinPath = self._pathFinder:getGridPath(startX, startY, destX, destY)

	if oringinPath and #oringinPath > 0 then
		if #oringinPath <= 40 then
			return oringinPath
		end

		table.insert(self._allPaths, oringinPath)
	end

	self:_doGetPathWithTranspoints(startX, startY, destX, destY)

	local minDistance = math.huge
	local targetPath

	for i = 1, #self._allPaths do
		local path = self._allPaths[i]
		local dist = #path

		if dist < minDistance then
			minDistance = dist
			targetPath = path
		end
	end

	return targetPath
end

function SeasonPathFindingAgent:_doGetPathWithTranspoints(startX, startY, destX, destY)
	for k, v in pairs(self._rainBows) do
		local path = self:_getTransmitGroupPosPath(startX, startY, destX, destY, k, v)

		if path and #path > 0 then
			table.insert(self._allPaths, path)
		else
			self:_lock(k)
		end
	end

	for k, v in pairs(self._transpoints) do
		local path = self:_getTransmitGroupPosPath(startX, startY, destX, destY, k, v)

		if path and #path > 0 then
			table.insert(self._allPaths, path)
		else
			self:_lock(k)
		end
	end
end

function SeasonPathFindingAgent:_getTransmitGroupPosPath(startX, startY, endX, endY, startId, destId)
	if self:_isLock(startId) then
		return
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, startId)

	if evtCfg and evtCfg.eventType == SeasonGridEvtTypes.EVT_CONVEY then
		local mapData = SeasonModel.instance:getMapInfoById(evtCfg.id)

		if mapData and mapData:isLock() then
			return
		end
	end

	local s_row, s_col = SeasonPathFindingDataModel.instance:id2Grid(startId)
	local d_row, d_col = SeasonPathFindingDataModel.instance:id2Grid(destId)

	return self:_getPaths(startX, startY, endX, endY, s_row, s_col, d_row, d_col, startId, destId)
end

function SeasonPathFindingAgent:_getPaths(startX, startY, destX, destY, t_sx, t_sy, t_dx, t_dy, startId, destId)
	local s_Path

	if startX == t_sx and startY == t_sy then
		s_Path = {}
	else
		s_Path = self._pathFinder:getGridPath(startX, startY, t_sx, t_sy)

		if not s_Path or #s_Path == 0 then
			return
		end
	end

	local e_Path = self._pathFinder:getGridPath(t_dx, t_dy, destX, destY)

	if not e_Path or #e_Path == 0 then
		return
	end

	table.insert(s_Path, t_dx)
	table.insert(s_Path, t_dy)

	for i = 1, #e_Path do
		table.insert(s_Path, e_Path[i])
	end

	return s_Path
end

function SeasonPathFindingAgent:_lock(id)
	self._lockTrans = self._lockTrans or {}
	self._lockTrans[id] = true
end

function SeasonPathFindingAgent:_isLock(id)
	return self._lockTrans and self._lockTrans[id]
end

return SeasonPathFindingAgent
