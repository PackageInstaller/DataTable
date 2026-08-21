-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/agent/AirtightRoomAgent.lua

module("logic.extensions.airtightroom.agent.AirtightRoomAgent", package.seeall)

local M = class("AirtightRoomAgent", BaseAgent)

function M:ctor()
	return
end

function M:sendGetAirtightRoomInfoRequest()
	if AirtightRoomUtil.isSystemOpen(false) then
		local msg = AirtightRoomExtension_pb.GetAirtightRoomInfoRequest()

		self:sendMsg(msg)
	else
		printWarn("功能未开启，不能请求密室时间状态数据")
	end
end

function M:handleGetAirtightRoomInfoReply(status, msg)
	if status == 0 then
		AirtightRoomController.instance:onAirtightRoomExitTimeChange(msg.exitTime)
	end
end

function M:sendEnterAirtightRoomRequest()
	local inTime = AirtightRoomController.instance:getIsInAirtightTime()

	if inTime then
		FloatWordMgr.instance:show(lang("tip_airtighttime_already"))

		return
	end

	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

	if inSpTime then
		printWarn("处于特殊时间，不能使用进入密室时间道具")
		FloatWordMgr.instance:show(lang("tip_airtighttime_item_use_limit"))

		return
	end

	if AirtightRoomUtil.isSystemOpen(false) then
		local msg = AirtightRoomExtension_pb.EnterAirtightRoomRequest()

		self:sendMsg(msg)
	else
		printWarn("功能未开启，不能使用进入密室时间道具")
		FloatWordMgr.instance:show(lang("tip_no_feedback"))
	end
end

function M:handleEnterAirtightRoomReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ARITIGHT_OPEN_USEITEM)
	end
end

function M:handleAirtightRoomStatusChangePush(status, msg)
	if status == 0 then
		AirtightRoomController.instance:onAirtightRoomExitTimeChange(msg.exitTime)
	end
end

function M:sendExperienceAirtightRoomRequest()
	if AirtightRoomUtil.isSystemOpen(false) then
		local msg = AirtightRoomExtension_pb.ExperienceAirtightRoomRequest()

		self:sendMsg(msg)
	end
end

function M:handleExperienceAirtightRoomReply(status, msg)
	return
end

M.instance = M.New()

return M
