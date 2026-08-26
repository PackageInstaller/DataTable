-- chunkname: @modules/logic/weekwalk/view/WeekWalkEnemyInfoViewRule.lua

module("modules.logic.weekwalk.view.WeekWalkEnemyInfoViewRule", package.seeall)

local WeekWalkEnemyInfoViewRule = class("WeekWalkEnemyInfoViewRule", BaseView)

function WeekWalkEnemyInfoViewRule:onInitView()
	self._goadditionRule = gohelper.findChild(self.viewGO, "go_rule/#go_additionRule")
	self._goruletemp = gohelper.findChild(self.viewGO, "go_rule/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "go_rule/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._gorulelist = gohelper.findChild(self.viewGO, "go_rule/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "go_rule/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._goruledesc = gohelper.findChild(self.viewGO, "go_rule/#go_ruledesc")

	gohelper.setActive(self._goruledesc, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkEnemyInfoViewRule:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
end

function WeekWalkEnemyInfoViewRule:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
end

function WeekWalkEnemyInfoViewRule:_btncloseruleOnClick()
	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function WeekWalkEnemyInfoViewRule:_btnadditionRuleOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self._ruleList,
		closeCb = self._btncloseruleOnClick,
		closeCbObj = self
	})

	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

function WeekWalkEnemyInfoViewRule:_editableInitView()
	gohelper.setActive(self._goruleitem, false)
	gohelper.setActive(self._goruletemp, false)

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._simageList = self:getUserDataTb_()
	self._childGoList = self:getUserDataTb_()

	gohelper.addUIClickAudio(self._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)
end

function WeekWalkEnemyInfoViewRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	table.insert(self._childGoList, go)
	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function WeekWalkEnemyInfoViewRule:refreshUI(battleId)
	local additionRule = DungeonConfig.instance:getBattleAdditionRule(battleId)

	if string.nilorempty(additionRule) then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	self:_clear()
	gohelper.setActive(self._goadditionRule, true)

	local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

	self._ruleList = ruleList

	for i, v in ipairs(ruleList) do
		local targetId = v[1]
		local ruleId = v[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			self:_addRuleItem(ruleCo, targetId)
		end

		if i == #ruleList then
			gohelper.setActive(self._rulesimagelineList[i], false)
		end
	end
end

function WeekWalkEnemyInfoViewRule:_clear()
	for i, v in ipairs(self._childGoList) do
		gohelper.destroy(v)
	end

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._simageList = self:getUserDataTb_()
	self._childGoList = self:getUserDataTb_()
end

function WeekWalkEnemyInfoViewRule:onDestroyView()
	self:_clear()
end

return WeekWalkEnemyInfoViewRule
