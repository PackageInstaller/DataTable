-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonEscapeRuleComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonEscapeRuleComp", package.seeall)

local Act183DungeonEscapeRuleComp = class("Act183DungeonEscapeRuleComp", Act183DungeonBaseComp)

function Act183DungeonEscapeRuleComp:init(go)
	Act183DungeonEscapeRuleComp.super.init(self, go)

	self._goescaperuleitem = gohelper.findChild(self.go, "#go_escaperules/#go_escaperuleitem")
	self._escapeRuleItemTab = self:getUserDataTb_()
end

function Act183DungeonEscapeRuleComp:addEventListeners()
	return
end

function Act183DungeonEscapeRuleComp:removeEventListeners()
	return
end

function Act183DungeonEscapeRuleComp:updateInfo(episodeMo)
	Act183DungeonEscapeRuleComp.super.updateInfo(self, episodeMo)

	self._escapeRules = self._groupEpisodeMo:getEscapeRules(self._episodeId)
	self._maxPassOrder = self._groupEpisodeMo:findMaxPassOrder()
end

function Act183DungeonEscapeRuleComp:checkIsVisible()
	if self._escapeRules then
		local hasEscapeRules = #self._escapeRules > 0

		return hasEscapeRules
	end
end

function Act183DungeonEscapeRuleComp:show()
	Act183DungeonEscapeRuleComp.super.show(self)

	self._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(self._episodeId)
	self._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(self._hasPlayRefreshAnimRuleIds)
	self._needFocusEscapeRule = false
	self._needFocusMinRuleIndex = 100

	self:createObjList(self._escapeRules, self._escapeRuleItemTab, self._goescaperuleitem, self._initEscapeRuleItemFunc, self._refreshEscapeRuleItemFunc, self._defaultItemFreeFunc)

	if self._needFocusEscapeRule then
		self.mgr:focus(Act183DungeonEscapeRuleComp, self._needFocusMinRuleIndex)
	end

	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(self._episodeId, self._hasPlayRefreshAnimRuleIds)
end

function Act183DungeonEscapeRuleComp:_initEscapeRuleItemFunc(goItem)
	goItem.txtdesc = gohelper.findChildText(goItem.go, "txt_desc")
	goItem.imageicon = gohelper.findChildImage(goItem.go, "image_icon")
	goItem.anim = gohelper.onceAddComponent(goItem.go, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(goItem.txtdesc)
end

function Act183DungeonEscapeRuleComp:_refreshEscapeRuleItemFunc(goItem, escapeInfo, index)
	local episodeId = escapeInfo.episodeId
	local ruleIndex = escapeInfo.ruleIndex

	goItem.txtdesc.text = SkillHelper.buildDesc(escapeInfo.ruleDesc)

	Act183Helper.setRuleIcon(episodeId, ruleIndex, goItem.imageicon)

	if self._maxPassOrder then
		local isLastEscapeRule = escapeInfo.passOrder == self._maxPassOrder
		local key = string.format("%s_%s", episodeId, ruleIndex)
		local hasPlayRefreshAnim = self._hasPlayRefreshAnimRuleIdMap[key] ~= nil
		local isNeedPlayRefreshAnim = isLastEscapeRule and not hasPlayRefreshAnim

		goItem.anim:Play(isNeedPlayRefreshAnim and "in" or "idle", 0, 0)

		if isNeedPlayRefreshAnim then
			self._hasPlayRefreshAnimRuleIdMap[key] = true

			table.insert(self._hasPlayRefreshAnimRuleIds, key)

			self._needFocusEscapeRule = true
			self._needFocusMinRuleIndex = index < self._needFocusMinRuleIndex and index or self._needFocusMinRuleIndex
		end
	end
end

function Act183DungeonEscapeRuleComp:focus(minFocusIndex)
	local offset = 0

	minFocusIndex = minFocusIndex or 1

	local goEscapeRuleItem = self._escapeRuleItemTab[minFocusIndex]

	if not goEscapeRuleItem then
		return offset
	end

	for i = 1, #self._escapeRuleItemTab do
		if minFocusIndex <= i then
			break
		end

		local escapeRuleItemGo = self._escapeRuleItemTab[i].go
		local itemHeight = recthelper.getHeight(escapeRuleItemGo.transform)

		offset = offset + itemHeight
	end

	return offset
end

function Act183DungeonEscapeRuleComp:onDestroy()
	Act183DungeonEscapeRuleComp.super.onDestroy(self)
end

return Act183DungeonEscapeRuleComp
