-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\HeroStrengthenDlg.lua

local ResHeroStrengthenDes = require("ClientData/ResHeroStrengthenDes")
local HeroSkill = require("Common/Object/HeroSkill")
local HeroStrengthenDlg = Class("HeroStrengthenDlg", UIControls.Window)

function HeroStrengthenDlg:ctor()
	self.txtStrengthenDes = UIControls.Label(self, "BgPanel/SkillDesPanel/Content/TextDes")
	self.txtOldSkillName = UIControls.Label(self, "BgPanel/OldSkillPanel/Content/TextTitle")
	self.txtOldSkillPropValue = UIControls.Label(self, "BgPanel/OldSkillPanel/Content/TextNum")
	self.txtOldSkillPropName = UIControls.Label(self, "BgPanel/OldSkillPanel/Content/TextNum/TextTitle")
	self.imgOldPassive = UIControls.Image(self, "BgPanel/OldSkillPanel/Content/TextNum/TextTitle/Image")
	self.txtOldSkillDes = UIControls.Label(self, "BgPanel/OldSkillPanel/Content/TextDes")
	self.txtOldSkillPropValue2 = UIControls.Label(self, "BgPanel/OldSkillPanel/Content/TextNum2")
	self.txtNewSkillName = UIControls.Label(self, "BgPanel/NewSkillPanel/Content/TextTitle")
	self.txtNewSkillPropValue = UIControls.Label(self, "BgPanel/NewSkillPanel/Content/TextNum")
	self.txtNewSkillPropName = UIControls.Label(self, "BgPanel/NewSkillPanel/Content/TextNum/TextTitle")
	self.txtNewSkillDes = UIControls.Label(self, "BgPanel/NewSkillPanel/Content/TextDes")
	self.txtNewSkillPropValue2 = UIControls.Label(self, "BgPanel/NewSkillPanel/Content/TextNum2")
	self.imgNewPassive = UIControls.Image(self, "BgPanel/NewSkillPanel/Content/TextNum/TextTitle/Image")
	self.slotOnClickSkillCell = Slot(self.onClickSkillCell, self)
end

function HeroStrengthenDlg:setData(poolId)
	local heroStrengthenConfig = ResHeroStrengthenDes[poolId]

	self.txtStrengthenDes:setText(heroStrengthenConfig.change_appraise)

	self.hero = BaseObject.GetObject(heroStrengthenConfig.hero_id)
	self.skillCellList = self.skillCellList or {}
	self.curSelectSkillInfo = nil

	local skillInfoList = heroStrengthenConfig.skill_list

	self.skillDataDic = {}

	local skillNum = #skillInfoList
	local cellNum = #self.skillCellList

	for i = 1, skillNum do
		local cell

		if i <= cellNum then
			cell = self.skillCellList[i]
		else
			cell = UIControls.HeroSkillGridChild(self, "BgPanel/SkillList", "System/Hero/GridHeroSkill")
			cell.mEnableTips = false
			cell.mEventClick = self.slotOnClickSkillCell

			table.insert(self.skillCellList, cell)
		end

		cell:setVisible(true)

		local skillInfo = skillInfoList[i]
		local newSkillId = skillInfo.new_skill_id
		local skillField = self.hero:getSkillFieldBySkillId(newSkillId)
		local newSkillObj = HeroSkill(newSkillId, utils.getHeroMaxSkillLevel(self.hero, skillField), skillField)
		local oldSkillId = skillInfo.old_skill_id
		local oldSkillObj = HeroSkill(oldSkillId, utils.getHeroMaxSkillLevel(self.hero, skillField), skillField)

		self.skillDataDic[newSkillId] = {
			newSkillObj = newSkillObj,
			oldSkillObj = oldSkillObj,
			skillInfo = skillInfo
		}

		cell:setObj(newSkillObj)

		local checkSelect = i == 1

		cell:setSelect(checkSelect)

		if checkSelect then
			self.selectSkillId = skillInfo.new_skill_id
			self.selectSkillCell = cell

			self:refreshSelectSkillRes()
		end
	end

	if skillNum < cellNum then
		for i = skillNum + 1, cellNum do
			self.skillCellList[i]:setVisible(false)
		end
	end
end

function HeroStrengthenDlg:refreshSelectSkillRes()
	if not self.selectSkillId or self.selectSkillId <= 0 then
		return
	end

	local data = self.skillDataDic[self.selectSkillId]

	if not data then
		return
	end

	local newSkillObj = data.newSkillObj
	local oldSkillObj = data.oldSkillObj

	self.txtNewSkillName:setText(newSkillObj.name)
	self.txtNewSkillDes:setText(data.skillInfo.new_skill_des)
	self.txtOldSkillName:setText(oldSkillObj.name)
	self.txtOldSkillDes:setText(data.skillInfo.old_skill_des)

	if newSkillObj.style == Const.HERO_SKILL_STYLE.ATTACK then
		self.txtNewSkillPropValue:setVisible(true)
		self.txtOldSkillPropValue:setVisible(true)
		self.txtNewSkillPropValue2:setVisible(false)
		self.txtOldSkillPropValue2:setVisible(false)
		self.imgOldPassive:setVisible(false)
		self.imgNewPassive:setVisible(false)
		self.txtNewSkillPropName:setText(Lang.get(30241))
		self.txtNewSkillPropValue:setText(string.format(Lang.get(30237), self.hero.resData.attack_range or 1))
		self.txtOldSkillPropName:setText(Lang.get(30241))
		self.txtOldSkillPropValue:setText(string.format(Lang.get(30237), self.hero.resData.attack_range or 1))
	elseif newSkillObj.style == Const.HERO_SKILL_STYLE.SKILL then
		self.txtNewSkillPropValue:setVisible(true)
		self.txtOldSkillPropValue:setVisible(true)
		self.txtNewSkillPropValue2:setVisible(true)
		self.txtOldSkillPropValue2:setVisible(true)
		self.imgOldPassive:setVisible(false)
		self.imgNewPassive:setVisible(false)
		self.txtNewSkillPropName:setText(Lang.get(985))
		self.txtNewSkillPropValue:setText(self.hero:getInitMana() or 0)
		self.txtNewSkillPropValue2:setText(string.format(Lang.get(30238), self.hero.resData.mana_gen or 0))
		self.txtOldSkillPropName:setText(Lang.get(985))
		self.txtOldSkillPropValue:setText(self.hero:getInitMana() or 0)
		self.txtOldSkillPropValue2:setText(string.format(Lang.get(30238), self.hero.resData.mana_gen or 0))
	elseif newSkillObj.style == Const.HERO_SKILL_STYLE.PASSIVE then
		self.txtNewSkillPropValue:setVisible(false)
		self.txtOldSkillPropValue:setVisible(false)
		self.txtNewSkillPropValue2:setVisible(false)
		self.txtOldSkillPropValue2:setVisible(false)
		self.imgOldPassive:setVisible(false)
		self.imgNewPassive:setVisible(false)

		local isSupport = self.hero.career == Const.CAREER_TYPE.SUPPORT

		if isSupport and newSkillObj.skillField == Const.HERO_SKILL_FIELD.HERO_PASSIVE then
			self.txtNewSkillPropValue:setVisible(true)
			self.txtOldSkillPropValue:setVisible(true)
			self.txtNewSkillPropValue:setText("")
			self.txtOldSkillPropValue:setText("")
			self.txtNewSkillPropName:setText(Lang.get(4493))
			self.txtOldSkillPropName:setText(Lang.get(4493))

			local careerPath = self.hero:getCareerPath()

			if careerPath then
				self.imgOldPassive:setVisible(true)
				self.imgNewPassive:setVisible(true)
				self.imgNewPassive:setImage(careerPath[1], careerPath[2])
				self.imgOldPassive:setImage(careerPath[1], careerPath[2])
			end
		end
	else
		self.txtNewSkillPropValue:setVisible(false)
		self.txtOldSkillPropValue:setVisible(false)
		self.txtNewSkillPropValue2:setVisible(false)
		self.txtOldSkillPropValue2:setVisible(false)
		self.imgOldPassive:setVisible(false)
		self.imgNewPassive:setVisible(false)
	end
end

function HeroStrengthenDlg:onClickSkillCell(cell)
	local skillId = cell.object.id

	if skillId == self.selectSkillId then
		return
	end

	if self.selectSkillCell then
		self.selectSkillCell:setSelect(false)
	end

	self.selectSkillId = skillId
	self.selectSkillCell = cell

	self.selectSkillCell:setSelect(true)
	self:refreshSelectSkillRes()
end

return HeroStrengthenDlg
