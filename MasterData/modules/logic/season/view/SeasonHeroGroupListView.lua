-- chunkname: @modules/logic/season/view/SeasonHeroGroupListView.lua

module("modules.logic.season.view.SeasonHeroGroupListView", package.seeall)

local SeasonHeroGroupListView = class("SeasonHeroGroupListView", BaseView)

function SeasonHeroGroupListView:onInitView()
	self._goheroarea = gohelper.findChild(self.viewGO, "herogroupcontain/area")
	self._gohero = gohelper.findChild(self.viewGO, "herogroupcontain/hero")
	self._goheroitem = gohelper.findChild(self.viewGO, "herogroupcontain/hero/heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonHeroGroupListView:_editableInitView()
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
		local go = gohelper.findChild(self._goheroarea, "pos" .. i .. "/container")
		local tr = go.transform
		local cloneGO = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, SeasonHeroGroupHeroItem, self)

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

function SeasonHeroGroupListView:addEvents()
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
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, self._onSnapshotSaveSucc, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function SeasonHeroGroupListView:removeEvents()
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
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, self._onSnapshotSaveSucc, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function SeasonHeroGroupListView:onOpen()
	self._isOpen = true

	self:_updateHeroList()
	self:_playOpenAnimation()
end

function SeasonHeroGroupListView:_playOpenAnimation()
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

function SeasonHeroGroupListView:_checkRestrictHero()
	local needRemoveHeroUidDict = {}

	for i = 1, 4 do
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

function SeasonHeroGroupListView:_removeRestrictHero()
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not self.needRemoveHeroUidDict then
		return
	end

	for heroUid, _ in pairs(self.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(heroUid)
	end

	HeroGroupModel.instance:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function SeasonHeroGroupListView:_onHeroGroupExit()
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
	ViewMgr.instance:closeView(ViewName.SeasonHeroGroupFightView, false, false)
end

function SeasonHeroGroupListView:_closeTweenFinish(index)
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

function SeasonHeroGroupListView:_onBeginDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
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

function SeasonHeroGroupListView:_onDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
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

function SeasonHeroGroupListView:_onEndDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
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

		local srcAct104Equips = heroGroupMO:getAct104PosEquips(srcPos).equipUid

		heroGroupMO.activity104Equips[srcPos].equipUid = heroGroupMO:getAct104PosEquips(targetPos).equipUid
		heroGroupMO.activity104Equips[targetPos].equipUid = srcAct104Equips
		heroGroupMO.heroList[srcPos + 1] = heroGroupMO.heroList[targetPos + 1]
		heroGroupMO.heroList[targetPos + 1] = heroGroupMO.heroList[srcPos + 1]

		self:_updateHeroList()

		local actId = ActivityEnum.Activity.Season
		local extraData = {}

		extraData.groupIndex = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)
		extraData.heroGroup = heroGroupMO

		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, extraData)
	end)
end

function SeasonHeroGroupListView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
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

function SeasonHeroGroupListView:_tweenToPos(heroItem, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(heroItem.go.transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)
	end
end

function SeasonHeroGroupListView:_setDragEnabled(isEnabled)
	for i, drag in ipairs(self._heroItemDrag) do
		drag.enabled = isEnabled
	end
end

function SeasonHeroGroupListView:_updateHeroList()
	for i, heroItem in ipairs(self._heroItemList) do
		local groupMO = HeroGroupModel.instance:getCurGroupMO()
		local mo = {}

		mo = HeroSingleGroupMO.New()
		mo.id = i
		mo.heroUid = groupMO.heroList[i]

		heroItem:onUpdateMO(mo)
	end
end

function SeasonHeroGroupListView:_onSnapshotSaveSucc()
	self:_updateHeroList()
	gohelper.setActive(self._goheroarea, false)
	gohelper.setActive(self._goheroarea, true)
	gohelper.setActive(self._gohero, false)
	gohelper.setActive(self._gohero, true)
end

function SeasonHeroGroupListView:_calcIndex(position)
	for i = 1, 4 do
		local posTr = self.heroPosTrList[i].parent
		local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

		if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
			return i
		end
	end

	return 0
end

function SeasonHeroGroupListView:onDestroyView()
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

function SeasonHeroGroupListView:_onScreenSizeChange()
	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
	end
end

function SeasonHeroGroupListView:getHeroItemList()
	return self._heroItemList
end

return SeasonHeroGroupListView
