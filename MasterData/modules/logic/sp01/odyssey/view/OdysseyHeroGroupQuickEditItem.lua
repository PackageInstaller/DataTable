-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroGroupQuickEditItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupQuickEditItem", package.seeall)

local OdysseyHeroGroupQuickEditItem = class("OdysseyHeroGroupQuickEditItem", HeroGroupQuickEditItem)

function OdysseyHeroGroupQuickEditItem:_onItemClick()
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

	if self._mo:isTrial() and not HeroGroupQuickEditListModel.instance:inInTeam(self._mo.uid) and HeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	local mainHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local odysseyTrialId = tonumber(mainHeroConstCo.value)
	local odysseyTrialCo = lua_hero_trial.configDict[odysseyTrialId][0]

	if self._mo.heroId == odysseyTrialCo.heroId then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._mo and not self._mo.isPosLock then
		local result = HeroGroupQuickEditListModel.instance:selectHero(self._mo.uid)

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

return OdysseyHeroGroupQuickEditItem
