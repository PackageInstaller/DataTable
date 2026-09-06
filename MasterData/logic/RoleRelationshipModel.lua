-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/model/RoleRelationshipModel.lua

module("logic.extensions.rolerelationship.model.RoleRelationshipModel", package.seeall)

local RoleRelationshipModel = class("RoleRelationshipModel", BaseModel)

function RoleRelationshipModel:ctor()
	return
end

function RoleRelationshipModel:onInit()
	self:onReset()
end

function RoleRelationshipModel:onReset()
	self._activityId = 0
	self._mapInfoRes = {
		canUnlockTimes = 0,
		unlockedLines = {},
		roleInfos = {},
		gainedProgressPrizeIds = {}
	}
	self._taskInfoRes = {
		taskInfos = {}
	}
end

function RoleRelationshipModel:onHandleRRMGetMapInfoRes(msg)
	self._activityId = checknumber(msg.activityId)
	self._mapInfoRes.canUnlockTimes = checknumber(msg.canUnlockTimes)

	local tab = {}

	for _, id in ipairs(msg.unlockedLines) do
		table.insert(tab, checknumber(id))
	end

	self._mapInfoRes.unlockedLines = tab

	local info = {}

	tab = {}

	for _, v in ipairs(msg.roleInfos) do
		tab = {
			roleId = checknumber(v.roleId),
			archiveId = checknumber(v.archiveId),
			gainedImpressIds = {}
		}

		for _, id in ipairs(v.gainedImpressIds) do
			table.insert(tab.gainedImpressIds, checknumber(id))
		end

		table.insert(info, tab)
	end

	self._mapInfoRes.roleInfos = info
	tab = {}

	for _, prizeId in ipairs(msg.gainedProgressPrizeIds) do
		table.insert(tab, checknumber(prizeId))
	end

	self._mapInfoRes.gainedProgressPrizeIds = tab
end

function RoleRelationshipModel:onHandleRRMGetTaskInfoRes(msg)
	self._activityId = checknumber(msg.activityId)
	self._mapInfoRes.canUnlockTimes = checknumber(msg.canUnlockTimes)

	local info = {}

	for _, v in ipairs(msg.taskInfos) do
		table.insert(info, {
			taskId = checknumber(v.taskId),
			curProgress = checknumber(v.curProgress)
		})
	end

	self._taskInfoRes.taskInfos = info
end

function RoleRelationshipModel:onHandleRRMUnlockLineRes(msg)
	self._mapInfoRes.canUnlockTimes = self._mapInfoRes.canUnlockTimes - 1

	table.insert(self._mapInfoRes.unlockedLines, checknumber(msg.lineId))
end

function RoleRelationshipModel:onHandleRRMGainProgressPrizeRes(msg)
	table.insert(self._mapInfoRes.gainedProgressPrizeIds, checknumber(msg.prizeId))
end

function RoleRelationshipModel:onHandleRRMGainImpressPrizeRes(msg)
	local roleId = checknumber(msg.roleId)
	local archiveId = checknumber(msg.archiveId)
	local impressId = checknumber(msg.impressId)
	local index = 0

	for idx, v in ipairs(self._mapInfoRes.roleInfos) do
		if v.roleId == roleId and v.archiveId == archiveId then
			index = idx
		end
	end

	if index ~= 0 then
		table.insert(self._mapInfoRes.roleInfos[index].gainedImpressIds, impressId)
	else
		local tab = {
			roleId = roleId,
			archiveId = archiveId,
			gainedImpressIds = {
				impressId
			}
		}

		table.insert(self._mapInfoRes.roleInfos, tab)
	end
end

function RoleRelationshipModel:getCurActivityId()
	return self._activityId
end

function RoleRelationshipModel:getCanUnlockTimes()
	return self._mapInfoRes.canUnlockTimes
end

function RoleRelationshipModel:getUnlockTimes()
	return #self._mapInfoRes.unlockedLines
end

function RoleRelationshipModel:getUnlockedLines()
	return self._mapInfoRes.unlockedLines
end

function RoleRelationshipModel:getGainedImpressIds(roleId, archiveId)
	local gainedImpressIds = {}

	for _, info in ipairs(self._mapInfoRes.roleInfos) do
		if info.roleId == roleId and info.archiveId == archiveId then
			gainedImpressIds = info.gainedImpressIds

			break
		end
	end

	return gainedImpressIds
end

function RoleRelationshipModel:getTaskCurProgress(taskId)
	local curProgress = 0

	for _, info in ipairs(self._taskInfoRes.taskInfos) do
		if info.taskId == taskId then
			curProgress = info.curProgress
		end
	end

	return curProgress
end

function RoleRelationshipModel:getGainedProgressPrizeIds()
	return self._mapInfoRes.gainedProgressPrizeIds
end

RoleRelationshipModel.instance = RoleRelationshipModel.New()

return RoleRelationshipModel
