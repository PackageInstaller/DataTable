-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/agent/ImpressionStickersAgent.lua

module("logic.extensions.impressionstickers.agent.ImpressionStickersAgent", package.seeall)

local ImpressionStickersAgent = class("ImpressionStickersAgent", BaseAgent)

function ImpressionStickersAgent:sendPM_ImpressionStickersInfoReq(otherUserId)
	local req = ImpressionStickersExtension_pb.PM_ImpressionStickersInfoReq()

	if otherUserId then
		req.otherUserId = otherUserId
	end

	self:sendMsg(req)
end

function ImpressionStickersAgent:handlePM_ImpressionStickersInfoRes(status, msg)
	if status == 0 then
		ImpressionStickersController.instance:handlePM_ImpressionStickersInfoRes(msg)
	end
end

function ImpressionStickersAgent:sendPM_Annuity2025ChangeRankInfoReq()
	local req = ImpressionStickersExtension_pb.PM_Annuity2025ChangeRankInfoReq()

	self:sendMsg(req)
end

function ImpressionStickersAgent:handlePM_Annuity2025ChangeRankInfoRes(status, msg)
	if status == 0 then
		ImpressionStickersController.instance:handlePM_Annuity2025ChangeRankInfoRes(msg)
	end
end

function ImpressionStickersAgent:sendPM_Annuity2025ChangeRankReq(stickerId, cover)
	local req = ImpressionStickersExtension_pb.PM_Annuity2025ChangeRankReq()

	req.stickerId = stickerId
	req.cover = cover

	self:sendMsg(req)
end

function ImpressionStickersAgent:handlePM_Annuity2025ChangeRankRes(status, msg)
	if status == 0 then
		ImpressionStickersController.instance:handlePM_Annuity2025ChangeRankRes(msg)
	end
end

function ImpressionStickersAgent:sendPM_ImpressionStickersPinReq(ids, setTop)
	local req = ImpressionStickersExtension_pb.PM_ImpressionStickersPinReq()

	for i, id in ipairs(ids) do
		req.id:append(id)
	end

	req.setTop = setTop

	self:sendMsg(req)
end

function ImpressionStickersAgent:handlePM_ImpressionStickersPinRes(status, msg)
	if status == 0 then
		ImpressionStickersController.instance:handlePM_ImpressionStickersPinRes(msg)
	end
end

ImpressionStickersAgent.instance = ImpressionStickersAgent.New()

return ImpressionStickersAgent
