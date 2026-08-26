-- chunkname: @modules/logic/seasonver/act123/view/Season123HeroGroupListView.lua

module("modules.logic.seasonver.act123.view.Season123HeroGroupListView", package.seeall)

local Season123HeroGroupListView = class("Season123HeroGroupListView", BaseView)

function Season123HeroGroupListView:onInitView()
	self._goheroarea = gohelper.findChild(self.viewGO, "herogroupcontain/area")
	self._gohero = gohelper.findChild(self.viewGO, "herogroupcontain/hero")
	self._goheroitem = gohelper.findChild(self.viewGO, "herogroupcontain/hero/heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123HeroGroupListView:_editableInitView()
	self._heroItemList = {}
	self._heroItemDrag = self:getUserDataTb_()

	gohelper.setActive(self._goheroitem, false)
	gohelper.setActive(self._goaidheroitem, false)

	self.heroPosTrList = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()

	for i = 1, 4 do
		local go = gohelper.findChild(self._goheroarea, "pos" .. i .. "/container")
		local tr = go.transform
		local cloneGO = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, Season123HeroGroupHeroItem, self)

		table.insert(self.heroPosTrList, tr)
		table.insert(self._heroItemList, item)
		gohelper.setActive(cloneGO, true)
	end

	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
		table.insert(self._heroItemPosList, heroItem.go.transform)
		heroItem:setParent(self.heroPosTrList[i])

		local drag = SLFramework.UGUI.UIDragListener.Get(heroItem.go)

		table.insert(self._heroItemDrag, drag)
	end

	self._bgList = {}

	for i = 1, 4 do
		local bg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg")

		table.insert(self._bgList, bg)
	end

	HeroGroupModel.instance:setHeroGroupItemPos(self._heroItemPosList)
end

function Season123HeroGroupListView:addEvents()
	for i, drag in ipairs(self._heroItemDrag) do
		drag:AddDragBeginListener(self._onBeginDrag, self, i)
		drag:AddDragListener(self._onDrag, self, i)
		drag:AddDragEndListener(self._onEndDrag, self, i)
	end

	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._updateHeroList, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self._onSnapshotSaveSucc, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function Season123HeroGroupListView:removeEvents()
	for _, drag in ipairs(self._heroItemDrag) do
		drag:RemoveDragBeginListener()
		drag:RemoveDragListener()
		drag:RemoveDragEndListener()
	end

	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._updateHeroList, self)
	self.removeEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self._onSnapshotSaveSucc, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function Season123HeroGroupListView:onOpen()
	self._isOpen = true

	self:_updateHeroList()
	self:_playOpenAnimation()
end

function Season123HeroGroupListView:_playOpenAnimation()
	for i, posTr in ipairs(self.heroPosTrList) do
		if posTr then
			local anim = posTr.gameObject:GetComponent(typeof(UnityEngine.Animator))

			anim:Play("open")
			anim:Update(0)

			anim.speed = 1
		end
	end

	for i, heroItem in ipairs(self._heroItemList) do
		if heroItem then
			local anim = heroItem.anim

			anim:Play("open")
			anim:Update(0)

			anim.speed = 1
		end
	end

	for i, bg in ipairs(self._bgList) do
		if bg then
			local anim = bg:GetComponent(typeof(UnityEngine.Animator))

			anim:Play("open")
			anim:Update(0)

			anim.speed = 1
		end
	end

	self:_checkRestrictHero()
end

function Season123HeroGroupListView:_checkRestrictHero()
	local needRemoveHeroUidDict = {}
	local isRemoveDeath = false
	local removeDeadUidDict

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		isRemoveDeath, removeDeadUidDict = Season123HeroGroupController.checkUnloadHero(Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer)
	end

	for i = 1, 4 do
		local heroSingleGroupMO = HeroSingleGroupModel.instance:getById(i)

		if heroSingleGroupMO and HeroGroupModel.instance:isRestrict(heroSingleGroupMO.heroUid) then
			needRemoveHeroUidDict[heroSingleGroupMO.heroUid] = true
		end
	end

	local needRemoveHeroCount = tabletool.len(needRemoveHeroUidDict)

	if needRemoveHeroCount <= 0 and removeDeadUidDict and tabletool.len(removeDeadUidDict) <= 0 then
		Season123HeroGroupController.instance:checkSeason123HeroGroup()

		return
	end

	local battleCo = HeroGroupModel.instance:getCurrentBattleConfig()
	local restrictReason = battleCo and battleCo.restrictReason

	if not string.nilorempty(restrictReason) and needRemoveHeroCount > 0 then
		ToastController.instance:showToastWithString(restrictReason)
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:playRestrictAnimation(needRemoveHeroUidDict, removeDeadUidDict)
	end

	self.needRemoveHeroUidDict = needRemoveHeroUidDict

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(self._removeRestrictHero, self, 1.5)
end

function Season123HeroGroupListView:_removeRestrictHero()
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not self.needRemoveHeroUidDict then
		Season123HeroGroupController.instance:checkSeason123HeroGroup()

		return
	end

	for heroUid, _ in pairs(self.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(heroUid)
	end

	HeroGroupModel.instance:replaceSingleGroup()
	Season123HeroGroupController.instance:checkSeason123HeroGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function Season123HeroGroupListView:_onHeroGroupExit()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if self._openTweenIdList then
		for i, openTweenId in ipairs(self._openTweenIdList) do
			ZProj.TweenHelper.KillById(openTweenId)
		end
	end

	self._closeTweenIdList = {}

	for i = 1, 4 do
		local closeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - i), nil, self._closeTweenFinish, self, i, EaseType.Linear)

		table.insert(self._closeTweenIdList, closeTweenId)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(Season123Controller.instance:getHeroGroupFightViewName(), false, false)
end

function Season123HeroGroupListView:_closeTweenFinish(index)
	local posTr = self.heroPosTrList[index]

	if posTr then
		local anim = posTr.gameObject:GetComponent(typeof(UnityEngine.Animator))

		anim:Play("close")

		anim.speed = 1
	end

	local heroItem = self._heroItemList[index]

	if heroItem then
		local anim = heroItem.anim

		anim:Play("close")

		anim.speed = 1
	end

	local bg = self._bgList[index]

	if bg then
		local anim = bg:GetComponent(typeof(UnityEngine.Animator))

		anim:Play("close")

		anim.speed = 1
	end
end

function Season123HeroGroupListView:canDrag(param, isWrap)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local index = param
	local heroItem = self._heroItemList[index]

	if heroItem.isTrialLock then
		return false
	end

	if not isWrap and (heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or param > HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function Season123HeroGroupListView:_onBeginDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not self:canDrag(param) then
		return
	end

	if self._tweening then
		return
	end

	local index = param
	local heroItem = self._heroItemList[index]

	if heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or param > HeroGroupModel.instance:positionOpenCount() then
		return
	end

	for _, one in ipairs(self._heroItemList) do
		one:onItemBeginDrag(index)
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(heroItem.go)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._goheroarea.transform)

	self:_tweenToPos(heroItem, anchorPos)
end

function Season123HeroGroupListView:_onDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not self:canDrag(param) then
		local heroItem = self._heroItemList[param]

		if heroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	local index = param
	local heroItem = self._heroItemList[index]

	if heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or param > HeroGroupModel.instance:positionOpenCount() then
		return
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._goheroarea.transform)

	self:_tweenToPos(heroItem, anchorPos)
end

function Season123HeroGroupListView:_onEndDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not self:canDrag(param) then
		return
	end

	local index = param
	local heroItem = self._heroItemList[index]

	if heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or index > HeroGroupModel.instance:positionOpenCount() then
		return
	end

	local dragToIndex = self:_calcIndex(pointerEventData.position)

	for _, one in ipairs(self._heroItemList) do
		one:onItemEndDrag(index, dragToIndex)
	end

	self:_setDragEnabled(false)

	local function completeDragFunc(self, complete)
		for _, one in ipairs(self._heroItemList) do
			one:onItemCompleteDrag(index, dragToIndex, complete)
		end

		self:_setDragEnabled(true)

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

	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	if dragToIndex > HeroGroupModel.instance:positionOpenCount() then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		local lockDesc, param = HeroGroupModel.instance:getPositionLockDesc(dragToIndex)

		GameFacade.showToast(lockDesc, param)

		return
	end

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

	if otherHeroItem.mo.aid and otherHeroItem.mo.aid ~= -1 and battleCO and index > battleCO.playerMax then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local canMoveTar, posStrTar = heroItem:canMoveCardToPos(dragToIndex - 1)
	local canMoveSrc, posStrSrc = otherHeroItem:canMoveCardToPos(index - 1)

	if not canMoveTar or not canMoveSrc then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		if not canMoveTar then
			GameFacade.showToast(Season123EquipItem.Toast_Pos_Wrong, posStrTar)
		end

		if not canMoveSrc then
			GameFacade.showToast(Season123EquipItem.Toast_Pos_Wrong, posStrSrc)
		end

		return
	end

	if index ~= dragToIndex then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(otherHeroItem.go)
	gohelper.setAsLastSibling(heroItem.go)
	otherHeroItem:flowOriginParent()

	self._tweenId = self:_setHeroItemPos(otherHeroItem, index, true)

	self:_setHeroItemPos(heroItem, dragToIndex, true, function()
		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		for i, heroItem in ipairs(self._heroItemList) do
			self:_setHeroItemPos(heroItem, i)
		end

		completeDragFunc(self, true)
		Season123HeroGroupUtils.swapHeroItem(heroItem.mo.id, otherHeroItem.mo.id)

		if Season123HeroGroupModel.instance:isEpisodeSeason123() or Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
			self:_updateHeroList()
			Season123HeroGroupController.instance:saveCurrentHeroGroup()
		else
			local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
			local newHeroUids = HeroSingleGroupModel.instance:getHeroUids()

			for i, heroUid in ipairs(heroGroupMO.heroList) do
				if newHeroUids[i] ~= heroUid then
					HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
					HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
					HeroGroupModel.instance:saveCurGroupData()
					self:_updateHeroList()

					break
				end
			end
		end
	end)
end

function Season123HeroGroupListView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self.heroPosTrList[index]
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self._goheroarea.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Season123HeroGroupListView:_tweenToPos(heroItem, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(heroItem.go.transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)
	end
end

function Season123HeroGroupListView:_setDragEnabled(isEnabled)
	for i, drag in ipairs(self._heroItemDrag) do
		drag.enabled = isEnabled
	end
end

function Season123HeroGroupListView:_updateHeroList()
	for i, heroItem in ipairs(self._heroItemList) do
		if Season123HeroGroupModel.instance:isEpisodeSeason123() or Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
			local groupMO = HeroGroupModel.instance:getCurGroupMO()
			local mo = {}

			mo = HeroSingleGroupMO.New()
			mo.id = i
			mo.heroUid = groupMO.heroList[i]

			if groupMO.isReplay then
				local replayHeroData = groupMO.replay_hero_data[mo.heroUid]

				heroItem:onUpdateMO(mo, self.viewParam, replayHeroData)
			else
				heroItem:onUpdateMO(mo, self.viewParam)
			end
		else
			local mo = HeroSingleGroupModel.instance:getById(i)

			heroItem:onUpdateMO(mo, self.viewParam)
		end
	end
end

function Season123HeroGroupListView:_onSnapshotSaveSucc()
	self:_updateHeroList()
	gohelper.setActive(self._goheroarea, false)
	gohelper.setActive(self._goheroarea, true)
	gohelper.setActive(self._gohero, false)
	gohelper.setActive(self._gohero, true)
end

function Season123HeroGroupListView:_calcIndex(position)
	for i = 1, 4 do
		local posTr = self.heroPosTrList[i].parent
		local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

		if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
			return i
		end
	end

	return 0
end

function Season123HeroGroupListView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)

	if self._openTweenIdList then
		for i, openTweenId in ipairs(self._openTweenIdList) do
			ZProj.TweenHelper.KillById(openTweenId)
		end
	end

	if self._closeTweenIdList then
		for i, closeTweenId in ipairs(self._closeTweenIdList) do
			ZProj.TweenHelper.KillById(closeTweenId)
		end
	end
end

function Season123HeroGroupListView:_onScreenSizeChange()
	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
	end
end

function Season123HeroGroupListView:getHeroItemList()
	return self._heroItemList
end

return Season123HeroGroupListView
