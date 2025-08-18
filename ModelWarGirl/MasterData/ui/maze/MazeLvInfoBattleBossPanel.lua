-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoBattleBossPanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local strClassName = "MazeLvInfoBattleBossPanel"
local MazeLvInfoBattleBossPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoBattleBossPanel, MazeNodePanelMixin, true)

function MazeLvInfoBattleBossPanel:ctor(...)
	self:ctorMixin()
	self:initMonsterUI()
end

function MazeLvInfoBattleBossPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initMonsters()
	self:initAward(branchData.param[2])
end

function MazeLvInfoBattleBossPanel:onBtnFuncClick(...)
	self:battleFunc()
end

return MazeLvInfoBattleBossPanel
