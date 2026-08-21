-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\RelatedGridHeroMixin.lua

local strClassName = "RelatedGridHeroMixin"
local RelatedGridHeroMixin = {}

function RelatedGridHeroMixin:ctorMixin()
	self:initUI()
end

function RelatedGridHeroMixin:initUI()
	self.panelSelf = UIControls.Panel(self, "")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgHead = UIControls.Image(self, "BgHead/IconHead")
	self.imgStar = UIControls.Image(self, "ImgStar")
	self.textName = UIControls.Label(self, "OtherInfo/TextName")
	self.imgStarColor = UIControls.Image(self, "ImgStarColor")
	self.imgGroup = UIControls.Image(self, "OtherInfo/IconGroup")
	self.imgCareer = UIControls.Image(self, "OtherInfo/IconCareer")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)
end

function RelatedGridHeroMixin:setHero(heroId)
	self.heroId = heroId
	self.hasHero = CurAvatar:getHeroCountByResId(heroId) > 0

	if self.hasHero then
		self.hero = CurAvatar:getHeroMaxStarHero(heroId)
	else
		self.hero = BaseObject.GetObject(heroId)
	end

	self.textName:setText(self.hero.name or "")

	local iconPath = self.hero:getIconPath(true)

	if iconPath then
		self.imgHead:setImage(iconPath[1], iconPath[2])
	end

	local stepImgInfo = self.hero:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	local star = CurAvatar:getHeroMaxStar(heroId)
	local starPath = UIConst.getHeroStarPath(star)

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end

	self.panelSelf:setObjGray(not self.hasHero, true)

	if self.hasHero then
		local color = UIConst.getHeroStarColor(star)

		if color then
			self.imgStarColor:setObjColor(color)
		end
	end

	local groupPath = self.hero:getGroupPath()

	if groupPath then
		self.imgGroup:setImage(groupPath[1], groupPath[2])
	end

	local careerPath = self.hero:getCareerPath()

	if careerPath then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
	end
end

function RelatedGridHeroMixin:onSensorClick()
	if self.mEventClick then
		self.mEventClick(self)
	end
end

return RelatedGridHeroMixin
