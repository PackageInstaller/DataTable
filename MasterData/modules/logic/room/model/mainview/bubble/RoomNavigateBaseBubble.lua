-- chunkname: @modules/logic/room/model/mainview/bubble/RoomNavigateBaseBubble.lua

module("modules.logic.room.model.mainview.bubble.RoomNavigateBaseBubble", package.seeall)

local RoomNavigateBaseBubble = pureTable("RoomNavigateBaseBubble")

function RoomNavigateBaseBubble:init(showType)
	self.showType = showType
	self.bubbleDatas = {}
	self.bubbleDataSet = {}
end

function RoomNavigateBaseBubble:addBubbleData(bubbleData)
	if self.bubbleDataSet[bubbleData] then
		return
	end

	table.insert(self.bubbleDatas, bubbleData)

	self.bubbleDataSet[bubbleData] = true
end

function RoomNavigateBaseBubble:removeBubbleData(bubbleData)
	if not self.bubbleDataSet[bubbleData] then
		return
	end

	tabletool.removeValue(self.bubbleDatas, bubbleData)

	self.bubbleDataSet[bubbleData] = nil
end

function RoomNavigateBaseBubble:clear()
	for k, _ in pairs(self.bubbleDatas) do
		self.bubbleDatas[k] = nil
	end

	for k, _ in pairs(self.bubbleDataSet) do
		self.bubbleDataSet[k] = nil
	end
end

function RoomNavigateBaseBubble:getShowType()
	return self.showType
end

function RoomNavigateBaseBubble:getBubbleCount()
	return #self.bubbleDatas
end

function RoomNavigateBaseBubble:getFirstBubble()
	return self.bubbleDatas[1]
end

function RoomNavigateBaseBubble:sort(compareFunc)
	if compareFunc then
		table.sort(self.bubbleDatas, compareFunc)
	end
end

return RoomNavigateBaseBubble
