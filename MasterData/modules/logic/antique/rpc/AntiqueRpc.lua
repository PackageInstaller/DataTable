-- chunkname: @modules/logic/antique/rpc/AntiqueRpc.lua

module("modules.logic.antique.rpc.AntiqueRpc", package.seeall)

local AntiqueRpc = class("AntiqueRpc", BaseRpc)

function AntiqueRpc:sendGetAntiqueInfoRequest(callback, callbackObj)
	local req = AntiqueModule_pb.GetAntiqueInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function AntiqueRpc:onReceiveGetAntiqueInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AntiqueModel.instance:setAntiqueInfo(msg.antiques)
end

function AntiqueRpc:onReceiveAntiqueUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	for _, v in ipairs(msg.antiques) do
		local antique = AntiqueModel.instance:getAntique(v.antiqueId)

		if not antique then
			GameFacade.showToast(ToastEnum.AntiqueNewGet)
		end
	end

	AntiqueModel.instance:updateAntiqueInfo(msg.antiques)
end

AntiqueRpc.instance = AntiqueRpc.New()

return AntiqueRpc
