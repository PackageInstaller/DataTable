-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupQuickEditItem.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupQuickEditItem", package.seeall)

local Rouge2_HeroGroupQuickEditItem = class("Rouge2_HeroGroupQuickEditItem", Rouge2_HeroGroupEditItem)

function Rouge2_HeroGroupQuickEditItem:init(go)
	Rouge2_HeroGroupQuickEditItem.super.init(self, go)

	self._goframe = gohelper.findChild(go, "frame")
	self._imageorder = gohelper.findChildImage(go, "#go_orderbg/#image_order")
	self._goorderbg = gohelper.findChild(go, "#go_orderbg")

	self:enableDeselect(false)
	self._heroItem:setNewShow(false)
	gohelper.setActive(self._goorderbg, false)
	gohelper.setActive(self._goframe, false)
end

function Rouge2_HeroGroupQuickEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)

	if not mo:isTrial() then
		local lv = Rouge2_HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()
	self:updateRecommendTag()
	self._heroItem:setRepeatAnimFinish()

	local index = Rouge2_HeroGroupQuickEditListModel.instance:getHeroTeamPos(self._mo.uid)

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
end

function Rouge2_HeroGroupQuickEditItem:updateTrialRepeat(mo)
	if mo and (mo.heroId ~= self._mo.heroId or mo == self._mo) then
		return
	end

	local isRepeat = Rouge2_HeroGroupQuickEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function Rouge2_HeroGroupQuickEditItem:_show_goorderbg()
	gohelper.setActive(self._goorderbg, true)
	gohelper.setActive(self._goframe, true)
	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageorder, "biandui_shuzi_" .. self._team_pos_index)
end

function Rouge2_HeroGroupQuickEditItem:_onItemClick()
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

	if self._mo:isTrial() and not Rouge2_HeroGroupQuickEditListModel.instance:inInTeam(self._mo.uid) and Rouge2_HeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo and not self._mo.isPosLock then
		local result = Rouge2_HeroGroupQuickEditListModel.instance:selectHero(self._mo.uid)

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

function Rouge2_HeroGroupQuickEditItem:onSelect(select)
	self._isSelect = select

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function Rouge2_HeroGroupQuickEditItem:onDestroy()
	TaskDispatcher.cancelTask(self._show_goorderbg, self)
	Rouge2_HeroGroupQuickEditItem.super.onDestroy(self)
end

return Rouge2_HeroGroupQuickEditItem
