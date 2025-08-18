-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeLvInfoBattleCampPanel.lua

local MazeNodePanelMixin = require("UI/Maze/MazeNodePanelMixin")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local strClassName = "MazeLvInfoBattleCampPanel"
local MazeLvInfoBattleCampPanel = Class(strClassName, UIControls.Child)

MixinClass(MazeLvInfoBattleCampPanel, MazeNodePanelMixin, true)

local ICON_PATH = "Atlas/MazeAtlas/MazeAtlas"

function MazeLvInfoBattleCampPanel:ctor(...)
	self:ctorMixin()
	self:initMonsterUI()
	self:initUI()
end

function MazeLvInfoBattleCampPanel:initUI(...)
	self.txtFrontTips = UIControls.Label(self, "FrontPanel/TextTips")
	self.imgCamp = UIControls.Image(self, "FrontPanel/BgTips")
	self.imgFrontBg = UIControls.Image(self, "FrontPanel/BgTitle")
	self.imgFrontTitile = UIControls.Image(self, "FrontPanel/ImgTitle")
	self.imgFrontType = UIControls.Image(self, "FrontPanel/ImgType")
	self.imgBack = UIControls.Image(self, "BackPanel")
	self.imgBackBg = UIControls.Image(self, "BackPanel/BgTitle")
	self.imgBackTitle = UIControls.Image(self, "BackPanel/ImgTitle")
end

function MazeLvInfoBattleCampPanel:setData(branchData, branchIndex, baseData, isNextChangeNode)
	self:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self:initMonsters()
	self:initAward(branchData.param[2])

	local camp = self.battleConfig.camp_limit
	local name = ""

	if camp then
		name = Const.CAMP_CONFIG[camp].name
	end

	local content = string.format(ResMazeNodeConfig[branchData.type].node_desc, name)

	self.txtFrontTips:setText(content)
	self.imgCamp:setImage("Atlas/MazeAtlas/MazeAtlas", "BgGroupL0" .. camp)

	local idx = camp == 1 and 6 or 7
	local path = ICON_PATH .. idx

	self.imgFrontBg:setImage(path, "IconBattleGroup0" .. camp .. "S")
	self.imgFrontTitile:setImage(path, "TxtBattleGroup0" .. camp)
	self.imgFrontType:setImage(path, "IconBattleGroup0" .. camp)
	self.imgBack:setImage(path, "BgBattleGroup0" .. camp)
	self.imgBackBg:setImage(path, "IconBattleGroup0" .. camp .. "S")
	self.imgBackTitle:setImage(path, "TxtBattleGroup0" .. camp)
end

function MazeLvInfoBattleCampPanel:onBtnFuncClick(...)
	self:battleFunc()
end

return MazeLvInfoBattleCampPanel
