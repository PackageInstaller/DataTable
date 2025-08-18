-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoBattlePanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local strClassName = "MazeLvInfoBattlePanel"
local MazeLvInfoBattlePanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoBattlePanel, MazeNodePanelMixin, true)

function MazeLvInfoBattlePanel:ctor(...)
	self:ctorMixin()
	self:initMonsterUI()
end

function MazeLvInfoBattlePanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initMonsters()
	self:initAward(branchData.param[2])
end

function MazeLvInfoBattlePanel:onBtnFuncClick(...)
	self:battleFunc()
end

return MazeLvInfoBattlePanel
