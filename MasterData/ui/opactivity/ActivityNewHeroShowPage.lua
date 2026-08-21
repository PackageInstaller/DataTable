-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityNewHeroShowPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResNewHeroMisc = require("ClientData/ResNewHeroMisc")
local ResHero = require("ClientData/ResHero")
local HeroCVNamePanel = require("UI/HandBook/HeroCVNamePanel")
local UIControls = UIControls
local ActivityNewOneHeroPanel = Class("ActivityNewOneHeroPanel", UIControls.Panel)

function ActivityNewOneHeroPanel:ctor()
	self.textHeroName = UIControls.Label(self, self.mPath .. "/TextHeroName")
	self.btnHero = UIControls.Button(self, self.mPath .. "/TextHeroName/BtnHero")

	self.btnHero:addEventClick(self.onBtnHeroClick)

	self.imgHeroClass = UIControls.Image(self, self.mPath .. "/ImgClass")
	self.panelHeroCv = HeroCVNamePanel(self, self.mPath .. "/CvPanel")
	self.imgHeroGroup = UIControls.Image(self, self.mPath .. "/ImgFaction")
	self.textHeroSlogan = UIControls.Label(self, self.mPath .. "/TextSlogan")
end

function ActivityNewOneHeroPanel:setHero(heroId)
	self.heroId = heroId

	self.panelHeroCv:setHero(BaseObject.GetObject(heroId))
	self.panelHeroCv:setVisible(true)

	local heroData = ResHero[heroId]

	self.textHeroName:setText(heroData.hero_name or "")

	local careerPath = UIConst.getHeroCareerIconPath(heroData.career)

	if careerPath then
		self.imgHeroClass:setImage(careerPath[1], careerPath[2])
	end

	local campPath = UIConst.getHeroCampIconPath(heroData.camp)

	if campPath then
		self.imgHeroGroup:setImage(campPath[1], campPath[2])
	end

	local heroMiscData = ResNewHeroMisc[heroId] or {}

	self.textHeroSlogan:setText(heroMiscData.propagate_str or "")
end

function ActivityNewOneHeroPanel:onBtnHeroClick()
	if self.heroId then
		BaseObject.ShowObjectTips(self.heroId, 1, self)
	end
end

local classNameStr = "ActivityNewHeroShowPage"
local ActivityNewHeroShowPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityNewHeroShowPage, ActivityPanelMixin)

function ActivityNewHeroShowPage:initUI()
	self.panelHero1 = ActivityNewOneHeroPanel(self, "HeroPanel1")
	self.panelHero2 = ActivityNewOneHeroPanel(self, "HeroPanel2")

	if UIControls.checkControlFunc(self, "BgStar") then
		self.heroStarNml = UIControls.Image(self, "BgStar/HeroStarNml")
		self.heroStarVanity = UIControls.Image(self, "BgStar/HeroStarVanity")
	end
end

function ActivityNewHeroShowPage:_setData()
	self.showArgs = self.clientTemplateData.template_args or {}

	self.panelHero1:setHero(tonumber(self.showArgs[1]))
	self.panelHero2:setHero(tonumber(self.showArgs[2]))

	if self.heroStarNml and self.heroStarVanity then
		local hero1 = CurAvatar:getHeroMaxStarHero(tonumber(self.showArgs[1]))
		local atlas = "Atlas/HeroAtlas/HeroAtlas"

		if hero1 then
			local imgName

			if hero1.star >= 10 then
				imgName = "IconStarL" .. hero1.star
			else
				imgName = "IconStarL0" .. hero1.star
			end

			self.heroStarNml:setImage(atlas, imgName)
			self.heroStarVanity:setImage(atlas, imgName)
		else
			self.heroStarNml:setImage(atlas, "IconStarL05")
			self.heroStarVanity:setImage(atlas, "IconStarL05")
		end
	end
end

return ActivityNewHeroShowPage
