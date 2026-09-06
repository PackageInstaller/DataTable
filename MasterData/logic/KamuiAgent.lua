-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/agent/KamuiAgent.lua

module("logic.extensions.kamui.agent.KamuiAgent", package.seeall)

local KamuiAgent = class("KamuiAgent", BaseAgent)

function KamuiAgent:sendPM_KamuiResetInfoReq(petId)
	local req = KamuiExtension_pb.PM_KamuiResetInfoReq()

	req.petId = petId
	self._resetPetId = petId

	self:sendMsg(req)
end

function KamuiAgent:handlePM_KamuiResetInfoRes(status, msg)
	if status == 0 then
		local infos = msg.infos

		if self._resetPetId then
			DomainCultivateModel.instance:setResetInfo(self._resetPetId, infos)
		end
	end
end

function KamuiAgent:sendPM_ActiveKamuiReq(petId, level)
	local req = KamuiExtension_pb.PM_ActiveKamuiReq()

	req.petId = petId
	req.level = level

	self:sendMsg(req)
end

function KamuiAgent:handlePM_ActiveKamuiRes(status, msg)
	if status == 0 then
		self:dispatch(GlobalNotify.KamuiCultivateActive)
	end
end

function KamuiAgent:sendPM_ResetKamuiReq(petId, level)
	local req = KamuiExtension_pb.PM_ResetKamuiReq()

	req.petId = petId
	req.level = level
	self._resetPetId3 = petId
	self._level3 = level

	self:sendMsg(req)
end

function KamuiAgent:handlePM_ResetKamuiRes(status, msg)
	if status == 0 then
		local tempid = msg.tempId

		DomainCultivateModel.instance:setResetInfo2(self._resetPetId3, self._level3, tempid)
		DomainCultivateController.instance:handleResetKamuiRes(status, msg, self._resetPetId3, self._level3)
	end
end

function KamuiAgent:sendPM_ConfirmResetKamuiReq(petId, level, useNewGenKamui)
	local req = KamuiExtension_pb.PM_ConfirmResetKamuiReq()

	req.petId = petId
	req.level = level
	req.useNewGenKamui = useNewGenKamui
	self._resetPetId4 = petId
	self._level4 = level

	self:sendMsg(req)
end

function KamuiAgent:handlePM_ConfirmResetKamuiRes(status, msg)
	if status == 0 then
		DomainCultivateModel.instance:setResetInfo2(self._resetPetId4, self._level4, -1)
		self:dispatch(GlobalNotify.KamuiCultivateChange)
	end
end

KamuiAgent.instance = KamuiAgent.New()

return KamuiAgent
