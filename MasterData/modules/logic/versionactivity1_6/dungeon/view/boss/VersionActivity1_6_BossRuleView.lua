-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6_BossRuleView.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossRuleView", package.seeall)

local VersionActivity1_6_BossRuleView = class("VersionActivity1_6_BossRuleView", BaseView)

function VersionActivity1_6_BossRuleView:onInitView()
	local root = gohelper.findChild(self.viewGO, "Left/Rule")

	self._goadditionRule = gohelper.findChild(root, "#scroll_ConditionIcons")
	self._goruletemp = gohelper.findChild(root, "#scroll_ConditionIcons/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self._goruletemp, "#image_tagicon")
	self._gorulelist = gohelper.findChild(self._goadditionRule, "Viewport/content")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self._goadditionRule, "#btn_additionRuleclick")
	self._goruledesc = gohelper.findChild(root, "Tips")
	self._goruleitem = gohelper.findChild(self._goruledesc, "image_TipsBG/#go_Item1")
	self._goExtraRuleitem = gohelper.findChild(self._goruledesc, "image_TipsBG/#go_Item2")
	self._goruleDescList = gohelper.findChild(self._goruledesc, "bg/#go_ruleDescList")
	self._nextBossTitle = gohelper.findChildText(self.viewGO, "Left/Rule/Tips/image_TipsBG/#go_Item2/#txt_Descr/#txt_Title")
	self._nextBossDay = gohelper.findChildText(self.viewGO, "Left/Rule/Tips/image_TipsBG/#go_Item2/#txt_Descr/#txt_Title/#txt_dayNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6_BossRuleView:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnRuleAreaOnClick, self)
end

function VersionActivity1_6_BossRuleView:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
end

function VersionActivity1_6_BossRuleView:_editableInitView()
	gohelper.setActive(self._goruleitem, false)
	gohelper.setActive(self._goExtraRuleitem, false)
	gohelper.setActive(self._goruletemp, false)
	gohelper.setActive(self._goruledesc, false)
	gohelper.addUIClickAudio(self._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)

	self._normalRuleItemList = {}
	self._extraRuleItemList = {}
end

function VersionActivity1_6_BossRuleView:refreshUI(battleId, addBattleId)
	gohelper.setActive(self._goruleitem, false)
	gohelper.setActive(self._goExtraRuleitem, false)
	self:addNormalRuleItem(battleId, addBattleId and addBattleId ~= 0)

	if addBattleId and addBattleId ~= 0 then
		self:AddExtraRuleItem(addBattleId)
	end
end

function VersionActivity1_6_BossRuleView:addNormalRuleItem(battleId, zoom)
	local additionRule = DungeonConfig.instance:getBattleAdditionRule(battleId)

	if string.nilorempty(additionRule) then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	self:_clear()
	gohelper.setActive(self._goadditionRule, true)
	gohelper.setActive(self._goruleitem, true)

	local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

	self._ruleList = ruleList

	for i, ruleData in ipairs(ruleList) do
		local ruleId = ruleData[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			local ruleItem = self:_addRuleItem(ruleData, false, zoom)

			ruleItem.battleId = battleId
			self._normalRuleItemList[#self._normalRuleItemList + 1] = ruleItem
		end
	end
end

function VersionActivity1_6_BossRuleView:AddExtraRuleItem(battleId)
	local additionRule = DungeonConfig.instance:getBattleAdditionRule(battleId)
	local modelInstance = VersionActivity1_6DungeonBossModel.instance

	if not additionRule then
		return
	end

	local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

	for i, ruleData in ipairs(ruleList) do
		local ruleId = ruleData[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			local ruleItem = self:_addRuleItem(ruleData, true)

			ruleItem.battleId = battleId
			self._extraRuleItemList[#self._extraRuleItemList + 1] = ruleItem

			table.insert(self._ruleList, ruleData)

			local curBossDayRemain = modelInstance:getCurBossEpisodeRemainDay()

			self._nextBossTitle.text = string.format(luaLang("p_v1a6_activityboss_help_3_txt_3"), curBossDayRemain)
			self._nextBossDay.text = ""
		end
	end
end

function VersionActivity1_6_BossRuleView:_addRuleItem(ruleData, extra, zoom)
	local ruleItem = self:getUserDataTb_()

	ruleItem.targetId = ruleData[1]
	ruleItem.ruleId = ruleData[2]
	ruleItem.ruleCfg = lua_rule.configDict[ruleItem.ruleId]

	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleItem.ruleCfg.id)

	ruleItem.go = go

	gohelper.setActive(go, true)

	local canvasGroup = gohelper.onceAddComponent(go, typeof(UnityEngine.CanvasGroup))

	if canvasGroup then
		canvasGroup.alpha = extra and 0.5 or 1
	end

	local scale = zoom and 1.3 or 1

	transformhelper.setLocalScale(go.transform, scale, scale, 1)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. ruleItem.targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleItem.ruleCfg.icon)

	tagicon.maskable = true
	simage.maskable = true

	return ruleItem
end

function VersionActivity1_6_BossRuleView:_btnRuleAreaOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self._ruleList
	})
end

function VersionActivity1_6_BossRuleView:_clear()
	for i, ruleItem in ipairs(self._normalRuleItemList) do
		gohelper.destroy(ruleItem.go)
	end

	for i, ruleItem in ipairs(self._extraRuleItemList) do
		gohelper.destroy(ruleItem.go)
	end

	self._normalRuleItemList = {}
	self._extraRuleItemList = {}
end

function VersionActivity1_6_BossRuleView:onDestroyView()
	self:_clear()
end

return VersionActivity1_6_BossRuleView
