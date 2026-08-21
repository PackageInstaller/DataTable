-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpBpHeroIconCell.lua

local BaseObject = require("Common/Object/BaseObject")
local TopPvpBpHeroIconCell = Class("TopPvpBpHeroIconCell", UIControls.Child)

function TopPvpBpHeroIconCell:ctor()
	self:initUI()
end

function TopPvpBpHeroIconCell:initUI()
	self.imgHeroIcon = UIControls.Image(self, "BgHead/IconHead")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.bgStar = UIControls.Image(self, "BgStar")

	self.bgStar:setVisible(false)

	self.imgStar = UIControls.Image(self, "ImgStar")

	self.imgStar:setVisible(false)

	self.otherInfo = UIControls.Panel(self, "OtherInfo")

	self.otherInfo:setVisible(false)

	if UIControls.checkControlFunc(self, "OtherInfo/IconUR") then
		self.iconUR = UIControls.Panel(self, "OtherInfo/IconUR")
	end
end

function TopPvpBpHeroIconCell:setHero(hero)
	local iconPath = hero:getIconPath(true)

	if iconPath then
		self.imgHeroIcon:setImage(iconPath[1], iconPath[2])
	end

	local stepImgInfo = hero:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	if self.iconUR then
		self.iconUR:setVisible(hero:isURHero())
	end
end

return TopPvpBpHeroIconCell
