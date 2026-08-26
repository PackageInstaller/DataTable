-- chunkname: @modules/logic/versionactivity2_5/challenge/view/herogroup/Act183HeroGroupListView.lua

module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupListView", package.seeall)

local Act183HeroGroupListView = class("Act183HeroGroupListView", HeroGroupListView)
local HeroContainerPostionMap = {
	[ModuleEnum.HeroGroupSnapshotType.Act183Normal] = {
		{
			-967.6,
			140.47
		},
		{
			-717.86,
			50.8
		},
		{
			-468.9,
			90.63
		},
		{
			-219.8,
			140.2
		}
	},
	[ModuleEnum.HeroGroupSnapshotType.Act183Boss] = {
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
}
local HeroBgPositionMap = {
	[ModuleEnum.HeroGroupSnapshotType.Act183Normal] = {
		{
			-959.6,
			121
		},
		{
			-709.9,
			31.2
		},
		{
			-461,
			71
		},
		{
			-211.75,
			121
		}
	},
	[ModuleEnum.HeroGroupSnapshotType.Act183Boss] = {
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
}
local BgAndCardScaleMap = {
	[ModuleEnum.HeroGroupSnapshotType.Act183Normal] = {
		1,
		1,
		1
	},
	[ModuleEnum.HeroGroupSnapshotType.Act183Boss] = {
		0.9,
		0.9,
		0.9
	}
}

function Act183HeroGroupListView:_editableInitView()
	self._episodeId = HeroGroupModel.instance.episodeId
	self._roleNum = Act183Helper.getEpisodeBattleNum(self._episodeId)
	self._snapshotType = Act183Helper.getEpisodeSnapShotType(self._episodeId)

	self:initHeroBgList()
	self:initHeroList()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(self._heroItemPosList)
end

function Act183HeroGroupListView:initHeroList()
	gohelper.setActive(self._goheroitem, false)

	self._heroItemList = {}
	self.heroPosTrList = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()
	self._cardScale = BgAndCardScaleMap[self._snapshotType]

	if not self._cardScale then
		logError(string.format("卡牌缩放配置(BgAndCardScaleMap)不存在 snapshotType = %s", self._snapshotType))
	end

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

		local goleaderframe = gohelper.findChild(go, "go_leader")

		heroItem:setBgLeaderTran(goleaderframe.transform)
	end
end

function Act183HeroGroupListView:_getHeroItemCls()
	return Act183HeroGroupHeroItem
end

function Act183HeroGroupListView:_calcIndex(position)
	for i = 1, self._roleNum do
		if self.heroPosTrList[i] then
			if gohelper.isMouseOverGo(self.heroPosTrList[i], position) then
				return i
			end
		end
	end

	return 0
end

function Act183HeroGroupListView:canDrag(param, isWrap)
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

function Act183HeroGroupListView:_onEndDrag(param, pointerEventData)
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

function Act183HeroGroupListView:_getOrCreateHeroGO(index)
	local go = gohelper.findChild(self.heroContainer, "pos" .. index)

	if gohelper.isNil(go) then
		local gotemplate = gohelper.findChild(self.heroContainer, "pos_template")

		go = gohelper.cloneInPlace(gotemplate, "pos" .. index)

		gohelper.setActive(go, true)
	end

	local positionMap = HeroContainerPostionMap[self._snapshotType]
	local position = positionMap and positionMap[index]
	local scale = BgAndCardScaleMap[self._snapshotType]

	if position and scale then
		transformhelper.setLocalScale(go.transform, scale[1], scale[2], scale[3])
		recthelper.setAnchor(go.transform, position[1], position[2])
	else
		logError(string.format("编队界面卡牌缺少坐标配置(HeroContainerPostionMap) or 缩放配置(BgAndCardScaleMap) : snapshotType = %s, index = %s", self._snapshotType, index))
	end

	return go
end

function Act183HeroGroupListView:initHeroBgList()
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

function Act183HeroGroupListView:_getOrCreateHeroBg(index)
	local gobg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. index)

	if gohelper.isNil(gobg) then
		local gobgtemplate = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg1")

		gobg = gohelper.cloneInPlace(gobgtemplate, "bg" .. index)
	end

	local positionMap = HeroBgPositionMap[self._snapshotType]
	local position = positionMap and positionMap[index]
	local scale = BgAndCardScaleMap[self._snapshotType]

	if position and scale then
		transformhelper.setLocalScale(gobg.transform, scale[1], scale[2], scale[3])
		recthelper.setAnchor(gobg.transform, position[1], position[2])
	else
		logError(string.format("编队界面卡牌背景缺少坐标配置(HeroBgPositionMap) or 缩放配置(BgAndCardScaleMap) : snapshotType = %s, index = %s", self._snapshotType, index))
	end

	return gobg
end

function Act183HeroGroupListView:_onScreenSizeChange()
	if self._heroItemList then
		for i, heroItem in ipairs(self._heroItemList) do
			self:_setHeroItemPos(heroItem, i)
		end
	end
end

function Act183HeroGroupListView:onDestroyView()
	if self._heroItemList then
		for _, heroItem in pairs(self._heroItemList) do
			CommonDragHelper.instance:unregisterDragObj(heroItem.go)
		end
	end

	Act183HeroGroupListView.super.onDestroyView(self)
end

return Act183HeroGroupListView
