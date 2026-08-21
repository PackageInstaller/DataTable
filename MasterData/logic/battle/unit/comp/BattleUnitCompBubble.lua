-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompBubble.lua

module("logic.battle.unit.comp.BattleUnitCompBubble", package.seeall)

local BattleUnitCompBubble = class("BattleUnitCompBubble", BattleUnitCompBase)

function BattleUnitCompBubble:onInit()
	self._uiFollow = self._unit.uiFollow
	self._bubbleGroupTable = {}
	self._performanceBubbleGroup = {}
end

function BattleUnitCompBubble:onReset()
	self:_clearAllBubbleGroup()
end

function BattleUnitCompBubble:onDestroy()
	self:_clearAllBubbleGroup()

	self._uiFollow = nil
end

function BattleUnitCompBubble:showBubble(bubbleType, value, time, ...)
	local bubbleGroup = self:_getBubbleGroup(UIFollowType.TopBubble, bubbleType)

	bubbleGroup:showBubble(bubbleType, value, time, false, ...)
end

function BattleUnitCompBubble:showCenterBubble(bubbleType, value, time)
	local bubbleGroup = self:_getBubbleGroup(UIFollowType.CenterBubble, bubbleType)

	bubbleGroup:showBubble(bubbleType, value, time, false)
end

function BattleUnitCompBubble:showPerformanceBubble(bubbleType, value, time, ...)
	local bubbleGroup = self:_getPerformanceBubbleGroup()

	bubbleGroup:showBubble(bubbleType, value, time, true, ...)
end

function BattleUnitCompBubble:clearAllBubbleGroup()
	self:_clearAllBubbleGroup()
end

function BattleUnitCompBubble:clearPerformanceBubbleGroup()
	self:_clearPerformanceBubbleGroup()
end

function BattleUnitCompBubble:_getBubbleGroup(followType, bubbleType)
	local bubbleGroup = self._bubbleGroupTable[followType]

	if not bubbleGroup then
		local cls = BubbleSettings.bubbleType2BubbleGroup(bubbleType)

		bubbleGroup = cls:createInstance()

		bubbleGroup:setListener(self._onBubbleGroupEmpty, self)

		bubbleGroup.followType = followType

		self._uiFollow:addFollowGameObject(followType, bubbleGroup.mainGO)

		self._bubbleGroupTable[followType] = bubbleGroup
	end

	return bubbleGroup
end

function BattleUnitCompBubble:_clearAllBubbleGroup()
	self:_clearPerformanceBubbleGroup()

	for followType, bubbleGroup in pairs(self._bubbleGroupTable) do
		self._uiFollow:removeFollowGameObject(followType, bubbleGroup.mainGO)
	end

	BattleTableUtil.clearReusableTable(self._bubbleGroupTable)
end

function BattleUnitCompBubble:_onBubbleGroupEmpty(bubbleGroup)
	self._uiFollow:removeFollowGameObject(bubbleGroup.followType, bubbleGroup.mainGO)

	self._bubbleGroupTable[bubbleGroup.followType] = nil

	bubbleGroup:returnSelf()
end

function BattleUnitCompBubble:_getPerformanceBubbleGroup()
	if #self._performanceBubbleGroup >= 5 then
		local item = table.remove(self._performanceBubbleGroup, 1)

		self._uiFollow:removeFollowGameObject(UIFollowType.Center, item.mainGO)
		item:returnSelf()
	end

	local bubbleUnique = BubbleUnique:createInstance()

	self._uiFollow:addFollowGameObject(UIFollowType.Center, bubbleUnique.mainGO)
	table.insert(self._performanceBubbleGroup, bubbleUnique)

	return bubbleUnique
end

function BattleUnitCompBubble:_clearPerformanceBubbleGroup()
	for _, item in ipairs(self._performanceBubbleGroup) do
		self._uiFollow:removeFollowGameObject(UIFollowType.Center, item.mainGO)
		item:returnSelf()
	end

	self._performanceBubbleGroup = {}
end

return BattleUnitCompBubble
