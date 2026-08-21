-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/agent/PlayerCourseAgent.lua

module("logic.extensions.playerinfo.agent.PlayerCourseAgent", package.seeall)

local M = class("PlayerCourseAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	return
end

function M:sendGetPlayerDisplayInfoRequest(userId)
	local msg = PlayerExtension_pb.GetPlayerDisplayInfoRequest()

	msg.userId = userId

	self:sendMsg(msg)
end

function M:handleGetPlayerDisplayInfoReply(status, msg)
	if status == 0 then
		PlayerCourseModel.instance:buildCourseData(msg.info)
		GlobalDispatcher:dispatchEvent(EventType.COURSE_INFO_GOT)
	end
end

function M:sendGetHeroDetailInfoRequest(userId, heroId)
	local msg = PlayerExtension_pb.GetHeroDetailInfoRequest()

	msg.userId = userId
	msg.heroId = heroId

	self:sendMsg(msg)
end

function M:handleGetHeroDetailInfoReply(status, msg)
	if status == 0 then
		HeroDetailInfoModel.instance:addHeroDetailInfo(msg)
		GlobalDispatcher:dispatchEvent(EventType.COURSE_HERO_DETAIL_VIEW, msg.info)
		GlobalDispatcher:dispatchEvent(EventType.HERO_DETAIL_Info, msg)
	end
end

function M:sendSetDisplayContentRequest(type, ids)
	local msg = PlayerExtension_pb.SetDisplayContentRequest()

	msg.type = type

	for _, v in ipairs(ids) do
		table.insert(msg.id, v)
	end

	self:sendMsg(msg)
end

function M:handleSetDisplayContentReply(status, msg)
	if status == 0 then
		PlayerCourseModel.instance:updateShowContent(msg)
		GlobalDispatcher:dispatchEvent(EventType.COURSE_SHOW_REFRESH_VIEW, msg.type)

		self.curSetType = nil
	end
end

function M:sendSetDisplayTargetRequest(target)
	local msg = PlayerExtension_pb.SetDisplayTargetRequest()

	for k, v in pairs(target) do
		local temp = PlayerExtension_pb.DisplayTarget()

		temp.type = k
		temp.target = v

		table.insert(msg.target, temp)
	end

	self:sendMsg(msg)
end

function M:handleSetDisplayTargetReply(status, msg)
	if status == 0 then
		PlayerCourseModel.instance:updateEditInfo(msg.target)
	end
end

M.instance = M.New()

return M
