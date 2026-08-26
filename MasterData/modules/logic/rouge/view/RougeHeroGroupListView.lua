-- chunkname: @modules/logic/rouge/view/RougeHeroGroupListView.lua

module("modules.logic.rouge.view.RougeHeroGroupListView", package.seeall)

local RougeHeroGroupListView = class("RougeHeroGroupListView", BaseView)

function RougeHeroGroupListView:onInitView()
	self.heroContainer = gohelper.findChild(self.viewGO, "herogroupcontain/area")
	self._goheroitem = gohelper.findChild(self.viewGO, "herogroupcontain/hero/heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeHeroGroupListView:_editableInitView()
	local battleId = HeroGroupModel.instance.battleId
	local battleConfig = lua_battle.configDict[battleId]

	self._playerMax = battleConfig.playerMax
	self._roleNum = battleConfig.roleNum
	self._heroItemList = {}
	self._heroItemDrag = self:getUserDataTb_()

	gohelper.setActive(self._goheroitem, false)
	gohelper.setActive(self._goaidheroitem, false)

	self.heroPosTrList = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()

	for i = 1, 4 do
		local go = gohelper.findChild(self.heroContainer, "pos" .. i .. "/container")
		local tr = go.transform
		local cloneGO = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, RougeHeroGroupHeroItem, self)

		item:setIndex(i)
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

	self._bgList = self:getUserDataTb_()
	self._orderList = self:getUserDataTb_()

	local openCount = HeroGroupModel.instance:positionOpenCount()
	local roleNum = HeroGroupModel.instance:getBattleRoleNum()

	if roleNum then
		openCount = math.min(roleNum, openCount)
	end

	openCount = math.min(self._playerMax, openCount)
	self._openCount = openCount

	for i = 1, 4 do
		local bg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg")

		table.insert(self._bgList, bg)

		local order = gohelper.findChildTextMesh(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg/#txt_order")

		order.text = i <= openCount and tostring(i) or ""

		table.insert(self._orderList, order)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(self._heroItemPosList)
end

function RougeHeroGroupListView:addEvents()
	for i, drag in ipairs(self._heroItemDrag) do
		drag:AddDragBeginListener(self._onBeginDrag, self, i)
		drag:AddDragListener(self._onDrag, self, i)
		drag:AddDragEndListener(self._onEndDrag, self, i)
	end

	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHeroAndWeekWalk, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._checkRestrictHeroAndWeekWalk, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function RougeHeroGroupListView:removeEvents()
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
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHeroAndWeekWalk, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._checkRestrictHeroAndWeekWalk, self)
end

function RougeHeroGroupListView:onOpen()
	self._isOpen = true

	self:_updateHeroList()
	self:_playOpenAnimation()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
end

function RougeHeroGroupListView:_playOpenAnimation()
	for i, posTr in ipairs(self.heroPosTrList) do
		if posTr then
			local anim = posTr.gameObject:GetComponent(typeof(UnityEngine.Animator))

			anim:Play(UIAnimationName.Open)
			anim:Update(0)

			anim.speed = 1
		end
	end

	for i, heroItem in ipairs(self._heroItemList) do
		if heroItem then
			local anim = heroItem.anim

			anim:Play(UIAnimationName.Open)
			anim:Update(0)

			anim.speed = 1
		end
	end

	for i, bg in ipairs(self._bgList) do
		if bg then
			local anim = bg:GetComponent(typeof(UnityEngine.Animator))

			anim:Play(UIAnimationName.Open)
			anim:Update(0)

			anim.speed = 1
		end
	end

	self:_checkRestrictHeroAndWeekWalk()
end

function RougeHeroGroupListView:_checkRestrictHeroAndWeekWalk()
	self:_checkDead()
end

function RougeHeroGroupListView:_checkDead()
	local teamInfo = RougeModel.instance:getTeamInfo()
	local needRemoveHeroUidDict = {}

	for i = 1, RougeEnum.FightTeamHeroNum do
		local heroSingleGroupMO = RougeHeroSingleGroupModel.instance:getById(i)

		if heroSingleGroupMO then
			local heroMO = heroSingleGroupMO:getHeroMO()

			if heroMO then
				local hpInfo = teamInfo:getHeroHp(heroMO.heroId)

				if hpInfo and hpInfo.life <= 0 then
					needRemoveHeroUidDict[heroSingleGroupMO.heroUid] = true
				end
			end
		end
	end

	if tabletool.len(needRemoveHeroUidDict) <= 0 then
		return
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:playRestrictAnimation(needRemoveHeroUidDict)
	end

	if tabletool.len(needRemoveHeroUidDict) <= 0 then
		self:_saveAfterRemoveDead()

		return
	end

	self.needRemoveHeroUidDict = needRemoveHeroUidDict

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(self._removeDeadHero, self, 1.5)
end

function RougeHeroGroupListView:_removeDeadHero()
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not self.needRemoveHeroUidDict then
		return
	end

	for heroUid, _ in pairs(self.needRemoveHeroUidDict) do
		RougeHeroSingleGroupModel.instance:remove(heroUid)
	end

	self:_saveAfterRemoveDead()
end

function RougeHeroGroupListView:_saveAfterRemoveDead()
	RougeHeroGroupModel.instance:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function RougeHeroGroupListView:_checkRestrictHero()
	local needRemoveHeroUidDict = {}

	for i = 1, 4 do
		local heroSingleGroupMO = RougeHeroSingleGroupModel.instance:getById(i)

		if heroSingleGroupMO and HeroGroupModel.instance:isRestrict(heroSingleGroupMO.heroUid) then
			needRemoveHeroUidDict[heroSingleGroupMO.heroUid] = true
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

function RougeHeroGroupListView:_removeRestrictHero()
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not self.needRemoveHeroUidDict then
		return
	end

	for heroUid, _ in pairs(self.needRemoveHeroUidDict) do
		RougeHeroSingleGroupModel.instance:remove(heroUid)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function RougeHeroGroupListView:_onHeroGroupExit()
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

	local groupFightView = self.viewContainer:getHeroGroupFightView()

	ViewMgr.instance:closeView(groupFightView.viewName, false, false)
end

function RougeHeroGroupListView:_closeTweenFinish(index)
	local posTr = self.heroPosTrList[index]

	if posTr then
		local anim = posTr.gameObject:GetComponent(typeof(UnityEngine.Animator))

		anim:Play(UIAnimationName.Close)

		anim.speed = 1
	end

	local heroItem = self._heroItemList[index]

	if heroItem then
		local anim = heroItem.anim

		anim:Play(UIAnimationName.Close)

		anim.speed = 1
		anim = heroItem.anim2

		heroItem.anim2:Play(UIAnimationName.Close)

		anim.speed = 1
	end

	local bg = self._bgList[index]

	if bg then
		local anim = bg:GetComponent(typeof(UnityEngine.Animator))

		anim:Play(UIAnimationName.Close)

		anim.speed = 1
	end
end

function RougeHeroGroupListView:_isCurEpisodeTeachNote()
	return true
end

function RougeHeroGroupListView:_isAct114Battle()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.Jiexika then
		return true
	end
end

function RougeHeroGroupListView:canDrag(param, isWrap)
	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local index = param
	local heroItem = self._heroItemList[index]

	if heroItem.isAid and self:_isCurEpisodeTeachNote() then
		return false
	end

	if heroItem.isAid and self:_isAct114Battle() then
		return false
	end

	if heroItem.isTrialLock then
		return false
	end

	if not isWrap and (heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or param > HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function RougeHeroGroupListView:_onBeginDrag(param, pointerEventData)
	if self._tweening then
		return
	end

	if not self:canDrag(param) then
		return
	end

	if self._nowDragingIndex then
		return
	end

	if param <= self._openCount then
		self._orderList[param].text = param
	end

	self._nowDragingIndex = param

	local heroItem = self._heroItemList[param]

	for _, one in ipairs(self._heroItemList) do
		one:onItemBeginDrag(param)
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(heroItem.go)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.heroContainer.transform)

	self:_tweenToPos(heroItem, anchorPos)
end

function RougeHeroGroupListView:_onDrag(param, pointerEventData)
	if not self:canDrag(param) then
		local heroItem = self._heroItemList[param]

		if heroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	if self._nowDragingIndex ~= param then
		return
	end

	local heroItem = self._heroItemList[param]
	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.heroContainer.transform)

	self:_tweenToPos(heroItem, anchorPos)
end

function RougeHeroGroupListView:_onEndDrag(param, pointerEventData)
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

	if dragToIndex == param or dragToIndex <= 0 then
		self._orderList[param].text = ""
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

		local heroGroupMO = RougeHeroGroupModel.instance:getCurGroupMO()
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

		RougeHeroSingleGroupModel.instance:swap(index, dragToIndex)
		RougeHeroSingleGroupModel.instance:swap(index + RougeEnum.FightTeamNormalHeroNum, dragToIndex + RougeEnum.FightTeamNormalHeroNum)

		local newHeroUids = RougeHeroSingleGroupModel.instance:getHeroUids()

		for i, heroUid in ipairs(heroGroupMO.heroList) do
			if newHeroUids[i] ~= heroUid then
				RougeHeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				RougeHeroGroupModel.instance:saveCurGroupData()
				RougeHeroGroupModel.instance:rougeSaveCurGroup()
				self:_updateHeroList()

				break
			end
		end
	end, self)
end

function RougeHeroGroupListView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self.heroPosTrList[index]
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.heroContainer.transform)

	if heroItem then
		heroItem:resetEquipPos()
	end

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function RougeHeroGroupListView:_tweenToPos(heroItem, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(heroItem.go.transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)
	end
end

function RougeHeroGroupListView:_setDragEnabled(isEnabled)
	for i, drag in ipairs(self._heroItemDrag) do
		drag.enabled = isEnabled
	end
end

function RougeHeroGroupListView:_updateHeroList()
	local groupFightView = self.viewContainer:getHeroGroupFightView()
	local isReplay = groupFightView:isReplayMode()

	for i, heroItem in ipairs(self._heroItemList) do
		local mo = RougeHeroSingleGroupModel.instance:getById(i)

		heroItem:onUpdateMO(mo)

		if not self._nowDragingIndex and i <= self._openCount then
			self._orderList[i].text = mo:isEmpty() and i or ""
		end

		if not heroItem.isLock and not RougeHeroSingleGroupModel.instance:isTemp() and not isReplay and self._isOpen then
			if i == 3 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnThirdPosOpen)
			elseif i == 4 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFourthPosOpen)
			end
		end
	end
end

function RougeHeroGroupListView:_checkWeekWalkCd()
	local list = {}

	for i, heroItem in ipairs(self._heroItemList) do
		local id = heroItem:checkWeekWalkCd()

		if id then
			table.insert(list, id)
		end
	end

	if #list == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeWeekWalkInCdHero")

	self._heroInCdList = list

	TaskDispatcher.runDelay(self._removeWeekWalkInCdHero, self, 1.5)
end

function RougeHeroGroupListView:_removeWeekWalkInCdHero()
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if not self._heroInCdList then
		return
	end

	local list = self._heroInCdList

	self._heroInCdList = nil

	for i, id in ipairs(list) do
		RougeHeroSingleGroupModel.instance:remove(id)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function RougeHeroGroupListView:_calcIndex(position)
	for i = 1, 4 do
		local posTr = self.heroPosTrList[i].parent
		local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

		if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
			return i
		end
	end

	return 0
end

function RougeHeroGroupListView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._removeWeekWalkInCdHero, self)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

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

function RougeHeroGroupListView:_onScreenSizeChange()
	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
	end
end

return RougeHeroGroupListView
