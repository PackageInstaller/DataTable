-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupListView.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupListView", package.seeall)

local Season166HeroGroupListView = class("Season166HeroGroupListView", BaseView)

function Season166HeroGroupListView:onInitView()
	self.heroContainer = gohelper.findChild(self.viewGO, "herogroupcontain/area")
	self._goheroitem = gohelper.findChild(self.viewGO, "herogroupcontain/hero/heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166HeroGroupListView:_editableInitView()
	local battleId = Season166HeroGroupModel.instance.battleId
	local battleConfig = lua_battle.configDict[battleId]
	local battleContext = Season166Model.instance:getBattleContext()

	self.episodeType = Season166HeroGroupModel.instance.episodeType
	self._playerMax = battleConfig.playerMax
	self._roleNum = battleConfig.roleNum
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

		if battleContext then
			::label_2_0::

			local var_2_0 = battleContext.teachId

			if battleContext.teachId then
				local isTeachItem = battleContext.teachId > 0

				heroItem:setIsTeachItem(isTeachItem)
				table.insert(self.heroPosTrList, tr)
				table.insert(self._heroItemList, heroItem)
				gohelper.setActive(cloneGO, true)
				self:_setHeroItemPos(heroItem, i)
				table.insert(self._heroItemPosList, heroItem.go.transform)
				heroItem:setParent(self.heroPosTrList[i])
				CommonDragHelper.instance:registerDragObj(heroItem.go, self._onBeginDrag, nil, self._onEndDrag, self._checkCanDrag, self, i)
			end
		end
	end

	self._bgList = self:getUserDataTb_()
	self._orderList = self:getUserDataTb_()

	local openCount = Season166HeroGroupModel.instance:positionOpenCount()
	local roleNum = Season166HeroGroupModel.instance:getBattleRoleNum()

	if roleNum then
		openCount = math.min(roleNum, openCount)
	end

	self._openCount = openCount

	for i = 1, self._roleNum do
		local bg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg")

		table.insert(self._bgList, bg)

		local order = gohelper.findChildTextMesh(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg/txt_order")

		order.text = i <= openCount and tostring(i) or ""

		table.insert(self._orderList, order)
	end

	Season166HeroGroupController.instance:dispatchEvent(Season166Event.OnCreateHeroItemDone)
	Season166HeroGroupModel.instance:setHeroGroupItemPos(self._heroItemPosList)
end

function Season166HeroGroupListView:addEvents()
	self.addEventCb(self, Season166Controller.instance, Season166Event.OpenPickAssistView, self.openPickAssistView, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.CleanAssistData, self.cleanAssistData, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._updateHeroList, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function Season166HeroGroupListView:removeEvents()
	self.removeEventCb(self, Season166Controller.instance, Season166Event.OpenPickAssistView, self.openPickAssistView, self)
	self.removeEventCb(self, Season166Controller.instance, Season166Event.CleanAssistData, self.cleanAssistData, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._updateHeroList, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._updateHeroList, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function Season166HeroGroupListView:onOpen()
	self.actId = self.viewParam.actId

	self:_updateHeroList()
	self:_playOpenAnimation()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
end

function Season166HeroGroupListView:_getHeroItemCls()
	return Season166HeroGroupHeroItem
end

function Season166HeroGroupListView:_updateHeroList()
	for i, heroItem in ipairs(self._heroItemList) do
		if Season166HeroGroupModel.instance:isSeason166Episode() then
			local groupMO = Season166HeroGroupModel.instance:getCurGroupMO()
			local mo = Season166HeroSingleGroupModel.instance:getById(i)
			local assistMO = Season166HeroSingleGroupModel.instance.assistMO

			if assistMO and assistMO.pickAssistHeroMO.heroUid == mo.heroUid then
				mo = assistMO
			end

			mo.id = i
			mo.heroUid = groupMO.heroList[i]

			heroItem:onUpdateMO(mo)

			if not self._nowDragingIndex and i <= self._openCount then
				self._orderList[i].text = mo:isEmpty() and i or ""
			end
		end
	end
end

function Season166HeroGroupListView:_playOpenAnimation()
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
end

function Season166HeroGroupListView:openPickAssistView()
	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Activity166, self.actId, nil, self.pickOverCallBack, self, true)
end

function Season166HeroGroupListView:cleanAssistData()
	self._assistMO = nil
end

function Season166HeroGroupListView:pickOverCallBack(mo)
	if not mo then
		self._assistMO = nil

		return
	end

	if self._assistMO then
		if not self._assistMO.id then
			local assistIndex = self:_getAssistIndex(mo.heroMO.heroId)

			if not assistIndex then
				return
			end

			self._assistMO = self._assistMO or Season166AssistHeroSingleGroupMO.New()

			self._assistMO:init(assistIndex, mo)
			Season166HeroSingleGroupModel.instance:setAssistHeroGroupMO(self._assistMO)
			Season166HeroSingleGroupModel.instance:addTo(mo.heroMO.uid, assistIndex)
			Season166HeroGroupModel.instance:replaceSingleGroup()
			Season166HeroGroupModel.instance:saveCurGroupData()
			Season166Controller.instance:dispatchEvent(Season166Event.OnSelectPickAssist, self._assistMO)
		end
	end
end

function Season166HeroGroupListView:_getAssistIndex(assistHeroId)
	for i, heroItem in ipairs(self._heroItemList) do
		local mo = Season166HeroSingleGroupModel.instance:getById(i)
		local heroMo = mo:getHeroMO()

		if heroMo and heroMo.heroId == assistHeroId and assistHeroId then
			Season166HeroSingleGroupModel.instance:removeFrom(i)

			return i
		end
	end

	for i, heroItem in ipairs(self._heroItemList) do
		local mo = Season166HeroSingleGroupModel.instance:getById(i)
		local heroMo = mo:getHeroMO()

		if not heroMo then
			return i
		end
	end
end

function Season166HeroGroupListView:_checkCanDrag(param)
	if not self:canDrag(param) then
		local heroItem = self._heroItemList[param]

		if heroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return true
	end
end

function Season166HeroGroupListView:canDrag(param, isWrap)
	local index = param
	local heroItem = self._heroItemList[index]

	if heroItem.isAid then
		return false
	end

	if heroItem.isTrialLock then
		return false
	end

	if not isWrap and (heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or param > Season166HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function Season166HeroGroupListView:_onBeginDrag(param, pointerEventData)
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

function Season166HeroGroupListView:_onEndDrag(param, pointerEventData)
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

	local battleId = Season166HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	if dragToIndex > Season166HeroGroupModel.instance:positionOpenCount() then
		self._setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)
		logError("drag to Error OpenCount Pos")

		return
	end

	local roleNum = Season166HeroGroupModel.instance:getBattleRoleNum()

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

		local heroGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()
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

		Season166HeroSingleGroupModel.instance:swap(index, dragToIndex)

		local newHeroUids = Season166HeroSingleGroupModel.instance:getHeroUids()

		for i, heroUid in ipairs(heroGroupMO.heroList) do
			if newHeroUids[i] ~= heroUid then
				Season166HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				Season166HeroGroupModel.instance:saveCurGroupData()
				self:_updateHeroList()

				break
			end
		end
	end, self)
end

function Season166HeroGroupListView:_calcIndex(position)
	for i = 1, self._roleNum do
		local posTr = self.heroPosTrList[i].parent

		if gohelper.isMouseOverGo(posTr, position) then
			return i
		end
	end

	return 0
end

function Season166HeroGroupListView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
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

function Season166HeroGroupListView:_onHeroGroupExit()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	self._closeTweenIdList = {}

	for i = 1, 4 do
		local closeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - i), nil, self._closeTweenFinish, self, i, EaseType.Linear)

		table.insert(self._closeTweenIdList, closeTweenId)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(self.viewName, false, false)
end

function Season166HeroGroupListView:_closeTweenFinish(index)
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

function Season166HeroGroupListView:onDestroyView()
	CommonDragHelper.instance:setGlobalEnabled(true)

	for i = 1, self._roleNum do
		CommonDragHelper.instance:unregisterDragObj(self._heroItemList[i].go)
	end

	if self._closeTweenIdList then
		for i, closeTweenId in ipairs(self._closeTweenIdList) do
			ZProj.TweenHelper.KillById(closeTweenId)
		end
	end
end

function Season166HeroGroupListView:_onScreenSizeChange()
	for i = 1, self._roleNum do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
	end
end

return Season166HeroGroupListView
