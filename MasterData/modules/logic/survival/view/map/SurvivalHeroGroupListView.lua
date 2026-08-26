-- chunkname: @modules/logic/survival/view/map/SurvivalHeroGroupListView.lua

module("modules.logic.survival.view.map.SurvivalHeroGroupListView", package.seeall)

local SurvivalHeroGroupListView = class("SurvivalHeroGroupListView", HeroGroupListView)
local HeroContainerPostionMap = {
	{
		-1097.6,
		166.6
	},
	{
		-874.0001,
		85.79997
	},
	{
		-649.4001,
		120.9
	},
	{
		-425.1,
		165.9
	},
	{
		-199.9,
		122.6
	}
}
local HeroBgPositionMap = {
	{
		-1089.6,
		147.13
	},
	{
		-866.0001,
		66.32997
	},
	{
		-641.4001,
		101.43
	},
	{
		-417.1001,
		146.43
	},
	{
		-191.8999,
		103.13
	}
}
local BgAndCardScaleMap = {
	0.9,
	0.9,
	0.9
}

function SurvivalHeroGroupListView:_editableInitView()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._roleNum = 5

	self:initHeroBgList()
	self:initHeroList()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(self._heroItemPosList)
end

function SurvivalHeroGroupListView:initHeroList()
	gohelper.setActive(self._goheroitem, false)

	self._heroItemList = {}
	self.heroPosTrList = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()
	self._cardScale = BgAndCardScaleMap

	for i = 1, self._roleNum do
		local go = self:_getOrCreateHeroGO(i)
		local gocontainer = gohelper.findChild(go, "container")
		local cloneGO = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, self:_getHeroItemCls(), self)

		heroItem:setIndex(i)
		heroItem:setScale(self._cardScale[1] or 1, self._cardScale[2] or 1, self._cardScale[3] or 1)
		table.insert(self.heroPosTrList, gocontainer.transform)
		table.insert(self._heroItemList, heroItem)
		gohelper.setActive(cloneGO, true)
		self:_setHeroItemPos(heroItem, i)
		table.insert(self._heroItemPosList, heroItem.go.transform)
		heroItem:setParent(self.heroPosTrList[i])
		CommonDragHelper.instance:registerDragObj(heroItem.go, self._onBeginDrag, nil, self._onEndDrag, self._checkCanDrag, self, i)
	end
end

function SurvivalHeroGroupListView:_getHeroItemCls()
	return SurvivalHeroGroupHeroItem
end

function SurvivalHeroGroupListView:_calcIndex(position)
	for i = 1, self._roleNum do
		if self.heroPosTrList[i] then
			if gohelper.isMouseOverGo(self.heroPosTrList[i], position) then
				return i
			end
		end
	end

	return 0
end

function SurvivalHeroGroupListView:canDrag(param, isWrap)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local index = param
	local heroItem = self._heroItemList[index]

	if heroItem.isAid then
		return false
	end

	if heroItem.isTrialLock then
		return false
	end

	if not isWrap and (heroItem.mo:isEmpty() or heroItem.mo.aid == -1) then
		return false
	end

	return true
end

function SurvivalHeroGroupListView:_onEndDrag(param, pointerEventData)
	if not self:canDrag(param) then
		return
	end

	if self._nowDragingIndex ~= param then
		return
	end

	self._nowDragingIndex = nil

	local dragToIndex = self:_calcIndex(pointerEventData.position)
	local heroItem = self._heroItemList[param]
	local index = param

	for _, one in ipairs(self._heroItemList) do
		one:onItemEndDrag(index, dragToIndex)
	end

	CommonDragHelper.instance:setGlobalEnabled(false)

	if dragToIndex == param or dragToIndex <= 0 then
		self._orderList[param].text = ""
	end

	local function completeDragFunc(self, complete)
		for _, one in ipairs(self._heroItemList) do
			one:onItemCompleteDrag(index, dragToIndex, complete)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)

		for _, heroItem in ipairs(self._heroItemList) do
			heroItem:flowCurrentParent()
		end
	end

	if dragToIndex <= 0 then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	if not self:canDrag(dragToIndex, true) then
		local dragHeroItem = self._heroItemList[dragToIndex]

		if dragHeroItem and dragHeroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	if dragToIndex <= 0 then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local roleNum = HeroGroupModel.instance:getBattleRoleNum()

	if roleNum and roleNum < dragToIndex then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if battleCO and heroItem.mo.aid and dragToIndex > battleCO.playerMax then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local otherHeroItem = self._heroItemList[dragToIndex]

	if otherHeroItem.mo.aid then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	if index ~= dragToIndex then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(otherHeroItem.go)
	gohelper.setAsLastSibling(heroItem.go)
	otherHeroItem:flowOriginParent()

	self._tweenId = self:_setHeroItemPos(otherHeroItem, index, true)

	self._setHeroItemPos(self, heroItem, dragToIndex, true, function()
		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		for i, heroItem in ipairs(self._heroItemList) do
			self:_setHeroItemPos(heroItem, i)
		end

		completeDragFunc(self, true)

		local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
		local srcPos = heroItem.mo.id - 1
		local targetPos = otherHeroItem.mo.id - 1
		local srcEquipId = heroGroupMO:getPosEquips(srcPos).equipUid[1]
		local targetEquipId = heroGroupMO:getPosEquips(targetPos).equipUid[1]

		heroGroupMO.equips[srcPos].equipUid = {
			targetEquipId
		}
		heroGroupMO.equips[targetPos].equipUid = {
			srcEquipId
		}

		HeroSingleGroupModel.instance:swap(index, dragToIndex)

		local newHeroUids = HeroSingleGroupModel.instance:getHeroUids()

		for i, heroUid in ipairs(heroGroupMO.heroList) do
			if newHeroUids[i] ~= heroUid then
				HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				HeroGroupModel.instance:saveCurGroupData()
				self:_updateHeroList()

				break
			end
		end
	end, self)
end

function SurvivalHeroGroupListView:_getOrCreateHeroGO(index)
	local go = gohelper.findChild(self.heroContainer, "pos" .. index)

	if gohelper.isNil(go) then
		local gotemplate = gohelper.findChild(self.heroContainer, "pos_template")

		go = gohelper.cloneInPlace(gotemplate, "pos" .. index)

		gohelper.setActive(go, true)
	end

	local position = HeroContainerPostionMap[index]
	local scale = BgAndCardScaleMap

	transformhelper.setLocalScale(go.transform, scale[1], scale[2], scale[3])
	recthelper.setAnchor(go.transform, position[1], position[2])

	return go
end

function SurvivalHeroGroupListView:_checkRestrictHero()
	local needRemoveHeroUidDict = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	for i = 1, 5 do
		local heroSingleGroupMO = HeroSingleGroupModel.instance:getById(i)

		if heroSingleGroupMO then
			local heroMo = heroSingleGroupMO:getHeroMO()

			if heroMo then
				local heroHealthMo = weekInfo:getHeroMo(heroMo.heroId)

				if HeroGroupModel.instance:isRestrict(heroSingleGroupMO.heroUid) or heroHealthMo.health <= 0 or not sceneMo.teamInfo:getHeroMo(heroSingleGroupMO.heroUid) then
					needRemoveHeroUidDict[heroSingleGroupMO.heroUid] = true
				end
			else
				heroSingleGroupMO:setEmpty()
			end
		end
	end

	if tabletool.len(needRemoveHeroUidDict) <= 0 then
		return
	end

	local battleCo = HeroGroupModel.instance:getCurrentBattleConfig()
	local restrictReason = battleCo and battleCo.restrictReason

	if not string.nilorempty(restrictReason) then
		ToastController.instance:showToastWithString(restrictReason)
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:playRestrictAnimation(needRemoveHeroUidDict)
	end

	self.needRemoveHeroUidDict = needRemoveHeroUidDict

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(self._removeRestrictHero, self, 1.5)
end

function SurvivalHeroGroupListView:initHeroBgList()
	self._bgList = self:getUserDataTb_()
	self._orderList = self:getUserDataTb_()
	self._openCount = self._roleNum

	for i = 1, self._roleNum do
		local gobg = self:_getOrCreateHeroBg(i)
		local bg = gohelper.findChild(gobg, "bg")

		table.insert(self._bgList, bg)

		local order = gohelper.findChildTextMesh(gobg, "bg/#txt_order")

		order.text = i <= self._openCount and tostring(i) or ""

		table.insert(self._orderList, order)
	end
end

function SurvivalHeroGroupListView:_getOrCreateHeroBg(index)
	local gobg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. index)

	if gohelper.isNil(gobg) then
		local gobgtemplate = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg1")

		gobg = gohelper.cloneInPlace(gobgtemplate, "bg" .. index)
	end

	local positionMap = HeroBgPositionMap

	if positionMap then
		if not positionMap[index] then
			local position = {
				0,
				0
			}
			local scale = BgAndCardScaleMap

			transformhelper.setLocalScale(gobg.transform, scale[1], scale[2], scale[3])
			recthelper.setAnchor(gobg.transform, position[1], position[2])

			return gobg
		end
	end
end

function SurvivalHeroGroupListView:_onScreenSizeChange()
	if self._heroItemList then
		for i, heroItem in ipairs(self._heroItemList) do
			self:_setHeroItemPos(heroItem, i)
		end
	end
end

function SurvivalHeroGroupListView:onDestroyView()
	if self._heroItemList then
		for _, heroItem in pairs(self._heroItemList) do
			CommonDragHelper.instance:unregisterDragObj(heroItem.go)
		end
	end

	SurvivalHeroGroupListView.super.onDestroyView(self)
end

return SurvivalHeroGroupListView
