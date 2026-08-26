-- chunkname: @modules/logic/room/model/mainview/bubble/RoomNavigateBubbleCategoryMO.lua

module("modules.logic.room.model.mainview.bubble.RoomNavigateBubbleCategoryMO", package.seeall)

local RoomNavigateBubbleCategoryMO = pureTable("RoomNavigateBubbleCategoryMO")

function RoomNavigateBubbleCategoryMO:init(showType)
	self.showType = showType
	self._buildingBubblesDict = {}
	self._buildingBubblesList = {}
end

local ChildrenTypeClz = {}

function RoomNavigateBubbleCategoryMO:getOrCreateBubbleMO(bubbleType)
	local bubbleMO = self._buildingBubblesDict[bubbleType]

	if not bubbleMO then
		local clz = ChildrenTypeClz[bubbleType]

		clz = clz or RoomNavigateBaseBubble
		bubbleMO = clz.New()

		bubbleMO:init(bubbleType)

		self._buildingBubblesDict[bubbleType] = bubbleMO
		self._buildingBubblesList[#self._buildingBubblesList + 1] = bubbleMO
	end

	return bubbleMO
end

function RoomNavigateBubbleCategoryMO:cleanBubble(bubbleType)
	local bubbleMO = self._buildingBubblesDict[bubbleType]

	if bubbleMO then
		bubbleMO:clear()
	end
end

function RoomNavigateBubbleCategoryMO:getBubbles()
	return self._buildingBubblesList
end

function RoomNavigateBubbleCategoryMO:getBubbleByType(bubbleType)
	local bubbleMO

	return (self._buildingBubblesDict and bubbleType or nil) and self._buildingBubblesDict[bubbleType]
end

function RoomNavigateBubbleCategoryMO:getBubblesCount()
	local rs = 0

	for k, bubbleMO in pairs(self._buildingBubblesDict) do
		rs = rs + bubbleMO:getBubbleCount()
	end

	return rs
end

function RoomNavigateBubbleCategoryMO:sort()
	for _, bubbleMO in pairs(self._buildingBubblesDict) do
		local compareFunc = RoomNavigateBubbleController.sortFunc[self.showType][bubbleMO.showType]

		if compareFunc then
			bubbleMO:sort(compareFunc)
		end
	end
end

return RoomNavigateBubbleCategoryMO
