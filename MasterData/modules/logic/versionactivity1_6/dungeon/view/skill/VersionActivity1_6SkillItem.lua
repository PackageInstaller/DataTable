-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/skill/VersionActivity1_6SkillItem.lua

module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillItem", package.seeall)

local VersionActivity1_6SkillItem = class("VersionActivity1_6SkillItem", UserDataDispose)

function VersionActivity1_6SkillItem:init(go, skillType)
	self.viewGO = go
	self._skillType = skillType
	self.btnLvUp = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_LvUp/#btn_LvUpArea")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "image_Pic")
	self._imageIconGold = gohelper.findChildImage(self.viewGO, "#image_Icon_gold")
	self._imageIconSliver = gohelper.findChildImage(self.viewGO, "#image_Icon_sliver")
	self._txtLvNum = gohelper.findChildText(self.viewGO, "#txt_LvNum")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Scroll View/Viewport/#txt_Descr")
	self._goEffect = gohelper.findChild(self.viewGO, "eff")

	self:addEventListeners()
	self:refreshItemUI()
end

function VersionActivity1_6SkillItem:addEventListeners()
	self.btnLvUp:AddClickListener(self._btnLvUpClick, self)
end

function VersionActivity1_6SkillItem:removeEventListeners()
	self.btnLvUp:RemoveClickListener()
end

function VersionActivity1_6SkillItem:refreshItemUI()
	local skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(self._skillType)
	local skillLv = skillMo and skillMo:getLevel() or 0
	local skillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillType, skillLv)
	local skillTypeCfg = Activity148Config.instance:getAct148SkillTypeCfg(self._skillType)
	local skillSmallIcon = skillLv == 0 and Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.SkillOriginIcon[self._skillType]) or skillCfg.skillSmallIcon
	local maxSkillLv = tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillLv))

	self._txtLvNum.text = skillLv == maxSkillLv and "MAX" or skillLv
	self._txtTitle.text = skillTypeCfg.skillName
	self._txtDesc.text = skillTypeCfg.skillValueDesc

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(self._imageIcon, skillSmallIcon)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(self._imageIconGold, skillSmallIcon)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(self._imageIconSliver, skillSmallIcon)

	local silverEffectSkillLv = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.SilverEffectSkillLv)
	local goldEffectSkillLv = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.GoldEffectSkillLv)
	local isGold = skillLv >= tonumber(goldEffectSkillLv)
	local isSilver = skillLv >= tonumber(silverEffectSkillLv)

	if isGold then
		gohelper.setActive(self._imageIconSliver.gameObject, false)
		gohelper.setActive(self._imageIconGold.gameObject, true)
	elseif isSilver then
		gohelper.setActive(self._imageIconSliver.gameObject, true)
		gohelper.setActive(self._imageIconGold.gameObject, false)
	else
		gohelper.setActive(self._imageIconSliver.gameObject, false)
		gohelper.setActive(self._imageIconGold.gameObject, false)
	end
end

function VersionActivity1_6SkillItem:refreshResetEffect()
	gohelper.setActive(self._goEffect, false)
	gohelper.setActive(self._goEffect, true)
end

function VersionActivity1_6SkillItem:onDestroyItem()
	self:removeEventListeners()
end

function VersionActivity1_6SkillItem:_btnLvUpClick()
	VersionActivity1_6DungeonController.instance:openSkillLvUpView(self._skillType)
end

return VersionActivity1_6SkillItem
