-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/controller/JumpSystem.lua

require("dm.gameplay.miniGame.model.jump.Jump")

JumpSystem = class("JumpSystem", legs.Actor)

JumpSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
JumpSystem:has("_jumpService", {
	is = "r"
}):injectWith("JumpService")
JumpSystem:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")
JumpSystem:has("_jumpData", {
	is = "r"
})
JumpSystem:has("_beginStage", {
	is = "rw"
})

EVT_JUMP_PLAYAGAIN = "EVT_JUMP_PLAYAGAIN"
EVT_JUMP_RESULTCLOSE = "EVT_JUMP_RESULTCLOSE"
EVT_JUMP_REWARDCONFIRM = "EVT_JUMP_REWARDCONFIRM"
EVT_JUMP_QUIT_SUCC = "EVT_JUMP_QUIT_SUCC"

function JumpSystem:initialize()
	super.initialize(self)

	self._rankList = {}
	self._jumpData = nil
	self._beginStage = 1
end

function JumpSystem:tryEnterByActivity(activityId)
	self._activityId = activityId

	local activitySystem = self:getInjector():getInstance("ActivitySystem")

	activitySystem:requestActicityById(activityId, function(response)
		local view = self:getInjector():getInstance("JumpView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			activityId = activityId
		}))
	end)
end

function JumpSystem:initJumpData(data)
	self._jumpData = Jump:new(data)
end

function JumpSystem:getRewardMaxList()
	return self._jumpData:getRewardMaxList()
end

function JumpSystem:isGetRewardLimit()
	return self._jumpData:isGetRewardLimit()
end

function JumpSystem:getBuyCostItemId()
	return self._jumpData:getBuyTimesCost().id
end

function JumpSystem:getCostBuyTimes(times)
	local amount = self._jumpData:getBuyTimesCost().amount

	if not amount[times] then
		return amount[times]
	end
end

function JumpSystem:getEachBuyNum()
	return self._jumpData:getEachBuyNum()
end

function JumpSystem:getCostBuyMaxTimes()
	return self._jumpData:getBuyLimit()
end

function JumpSystem:getCostAmountList()
	return self._jumpData:getBuyTimesCost().amount
end
