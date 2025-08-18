-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoBattleBloodPanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local strClassName = "MazeLvInfoBattleBloodPanel"
local MazeLvInfoBattleBloodPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoBattleBloodPanel, MazeNodePanelMixin, true)

function MazeLvInfoBattleBloodPanel:ctor(...)
	self:ctorMixin()
	self:initUI()
	self:initMonsterUI()
end

function MazeLvInfoBattleBloodPanel:initUI(...)
	self.txtFrontTips = UIControls.Label(self, "FrontPanel/TextTips")
end

function MazeLvInfoBattleBloodPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initMonsters()
	self:initAward(branchData.param[2])

	local percent = branchData.param[3] / 100 .. "%"
	local content = string.format(ResMazeNodeConfig[branchData.type].node_desc, percent)

	self.txtFrontTips:setText(content)
end

function MazeLvInfoBattleBloodPanel:onBtnFuncClick(...)
	self:battleFunc()
end

return MazeLvInfoBattleBloodPanel
