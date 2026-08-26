-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetQuickEditItem.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetQuickEditItem", package.seeall)

local HeroGroupPresetQuickEditItem = class("HeroGroupPresetQuickEditItem", HeroGroupEditItem)

function HeroGroupPresetQuickEditItem:init(go)
	HeroGroupPresetQuickEditItem.super.init(self, go)

	self._goframe = gohelper.findChild(go, "frame")
	self._imageorder = gohelper.findChildImage(go, "#go_orderbg/#image_order")
	self._goorderbg = gohelper.findChild(go, "#go_orderbg")

	self:enableDeselect(false)
	self._heroItem:setNewShow(false)
	gohelper.setActive(self._goorderbg, false)
	gohelper.setActive(self._goframe, false)
end

function HeroGroupPresetQuickEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)

	if not mo:isTrial() then
		local lv = HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()
	self._heroItem:setRepeatAnimFinish()

	local index = HeroGroupPresetQuickEditListModel.instance:getHeroTeamPos(self._mo.uid)

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

function HeroGroupPresetQuickEditItem:updateTrialRepeat(mo)
	if mo and (mo.heroId ~= self._mo.heroId or mo == self._mo) then
		return
	end

	local isRepeat = HeroGroupPresetQuickEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function HeroGroupPresetQuickEditItem:_show_goorderbg()
	gohelper.setActive(self._goorderbg, true)
	gohelper.setActive(self._goframe, true)
	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageorder, "biandui_shuzi_" .. self._team_pos_index)
end

function HeroGroupPresetQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if self._mo and self._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._mo and HeroGroupPresetSingleGroupModel.instance:isAidConflict(self._mo.heroId) then
		GameFacade.showToast(ToastEnum.HeroIsAidConflict)

		return
	end

	if HeroGroupPresetModel.instance:isRestrict(self._mo.uid) then
		local battleCo = HeroGroupPresetModel.instance:getCurrentBattleConfig()
		local restrictReason = battleCo and battleCo.restrictReason

		if not string.nilorempty(restrictReason) then
			ToastController.instance:showToastWithString(restrictReason)
		end

		return
	end

	if self._mo:isTrial() and not HeroGroupPresetQuickEditListModel.instance:inInTeam(self._mo.uid) and HeroGroupPresetQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo and not self._mo.isPosLock then
		local result = HeroGroupPresetQuickEditListModel.instance:selectHero(self._mo.uid)

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

function HeroGroupPresetQuickEditItem:onSelect(select)
	self._isSelect = select

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function HeroGroupPresetQuickEditItem:onDestroy()
	TaskDispatcher.cancelTask(self._show_goorderbg, self)
	HeroGroupPresetQuickEditItem.super.onDestroy(self)
end

return HeroGroupPresetQuickEditItem
