-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\HeroGridSolderCard.lua

local ResColor = require("ClientData/ResColor")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local strClassName = "HeroGridSolderCard"
local HeroGridSolderCard = Class(strClassName, UIControls.HeroCardLoop)

function HeroGridSolderCard:initUI(...)
	HeroGridSolderCard.super.initUI(self)

	self.IconSolderList = {}

	for i = 1, 3 do
		local IconSolder = UIControls.Image(self, "InfoPanel/SolderPanel/IconSolder" .. i)
		local BgIconSolder = UIControls.Image(self, "InfoPanel/SolderPanel/BgIconSolder" .. i)

		table.insert(self.IconSolderList, {
			IconSolder = IconSolder,
			BgIconSolder = BgIconSolder
		})
	end

	self.bgIntoBattle = UIControls.Panel(self, "InfoPanel/BgIntoBattle")
	self.sensor = UIControls.Panel(self, "")

	self.sensor:addEventDragOnGet(self.onDragGet)
	self.sensor:addEventDragOnClick(self.onDragClick)

	self.selBg1 = UIControls.Image(self, "SelBg1")
	self.imgSel = UIControls.Panel(self, "InfoPanel/ImgSel")
	self.imgInherit = UIControls.Panel(self, "InfoPanel/ImgInherit")
	self.imgReplace = UIControls.Panel(self, "InfoPanel/ImgReplace")
	self.panelInBattle = UIControls.Panel(self, "InfoPanel/IconState3")
	self.showTips = true
	self.isDragTip = true
	self.showSelPic = false
end

function HeroGridSolderCard:onDragGet()
	return
end

function HeroGridSolderCard:onDragClick(sender)
	return
end

function HeroGridSolderCard:setHero(hero)
	HeroGridSolderCard.super.setHero(self, hero)

	self.hero = hero

	if self.hero.inBattleFormation then
		self.panelInBattle:setVisible(true)
	else
		self.panelInBattle:setVisible(false)
	end

	self:showMazeSolderState()
end

function HeroGridSolderCard:showMazeSolderState(isShowDefault)
	local solderList = self.hero:getMazeSolderState(isShowDefault)

	for i = 1, 3 do
		if solderList[i] then
			local solderId = solderList[i].id

			self.IconSolderList[i].IconSolder:setVisible(true)
			self.IconSolderList[i].BgIconSolder:setVisible(true)

			if ResNewMazeFettersType[solderId] then
				local data = ResNewMazeFettersType[solderId][1]

				self.IconSolderList[i].IconSolder:setImage(data.icon_path, data.icon_name)
			end

			if solderList[i].isDefault then
				self.IconSolderList[i].BgIconSolder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", "BgFetter1")
			else
				self.IconSolderList[i].BgIconSolder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", "BgFetter2")
			end
		else
			self.IconSolderList[i].IconSolder:setVisible(false)
			self.IconSolderList[i].BgIconSolder:setVisible(false)
		end
	end
end

function HeroGridSolderCard:setFormation()
	self.formation = CurAvatar:getNowFormation(Const.FORMATION_NEW_MAZE)

	if self.formation[self.hero.id] then
		self.bgIntoBattle:setVisible(true)
	else
		self.bgIntoBattle:setVisible(false)
	end
end

return HeroGridSolderCard
