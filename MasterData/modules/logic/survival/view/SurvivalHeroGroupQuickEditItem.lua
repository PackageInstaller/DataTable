-- chunkname: @modules/logic/survival/view/SurvivalHeroGroupQuickEditItem.lua

module("modules.logic.survival.view.SurvivalHeroGroupQuickEditItem", package.seeall)

local SurvivalHeroGroupQuickEditItem = class("SurvivalHeroGroupQuickEditItem", SurvivalHeroGroupEditItem)

function SurvivalHeroGroupQuickEditItem:init(go)
	SurvivalHeroGroupQuickEditItem.super.init(self, go)

	self._goframe = gohelper.findChild(go, "frame")
	self._txtorder = gohelper.findChildTextMesh(go, "go_order/txt_order")
	self._goorderbg = gohelper.findChild(go, "go_order")

	self:enableDeselect(false)
	self._heroItem:setNewShow(false)
	self._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	self._heroItem:_setTxtPos("_nameEnTxt", 0.55, 36.1)
	self._heroItem:_setTxtPos("_lvObj", 1.7, 96.8)
	self._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	self._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	self._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	self._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	self._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
	self._heroItem:setStyle_SurvivalHeroGroupEdit()
	gohelper.setActive(self._goorderbg, false)
	gohelper.setActive(self._goframe, false)
end

function SurvivalHeroGroupQuickEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)

	if not mo:isTrial() then
		local lv = SurvivalBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()
	self._heroItem:setRepeatAnimFinish()

	local index = SurvivalHeroGroupQuickEditListModel.instance:getHeroTeamPos(self._mo.uid)

	self._team_pos_index = index

	if index ~= 0 then
		if not self._open_ani_finish then
			TaskDispatcher.runDelay(self._show_goorderbg, self, 0.3)
		else
			self:_show_goorderbg()
		end
	else
		gohelper.setActive(self._goorderbg, false)
		gohelper.setActive(self._goframe, false)
	end

	self._open_ani_finish = true

	self._healthPart:setHeroId(self._mo.heroId)
	self:refreshRound()
end

function SurvivalHeroGroupQuickEditItem:updateTrialRepeat(mo)
	if mo and (mo.heroId ~= self._mo.heroId or mo == self._mo) then
		return
	end

	local isRepeat = SurvivalHeroGroupQuickEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function SurvivalHeroGroupQuickEditItem:_show_goorderbg()
	gohelper.setActive(self._goorderbg, true)
	gohelper.setActive(self._goframe, true)

	self._txtorder.text = self._team_pos_index
end

function SurvivalHeroGroupQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local index = SurvivalHeroGroupEditListModel.instance:getSelectByIndex(self._mo.heroId)

	if index ~= nil then
		GameFacade.showToast(ToastEnum.SurvivalOtherRoundSelect)

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

	if self._mo:isTrial() and not SurvivalHeroGroupQuickEditListModel.instance:inInTeam(self._mo.uid) and SurvivalHeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo and not self._mo.isPosLock then
		local result = SurvivalHeroGroupQuickEditListModel.instance:selectHero(self._mo.uid)

		if not result then
			return
		end
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if self._mo and weekInfo:getHeroMo(self._mo.heroId).health == 0 then
		GameFacade.showToast(ToastEnum.SurvivalHeroDead)

		return
	end

	if self._isSelect and self._enableDeselect and not self._mo.isPosLock then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, self._mo)
end

function SurvivalHeroGroupQuickEditItem:onSelect(select)
	self._isSelect = select

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function SurvivalHeroGroupQuickEditItem:onDestroy()
	TaskDispatcher.cancelTask(self._show_goorderbg, self)
	SurvivalHeroGroupQuickEditItem.super.onDestroy(self)
end

return SurvivalHeroGroupQuickEditItem
