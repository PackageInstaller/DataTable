-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\RelatedHeroStarChangeDlg.lua

local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResHero = require("ClientData/ResHero")
local RelatedHeroStarTeamGrid = Class("RelatedHeroStarTeamGrid", UIControls.Child)

function RelatedHeroStarTeamGrid:ctor()
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgHead = UIControls.Image(self, "BgHead/IconHead")
	self.imgStar = UIControls.Image(self, "ImgStar")
end

function RelatedHeroStarTeamGrid:setData(heroId, heroStar)
	self.heroId = heroId
	self.heroStar = heroStar
	self.hero = BaseObject.GetObject(heroId)

	local iconPath = self.hero:getIconPath(true)

	if iconPath then
		self.imgHead:setImage(iconPath[1], iconPath[2])
	end

	local stepImgInfo = UIConst.getHeroStepPath(heroStar)

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	local starPath = UIConst.getHeroStarPath(heroStar)

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end
end

local RelatedHeroStarChangeCell = Class("RelatedHeroStarChangeCell", UIControls.Child)

function RelatedHeroStarChangeCell:ctor()
	self.panelBg = UIControls.Image(self, "Bg")
	self.textMode = UIControls.Label(self, "TextTitle")
	self.textMaskEng = UIControls.Label(self, "TextMask/TextEng")
	self.gridUniqueHeroBefore = RelatedHeroStarTeamGrid(self, "HeroPanel2/BeforePanel", "System/Common/Grid/GridHeroTeam", 0, 0, true)
	self.gridUniqueHeroAfter = RelatedHeroStarTeamGrid(self, "HeroPanel2/AfterPanel", "System/Common/Grid/GridHeroTeam", 0, 0, true)
	self.gridRelatedHeroBefore = RelatedHeroStarTeamGrid(self, "HeroPanel1/BeforePanel", "System/Common/Grid/GridHeroTeam", 0, 0, true)
	self.gridRelatedHeroAfter = RelatedHeroStarTeamGrid(self, "HeroPanel1/AfterPanel", "System/Common/Grid/GridHeroTeam", 0, 0, true)
	self.panelEfxUp = UIControls.Panel(self, "EfxPanelUp")
	self.panelEfxDown = UIControls.Panel(self, "EfxPanelDown")
end

function RelatedHeroStarChangeCell:setData(heroId, preStar, nowStar)
	self.relateData = Const.UNIQUE_HERO[heroId]

	if not self.relateData then
		return
	end

	if preStar < nowStar then
		self.panelEfxUp:setVisible(true)
		self.panelEfxDown:setVisible(false)
		self.panelBg:setImage("Atlas/HeroAtlas/VanityHeroAtlas", "ImgDec03")
		self.textMode:setText(Lang.get(1202))
		self.textMode:setFontColor(ResColor.ORANGEBTN)
		self.textMaskEng:setFontColor(ResColor.GREYMAIN)
	else
		self.panelEfxUp:setVisible(false)
		self.panelEfxDown:setVisible(true)
		self.panelBg:setImage("Atlas/HeroAtlas/VanityHeroAtlas", "ImgDec04")
		self.textMode:setText(Lang.get(55824))
		self.textMode:setFontColor(ResColor.COLORRANK07)
		self.textMaskEng:setFontColor(ResColor.COLORRANK03)
	end

	self.gridUniqueHeroBefore:setData(heroId, preStar)
	self.gridUniqueHeroAfter:setData(heroId, nowStar)
	self.gridRelatedHeroBefore:setData(self.relateData.resid, preStar)
	self.gridRelatedHeroAfter:setData(self.relateData.resid, nowStar)
end

local strClassName = "RelatedHeroStarChangeDlg"
local RelatedHeroStarChangeDlg = Class(strClassName, UIControls.Window)

function RelatedHeroStarChangeDlg:ctor()
	self:initUI()
end

function RelatedHeroStarChangeDlg:initUI()
	self.textRule = UIControls.Label(self, "BgPanel/TextRule")
	self.panelStarCell = RelatedHeroStarChangeCell(self, "BgPanel/StarChangeList/Content", "System/Hero/VanityHeroStarChangeCell")

	self.panelStarCell:setVisible(true)
end

function RelatedHeroStarChangeDlg:showHero(heroId, preStar, afterStar)
	self.relateData = Const.UNIQUE_HERO[heroId]

	if not self.relateData then
		return
	end

	self.panelStarCell:setData(heroId, preStar, afterStar)

	local ruleDesc = ResInfoNotice[255].content
	local uniqueHeroName = ResHero[self.relateData.voidhero_resid].full_name or ""
	local relatedHeroName = ResHero[self.relateData.resid].full_name or ""

	ruleDesc = utils.replaceString(ruleDesc, "#1", uniqueHeroName)
	ruleDesc = utils.replaceString(ruleDesc, "#2", relatedHeroName)

	self.textRule:setText(ruleDesc)
end

return RelatedHeroStarChangeDlg
