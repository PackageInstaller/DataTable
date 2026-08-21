-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\GetLightBlackHeroDlg.lua

local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local HeroCVNamePanel = require("UI/HandBook/HeroCVNamePanel")
local strClassName = "GetLightBlackHeroDlg"
local GetLightBlackHeroDlg = Class(strClassName, UIControls.Window)

function GetLightBlackHeroDlg:ctor()
	self:initUI()
end

function GetLightBlackHeroDlg:initUI()
	self.aniSelf = UIControls.UIAni(self, "")
	self.btnBlock = UIControls.Button(self, "Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.imgStar = UIControls.Image(self, "InfoPanel/IconStar")
	self.txtName = UIControls.Label(self, "InfoPanel/BgName/TextName")
	self.imgGroupIcon = UIControls.Image(self, "InfoPanel/IconCamp")
	self.imgCareerIcon = UIControls.Image(self, "InfoPanel/IconJob")

	self.aniSelf:addEventAnimateCue(self.playHeroVocal)

	self.panelCVName = HeroCVNamePanel(self, "InfoPanel/CvPanel")
	self.sharePanel = ShareAchievePanel(self, "SharePanel")
end

function GetLightBlackHeroDlg:setHero(hero)
	self.hero = hero

	local largeStarPath = self.hero:getLargeStarPath()

	if largeStarPath then
		self.imgStar:setImage(largeStarPath[1], largeStarPath[2])
	end

	local careerPath = hero:getCareerPath()

	if careerPath then
		self.imgCareerIcon:setImage(careerPath[1], careerPath[2])
	end

	local groupPath = hero:getGroupPath()

	if groupPath then
		self.imgGroupIcon:setImage(groupPath[1], groupPath[2])
	end

	self.txtName:setText(self.hero.fullName)
	CueManager.stopVocal()

	if self.needSharePanel then
		local hasOpShareAward, opActId = CurAvatar:replaceActivityHasShareAward(hero.id)

		if hasOpShareAward then
			self.sharePanel:setActivityInfo(opActId, "getLightBlackHeroDlg")
		else
			self.sharePanel:setAchieveInfo(Const.ACHIEVE_TYPE_SHARE_LIGHTDRAW, "getLightBlackHeroDlg")
		end
	end

	self.sharePanel:setShareVisible(self.needSharePanel)
	self.panelCVName:setHero(self.hero)
end

function GetLightBlackHeroDlg:playHeroVocal(aniCom, eventKey)
	if eventKey == "CvPlay" then
		CueManager.playHeroVocal(self.hero.id, Const.HERO_VOCAL_GET)
	end
end

function GetLightBlackHeroDlg:setHeroListDic(heroListDic, heroId, fromDraw)
	self.heroListDic = heroListDic
	self.heroId = heroId
	self.needSharePanel = fromDraw or false

	self:setHeroList(self.heroListDic[self.heroId])
end

function GetLightBlackHeroDlg:setHeroList(heroList)
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

function GetLightBlackHeroDlg:onBtnBlockClick()
	if self.heroList and #self.heroList > 0 then
		local aniName = "ShowLightBlackHeroCanvas" .. self.heroId

		self.aniSelf:startAni(aniName, true)
		self:setHero(self.heroList[1])
		table.remove(self.heroList, 1)
	else
		self:setVisible(false)
	end
end

function GetLightBlackHeroDlg:onClose()
	CueManager.stopVocal()

	self.heroListDic[self.heroId] = nil

	local nextHeroId = 0

	for heroId, heroList in pairs(self.heroListDic) do
		if heroId ~= 0 then
			nextHeroId = heroId

			break
		end
	end

	if nextHeroId ~= 0 then
		local uiName = "getLightBlackHeroDlg_" .. nextHeroId
		local getLightBlackHeroDlg = UIManager.getUI(uiName, true)

		getLightBlackHeroDlg:setHeroListDic(self.heroListDic, nextHeroId)
	elseif self.heroListDic[0] then
		local getNewHeroDlg = UIManager.getUI("getNewHeroDlg", true)

		getNewHeroDlg:setHeroList(self.heroListDic[0])
	else
		CurAvatar:showDrawLightResutlDlg(true)
	end

	GetLightBlackHeroDlg.super.onClose(self)
end

return GetLightBlackHeroDlg
