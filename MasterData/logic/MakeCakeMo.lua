-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/MakeCakeMo.lua

module("logic.extensions.anniversarycake.view.MakeCakeMo", package.seeall)

local MakeCakeMo = class("MakeCakeMo", CakeMoBase)

function MakeCakeMo:ctor()
	MakeCakeMo.super.ctor(self)

	self._type = 0
end

function MakeCakeMo:sendGetInfoReq(activityId)
	MakeCakeMo.super.sendGetInfoReq(self, activityId)
	AnniversaryCakeAgent.instance:sendPM_ACGetMakeCakeInfoReq(activityId)
end

function MakeCakeMo:getWorldPrizePlanId()
	return MakeCakeModel.instance:getWorldPrizePlanId()
end

function MakeCakeMo:getPlayerPrizePlanId()
	return MakeCakeModel.instance:getPlayerPrizePlanId()
end

function MakeCakeMo:getWorldProgress()
	return MakeCakeModel.instance:getWorldProgress()
end

function MakeCakeMo:getPersonalScore()
	return MakeCakeModel.instance:getPersonalScore()
end

function MakeCakeMo:getCurLeftGameCount()
	return MakeCakeModel.instance:getCurLeftGameCount()
end

function MakeCakeMo:getSpecialDesc()
	return MakeCakeConfig.instance:getConstValue("SPECIAL_DESC")
end

function MakeCakeMo:getSpecialReward()
	return MakeCakeConfig.instance:getConstValue("SPECIAL_REWARD")
end

function MakeCakeMo:getBgPath()
	return GameUrl.getBigbgPngUrl("anniversarycake/bg_zndg_03")
end

function MakeCakeMo:openGame()
	UIStateManager.instance:push(ViewName.SphereGameLevelView)
end

function MakeCakeMo:isWorldRewardGeted(prizeId)
	return MakeCakeModel.instance:isWorldRewardGeted(prizeId)
end

function MakeCakeMo:isWorldRewardCanGet(prizeId, needScore)
	return MakeCakeModel.instance:isWorldRewardCanGet(prizeId, needScore)
end

function MakeCakeMo:isPlayerRewardGeted(prizeId)
	return MakeCakeModel.instance:isPlayerRewardGeted(prizeId)
end

function MakeCakeMo:isPlayerRewardCanGet(prizeId, needScore)
	return MakeCakeModel.instance:isPlayerRewardCanGet(prizeId, needScore)
end

function MakeCakeMo:sendGainPersonalPrizeReq(activityId, prizeId)
	AnniversaryCakeAgent.instance:sendPM_ACGainMakeCakePersonalPrizeReq(activityId, prizeId)
end

function MakeCakeMo:sendGainWorldPrizeReq(activityId, prizeId)
	AnniversaryCakeAgent.instance:sendPM_ACGainMakeCakeWorldPrizeReq(activityId, prizeId)
end

return MakeCakeMo
