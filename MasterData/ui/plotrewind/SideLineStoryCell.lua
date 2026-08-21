-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\SideLineStoryCell.lua

local strClassName = "SideLineStoryCell"
local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local PlotRewindStoryCellMixin = require("UI/PlotRewind/PlotRewindStoryCellMixin")
local SideLineStoryCell = Class(strClassName, UIControls.Child)

MixinClass(SideLineStoryCell, PlotRewindStoryCellMixin)

SideLineStoryCell.CellWidth = 430

function SideLineStoryCell:ctor()
	return
end

function SideLineStoryCell:setData(storyInfo, cellRootPath)
	if cellRootPath then
		self.rootPath = cellRootPath
		self.partition = "/"
	else
		self.partition = ""
		self.rootPath = ""
	end

	self.iconNew = UIControls.Image(self, self.rootPath .. self.partition .. "IconNew")

	self:_setData(storyInfo, cellRootPath)
end

function SideLineStoryCell:setNewState(state)
	self.iconNew:setVisible(state)
end

return SideLineStoryCell
