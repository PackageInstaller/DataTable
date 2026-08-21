-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/BubbleUnique.lua

module("logic.battle.uibubble.BubbleUnique", package.seeall)

local BubbleUnique = class("BubbleUnique", IBattleReusable)

function BubbleUnique:ctor()
	self.mainGO = goutil.create("bubble-unique", true)

	goutil.addChildToParent(self.mainGO, BubbleSettings.BubbleRoot)

	self._bubble = false
end

function BubbleUnique:reset()
	self:clearAllBubble()
end

function BubbleUnique:destroy()
	self:clearAllBubble()
	goutil.destroy(self.mainGO)

	self.mainGO = nil
end

function BubbleUnique:getCapacity()
	return BattleConst.ObjPoolCapacityDefault
end

function BubbleUnique:showBubble(bubbleType, value, time, ...)
	if not self._bubble then
		local cls = BubbleSettings.bubbleType2BubbleClass(bubbleType)

		self._bubble = cls:createInstance()

		goutil.addChildToParent(self._bubble.mainGO, self.mainGO)
	end

	self._bubble:setBubbleContent(value, bubbleType, ...)
end

function BubbleUnique:clearAllBubble()
	if self._bubble then
		self._bubble:returnSelf()

		self._bubble = false
	end
end

return BubbleUnique
