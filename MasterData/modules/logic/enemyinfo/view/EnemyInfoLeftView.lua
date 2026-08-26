-- chunkname: @modules/logic/enemyinfo/view/EnemyInfoLeftView.lua

module("modules.logic.enemyinfo.view.EnemyInfoLeftView", package.seeall)

local EnemyInfoLeftView = class("EnemyInfoLeftView", BaseView)

function EnemyInfoLeftView:onInitView()
	self._gorulecontainer = gohelper.findChild(self.viewGO, "#go_left_container/#go_rule_container")
	self._goruleitem = gohelper.findChild(self.viewGO, "#go_left_container/#go_rule_container/#go_ruleitem")
	self._goline1 = gohelper.findChild(self.viewGO, "#go_left_container/#go_line1")
	self._scrollenemy = gohelper.findChildScrollRect(self.viewGO, "#go_left_container/#scroll_enemy")
	self._gopoolcontainer = gohelper.findChild(self.viewGO, "#go_left_container/#go_pool_container")
	self._goenemygrouppool = gohelper.findChild(self.viewGO, "#go_left_container/#go_pool_container/#go_enemygroup_pool")
	self._goenemygroupitem = gohelper.findChild(self.viewGO, "#go_left_container/#go_pool_container/#go_enemygroup_pool/#go_enemygroupitem")
	self._goenemyitempool = gohelper.findChild(self.viewGO, "#go_left_container/#go_pool_container/#go_enemyitem_pool")
	self._goenemyitem = gohelper.findChild(self.viewGO, "#go_left_container/#go_pool_container/#go_enemyitem_pool/#go_enemyitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoLeftView:addEvents()
	return
end

function EnemyInfoLeftView:removeEvents()
	return
end

function EnemyInfoLeftView:onClickRule()
	local lineShowRuleCount = math.floor(self.layoutMo.scrollEnemyWidth / EnemyInfoEnum.RuleItemWeight)
	local rightRuleItem = self.ruleItemList[(lineShowRuleCount > #self.ruleItemList or nil) and #self.ruleItemList]
	local tr = rightRuleItem.go:GetComponent(gohelper.Type_Transform)
	local anchorX, _ = recthelper.worldPosToAnchorPos2(tr.position, self.ruleTipContainerRectTr)

	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		pivot = CommonBuffTipEnum.Pivot.Left,
		offSet = {
			anchorX + EnemyInfoEnum.TipOffsetX,
			428.76
		},
		ruleList = self._ruleList
	})
end

function EnemyInfoLeftView:_editableInitView()
	gohelper.setActive(self._goruleitem, false)
	gohelper.setActive(self._goenemygroupitem, false)
	gohelper.setActive(self._goenemyitem, false)
	gohelper.setActive(self._gopoolcontainer, false)

	self.ruleTipContainerRectTr = gohelper.findChildComponent(self.viewGO, "#go_tip_container", gohelper.Type_RectTransform)
	self.ruleTipRectTr = gohelper.findChildComponent(self.viewGO, "#go_tip_container/#go_ruletip", gohelper.Type_RectTransform)
	self.trScrollContent = gohelper.findChildComponent(self._scrollenemy.gameObject, "viewport/content", gohelper.Type_Transform)
	self.enemyGroupPoolTr = self._goenemygrouppool:GetComponent(gohelper.Type_Transform)
	self.enemyItemPoolTr = self._goenemyitempool:GetComponent(gohelper.Type_Transform)
	self.ruleClick = gohelper.getClickWithDefaultAudio(self._gorulecontainer, self)

	self.ruleClick:AddClickListener(self.onClickRule, self)

	self.ruleLineCount = 0
	self.ruleItemPool = {}
	self.ruleItemList = {}
	self.ruleTipItemPool = {}
	self.ruleTipItemList = {}
	self.enemyGroupPool = {}
	self.enemyGroupList = {}
	self.enemyItemList = {}
	self.enemyItemPool = {
		[0] = {}
	}

	for key, _ in pairs(IconMaterialMgr.instance.variantIdToMaterialPath) do
		self.enemyItemPool[key] = {}
	end

	self.addEventCb(self, EnemyInfoController.instance, EnemyInfoEvent.SelectMonsterChange, self.onSelectMonsterChange, self)
	self.addEventCb(self, EnemyInfoController.instance, EnemyInfoEvent.UpdateBattleInfo, self.onUpdateBattleInfo, self)
end

function EnemyInfoLeftView:onSelectMonsterChange(eventData)
	self.selectEnemyIndex = eventData.enemyIndex

	for index, enemyItem in ipairs(self.enemyItemList) do
		gohelper.setActive(enemyItem.selectframe, self.selectEnemyIndex == index)
	end
end

function EnemyInfoLeftView:onUpdateBattleInfo(battleId)
	if self.battleId == battleId then
		return
	end

	self.battleId = battleId
	self.battleCo = lua_battle.configDict[self.battleId]

	self:refreshUI()
	self:selectFirstMonster()
end

function EnemyInfoLeftView:selectFirstMonster()
	local firstItem = self.enemyItemList[1]

	self.eventData = self.eventData or {}
	self.eventData.monsterId = firstItem.monsterId
	self.eventData.isBoss = firstItem.isBoss
	self.eventData.enemyIndex = 1

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.SelectMonsterChange, self.eventData)
end

function EnemyInfoLeftView:refreshUI()
	self:refreshRule()
	self:refreshScrollEnemy()
end

function EnemyInfoLeftView:refreshRule()
	self:recycleAllRuleItem()
	self:recycleAllRuleTipItem()

	local additionRule = self.battleCo.additionRule

	if string.nilorempty(additionRule) then
		gohelper.setActive(self._goline1, false)
		gohelper.setActive(self._gorulecontainer, false)

		return
	end

	gohelper.setActive(self._gorulecontainer, true)

	local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

	self._ruleList = ruleList

	self:filterRule(ruleList)

	for _, v in ipairs(ruleList) do
		local targetId = v[1]
		local ruleId = v[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			self:addRuleItem(ruleCo, targetId)
		end
	end

	gohelper.setActive(self._goline1, #ruleList > 0)

	local lastRuleTipItem = self.ruleTipItemList[#self.ruleTipItemList]

	if lastRuleTipItem then
		gohelper.setActive(lastRuleTipItem.goLine, false)
	end
end

function EnemyInfoLeftView:filterRule(ruleList)
	if self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Season123 then
		local rule = Season123Config.instance:getSeasonConstStr(self.viewParam.activityId, Activity123Enum.Const.HideRule)
		local hideRuleList = string.splitToNumber(rule, "#")

		for i = #ruleList, 1, -1 do
			if tabletool.indexOf(hideRuleList, ruleList[i][2]) then
				table.remove(ruleList, i)
			end
		end
	end
end

function EnemyInfoLeftView:refreshScrollEnemy()
	local groupIds = self.battleCo.monsterGroupIds

	if string.nilorempty(groupIds) then
		return
	end

	self:recycleAllEnemyGroupList()
	self:recycleAllEnemyItemList()

	if self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.TowerDeep then
		self:addTowerDeepGroupItem()

		return
	elseif self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.TowerCompose then
		self:addTowerComposeGroupItem()

		return
	end

	local groupIdList = string.splitToNumber(groupIds, "#")

	for index, groupId in ipairs(groupIdList) do
		self:addGroupItem(groupId, index)
	end
end

function EnemyInfoLeftView:recycleAllRuleItem()
	for _, ruleItem in ipairs(self.ruleItemList) do
		gohelper.setActive(ruleItem.go, false)
		table.insert(self.ruleItemPool, ruleItem)
	end

	tabletool.clear(self.ruleItemList)
end

function EnemyInfoLeftView:recycleAllRuleTipItem()
	for _, ruleTipItem in ipairs(self.ruleTipItemList) do
		gohelper.setActive(ruleTipItem.go, false)
		table.insert(self.ruleTipItemPool, ruleTipItem)
	end

	tabletool.clear(self.ruleTipItemList)
end

function EnemyInfoLeftView:addRuleItem(ruleCo, targetId)
	if not ruleCo then
		logError("rule co nil")

		return
	end

	local ruleItem = self:getRuleItem()

	UISpriteSetMgr.instance:setCommonSprite(ruleItem.tagIcon, "wz_" .. targetId)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(ruleItem.ruleIcon, ruleCo.icon)
end

function EnemyInfoLeftView:getRuleItem()
	if #self.ruleItemPool > 0 then
		local ruleItem = table.remove(self.ruleItemPool)

		table.insert(self.ruleItemList, ruleItem)
		gohelper.setActive(ruleItem.go, true)
		gohelper.setAsLastSibling(ruleItem.go)

		return ruleItem
	end

	local ruleItem = self:getUserDataTb_()

	ruleItem.go = gohelper.cloneInPlace(self._goruleitem)
	ruleItem.ruleIcon = gohelper.findChildImage(ruleItem.go, "#image_ruleicon")
	ruleItem.tagIcon = gohelper.findChildImage(ruleItem.go, "#image_ruleicon/#image_tagicon")

	gohelper.setActive(ruleItem.go, true)
	table.insert(self.ruleItemList, ruleItem)

	return ruleItem
end

function EnemyInfoLeftView:recycleAllEnemyGroupList()
	for _, enemyGroupItem in ipairs(self.enemyGroupList) do
		gohelper.setActive(enemyGroupItem.go, false)
		enemyGroupItem.tr:SetParent(self.enemyGroupPoolTr)
		table.insert(self.enemyGroupPool, enemyGroupItem)
	end

	tabletool.clear(self.enemyGroupList)
end

function EnemyInfoLeftView:recycleAllEnemyItemList()
	for _, enemyItem in ipairs(self.enemyItemList) do
		gohelper.setActive(enemyItem.go, false)
		enemyItem.tr:SetParent(self.enemyItemPoolTr)

		enemyItem.monsterId = nil

		table.insert(self.enemyItemPool[enemyItem.variantId], enemyItem)
	end

	tabletool.clear(self.enemyItemList)
end

function EnemyInfoLeftView:getEnemyGroupItem()
	if #self.enemyGroupPool > 0 then
		local enemyGroupItem = table.remove(self.enemyGroupPool)

		table.insert(self.enemyGroupList, enemyGroupItem)
		recthelper.setWidth(enemyGroupItem.tr, self.layoutMo.scrollEnemyWidth)
		recthelper.setWidth(enemyGroupItem.trContent, self.layoutMo.scrollEnemyWidth - EnemyInfoEnum.EnemyGroupLeftMargin)
		gohelper.setActive(enemyGroupItem.go, true)
		gohelper.setAsLastSibling(enemyGroupItem.go)

		return enemyGroupItem
	end

	local enemyGroupItem = self:getUserDataTb_()

	enemyGroupItem.go = gohelper.cloneInPlace(self._goenemygroupitem)
	enemyGroupItem.tr = enemyGroupItem.go:GetComponent(gohelper.Type_Transform)
	enemyGroupItem.txtTitleNum = gohelper.findChildText(enemyGroupItem.go, "title/#txt_titlenum")
	enemyGroupItem.trContent = gohelper.findChildComponent(enemyGroupItem.go, "content", gohelper.Type_RectTransform)

	recthelper.setWidth(enemyGroupItem.tr, self.layoutMo.scrollEnemyWidth)
	recthelper.setWidth(enemyGroupItem.trContent, self.layoutMo.scrollEnemyWidth - EnemyInfoEnum.EnemyGroupLeftMargin)
	gohelper.setActive(enemyGroupItem.go, true)
	table.insert(self.enemyGroupList, enemyGroupItem)

	return enemyGroupItem
end

function EnemyInfoLeftView:getEnemyItem(variantId)
	local pool = self.enemyItemPool[variantId]

	if not pool then
		logError("not variantId : " .. tostring(variantId) .. " pool")

		return nil
	end

	if #pool > 0 then
		local enemyItem = table.remove(pool)

		table.insert(self.enemyItemList, enemyItem)
		gohelper.setActive(enemyItem.go, true)
		gohelper.setAsLastSibling(enemyItem.go)

		return enemyItem
	end

	local enemyItem = self:getUserDataTb_()

	enemyItem.go = gohelper.cloneInPlace(self._goenemyitem)
	enemyItem.tr = enemyItem.go:GetComponent(gohelper.Type_Transform)
	enemyItem.icon = gohelper.findChildImage(enemyItem.go, "icon")
	enemyItem.career = gohelper.findChildImage(enemyItem.go, "career")
	enemyItem.selectframe = gohelper.findChild(enemyItem.go, "selectframe")
	enemyItem.bosstag = gohelper.findChild(enemyItem.go, "bosstag")

	gohelper.setActive(enemyItem.selectframe, false)

	enemyItem.btn = gohelper.findChildButtonWithAudio(enemyItem.go, "btn_click", AudioEnum.UI.Play_UI_Tags)

	enemyItem.btn:AddClickListener(self.onClickEnemyItem, self, enemyItem)

	enemyItem.variantId = variantId

	if variantId ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(variantId), enemyItem.icon)
	end

	gohelper.setActive(enemyItem.go, true)
	table.insert(self.enemyItemList, enemyItem)

	return enemyItem
end

function EnemyInfoLeftView:addGroupItem(groupId, index)
	local monsterGroupConfig = lua_monster_group.configDict[groupId]

	if not self.tempMonsterIdList then
		local bossIdList = string.splitToNumber(monsterGroupConfig.bossId, "#")

		tabletool.clear(self.tempMonsterIdList)

		if not string.nilorempty(monsterGroupConfig.monster) then
			tabletool.addValues(self.tempMonsterIdList, string.splitToNumber(monsterGroupConfig.monster, "#"))
		end

		if not string.nilorempty(monsterGroupConfig.spMonster) then
			tabletool.addValues(self.tempMonsterIdList, string.splitToNumber(monsterGroupConfig.spMonster, "#"))
		end

		if #self.tempMonsterIdList <= 0 then
			return
		end

		local enemyGroupItem = self:getEnemyGroupItem()

		enemyGroupItem.tr:SetParent(self.trScrollContent)

		enemyGroupItem.txtTitleNum.text = index

		for _, monsterId in ipairs(self.tempMonsterIdList) do
			self:addMonsterItem(monsterId, enemyGroupItem.trContent, bossIdList)
		end
	end
end

function EnemyInfoLeftView:addMonsterItem(monsterId, parent, bossIdList)
	local monsterConfig = lua_monster.configDict[monsterId]
	local enemyItem = self:getEnemyItem(monsterConfig.heartVariantId)

	enemyItem.tr:SetParent(parent)

	enemyItem.monsterId = monsterId
	enemyItem.isBoss = self:checkIsBoss(bossIdList, monsterId)
	enemyItem.enemyIndex = #self.enemyItemList

	local skinConfig = FightConfig.instance:getSkinCO(monsterConfig.skinId)

	gohelper.getSingleImage(enemyItem.icon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))

	if self.viewParam and self.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Sodache then
		gohelper.setActive(enemyItem.career, false)
	else
		UISpriteSetMgr.instance:setEnemyInfoSprite(enemyItem.career, "sxy_" .. monsterConfig.career)
	end

	gohelper.setActive(enemyItem.bosstag, enemyItem.isBoss)
end

function EnemyInfoLeftView:checkIsBoss(bossIdList, monsterId)
	for _, v in ipairs(bossIdList) do
		if monsterId == v then
			return true
		end
	end

	return false
end

function EnemyInfoLeftView:onClickEnemyItem(enemyItem)
	self.eventData = self.eventData or {}
	self.eventData.monsterId = enemyItem.monsterId
	self.eventData.isBoss = enemyItem.isBoss
	self.eventData.enemyIndex = enemyItem.enemyIndex

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.SelectMonsterChange, self.eventData)
end

function EnemyInfoLeftView:addTowerDeepGroupItem()
	local enemyGroupItem = self:getEnemyGroupItem()

	enemyGroupItem.tr:SetParent(self.trScrollContent)

	enemyGroupItem.txtTitleNum.text = 1

	local monsterId = TowerPermanentDeepModel.instance:getCurDeepMonsterId()

	self:addMonsterItem(monsterId, enemyGroupItem.trContent, {
		monsterId
	})
end

function EnemyInfoLeftView:addTowerComposeGroupItem()
	local themeId = self.viewParam.themeId
	local planeId = self.viewParam.planeId
	local themeConfig = TowerComposeConfig.instance:getThemeConfig(themeId)
	local bossMonsterGroupId = themeConfig.monsterGroupId
	local bossGroupConfig = lua_monster_group.configDict[bossMonsterGroupId]
	local bossIdList = string.splitToNumber(bossGroupConfig.bossId, "#")
	local bossMonsterIdList = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[bossMonsterGroupId].monster, "#")
	local curBossMonsterIdList, curBossIdList = TowerComposeModel.instance:getPlaneBossIdList(themeId, planeId, bossMonsterIdList, bossIdList)
	local groupIds = self.battleCo.monsterGroupIds
	local groupIdList = string.splitToNumber(groupIds, "#")

	for index, groupId in ipairs(groupIdList) do
		if groupId ~= bossMonsterGroupId then
			local monsterGroupConfig = lua_monster_group.configDict[groupId]

			if not self.tempMonsterIdList then
				if not string.nilorempty(monsterGroupConfig.monster) then
					tabletool.addValues(self.tempMonsterIdList, string.splitToNumber(monsterGroupConfig.monster, "#"))
				end

				local enemyGroupItem = self:getEnemyGroupItem()

				enemyGroupItem.tr:SetParent(self.trScrollContent)

				enemyGroupItem.txtTitleNum.text = index

				for _, monsterId in ipairs(self.tempMonsterIdList) do
					self:addMonsterItem(monsterId, enemyGroupItem.trContent, curBossIdList)
				end
			end
		end
	end

	local enemyGroupItem = self:getEnemyGroupItem()

	enemyGroupItem.tr:SetParent(self.trScrollContent)

	enemyGroupItem.txtTitleNum.text = tabletool.indexOf(groupIdList, bossMonsterGroupId)

	for _, monsterId in ipairs(curBossMonsterIdList) do
		self:addMonsterItem(monsterId, enemyGroupItem.trContent, curBossIdList)
	end
end

function EnemyInfoLeftView:onClose()
	return
end

function EnemyInfoLeftView:onDestroyView()
	self.ruleClick:RemoveClickListener()

	for _, enemyItem in ipairs(self.enemyItemList) do
		enemyItem.btn:RemoveClickListener()
	end

	for _, pool in pairs(self.enemyItemPool) do
		for _, enemyItem in ipairs(pool) do
			enemyItem.btn:RemoveClickListener()
		end
	end
end

return EnemyInfoLeftView
