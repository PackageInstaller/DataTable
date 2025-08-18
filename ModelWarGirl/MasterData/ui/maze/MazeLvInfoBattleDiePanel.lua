-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoBattleDiePanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local strClassName = "MazeLvInfoBattleDiePanel"
local MazeLvInfoBattleDiePanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoBattleDiePanel, MazeNodePanelMixin, true)

function MazeLvInfoBattleDiePanel:ctor(...)
	self:ctorMixin()
	self:initUI()
	self:initMonsterUI()
end

function MazeLvInfoBattleDiePanel:initUI(...)
	self.txtFrontTips = UIControls.Label(self, "FrontPanel/TextTips")
end

function MazeLvInfoBattleDiePanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initMonsters()
	self:initAward(branchData.param[2])
	self.txtFrontTips:setText(ResMazeNodeConfig[branchData.type].desc)
end

function MazeLvInfoBattleDiePanel:onBtnFuncClick(...)
	self:battleFunc()
end

return MazeLvInfoBattleDiePanel
