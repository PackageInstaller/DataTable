-- chunkname: @modules/logic/rouge/view/RougeHeroGroupQuickEditItem.lua

module("modules.logic.rouge.view.RougeHeroGroupQuickEditItem", package.seeall)

local RougeHeroGroupQuickEditItem = class("RougeHeroGroupQuickEditItem", RougeHeroGroupEditItem)

function RougeHeroGroupQuickEditItem:init(go)
	RougeHeroGroupQuickEditItem.super.init(self, go)

	self._goframe = gohelper.findChild(go, "frame")
	self._goframehp = gohelper.findChild(go, "frame_hp")
	self._imageorder = gohelper.findChildImage(go, "#go_orderbg/#image_order")
	self._goorderbg = gohelper.findChild(go, "#go_orderbg")

	self:enableDeselect(false)
	self._heroItem:setNewShow(false)
	gohelper.setActive(self._goorderbg, false)
	gohelper.setActive(self._goframe, false)
end

function RougeHeroGroupQuickEditItem:onUpdateMO(mo)
	self._edityType = RougeHeroGroupEditListModel.instance:getHeroGroupEditType()
	self._isSelectHeroType = self._edityType == RougeEnum.HeroGroupEditType.SelectHero
	self._isInitType = self._edityType == RougeEnum.HeroGroupEditType.Init
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)
	self:_updateCapacity(mo)
	self:_updateHp()

	if not mo:isTrial() then
		local lv = RougeHeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateTrialTag()
	self:updateTrialRepeat()
	self._heroItem:setRepeatAnimFinish()

	local index = RougeHeroGroupQuickEditListModel.instance:getHeroTeamPos(self._mo.uid)

	if self._edityType == RougeEnum.HeroGroupEditType.FightAssit then
		local assitPosIndex = RougeHeroGroupQuickEditListModel.instance:getAssitPosIndex(self._mo.uid)
		local inAssit = index == 0 and assitPosIndex

		if inAssit then
			local mainPosIndex = assitPosIndex - RougeEnum.FightTeamNormalHeroNum
			local mainHeroUid = RougeHeroGroupQuickEditListModel.instance:getHeroUidByPos(mainPosIndex)

			inAssit = mainHeroUid ~= "0"
		end

		gohelper.setActive(self._goassit, inAssit)
	else
		gohelper.setActive(self._goassit, false)
	end

	self._team_pos_index = index

	if index ~= 0 then
		if not self._open_ani_finish then
			TaskDispatcher.runDelay(self._show_goorderbg, self, 0.3)
		else
			self:_show_goorderbg()
		end
	else
		gohelper.setActive(self._goorderbg, false)
		gohelper.setActive(self._goframehp, false)
		gohelper.setActive(self._goframe, false)
	end

	self._open_ani_finish = true

	self:tickUpdateDLCs(mo)
end

function RougeHeroGroupQuickEditItem:updateTrialRepeat(mo)
	if mo and (mo.heroId ~= self._mo.heroId or mo == self._mo) then
		return
	end

	local isRepeat = RougeHeroGroupQuickEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function RougeHeroGroupQuickEditItem:_show_goorderbg()
	local isHideHp = self:_isHideHp()

	gohelper.setActive(self._goorderbg, true)
	gohelper.setActive(self._goframehp, not isHideHp)
	gohelper.setActive(self._goframe, isHideHp)

	local showOrder = not self._isSelectHeroType and not self._isInitType

	gohelper.setActive(self._goorderbg, showOrder)

	if not showOrder then
		return
	end

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageorder, "biandui_shuzi_" .. self._team_pos_index)
end

function RougeHeroGroupQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if self._mo and self._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._mo and RougeHeroSingleGroupModel.instance:isAidConflict(self._mo.heroId) then
		GameFacade.showToast(ToastEnum.HeroIsAidConflict)

		return
	end

	local teamInfo = RougeModel.instance:getTeamInfo()
	local hpInfo = teamInfo:getHeroHp(self._mo.heroId)

	if hpInfo and hpInfo.life <= 0 then
		GameFacade.showToast(ToastEnum.V1a6CachotToast04)

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

	if self._mo:isTrial() and not RougeHeroGroupQuickEditListModel.instance:inInTeam(self._mo.uid) and RougeHeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo and not self._mo.isPosLock then
		local result = RougeHeroGroupQuickEditListModel.instance:selectHero(self._mo.uid)

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

function RougeHeroGroupQuickEditItem:onSelect(select)
	self._isSelect = select

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function RougeHeroGroupQuickEditItem:onDestroy()
	TaskDispatcher.cancelTask(self._show_goorderbg, self)
	RougeHeroGroupQuickEditItem.super.onDestroy(self)
end

return RougeHeroGroupQuickEditItem
