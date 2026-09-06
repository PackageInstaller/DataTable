-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/agent/FamilySceneAgent.lua

module("logic.extensions.familyscene.agent.FamilySceneAgent", package.seeall)

local FamilySceneAgent = class("FamilySceneAgent", BaseAgent)

function FamilySceneAgent:sendPM_Cube_JoinReq(type, joinParams, x, y, z)
	local req = CubeExtension_pb.PM_Cube_JoinReq()

	req.type = type
	req.joinParams = joinParams or ""
	req.pos.x = x
	req.pos.y = y
	req.pos.z = z

	self:sendMsg(req)
end

function FamilySceneAgent:handlePM_Cube_JoinRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneJoinRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneJoinRes)
	end
end

function FamilySceneAgent:handlePM_Cube_NotifyJoinResultRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneNotifyJoinResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifyJoinResultRes)
	end
end

function FamilySceneAgent:sendPM_Cube_SwitchChannelReq(channelId)
	local req = CubeExtension_pb.PM_Cube_SwitchChannelReq()

	req.channelId = channelId

	self:sendMsg(req)
end

function FamilySceneAgent:handlePM_Cube_SwitchChannelRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneSwitchChannelRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneSwitchChannelRes)
	end
end

function FamilySceneAgent:sendPM_Cube_GetAllChannelInfosReq()
	local req = CubeExtension_pb.PM_Cube_GetAllChannelInfosReq()

	self:sendMsg(req)
end

function FamilySceneAgent:handlePM_Cube_GetAllChannelInfosRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneGetAllChannelInfosRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneGetAllChannelInfosRes)
	end
end

function FamilySceneAgent:handlePM_Cube_NotifyOtherEnterRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneNotifyOtherEnterRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifyOtherEnterRes)
	end
end

function FamilySceneAgent:handlePM_Cube_NotifyLeaveRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneNotifyLeaveRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifyLeaveRes)
	end
end

function FamilySceneAgent:sendSetUserVari(...)
	local args = ...

	if args ~= nil then
		args = {
			...
		}

		local list = {}

		for i, var in ipairs(args) do
			local variable = CubeExtension_pb.PM_Cube_Variable()

			variable.varName = var.varName
			variable.type = var.type
			variable.value = var.value

			table.insert(list, variable)
		end

		if #list > 0 then
			self:sendPM_Cube_SetVariablesReq(list)
		end
	end
end

function FamilySceneAgent:sendPM_Cube_SetVariablesReq(variables)
	local req = CubeExtension_pb.PM_Cube_SetVariablesReq()

	for i = 1, #variables do
		table.insert(req.variables, variables[i])
	end

	self:sendMsg(req)
end

function FamilySceneAgent:handlePM_Cube_SetVariablesRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneSetVariablesRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneSetVariablesRes)
	end
end

function FamilySceneAgent:handlePM_Cube_NotifyVariablesUpdateRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneNotifyVariablesUpdateRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifyVariablesUpdateRes, msg.userId, msg.variables)
	end
end

function FamilySceneAgent:sendPM_Cube_MoveReq(x, y, z, isTeleport)
	if isTeleport == nil then
		isTeleport = false
	end

	local req = CubeExtension_pb.PM_Cube_MoveReq()

	req.pos.x = x
	req.pos.y = y
	req.pos.z = z
	req.isTeleport = isTeleport

	self:sendMsg(req)
end

function FamilySceneAgent:handlePM_Cube_MoveRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneMoveRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneMoveRes)
	end
end

function FamilySceneAgent:sendPM_Cube_ExitReq()
	local req = CubeExtension_pb.PM_Cube_ExitReq()

	self:sendMsg(req)
end

function FamilySceneAgent:handlePM_Cube_ExitRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneExitRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneExitRes)
	end
end

function FamilySceneAgent:handlePM_Cube_NotifyMoveRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneNotifyMoveRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifyMoveRes)
	end
end

function FamilySceneAgent:handlePM_Cube_NotifyExitRes(status, msg)
	if status == 0 then
		FamilySceneModel.instance:onFamilySceneNotifyExitRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FamilySceneNotifyExitRes)
	end
end

FamilySceneAgent.instance = FamilySceneAgent.New()

return FamilySceneAgent
