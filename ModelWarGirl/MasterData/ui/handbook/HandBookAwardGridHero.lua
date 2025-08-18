-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookAwardGridHero.lua

local strClassName = "HandBookAwardGridHero"
local HandBookAwardGridHero = Class(strClassName, UIControls.Child)

function HandBookAwardGridHero:ctor()
	self:initUI()
end

function HandBookAwardGridHero:initUI()
	self.imgIcon = UIControls.Image(self, "Icon")
	self.imgStar = UIControls.Image(self, "ImgStar")
	self.txtName = UIControls.Label(self, "TextName")
	self.imgState = UIControls.Image(self, "ImgState")
	self.imgQuality = UIControls.Image(self, "ImgQuality")

	if UIControls.checkControlFunc(self, "IconUR") then
		self.iconUR = UIControls.Panel(self, "IconUR")
	end
end

function HandBookAwardGridHero:setHero(hero)
	self.hero = hero

	local iconPath = hero:getIconPath(true)

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	local starPath = hero:getStarPath()

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end

	local stepImgInfo = self.hero:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	self.txtName:setText(hero.name)
	self.imgState:setVisible(not CurAvatar.handBookHeroDic[self.hero.id])

	if self.iconUR then
		self.iconUR:setVisible(self.hero:isURHero())
	end
end

return HandBookAwardGridHero
