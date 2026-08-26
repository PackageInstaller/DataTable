-- chunkname: @modules/logic/rouge/view/RougeHeroGroupFightViewRule.lua

module("modules.logic.rouge.view.RougeHeroGroupFightViewRule", package.seeall)

local RougeHeroGroupFightViewRule = class("RougeHeroGroupFightViewRule", BaseView)

function RougeHeroGroupFightViewRule:onInitView()
	self._goadditionRule = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	self._goruletemp = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._gorulelist = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._gobalance = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance")
	self._txtBalanceRoleLv = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/roleLvTxtbg/roleLvTxt/#txt_roleLv")
	self._txtBalanceEquipLv = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/equipLvTxtbg/equipLvTxt/#txt_equipLv")
	self._txtBalanceTalent = gohelper.findChildTextMesh(self.viewGO, "#go_container/#scroll_info/infocontain/#go_balance/balancecontain/talentTxtbg/talentTxt/#txt_talent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeHeroGroupFightViewRule:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function RougeHeroGroupFightViewRule:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function RougeHeroGroupFightViewRule:_btncloseruleOnClick()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
end

function RougeHeroGroupFightViewRule:_btnadditionRuleOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self._ruleList,
		closeCb = self._btncloseruleOnClick,
		closeCbObj = self
	})
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
end

function RougeHeroGroupFightViewRule:_editableInitView()
	gohelper.setActive(self._goruleitem, false)
	gohelper.setActive(self._goruletemp, false)
	gohelper.setActive(self._goruledesc, false)

	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._simageList = self:getUserDataTb_()
end

local NormalTagColor = "#E6E6E6"
local SurpriseTagColor = "#C86A6A"

function RougeHeroGroupFightViewRule:_addRuleItem(ruleCo, targetId, isSurpriseRule)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)
	table.insert(self._cloneRuleGos, go)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
	SLFramework.UGUI.GuiHelper:SetColor((isSurpriseRule or nil) and (SurpriseTagColor or NormalTagColor))
end

function RougeHeroGroupFightViewRule:onOpen()
	self:_refreshUI()
end

function RougeHeroGroupFightViewRule:_refreshUI()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._battleId = HeroGroupModel.instance.battleId

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local roleLv, talent, equipLv = HeroGroupBalanceHelper.getBalanceLv()

	if roleLv then
		gohelper.setActive(self._gobalance, true)
	else
		gohelper.setActive(self._gobalance, false)
	end

	self._isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard

	if chapterConfig.type == DungeonEnum.ChapterType.Normal then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	local battleCo = lua_battle.configDict[self._battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""
			local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

			if episodeConfig.type == DungeonEnum.EpisodeType.Meilanni then
				ruleList = RougeHeroGroupFightViewRule.meilanniExcludeRules(ruleList)
			end

			if ruleList then
				if not #ruleList then
					local normalRuleCount = 0

					ruleList = self:_addRougeSurpriseAdditionRules(ruleList)

					if not ruleList or #ruleList == 0 then
						gohelper.setActive(self._goadditionRule, false)

						return
					end

					self._cloneRuleGos = self._cloneRuleGos or self:getUserDataTb_()

					self:_clearRules()
					gohelper.setActive(self._goadditionRule, true)

					self._ruleList = ruleList

					for i, v in ipairs(ruleList) do
						local targetId = v[1]
						local ruleId = v[2]
						local ruleCo = lua_rule.configDict[ruleId]

						if ruleCo then
							local isSurpriseRule = normalRuleCount < i

							self:_addRuleItem(ruleCo, targetId, isSurpriseRule)
						end

						if i == #ruleList then
							gohelper.setActive(self._rulesimagelineList[i], false)
						end
					end
				end
			end
		end
	end
end

function RougeHeroGroupFightViewRule:_addRougeSurpriseAdditionRules(ruleList)
	ruleList = ruleList or {}

	local curNode = RougeMapModel.instance:getCurNode()
	local eventMo = curNode and curNode.eventMo
	local supriseAttackList = eventMo and eventMo:getSurpriseAttackList()

	if supriseAttackList then
		for _, supriseAttackId in ipairs(supriseAttackList) do
			local surpriseAttackCo = lua_rouge_surprise_attack.configDict[supriseAttackId]

			if surpriseAttackCo and not string.nilorempty(surpriseAttackCo.additionRule) then
				local infos = GameUtil.splitString2(surpriseAttackCo.additionRule, true, "|", "#")

				tabletool.addValues(ruleList, infos)
			end
		end
	end

	return ruleList
end

function RougeHeroGroupFightViewRule:_clearRules()
	for i = #self._cloneRuleGos, 1, -1 do
		gohelper.destroy(self._cloneRuleGos[i])

		self._cloneRuleGos[i] = nil
	end
end

function RougeHeroGroupFightViewRule.meilanniExcludeRules(ruleList)
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

function RougeHeroGroupFightViewRule:onDestroyView()
	return
end

return RougeHeroGroupFightViewRule
