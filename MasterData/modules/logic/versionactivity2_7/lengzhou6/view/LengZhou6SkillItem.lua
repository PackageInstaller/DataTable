-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6SkillItem.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6SkillItem", package.seeall)

local LengZhou6SkillItem = class("LengZhou6SkillItem", ListScrollCellExtend)

function LengZhou6SkillItem:onInitView()
	self._goSkillEmpty = gohelper.findChild(self.viewGO, "#go_SkillEmpty")
	self._goHaveSkill = gohelper.findChild(self.viewGO, "#go_HaveSkill")
	self._imageSkillIIcon = gohelper.findChildImage(self.viewGO, "#go_HaveSkill/SkillIconMask/#image_SkillIIcon")
	self._imagecd = gohelper.findChildImage(self.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd")
	self._txtcd = gohelper.findChildText(self.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd/#txt_cd")
	self._imageSkillSmallIcon = gohelper.findChildImage(self.viewGO, "#go_HaveSkill/#image_SkillSmallIcon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_HaveSkill/#image_SkillSmallIcon/#txt_num")
	self._goSkillNeedChange = gohelper.findChild(self.viewGO, "#go_SkillNeedChange")
	self._imagechange = gohelper.findChildImage(self.viewGO, "#go_SkillNeedChange/#image_change")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6SkillItem:addEvents()
	return
end

function LengZhou6SkillItem:removeEvents()
	return
end

function LengZhou6SkillItem:_editableInitView()
	self._skillClick = SLFramework.UGUI.UIClickListener.Get(self._imageSkillIIcon.gameObject)

	self._skillClick:AddClickListener(self._click, self)

	self._skillSelectClick = SLFramework.UGUI.UIClickListener.Get(self._imagechange.gameObject)

	self._skillSelectClick:AddClickListener(self._selectClick, self)

	self._goSelect = gohelper.findChild(self.viewGO, "#go_HaveSkill/SkillIconMask/vx_select")
	self._goComing = gohelper.findChild(self.viewGO, "#go_HaveSkill/SkillIconMask/vx_coming")
	self._goCanuse = gohelper.findChild(self.viewGO, "#go_HaveSkill/SkillIconMask/vx_canuse")
	self._goCanchange = gohelper.findChild(self.viewGO, "#go_SkillNeedChange/vx_canchange")
end

function LengZhou6SkillItem:_click()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._skill == nil then
		return
	end

	if not LengZhou6EliminateController.instance:getPerformIsFinish() then
		return
	end

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.OnClickSkill, self._skill)
end

function LengZhou6SkillItem:_selectClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local progress = LengZhou6GameModel.instance:getEndLessBattleProgress()

	if progress == LengZhou6Enum.BattleProgress.selectSkill then
		LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.ShowSelectView, self._index)
	end
end

function LengZhou6SkillItem:initSkill(skill, index)
	self._skill = skill
	self._configId = nil
	self._index = index or 1

	if self._skill ~= nil then
		self._configId = self._skill:getConfig().id
		self._skillId = self._skill._id
	end

	gohelper.setActive(self._goComing, false)
	gohelper.setActive(self._goSelect, false)
	gohelper.setActive(self._goCanuse, false)
	gohelper.setActive(self._goCanchange, false)
end

function LengZhou6SkillItem:initSkillConfigId(skillConfigId)
	self._configId = skillConfigId
end

function LengZhou6SkillItem:selectIsFinish(isFinish)
	self._selectIsFinish = isFinish
end

function LengZhou6SkillItem:initCamp(camp)
	self._camp = camp
end

function LengZhou6SkillItem:refreshState()
	local skillIdIsNil = self._skillId == nil
	local configIsNil = self._configId == nil

	if not configIsNil then
		self:initInfo()
	end

	if not skillIdIsNil then
		self:updateInfo()
	end

	gohelper.setActive(self._goSkillEmpty, configIsNil)
	gohelper.setActive(self._goHaveSkill, not configIsNil)

	local battleModel = LengZhou6GameModel.instance:getBattleModel()

	if battleModel == LengZhou6Enum.BattleModel.infinite then
		local progress = LengZhou6GameModel.instance:getEndLessBattleProgress()
		local selectIsFinish = progress == LengZhou6Enum.BattleProgress.selectFinish
		local isShow = not selectIsFinish and self._camp == LengZhou6Enum.entityCamp.player

		gohelper.setActive(self._goSkillNeedChange, isShow)

		if not selectIsFinish then
			gohelper.setActive(self._imagecd.gameObject, false)
		end
	else
		gohelper.setActive(self._goSkillNeedChange, false)
	end

	self:updateCanChangeActive()
end

function LengZhou6SkillItem:useSkill(skillId)
	if self._skillId == skillId then
		self._skillId = nil
		self._configId = nil
	end

	self:refreshState()
end

function LengZhou6SkillItem:initInfo()
	local config = LengZhou6Config.instance:getEliminateBattleSkill(self._configId)

	if config == nil then
		return
	end

	local icon = config.icon

	if icon ~= nil then
		local icons = string.split(icon, "#")

		UISpriteSetMgr.instance:setHisSaBethSprite(self._imageSkillIIcon, icons[1])

		local haveSmallIcon = icons[2] ~= nil

		if haveSmallIcon then
			UISpriteSetMgr.instance:setHisSaBethSprite(self._imageSkillSmallIcon, icons[2])
		end

		gohelper.setActive(self._imageSkillSmallIcon.gameObject, haveSmallIcon)
	end

	local effect = config.effect

	if effect ~= nil then
		local effects = string.split(effect, "#")

		if effects[1] == LengZhou6Enum.SkillEffect.DealsDamage then
			self._txtnum.text = tonumber(effects[2])
		end

		gohelper.setActive(self._txtnum, effects[1] == LengZhou6Enum.SkillEffect.DealsDamage)
	end
end

function LengZhou6SkillItem:updateSkillInfo()
	if self._configId == nil then
		return
	end

	if self._skill ~= nil then
		local effects = self._skill:getEffect()

		if effects[1] == LengZhou6Enum.SkillEffect.DealsDamage then
			self._txtnum.text = self._skill:getTotalValue()
		end
	end

	local config = LengZhou6Config.instance:getEliminateBattleSkill(self._configId)

	if config and config.type ~= LengZhou6Enum.SkillType.active then
		gohelper.setActive(self._imagecd.gameObject, false)

		return
	end

	local cd = self._skill and self._skill:getCd() or 0
	local inCd = cd > 0

	gohelper.setActive(self._imagecd.gameObject, inCd)

	if inCd then
		self._txtcd.text = cd
	else
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.PlayerSkillCanUse)
		gohelper.setActive(self._goSelect, true)

		if self._lastInCd then
			AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
		end
	end

	self._lastInCd = inCd

	gohelper.setActive(self._goCanuse, self._selectIsFinish and not inCd)
end

function LengZhou6SkillItem:_editableAddEvents()
	return
end

function LengZhou6SkillItem:_editableRemoveEvents()
	return
end

function LengZhou6SkillItem:updateInfo()
	self:updateSkillInfo()
end

function LengZhou6SkillItem:showEnemySkillRound(show)
	if self._goComing then
		gohelper.setActive(self._goComing, show)
	end
end

function LengZhou6SkillItem:updateCanChangeActive()
	local active = not self._selectIsFinish

	if self._configId ~= nil then
		local config = LengZhou6Config.instance:getEliminateBattleSkill(self._configId)

		if config and config.type == LengZhou6Enum.SkillType.enemyActive then
			active = false
		end
	end

	gohelper.setActive(self._goCanchange, active)
end

function LengZhou6SkillItem:onDestroyView()
	if self._skillClick ~= nil then
		self._skillClick:RemoveClickListener()

		self._skillClick = nil
	end

	if self._skillSelectClick then
		self._skillSelectClick:RemoveClickListener()

		self._skillSelectClick = nil
	end
end

return LengZhou6SkillItem
