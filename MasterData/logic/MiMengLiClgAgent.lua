-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/agent/MiMengLiClgAgent.lua

module("logic.extensions.mimengliclg.agent.MiMengLiClgAgent", package.seeall)

local MiMengLiClgAgent = class("MiMengLiClgAgent", BaseAgent)

function MiMengLiClgAgent:sendPM_MiMengLiClgGetInfoReq(activityId)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgGetInfoRes(status, msg)
	if status == 0 then
		MiMengLiController.instance:onGetInfo(msg)
	end
end

function MiMengLiClgAgent:sendPM_MiMengLiClgSelectPetReq(activityId, petId_i32_Ary)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgSelectPetReq()

	req.activityId = activityId

	for i, v1 in ipairs(petId_i32_Ary) do
		req.petId:append(v1)
	end

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgSelectPetRes(status, msg)
	if status == 0 then
		MiMengLiController.instance:onSelectPets(msg)
	end
end

function MiMengLiClgAgent:sendPM_MiMengLiClgStageSelectTagReq(activityId, selectedTagType_i32_Ary)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgStageSelectTagReq()

	req.activityId = activityId

	for i, v2 in ipairs(selectedTagType_i32_Ary) do
		req.selectedTagType:append(v2)
	end

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgStageSelectTagRes(status, msg)
	if status == 0 then
		MiMengLiController.instance:onSelectTag(msg)
	end
end

function MiMengLiClgAgent:sendPM_MiMengLiClgStageNormalFightReq(activityId, form_pb)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgStageNormalFightReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgStageNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MiMengLiClgAgent:sendPM_MiMengLiClgConfirmReq(activityId, confirmNum, save)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgConfirmRes(status, msg)
	if status == 0 then
		MiMengLiController.instance:onConfirm(msg)
	end
end

function MiMengLiClgAgent:sendPM_MiMengLiClgBuyNUseShopGoodsReq(activityId, skip, goodsId, petId, fromTag2Tag_pb)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgBuyNUseShopGoodsReq()

	req.activityId = activityId
	req.skip = skip

	if goodsId ~= nil then
		req.goodsId = goodsId
	end

	if petId ~= nil then
		req.petId = petId
	end

	if fromTag2Tag_pb ~= nil then
		req.fromTag2Tag:ParseFromString(fromTag2Tag_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgBuyNUseShopGoodsRes(status, msg)
	if status == 0 then
		MiMengLiController.instance:onBuyShopGoods(msg)
	end
end

function MiMengLiClgAgent:sendPM_MiMengLiClgStageBossFightReq(activityId, form_pb_Ary)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgStageBossFightReq()

	req.activityId = activityId

	if form_pb_Ary ~= nil then
		for i, v3 in ipairs(form_pb_Ary) do
			local form = req.form:add()

			form:ParseFromString(v3:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgStageBossFightRes(status, msg)
	if status == 0 then
		MiMengLiController.instance:handleBossFightRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MiMengLiClgAgent:sendPM_MiMengLiClgResetClgReq(activityId)
	local req = MiMengLiClgExtension_pb.PM_MiMengLiClgResetClgReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MiMengLiClgAgent:handlePM_MiMengLiClgResetClgRes(status, msg)
	if status == 0 then
		MiMengLiController.instance:onResetChallenge(msg)
	end
end

function MiMengLiClgAgent:handlePM_MiMengLiClgNotifyStageNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	end

	MiMengLiController.instance:handleFightRes(msg)
end

MiMengLiClgAgent.instance = MiMengLiClgAgent.New()

return MiMengLiClgAgent
