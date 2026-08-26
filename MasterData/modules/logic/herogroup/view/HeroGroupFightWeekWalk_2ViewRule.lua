-- chunkname: @modules/logic/herogroup/view/HeroGroupFightWeekWalk_2ViewRule.lua

module("modules.logic.herogroup.view.HeroGroupFightWeekWalk_2ViewRule", package.seeall)

local HeroGroupFightWeekWalk_2ViewRule = class("HeroGroupFightWeekWalk_2ViewRule", BaseView)

function HeroGroupFightWeekWalk_2ViewRule:onInitView()
	self._goadditionRule = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	self._goruletemp = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._gorulelist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._gobalance = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance")
	self._txtBalanceRoleLv = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/roleLvTxtbg/roleLvTxt/#txt_roleLv")
	self._txtBalanceEquipLv = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/equipLvTxtbg/equipLvTxt/#txt_equipLv")
	self._txtBalanceTalent = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/talentTxtbg/talentTxt/#txt_talent")
	self._goruledesc = gohelper.findChild(self.viewGO, "#go_container2/#go_ruledesc")

	gohelper.setActive(self._goruledesc, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupFightWeekWalk_2ViewRule:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, self._refreshUI, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._onModifyGroupSelectIndex, self)
end

function HeroGroupFightWeekWalk_2ViewRule:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
	self.removeEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, self._refreshUI, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._onModifyGroupSelectIndex, self)
end

function HeroGroupFightWeekWalk_2ViewRule:_btncloseruleOnClick()
	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function HeroGroupFightWeekWalk_2ViewRule:_btnadditionRuleOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self._ruleList,
		closeCb = self._btncloseruleOnClick,
		closeCbObj = self
	})

	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

function HeroGroupFightWeekWalk_2ViewRule:_editableInitView()
	gohelper.setActive(self._goruletemp, false)

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._simageList = self:getUserDataTb_()
end

function HeroGroupFightWeekWalk_2ViewRule:onOpen()
	self:_refreshUI()
end

function HeroGroupFightWeekWalk_2ViewRule:_onModifyGroupSelectIndex()
	local additionRule = self:_getAdditionRule()

	if self._additionRule ~= additionRule then
		self:_refreshUI()
	end
end

function HeroGroupFightWeekWalk_2ViewRule:_getAdditionRule()
	local result = ""
	local mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	local battleId = HeroGroupModel.instance.battleId
	local battleInfo = mapInfo and mapInfo:getBattleInfoByBattleId(battleId)
	local skillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()
	local info = WeekWalk_2Model.instance:getInfo()
	local ruleConfig = lua_weekwalk_ver2_time.configDict[info.issueId]

	if battleInfo then
		result = battleInfo.index == WeekWalk_2Enum.BattleIndex.First and ruleConfig.ruleFront or ruleConfig.ruleRear
	end

	if skillId then
		local buffConfig = lua_weekwalk_ver2_skill.configDict[skillId]

		result = result .. "|" .. buffConfig.rules
	end

	return result
end

function HeroGroupFightWeekWalk_2ViewRule:_refreshUI()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._battleId = HeroGroupModel.instance.battleId

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local roleLv, talent, equipLv = HeroGroupBalanceHelper.getBalanceLv()

	if roleLv then
		gohelper.setActive(self._gobalance, true)

		self._txtBalanceRoleLv.text = HeroConfig.instance:getCommonLevelDisplay(roleLv)
		self._txtBalanceEquipLv.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("common_format_level"), equipLv)
		self._txtBalanceTalent.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("common_format_level"), talent)
	else
		gohelper.setActive(self._gobalance, false)
	end

	self._isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard

	if chapterConfig.type == DungeonEnum.ChapterType.Normal then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	local additionRule = self:_getAdditionRule()

	self._additionRule = additionRule

	local ruleList = FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#")

	if episodeConfig.type == DungeonEnum.EpisodeType.Meilanni then
		ruleList = HeroGroupFightWeekWalk_2ViewRule.meilanniExcludeRules(ruleList)
	end

	if not ruleList or #ruleList == 0 then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	self._cloneRuleGos = self._cloneRuleGos or self:getUserDataTb_()

	self:_clearRules()

	self._ruleList = ruleList

	gohelper.setActive(self._goadditionRule, true)

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

function HeroGroupFightWeekWalk_2ViewRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)
	table.insert(self._cloneRuleGos, go)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function HeroGroupFightWeekWalk_2ViewRule:_clearRules()
	for i = #self._cloneRuleGos, 1, -1 do
		gohelper.destroy(self._cloneRuleGos[i])

		self._cloneRuleGos[i] = nil
	end
end

function HeroGroupFightWeekWalk_2ViewRule.meilanniExcludeRules(ruleList)
	if not ruleList or #ruleList == 0 then
		return
	end

	local mapId = MeilanniModel.instance:getCurMapId()

	if mapId then
		::label_13_0::

		local mapInfo = MeilanniModel.instance:getMapInfo(mapId)
		local result = {}

		for i, v in ipairs(ruleList) do
			local ruleId = v[2]

			if mapInfo and not mapInfo:isExcludeRule(ruleId) then
				table.insert(result, v)
			end
		end

		return result
	end
end

function HeroGroupFightWeekWalk_2ViewRule:onDestroyView()
	return
end

return HeroGroupFightWeekWalk_2ViewRule
