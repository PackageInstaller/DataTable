-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/EatCakeMo.lua

module("logic.extensions.anniversarycake.view.EatCakeMo", package.seeall)

local EatCakeMo = class("EatCakeMo", CakeMoBase)

function EatCakeMo:ctor()
	EatCakeMo.super.ctor(self)

	self._type = 1
end

function EatCakeMo:sendGetInfoReq(activityId)
	EatCakeMo.super.sendGetInfoReq(self, activityId)
	AnniversaryCakeAgent.instance:sendPM_ACGetEatCakeInfoReq(activityId)
end

function EatCakeMo:getWorldPrizePlanId()
	return MakeCakeModel.instance:getEatWorldPrizePlanId()
end

function EatCakeMo:getPlayerPrizePlanId()
	return MakeCakeModel.instance:getEatPlayerPrizePlanId()
end

function EatCakeMo:getWorldProgress()
	return MakeCakeModel.instance:getEatWorldProgress()
end

function EatCakeMo:getPersonalScore()
	return MakeCakeModel.instance:getEatPersonalScore()
end

function EatCakeMo:getCurLeftGameCount()
	return MakeCakeModel.instance:getEatCurLeftGameCount()
end

function EatCakeMo:getSpecialDesc()
	return MakeCakeConfig.instance:getConstValue("SPECIAL_DESC2")
end

function EatCakeMo:getSpecialReward()
	return MakeCakeConfig.instance:getConstValue("SPECIAL_REWARD2")
end

function EatCakeMo:getBgPath()
	return GameUrl.getBigbgPngUrl("anniversarycake/bg_zndg_04")
end

function EatCakeMo:openGame()
	UIStateManager.instance:push(ViewName.EatCakeGameMainView)
end

function EatCakeMo:isWorldRewardGeted(prizeId)
	return MakeCakeModel.instance:isEatWorldRewardGeted(prizeId)
end

function EatCakeMo:isWorldRewardCanGet(prizeId, needScore)
	return MakeCakeModel.instance:isEatWorldRewardCanGet(prizeId, needScore)
end

function EatCakeMo:isPlayerRewardGeted(prizeId)
	return MakeCakeModel.instance:isEatPlayerRewardGeted(prizeId)
end

function EatCakeMo:isPlayerRewardCanGet(prizeId, needScore)
	return MakeCakeModel.instance:isEatPlayerRewardCanGet(prizeId, needScore)
end

function EatCakeMo:sendGainPersonalPrizeReq(activityId, prizeId)
	AnniversaryCakeAgent.instance:sendPM_ACGainEatCakePrizeReq(activityId, prizeId)
end

function EatCakeMo:sendGainWorldPrizeReq(activityId, prizeId)
	AnniversaryCakeAgent.instance:sendPM_ACGainEatCakeWorldPrizeReq(activityId, prizeId)
end

return EatCakeMo
