-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeInfoLvDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResMazeConfig = require("ClientData/ResMazeConfig")
local MazeLvInfoAwardPanel = require("UI/Maze/MazeLvInfoAwardPanel")
local MazeLvInfoBattleDiePanel = require("UI/Maze/MazeLvInfoBattleDiePanel")
local MazeLvInfoBattlePanel = require("UI/Maze/MazeLvInfoBattlePanel")
local MazeLvInfoRebornPanel = require("UI/Maze/MazeLvInfoRebornPanel")
local MazeLvInfoRecoverPanel = require("UI/Maze/MazeLvInfoRecoverPanel")
local MazeLvInfoBattleBloodPanel = require("UI/Maze/MazeLvInfoBattleBloodPanel")
local MazeLvInfoBattleNumLimitPanel = require("UI/Maze/MazeLvInfoBattleNumLimitPanel")
local MazeLvInfoBattleCampPanel = require("UI/Maze/MazeLvInfoBattleCampPanel")
local MazeLvInfoPandoraPanel = require("UI/Maze/MazeLvInfoPandoraPanel")
local MazeLvInfoBattleBossPanel = require("UI/Maze/MazeLvInfoBattleBossPanel")
local ID2BRANCH = {
	{
		Lang.get(6564),
		MazeLvInfoRecoverPanel,
		"System/Mazz/MazzLvInfoRecoverPanel"
	},
	{
		Lang.get(6567),
		MazeLvInfoRebornPanel,
		"System/Mazz/MazzLvInfoRebornPanel"
	},
	{
		Lang.get(6569),
		MazeLvInfoBattlePanel,
		"System/Mazz/MazzLvInfoBattlePanel"
	},
	{
		Lang.get(6571),
		MazeLvInfoBattlePanel,
		"System/Mazz/MazzLvInfoBattleHardPanel"
	},
	{
		Lang.get(6573),
		MazeLvInfoBattleDiePanel,
		"System/Mazz/MazzLvInfoBattleDiePanel"
	},
	{
		Lang.get(6576),
		MazeLvInfoAwardPanel,
		"System/Mazz/MazzLvInfoAwardPanel"
	},
	{
		Lang.get(6578),
		MazeLvInfoBattleBloodPanel,
		"System/Mazz/MazzLvInfoBattleBloodPanel"
	},
	{
		Lang.get(30578),
		MazeLvInfoBattleNumLimitPanel,
		"System/Mazz/MazzLvInfoBattleNumLimitPanel"
	},
	{
		Lang.get(30579),
		MazeLvInfoBattleCampPanel,
		"System/Mazz/MazzLvInfoBattleGroupPanel"
	},
	{
		Lang.get(30580),
		MazeLvInfoPandoraPanel,
		"System/Mazz/MazzLvInfoPandoraPanel"
	},
	{
		Lang.get(30581),
		nil,
		""
	},
	{
		Lang.get(30582),
		MazeLvInfoBattleBossPanel,
		"System/Mazz/MazzLvInfoBattleBossPanel"
	},
	{
		Lang.get(30583),
		MazeLvInfoBattleNumLimitPanel,
		"System/Mazz/MazzLvInfoBattleNumLimitHardPanel"
	}
}
local PanelChoose = Class("PanelChoose", UIControls.Panel)

function PanelChoose:ctor(parent, path, flag)
	self.flag = flag

	self:initUI()
end

function PanelChoose:initUI(...)
	self.uiAni = UIControls.UIAni(self, self.mPath)
	self.btnCards = {}

	for i = 1, self.flag do
		local btn = UIControls.Button(self, self.mPath .. "/Card" .. i)

		btn.mIndex = i

		btn:addEventClick(self.onBtnCardClick)
		table.insert(self.btnCards, btn)
	end

	self.cards = {}
	self.curIndex = nil
end

function PanelChoose:setData(data)
	self.data = data

	self:playAni("ShowMazzChoosePanel" .. self.flag)

	for i, info in ipairs(self.data.branchs) do
		local config = ID2BRANCH[info.type]
		local NodePanel = config[2]
		local node = NodePanel(self, self.mPath .. "/Card" .. i, config[3], 0, 0, true)

		table.insert(self.cards, node)
		node:setData(info, i, self.data, self.mWindow.isNextChangeNode)
		self.mParent:setNodeInfo(node)
		node:playAni("ShowMazzLvInfoB")
	end

	self.selectedIndex = CurAvatar.mazeData.branch

	if self.selectedIndex > 0 and self.selectedIndex <= #self.btnCards then
		self:onBtnCardClick(self.btnCards[self.selectedIndex])
	end
end

function PanelChoose:playAni(aniName)
	self.uiAni:startAni(aniName)
end

function PanelChoose:onBtnCardClick(sender)
	if self.selectedIndex > 0 and sender.mIndex ~= self.selectedIndex then
		MsgManager.notice(Lang.get(30584))

		return
	end

	for idx, btn in ipairs(self.btnCards) do
		if idx == sender.mIndex then
			btn:setEnable(false)
		else
			btn:setEnable(true)
		end
	end

	self:setClick(sender.mIndex)
end

function PanelChoose:setClick(index)
	self.cards[index]:playAni("RollMazzLvInfoBToF")

	if self.curIndex == nil then
		self:playAni("ShowMazzChoosePanel" .. self.flag .. index)

		self.curIndex = index
	else
		self.cards[self.curIndex]:playAni("RollMazzLvInfoFToB")
		self:playAni("ChangeMazzChoosePanel" .. self.flag .. self.curIndex .. "To" .. index)
	end

	self.curIndex = index
end

local strClassName = "MazeInfoLvDlg"
local MazeInfoLvDlg = Class(strClassName, UIControls.Window)

function MazeInfoLvDlg:ctor(...)
	self:initUI()
end

function MazeInfoLvDlg:initUI(...)
	self.panelInfo = UIControls.Panel(self, "InfoPanel")
	self.panelChoose2 = PanelChoose(self, "ChoosePanel2", 2)
	self.panelChoose3 = PanelChoose(self, "ChoosePanel3", 3)
end

function MazeInfoLvDlg:show(data, nodeIdx, isSpecialBox, isNextChangeNode)
	self.nodeIdx = nodeIdx
	self.isNextChangeNode = isNextChangeNode
	self.data = data

	if data then
		if #data.branchs == 1 then
			self.panelChoose2:setVisible(false)
			self.panelChoose3:setVisible(false)
			self.panelInfo:setVisible(true)
			self:initPanelInfo(self.data.branchs[1].type, isSpecialBox)
		elseif #data.branchs == 2 then
			self.panelChoose2:setVisible(true)
			self.panelChoose3:setVisible(false)
			self.panelInfo:setVisible(false)
			self.panelChoose2:setData(self.data)
		elseif #data.branchs == 3 then
			self.panelChoose2:setVisible(false)
			self.panelChoose3:setVisible(true)
			self.panelInfo:setVisible(false)
			self.panelChoose3:setData(self.data)
		end
	end
end

function MazeInfoLvDlg:setNodeInfo(nodePanel)
	local mazeName = ResMazeConfig[CurAvatar.mazeData.maze_id][1].maze_name or ""

	if RegionUtils.isSEA() then
		nodePanel:setNodeInfo(mazeName .. " - " .. self.nodeIdx)
	else
		nodePanel:setNodeInfo(mazeName .. "-" .. self.nodeIdx)
	end
end

function MazeInfoLvDlg:initPanelInfo(typeId, isSpecialBox)
	local config = ID2BRANCH[typeId]
	local NodePanel = config[2]

	if NodePanel then
		local node = NodePanel(self, "InfoPanel", config[3], 0, 0, true)

		node:setData(self.data.branchs[1], 1, self.data, self.isNextChangeNode)
		self:setNodeInfo(node)

		if isSpecialBox and node.setBoxPreview then
			node:setBoxPreview()
		end

		node:playAni("ShowMazzLvInfo", nil)
	end
end

function MazeInfoLvDlg:setBattleState(...)
	self:setVisible(false)

	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:showNodes(false)
	end
end

function MazeInfoLvDlg:hide(...)
	self:setVisible(false)
end

return MazeInfoLvDlg
