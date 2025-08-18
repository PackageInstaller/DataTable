-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\HeroTipsInfoPanel.lua

local HeroSkillSingleTips = require("UI/Common/Tips/HeroSkillSingleTips")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local HeroTipsInfoPanel = Class("HeroTipsInfoPanel", UIControls.Child)
local ResColor = require("ClientData/ResColor")

function HeroTipsInfoPanel:ctor()
	local infoPath = "BgBasicInfo/InfoPanel"

	self.txtLv = UIControls.Label(self, infoPath .. "/TextLv")
	self.txtName = UIControls.Label(self, infoPath .. "/TextName")
	self.imgIcon = UIControls.Image(self, infoPath .. "/BgHead/IconHead")
	self.imgIconStepBg = UIControls.Image(self, infoPath .. "/BgHead/Bg")
	self.imgStepBg = UIControls.Image(self, infoPath .. "/TextName/BgStageLv")
	self.txtStepLv = UIControls.Label(self, infoPath .. "/TextName/BgStageLv/Text")
	self.imgCareer = UIControls.Image(self, infoPath .. "/IconCareer")
	self.txtCareer = UIControls.Label(self, infoPath .. "/IconCareer/Text")
	self.imgGroup = UIControls.Image(self, infoPath .. "/IconGroup")
	self.txtGroup = UIControls.Label(self, infoPath .. "/IconGroup/Text")
	self.imgStar = UIControls.Image(self, infoPath .. "/ImgStar")
	self.imgQuality = UIControls.Image(self, infoPath .. "/BgHead/ImgQuality")
	self.imgBgLine = UIControls.Image(self, "BgBasicInfo/BgWhite/BgLine")
	self.btnJump = UIControls.Button(self, "BgBasicInfo/BtnInfo")

	self.btnJump:addEventClick(self.onClickJump)

	self.scrollSkillList = UIControls.ScrollView(self, "SkillList")
	self.tipsSkillList = {}

	if UIControls.checkControlFunc(self, infoPath .. "/ImgCrystalLv") then
		self.panelCrystalLv = UIControls.Panel(self, infoPath .. "/ImgCrystalLv")
		self.textCrystalLv = UIControls.Label(self, infoPath .. "/ImgCrystalLv/TextCrystalLv")
		self.textCrystalOldLv = UIControls.Label(self, infoPath .. "/ImgCrystalLv/TextOldLv")
	end

	self.LosderPanelList = {}

	if UIControls.checkControlFunc(self, infoPath .. "/LosderTitlePanel") then
		self.losderTitlePanel = UIControls.Panel(self, infoPath .. "/LosderTitlePanel")

		for i = 1, 3 do
			local losderPanel = UIControls.Panel(self, infoPath .. "/LosderTitlePanel/LosderPanel" .. i)
			local iconLosder = UIControls.Image(self, infoPath .. "/LosderTitlePanel/LosderPanel" .. i .. "/IconLosder")
			local textLosderName = UIControls.Label(self, infoPath .. "/LosderTitlePanel/LosderPanel" .. i .. "/TextLosderName")
			local textLosderName = UIControls.Label(self, infoPath .. "/LosderTitlePanel/LosderPanel" .. i .. "/TextLosderName")
			local bgLosder = UIControls.Image(self, infoPath .. "/LosderTitlePanel/LosderPanel" .. i .. "/Bg")

			table.insert(self.LosderPanelList, {
				losderPanel = losderPanel,
				icon = iconLosder,
				name = textLosderName,
				bg = bgLosder
			})
		end
	end
end

function HeroTipsInfoPanel:setHero(hero)
	self.hero = hero

	local lvColor = self.hero:getLvColor()

	if self.panelCrystalLv and self.hero.crystalSecondLevel and self.hero.crystalSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.txtLv:setVisible(false)

		if Const.REVIEW_VERSION then
			self.textCrystalOldLv:setText(Lang.get(1203) .. hero:getShowLv())
		else
			self.textCrystalOldLv:setText("LV." .. hero:getShowLv())
		end

		self.textCrystalOldLv:setFontColor(lvColor)
		self.textCrystalLv:setText(math.floor(self.hero.crystalSecondLevel / 10))
	else
		if self.panelCrystalLv then
			self.panelCrystalLv:setVisible(false)
			self.txtLv:setVisible(true)
		end

		if Const.REVIEW_VERSION then
			self.txtLv:setText(Lang.get(1203) .. hero:getShowLv())
		else
			self.txtLv:setText("LV." .. hero:getShowLv())
		end

		self.txtLv:setFontColor(lvColor)
	end

	self.txtName:setText(hero.name)
	self.txtCareer:setText(hero.careerName)
	self.txtGroup:setText(hero.groupName)

	local stepImgIdx = ResStarUpCondition[self.hero.star].step_img_idx or 1
	local color = self.hero:getQualityColor(stepImgIdx)

	self.imgBgLine:setObjColor(color)

	local iconPath = hero:getIconPath(true)

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	local stepImgInfo = self.hero:getStepImgPath()

	if stepImgInfo then
		self.imgQuality:setImage(stepImgInfo[1], stepImgInfo[2])
	end

	self.hero:setHeroStepUI(self.imgStepBg, self.txtStepLv)

	local careerPath = hero:getCareerPath()

	if careerPath then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
	end

	local groupPath = hero:getGroupPath()

	if groupPath then
		self.imgGroup:setImage(groupPath[1], groupPath[2])
	end

	local starPath = hero:getStarPath()

	if starPath then
		self.imgStar:setVisible(true)
		self.imgStar:setImage(starPath[1], starPath[2])
	else
		self.imgStar:setVisible(false)
	end

	for i = 1, 4 do
		if self.hero[Const.SKILL_FIELD_LIST[i]] then
			if not self.tipsSkillList[i] then
				local skillTips = HeroSkillSingleTips(self, "SkillList/Content", "System/Common/Tips/SkillTipsInfoSinglePanel", 0, 0, true)

				skillTips.isInHeroTips = true
				self.tipsSkillList[i] = skillTips
			end

			self.tipsSkillList[i]:setSkillBySkill(self.hero[Const.SKILL_FIELD_LIST[i]], self.hero)
			self.tipsSkillList[i]:hideLevelUpPanel()
		elseif self.tipsSkillList[i] then
			self.tipsSkillList[i]:destroy()

			self.tipsSkillList[i] = nil
		end
	end
end

function HeroTipsInfoPanel:setLosderData(heroId, hero)
	if self.losderTitlePanel then
		self.losderTitlePanel:setVisible(true)

		if hero then
			local solderList = hero:getMazeSolderState()

			for i = 1, 3 do
				if solderList[i] then
					self.LosderPanelList[i].losderPanel:setVisible(true)

					local solderId = solderList[i].id

					if ResNewMazeFettersType[solderId] then
						local data = ResNewMazeFettersType[solderId][1]

						self.LosderPanelList[i].icon:setImage(data.icon_path, data.icon_name)
						self.LosderPanelList[i].name:setText(data.name)
					end

					if solderList[i].isDefault then
						self.LosderPanelList[i].bg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", "BgFetter1")
					else
						self.LosderPanelList[i].bg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", "BgFetter2")
					end
				else
					self.LosderPanelList[i].losderPanel:setVisible(false)
				end
			end
		else
			local labelList = {}

			if ResNewMazeHero[heroId] then
				local heroData = ResNewMazeHero[heroId]

				if heroData.team_label then
					table.insert(labelList, heroData.team_label)
				end

				if heroData.feature_label1 then
					table.insert(labelList, heroData.feature_label1)
				end

				if heroData.feature_label2 then
					table.insert(labelList, heroData.feature_label2)
				end
			end

			for i = 1, 3 do
				if labelList[i] then
					self.LosderPanelList[i].losderPanel:setVisible(true)

					if ResNewMazeFettersType[labelList[i]] then
						local data = ResNewMazeFettersType[labelList[i]][1]

						self.LosderPanelList[i].icon:setImage(data.icon_path, data.icon_name)
						self.LosderPanelList[i].name:setText(data.name)
						self.LosderPanelList[i].bg:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", "BgFetter1")
					end
				else
					self.LosderPanelList[i].losderPanel:setVisible(false)
				end
			end
		end
	end
end

function HeroTipsInfoPanel:showJumpBtn(v)
	self.btnJump:setVisible(v)
end

function HeroTipsInfoPanel:onClickJump()
	if self.hero.gid then
		JumpGuideManager.jump(Const.HERO_CONTENT_PANEL.BASE_INFO, "heroTips", self.hero.gid)
	end

	self.mWindow:setVisible(false)
end

return HeroTipsInfoPanel
