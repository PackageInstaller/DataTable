-- chunkname: @modules/logic/survival/rpc/SurvivalOutSideRpc.lua

module("modules.logic.survival.rpc.SurvivalOutSideRpc", package.seeall)

local SurvivalOutSideRpc = class("SurvivalOutSideRpc", BaseRpc)

function SurvivalOutSideRpc:sendSurvivalOutSideGetInfo(callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalOutSideGetInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:onReceiveSurvivalOutSideGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		SurvivalModel.instance:onGetInfo(msg.info)
	end
end

function SurvivalOutSideRpc:sendSurvivalOutSideGainReward(rewardId, callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalOutSideGainRewardRequest()

	req.rewardId = rewardId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:onReceiveSurvivalOutSideGainRewardReply(resultCode, msg)
	if resultCode == 0 then
		local outSideMo = SurvivalModel.instance:getOutSideInfo()

		outSideMo:onGainReward(msg.rewardId)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnGainReward)
	end
end

function SurvivalOutSideRpc:sendSurvivalSurvivalOutSideClientData(data, callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalSurvivalOutSideClientDataRequest()

	req.data = data

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:onReceiveSurvivalSurvivalOutSideClientDataReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalOutSideRpc:onReceiveSurvivalHandbookPush(resultCode, msg)
	return
end

function SurvivalOutSideRpc:onReceiveSurvivalMarkNewHandbookReply(resultCode, msg)
	SurvivalHandbookModel.instance:onReceiveSurvivalMarkNewHandbookReply(resultCode, msg)
end

function SurvivalOutSideRpc:sendSurvivalMarkNewHandbook(ids, callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalMarkNewHandbookRequest()

	for i, v in ipairs(ids) do
		table.insert(req.ids, v)
	end

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:sendSurvivalOutSideTechUnlockRequest(techId, teachCellId)
	UIBlockHelper.instance:startBlock("SurvivalOutSideTechUnlockRequest", 4)

	local req = SurvivalOutSideModule_pb.SurvivalOutSideTechUnlockRequest()

	req.techId = teachCellId

	return self:sendMsg(req, function()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalOutSideTechUnlockReply, {
			techId = techId,
			teachCellId = teachCellId
		})
	end, nil)
end

function SurvivalOutSideRpc:onReceiveSurvivalOutSideTechUnlockReply(resultCode, msg)
	UIBlockHelper.instance:endBlock("SurvivalOutSideTechUnlockRequest")

	if resultCode == 0 then
		local survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo

		survivalOutSideTechMo:onReceiveSurvivalOutSideTechUnlockReply(msg)
	end
end

function SurvivalOutSideRpc:sendSurvivalOutSideTechResetRequest(techId)
	local req = SurvivalOutSideModule_pb.SurvivalOutSideTechResetRequest()

	req.belongRoleId = techId

	return self:sendMsg(req)
end

function SurvivalOutSideRpc:onReceiveSurvivalOutSideTechResetReply(resultCode, msg)
	if resultCode == 0 then
		GameFacade.showToastString(luaLang("SurvivalTechView_2"))

		local survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo

		survivalOutSideTechMo:onReceiveSurvivalOutSideTechResetReply(msg)
	end
end

function SurvivalOutSideRpc:sendSurvivalMarkRoleNotNewRequest(roleIds, callback, callobj)
	if #roleIds > 0 then
		local req = SurvivalOutSideModule_pb.SurvivalMarkRoleNotNewRequest()

		for i, v in ipairs(roleIds) do
			table.insert(req.roleId, v)
		end

		return self:sendMsg(req, callback, callobj)
	end
end

function SurvivalOutSideRpc:onReceiveSurvivalMarkRoleNotNewReply(resultCode, msg)
	return
end

function SurvivalOutSideRpc:sendSurvivalMarkModNotNewRequest(ids, callback, callobj)
	if #ids > 0 then
		local req = SurvivalOutSideModule_pb.SurvivalMarkModNotNewRequest()

		for i, v in ipairs(ids) do
			table.insert(req.modId, v)
		end

		return self:sendMsg(req, callback, callobj)
	end
end

function SurvivalOutSideRpc:onReceiveSurvivalMarkModNotNewReply(resultCode, msg)
	return
end

function SurvivalOutSideRpc:sendSurvivalOutsideShopBuyRequest(id, count, callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalOutsideShopBuyRequest()

	req.id = id
	req.count = count

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:onReceiveSurvivalOutsideShopBuyReply(resultCode, msg)
	if resultCode == 0 then
		SurvivalStoreModel.instance:onReceiveSurvivalOutsideShopBuyReply(msg)
		SurvivalStoreController.instance:dispatchEvent(SurvivalEvent.OnSurvivalOutsideShopBuyReply)
	end
end

SurvivalOutSideRpc.instance = SurvivalOutSideRpc.New()

return SurvivalOutSideRpc
