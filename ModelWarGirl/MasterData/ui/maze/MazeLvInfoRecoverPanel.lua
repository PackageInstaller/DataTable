-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoRecoverPanel.lua

local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local strClassName = "MazeLvInfoRecoverPanel"
local MazeLvInfoRecoverPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoRecoverPanel, MazeNodePanelMixin, true)

function MazeLvInfoRecoverPanel:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function MazeLvInfoRecoverPanel:initUI(...)
	self.txtDesc = UIControls.Label(self, "FrontPanel/TextDes")
end

function MazeLvInfoRecoverPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)

	local percent = branchData.param[1] / 100 .. "%"

	self.percent = percent

	local content = string.format(ResMazeNodeConfig[branchData.type].node_desc, percent)

	self.txtDesc:setText(content)
end

function MazeLvInfoRecoverPanel:onBtnFuncClick(...)
	MsgManager.notice(string.format(Lang.get(30589), self.percent))
	RPC.mazeSelectBranch(self.branchIndex)
	self.mWindow:hide()
end

return MazeLvInfoRecoverPanel
