-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/agent/GloryBattleAgent.lua

module("logic.extensions.glorybattle.agent.GloryBattleAgent", package.seeall)

local GloryBattleAgent = class("GloryBattleAgent", BaseAgent)

function GloryBattleAgent:sendPM_GloryBattleInfoReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleInfoRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleInfoRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleDrawGenreReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleDrawGenreReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleDrawGenreRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleDrawGenreRes, msg.genreId)
	end
end

function GloryBattleAgent:sendPM_GloryBattleSelectGenreReq(activityId, isRandom, genreId)
	local req = GloryBattleExtension_pb.PM_GloryBattleSelectGenreReq()

	req.activityId = activityId
	req.isRandom = isRandom
	req.genreId = genreId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleSelectGenreRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onSelectGenreRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleSelectGenreRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleMatchFightReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleMatchFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleMatchFightRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onMatchFightRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.GloryBattleMatchFightRes, status)
end

function GloryBattleAgent:sendPM_GloryBattleCancelMatchReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleCancelMatchRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleCancelMatchRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleFightReq(activityId, form, usePetCardIdList)
	local req = GloryBattleExtension_pb.PM_GloryBattleFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	if usePetCardIdList then
		for i, v in ipairs(usePetCardIdList) do
			req.usePetCardIdList:append(v)
		end
	end

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleFightRes)
	end

	GlorybattleController.instance:onFightRes(status)
end

function GloryBattleAgent:handlePM_GloryBattleNotifyFightRes(status, msg)
	if status == 0 then
		GlorybattleController.instance:onNotifyFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleNotifyFightRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleGiveUpReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleGiveUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleGiveUpRes(status, msg)
	if status == 0 then
		GlorybattleController.instance:onGiveUpRes(msg)
		GlorybattleModel.instance:onGiveUpRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleGiveUpRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleBuyTimesReq(activityId, buyTimes)
	local req = GloryBattleExtension_pb.PM_GloryBattleBuyTimesReq()

	req.activityId = activityId
	req.buyTimes = buyTimes

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleBuyTimesRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onBuyTimesRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleBuyTimesRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleViewBtlReportReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleViewBtlReportReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleViewBtlReportRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleViewBtlReportRes, msg.viewBtlReports)
	end
end

function GloryBattleAgent:sendPM_GloryBattleRankViewReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleRankViewRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onRankViewRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleRankViewRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleOperateHolyStripeReq(activityId, creepsId, holyStripeId, operateType)
	local req = GloryBattleExtension_pb.PM_GloryBattleOperateHolyStripeReq()

	req.activityId = activityId
	req.creepsId = creepsId
	req.holyStripeId = holyStripeId
	req.operateType = operateType

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleOperateHolyStripeRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onOperateHolyStripeRes(msg)
		GlorybattleController.instance:onOperateHolyStripeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleOperateHolyStripeRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleRefreshShopReq(activityId)
	local req = GloryBattleExtension_pb.PM_GloryBattleRefreshShopReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleRefreshShopRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onRefreshShopRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleRefreshShopRes)
		FloatWordMgr.instance:show("刷新成功")
	end
end

function GloryBattleAgent:sendPM_GloryBattleChangeLockStateReq(activityId, blockId, changeType)
	local req = GloryBattleExtension_pb.PM_GloryBattleChangeLockStateReq()

	req.activityId = activityId
	req.blockId = blockId
	req.changeType = changeType

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleChangeLockStateRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onChangeLockStateRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleChangeLockStateRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleBuyGoodsReq(activityId, blockId)
	local req = GloryBattleExtension_pb.PM_GloryBattleBuyGoodsReq()

	req.activityId = activityId
	req.blockId = blockId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleBuyGoodsRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onBuyGoodsRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleBuyGoodsRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleSalePetReq(activityId, creepsId)
	local req = GloryBattleExtension_pb.PM_GloryBattleSalePetReq()

	req.activityId = activityId
	req.creepsId = creepsId

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleSalePetRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onSalePetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleSalePetRes)
	end
end

function GloryBattleAgent:handlePM_NotifyGloryBattleGainPetRes(status, msg)
	if status == 0 then
		GlorybattleModel.instance:onGainPetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyGloryBattleGainPetRes)
	end
end

function GloryBattleAgent:handlePM_NotifyGloryBattleIncExperiencePetRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local creepsId = msg.creepsId

		GlorybattleModel.instance:petAwakenLevelUp(activityId, creepsId)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyGloryBattleIncExperiencePetRes)
	end
end

function GloryBattleAgent:sendPM_GloryBattleSaveFormationReq(activityId, simpleForm, usePetCardIdList)
	local req = GloryBattleExtension_pb.PM_GloryBattleSaveFormationReq()

	req.activityId = activityId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())

	if usePetCardIdList then
		for i, v in ipairs(usePetCardIdList) do
			req.usePetCardIdList:append(v)
		end
	end

	self:sendMsg(req)
end

function GloryBattleAgent:handlePM_GloryBattleSaveFormationRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GloryBattleSaveFormationRes)
	end
end

GloryBattleAgent.instance = GloryBattleAgent.New()

return GloryBattleAgent
