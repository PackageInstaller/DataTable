-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroInfoPanel.lua

local strClassName = "HeroInfoPanel"
local HeroInfoPanel = Class(strClassName, UIControls.Panel)
local HERO_COMMON_ATLAS = "Atlas/HeroAtlas/HeroCardCommonAtlas"

function HeroInfoPanel:ctor()
	self:initUI()
end

function HeroInfoPanel:initUI()
	self.txtHeroName = UIControls.Label(self, self.mPath .. "/TextName")
	self.imgCareerIcon = UIControls.Image(self, self.mPath .. "/IconCareer")
	self.imgGroup = UIControls.Image(self, self.mPath .. "/IconGroup")
	self.starList = {}
	self.imgLargeStar = UIControls.Image(self, self.mPath .. "/IconStar")
	self.btnLock = UIControls.Button(self, self.mPath .. "/BtnLock")

	self.btnLock:addEventClick(self.onBtnLockClick)

	self.imgLocked = UIControls.Image(self, self.mPath .. "/BtnLock/Dis")
	self.imgCanLock = UIControls.Image(self, self.mPath .. "/BtnLock/Nml")
end

function HeroInfoPanel:onBtnLockClick()
	if self.hero.lock == 0 then
		RPC.heroLock(self.hero.gid)
	else
		RPC.heroUnlock(self.hero.gid)
	end
end

function HeroInfoPanel:onBtnCommentClick()
	return
end

function HeroInfoPanel:setHero(hero)
	self.hero = hero

	if Const.REVIEW_VERSION and self.hero.fullName == "S-VIII" then
		self.txtHeroName:setText(Lang.get(111526))
	else
		self.txtHeroName:setText(self.hero.fullName)
	end

	self.imgLocked:setVisible(self.hero.lock == 1)
	self.imgCanLock:setVisible(self.hero.lock == 0)

	local careerPath = self.hero:getCareerPath()

	if careerPath then
		self.imgCareerIcon:setImage(careerPath[1], careerPath[2])
	end

	local campPath = self.hero:getGroupPath()

	if campPath then
		self.imgGroup:setImage(campPath[1], campPath[2])
	end

	self:refreshStarInfo()
end

function HeroInfoPanel:refreshStarInfo()
	local largeStarPath = self.hero:getLargeStarPath()

	if largeStarPath then
		self.imgLargeStar:setImage(largeStarPath[1], largeStarPath[2])
	end
end

function HeroInfoPanel:onBtnHandBookClick()
	return
end

return HeroInfoPanel
