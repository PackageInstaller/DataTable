-- chunkname: @modules/logic/handbook/model/HandbookCGTripleMO.lua

module("modules.logic.handbook.model.HandbookCGTripleMO", package.seeall)

local HandbookCGTripleMO = pureTable("HandbookCGTripleMO")

function HandbookCGTripleMO:init(param)
	if param.isTitle then
		self.storyChapterId = param.storyChapterId
		self.isTitle = true
	else
		self.cgList = param.cgList
		self.cgType = param.cgType
		self.isTitle = false
	end
end

return HandbookCGTripleMO
