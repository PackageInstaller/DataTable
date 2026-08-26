-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191TeamComp.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191TeamComp", package.seeall)

local Act191TeamComp = class("Act191TeamComp", LuaCompBase)

function Act191TeamComp:ctor(view)
	self.handleViewName = view.viewName
end

function Act191TeamComp:init(go)
	self.go = go
	self.goHeroTeam = gohelper.findChild(go, "#go_HeroTeam")
	self.goCollectionTeam = gohelper.findChild(go, "#go_CollectionTeam")
	self.imageLevel = gohelper.findChildImage(go, "level/#image_Level")
	self.goRoleS = gohelper.findChild(go, "switch/role/select")
	self.goRoleU = gohelper.findChild(go, "switch/role/unselect")
	self.goCollectionS = gohelper.findChild(go, "switch/collection/select")
	self.goCollectionU = gohelper.findChild(go, "switch/collection/unselect")
	self.btnSwitch = gohelper.findChildButtonWithAudio(go, "switch/btn_Switch")
	self.scrollFetter = gohelper.findChildScrollRect(go, "#scroll_Fetter")
	self.goFetterContent = gohelper.findChild(go, "#scroll_Fetter/Viewport/#go_FetterContent")
	self.btnEnhance = gohelper.findChildButtonWithAudio(go, "#btn_Enhance")

	self.addClickCb(self, self.btnEnhance, self._btnEnhanceOnClick, self)

	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.groupItem1List = {}
	self.fetterItemList = {}
	self.mainTeamSlot = self.gameInfo.mainTeamSize
	self.subTeamSlot = self.gameInfo.subTeamSize
	self.heroPosTrList = self:getUserDataTb_()

	for i = 1, 9 do
		local recordGo = gohelper.findChild(self.go, "recordPos/hero" .. i)
		local heroGo = gohelper.findChild(self.goHeroTeam, "hero" .. i)

		gohelper.setActive(heroGo, i <= self.mainTeamSlot + self.subTeamSlot)

		if i <= self.mainTeamSlot + self.subTeamSlot then
			self.heroPosTrList[i] = recordGo.transform
			self.groupItem1List[i] = MonoHelper.addNoUpdateLuaComOnceToGo(heroGo, Act191HeroGroupItem1)

			self.groupItem1List[i]:setIndex(i)
			self.groupItem1List[i]:setExtraParam({
				type = "justHero",
				fromView = self.handleViewName
			})
			CommonDragHelper.instance:registerDragObj(heroGo, self._onBeginDrag, nil, self._onEndDrag, self._checkDrag, self, i)
		end
	end

	self._loader = MultiAbLoader.New()

	self._loader:addPath(Activity191Enum.PrefabPath.FetterItem)
	self._loader:startLoad(self._loadFinish, self)

	self._anim = go:GetComponent(gohelper.Type_Animator)
end

function Act191TeamComp:addEventListeners()
	self.addClickCb(self, self.btnSwitch, self.onClickSwitch, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateTeamInfo, self.refreshTeam, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateGameInfo, self.refreshTeam, self)
end

function Act191TeamComp:onStart()
	self:refreshTeam()
	self:refreshStatus()

	local enhanceCnt = #self.gameInfo.warehouseInfo.enhanceId

	gohelper.setActive(self.btnEnhance, enhanceCnt ~= 0)
end

function Act191TeamComp:onDestroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	TaskDispatcher.cancelTask(self.refreshStatus, self)

	for _, item in ipairs(self.groupItem1List) do
		CommonDragHelper.instance:unregisterDragObj(item.go)
	end
end

function Act191TeamComp:_loadFinish()
	self.canFreshFetter = true

	if self.needFreshFetter then
		self:refreshFetter()

		self.needFreshFetter = false
	end
end

function Act191TeamComp:onClickSwitch(manual)
	return
end

function Act191TeamComp:refreshStatus()
	gohelper.setActive(self.goRoleS, not self.editCollection)
	gohelper.setActive(self.goRoleU, self.editCollection)
	gohelper.setActive(self.goCollectionS, self.editCollection)
	gohelper.setActive(self.goCollectionU, not self.editCollection)
	gohelper.setActive(self.goHeroTeam, not self.editCollection)
	gohelper.setActive(self.goCollectionTeam, self.editCollection)
end

function Act191TeamComp:refreshTeam()
	local rankCfg = Activity191Config.instance:getRankCfg(self.gameInfo.rank)

	if rankCfg then
		UISpriteSetMgr.instance:setAct174Sprite(self.imageLevel, "act191_level_" .. string.lower(rankCfg.fightLevel))
	end

	local teamInfo = self.gameInfo:getTeamInfo()

	for i = 1, self.mainTeamSlot do
		self:_setHeroItemPos(self.groupItem1List[i], i)

		local battleHeroInfo = Activity191Helper.matchKeyInArray(teamInfo.battleHeroInfo, i)
		local heroId = battleHeroInfo and battleHeroInfo.heroId

		self.groupItem1List[i]:setData(heroId)
	end

	for i = 1, self.subTeamSlot do
		self:_setHeroItemPos(self.groupItem1List[i + self.mainTeamSlot], i + self.mainTeamSlot)

		local subHeroInfo = Activity191Helper.matchKeyInArray(teamInfo.subHeroInfo, i)
		local subHeroId = subHeroInfo and subHeroInfo.heroId

		self.groupItem1List[i + self.mainTeamSlot]:setData(subHeroId)
	end

	if self.canFreshFetter then
		self:refreshFetter()
	else
		self.needFreshFetter = true
	end
end

function Act191TeamComp:refreshFetter()
	local fetterCntDic = self.gameInfo:getTeamFetterCntDic()
	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	for k, info in ipairs(fetterInfoList) do
		local item = self.fetterItemList[k]

		if not item then
			local prefabSource = self._loader:getFirstAssetItem():GetResource()
			local go = gohelper.clone(prefabSource, self.goFetterContent)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterItem)

			item:setExtraParam({
				fromView = self.handleViewName,
				index = k
			})

			self.fetterItemList[k] = item
		end

		item:setData(info.config, info.count)
		gohelper.setActive(item.go, true)
	end

	for i = #fetterInfoList + 1, #self.fetterItemList do
		local item = self.fetterItemList[i]

		gohelper.setActive(item.go, false)
	end

	gohelper.setActive(self.goFetterContent, #fetterInfoList ~= 0)

	self.scrollFetter.horizontalNormalizedPosition = 0
	self.needFreshFetter = false
end

function Act191TeamComp:_checkDrag(param)
	local heroItem = self.groupItem1List[param]

	if not heroItem.heroId or heroItem.heroId == 0 then
		return true
	end

	return false
end

function Act191TeamComp:_onBeginDrag(param)
	local heroItem = self.groupItem1List[param]

	if not heroItem then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	heroItem:setDrag(true)
end

function Act191TeamComp:_onEndDrag(param, pointerEventData)
	local heroItem = self.groupItem1List[param]

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

	local otherHeroItem = self.groupItem1List[toIndex]

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

function Act191TeamComp:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self.heroPosTrList[index]
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.goHeroTeam.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act191TeamComp:_btnEnhanceOnClick()
	Act191StatController.instance:statButtonClick(self.handleViewName, "_btnEnhanceOnClick")
	ViewMgr.instance:openView(ViewName.Act191EnhanceView, {
		isDown = true,
		pos = Vector2(380, -735)
	})
end

return Act191TeamComp
