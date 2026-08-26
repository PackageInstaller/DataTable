-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupListView.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupListView", package.seeall)

local TowerComposeHeroGroupListView = class("TowerComposeHeroGroupListView", BaseView)

function TowerComposeHeroGroupListView:onInitView()
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "#go_herogroupcontain")
	self._goherogroupcontain2 = gohelper.findChild(self.viewGO, "#go_herogroupcontain2")
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupListView:addEvents()
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
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function TowerComposeHeroGroupListView:removeEvents()
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
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, self._onHeroGroupExit, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self._checkRestrictHero, self)
end

function TowerComposeHeroGroupListView:_editableInitView()
	self._goplaneHeroContain = gohelper.findChild(self.viewGO, "#go_herogroupcontain2/contain")

	gohelper.setActive(self._goheroitem, false)
	self:initData()
	self:initHeroItemList()
end

function TowerComposeHeroGroupListView:onUpdateParam()
	return
end

function TowerComposeHeroGroupListView:onOpen()
	self:checkReplaceHeroList()
	self:_updateHeroList()
	self:_playOpenAnimation()
end

function TowerComposeHeroGroupListView:initData()
	self.recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	self.themeId = self.recordFightParam.themeId
	self.layerId = self.recordFightParam.layerId
	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.layerId)
	self.dungeonEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.towerEpisodeConfig.episodeId)
	self.episodeId = self.towerEpisodeConfig.episodeId
	self.battleId = self.dungeonEpisodeCo.battleId
	self.battleConfig = lua_battle.configDict[self.battleId]
	self.isPlaneEpisode = self.towerEpisodeConfig.plane > 0
	self.isHaveTwoPlane = self.towerEpisodeConfig.plane == 2

	if self.isPlaneEpisode then
		if not ModuleEnum.HeroGroupSnapshotType.TowerComposeBoss then
			local heroGroupId = ModuleEnum.HeroGroupSnapshotType.TowerComposeNormal
			local heroTeamConfig = lua_hero_team.configDict[heroGroupId]
			local roleNumMax = heroTeamConfig.batNum

			self.playerNum = self.battleConfig.roleNum
			self.roleNum = self.isHaveTwoPlane and roleNumMax or self.playerNum

			gohelper.setActive(self._goherogroupcontain, not self.isHaveTwoPlane)
			gohelper.setActive(self._goherogroupcontain2, self.isHaveTwoPlane)
			HeroGroupModel.instance:setBattleAndEpisodeId(self.battleId, self.episodeId)
		end
	end
end

function TowerComposeHeroGroupListView:initHeroItemList()
	self._heroItemList = self:getUserDataTb_()
	self.heroItemGOList = self:getUserDataTb_()
	self.heroPosTrList = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()
	self._bgList = self:getUserDataTb_()
	self._orderList = self:getUserDataTb_()

	if self.isHaveTwoPlane then
		if not self._goplaneHeroContain then
			local heroContainerGO = self._goherogroupcontain

			for index = 1, self.roleNum do
				self:createHeroItem(index, heroContainerGO)
			end

			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
		end
	end
end

function TowerComposeHeroGroupListView:createHeroItem(index, heroContainer)
	local heroItemGO = self.heroItemGOList[index]

	if not heroItemGO then
		heroItemGO = {
			index = index
		}
		heroItemGO.planeType = self.isPlaneEpisode and Mathf.Ceil(index / self.playerNum) or 0
		heroItemGO.heroContainerGO = heroContainer
		heroItemGO.posGO = gohelper.findChild(heroContainer, "area/pos" .. index .. "/container")
		heroItemGO.heroRoot = gohelper.findChild(heroContainer, "hero")
		heroItemGO.areaRoot = gohelper.findChild(heroContainer, "area")
		heroItemGO.go = gohelper.clone(self._goheroitem, heroItemGO.heroRoot, "heroItem" .. index)

		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(heroItemGO.go, TowerComposeHeroGroupHeroItem, self)

		self.heroItemGOList[index] = heroItemGO

		local posTrans = heroItemGO.posGO.transform
		local bg = gohelper.findChild(heroContainer, "hero/bg" .. index .. "/bg")
		local order = gohelper.findChildText(heroContainer, "hero/bg" .. index .. "/bg/txt_order")

		table.insert(self._bgList, bg)
		table.insert(self._orderList, order)
		table.insert(self._heroItemPosList, heroItemGO.go.transform)
		table.insert(self.heroPosTrList, posTrans)
		table.insert(self._heroItemList, heroItem)
		heroItem:setIndex(index)
		self:setHeroItemPos(heroItem, index)
		heroItem:setParent(self.heroPosTrList[index])
		heroItem:setPlaneType(heroItem.planeType)
	end

	gohelper.setActive(heroItemGO.go, true)

	if heroItemGO.planeType == 2 then
		self._orderList[index].text = index % 4 or index
	end

	CommonDragHelper.instance:registerDragObj(heroItemGO.go, self._onBeginDrag, nil, self._onEndDrag, self._checkCanDrag, self, index)
end

function TowerComposeHeroGroupListView:setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self.heroPosTrList[index]
	local heroContainerGO = self.heroItemGOList[index].heroContainerGO
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, heroContainerGO.transform)

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

function TowerComposeHeroGroupListView:checkReplaceHeroList()
	local groupMO = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(self.roleNum)
	groupMO:setTowerComposeHeroList(self.roleNum)

	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local curBossMo = themeMo:getCurBossMo()

	if curBossMo and curBossMo.lock then
		local heroList = {}

		for pos = 1, self.roleNum do
			local planeId = Mathf.Ceil(pos / 4)
			local planeMo = curBossMo:getPlaneMo(planeId)
			local teamInfoData = planeMo:getTeamInfoData()

			if pos > 4 then
				if not (pos - 4) then
					local dataPos = pos
					local heroData = teamInfoData.heros[dataPos]

					if heroData then
						if heroData.heroId > 0 then
							local heroMo = HeroModel.instance:getByHeroId(heroData.heroId)

							table.insert(heroList, {
								heroUid = heroMo.uid,
								equipUid = {
									heroData.equipId
								}
							})
						elseif heroData.trialId > 0 then
							local trialCo = lua_hero_trial.configDict[heroData.trialId][0]
							local heroId = tostring(tonumber(trialCo.id .. "." .. trialCo.trialTemplate) - 1099511627776)

							table.insert(heroList, {
								heroUid = heroId,
								equipUid = {
									tostring(trialCo.equipId)
								}
							})
						else
							table.insert(heroList, {
								heroUid = "0",
								equipUid = {
									"0"
								}
							})
						end
					else
						table.insert(heroList, {
							heroUid = "0",
							equipUid = {
								"0"
							}
						})
					end
				end
			end
		end

		TowerComposeHeroGroupModel.instance:replaceLockPlaneHeroList(groupMO, heroList)
	end

	HeroSingleGroupModel.instance:setSingleGroup(groupMO, true)
end

function TowerComposeHeroGroupListView:_updateHeroList()
	for index, heroItem in ipairs(self._heroItemList) do
		if TowerComposeHeroGroupModel.instance:isTowerComposeEpisode(self.episodeId) then
			local mo = HeroSingleGroupModel.instance:getById(index)

			heroItem:onUpdateMO(mo)

			if not self.nowDragingIndex then
				self._orderList[index].text = mo:isEmpty() and index or ""
			end
		end
	end

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.RefreshHeroGroupPointBase)
end

function TowerComposeHeroGroupListView:_playOpenAnimation()
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

function TowerComposeHeroGroupListView:_checkRestrictHero()
	local needRemoveHeroUidDict = {}

	for i = 1, self.roleNum do
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

function TowerComposeHeroGroupListView:_removeRestrictHero()
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

function TowerComposeHeroGroupListView:canDrag(param, isWrap)
	local index = param
	local heroItem = self._heroItemList[index]

	if not heroItem then
		return false
	end

	if heroItem.isAid then
		return false
	end

	if heroItem.isTrialLock then
		return false
	end

	if not isWrap and (heroItem.mo:isEmpty() or heroItem.mo.aid == -1) then
		return false
	end

	if self:checkHeroItemInLockPlane(param) then
		GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

		return false
	end

	return true
end

function TowerComposeHeroGroupListView:_checkCanDrag(param)
	if not self:canDrag(param) then
		local heroItem = self._heroItemList[param]

		if heroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return true
	end
end

function TowerComposeHeroGroupListView:checkHeroItemInLockPlane(index)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local curBossMo = themeMo:getCurBossMo()

	if curBossMo and curBossMo.lock then
		local planeId = Mathf.Ceil(index / 4)
		local planeMo = themeMo:getPlaneMo(planeId)
		local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, planeId)

		return isPlaneLock and planeMo.hasFight
	end

	return false
end

function TowerComposeHeroGroupListView:_onBeginDrag(param, pointerEventData)
	if not self:canDrag(param) then
		return
	end

	if self.nowDragingIndex then
		return
	end

	local heroItem = self._heroItemList[param]

	self._orderList[param].text = param
	self.nowDragingIndex = param

	for _, item in ipairs(self._heroItemList) do
		item:onItemBeginDrag(self.nowDragingIndex)
		item:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(heroItem.go)
end

function TowerComposeHeroGroupListView:_onEndDrag(param, pointerEventData)
	if not self:canDrag(param) then
		return
	end

	if self.nowDragingIndex ~= param then
		return
	end

	self.nowDragingIndex = nil

	local dragToIndex = self:_calcIndex(pointerEventData.position)
	local heroItem = self._heroItemList[param]
	local index = param

	for _, item in ipairs(self._heroItemList) do
		item:onItemEndDrag(index, dragToIndex)
	end

	CommonDragHelper.instance:setGlobalEnabled(false)

	if dragToIndex == param or dragToIndex <= 0 then
		self._orderList[param].text = ""
	end

	local function completeDragFunc(self, complete)
		for _, item in ipairs(self._heroItemList) do
			item:onItemCompleteDrag(index, dragToIndex, complete)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)

		for _, item in ipairs(self._heroItemList) do
			item:flowCurrentParent()
		end
	end

	if dragToIndex <= 0 then
		self.setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	local dragToIndexIsInLockPlane = self:checkHeroItemInLockPlane(dragToIndex)

	if dragToIndexIsInLockPlane then
		GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)
		self.setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	local dragHeroItem = self._heroItemList[dragToIndex]

	if dragHeroItem and dragHeroItem.trialCO then
		if not TowerComposeHeroGroupModel.instance:checkCanSelectTrialHero(dragHeroItem.trialCO, index) then
			TowerComposeController.instance:showPlaneTrialLimitToast(Mathf.Ceil(index / 4))
			self.setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

			return
		end
	elseif heroItem.trialCO and not TowerComposeHeroGroupModel.instance:checkCanSelectTrialHero(heroItem.trialCO, dragToIndex) then
		TowerComposeController.instance:showPlaneTrialLimitToast(Mathf.Ceil(dragToIndex / 4))
		self.setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	if not self:canDrag(dragToIndex, true) then
		if dragHeroItem and dragHeroItem.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		self.setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	if dragToIndex <= 0 then
		self.setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	local otherHeroItem = self._heroItemList[dragToIndex]

	if otherHeroItem.mo.aid then
		self.setHeroItemPos(self, heroItem, index, true, completeDragFunc, self)

		return
	end

	if index ~= dragToIndex then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(otherHeroItem.go)
	gohelper.setAsLastSibling(heroItem.go)
	otherHeroItem:flowOriginParent()

	self._tweenId = self:setHeroItemPos(otherHeroItem, index, true)

	self.setHeroItemPos(self, heroItem, dragToIndex, true, function()
		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		for i, heroItem in ipairs(self._heroItemList) do
			self:setHeroItemPos(heroItem, i)
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

function TowerComposeHeroGroupListView:_calcIndex(position)
	for i = 1, self.roleNum do
		local posTr = self.heroPosTrList[i].parent

		if gohelper.isMouseOverGo(posTr, position) then
			return i
		end
	end

	return 0
end

function TowerComposeHeroGroupListView:_onHeroGroupExit()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if self._openTweenIdList then
		for i, openTweenId in ipairs(self._openTweenIdList) do
			ZProj.TweenHelper.KillById(openTweenId)
		end
	end

	self._closeTweenIdList = {}

	for i = 1, self.roleNum do
		local closeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (self.roleNum - i), nil, self._closeTweenFinish, self, i, EaseType.Linear)

		table.insert(self._closeTweenIdList, closeTweenId)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(self.viewName, false, false)
end

function TowerComposeHeroGroupListView:_closeTweenFinish(index)
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

function TowerComposeHeroGroupListView:_onScreenSizeChange()
	for i = 1, self.roleNum do
		local heroItem = self._heroItemList[i]

		self:setHeroItemPos(heroItem, i)
	end
end

function TowerComposeHeroGroupListView:onClose()
	TowerComposeHeroGroupModel.instance:saveThemePlaneBuffData()
end

function TowerComposeHeroGroupListView:onDestroyView()
	for index, heroItem in ipairs(self._heroItemList) do
		CommonDragHelper.instance:unregisterDragObj(heroItem.go)
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

return TowerComposeHeroGroupListView
