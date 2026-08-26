-- chunkname: @modules/common/others/simplelistcomp/SimpleListParam.lua

module("modules.common.others.simplelistcomp.SimpleListParam", package.seeall)

local SimpleListParam = pureTable("SimpleListParam")

function SimpleListParam:ctor()
	self.cellClass = nil
	self.cellParam = nil
	self.lineCount = 1
	self.cellWidth = 0
	self.cellHeight = 0
	self.cellSpaceH = 0
	self.cellSpaceV = 0
	self.startSpace = 0
	self.endSpace = 0
	self.sortMode = ScrollEnum.ScrollSortNone
	self.frameUpdateMs = 10
	self.minUpdateCountInFrame = 1
	self.isClickAutoSelect = false
end

return SimpleListParam
