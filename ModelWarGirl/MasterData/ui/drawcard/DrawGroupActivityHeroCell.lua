-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawGroupActivityHeroCell.lua

local ResNewHeroMisc = require("ClientData/ResNewHeroMisc")
local ResHero = require("ClientData/ResHero")
local strClassName = "DrawGroupActivityHeroCell"
local DrawGroupActivityHeroCell = Class(strClassName, UIControls.Panel)

function DrawGroupActivityHeroCell:ctor()
	self:initUI()
end

function DrawGroupActivityHeroCell:initUI()
	self.textSlogan = UIControls.Label(self, self.mPath .. "/BgSlogan/Text")
	self.textName = UIControls.Label(self, self.mPath .. "/BgInfo/Text")
	self.imgCareer = UIControls.Image(self, self.mPath .. "/BgInfo/IconCareer")
	self.imgGroup = UIControls.Image(self, self.mPath .. "/BgInfo/IconGroup")
end

function DrawGroupActivityHeroCell:setHero(heroId)
	local heroMiscData = ResNewHeroMisc[heroId] or {}

	self.textSlogan:setText(heroMiscData.draw_slogan or "")
	self.textName:setText(heroMiscData.draw_name or "")

	local heroData = ResHero[heroId]
	local careerPath = UIConst.getHeroCareerIconPath(heroData.career)

	if careerPath then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
	end

	local campPath = UIConst.getHeroCampIconPath(heroData.camp)

	if campPath then
		self.imgGroup:setImage(campPath[1], campPath[2])
	end
end

return DrawGroupActivityHeroCell
