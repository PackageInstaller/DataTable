-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroListView.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroListView", package.seeall)

local OdysseyHeroListView = class("OdysseyHeroListView", BaseView)
local maxHeroCount = 5

function OdysseyHeroListView:onInitView()
	self._goheroarea = gohelper.findChild(self.viewGO, "herogroupcontain/area")
	self._gohero = gohelper.findChild(self.viewGO, "herogroupcontain/hero")
	self._goheroitem = gohelper.findChild(self.viewGO, "herogroupcontain/hero/heroitem")
	self._heroGroupContainer = gohelper.findChild(self.viewGO, "herogroupcontain")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyHeroListView:_editableInitView()
	self.heroGroupWidth = recthelper.getWidth(self._heroGroupContainer.transform)

	self:initItemPos()
	self:refreshHeroGroupWidth()
end

function OdysseyHeroListView:addEvents()
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
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHero, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, self._onSnapshotSaveSucc, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self.addEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self._updateHeroList, self)
end

function OdysseyHeroListView:removeEvents()
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
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self._checkRestrictHero, self)
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, self._onSnapshotSaveSucc, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self.removeEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self._updateHeroList, self)
end

function OdysseyHeroListView:onOpen()
	self._isOpen = true

	self:_updateHeroList()
	self:_playOpenAnimation()
	CommonDragHelper.instance:setGlobalEnabled(true)
end

function OdysseyHeroListView:initItemPos()
	self._heroItemList = {}
	self._heroItemDrag = self:getUserDataTb_()

	gohelper.setActive(self._goheroitem, false)
	gohelper.setActive(self._goaidheroitem, false)

	self.heroPosTrList = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()

	for i = 1, maxHeroCount do
		local go = gohelper.findChild(self._goheroarea, "pos" .. i .. "/container")
		local tr = go.transform
		local cloneGO = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, OdysseyHeroGroupItem, self)

		table.insert(self.heroPosTrList, tr)
		table.insert(self._heroItemList, item)
		item:initEquipItem(self.getEquipPrefab, self)
		gohelper.setActive(cloneGO, true)
	end

	for i = 1, maxHeroCount do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
		table.insert(self._heroItemPosList, heroItem.go.transform)
		heroItem:setParent(self.heroPosTrList[i])

		local drag = SLFramework.UGUI.UIDragListener.Get(heroItem.go)

		table.insert(self._heroItemDrag, drag)
	end

	self._bgList = {}

	for i = 1, maxHeroCount do
		local bg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg")

		table.insert(self._bgList, bg)
	end

	HeroGroupModel.instance:setHeroGroupItemPos(self._heroItemPosList)

	self.odysseyEquipPosList = {}
	self.odysseyEquipItemList = {}

	for i = 1, maxHeroCount do
		local heroItem = self._heroItemList[i]
		local equipItemList = heroItem:getOdysseyEquipItem()

		for _, equipItem in ipairs(equipItemList) do
			table.insert(self.odysseyEquipPosList, equipItem.go.transform)
			table.insert(self.odysseyEquipItemList, equipItem)
		end
	end

	self._orderList = {}
	self._bgList = {}

	for i = 1, maxHeroCount do
		local bg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg")

		table.insert(self._bgList, bg)

		local order = gohelper.findChildTextMesh(self.viewGO, "herogroupcontain/hero/bg" .. i .. "/bg/#txt_order")

		order.text = tostring(i) or ""

		table.insert(self._orderList, order)
	end
end

function OdysseyHeroListView:refreshHeroGroupWidth()
	local curGroupMO = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	if self.haveSuit == nil or self.haveSuit ~= curGroupMO.haveSuit then
		if curGroupMO.haveSuit then
			if not self.heroGroupWidth then
				local width = 2321

				recthelper.setWidth(self._heroGroupContainer.transform, width)
				recthelper.setWidth(self._gohero.transform, width)
				recthelper.setWidth(self._goheroarea.transform, width)
				logNormal("refreshHeroGroupWidth")

				for i = 1, maxHeroCount do
					local heroItem = self._heroItemList[i]

					self:_setHeroItemPos(heroItem, i)
				end

				self.haveSuit = curGroupMO.haveSuit
			end
		end
	end
end

function OdysseyHeroListView:_playOpenAnimation()
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

function OdysseyHeroListView:_checkRestrictHero()
	local needRemoveHeroUidDict = {}

	for i = 1, maxHeroCount do
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

function OdysseyHeroListView:_removeRestrictHero()
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

function OdysseyHeroListView:_onHeroGroupExit()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if self._openTweenIdList then
		for i, openTweenId in ipairs(self._openTweenIdList) do
			ZProj.TweenHelper.KillById(openTweenId)
		end
	end

	self._closeTweenIdList = {}

	for i = 1, maxHeroCount do
		local closeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (maxHeroCount - i), nil, self._closeTweenFinish, self, i, EaseType.Linear)

		table.insert(self._closeTweenIdList, closeTweenId)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(ViewName.OdysseyHeroGroupView, false, false)
end

function OdysseyHeroListView:_closeTweenFinish(index)
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

function OdysseyHeroListView:canDrag(param, isWrap)
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

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

	if not isWrap and (heroItem.mo:isEmpty() or heroItem.mo.aid == -1 or index > OdysseyEnum.MaxHeroGroupCount) then
		return false
	end

	return true
end

function OdysseyHeroListView:_onBeginDrag(param, pointerEventData)
	if self._tweening then
		return
	end

	if not self:canDrag(param) then
		return
	end

	local index = param
	local heroItem = self._heroItemList[index]

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

function OdysseyHeroListView:_onDrag(param, pointerEventData)
	if not self:canDrag(param) then
		local heroItem = self._heroItemList[param]

		if heroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	local index = param
	local heroItem = self._heroItemList[index]
	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._goheroarea.transform)

	self:_tweenToPos(heroItem, anchorPos)
end

function OdysseyHeroListView:_onEndDrag(param, pointerEventData)
	if not self:canDrag(param) then
		return
	end

	local index = param
	local heroItem = self._heroItemList[index]
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

	if dragToIndex <= 0 or not self:canDrag(dragToIndex, true) then
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

		heroGroupMO:swapOdysseyEquips(srcPos, targetPos)
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
	end)
end

function OdysseyHeroListView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
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

function OdysseyHeroListView:_tweenToPos(heroItem, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(heroItem.go.transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)
	end
end

function OdysseyHeroListView:_setDragEnabled(isEnabled)
	for i, drag in ipairs(self._heroItemDrag) do
		drag.enabled = isEnabled
	end
end

function OdysseyHeroListView:_updateHeroList()
	self:refreshHeroGroupWidth()

	for i, heroItem in ipairs(self._heroItemList) do
		local mo = HeroSingleGroupModel.instance:getById(i)

		heroItem:onUpdateMO(mo)
	end
end

function OdysseyHeroListView:_onSnapshotSaveSucc()
	self:_updateHeroList()
	gohelper.setActive(self._goheroarea, false)
	gohelper.setActive(self._goheroarea, true)
	gohelper.setActive(self._gohero, false)
	gohelper.setActive(self._gohero, true)
end

function OdysseyHeroListView:_calcIndex(position)
	for i = 1, OdysseyEnum.MaxHeroGroupCount do
		local posTr = self.heroPosTrList[i].parent
		local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

		if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
			return i
		end
	end

	return 0
end

function OdysseyHeroListView:onDestroyView()
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

	CommonDragHelper.instance:setGlobalEnabled(true)
end

function OdysseyHeroListView:_onScreenSizeChange()
	for i = 1, maxHeroCount do
		local heroItem = self._heroItemList[i]

		self:_setHeroItemPos(heroItem, i)
	end
end

function OdysseyHeroListView:getHeroItemList()
	return self._heroItemList
end

function OdysseyHeroListView:getEquipPrefab(parent)
	return self:getResInst(self.viewContainer:getSetting().otherRes[2], parent)
end

return OdysseyHeroListView
