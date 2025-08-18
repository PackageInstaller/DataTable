-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoAwardPanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local strClassName = "MazeLvInfoAwardPanel"
local MazeLvInfoAwardPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoAwardPanel, MazeNodePanelMixin, true)

function MazeLvInfoAwardPanel:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function MazeLvInfoAwardPanel:initUI(...)
	self.txtUnlock = UIControls.Label(self, "FrontPanel/TextUnlock")
end

function MazeLvInfoAwardPanel:setBoxPreview(...)
	self.btnFunc:setVisible(false)
	self.txtUnlock:setVisible(true)
	self.txtUnlock:setText(ResMazeNodeConfig[self.branchData.type].desc)
end

function MazeLvInfoAwardPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initAward(branchData.param[1])
end

function MazeLvInfoAwardPanel:onBtnFuncClick(...)
	self:awardFunc()
end

return MazeLvInfoAwardPanel
