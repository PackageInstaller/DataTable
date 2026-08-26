-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity218/CruiseGameCardMO.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity218.CruiseGameCardMO", package.seeall)

local CruiseGameCardMO = pureTable("CruiseGameCardMO")

function CruiseGameCardMO:setData(cardType, isFlipped)
	self.cardType = cardType
	self.isFlipped = isFlipped
end

function CruiseGameCardMO:setIsFlipped(value)
	self.isFlipped = value
end

return CruiseGameCardMO
