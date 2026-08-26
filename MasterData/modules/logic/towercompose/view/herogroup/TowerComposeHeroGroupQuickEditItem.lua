-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupQuickEditItem.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupQuickEditItem", package.seeall)

local TowerComposeHeroGroupQuickEditItem = class("TowerComposeHeroGroupQuickEditItem", HeroGroupQuickEditItem)

function TowerComposeHeroGroupQuickEditItem:init(go)
	TowerComposeHeroGroupQuickEditItem.super.init(self, go)

	self._txtorder = gohelper.findChildText(go, "#go_orderbg/#txt_order")
	self._goaddNum = gohelper.findChild(go, "#go_addnum")
	self._txtNum = gohelper.findChildText(go, "#go_addnum/#txt_num")
	self._goplaneLock = gohelper.findChild(go, "#go_planeLock")
end

function TowerComposeHeroGroupQuickEditItem:updateTrialTag()
	TowerComposeHeroGroupQuickEditItem.super.updateTrialTag(self)

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

function TowerComposeHeroGroupQuickEditItem:updateTrialRepeat(mo)
	if mo and (mo.heroId ~= self._mo.heroId or mo == self._mo) then
		return
	end

	local isRepeat = HeroGroupQuickEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)
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

function TowerComposeHeroGroupQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if self._mo and self._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._mo and HeroSingleGroupModel.instance:isAidConflict(self._mo.heroId) then
		GameFacade.showToast(ToastEnum.HeroIsAidConflict)

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

	local isInLockPlane = TowerComposeHeroGroupModel.instance:checkHeroUidIsInLockPlane(self._mo.uid)

	if isInLockPlane then
		GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)

		return
	end

	if self._mo:isTrial() and not HeroGroupQuickEditListModel.instance:inInTeam(self._mo.uid) then
		local insetIndex = TowerComposeHeroGroupModel.instance:getQuickSelectOrder()

		if insetIndex and not TowerComposeHeroGroupModel.instance:checkCanSelectTrialHero(self._mo.trialCo, insetIndex, true) then
			TowerComposeController.instance:showPlaneTrialLimitToast(Mathf.Ceil(insetIndex / 4))

			return
		end
	end

	if self._mo and not self._mo.isPosLock then
		local result = HeroGroupQuickEditListModel.instance:towerComposeSelectHero(self._mo.uid)

		if not result then
			return
		end
	end

	if self._isSelect and self._enableDeselect and not self._mo.isPosLock then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, self._mo)
end

function TowerComposeHeroGroupQuickEditItem:_show_goorderbg()
	local isInLockPlane = TowerComposeHeroGroupModel.instance:checkHeroUidIsInLockPlane(self._mo.uid)

	if isInLockPlane then
		gohelper.setActive(self._goorderbg, false)
		gohelper.setActive(self._goframe, false)

		return
	end

	gohelper.setActive(self._goorderbg, true)
	gohelper.setActive(self._goframe, true)

	self._txtorder.text = self._team_pos_index
end

return TowerComposeHeroGroupQuickEditItem
