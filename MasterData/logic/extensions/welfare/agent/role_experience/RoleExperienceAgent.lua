-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/agent/role_experience/RoleExperienceAgent.lua

module("logic.extensions.welfare.agent.role_experience.RoleExperienceAgent", package.seeall)

local M = class("RoleExperienceAgent", BaseAgent)

function M:sendGetHeroEarlyAccessRewardRequest(actId)
	local msg = ActivityExtension_pb.GetHeroEarlyAccessRewardRequest()

	msg.actId = actId

	self:sendMsg(msg)
end

function M:handleGetHeroEarlyAccessRewardReply(status, msg)
	if status == 0 then
		local actId = msg.actId
		local activityData = ActivityModel.instance:getActivityById(actId)

		if activityData and activityData._dynConfig then
			activityData._dynConfig.rewardInfo = 1

			GlobalDispatcher:dispatchEvent(EventType.ROLE_EXPERIENCE_RECEIVE_REWARD)
		end
	end
end

M.instance = M.New()

return M
