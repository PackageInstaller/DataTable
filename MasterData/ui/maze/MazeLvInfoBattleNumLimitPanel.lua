-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoBattleNumLimitPanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local strClassName = "MazeLvInfoBattleNumLimitPanel"
local MazeLvInfoBattleNumLimitPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoBattleNumLimitPanel, MazeNodePanelMixin, true)

function MazeLvInfoBattleNumLimitPanel:ctor(...)
	self:ctorMixin()
	self:initUI()
	self:initMonsterUI()
end

function MazeLvInfoBattleNumLimitPanel:initUI(...)
	self.txtFrontTips = UIControls.Label(self, "FrontPanel/TextTips")
end

function MazeLvInfoBattleNumLimitPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initMonsters()
	self:initAward(branchData.param[2])

	local limit = self.battleConfig.num_limit or 0
	local content = string.format(ResMazeNodeConfig[branchData.type].node_desc, limit)

	self.txtFrontTips:setText(content)
end

function MazeLvInfoBattleNumLimitPanel:onBtnFuncClick(...)
	self:battleFunc()
end

return MazeLvInfoBattleNumLimitPanel
