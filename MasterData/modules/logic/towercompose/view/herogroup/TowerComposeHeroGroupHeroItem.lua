-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupHeroItem.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupHeroItem", package.seeall)

local TowerComposeHeroGroupHeroItem = class("TowerComposeHeroGroupHeroItem", HeroGroupHeroItem)

function TowerComposeHeroGroupHeroItem:init(go)
	TowerComposeHeroGroupHeroItem.super.init(self, go)

	self._goaddNum = gohelper.findChild(go, "heroitemani/#go_addnum")
	self._txtaddNum = gohelper.findChildText(go, "heroitemani/#go_addnum/#txt_addnum")
end

function TowerComposeHeroGroupHeroItem:onUpdateMO(mo)
	TowerComposeHeroGroupHeroItem.super.onUpdateMO(self, mo)
	gohelper.setActive(self._subGO, false)
	transformhelper.setLocalPosXY(self._tagTr, 36.3, 212.1)
	self:refreshExtraAddTag()
end

function TowerComposeHeroGroupHeroItem:refreshExtraAddTag()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local layerId = recordFightParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	local heroId = TowerComposeHeroGroupModel.instance:getHeroIdByHeroSingleGroupMO(self.mo)

	if not heroId or tonumber(heroId) == 0 or towerEpisodeConfig.plane == 0 then
		gohelper.setActive(self._goaddNum, false)

		return
	end

	local isExtraHero, extraCo = TowerComposeConfig.instance:checkIsExtraHero(themeId, heroId)

	if isExtraHero then
		self._txtaddNum.text = string.format("+%s", extraCo.bossPointBase)
	end

	local curInPlaneId = Mathf.Ceil(self._index / 4) or 0
	local realExtraHeroCoList = TowerComposeHeroGroupModel.instance:getPlaneRealExtraCoList(themeId, curInPlaneId)
	local isRealExtraHero = false

	for _, extraCo in ipairs(realExtraHeroCoList) do
		if heroId == extraCo.id then
			isRealExtraHero = true

			break
		end
	end

	gohelper.setActive(self._goaddNum, isExtraHero and towerEpisodeConfig.plane > 0 and isRealExtraHero)
end

function TowerComposeHeroGroupHeroItem:_checkDrag()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local curInPlaneId = Mathf.Ceil(self._index / 4) or 0
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(themeId, curInPlaneId)
	local planeMo = themeMo:getPlaneMo(curInPlaneId)

	if isPlaneLock and planeMo.hasFight then
		GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)

		return true
	end

	return TowerComposeHeroGroupHeroItem.super._checkDrag(self)
end

function TowerComposeHeroGroupHeroItem:_onEndDrag(_, pointerEventData)
	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + HeroGroupHeroItem.EquipDragOffset
	end

	local targetHeroItem = self:_moveToTarget(pos)

	self:_setEquipDragEnabled(false)

	if targetHeroItem then
		::label_5_0::

		local var_5_0 = targetHeroItem.trialCO

		if targetHeroItem.trialCO then
			local isTrialDefaultEquip = targetHeroItem.trialCO.equipId > 0

			if not targetHeroItem or targetHeroItem == self or targetHeroItem.mo.aid or isTrialDefaultEquip or not targetHeroItem._equipGO.activeSelf then
				if isTrialDefaultEquip then
					GameFacade.showToast(ToastEnum.TrialCantEditEquip)
				end

				self._setToPos(self, self._equip.moveContainer.transform, Vector2(), true, function()
					gohelper.setActive(self._equip.equipGolv, true)
					self:_setEquipDragEnabled(true)
				end, self)
				self:_showEquipParticleEffect()

				return
			end

			local targetHeroInPlaneId = Mathf.Ceil(targetHeroItem._index / 4) or 0
			local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
			local themeId = recordFightParam.themeId
			local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(themeId, targetHeroInPlaneId)
			local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
			local planeMo = themeMo:getPlaneMo(targetHeroInPlaneId)

			if isPlaneLock and planeMo.hasFight then
				GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)
				self._setToPos(self, self._equip.moveContainer.transform, Vector2(), true, function()
					gohelper.setActive(self._equip.equipGolv, true)
					self:_setEquipDragEnabled(true)
				end, self)
				self:_showEquipParticleEffect()

				return
			end

			self:_playDragEndAudio(targetHeroItem)
			gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[targetHeroItem.mo.id].parent.gameObject)
			gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)

			local anotherAnchorPos = recthelper.rectToRelativeAnchorPos(self._equipGO.transform.position, targetHeroItem._equipGO.transform)

			self._tweenId = self:_setToPos(targetHeroItem._equip.moveContainer.transform, anotherAnchorPos, true)

			local anchorPos = recthelper.rectToRelativeAnchorPos(targetHeroItem._equipGO.transform.position, self._equipGO.transform)

			self._setToPos(self, self._equip.moveContainer.transform, anchorPos, true, function()
				EquipTeamListModel.instance:openTeamEquip(self.mo.id - 1, self._heroMO)

				if self._tweenId then
					ZProj.TweenHelper.KillById(self._tweenId)
				end

				self:_setToPos(self._equip.moveContainer.transform, Vector2())
				self:_setToPos(targetHeroItem._equip.moveContainer.transform, Vector2())
				gohelper.setActive(self._equip.equipGolv, true)
				self:_setEquipDragEnabled(true)

				local srcPos = self.mo.id - 1
				local targetPos = targetHeroItem.mo.id - 1
				local srcEquipId = EquipTeamListModel.instance:getTeamEquip(srcPos)[1]

				srcEquipId = (EquipModel.instance:getEquip(srcEquipId) or HeroGroupTrialModel.instance:getEquipMo(srcEquipId)) and srcEquipId or nil

				if srcEquipId then
					EquipTeamShowItem.removeEquip(srcPos, true)
				end

				local targetEquipId = EquipTeamListModel.instance:getTeamEquip(targetPos)[1]

				targetEquipId = (EquipModel.instance:getEquip(targetEquipId) or HeroGroupTrialModel.instance:getEquipMo(targetEquipId)) and targetEquipId or nil

				if targetEquipId then
					EquipTeamShowItem.removeEquip(targetPos, true)
				end

				if srcEquipId then
					EquipTeamShowItem.replaceEquip(targetPos, srcEquipId, true)
				end

				if targetEquipId then
					EquipTeamShowItem.replaceEquip(srcPos, targetEquipId, true)
				end

				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
				HeroGroupModel.instance:saveCurGroupData()
			end, self)
		end
	end
end

function TowerComposeHeroGroupHeroItem:_onClickEquip()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or self.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		self._viewParam = {
			heroMo = self._heroMO,
			equipMo = self._equipMO,
			posIndex = self._posIndex,
			fromView = EquipEnum.FromViewEnum.FromTowerComposeHeroGroupView
		}

		if self.trialCO then
			self._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(self.trialCO)

			if self.trialCO.equipId > 0 then
				self._viewParam.equipMo = self._viewParam.heroMo.trialEquipMo
			end
		end

		self:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function TowerComposeHeroGroupHeroItem:setPlaneType(planeType)
	self.planeType = planeType
end

return TowerComposeHeroGroupHeroItem
