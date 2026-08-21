-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridSimpleHeroChild.lua

local GridSimpleHeroChild = Class("GridSimpleHeroChild", UIControls.Child)

function GridSimpleHeroChild:ctor()
	self:initUI()
end

function GridSimpleHeroChild:initUI()
	self.imgHeroIcon = UIControls.Image(self, "BgHead/IconHead")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgHeroStar = UIControls.Image(self, "ImgStar")
	self.imgPaint = UIControls.Image(self, "CoatingImg")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelect)

	if UIControls.checkControlFunc(self, "IconCoating02") then
		self.iconCoating02 = UIControls.Image(self, "IconCoating02")
		self.txtPaintPlusLevel = UIControls.Label(self, "IconCoating02/Text")
	end
end

function GridSimpleHeroChild:setObj(hero)
	self.hero = hero

	local iconPath = self.hero:getIconPath(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
	end

	local heroStar = self.hero.star

	if self.hero.paintLevel and self.hero.paintLevel > 0 then
		self.imgPaint:setVisible(true)
		self.imgPaint:setImage("Atlas/HeroAtlas/HeroCoatingAtlas", "CoatingImgC0" .. self.hero.paintLevel)

		heroStar = self.hero:getMaxStar()
	else
		self.imgPaint:setVisible(false)
	end

	local stepImgInfo = UIConst.getHeroStepPath(heroStar)

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	local starPath = UIConst.getHeroStarPath(heroStar)

	if starPath then
		self.imgHeroStar:setImage(starPath[1], starPath[2])
	end

	if Const.PAINT_PLUS_OPEN then
		local level = self.hero:getPaintPlusShowLevel()

		if level and level ~= 0 then
			self.iconCoating02:setVisible(true)
			self.txtPaintPlusLevel:setText(level)
		else
			self.iconCoating02:setVisible(false)
		end
	end
end

function GridSimpleHeroChild:onBtnSelect()
	if self.clickSelfFunc then
		self.clickSelfFunc(self)
	end
end

return GridSimpleHeroChild
