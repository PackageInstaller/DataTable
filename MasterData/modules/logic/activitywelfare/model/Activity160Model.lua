-- chunkname: @modules/logic/activitywelfare/model/Activity160Model.lua

module("modules.logic.activitywelfare.model.Activity160Model", package.seeall)

local Activity160Model = class("Activity160Model", BaseModel)

function Activity160Model:onInit()
	self:reInit()
end

function Activity160Model:reInit()
	self.infoDic = {}
end

function Activity160Model:setInfo(msg)
	local actId = msg.activityId
	local actInfo = self:getActInfo(actId)

	for _, info in ipairs(msg.act160Infos) do
		actInfo[info.id] = info
	end

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, actId)
end

function Activity160Model:updateInfo(msg)
	local actId = msg.activityId
	local actInfo = self:getActInfo(actId)

	actInfo[msg.act160Info.id] = msg.act160Info

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, actId)
end

function Activity160Model:finishMissionReply(msg)
	local actId = msg.activityId
	local actInfo = self:getActInfo(actId)

	actInfo[msg.act160Info.id] = msg.act160Info

	Activity160Controller.instance:dispatchEvent(Activity160Event.InfoUpdate, actId)

	if msg.isReadMail then
		Activity160Controller.instance:dispatchEvent(Activity160Event.HasReadMail, actId, msg.act160Info.id)
	end
end

function Activity160Model:getActInfo(actId)
	self.infoDic[actId] = self.infoDic[actId] or {}

	return self.infoDic[actId]
end

function Activity160Model:getCurMission(actId)
	local actInfo = self:getActInfo(actId)

	for id, info in ipairs(actInfo) do
		if info.state ~= 2 then
			return id
		end
	end

	return actInfo[#actInfo].id
end

function Activity160Model:hasRewardClaim(actId)
	local actInfo = self:getActInfo(actId)

	for _, info in pairs(actInfo) do
		if info.state == 1 then
			return true
		end
	end

	return false
end

function Activity160Model:hasRewardCanGet(actId)
	local actInfo = self:getActInfo(actId)

	for _, info in pairs(actInfo) do
		if info.state ~= 2 then
			return true
		end
	end

	return false
end

function Activity160Model:allRewardReceive(actId)
	local actInfo = self:getActInfo(actId)

	for _, info in pairs(actInfo) do
		if info.state ~= 2 then
			return false
		end
	end

	return true
end

function Activity160Model:isMissionCanGet(actId, missionId)
	local actInfo = self:getActInfo(actId)

	return actInfo[missionId] and actInfo[missionId].state == 1
end

function Activity160Model:isMissionFinish(actId, missionId)
	local actInfo = self:getActInfo(actId)

	return actInfo[missionId] and actInfo[missionId].state == 2
end

function Activity160Model:getFinishCount(actId)
	local count = 0
	local missionCos = Activity160Config.instance:getActivityMissions(actId)

	for index, missionCo in ipairs(missionCos) do
		local isFinish = self:isMissionFinish(actId, missionCo.id)
		local canGet = self:isMissionCanGet(actId, missionCo.id)

		if isFinish or canGet then
			count = count + 1
		end
	end

	return count
end

Activity160Model.instance = Activity160Model.New()

return Activity160Model
