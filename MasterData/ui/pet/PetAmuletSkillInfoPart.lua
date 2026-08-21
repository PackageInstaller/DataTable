-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetAmuletSkillInfoPart.lua

local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local ResColor = require("ClientData/ResColor")
local strClassName = "PetAmuletSkillInfoPart"
local PetAmuletSkillInfoPart = Class(strClassName, UIControls.Panel)

function PetAmuletSkillInfoPart:ctor()
	self:initUI()
end

function PetAmuletSkillInfoPart:initUI()
	self.skillPanel = {}

	for i = 1, 2 do
		local panelSkill = UIControls.Panel(self, self.mPath .. "/Skill0" .. i)
		local imgIcon

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/Image") then
			imgIcon = UIControls.Image(self, self.mPath .. "/Skill0" .. i .. "/Image")
		end

		local imgSkill

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/ImgSkill") then
			imgSkill = UIControls.Image(self, self.mPath .. "/Skill0" .. i .. "/ImgSkill")
		end

		local textTitle = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextTitle")
		local textInfo

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/ScrollRect/Content/TextInfo") then
			textInfo = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/ScrollRect/Content/TextInfo")
		else
			textInfo = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextInfo")
		end

		local textEnNum, textEnSpeedNum, textEnSpeedTitle

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum") then
			textEnNum = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum")
			textEnSpeedNum = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum2")
		end

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum/TextTitle") then
			textEnSpeedTitle = UIControls.Label(self, self.mPath .. "/Skill0" .. i .. "/TextEnNum/TextTitle")
		end

		local noEffect

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/NoEffect") then
			noEffect = UIControls.Panel(self, self.mPath .. "/Skill0" .. i .. "/NoEffect")
		end

		local imgBg

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/BgSkillName") then
			imgBg = UIControls.Image(self, self.mPath .. "/Skill0" .. i .. "/BgSkillName")
		end

		local efx

		if UIControls.checkControlFunc(self, self.mPath .. "/Skill0" .. i .. "/Efx") then
			efx = UIControls.LazyEffectPlayer(self, self.mPath .. "/Skill0" .. i .. "/Efx")
		end

		table.insert(self.skillPanel, {
			panelSkill = panelSkill,
			imgSkill = imgSkill,
			textTitle = textTitle,
			textInfo = textInfo,
			textEnSpeedNum = textEnSpeedNum,
			textEnNum = textEnNum,
			noEffect = noEffect,
			imgIcon = imgIcon,
			textEnSpeedTitle = textEnSpeedTitle,
			imgBg = imgBg,
			efx = efx
		})
	end
end

function PetAmuletSkillInfoPart:setData(amulet)
	self.amulet = amulet

	if self.amulet.mainSkill then
		local skillData = ResSkillConfig[self.amulet.mainSkill][self.amulet.star]

		self.skillPanel[1].textTitle:setText(skillData.name or "")
		self.skillPanel[1].textInfo:setText(skillData.skill_desc or "")

		if self.skillPanel[1].imgSkill and skillData.icon_path then
			self.skillPanel[1].imgSkill:setImage(skillData.icon_path, skillData.icon)
		end

		if self.skillPanel[1].textEnNum and self.skillPanel[1].textEnSpeedNum then
			self.skillPanel[1].textEnNum:setText(self.amulet.initMana or 0)
			self.skillPanel[1].textEnSpeedNum:setText(string.format(Lang.get(73228), self.amulet.manaGen))
			self.skillPanel[1].textEnNum:setVisible(true)
			self.skillPanel[1].textEnSpeedNum:setVisible(true)
		end
	end

	if self.amulet.assistantSkill then
		local skillData = ResPassiveSkill[self.amulet.assistantSkill][self.amulet.star]

		self.skillPanel[2].textTitle:setText(skillData.name or "")
		self.skillPanel[2].textInfo:setText(skillData.desc or "")

		if self.skillPanel[2].imgSkill and skillData.icon_path then
			self.skillPanel[2].imgSkill:setImage(skillData.icon_path, skillData.icon)
		end

		self.skillPanel[2].panelSkill:setVisible(true)
	else
		self.skillPanel[2].panelSkill:setVisible(false)
	end
end

function PetAmuletSkillInfoPart:setNoEffectSkillByPos(pos)
	if self.skillPanel[1].noEffect and self.skillPanel[2].noEffect then
		if pos == 1 then
			self.skillPanel[1].noEffect:setVisible(true)
			self.skillPanel[2].noEffect:setVisible(false)

			if self.skillPanel[2].imgIcon then
				self.skillPanel[2].imgIcon:setImageGray(true)
			end

			if self.skillPanel[2].imgBg then
				self.skillPanel[2].imgBg:setImageGray(true)
			end

			self.skillPanel[2].textTitle:setFontColor(ResColor.GREYLIGHT)
			self.skillPanel[2].textInfo:setFontColor(ResColor.GREYLIGHT)

			if self.skillPanel[2].textEnNum and self.skillPanel[2].textEnSpeedNum then
				self.skillPanel[2].textEnNum:setFontColor(ResColor.GREYLIGHT)
				self.skillPanel[2].textEnSpeedNum:setFontColor(ResColor.GREYLIGHT)
			end

			if self.skillPanel[2].textEnSpeedTitle then
				self.skillPanel[2].textEnSpeedTitle:setFontColor(ResColor.GREYLIGHT)
			end
		else
			self.skillPanel[1].noEffect:setVisible(false)
			self.skillPanel[2].noEffect:setVisible(true)

			if self.skillPanel[1].imgIcon then
				self.skillPanel[1].imgIcon:setImageGray(true)
			end

			if self.skillPanel[1].imgBg then
				self.skillPanel[1].imgBg:setImageGray(true)
			end

			self.skillPanel[1].textTitle:setFontColor(ResColor.GREYLIGHT)
			self.skillPanel[1].textInfo:setFontColor(ResColor.GREYLIGHT)

			if self.skillPanel[1].textEnNum and self.skillPanel[1].textEnSpeedNum then
				self.skillPanel[1].textEnNum:setFontColor(ResColor.GREYLIGHT)
				self.skillPanel[1].textEnSpeedNum:setFontColor(ResColor.GREYLIGHT)
			end

			if self.skillPanel[1].textEnSpeedTitle then
				self.skillPanel[1].textEnSpeedTitle:setFontColor(ResColor.GREYLIGHT)
			end
		end
	end
end

function PetAmuletSkillInfoPart:playStarUpEfx()
	if self.skillPanel[1].efx and self.amulet.mainSkill then
		self.skillPanel[1].efx:setVisible(false)
		self.skillPanel[1].efx:setVisible(true)
	end

	if self.skillPanel[2].efx and self.amulet.assistantSkill then
		self.skillPanel[2].efx:setVisible(false)
		self.skillPanel[2].efx:setVisible(true)
	end
end

return PetAmuletSkillInfoPart
