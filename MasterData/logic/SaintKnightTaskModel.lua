-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/model/SaintKnightTaskModel.lua

module("logic.extensions.saintknighttask.model.SaintKnightTaskModel", package.seeall)

local SaintKnightTaskModel = class("SaintKnightTaskModel", BaseModel)

function SaintKnightTaskModel:ctor()
	return
end

function SaintKnightTaskModel:onInit()
	self:onReset()
end

function SaintKnightTaskModel:onReset()
	self._tasksGetInfoResMsg = {}
	self._rankInfoResMsgs = {}
	self._worldTasksInfoList = {}
	self._personTaskDataList = {}
	self._isPersonTaskInfoLoaded = false
	self._hasTeamInfo = false
	self._teamInfo = {}
	self._verifyFormZdlResMsg = {}
	self._gainTeamPrizeResMsg = {}
	self._gainTeamPrizeIds = {}
	self._joinTeamResMsg = {}
	self._sktFmtCustomFmtMo = nil
	self._isPassVerify = false
end

function SaintKnightTaskModel:handleCollectionTasksGetInfoRes(msg)
	self._tasksGetInfoResMsg = msg
	self._isPassVerify = msg.isPassVerify
end

function SaintKnightTaskModel:handleCollectionTasksGetRankInfoRes(msg)
	self._rankInfoResMsgs[msg.rankId] = msg
end

function SaintKnightTaskModel:handleCollectionTasksGainPrizeRes(msg)
	return
end

function SaintKnightTaskModel:handleSK_GetPersonTaskRes(msg)
	self._personTaskDataList = msg.taskList
	self._isPersonTaskInfoLoaded = true
	self._hasTeamInfo = msg:HasField("teamInfo")

	if self._hasTeamInfo then
		self._teamInfo = msg.teamInfo or {}
	end

	self._gainTeamPrizeIds = {}
end

function SaintKnightTaskModel:handleSK_GainPersonTaskPrizeRes(msg)
	return
end

function SaintKnightTaskModel:handleWorldTasksGetInfoRes(msg)
	self._worldTasksInfoList = msg.infos
end

function SaintKnightTaskModel:handleWorldTasksGainPrizeRes(msg)
	return
end

function SaintKnightTaskModel:handleSKVerifyFormZdlRes(msg)
	self._verifyFormZdlResMsg = msg
	self._isPassVerify = msg.isPassVerify
end

function SaintKnightTaskModel:handleSKGainVerifyPrizeRes(msg)
	return
end

function SaintKnightTaskModel:handleSK_GainTeamPrizeRes(msg)
	self._gainTeamPrizeResMsg = msg

	for _, prizeId in ipairs(msg.prizeId or {}) do
		if not self:isHasGainPrizeAsTeam(prizeId) then
			table.insert(self._gainTeamPrizeIds, prizeId)
		end
	end
end

function SaintKnightTaskModel:handleSK_JoinTeamRes(msg)
	self._joinTeamResMsg = msg
end

function SaintKnightTaskModel:isHasGainAsCollePrize()
	return self:_getTasksGetInfoResMsg().isGainPrize
end

function SaintKnightTaskModel:isCanGainAsCollePrize()
	return self:_getTasksGetInfoResMsg().isCanGainPrize
end

function SaintKnightTaskModel:isGainVerifyPrize()
	return self:_getTasksGetInfoResMsg().isGainVerifyPrize
end

function SaintKnightTaskModel:isPassVerify()
	return checkbool(self._isPassVerify)
end

function SaintKnightTaskModel:_getTasksGetInfoResMsg()
	return self._tasksGetInfoResMsg
end

function SaintKnightTaskModel:getMyRankInCollection(rankId)
	return checknumber(self:_getRankResMsg(rankId).myRank)
end

function SaintKnightTaskModel:getCollectionTasksRankInfoList(rankId)
	return self:_getRankResMsg(rankId).rankInfos or {}
end

function SaintKnightTaskModel:_getRankResMsg(rankId)
	return self._rankInfoResMsgs[rankId] or {}
end

function SaintKnightTaskModel:getTaskDataAsPersonTask(taskId)
	local targetData

	for _, data in ipairs(self._personTaskDataList) do
		if data.taskId == taskId then
			targetData = data

			break
		end
	end

	return targetData
end

function SaintKnightTaskModel:getProgressAsPersonTask(taskId)
	local data = self:getTaskDataAsPersonTask(taskId)

	return checknumber(data and data.curProgress)
end

function SaintKnightTaskModel:isHasGainPrizeAsPersonTask(taskId)
	local data = self:getTaskDataAsPersonTask(taskId)

	return checkbool(data and data.hasGainPrize)
end

function SaintKnightTaskModel:getTeamInfo()
	return self._teamInfo or {}
end

function SaintKnightTaskModel:isPersonTaskInfoLoaded()
	return checkbool(self._isPersonTaskInfoLoaded)
end

function SaintKnightTaskModel:isInTeam()
	local captainId = self:getTeamCaptainId()
	local userId = tostring(RoleModel.instance:getUserId())

	if captainId ~= nil and tostring(captainId) ~= "" and tostring(captainId) ~= "0" and tostring(captainId) ~= userId then
		return true
	end

	for _, memberInfo in ipairs(self:getTeamMembers()) do
		local headInfo = self:getTeamMemberHeadInfo(memberInfo)

		if headInfo and tostring(headInfo.userId) ~= userId then
			return true
		end
	end

	return false
end

function SaintKnightTaskModel:getTeamProgress(activityId)
	if not self._hasTeamInfo then
		return self:_getLocalTeamProgress(activityId)
	end

	return checknumber(self:getTeamInfo().teamProgress)
end

function SaintKnightTaskModel:_getLocalTeamProgress(activityId)
	local data = SaintKnightTaskConfig.instance:getSktTeamConfigData(activityId)

	return checknumber(MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, data.activityItemId))
end

function SaintKnightTaskModel:getTeamMembers()
	return self:getTeamInfo().teamMembers or {}
end

function SaintKnightTaskModel:getTeamCaptainId()
	return self:getTeamInfo().captainId
end

function SaintKnightTaskModel:isTeamCaptain()
	local captainId = self:getTeamCaptainId()

	return captainId ~= nil and tostring(captainId) == tostring(RoleModel.instance:getUserId())
end

function SaintKnightTaskModel:getTeamMemberHeadInfo(memberInfo)
	return (memberInfo or nil) and (memberInfo.headInfo or nil)
end

function SaintKnightTaskModel:getTeamMemberProgress(memberInfo)
	return (memberInfo or nil) and (memberInfo.progress or 0)
end

function SaintKnightTaskModel:isHasGainPrizeAsTeam(prizeId)
	local gainPrizeIds = self:getTeamInfo().gainPrizeIds or {}

	for _, id in ipairs(gainPrizeIds) do
		if id == prizeId then
			return true
		end
	end

	for _, id in ipairs(self._gainTeamPrizeIds) do
		if id == prizeId then
			return true
		end
	end

	return false
end

function SaintKnightTaskModel:getJoinTeamState()
	return checknumber(self._joinTeamResMsg.state)
end

function SaintKnightTaskModel:getWorldTasksInfo(worldTaskPlanId)
	local targetInfo

	for _, info in ipairs(self._worldTasksInfoList) do
		if info.worldTaskPlanId == worldTaskPlanId then
			targetInfo = info

			break
		end
	end

	return targetInfo
end

function SaintKnightTaskModel:getWorldTasksGainUserNum(worldTaskPlanId)
	local info = self:getWorldTasksInfo(worldTaskPlanId)

	return (info or nil) and (info.gainUserNum or 0)
end

function SaintKnightTaskModel:isHasGainPrizeInWorldTasks(worldTaskPlanId, index)
	local isHasGain = false
	local info = self:getWorldTasksInfo(worldTaskPlanId)

	if info == nil then
		return isHasGain
	end

	for _, prizeId in ipairs(info.prizeIds) do
		if index == prizeId then
			isHasGain = true
		end
	end

	return isHasGain
end

function SaintKnightTaskModel:getOverPercentOfVerify()
	return checknumber(self._verifyFormZdlResMsg.overPercent)
end

function SaintKnightTaskModel:getFormZdlOfVerify()
	return checknumber(self._verifyFormZdlResMsg.formZdl)
end

function SaintKnightTaskModel:getSktFmtCustomFmtMo()
	if self._sktFmtCustomFmtMo == nil then
		self._sktFmtCustomFmtMo = SKTFormationCustomFmtMo.New()
	end

	return self._sktFmtCustomFmtMo
end

SaintKnightTaskModel.instance = SaintKnightTaskModel.New()

return SaintKnightTaskModel
