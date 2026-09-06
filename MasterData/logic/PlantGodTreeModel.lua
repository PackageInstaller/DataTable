-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plantgodtree/model/PlantGodTreeModel.lua

module("logic.extensions.planetarium.model.PlantGodTreeModel", package.seeall)

local PlantGodTreeModel = class("PlantGodTreeModel", BaseModel)

function PlantGodTreeModel:onInit()
	self:onReset()
end

function PlantGodTreeModel:onReset()
	self._infos = {}
	self._treeInfoMap = {}
	self._eventMap = {}
end

function PlantGodTreeModel:getInfo(activityId)
	return self._infos[activityId]
end

function PlantGodTreeModel:getTreeInfoMap(activityId)
	return self._treeInfoMap[activityId]
end

function PlantGodTreeModel:getEventInfoMap(activityId)
	return self._eventMap[activityId]
end

function PlantGodTreeModel:handlePM_PlantGodTreeGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
	self._treeInfoMap[msg.activityId] = self._treeInfoMap[msg.activityId] or {}
	self._eventMap[msg.activityId] = self._eventMap[msg.activityId] or {}

	local info = self._infos[msg.activityId]
	local treeInfoMap = self._treeInfoMap[msg.activityId]
	local eventInfoMap = self._eventMap[msg.activityId]

	info.treeInfoList = info.treeInfoList or {}

	local treeInfoList = info.treeInfoList

	for i, treeInfo in ipairs(treeInfoList) do
		treeInfoMap[treeInfo.treeId] = treeInfo
		treeInfo.eventList = treeInfo.eventList or {}
		eventInfoMap[treeInfo.treeId] = {}

		local eventMap = eventInfoMap[treeInfo.treeId]

		for j, eventInfo in ipairs(treeInfo.eventList) do
			eventMap[eventInfo.eventId] = eventInfo
		end
	end
end

function PlantGodTreeModel:handlePM_PlantGodTreePushStepRes(msg)
	local treeInfoMap = self._treeInfoMap[msg.activityId]
	local treeId = msg.treeInfo.treeId

	treeInfoMap[treeId] = msg.treeInfo

	local treeInfo = treeInfoMap[treeId]
	local eventInfoMap = self._eventMap[msg.activityId]
	local eventMap = eventInfoMap[treeId]

	for j, eventInfo in ipairs(treeInfo.eventList) do
		eventMap[eventInfo.eventId] = eventInfo
	end
end

function PlantGodTreeModel:handlePM_PlantGodTreeDoEventRes(msg)
	local treeInfoMap = self._treeInfoMap[msg.activityId]
	local eventInfoMap = self._eventMap[msg.activityId]
	local treeId = msg.treeId
	local eventMap = eventInfoMap[treeId]
	local treeInfo = treeInfoMap[treeId]

	treeInfo.wateringCount = msg.wateringCount
	eventMap[msg.event.eventId] = msg.event
end

function PlantGodTreeModel:handlePM_PlantGodTreeGainPrizeRes(msg)
	local eventInfoMap = self._eventMap[msg.activityId]
	local treeId = msg.treeInfo.treeId
	local eventMap = eventInfoMap[treeId]

	for i, eventInfo in ipairs(msg.treeInfo.eventList) do
		eventMap[eventInfo.eventId] = eventInfo
	end
end

PlantGodTreeModel.instance = PlantGodTreeModel.New()

return PlantGodTreeModel
