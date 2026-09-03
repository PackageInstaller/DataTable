-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/controller/DartsSystem.lua

require("dm.gameplay.miniGame.model.darts.DartsData")

DartsSystem = class("DartsSystem", legs.Actor)

DartsSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DartsSystem:has("_dartsService", {
	is = "r"
}):injectWith("DartsService")
DartsSystem:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
DartsSystem:has("_dartsData", {
	is = "r"
})
DartsSystem:has("_curLevel", {
	is = "rw"
})

EVT_DARTS_PLAYAGAIN = "EVT_DARTS_PLAYAGAIN"
EVT_DARTS_RESULTCLOSE = "EVT_DARTS_RESULTCLOSE"
EVT_DARTS_REWARDCONFIRM = "EVT_DARTS_REWARDCONFIRM"
EVT_DARTS_REWARDCONFIRM_ADD = "EVT_DARTS_REWARDCONFIRM_ADD"
EVT_DARTS_QUIT_SUCC = "EVT_DARTS_QUIT_SUCC"
EVT_DARTS_BACK_SUCC = "EVT_DARTS_BACK_SUCC"
EVT_DARTS_PASSGAME_SUCC = "EVT_DARTS_PASSGAME_SUCC"

function DartsSystem:initialize()
	super.initialize(self)

	self._dartsData = nil
	self._curLevel = 1
end

function DartsSystem:tryEnter()
	local activityId = self:getActivityId()

	if activityId then
		self:tryEnterByActivity(activityId)
	end
end

function DartsSystem:tryEnterByActivity(activityId)
	self._activityId = activityId

	local activitySystem = self:getInjector():getInstance("ActivitySystem")

	activitySystem:requestActicityById(activityId, function(response)
		local view = self:getInjector():getInstance("DartsView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			activityId = activityId
		}))
	end)
end

function DartsSystem:getActivityId()
	local activity = self:getMiniGameSystem():getActivityByGameType(MiniGameType.kDarts)

	if activity then
		self._activityId = activity:getId()
	else
		return nil
	end

	return self._activityId
end

function DartsSystem:initDartsData(data)
	self._dartsData = DartsData:new(data)
end

function DartsSystem:getMaxLevel()
	return self._dartsData:getMaxLevel()
end

function DartsSystem:getLevelInfoBylevel(level)
	return self._dartsData:getLevelInfoBylevel(level)
end

function DartsSystem:getBuyCostItemId()
	return self._dartsData:getBuyTimesCost().id
end

function DartsSystem:getCostBuyTimes(times)
	local amount = self._dartsData:getBuyTimesCost().amount

	if not amount[times] then
		return amount[times]
	end
end

function DartsSystem:getCostBuyMaxTimes()
	return self._dartsData:getBuyLimit()
end

function DartsSystem:getCostAmountList()
	return self._dartsData:getBuyTimesCost().amount
end

function DartsSystem:getMaxTimes()
	self._dartsData:getMaxTimes()
end

function DartsSystem:getGoldGetCount()
	return self._dartsData:getGolddaily()
end

function DartsSystem:getDiamondGetCount()
	return self._dartsData:getDiamonddaily()
end

function DartsSystem:getFragGetCount()
	return self._dartsData:getFragdaily()
end

function DartsSystem:getGoldLimit()
	return self._dartsData:getGoldLimit()
end

function DartsSystem:getDiamondLimit()
	return self._dartsData:getDiamondLimit()
end

function DartsSystem:getFragLimit()
	return self._dartsData:getFragLimit()
end

function DartsSystem:getRewardHeroPieceId()
	return self._dartsData:getRewardHeroPieceId()
end

function DartsSystem:syncData(data)
	return self._dartsData:syncData(data)
end

function DartsSystem:getMaximumShow()
	return self._dartsData:getMaximumShow()
end

function DartsSystem:isGetRewardLimit()
	return self._dartsData:isGetRewardLimit()
end

function DartsSystem:getEachBuyNum()
	return self._dartsData:getEachBuyNum()
end

function DartsSystem:getDartsScore()
	return self._dartsData:getDartsScore()
end

function DartsSystem:getRevertGapTime()
	return self._dartsData:getRevertGapTime()
end

function DartsSystem:getAccelerateTime()
	return self._dartsData:getAccelerateTime()
end

function DartsSystem:getCurLevel()
	return self._curLevel
end

function DartsSystem:getRewardMaxList()
	return self._dartsData:getRewardMaxList()
end
