-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191HeroGroupListView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupListView", package.seeall)

local Act191HeroGroupListView = class("Act191HeroGroupListView", BaseView)

function Act191HeroGroupListView:onInitView()
	self.imageLevel = gohelper.findChildImage(self.viewGO, "herogroupcontain/mainTitle/image_Level")
	self.btnEnhance = gohelper.findChildButtonWithAudio(self.viewGO, "herogroupcontain/mainTitle/btn_Enhance")
	self.heroContainer = gohelper.findChild(self.viewGO, "herogroupcontain/heroContainer")
	self.scrollFetter = gohelper.findChildScrollRect(self.viewGO, "herogroupcontain/scroll_Fetter")
	self.goFetterContent = gohelper.findChild(self.viewGO, "herogroupcontain/scroll_Fetter/Viewport/go_FetterContent")
	self.fetterItemList = {}

	local root = gohelper.findChild(self.viewGO, "herogroupcontain")

	self.animSwitch = root:GetComponent(gohelper.Type_Animator)
	self.goBoss = gohelper.findChild(self.viewGO, "herogroupcontain/go_Boss")
	self.simageBoss = gohelper.findChildSingleImage(self.goBoss, "simage_Boss")
	self.txtBossName = gohelper.findChildText(self.goBoss, "name/txt_BossName")
	self.imageBossCareer = gohelper.findChildImage(self.goBoss, "attribute/image_BossCareer")
	self.btnBoss = gohelper.findChildButtonWithAudio(self.goBoss, "btn_Boss")
	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.maxTeamSlot = self.gameInfo.mainTeamSize + self.gameInfo.subTeamSize

	self:initHeroInfoItem()
	self:initHeroAndEquipItem()
end

function Act191HeroGroupListView:addEvents()
	self.addClickCb(self, self.btnBoss, self._btnBossOnClick, self)
	self.addClickCb(self, self.btnEnhance, self._btnEnhanceOnClick, self)
end

function Act191HeroGroupListView:_btnBossOnClick()
	Act191StatController.instance:statButtonClick(self.viewName, "_btnBossOnClick")
	ViewMgr.instance:openView(ViewName.Act191AssistantView, self.summonIdList)
end

function Act191HeroGroupListView:_btnEnhanceOnClick()
	Act191StatController.instance:statButtonClick(self.viewName, "_btnEnhanceOnClick")
	ViewMgr.instance:openView(ViewName.Act191EnhanceView, {
		pos = Vector2(310, -80)
	})
end

function Act191HeroGroupListView:onOpen()
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateTeamInfo, self.refreshTeam, self)
	self:refreshTeam()

	local enhanceCnt = #self.gameInfo.warehouseInfo.enhanceId

	gohelper.setActive(self.btnEnhance, enhanceCnt ~= 0)
end

function Act191HeroGroupListView:onDestroyView()
	for _, item in ipairs(self.heroItemList) do
		CommonDragHelper.instance:unregisterDragObj(item.go)
	end

	TaskDispatcher.cancelTask(self.refreshTeam, self)
end

function Act191HeroGroupListView:initHeroInfoItem()
	self.heroInfoItemList = {}

	for i = 1, self.gameInfo.mainTeamSize do
		local heroInfoItem = self:getUserDataTb_()
		local go = gohelper.findChild(self.heroContainer, "bg" .. i)

		heroInfoItem.goIndex = gohelper.findChild(go, "Index")
		heroInfoItem.txtName = gohelper.findChildText(go, "Name")
		self.heroInfoItemList[i] = heroInfoItem
	end
end

function Act191HeroGroupListView:initHeroAndEquipItem()
	self.heroPosTrList = self:getUserDataTb_()
	self.equipPosTrList = self:getUserDataTb_()

	local recordPos = gohelper.findChild(self.viewGO, "herogroupcontain/recordPos")

	for i = 1, self.maxTeamSlot do
		local go = gohelper.findChild(recordPos, "heroPos" .. i)

		if go then
			self.heroPosTrList[i] = go.transform
		else
			logError("缺失Slot节点" .. i)
		end
	end

	local goHeroItem = gohelper.findChild(self.heroContainer, "go_HeroItem")
	local goEquipItem = gohelper.findChild(self.heroContainer, "go_EquipItem")

	self.heroItemList = {}

	for i = 1, self.maxTeamSlot do
		local cloneGo = gohelper.cloneInPlace(goHeroItem, "hero" .. i)
		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Act191HeroGroupItem1)

		heroItem:setIndex(i)

		self.heroItemList[i] = heroItem

		CommonDragHelper.instance:registerDragObj(cloneGo, self._onBeginDrag, nil, self._onEndDrag, self._checkDrag, self, i)
	end

	gohelper.setActive(goHeroItem, false)
	gohelper.setActive(goEquipItem, false)
end

function Act191HeroGroupListView:refreshTeam()
	local rankCfg = Activity191Config.instance:getRankCfg(self.gameInfo.rank)

	if rankCfg then
		UISpriteSetMgr.instance:setAct174Sprite(self.imageLevel, "act191_level_" .. string.lower(rankCfg.fightLevel))
	end

	for i = 1, self.maxTeamSlot do
		self:_setHeroItemPos(self.heroItemList[i], i)
	end

	local teamInfo = self.gameInfo:getTeamInfo()

	for i = 1, self.gameInfo.mainTeamSize do
		local info = Activity191Helper.matchKeyInArray(teamInfo.battleHeroInfo, i)

		if info then
			if not info.heroId then
				local heroId = 0

				self.heroItemList[i]:setData(heroId)

				local infoItem = self.heroInfoItemList[i]

				if infoItem then
					if heroId ~= 0 then
						local heroInfo = self.gameInfo:getHeroInfoInWarehouse(heroId)
						local roleCo = Activity191Config.instance:getRoleCoByNativeId(heroId, heroInfo.star)

						infoItem.txtName.text = roleCo.name
					end

					gohelper.setActive(infoItem.goIndex, heroId == 0)
					gohelper.setActive(infoItem.txtName, heroId ~= 0)
				end
			end
		end
	end

	for i = 1, self.gameInfo.subTeamSize do
		local subIndex = self.gameInfo.mainTeamSize + i
		local subInfo = Activity191Helper.matchKeyInArray(teamInfo.subHeroInfo, i)

		if subInfo then
			if not subInfo.heroId then
				local subHeroId = 0

				self.heroItemList[subIndex]:setData(subHeroId)
			end
		end
	end

	self:refreshFetter()

	self.summonIdList = self.gameInfo:getActiveSummonIdList()

	if next(self.summonIdList) then
		local summonCo = lua_activity191_summon.configDict[self.summonIdList[1]]

		if summonCo then
			self.txtBossName.text = summonCo.name

			UISpriteSetMgr.instance:setCommonSprite(self.imageBossCareer, "lssx_" .. summonCo.career)
			self.simageBoss:LoadImage(ResUrl.monsterHeadIcon(summonCo.headIcon))
		else
			logError("Act191召唤物表不存在ID：" .. tostring(self.summonIdList[1]))
		end

		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31503)
	end

	gohelper.setActive(self.goBoss, next(self.summonIdList))
end

function Act191HeroGroupListView:_checkDrag(param)
	local heroItem = self.heroItemList[param]

	if not heroItem.heroId or heroItem.heroId == 0 then
		return true
	end

	return false
end

function Act191HeroGroupListView:_onBeginDrag(param)
	local heroItem = self.heroItemList[param]

	if not heroItem then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	heroItem:setDrag(true)
end

function Act191HeroGroupListView:_onEndDrag(param, pointerEventData)
	local heroItem = self.heroItemList[param]

	if not heroItem then
		return
	end

	heroItem:setDrag(false)

	local toIndex = Activity191Helper.calcIndex(pointerEventData.position, self.heroPosTrList)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not toIndex or toIndex == param then
		self:_setHeroItemPos(heroItem, param, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local otherHeroItem = self.heroItemList[toIndex]

	gohelper.setAsLastSibling(otherHeroItem.go)

	self._tweenId = self:_setHeroItemPos(otherHeroItem, param, true)

	self._setHeroItemPos(self, heroItem, toIndex, true, function()
		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		self.gameInfo:exchangeHero(param, toIndex)
	end, self)
end

function Act191HeroGroupListView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self.heroPosTrList[index]
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.heroContainer.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act191HeroGroupListView:_checkDrag1(param)
	local equipItem = self.equipItemList[param]

	if not equipItem.itemUid or equipItem.itemUid == 0 then
		return true
	end

	return false
end

function Act191HeroGroupListView:_onBeginDrag1(param, pointerEventData)
	local equipItem = self.equipItemList[param]

	if not equipItem then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	equipItem:setDrag(true)
end

function Act191HeroGroupListView:_onEndDrag1(param, pointerEventData)
	local equipItem = self.equipItemList[param]

	if not equipItem then
		return
	end

	equipItem:setDrag(false)

	local toIndex = Activity191Helper.calcIndex(pointerEventData.position, self.equipPosTrList)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not toIndex or toIndex == param then
		self:_setEquipItemPos(equipItem, param, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local otherEquipItem = self.equipItemList[toIndex]

	gohelper.setAsLastSibling(otherEquipItem.go)

	self._tweenId = self:_setEquipItemPos(otherEquipItem, param, true)

	self._setEquipItemPos(self, equipItem, toIndex, true, function()
		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)
		self.gameInfo:exchangeItem(param, toIndex)
	end, self)
end

function Act191HeroGroupListView:_setEquipItemPos(equipItem, index, tween, callback, callbackObj)
	local posTr = self.equipPosTrList[index]
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.heroContainer.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(equipItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(equipItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act191HeroGroupListView:refreshFetter()
	for _, item in ipairs(self.fetterItemList) do
		gohelper.setActive(item.go, false)
	end

	local fetterCntDic = self.gameInfo:getTeamFetterCntDic()
	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	for k, info in ipairs(fetterInfoList) do
		local item = self.fetterItemList[k]

		if not item then
			local go = self:getResInst(Activity191Enum.PrefabPath.FetterItem, self.goFetterContent)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterItem)
			self.fetterItemList[k] = item
		end

		item:setData(info.config, info.count)
		item:setExtraParam({
			fromView = self.viewName,
			index = k
		})
		gohelper.setActive(item.go, true)
	end

	self.scrollFetter.horizontalNormalizedPosition = 0
end

return Act191HeroGroupListView
