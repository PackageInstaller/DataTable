-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\BtnStepUpCell.lua

local ResColor = require("ClientData/ResColor")
local ResStep = require("ClientData/ResStep")
local SkillUpCell = require("UI/Hero/ContentPanel/SkillUpCell")
local StepUpDonePanel = require("UI/Hero/ContentPanel/StepUpDonePanel")
local ResStepDes = require("ClientData/ResStepDes")
local ResItem = require("ClientData/ResItem")
local StepUpChild = require("UI/Hero/ContentPanel/StepUpChild")
local strClassName = "BtnStepUpCell"
local BtnStepUpCell = Class(strClassName, UIControls.ScrollViewLoopCell)
local UNLOCK = 1
local CAN_UNLOCK = 2
local UNOPEN = 3

function BtnStepUpCell:ctor()
	self:initUI()
end

function BtnStepUpCell:initUI()
	self.imgBg = UIControls.Image(self, "Bg")
	self.txtDes = UIControls.Label(self, "StageUpCell/TextDes")
	self.txtStepNum = UIControls.Label(self, "StageUpCell/TextStageNum")
	self.txtStepNumBig2 = UIControls.Label(self, "StageUpCell/TextStageNumBig/Text")
	self.txtTitle = UIControls.Label(self, "StageUpCell/TextTitle")
	self.txtCondition = UIControls.Label(self, "StageUpCell/TextCondition")
	self.btnGo = UIControls.Button(self, "StageUpCell/TextCondition/BtnGo")

	self.btnGo:addEventClick(self.onBtnGoClick)

	self.skillPanel = SkillUpCell(self, "SkillUpCell")
end

function BtnStepUpCell:onBtnGoClick()
	self.mWindow.heroContentPanel:selectTab(Const.HERO_CONTENT_PANEL.BASE_INFO)
end

function BtnStepUpCell:setHero(hero, step)
	self.hero = hero
	self.step = step

	if not ResStepDes[self.hero.id] or not ResStepDes[self.hero.id][self.step] then
		return
	end

	self.stepDesInfo = ResStepDes[self.hero.id][self.step]

	self.txtDes:setText(self.stepDesInfo.desc)
	self.txtStepNum:setText(self.stepDesInfo.step_name)
	self.txtTitle:setText(self.stepDesInfo.title)

	if self.hero.step >= self.step then
		self.status = UNLOCK
	elseif self.hero.step == self.step - 1 and self.hero.level >= ResStep[self.step].level_limit then
		self.status = CAN_UNLOCK
	else
		self.status = UNOPEN
	end

	local STAGE_ATLAS = "Atlas/HeroAtlas/HeroStageUpAtlas"

	self.skillPanel:setHero(self.hero, self.step)

	if self.status == UNLOCK then
		self.txtCondition:setVisible(false)

		if not self.stepUpDoneChild then
			self.stepUpDoneChild = StepUpDonePanel(self, "StageUpCell/StageUpPanel", "System/Hero/StageUpDone", 0, 0, true)
		end

		self.stepUpDoneChild:setData(self.stepDesInfo)

		if self.stepUpChild then
			self.stepUpChild:destroy()

			self.stepUpChild = nil
		end

		self.txtDes:setVisible(true)
		self.txtDes:setFontColor(ResColor.WHITE)
		self.imgBg:setImage(STAGE_ATLAS, "BgStageNml")
	elseif self.status == CAN_UNLOCK then
		self.txtCondition:setVisible(false)

		if self.stepUpDoneChild then
			self.stepUpDoneChild:destroy()

			self.stepUpDoneChild = nil
		end

		self.imgBg:setImage(STAGE_ATLAS, "BgStageSel")

		local isShowDes = RegionUtils.isCN() or RegionUtils.isTW()

		self.txtDes:setVisible(isShowDes)
		self.txtDes:setFontColor(ResColor.WHITE)

		if not self.stepUpChild then
			self.stepUpChild = StepUpChild(self, "StageUpCell/StageUpPanel", "System/Hero/StageUp", 0, 0, true)
		end

		self.stepUpChild:setHero(self.hero, self.step, true)
	else
		self.txtCondition:setVisible(true)
		self.txtCondition:setText(string.format(Lang.get(30369), ResStep[self.step].level_limit))

		if self.stepUpDoneChild then
			self.stepUpDoneChild:destroy()

			self.stepUpDoneChild = nil
		end

		self.txtDes:setVisible(false)
		self.imgBg:setImage(STAGE_ATLAS, "BgStageDis")

		if self.step == self.hero.step + 1 then
			if not self.stepUpChild then
				self.stepUpChild = StepUpChild(self, "StageUpCell/StageUpPanel", "System/Hero/StageUp", 0, 0, true)
			end

			self.stepUpChild:setHero(self.hero, self.step)
			self.txtDes:setVisible(true)
			self.txtDes:setText(Lang.get(30370))
		elseif self.stepUpChild then
			self.stepUpChild:destroy()

			self.stepUpChild = nil
		end
	end
end

function BtnStepUpCell:refreshForBtnState()
	if self.status == CAN_UNLOCK and self.stepUpChild then
		self.stepUpChild:refreshBtnState()
	end
end

function BtnStepUpCell:destroy()
	self.skillPanel.skillTips = nil

	BtnStepUpCell.super.destroy(self)
end

function BtnStepUpCell:onClear()
	BtnStepUpCell.super.onClear(self)
	self.skillPanel.panelSkillEfx:setVisible(false)
end

return BtnStepUpCell
