-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonRewardRuleComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRewardRuleComp", package.seeall)

local Act183DungeonRewardRuleComp = class("Act183DungeonRewardRuleComp", Act183DungeonBaseComp)

function Act183DungeonRewardRuleComp:init(go)
	Act183DungeonRewardRuleComp.super.init(self, go)

	self._gorewarditem = gohelper.findChild(self.go, "#go_rewards/#go_rewarditem")
	self._rewardRuleItemTab = self:getUserDataTb_()
end

function Act183DungeonRewardRuleComp:addEventListeners()
	return
end

function Act183DungeonRewardRuleComp:removeEventListeners()
	return
end

function Act183DungeonRewardRuleComp:updateInfo(episodeMo)
	Act183DungeonRewardRuleComp.super.updateInfo(self, episodeMo)

	self._subEpisodeConditions = Act183Config.instance:getGroupSubEpisodeConditions(self._activityId, self._groupId)

	self:initSelectConditionMap()
end

function Act183DungeonRewardRuleComp:initSelectConditionMap()
	self._selectConditionMap = {}
	self._selectConditionIds = {}
	self._passFightConditionIds = self._groupEpisodeMo:getAllPassConditionIds(self._episodeId)

	for _, passConditionId in ipairs(self._passFightConditionIds) do
		self._selectConditionMap[passConditionId] = true

		table.insert(self._selectConditionIds, passConditionId)
	end
end

function Act183DungeonRewardRuleComp:checkIsVisible()
	return self._episodeType == Act183Enum.EpisodeType.Boss and self._groupType ~= Act183Enum.GroupType.Daily
end

function Act183DungeonRewardRuleComp:show()
	Act183DungeonRewardRuleComp.super.show(self)

	self._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(self._episodeId)
	self._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(self._hasPlayRefreshAnimRuleIds)
	self._needFocusEscapeRule = false

	self:createObjList(self._subEpisodeConditions, self._rewardRuleItemTab, self._gorewarditem, self._initRewardRuleItemFunc, self._refreshRewardRuleItemFunc, self._defaultItemFreeFunc)
	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(self._episodeId, self._hasPlayRefreshAnimRuleIds)
end

function Act183DungeonRewardRuleComp:_initRewardRuleItemFunc(rewardItem, index)
	rewardItem.goselectbg = gohelper.findChild(rewardItem.go, "btn_check/#go_BG1")
	rewardItem.gounselectbg = gohelper.findChild(rewardItem.go, "btn_check/#go_BG2")
	rewardItem.imageicon = gohelper.findChildImage(rewardItem.go, "image_icon")
	rewardItem.txtcondition = gohelper.findChildText(rewardItem.go, "txt_condition")

	SkillHelper.addHyperLinkClick(rewardItem.txtcondition)

	rewardItem.txteffect = gohelper.findChildText(rewardItem.go, "txt_effect")
	rewardItem.btncheck = gohelper.findChildButtonWithAudio(rewardItem.go, "btn_check")

	rewardItem.btncheck:AddClickListener(self._onClickRewardItem, self, index)

	rewardItem.goselect = gohelper.findChild(rewardItem.go, "btn_check/go_select")
end

function Act183DungeonRewardRuleComp:_onClickRewardItem(index)
	return
end

function Act183DungeonRewardRuleComp:_refreshRewardRuleItemFunc(rewardItem, conditionId, index)
	local conditionCo = Act183Config.instance:getConditionCo(conditionId)

	if not conditionCo then
		return
	end

	local conditionDesc = conditionCo.decs1
	local effectDesc = conditionCo.decs2

	rewardItem.txtcondition.text = SkillHelper.buildDesc(conditionDesc)
	rewardItem.txteffect.text = effectDesc

	local isSelectSubCondition = self._selectConditionMap[conditionId] == true
	local isConditionPass = self._groupEpisodeMo:isConditionPass(conditionId)

	ZProj.UGUIHelper.SetGrayscale(rewardItem.imageicon.gameObject, not isConditionPass)
	gohelper.setActive(rewardItem.goselect, isSelectSubCondition)
	gohelper.setActive(rewardItem.btncheck.gameObject, isConditionPass and self._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(rewardItem.goselectbg, isSelectSubCondition)
	gohelper.setActive(rewardItem.gounselectbg, not isSelectSubCondition and isConditionPass)
	gohelper.setActive(rewardItem.go, true)
	Act183Helper.setEpisodeConditionStar(rewardItem.imageicon, isConditionPass, isSelectSubCondition)
end

function Act183DungeonRewardRuleComp:_releaseRewardItemsFunc()
	if self._rewardRuleItemTab then
		for _, rewardItem in pairs(self._rewardRuleItemTab) do
			rewardItem.btncheck:RemoveClickListener()
		end
	end
end

function Act183DungeonRewardRuleComp:getSelectConditionMap()
	return self._selectConditionMap
end

function Act183DungeonRewardRuleComp:onDestroy()
	self:_releaseRewardItemsFunc()
	Act183DungeonRewardRuleComp.super.onDestroy(self)
end

return Act183DungeonRewardRuleComp
