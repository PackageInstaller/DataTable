-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Monster.lua

local Hero = require("Common/Object/Hero")
local ResMonster = require("ClientData/ResMonster")
local ResColor = require("ClientData/ResColor")
local HeroSkill = require("Common/Object/HeroSkill")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local strClassName = "Monster"
local Monster = Class(strClassName, Hero)

function Monster:ctor(monsterID, monsterLevel)
	self.level = monsterLevel or 1
end

function Monster:_initData()
	self.id = self._serverData
	self.resData = ResMonster[self.id]

	if not self.resData then
		-- block empty
	end

	self.name = self.resData.name

	if self.resData.career == nil then
		self.resData.career = Const.CAREER_TYPE.TANK
	end

	self.careerName = Const.CAREER_CONFIG[self.resData.career].name

	if self.resData.camp == nil then
		self.resData.camp = 1
	end

	self.groupName = Const.CAMP_CONFIG[self.resData.camp].name
	self.camp = self.resData.camp
	self.star = 1
	self.step = 0
	self.wake = 0
	self.skill = {}

	if self.resData.attack_id then
		self.skillBase = HeroSkill(self.resData.attack_id, self.resData.attack_level or 1, Const.HERO_SKILL_FIELD.ATTACK)
	end

	if self.resData.skill_id then
		self.skillLast = HeroSkill(self.resData.skill_id, self.resData.skill_level or 1, Const.HERO_SKILL_FIELD.SKILL)
	end

	if self.resData.enter_passive then
		self.skillPassive1 = HeroSkill(self.resData.enter_passive, self.resData.enter_passive_level or 1, Const.HERO_SKILL_FIELD.ENTER_PASSIVE)
	end

	if self.resData.hero_passive then
		self.skillPassive2 = HeroSkill(self.resData.hero_passive, self.resData.hero_passive_level or 1, Const.HERO_SKILL_FIELD.HERO_PASSIVE)
	end

	self.inTeam = 0
	self.formationIndex = 0

	if self.resData.hero_id then
		self.heroSkinData = ResItemHeroSkin[self.resData.hero_id]
		self.skin = self.resData.skin_id
	end
end

function Monster:getIconPath()
	return UIConst.getMonsterHeadIconPath(self.id)
end

function Monster:getLvColor(campColorDic)
	if campColorDic then
		return campColorDic[self.camp]
	else
		return ResColor.WHITE
	end
end

function Monster:getStarPath(star)
	return
end

function Monster:getShowAniName()
	if self.skin and self.heroSkinData and self.heroSkinData[self.skin] then
		return self.heroSkinData[self.skin].ani_con_path
	end

	return self.resData.weapon
end

return Monster
