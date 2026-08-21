-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/BuffBubbleGroup.lua

module("logic.battle.uibubble.BuffBubbleGroup", package.seeall)

local BuffBubbleGroup = class("BuffBubbleGroup", BubbleGroup)

function BuffBubbleGroup:showBubble(bubbleType, value, time, ...)
	self.super.showBubble(self, bubbleType, value, time, ...)
	self:_doBubble(time)
end

function BuffBubbleGroup:_doBubble(time)
	local dotweenHeight = 85 - 20 * #self._bubbleList

	dotweenHeight = dotweenHeight >= 0 and dotweenHeight or 0
	time = BattleTime.getScaledTime(time)

	for _, bubble in ipairs(self._bubbleList) do
		bubble:doBubble(dotweenHeight, time, DG.Tweening.Ease.OutQuart)
	end
end

return BuffBubbleGroup
