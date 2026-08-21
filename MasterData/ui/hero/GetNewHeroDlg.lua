-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\GetNewHeroDlg.lua

local HeroCVNamePanel = require("UI/HandBook/HeroCVNamePanel")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local strClassName = "GetNewHeroDlg"
local GetNewHeroDlg = Class(strClassName, UIControls.Window)

function GetNewHeroDlg:ctor()
	self:initUI()
end

function GetNewHeroDlg:initUI()
	self.aniSelf = UIControls.UIAni(self, "")
	self.btnBlock = UIControls.Button(self, "Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.imgStarList = {}

	for i = 1, 5 do
		local image = UIControls.Image(self, "InfoPanel/ImgStarPanel/ImgStar" .. i)

		table.insert(self.imgStarList, image)
	end

	self.imgLineL = UIControls.Image(self, "InfoPanel/ImgStarPanel/ImgLineL")
	self.imgLineR = UIControls.Image(self, "InfoPanel/ImgStarPanel/ImgLineR")
	self.imgBgStar = UIControls.Image(self, "InfoPanel/BgStar")
	self.imgCamp = UIControls.Image(self, "InfoPanel/IconCamp")
	self.imgJob = UIControls.Image(self, "InfoPanel/IconJob")
	self.rolePortrait = UIControls.Role(self, "InfoPanel/GridHeroPortraitPanel", 0, 0)
	self.panelCVName = HeroCVNamePanel(self, "InfoPanel/CvPanel")

	if CurAvatar then
		CurAvatar:resetOpenBoxDlg()
	end

	self.panelUniqueHero1 = UIControls.Panel(self, "InfoPanel/BgTextName/IconVanityStar")
	self.panelUniqueHero2 = UIControls.Panel(self, "InfoPanel/BgTextName/Bg")
	self.txtName = UIControls.Label(self, "InfoPanel/BgTextName/TextName")
end

local STAR_BG_COLOR_DIC = {
	[4] = {
		196,
		88,
		255
	},
	[5] = {
		255,
		213,
		76
	}
}

function GetNewHeroDlg:setHero(hero)
	self.hero = hero

	self.txtName:setText(self.hero.fullName)

	local campPath = self.hero:getGroupLargePath()

	if campPath then
		self.imgCamp:setImage(campPath[1], campPath[2])
	end

	local careerPath = self.hero:getCareerPath()

	if careerPath then
		self.imgJob:setImage(careerPath[1], careerPath[2])
	end

	self.rolePortrait:showRole(self.hero.id, UIConst.ROLEIMAGE_SHOWTYPE_HERO_GET)

	local stepImgIdx = ResStarUpCondition[self.hero.star].step_img_idx or 1
	local stepImgInfo = UIConst.HERO_CARD_SPRITE_BY_STEP[stepImgIdx]

	if stepImgInfo then
		local showStarNum = 0

		for star = self.hero.star, 1, -1 do
			if ResStarUpCondition[star].step_img_idx == stepImgIdx then
				showStarNum = showStarNum + 1
			end
		end

		for idx, image in ipairs(self.imgStarList) do
			if idx <= showStarNum then
				image:setImage(stepImgInfo.IMG_STAR[1], stepImgInfo.IMG_STAR[2])
				image:setVisible(true)
			else
				image:setVisible(false)
			end
		end

		self.imgLineL:setImage(stepImgInfo.IMG_STAR_L[1], stepImgInfo.IMG_STAR_L[2])
		self.imgLineR:setImage(stepImgInfo.IMG_STAR_R[1], stepImgInfo.IMG_STAR_R[2])
	end

	self.panelCVName:setHero(self.hero)
	CueManager.stopVocal()
	CueManager.playHeroVocal(hero.id, Const.HERO_VOCAL_GET)
	self.panelUniqueHero1:setVisible(self.hero:isUniqueHero())
	self.panelUniqueHero2:setVisible(self.hero:isUniqueHero())
end

function GetNewHeroDlg:setHeroList(heroList)
	if not self.heroList then
		self.heroList = heroList

		self:setHero(self.heroList[1])
		table.remove(self.heroList, 1)
	else
		for _, hero in ipairs(heroList) do
			table.insert(self.heroList, hero)
		end
	end
end

function GetNewHeroDlg:onBtnBlockClick()
	if self.heroList and #self.heroList > 0 then
		self.aniSelf:startAni("ShowGetNewHeroWin", true)
		self:setHero(self.heroList[1])
		table.remove(self.heroList, 1)
	else
		self:setVisible(false)
	end
end

function GetNewHeroDlg:onClose()
	CueManager.stopVocal()
	GetNewHeroDlg.super.onClose(self)
end

return GetNewHeroDlg
