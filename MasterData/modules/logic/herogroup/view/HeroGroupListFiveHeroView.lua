-- chunkname: @modules/logic/herogroup/view/HeroGroupListFiveHeroView.lua

module("modules.logic.herogroup.view.HeroGroupListFiveHeroView", package.seeall)

local HeroGroupListFiveHeroView = class("HeroGroupListFiveHeroView", BaseView)

function HeroGroupListFiveHeroView:onInitView()
	self.heroContainer = gohelper.findChild(self.viewGO, "herogroupcontain/area")
	self._goheroitem = gohelper.findChild(self.viewGO, "herogroupcontain/hero/heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupListFiveHeroView:_editableInitView()
	local battleId = HeroGroupModel.instance.battleId
	local battleConfig = lua_battle.configDict[battleId]

	self._playerMax = battleConfig.playerMax
	self._roleNum = ModuleEnum.FiveHeroEnum.MaxHeroNum
	self._heroItemList = {}

	gohelper.setActive(self._goheroitem, false)

	self.heroPosTrList = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()

	for i = 1, self._roleNum do
		local go = gohelper.findChild(self.heroContainer, "pos" .. i .. "/container")
		local tr = go.transform
		local cloneGO = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, self:_getHeroItemCls(), self)

		heroItem:setIndex(i)
		table.insert(self.heroPosTrList, tr)
		table.insert(self._heroItemList, heroItem)
		gohelper.setActive(cloneGO, true)
		self:_setHeroItemPos(heroItem, i)
		table.insert(self._heroItemPosList, heroItem.go.transform)
		heroItem:setParent(self.heroPosTrList[i])
		CommonDragHelper.instance:registerDragObj(heroItem.go, self._onBeginDrag, nil, self._onEndDrag, self._checkCanDrag, self, i)
	end

	self._bgList = self:getUserDataTb_()
	self._orderList = self:getUserDataTb_()

	local openCount = self._roleNum
	local roleNum = HeroGroupModel.instance:getBattleRoleNum()

	if roleNum then
		openCount = math.min(roleNum, openCount)
	end

	openCount = math.min(self._playerMax, openCount)
	self._openCount = openCount

	for i = 1, self._roleNum do
		local bg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg")

		table.insert(self._bgList, bg)

		local order = gohelper.findChildTextMesh(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg/#txt_order")

		order.text = i <= openCount and tostring(i) or ""

		table.insert(self._orderList, order)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(self._heroItemPosList)
end

function HeroGroupListFiveHeroView:addEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHero, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._checkRestrictHero, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function HeroGroupListFiveHeroView:removeEvents()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._updateHeroList, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHero, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._checkRestrictHero, self)
end

function HeroGroupListFiveHeroView:onOpen()
	self._isOpen = true

	self:_updateHeroList()
	self:_playOpenAnimation()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
end

function HeroGroupListFiveHeroView:_playOpenAnimation()
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

	self:_checkRestrictHero()
end

function HeroGroupListFiveHeroView:_getHeroItemCls()
	return HeroGroupHeroItem
end

function HeroGroupListFiveHeroView:_checkRestrictHero()
	local needRemoveHeroUidDict = {}

	for i = 1, self._roleNum do
		local heroSingleGroupMO = HeroSingleGroupModel.instance:getById(i)

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

function HeroGroupListFiveHeroView:_removeRestrictHero()
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not self.needRemoveHeroUidDict then
		return
	end

	for heroUid, _ in pairs(self.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(heroUid)
	end

	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function HeroGroupListFiveHeroView:_onHeroGroupExit()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if self._openTweenIdList then
		for i, openTweenId in ipairs(self._openTweenIdList) do
			ZProj.TweenHelper.KillById(openTweenId)
		end
	end

	self._closeTweenIdList = {}

	for i = 1, self._roleNum do
		local closeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (self._roleNum - i), nil, self._closeTweenFinish, self, i, EaseType.Linear)

		table.insert(self._closeTweenIdList, closeTweenId)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(self.viewName, false, false)
end

function HeroGroupListFiveHeroView:_closeTweenFinish(index)
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
	end

	local bg = self._bgList[index]

	if bg then
		local anim = bg:GetComponent(typeof(UnityEngine.Animator))

		anim:Play(UIAnimationName.Close)

		anim.speed = 1
	end
end

function HeroGroupListFiveHeroView:canDrag(param, isWrap)
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

	if not isWrap and (heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or param > self._roleNum) then
		return false
	end

	return true
end

function HeroGroupListFiveHeroView:_checkCanDrag(param)
	if not self:canDrag(param) then
		local heroItem = self._heroItemList[param]

		if heroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return true
	end
end

function HeroGroupListFiveHeroView:_onBeginDrag(param, pointerEventData)
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
end

function HeroGroupListFiveHeroView:_onEndDrag(param, pointerEventData)
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

	if dragToIndex > self._roleNum then
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

function HeroGroupListFiveHeroView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
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

function HeroGroupListFiveHeroView:_tweenToPos(heroItem, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(heroItem.go.transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)
	end
end

function HeroGroupListFiveHeroView:_updateHeroList()
	local groupFightView = self.viewContainer:getHeroGroupFightView()
	local isReplay = groupFightView:isReplayMode()

	for i, heroItem in ipairs(self._heroItemList) do
		local mo = HeroSingleGroupModel.instance:getById(i)

		heroItem:onUpdateMO(mo)

		if not self._nowDragingIndex and i <= self._openCount then
			self._orderList[i].text = mo:isEmpty() and i or ""
		end

		if not heroItem.isLock and not HeroSingleGroupModel.instance:isTemp() and not isReplay and self._isOpen then
			if i == 3 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnThirdPosOpen)
			elseif i == 4 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFourthPosOpen)
			end
		end
	end
end

function HeroGroupListFiveHeroView:_calcIndex(position)
	for i = 1, self._roleNum do
		local posTr = self.heroPosTrList[i].parent

		if gohelper.isMouseOverGo(posTr, position) then
			return i
		end
	end

	return 0
end

function HeroGroupListFiveHeroView:onDestroyView()
	CommonDragHelper.instance:setGlobalEnabled(true)

	for i = 1, self._roleNum do
		CommonDragHelper.instance:unregisterDragObj(self._heroItemList[i].go)
	end

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

function HeroGroupListFiveHeroView:_onScreenSizeChange()
	for i = 1, self._roleNum do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
	end
end

return HeroGroupListFiveHeroView
