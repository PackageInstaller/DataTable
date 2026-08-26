-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupQuickEditItem.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupQuickEditItem", package.seeall)

local Season166HeroGroupQuickEditItem = class("Season166HeroGroupQuickEditItem", Season166HeroGroupEditItem)

function Season166HeroGroupQuickEditItem:init(go)
	Season166HeroGroupQuickEditItem.super.init(self, go)

	self._txtorder = gohelper.findChildText(go, "#go_orderbg/#txt_order")
	self._goorderbg = gohelper.findChild(go, "#go_orderbg")

	self:enableDeselect(false)
	self._heroItem:setNewShow(false)
	gohelper.setActive(self._goorderbg, false)

	self._itemAnim.speed = 1
end

function Season166HeroGroupQuickEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)

	if not mo:isTrial() then
		local lv = HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateTrialTag()
	self:updateTrialRepeat()

	local index = Season166HeroGroupQuickEditModel.instance:getHeroTeamPos(self._mo.uid)

	self._team_pos_index = index

	if index ~= 0 then
		if not self._open_ani_finish then
			TaskDispatcher.runDelay(self._show_goorderbg, self, 0.3)
		else
			self:_show_goorderbg()
		end
	else
		gohelper.setActive(self._goorderbg, false)
	end

	self._open_ani_finish = true

	self:refreshSelectState()
end

function Season166HeroGroupQuickEditItem:_show_goorderbg()
	gohelper.setActive(self._goorderbg, true)

	self._txtorder.text = self._team_pos_index
end

function Season166HeroGroupQuickEditItem:updateTrialRepeat(mo)
	if mo and (mo.heroId ~= self._mo.heroId or mo == self._mo) then
		return
	end

	self.isRepeat = Season166HeroGroupQuickEditModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(self.isRepeat)
end

function Season166HeroGroupQuickEditItem:refreshSelectState()
	gohelper.setActive(self._goMainSelect, false)
	gohelper.setActive(self._goHelpSelect, false)
end

function Season166HeroGroupQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if self._mo and self._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._mo:isTrial() and not Season166HeroGroupQuickEditModel.instance:isInTeamHero(self._mo.uid) and Season166HeroGroupQuickEditModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo then
		local result = Season166HeroGroupQuickEditModel.instance:selectHero(self._mo.uid)

		if not result then
			return
		end
	end

	if self._isSelect and self._enableDeselect then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

function Season166HeroGroupQuickEditItem:onSelect(select)
	self._isSelect = select

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function Season166HeroGroupQuickEditItem:onDestroy()
	TaskDispatcher.cancelTask(self._show_goorderbg, self)
	Season166HeroGroupQuickEditItem.super.onDestroy(self)
end

return Season166HeroGroupQuickEditItem
