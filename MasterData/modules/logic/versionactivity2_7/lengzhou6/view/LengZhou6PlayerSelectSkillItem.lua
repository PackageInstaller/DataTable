-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6PlayerSelectSkillItem.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6PlayerSelectSkillItem", package.seeall)

local LengZhou6PlayerSelectSkillItem = class("LengZhou6PlayerSelectSkillItem", ListScrollCellExtend)

function LengZhou6PlayerSelectSkillItem:onInitView()
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._txtSkillDescr = gohelper.findChildText(self.viewGO, "#txt_SkillDescr")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "#txt_SkillDescr/#txt_SkillName")
	self._imageSkillIIcon = gohelper.findChildImage(self.viewGO, "#txt_SkillDescr/Skill/SkillIconMask/#image_SkillIIcon")
	self._imageSkillSmallIcon = gohelper.findChildImage(self.viewGO, "#txt_SkillDescr/Skill/#image_SkillSmallIcon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_SkillDescr/Skill/#image_SkillSmallIcon/#txt_num")
	self._txtRound = gohelper.findChildText(self.viewGO, "#txt_SkillDescr/#txt_Round")
	self._goClick = gohelper.findChild(self.viewGO, "#txt_SkillDescr/#go_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6PlayerSelectSkillItem:addEvents()
	return
end

function LengZhou6PlayerSelectSkillItem:removeEvents()
	return
end

function LengZhou6PlayerSelectSkillItem:_editableInitView()
	return
end

function LengZhou6PlayerSelectSkillItem:_editableAddEvents()
	self._skillGoClick = SLFramework.UGUI.UIClickListener.Get(self._goClick)

	self._skillGoClick:AddClickListener(self._select, self)
end

function LengZhou6PlayerSelectSkillItem:_editableRemoveEvents()
	if self._skillGoClick then
		self._skillGoClick:RemoveClickListener()

		self._skillGoClick = nil
	end
end

function LengZhou6PlayerSelectSkillItem:_select()
	if self._skillId == nil then
		return
	end

	local isSelect = LengZhou6GameModel.instance:isSelectSkill(self._skillId)

	if isSelect then
		return
	end

	LengZhou6GameModel.instance:setPlayerSelectSkillId(self._selectIndex, self._skillId)
	self:refreshSelect()
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.PlayerSelectFinish, self._selectIndex, self._skillId)
end

function LengZhou6PlayerSelectSkillItem:initSkill(skillId)
	self._skillId = skillId
	self._config = LengZhou6Config.instance:getEliminateBattleSkill(skillId)

	if self._config ~= nil then
		self:initItem()
		self:refreshSelect()
	end
end

function LengZhou6PlayerSelectSkillItem:initSelectIndex(index)
	self._selectIndex = index
end

function LengZhou6PlayerSelectSkillItem:refreshSelect()
	local isSelect = LengZhou6GameModel.instance:isSelectSkill(self._skillId)

	gohelper.setActive(self._goSelected, isSelect)
end

function LengZhou6PlayerSelectSkillItem:initItem()
	local isActive = self._config.type == LengZhou6Enum.SkillType.active

	self._txtRound.text = isActive and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), self._config.cd) or luaLang("lengZhou6_skill_round_end")
	self._txtSkillDescr.text = self._config.desc

	local icon = self._config.icon

	if icon ~= nil then
		local icons = string.split(icon, "#")

		UISpriteSetMgr.instance:setHisSaBethSprite(self._imageSkillIIcon, icons[1])

		local haveSmallIcon = icons[2] ~= nil

		if haveSmallIcon then
			UISpriteSetMgr.instance:setHisSaBethSprite(self._imageSkillSmallIcon, icons[2])
		end

		gohelper.setActive(self._imageSkillSmallIcon.gameObject, haveSmallIcon)
	end

	local effect = self._config.effect

	if effect ~= nil then
		local effects = string.split(effect, "#")

		if effects[1] == LengZhou6Enum.SkillEffect.DealsDamage then
			self._txtnum.text = tonumber(effects[2])
		end

		gohelper.setActive(self._txtnum.gameObject, effects[1] == LengZhou6Enum.SkillEffect.DealsDamage)
	end

	self._txtSkillName.text = self._config.name
end

function LengZhou6PlayerSelectSkillItem:onDestroyView()
	return
end

return LengZhou6PlayerSelectSkillItem
