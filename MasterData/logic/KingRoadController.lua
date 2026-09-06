-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingroad/controller/KingRoadController.lua

module("logic.extensions.kingroad.controller.KingRoadController", package.seeall)

local KingRoadController = class("KingRoadController", BaseController)

function KingRoadController:ctor()
	KingRoadController.super.ctor(self)
end

function KingRoadController:onInit()
	return
end

function KingRoadController:onReset()
	return
end

function KingRoadController:getInfo()
	KingLoadAgent.instance:sendPM_KingLoadInfoReq(function(msg)
		local prizes = msg.prizes

		GlobalDispatcher:dispatch(GlobalNotify.KingRoadInfo, msg)
		KingRoadModel.instance:setPrizeInfos(prizes, true, 1, 1, 1)
		GlobalDispatcher:dispatch(GlobalNotify.KingRoadXiuLianInfoGot)
	end)
end

function KingRoadController:getPrize(index)
	KingLoadAgent.instance:sendPM_KingLoadCollectPrizeReq(index, function(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KingRoadCollectPrize)
	end)
end

function KingRoadController:clearCD(prizeIndex, callback)
	KingLoadAgent.instance:sendPM_KingLoadClearCdReq(prizeIndex, function(msg)
		local index = msg.index

		KingRoadModel.instance:updateTime(index + 1, 0)
		GlobalDispatcher:dispatch(GlobalNotify.KingRoadXiuLianInfoGot)
		GameUtil.callBack(callback)
	end)
end

function KingRoadController:getStrengPrize(prizeIndex, petId, equipStarGod)
	local prizeReq = PrizePublicDef_pb.PM_GainPrizeReq()

	prizeReq.petId = petId

	if equipStarGod then
		for i, v in ipairs(equipStarGod) do
			local equipStarGod = prizeReq.equipStarGod:add()

			equipStarGod.slotId = v.slotId
			equipStarGod.starGodDefineId = v.starGodDefineId
			equipStarGod.starGodLv = v.starGodLv
		end
	end

	KingLoadAgent.instance:sendPM_KingLoadStrengthPrizeReq(prizeIndex, prizeReq, function(msg)
		local index = msg.index

		printInfo("设置奖励状态", index + 1, 0)
		KingRoadModel.instance:setPrizeState(index + 1, msg.leftMillSec)
		GlobalDispatcher:dispatch(GlobalNotify.KingRoadXiuLianInfoGot, "getprize")
	end)
end

function KingRoadController:goFight(index)
	KingLoadAgent.instance:sendPM_KingLoadChallengeReq(index, function(msg)
		return
	end)
end

KingRoadController.instance = KingRoadController.New()

return KingRoadController
