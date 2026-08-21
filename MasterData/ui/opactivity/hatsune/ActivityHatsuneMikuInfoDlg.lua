-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Hatsune\\ActivityHatsuneMikuInfoDlg.lua

local ResOpActivityHatsuneMisc = require("ClientData/ResOpActivityHatsuneMisc")
local strClassName = "ActivityHatsuneMikuInfoDlg"
local ActivityHatsuneMikuInfoDlg = Class(strClassName, UIControls.Window)

function ActivityHatsuneMikuInfoDlg:ctor()
	self.textDes = UIControls.Label(self, "MainInfoPanel/DesPanel/TextDes")
	self.imgStar = UIControls.Image(self, "MainInfoPanel/ImgHero14102/ImgStar")
	self.imgVanityStar = UIControls.Image(self, "MainInfoPanel/ImgHero12107/ImgStar")
end

function ActivityHatsuneMikuInfoDlg:setData(actObj)
	self.actObj = actObj

	self.textDes:setText(self.actObj.actData.miscData.info_desc or "")

	self.heroId = self.actObj.actData.miscData.hero_id

	local hero = CurAvatar:getHeroMaxStarHero(self.heroId)
	local atlas = "Atlas/HeroAtlas/HeroAtlas"

	if hero then
		local imgName

		if hero.star >= 10 then
			imgName = "IconStarL" .. hero.star
		else
			imgName = "IconStarL0" .. hero.star
		end

		self.imgStar:setImage(atlas, imgName)
		self.imgVanityStar:setImage(atlas, imgName)
	else
		self.imgStar:setImage(atlas, "IconStarL05")
		self.imgVanityStar:setImage(atlas, "IconStarL05")
	end
end

return ActivityHatsuneMikuInfoDlg
