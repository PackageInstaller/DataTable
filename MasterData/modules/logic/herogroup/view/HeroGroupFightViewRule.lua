-- chunkname: @modules/logic/herogroup/view/HeroGroupFightViewRule.lua

module("modules.logic.herogroup.view.HeroGroupFightViewRule", package.seeall)

local HeroGroupFightViewRule = class("HeroGroupFightViewRule", BaseView)

function HeroGroupFightViewRule:onInitView()
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

function HeroGroupFightViewRule:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function HeroGroupFightViewRule:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function HeroGroupFightViewRule:_btncloseruleOnClick()
	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function HeroGroupFightViewRule:_btnadditionRuleOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self._ruleList,
		closeCb = self._btncloseruleOnClick,
		closeCbObj = self
	})

	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

function HeroGroupFightViewRule:_editableInitView()
	gohelper.setActive(self._goruletemp, false)

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._simageList = self:getUserDataTb_()
end

function HeroGroupFightViewRule:onOpen()
	self:_refreshUI()
end

function HeroGroupFightViewRule:_refreshUI()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._battleId = HeroGroupModel.instance.battleId

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local roleLv, talent, equipLv = HeroGroupBalanceHelper.getBalanceLv()

	if roleLv then
		gohelper.setActive(self._gobalance, true)

		self._txtBalanceRoleLv.text = HeroConfig.instance:getCommonLevelDisplay(roleLv)
		self._txtBalanceEquipLv.text = equipLv .. luaLang("level")
		self._txtBalanceTalent.text = talent .. luaLang("level")
	else
		gohelper.setActive(self._gobalance, false)
	end

	self._isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard

	if chapterConfig.type == DungeonEnum.ChapterType.Normal then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	local ruleList = self:_getRuleList(episodeConfig)

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

function HeroGroupFightViewRule:_getRuleList(episodeConfig)
	local battleCo = lua_battle.configDict[self._battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""
			local ruleList = FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#")

			if episodeConfig.type == DungeonEnum.EpisodeType.Meilanni then
				ruleList = HeroGroupFightViewRule.meilanniExcludeRules(ruleList)
			end

			return ruleList
		end
	end
end

function HeroGroupFightViewRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)
	table.insert(self._cloneRuleGos, go)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function HeroGroupFightViewRule:_clearRules()
	for i = #self._cloneRuleGos, 1, -1 do
		gohelper.destroy(self._cloneRuleGos[i])

		self._cloneRuleGos[i] = nil
	end
end

function HeroGroupFightViewRule.meilanniExcludeRules(ruleList)
	if not ruleList or #ruleList == 0 then
		return
	end

	local mapId = MeilanniModel.instance:getCurMapId()

	if mapId then
		::label_12_0::

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

function HeroGroupFightViewRule:onDestroyView()
	return
end

return HeroGroupFightViewRule
