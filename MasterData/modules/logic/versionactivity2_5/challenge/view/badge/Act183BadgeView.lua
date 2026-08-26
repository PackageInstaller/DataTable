-- chunkname: @modules/logic/versionactivity2_5/challenge/view/badge/Act183BadgeView.lua

module("modules.logic.versionactivity2_5.challenge.view.badge.Act183BadgeView", package.seeall)

local Act183BadgeView = class("Act183BadgeView", BaseView)

function Act183BadgeView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._txtbadgecount = gohelper.findChildText(self.viewGO, "root/left/#txt_badgecount")
	self._scrolldaily = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_daily")
	self._goheroitem = gohelper.findChild(self.viewGO, "root/right/#scroll_daily/Viewport/Content/#go_heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183BadgeView:addEvents()
	return
end

function Act183BadgeView:removeEvents()
	return
end

function Act183BadgeView:_editableInitView()
	self._actInfo = Act183Model.instance:getActInfo()
	self._activityId = Act183Model.instance:getActivityId()
	self._curBadgeNum = Act183Model.instance:getBadgeNum()
	self._maxBadgeNum = Act183Helper.getMaxBadgeNum()
	self._badgeCos = Act183Config.instance:getActivityBadgeCos(self._activityId)
	self._heroItemTab = self:getUserDataTb_()
	self._heroMoList = self:getUserDataTb_()
	self._needPlayAnimHeroItems = self:getUserDataTb_()
	self._leftAnim = gohelper.findChildComponent(self.viewGO, "root/left", gohelper.Type_Animator)
end

function Act183BadgeView:onUpdateParam()
	return
end

function Act183BadgeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenBadgeView)
	self:refreshPreBadge()
	self:refreshSupportHeros()
	self:saveHasReadUnlockSupportHeroIds()
end

function Act183BadgeView:onOpenFinish()
	self:playHeroItemAnim()
	self:refreshCurBadge()
end

function Act183BadgeView:refreshPreBadge()
	self._lastSaveBadgeNum = Act183Helper.getLastTotalBadgeNumInLocal(self._activityId)
	self._txtbadgecount.text = string.format("<size=64>%s</size>/%s", self._lastSaveBadgeNum, self._maxBadgeNum)
end

function Act183BadgeView:refreshCurBadge()
	local refresh = self._lastSaveBadgeNum ~= self._curBadgeNum

	self._leftAnim:Play(refresh and "refresh" or "idle", 0, 0)

	self._txtbadgecount.text = string.format("<size=64>%s</size>/%s", self._curBadgeNum, self._maxBadgeNum)

	Act183Helper.saveLastTotalBadgeNumInLocal(self._activityId, self._curBadgeNum)
end

function Act183BadgeView:refreshSupportHeros()
	if not self._badgeCos then
		return
	end

	local hasReadUnlockHeroIds = Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(self._activityId)

	self._hasReadUnlockHeroIdMap = Act183Helper.listToMap(hasReadUnlockHeroIds)
	self._unlockSupportHeroIndex = 0

	for _, badgeCo in ipairs(self._badgeCos) do
		local unlockSupportHeroId = badgeCo.unlockSupport

		if unlockSupportHeroId and unlockSupportHeroId ~= 0 then
			self:refreshSingleHeroItem(badgeCo, unlockSupportHeroId)
		end
	end
end

function Act183BadgeView:_getOrCreateHeroItem(index)
	local heroItem = self._heroItemTab[index]

	if not heroItem then
		heroItem = self:getUserDataTb_()
		heroItem.viewGO = gohelper.cloneInPlace(self._goheroitem, "heroitem_" .. index)
		heroItem.golock = gohelper.findChild(heroItem.viewGO, "go_lock")
		heroItem.txtcost = gohelper.findChildText(heroItem.viewGO, "go_lock/txt_cost")
		heroItem.goPos = gohelper.findChild(heroItem.viewGO, "go_pos")
		heroItem.icon = IconMgr.instance:getCommonHeroItem(heroItem.goPos)

		heroItem.icon:setStyle_CharacterBackpack()

		heroItem.animator = gohelper.onceAddComponent(heroItem.golock, gohelper.Type_Animator)
		heroItem.btnclick = gohelper.findChildButtonWithAudio(heroItem.viewGO, "btn_click")

		heroItem.btnclick:AddClickListener(self._onClickHeroItem, self, index)

		heroItem.heroMo = HeroMo.New()
		self._heroItemTab[index] = heroItem
	end

	return heroItem
end

function Act183BadgeView:_onClickHeroItem(index)
	local heroItem = self._heroItemTab[index]

	if not heroItem then
		return
	end

	local heroList = {}

	for _, heroItem in ipairs(self._heroItemTab) do
		table.insert(heroList, heroItem.heroMo)
	end

	CharacterController.instance:openCharacterView(heroItem.heroMo, heroList)
end

function Act183BadgeView:refreshSingleHeroItem(badgeCo, unlockSupportHeroId)
	local unlockSupportCo = lua_hero_trial.configDict[unlockSupportHeroId][0]

	if unlockSupportCo then
		self._unlockSupportHeroIndex = self._unlockSupportHeroIndex + 1

		local heroItem = self:_getOrCreateHeroItem(self._unlockSupportHeroIndex)

		heroItem.heroMo:initFromTrial(unlockSupportHeroId)
		heroItem.icon:onUpdateMO(heroItem.heroMo)

		heroItem.txtcost.text = badgeCo.num

		gohelper.setActive(heroItem.viewGO, true)

		local isLock = badgeCo.num > self._curBadgeNum
		local isNewUnlock = not isLock and self._hasReadUnlockHeroIdMap[unlockSupportHeroId] == nil

		gohelper.setActive(heroItem.golock, isLock or isNewUnlock)

		if isLock or isNewUnlock then
			self._needPlayAnimHeroItems[heroItem] = isNewUnlock and "unlock" or "open"
		end
	else
		logError(string.format("缺少支援角色配置 : badgeNum = %s, supportHeroId = %s", badgeCo.num, badgeCo.unlockSupport))
	end
end

function Act183BadgeView:playHeroItemAnim()
	if self._needPlayAnimHeroItems then
		for heroItem, animName in pairs(self._needPlayAnimHeroItems) do
			heroItem.animator:Play(animName, 0, 0)
		end
	end
end

function Act183BadgeView:releaseAllHeroItems()
	if self._heroItemTab then
		for _, heroItem in pairs(self._heroItemTab) do
			heroItem.btnclick:RemoveClickListener()
		end
	end
end

function Act183BadgeView:saveHasReadUnlockSupportHeroIds()
	local unlockSupportHeroIds = self._actInfo:getUnlockSupportHeroIds()

	Act183Helper.saveHasReadUnlockSupportHeroIdsInLocal(self._activityId, unlockSupportHeroIds)
	Act183Controller.instance:dispatchEvent(Act183Event.RefreshMedalReddot)
end

function Act183BadgeView:onClose()
	self:releaseAllHeroItems()
end

function Act183BadgeView:onDestroyView()
	return
end

return Act183BadgeView
