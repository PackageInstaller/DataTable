-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneScrollHero.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneScrollHero", package.seeall)

local M = class("AirWorkShopDefSceneScrollHero")

function M:ctor(gameObject)
	self.mainGO = gameObject

	self:buildUI()
end

function M:buildUI()
	self._headItemCollection = ViewlibCollection:create(ViewlibResPath.AirAdjustmentHeroItem, 10)
	self._teamMOList = {}
	self._btnFilter = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnFilter")

	self._btnFilter:AddClickListener(self._onClickFilter, self)

	self._goScrollRect = goutil.findChild(self.mainGO, "scrollView")
	self._scrollRect = Astral.ScrollRectLoop.Get(self._goScrollRect)

	self._scrollRect:InitFix(kScrollDirH, 120, 120, 4, 0, 1, self._onCellUpdate, self)
	self._scrollRect:SetCellsUpdateFinishHandler(self._onCellUpdateFinish, self)

	self._scrollRect.enableSeparateFrameUpdate = true
	self._scrollRect.frameUpdateCellCount = 1
	self._scrollRect.frameUpdateRate = 1

	self:_initData()
end

function M:destroy()
	self._headItemCollection:clear()

	self._headItemCollection = nil

	self._btnFilter:RemoveClickListener()
	self:_setEvents(false)
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TEAM_FILTER_BEFORE_BATTLE, self._onTeamFilterFinish, self)
		BattleDispatcher:addEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TEAM_FILTER_BEFORE_BATTLE, self._onTeamFilterFinish, self)
		BattleDispatcher:removeEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
	end
end

function M:_initData()
	self:_setEvents(true)

	self._isDraging = false

	local teamMOList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Battle, self:_getAllHeroData())

	self:_setTeamMOList(teamMOList)
end

function M:setVisibleAndUpdate(isVisible)
	goutil.setActive(self.mainGO, isVisible)

	if isVisible then
		self:_updateScrollView()
	end
end

function M:_onCellUpdateFinish()
	return
end

function M:_onAvailableHeroListUpdate(event)
	local teamMOList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Battle, AirWorkShopDefSceneModel.instance:getAvailableHeroMOList())

	self:_setTeamMOList(teamMOList)
	self:_updateScrollView()
end

function M:_onTeamFilterFinish(event, resultList)
	self._totalEnterAnimationCount = 10

	self:_setTeamMOList(resultList, true)
	self:_updateScrollView()
end

function M:_setTeamMOList(teamMOList)
	self._teamMOList = teamMOList
end

function M:_updateScrollView()
	self._scrollRect.TotalCellNum = #self._teamMOList
end

function M:_onCellUpdate(cellTransform, cellIndex, prevIndex)
	if not self._headItemCollection then
		return
	end

	cellIndex = cellIndex + 1

	local itemGO = goutil.findChild(cellTransform.gameObject, "BattleCampAdjustmentHeroItem")
	local cellBehavior

	if itemGO then
		cellBehavior = Astral.SimpleLuaComponentContainer.Get(itemGO, AirAdjustmentHeroItem)
	else
		cellBehavior = self._headItemCollection:createInstance(cellTransform.gameObject)

		cellBehavior:setHandler(self)
		cellBehavior:setPassToGameObject(self._goScrollRect)

		itemGO = cellBehavior.mainGO
		itemGO.name = "BattleCampAdjustmentHeroItem"

		Astral.TransformUtil.SetLocalPos(itemGO.transform, 0, 0, 0)
	end

	local heroMO = self._teamMOList[cellIndex]

	cellBehavior:setHeroMO(heroMO)
	cellBehavior:setSelected(heroMO:getId() == self._selectedCharacterId)
	cellBehavior:setEnable(true)

	if self._selectedAnimation and heroMO:getId() == self._selectedCharacterId then
		self._selectedAnimation = false
	end

	if heroMO:getId() == self._lastSelectedCharacterId then
		self._lastSelectedCharacterId = false
	end
end

function M:_getAllHeroData()
	return AirWorkShopDefSceneModel.instance:getAvailableHeroMOList()
end

function M:_onClickFilter()
	BattleAudioUtil.playSEByName("ui_battle_jueseshaixuan")

	local heroMOList = self:_getAllHeroData()

	ViewMgr.instance:open(ViewName.HeroFilterTipsView, {
		moduleType = CommEnum.HeroFilter.Battle,
		data = heroMOList,
		confirmEvent = EventType.TEAM_FILTER_BEFORE_BATTLE
	})
end

function M:onClickHeadItem(headItem)
	if self._isDraging then
		return
	end

	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	self._selectedAnimation = true

	local characterId = headItem:getHeroId()

	if self._selectedCharacterId == characterId then
		self:cancelSelectedCharacter()
	else
		self:setSelectedCharacter(characterId)
	end
end

function M:onBeginDragHeadItem(headItem, screenX, screenY)
	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	if not AirWorkShopDefSceneModel.instance:isEnableAdjustment() then
		return
	end

	if self._isDraging then
		return
	end

	if AirWorkShopDefSceneModel.instance:isDragging() then
		return
	end

	if AirWorkShopDefOperateUtil.isUnitReachLimit(self:_getUnitTagType()) then
		FloatWordMgr.instance:show(lang("tip_airwork_reach_limit"))

		return
	end

	self._isDraging = true
	self._selectedAnimation = true

	self:_setSceneDragEnable(false)

	self._dragUnit = self:_createDragUnit(headItem:getHeroId())

	AirWorkShopDefSceneModel.instance:setDragging(true)
	self:setSelectedCharacter(headItem:getHeroId(), true)
	self:onDragHeadItem(headItem, screenX, screenY)

	if not AirWorkShopDefOperateUtil.isUnitVisible(self._dragUnit) then
		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_UNIT_VISIBLE_UPDATE, self._dragUnit.property:getTabType())
	end
end

function M:onDragHeadItem(headItem, screenX, screenY)
	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY)

	if not x then
		return
	end

	if not self._isDraging then
		return
	end

	self._dragUnit.mover:setPosDirectly(x, z)

	local boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()
	local unionIndex = boardMgr:worldPosition2UnionIndex(x, y, z)
	local hideUnit = false

	if AirWorkShopDefOperateUtil.canSetToUnionIndex(self._dragUnit, unionIndex) then
		AirWorkShopDefSceneUtil.showFocusSign(unionIndex)

		local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

		hideUnit = unitMgr:getUnitOnUnionIndex(unionIndex, AirWorkShopDefSceneModel.instance:getCurTabType())

		if hideUnit and hideUnit.property:getTabType() ~= AirWorkShopEnum.TabEnum.Hero then
			hideUnit = false
		end
	else
		AirWorkShopDefSceneUtil.hideFocusSign()
	end

	if hideUnit ~= self._lastHideUnit then
		if self._lastHideUnit then
			self._lastHideUnit:setVisible(true)
		end

		if hideUnit then
			hideUnit:setVisible(false)
		end

		self._lastHideUnit = hideUnit
	end
end

function M:onEndDragHeadItem(headItem, screenX, screenY)
	if not self._isDraging then
		return
	end

	self._isDraging = false

	self:_setSceneDragEnable(true)
	AirWorkShopDefSceneUtil.hideFocusSign()

	local characterCode = headItem:getHeroId()
	local unionIndex = self:_getPlaceUnionIndex(screenX, screenY)

	if not unionIndex then
		self:_destroyDragUnit()
		self:cancelSelectedCharacter()

		return
	end

	if not AirWorkShopDefOperateUtil.canSetToUnionIndex(self._dragUnit, unionIndex) then
		self:_destroyDragUnit()
		self:cancelSelectedCharacter()

		return
	end

	local dragUnit = self._dragUnit

	self:_placeDragUnit(unionIndex)
	self:cancelSelectedCharacter(false)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_renwuputdown)
	AirWorkShopDefSceneUtil.requestPlaceHero(characterCode, unionIndex, dragUnit)
	AirWorkShopDefSceneUtil.playPlaceEffect(dragUnit)
end

function M:onTriggerDisable(headItem)
	local heroId = headItem:getHeroId()
end

function M:_placeDragUnit(unionIndex)
	local unit = self._dragUnit

	self._dragUnit = false
	self._lastHideUnit = false

	AirWorkShopDefSceneModel.instance:setDragging(false)
	AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
end

function M:_getPlaceUnionIndex(screenX, screenY)
	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY)

	if not x then
		return
	end

	local boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()
	local unionIndex = boardMgr:worldPosition2UnionIndex(x, y, z)
	local isCanPlaceOnUnionIndex = AirWorkShopDefOperateUtil.canSetToUnionIndex(self._dragUnit, unionIndex, true)

	if not isCanPlaceOnUnionIndex then
		return
	end

	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local oldUnit = unitMgr:getUnitOnUnionIndex(unionIndex, AirWorkShopDefSceneModel.instance:getCurTabType())

	if oldUnit and not AirWorkShopDefSceneUtil.tryRemoveUnit(oldUnit, true) then
		return
	end

	return unionIndex
end

function M:cancelSelectedCharacter()
	if self._selectedCharacterId == -1 then
		return
	end

	self._lastSelectedCharacterId = self._selectedCharacterId
	self._selectedCharacterId = -1

	BattleMainViewFacade.instance:cancelSelectedHero()
	self:_updateScrollView()
end

function M:setSelectedCharacter(characterId, hideMainView)
	if self._selectedCharacterId == characterId then
		return
	end

	self._lastSelectedCharacterId = self._selectedCharacterId
	self._selectedCharacterId = characterId

	self:_updateScrollView()
end

function M:_setSceneDragEnable(enable)
	local scenePicker = AirWorkShopDefMgr.instance:getScenePicker()

	scenePicker:setIsCameraFollowing(not enable)
end

function M:_updateScrollView()
	self._scrollRect.TotalCellNum = #self._teamMOList
end

function M:_createDragUnit(characterCode)
	local unit = AirWorkShopDefSceneUtil.createHero(characterCode)

	unit.mover:setPosDirectly(-999, 0)
	unit.meshModelMover:playIdle()
	AirWorkShopDefSceneUtil.setUnitForDrag(unit)

	return unit
end

function M:_getUnitTagType()
	return AirWorkShopEnum.TabEnum.Hero
end

function M:_destroyDragUnit()
	if self._dragUnit then
		self._dragUnit.meshModelMover:setOffsetXYZ(0, 0, 0)
		AirWorkShopDefSceneUtil.requestRemoveEntity(self._dragUnit)
		AirWorkShopDefSceneModel.instance:setDragging(false)

		self._dragUnit = false
	end

	if self._lastHideUnit then
		self._lastHideUnit:setVisible(true)

		self._lastHideUnit = false
	end
end

return M
