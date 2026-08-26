-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroGroupEditItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupEditItem", package.seeall)

local OdysseyHeroGroupEditItem = class("OdysseyHeroGroupEditItem", HeroGroupEditItem)

function OdysseyHeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and HeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo.isPosLock or not singleGroupMO:isEmpty() and singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	local heroId = self._mo.heroId

	if singleGroupMO.trial and singleGroupMO.trial ~= 0 then
		local trialCo = lua_hero_trial.configDict[singleGroupMO.trial][singleGroupMO.trialTemplate]

		if trialCo == nil then
			logError("奥德赛下半活动 不存在的试用角色id：" .. singleGroupMO.trial)

			return
		end

		if self._isSelect and heroId == trialCo.heroId then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		elseif self._isSelect == false and heroId ~= trialCo.heroId then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end
	elseif singleGroupMO.heroUid ~= nil and singleGroupMO.heroUid ~= "0" then
		local curHeroMo = HeroModel.instance:getById(singleGroupMO.heroUid)

		if curHeroMo == nil then
			logError("奥德赛下半活动 不存在的角色 uid：" .. singleGroupMO.heroUid)

			return
		end

		local mainHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
		local odysseyTrialId = tonumber(mainHeroConstCo.value)
		local odysseyTrialCo = lua_hero_trial.configDict[odysseyTrialId][0]

		if curHeroMo.heroId == odysseyTrialCo.heroId then
			if self._isSelect and heroId == odysseyTrialCo.heroId then
				GameFacade.showToast(ToastEnum.TrialCantTakeOff)

				return
			elseif self._isSelect == false and heroId ~= odysseyTrialCo.heroId then
				GameFacade.showToast(ToastEnum.TrialCantTakeOff)

				return
			end
		end
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

return OdysseyHeroGroupEditItem
