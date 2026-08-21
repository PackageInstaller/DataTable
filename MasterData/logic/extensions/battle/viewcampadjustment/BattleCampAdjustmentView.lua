-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentView.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentView", package.seeall)

local BattleCampAdjustmentView = class("BattleCampAdjustmentView", ViewComponent)
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local kMaxEnterAnimationCount = 10

function BattleCampAdjustmentView:buildUI()
	self._transform = self.mainGO.transform
	self._headItemCollection = ViewlibCollection:create(ViewlibResPath.BattleCampAdjustmentHeroItem, 10)
	self._btnFilter = self:getBtn("prewarprepareview_1819525810")
	self._btnTeam = self:getBtn("prewarprepareview_-617826668")
	self._goLeftTopView = self:getGo("prewarprepareview_1620125107")
	self._goMaskTop = self:getGo("prewar_prepare_view_-1487578069")
	self._goScrollRect = self:getGo("prewarprepareview_1231393319960715422")
	self._scrollRect = Astral.ScrollRectLoop.Get(self._goScrollRect)

	self._scrollRect:InitFix(kScrollDirH, 120, 120, 4, 0, 1, self._onCellUpdate, self)
	self._scrollRect:SetCellsUpdateFinishHandler(self._onCellUpdateFinish, self)

	self._scrollRect.enableSeparateFrameUpdate = true
	self._scrollRect.frameUpdateCellCount = 1
	self._scrollRect.frameUpdateRate = 1
	self._preloader = BattleCampAdjustmentPreloader.New()
	self._teamMOList = {}
	self._selectedCharacterId = -1
	self._lastSelectedCharacterId = -1
	self._totalEnterAnimationCount = 0
	self._forbiddenCareerMsg = false
	self._forbiddenCampMsg = false
	self._forbiddenRoleMsg = false
	self._curSelectHeroByClick = false
	self._lastSelectHeroByClick = false
	self._middleTopPanelGo = self:getGoByPath("midTopHint")
end

function BattleCampAdjustmentView:destroyUI()
	self._headItemCollection:clear()

	self._headItemCollection = nil
	self._transform = nil
	self._goMaskTop = nil
	self._btnFilter = nil
	self._btnTeam = nil
	self._scrollRect = nil
	self._goLeftTopView = nil
	self._goScrollRect = nil
	self._teamMOList = nil
	self._selectedCharacterId = -1
	self._lastSelectedCharacterId = -1
	self._forbiddenCareerMsg = false
	self._forbiddenCampMsg = false
	self._forbiddenRoleMsg = false
	self._curSelectHeroByClick = false
	self._lastSelectHeroByClick = false
end

function BattleCampAdjustmentView:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnTeam:AddClickListener(self._onClickTeam, self)
end

function BattleCampAdjustmentView:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnTeam:RemoveClickListener()
end

function BattleCampAdjustmentView:onEnter()
	CharacterUtil.clearFilterRecord(CommEnum.HeroFilter.Battle)
	BattleCampAdjustmentViewFacade.instance:registerView(self)

	self._selectedCharacterId = -1
	self._lastSelectedCharacterId = -1
	self._selectedAnimation = false
	self._isDraging = false
	self._totalEnterAnimationCount = kMaxEnterAnimationCount
	self._lastHideUnit = false

	self:_setEvent(true)
	self:_onAvailableHeroListUpdate()
	self:_updateForbiddenCareerMsg()
	self:_updateForbiddenCampMsg()
	self:_updateForbiddenRoleMsg()
	BattleAudioUtil.playSEByName("ui_battle_below_init")
end

function BattleCampAdjustmentView:onExit()
	BattleCampAdjustmentViewFacade.instance:unregisterView()

	self._isDraging = false
	self._lastHideUnit = false

	self:cancelSelectedCharacter()
	self:_setEvent(false)
	self._headItemCollection:clearAllInstance()
	self._preloader:clear()
end

function BattleCampAdjustmentView:setLeftTopVisible(visible)
	goutil.setActive(self._goLeftTopView, visible)
	goutil.setActive(self._goMaskTop, visible)
	goutil.setActive(self._middleTopPanelGo, visible)
end

function BattleCampAdjustmentView:_setSelectedCharacter(characterId, hideMainView)
	self._lastSelectedCharacterId = self._selectedCharacterId
	self._selectedCharacterId = characterId

	self:_updateScrollView()

	if hideMainView then
		BattleCampAdjustmentViewFacade.instance:setHeroInfo(false)
	else
		BattleCampAdjustmentViewFacade.instance:setHeroInfo(characterId)
	end

	local scenePicker = BattleMgr.instance:getScenePicker()

	scenePicker:clearOperateUnit()
end

function BattleCampAdjustmentView:cancelSelectedCharacter()
	if self._selectedCharacterId == -1 then
		return
	end

	self._lastSelectedCharacterId = self._selectedCharacterId
	self._selectedCharacterId = -1

	BattleCampAdjustmentViewFacade.instance:setHeroInfo(false)
	self:_updateScrollView()
end

function BattleCampAdjustmentView:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TEAM_FILTER_BEFORE_BATTLE, self._onTeamFilterFinish, self)
		BattleDispatcher:addEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_CHANGE, self._onHeroInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TEAM_FILTER_BEFORE_BATTLE, self._onTeamFilterFinish, self)
		BattleDispatcher:removeEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_CHANGE, self._onHeroInfoChange, self)
	end
end

function BattleCampAdjustmentView:_setTeamMOList(teamMOList)
	table.clear(self._teamMOList)

	for _, teamMO in ipairs(teamMOList) do
		if not BattleCampAdjustmentModel.instance:isLockedCharacter(teamMO:getId()) then
			table.insert(self._teamMOList, teamMO)
		end
	end

	self._teamMOList = BattleCampAdjustmentModel.instance:sortByCareerList(self._teamMOList)

	if GuideController.instance:isGuiding() then
		local curGuideId = GuideController.instance:getCurGuideId()
		local guideConstData = ConstConfig.instance:getJsonValueByKey("UpgradeGuideId")
		local jsonConfigList = guideConstData.guideData

		for _, jsonConfig in ipairs(jsonConfigList) do
			if jsonConfig.guideId == curGuideId then
				self._teamMOList = CharacterUtil.AdjustSortByGuide(self._teamMOList, jsonConfig.heroId)

				break
			end
		end
	end

	self._preloader:preload(self._teamMOList)
end

function BattleCampAdjustmentView:_onTeamFilterFinish(event, resultList)
	self:cancelSelectedCharacter()

	self._totalEnterAnimationCount = kMaxEnterAnimationCount

	self:_setTeamMOList(resultList, true)
	self:_updateScrollView()
end

function BattleCampAdjustmentView:_updateForbiddenCareerMsg()
	local sb = StringBuffer.New()
	local forbiddenCareerList = BattleCampAdjustmentModel.instance:getForbiddenCareerList()

	for _, career in pairs(forbiddenCareerList) do
		sb:append(CharacterCOUtil.getCareerName(career))
	end

	local careerMsg = sb:toString("/")

	self._forbiddenCareerMsg = string.format("无法上阵<color=#fd3d47>%s</color>角色", careerMsg)
end

function BattleCampAdjustmentView:_updateForbiddenCampMsg()
	local sb = StringBuffer.New()
	local forbiddenCampList = BattleCampAdjustmentModel.instance:getForbiddenCampList()

	for _, career in pairs(forbiddenCampList) do
		sb:append(CommEnum.CampType2Name[career])
	end

	local careerMsg = sb:toString("/")

	self._forbiddenCampMsg = string.format("无法上阵<color=#fd3d47>%s</color>角色", careerMsg)
end

function BattleCampAdjustmentView:_updateForbiddenRoleMsg()
	local sb = StringBuffer.New()
	local forbiddenRoleList = BattleCampAdjustmentModel.instance:getForbiddenRoleList()

	for _, heroId in pairs(forbiddenRoleList) do
		sb:append(ContainmentUtil.getHeroName(heroId))
	end

	local careerMsg = sb:toString("/")

	self._forbiddenRoleMsg = string.format("无法上阵<color=#fd3d47>%s</color>", careerMsg)
end

function BattleCampAdjustmentView:_onAvailableHeroListUpdate(event)
	local teamMOList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Battle, BattleCampAdjustmentModel.instance:getAvailableAndTrialHeroMOList())

	self:_setTeamMOList(teamMOList)
	self:_updateScrollView()
end

function BattleCampAdjustmentView:_onCellUpdate(cellTransform, cellIndex, prevIndex)
	if not self._headItemCollection then
		return
	end

	cellIndex = cellIndex + 1

	local itemGO = goutil.findChild(cellTransform.gameObject, "BattleCampAdjustmentHeroItem")
	local cellBehavior

	if itemGO then
		cellBehavior = Astral.SimpleLuaComponentContainer.Get(itemGO, BattleCampAdjustmentHeroItem)
	else
		cellBehavior = self._headItemCollection:createInstance(cellTransform.gameObject)

		cellBehavior:setHandler(self)
		cellBehavior:setPassToGameObject(self._goScrollRect)

		itemGO = cellBehavior.mainGO
		itemGO.name = "BattleCampAdjustmentHeroItem"
	end

	Astral.TransformUtil.SetLocalPos(itemGO.transform, 0, 0, 0)

	local heroMO = self._teamMOList[cellIndex]
	local isForbidden = BattleCampAdjustmentModel.instance:isForbiddenCharacterCode(heroMO:getId())

	cellBehavior:setHeroMO(heroMO)
	cellBehavior:setSelected(heroMO:getId() == self._selectedCharacterId, self._curSelectHeroByClick)
	cellBehavior:setEnable(not isForbidden)

	if heroMO:getId() == self._selectedCharacterId and not self._curSelectHeroByClick then
		cellBehavior:playSelectAnimation()

		self._selectedAnimation = false
	end

	if heroMO:getId() == self._lastSelectedCharacterId and not self._curSelectHeroByClick and not self._lastSelectHeroByClick then
		cellBehavior:playUnselectAnimation()

		self._lastSelectedCharacterId = false
	end

	if self._totalEnterAnimationCount > 0 then
		self._totalEnterAnimationCount = self._totalEnterAnimationCount - 1

		cellBehavior:playEnterAnimation()
	end
end

function BattleCampAdjustmentView:_onCellUpdateFinish()
	self._totalEnterAnimationCount = 0
end

function BattleCampAdjustmentView:_onClickFilter()
	BattleAudioUtil.playSEByName("ui_battle_jueseshaixuan")

	local heroMOList = BattleCampAdjustmentModel.instance:getAvailableAndTrialHeroMOList()

	ViewMgr.instance:open(ViewName.HeroFilterTipsView, {
		moduleType = CommEnum.HeroFilter.Battle,
		data = heroMOList,
		confirmEvent = EventType.TEAM_FILTER_BEFORE_BATTLE
	})
end

function BattleCampAdjustmentView:_onClickTeam()
	BattleAudioUtil.playSEByName("ui_battle_biandui")
	ViewMgr.instance:open(ViewName.AdjustTeamTipsViewPresentor)
end

function BattleCampAdjustmentView:onClickHeadItem(headItem)
	if self._isDraging then
		return
	end

	self._lastSelectHeroByClick = self._curSelectHeroByClick
	self._curSelectHeroByClick = true
	self._selectedAnimation = true

	local characterId = headItem:getHeroId()

	if self._selectedCharacterId == characterId then
		self:cancelSelectedCharacter()
	else
		BattleAudioUtil.playSEByName("ui_battle_juesexinxi")
		self:_setSelectedCharacter(characterId)
	end
end

function BattleCampAdjustmentView:onBeginDragHeadItem(headItem, screenX, screenY)
	if not BattleCampAdjustmentModel.instance:isEnableAdjustment() then
		return
	end

	if self._isDraging then
		return
	end

	if BattleCampAdjustmentModel.instance:isDragging() then
		return
	end

	self._isDraging = true
	self._selectedAnimation = true
	self._lastSelectHeroByClick = self._curSelectHeroByClick
	self._curSelectHeroByClick = false

	self:_setSceneDrageEnable(false)
	BattleCampAdjustmentUtil.clearOperateUnit()

	self._dragUnit = self:_createDragUnit(headItem:getHeroId())

	BattleCampAdjustmentModel.instance:setDragging(true)
	self:_setSelectedCharacter(headItem:getHeroId(), true)
	self:onDragHeadItem(headItem, screenX, screenY)
	BattleAudioUtil.playSEByName("ui_battle_renwupickup")
end

function BattleCampAdjustmentView:onDragHeadItem(headItem, screenX, screenY)
	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY)

	if not x then
		return
	end

	if not self._isDraging then
		return
	end

	self._dragUnit.mover:setPosDirectly(x, z)

	local boardMgr = BattleMgr.instance:getBoardMgr()
	local unionIndex = boardMgr:worldPosition2UnionIndex(x, y, z)
	local hideUnit = false

	if BattleCampAdjustmentUtil.canPlaceOnUnionIndex(self._dragUnit, unionIndex) then
		BattleCampAdjustmentUtil.showFocusSign(unionIndex)

		local unitMgr = BattleMgr.instance:getUnitMgr()

		hideUnit = unitMgr:getUnitOnUnionIndex(unionIndex)
	else
		BattleCampAdjustmentUtil.hideFocusSign()
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

function BattleCampAdjustmentView:onEndDragHeadItem(headItem, screenX, screenY)
	if not self._isDraging then
		return
	end

	self._isDraging = false

	self:_setSceneDrageEnable(true)
	BattleCampAdjustmentUtil.hideFocusSign()

	local characterCode = headItem:getHeroId()
	local unionIndex = self:_getPlaceUnionIndex(screenX, screenY)

	if not unionIndex then
		self:_destroyDragUnit()
		self:cancelSelectedCharacter()

		return
	end

	local dragUnit = self._dragUnit

	self:_placeDragUnit(unionIndex)
	self:_removeFromTeamMOList(characterCode)
	self:cancelSelectedCharacter(false)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_renwuputdown)
	BattleCampAdjustmentUtil.requestPlaceEntity(characterCode, unionIndex)
	BattleCampAdjustmentUtil.playPlaceEffect(dragUnit)
	BattleCampAdjustmentModel.instance:setPrePlayedEffect(true)
end

function BattleCampAdjustmentView:onTriggerDisable(headItem)
	local heroId = headItem:getHeroId()
	local isTrial, trialForbidden = BattleCampAdjustmentModel.instance:isHeroForbiddenByTrial(heroId)

	if isTrial then
		if trialForbidden then
			FloatWordMgr.instance:show(lang("tip_no_battle_role_1"))
		end

		return
	end

	local careerForbideen = BattleCampAdjustmentModel.instance:isHeroForbiddenByCareer(heroId)
	local campForbideen = BattleCampAdjustmentModel.instance:isHeroForbiddenByCamp(heroId)
	local roleForbidden = BattleCampAdjustmentModel.instance:isHeroForbiddenByRole(heroId)
	local str

	if careerForbideen then
		str = self._forbiddenCareerMsg
	elseif campForbideen then
		str = self._forbiddenCampMsg
	elseif roleForbidden then
		str = self._forbiddenRoleMsg
	else
		str = lang("tip_no_battle_role_1")
	end

	FloatWordMgr.instance:show(str)
end

function BattleCampAdjustmentView:_placeDragUnit(unionIndex)
	local unit = self._dragUnit

	self._dragUnit = false
	self._lastHideUnit = false

	BattleCampAdjustmentModel.instance:setDragging(false)
	BattleCampAdjustmentModel.instance:addTempUnit(unionIndex, unit)
	BattleCampAdjustmentUtil.setDragUnitToUnionIndex(unit, unionIndex)
end

function BattleCampAdjustmentView:_getPlaceUnionIndex(screenX, screenY)
	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY)

	if not x then
		return
	end

	local boardMgr = BattleMgr.instance:getBoardMgr()
	local unionIndex = boardMgr:worldPosition2UnionIndex(x, y, z)
	local isCanPlaceOnUnionIndex, resultMsg = BattleCampAdjustmentUtil.canPlaceOnUnionIndex(self._dragUnit, unionIndex)

	if not isCanPlaceOnUnionIndex then
		FloatWordMgr.instance:show(resultMsg)

		return
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local oldUnit = unitMgr:getUnitOnUnionIndex(unionIndex)

	BattleCampAdjustmentUtil.requestRemoveEntity(oldUnit)

	if not BattleCampAdjustmentModel.instance:checkMaxCountLimit() then
		FloatWordMgr.instance:show(lang("tip_has_role_full_not_battle"))

		return
	end

	return unionIndex
end

function BattleCampAdjustmentView:_setSceneDrageEnable(enable)
	local scenePicker = BattleMgr.instance:getScenePicker()

	scenePicker:setIsCameraFollowing(not enable)
end

function BattleCampAdjustmentView:_updateScrollView()
	if self._totalEnterAnimationCount > 0 then
		self._totalEnterAnimationCount = math.min(self._totalEnterAnimationCount, #self._teamMOList)
	end

	self._scrollRect.TotalCellNum = #self._teamMOList
end

function BattleCampAdjustmentView:_createDragUnit(characterCode)
	local entityInfo = BattleUnitUtil.createHeroEntityInfo(characterCode)
	local unit = BattleUnitGenerator.createUnit(entityInfo)

	unit.mover:setPosDirectly(-999, 0)
	unit.meshModelMover:playIdle()
	BattleCampAdjustmentUtil.setUnitForDrag(unit)
	entityInfo:returnSelf()

	return unit
end

function BattleCampAdjustmentView:_destroyDragUnit()
	if self._dragUnit then
		self._dragUnit.meshModelMover:setOffsetXYZ(0, 0, 0)
		BattleUnitGenerator.destroyUnit(self._dragUnit)
		BattleCampAdjustmentModel.instance:setDragging(false)

		self._dragUnit = false
	end

	if self._lastHideUnit then
		self._lastHideUnit:setVisible(true)

		self._lastHideUnit = false
	end
end

function BattleCampAdjustmentView:_removeFromTeamMOList(characterCode)
	for index, heroMO in ipairs(self._teamMOList) do
		if characterCode == heroMO:getId() then
			table.remove(self._teamMOList, index)

			return index
		end
	end

	return false
end

function BattleCampAdjustmentView:_onHeroInfoChange()
	local teamMOList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Battle, BattleCampAdjustmentModel.instance:getAvailableAndTrialHeroMOList())

	self:_setTeamMOList(teamMOList)
	self:_updateScrollView()
end

return BattleCampAdjustmentView
