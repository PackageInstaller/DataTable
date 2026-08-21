-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\MainLineStoryCell.lua

local strClassName = "MainLineStoryCell"
local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local MainLineStoryCell = Class(strClassName, UIBaseControl)
local PlotRewindStoryCellMixin = require("UI/PlotRewind/PlotRewindStoryCellMixin")

MixinClass(MainLineStoryCell, PlotRewindStoryCellMixin)

function MainLineStoryCell:ctor()
	return
end

function MainLineStoryCell:setData(storyInfo, cellRootPath)
	if cellRootPath then
		self.rootPath = cellRootPath
		self.partition = "/"
	else
		self.partition = ""
		self.rootPath = ""
	end

	self.lockNode = UIControls.Panel(self, self.rootPath .. self.partition .. "MaskImage/LockNode")
	self.lockImage = UIControls.Image(self, self.rootPath .. self.partition .. "TitleInfo/LockImage")

	self:_setData(storyInfo, cellRootPath)
end

return MainLineStoryCell
