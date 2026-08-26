-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EnemyRule.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EnemyRule", package.seeall)

local Season123_3_5EnemyRule = class("Season123_3_5EnemyRule", BaseView)

function Season123_3_5EnemyRule:onInitView()
	self._goadditionRule = gohelper.findChild(self.viewGO, "go_rule/#go_additionRule")
	self._goruletemp = gohelper.findChild(self.viewGO, "go_rule/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "go_rule/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._gorulelist = gohelper.findChild(self.viewGO, "go_rule/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "go_rule/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._goruledesc = gohelper.findChild(self.viewGO, "go_rule/#go_ruledesc")
	self._btncloserule = gohelper.findChildButtonWithAudio(self.viewGO, "go_rule/#go_ruledesc/#btn_closerule")
	self._goruleitem = gohelper.findChild(self.viewGO, "go_rule/#go_ruledesc/bg/#go_ruleitem")
	self._goruleDescList = gohelper.findChild(self.viewGO, "go_rule/#go_ruledesc/bg/#go_ruleDescList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5EnemyRule:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
	self._btncloserule:AddClickListener(self._btncloseruleOnClick, self)
end

function Season123_3_5EnemyRule:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
	self._btncloserule:RemoveClickListener()
end

function Season123_3_5EnemyRule:_btncloseruleOnClick()
	if self._ruleItemClick then
		self._ruleItemClick = false

		return
	end

	gohelper.setActive(self._goruledesc, false)
end

function Season123_3_5EnemyRule:_btnadditionRuleOnClick()
	self._ruleItemClick = self._goruledesc.activeSelf

	gohelper.setActive(self._goruledesc, true)
end

function Season123_3_5EnemyRule:_editableInitView()
	gohelper.setActive(self._goruleitem, false)
	gohelper.setActive(self._goruletemp, false)
	gohelper.setActive(self._goruledesc, false)

	self._rulesimagelineList = self:getUserDataTb_()
	self._childGoList = self:getUserDataTb_()

	gohelper.addUIClickAudio(self._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)
end

function Season123_3_5EnemyRule:onOpen()
	self.addEventCb(self, Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, self.refreshUI, self)
	self:refreshUI()
end

function Season123_3_5EnemyRule:refreshUI()
	local battleId = Season123EnemyModel.instance:getSelectBattleId()
	local additionRule = DungeonConfig.instance:getBattleAdditionRule(battleId)

	if string.nilorempty(additionRule) then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	self:_clear()
	gohelper.setActive(self._goadditionRule, true)

	local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

	for i, v in ipairs(ruleList) do
		local targetId = v[1]
		local ruleId = v[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			self:_addRuleItem(ruleCo, targetId)
			self:_setRuleDescItem(ruleCo, targetId)
		end

		if i == #ruleList then
			gohelper.setActive(self._rulesimagelineList[i], false)
		end
	end
end

function Season123_3_5EnemyRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")
	local simage = gohelper.findChildImage(go, "")

	table.insert(self._childGoList, go)
	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function Season123_3_5EnemyRule:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local go = gohelper.clone(self._goruleitem, self._goruleDescList, ruleCo.id)

	table.insert(self._childGoList, go)
	gohelper.setActive(go, true)

	local icon = gohelper.findChildImage(go, "icon")
	local line = gohelper.findChild(go, "line")

	table.insert(self._rulesimagelineList, line)

	local tag = gohelper.findChildImage(go, "tag")
	local desc = gohelper.findChildText(go, "desc")
	local descContent = string.gsub(ruleCo.desc, "%【(.-)%】", "<color=#6680bd>[%1]</color>")
	local wordContent = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(ruleCo.desc, tagColor[1])
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)
	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	desc.text = string.format("<color=%s>[%s]</color>%s%s", color, side, descContent, wordContent)
end

function Season123_3_5EnemyRule:_clear()
	for i, v in ipairs(self._childGoList) do
		gohelper.destroy(v)
	end

	self._rulesimagelineList = self:getUserDataTb_()
	self._childGoList = self:getUserDataTb_()
end

function Season123_3_5EnemyRule:onDestroyView()
	self:_clear()
end

return Season123_3_5EnemyRule
