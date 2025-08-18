-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\SkillUpCell.lua

local ResRechargeCost = require("ClientData/ResRechargeCost")
local ResHeroRecharge = require("ClientData/ResHeroRecharge")
local ResStep = require("ClientData/ResStep")
local HeroSkill = require("Common/Object/HeroSkill")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local ResColor = require("ClientData/ResColor")
local ResStepDes = require("ClientData/ResStepDes")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local strClassName = "SkillUpCell"
local SkillUpCell = Class(strClassName, UIControls.Panel)
local UNLOCK = 1
local CAN_UNLOCK = 2
local UNOPEN = 3

function SkillUpCell:ctor()
	self:initUI()
end

function SkillUpCell:initUI()
	self.imgBg = UIControls.Image(self, self.mPath .. "/Bg")
	self.txtCurSkillLevel = UIControls.Label(self, self.mPath .. "/TextSKillNum/TextSKillNumBefore")
	self.txtTargetSkillLevel = UIControls.Label(self, self.mPath .. "/TextSKillNum")
	self.txtSkillLevelLock = UIControls.Label(self, self.mPath .. "/TextSKillNum/TextSKillNumBefore/TextSKillLock")
	self.txtSkillDes = UIControls.Label(self, self.mPath .. "/SkillUpState/Bg01/Text")
	self.panelSkillUpState = UIControls.Panel(self, self.mPath .. "/SkillUpState")
	self.imgSkillState = UIControls.Panel(self, self.mPath .. "/TextSkillState")
	self.panelSkillEfx = UIControls.LazyEffectPlayer(self, self.mPath .. "/SkillEfxPanel")
	self.txtName = UIControls.Label(self, self.mPath .. "/TextName")
	self.btnMore = UIControls.Button(self, "BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.skillMaterialGridList = {}
end

function SkillUpCell:setHero(hero, recharge)
	self.hero = hero
	self.recharge = recharge

	local rechargeTimes = ResStep[self.hero.step] and ResStep[self.hero.step].recharge_times or 0

	if self.hero.step >= self.recharge then
		self.status = UNLOCK
	elseif self.recharge - 1 == self.hero.step and rechargeTimes >= self.recharge then
		self.status = UNOPEN
	else
		self.status = UNOPEN
	end

	self:initSkillInfo()
	self:refreshSkillInfoShow()

	local STAGE_ATLAS = "Atlas/HeroAtlas/HeroStageUpAtlas"

	self.txtName:setText(self.skill.name)

	if utils.utf8len(self.skill.desc, 1) <= 70 then
		self.txtSkillDes:setText(self.skill.desc)
	else
		local desc = utils.utf8Substring(self.skill.desc, 1, 70)

		if desc then
			self.txtSkillDes:setText(desc .. "...")
		else
			self.txtSkillDes:setText(self.skill.desc)
		end
	end

	if self.skill.level == 1 then
		if self.status ~= UNLOCK or not Lang.get(152) then
			local getStr = Lang.get(519)
		end
	else
		local lastDesc = ""
		local upDesc = ""

		if self.skill.isPassive then
			lastDesc = ResPassiveSkill[self.skill.id][self.skill.level - 1].desc
			upDesc = "↑" .. ResPassiveSkill[self.skill.id][self.skill.level].battle_desc
		else
			lastDesc = ResSkillConfig[self.skill.id][self.skill.level - 1].skill_desc
			upDesc = "↑" .. ResSkillConfig[self.skill.id][self.skill.level].battle_desc
		end
	end

	if self.status == UNLOCK then
		self.panelSkillUpState:setVisible(true)
		self.txtSkillDes:setFontColor(ResColor.WHITE)
		self.imgBg:setImage(STAGE_ATLAS, "BgStageNml")
	elseif self.status == CAN_UNLOCK then
		self.panelSkillEfx:setVisible(false)
		self.panelSkillUp:setVisible(true)
		self.panelSkillUpState:setVisible(false)
		self:refreshSkillMaterialInfo()
		self.imgBg:setImage(STAGE_ATLAS, "BgStageSel")
		self.txtSkillDes:setFontColor(ResColor.WHITE)
	else
		self.panelSkillUpState:setVisible(true)
		self.txtSkillDes:setFontColor(ResColor.GREYLIGHT)

		local levelNeedStr = self.skillLevel - 1 ~= 0 and utils.format(Lang.get(30385), self.skill.name, self.skillLevel - 1) or ""
		local needStep = CurAvatar:getRechargeNeedStep(self.recharge)
		local stepNeedStr = needStep ~= 0 and string.format(Lang.get(30386), ResStepDes[self.hero.id][needStep].step_name) or ""

		self.imgBg:setImage(STAGE_ATLAS, "BgStageDis")
	end
end

function SkillUpCell:onBtnMoreClick()
	local heroStageUpSkillDetailDlg = UIManager.getUI("heroStageUpSkillDetailDlg", true)

	heroStageUpSkillDetailDlg:setSkillInfo(self.skill)
end

function SkillUpCell:refreshSkillInfoShow()
	if self.skillLevel == 1 then
		self.txtCurSkillLevel:setText("")
		self.txtSkillLevelLock:setText(string.format(Lang.get(30387), self.skill.name))
		self.txtSkillLevelLock:setVisible(true)
		self.imgSkillState:setVisible(true)
		self.txtTargetSkillLevel:setVisible(false)
	else
		self.txtCurSkillLevel:setText(self.skillLevel - 1)
		self.txtSkillLevelLock:setVisible(false)
		self.imgSkillState:setVisible(false)
		self.txtTargetSkillLevel:setVisible(true)
		self.txtTargetSkillLevel:setText(self.skillLevel)
	end
end

function SkillUpCell:initSkillInfo()
	for skillField, lvField in pairs(Const.HERO_SKILL_LEVEL_FIELD_DIC) do
		if self.recharge == 1 then
			local oriLevel = 0

			if skillField == Const.HERO_SKILL_FIELD.ATTACK or skillField == Const.HERO_SKILL_FIELD.SKILL then
				oriLevel = 1
			end

			if ResHeroRecharge[self.recharge][Const.HERO_SKILL_LEVEL_FIELD_DIC[skillField]] == oriLevel + 1 then
				self.skillField = skillField

				if self.hero[skillField] then
					self.skillId = self.hero[skillField].id
				end

				self.skillLevel = oriLevel + 1
			end
		else
			local levelField = Const.HERO_SKILL_LEVEL_FIELD_DIC[skillField]

			if ResHeroRecharge[self.recharge][levelField] - ResHeroRecharge[self.recharge - 1][levelField] ~= 0 then
				self.skillField = skillField

				if self.hero[skillField] then
					self.skillId = self.hero[skillField].id
				end

				self.skillLevel = ResHeroRecharge[self.recharge][levelField]
			end
		end
	end

	self.skill = HeroSkill(self.skillId, self.skillLevel, self.skillField)

	if not self.skillGrid then
		self.skillGrid = UIControls.HeroSkillGridChild(self, self.mPath .. "/GridSkillPanel", "System/Hero/GridHeroSkill", 0, 0, true)

		self.skillGrid.btnSelf:setEnable(false)
	end

	self.skillGrid:setObj(self.skill, self.hero)
end

function SkillUpCell:onBtnSkillTipsSensor()
	if self.skillTips then
		self.skillTips:setVisible(false)
		self.btnSkillTipsSensor:setVisible(false)
	end
end

function SkillUpCell:refreshSkillMaterialInfo()
	for k, v in pairs(self.skillMaterialGridList) do
		self.skillMaterialGridList[k]:destroy()
	end

	self.lackInfo = {}
	self.stepCostInfo = ResRechargeCost[self.recharge]

	if self.stepCostInfo.materials then
		for i, v in ipairs(self.stepCostInfo.materials) do
			local materialGrid = MaterialItemGridChild(self, self.mPath .. "/SkillUp/MaterialList", "System/Common/Grid/GridMaterialItem", 0, 0, true)
			local enough = materialGrid:setMaterial(v.id, v.num)

			materialGrid.imgAdd:setVisible(not enough)

			if not enough then
				table.insert(self.lackInfo, Lang.get(30293))
			end

			materialGrid.hero = self.hero
			self.skillMaterialGridList[i] = materialGrid
		end
	end
end

return SkillUpCell
