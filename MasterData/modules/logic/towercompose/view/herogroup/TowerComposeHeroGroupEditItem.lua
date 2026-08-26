-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupEditItem.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupEditItem", package.seeall)

local TowerComposeHeroGroupEditItem = class("TowerComposeHeroGroupEditItem", HeroGroupEditItem)

function TowerComposeHeroGroupEditItem:_initObj(go)
	TowerComposeHeroGroupEditItem.super._initObj(self, go)

	self._goplaneLock = gohelper.findChild(go, "#go_planeLock")
	self._goaddNum = gohelper.findChild(go, "#go_addnum")
	self._txtNum = gohelper.findChildText(go, "#go_addnum/#txt_num")
end

function TowerComposeHeroGroupEditItem:updateTrialTag()
	TowerComposeHeroGroupEditItem.super.updateTrialTag(self)

	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local layerId = recordFightParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	local isExtraHero, extraCo = TowerComposeConfig.instance:checkIsExtraHero(themeId, self._mo.config.id)

	gohelper.setActive(self._goaddNum, isExtraHero and towerEpisodeConfig.plane > 0)

	if isExtraHero then
		self._txtNum.text = string.format("+%s", extraCo.bossPointBase)
	end

	local isInLockPlane = TowerComposeHeroGroupModel.instance:checkHeroUidIsInLockPlane(self._mo.uid)

	gohelper.setActive(self._goplaneLock, isInLockPlane)
end

function TowerComposeHeroGroupEditItem:updateTrialRepeat()
	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = HeroGroupEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)
	local isInSupport = TowerComposeHeroGroupModel.instance:checkEquipedSupportHero(self._mo.heroId)
	local trialTag = ""

	if isRepeat then
		trialTag = luaLang("p_commonheroitemnew_repeat")
	elseif isInSupport then
		trialTag = luaLang("towercompose_inSupport")
	end

	self._heroItem:setTrialRepeatCn(trialTag)
	self._heroItem:setTrialRepeat(isRepeat or isInSupport)
end

function TowerComposeHeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)
	local isInLockPlane = TowerComposeHeroGroupModel.instance:checkHeroUidIsInLockPlane(self._mo.uid)

	if isInLockPlane then
		GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)

		return
	end

	if self._mo:isTrial() and not TowerComposeHeroGroupModel.instance:checkCanSelectTrialHero(self._mo.trialCo, self._view.viewContainer.viewParam.singleGroupMOId) then
		TowerComposeController.instance:showPlaneTrialLimitToast(Mathf.Ceil(self._view.viewContainer.viewParam.singleGroupMOId / 4))

		return
	end

	if self._mo.isPosLock or not singleGroupMO:isEmpty() and singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if HeroGroupModel.instance:isRestrict(self._mo.uid) then
		local battleCo = HeroGroupModel.instance:getCurrentBattleConfig()
		local restrictReason = battleCo and battleCo.restrictReason

		if not string.nilorempty(restrictReason) then
			ToastController.instance:showToastWithString(restrictReason)
		end

		return
	end

	if self._isSelect and self._enableDeselect and not self._mo.isPosLock then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

return TowerComposeHeroGroupEditItem
