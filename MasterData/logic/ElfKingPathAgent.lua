-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elfkingpath/agent/ElfKingPathAgent.lua

module("logic.extensions.elfkingpath.agent.ElfKingPathAgent", package.seeall)

local ElfKingPathAgent = class("ElfKingPathAgent", BaseAgent)

function ElfKingPathAgent:sendPM_ElfKingPathInfoReq()
	local req = ElfKingPathExtension_pb.PM_ElfKingPathInfoReq()

	self:sendMsg(req)
end

function ElfKingPathAgent:handlePM_ElfKingPathInfoRes(status, msg)
	if status == 0 then
		ElfKingPathController.instance:handleGetInfo(msg)
	end
end

function ElfKingPathAgent:sendPM_ElfKingPahtClgReq(form_pb, stageId, sonStageId)
	local req = ElfKingPathExtension_pb.PM_ElfKingPahtClgReq()

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.stageId = stageId
	req.sonStageId = sonStageId

	self:sendMsg(req)
end

function ElfKingPathAgent:handlePM_ElfKingPahtClgRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GuideController.instance:setViewVar("elf_king_path_battle", nil)
	end
end

function ElfKingPathAgent:handlePM_ElfKingPathNotifyClgRes(status, msg)
	if status == 0 then
		ElfKingPathController.instance:handleNotifyChallenge(msg)
	end
end

ElfKingPathAgent.instance = ElfKingPathAgent.New()

return ElfKingPathAgent
