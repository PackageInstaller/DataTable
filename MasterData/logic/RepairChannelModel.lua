-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/repairchannel/model/RepairChannelModel.lua

module("logic.extensions.repairchannel.model.RepairChannelModel", package.seeall)

local RepairChannelModel = class("RepairChannelModel", BaseModel)

function RepairChannelModel:onInit()
	self:onReset()
end

function RepairChannelModel:onReset()
	self._infoMap = {}
end

function RepairChannelModel:onGetInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = data.activityId
	local branchProgressMap = {}

	if data.branchProgresses then
		for _, progress in ipairs(data.branchProgresses) do
			branchProgressMap[progress.left] = progress.right
		end
	end

	data.branchProgressMap = branchProgressMap
	self._infoMap[activityId] = data
end

function RepairChannelModel:onRepairNode(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infoMap[data.activityId]

	if info then
		if not info.branchProgressMap then
			info.branchProgressMap[data.branchId] = data.nodeId
			info.branchProgressMap = info.branchProgressMap
		end
	end
end

function RepairChannelModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function RepairChannelModel:getBranchProgressMap(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.branchProgressMap or {}
	end

	return {}
end

function RepairChannelModel:getRepairedNodeId(activityId, branchId)
	local branchProgressMap = self:getBranchProgressMap(activityId)
	local progress = branchProgressMap[branchId]

	if progress then
		return progress
	end

	return 0
end

RepairChannelModel.instance = RepairChannelModel.New()

return RepairChannelModel
