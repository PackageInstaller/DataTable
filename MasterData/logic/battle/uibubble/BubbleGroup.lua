-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/BubbleGroup.lua

module("logic.battle.uibubble.BubbleGroup", package.seeall)

local BubbleGroup = class("BubbleGroup", IBattleReusable)

local function sort_on_priority(bubbleA, bubbleB)
	if bubbleA and bubbleB then
		return bubbleA:getPriority() > bubbleB:getPriority()
	end

	return false
end

function BubbleGroup:ctor()
	self.mainGO = goutil.create("bubble-group", true)

	goutil.addChildToParent(self.mainGO, BubbleSettings.BubbleRoot)

	self._bubbleList = {}
	self._handler = Handler.New()
end

function BubbleGroup:reset()
	self:clearAllBubble()
end

function BubbleGroup:destroy()
	self:clearAllBubble()
	goutil.destroy(self.mainGO)

	self.mainGO = nil
end

function BubbleGroup:getCapacity()
	return BattleConst.ObjPoolCapacityDefault
end

function BubbleGroup:setListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function BubbleGroup:showBubble(bubbleType, value, time, ...)
	local cls = BubbleSettings.bubbleType2BubbleClass(bubbleType)
	local bubble = cls:createInstance()

	bubble:setFinishListener(self._onBubbleFinish, self)
	goutil.addChildToParent(bubble.mainGO, self.mainGO)

	if time then
		bubble:setLifeTime(BattleTime.getScaledTime(time))
	end

	bubble:setBubbleContent(value, bubbleType, ...)
	table.insert(self._bubbleList, bubble)
	table.sort(self._bubbleList, sort_on_priority)
	self:_adjustBubbles()
end

function BubbleGroup:clearAllBubble()
	for _, bubble in pairs(self._bubbleList) do
		bubble:returnSelf()
	end

	BattleTableUtil.clearTable(self._bubbleList)
end

function BubbleGroup:_onBubbleFinish(bubble)
	table.removebyvalue(self._bubbleList, bubble)
	self:_adjustBubbles()

	if #self._bubbleList <= 0 then
		self._handler:call(self)
	end
end

function BubbleGroup:_adjustBubbles()
	local y = 0

	for _, bubble in ipairs(self._bubbleList) do
		bubble:setPositionXY(0, y)

		y = y + bubble:getHeight()
	end
end

return BubbleGroup
