-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeHeroCheckDlg.lua

local HeroGridBloodCard = require("UI/Maze/HeroGridBloodCard")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local strClassName = "MazeHeroCheckDlg"
local MazeHeroCheckDlg = Class(strClassName, UIControls.Window)
local ResMazeMisc = require("ClientData/ResMazeMisc")

function MazeHeroCheckDlg:ctor()
	self:initUI()
end

function MazeHeroCheckDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.filterSelectPanel = FilterSelectPanel(self, "MainInfoPanel/ListSelectPanel")
	self.listHeros = CommonHeroListPanel(self, "MainInfoPanel")
	self.listHeros.isDragTip = false

	self.listHeros:initHeroList(HeroGridBloodCard, "System/Hero/GridHeroCardBlood", UIConst.HERO_MAZE_SORT_MAP, UIConst.HERO_MAZE_FILTER_PANEL_MAP)

	self.txtNum = UIControls.Label(self, "MainInfoPanel/LimitPanel/TextNum")

	self:refreshNum()
end

function MazeHeroCheckDlg:refreshNum(...)
	self.txtNum:setText(CurAvatar.mazeHeroNum .. "/" .. CurAvatar:getMazeHeroLimit())
end

function MazeHeroCheckDlg:onBtnCloseClick()
	self:setVisible(false)
end

return MazeHeroCheckDlg
