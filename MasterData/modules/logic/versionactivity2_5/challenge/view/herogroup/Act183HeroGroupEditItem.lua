-- chunkname: @modules/logic/versionactivity2_5/challenge/view/herogroup/Act183HeroGroupEditItem.lua

module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupEditItem", package.seeall)

local Act183HeroGroupEditItem = class("Act183HeroGroupEditItem", ListScrollCell)

function Act183HeroGroupEditItem:init(go)
	self._gorepress = gohelper.findChild(go, "go_repress")
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)
	self:_initObj(go)
end

function Act183HeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
end

function Act183HeroGroupEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
end

function Act183HeroGroupEditItem:removeEventListeners()
	return
end

function Act183HeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function Act183HeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	if not mo:isTrial() then
		local lv = HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateTrialTag()
	self:updateTrialRepeat()

	local inteam = Act183HeroGroupEditListModel.instance:isInTeamHero(self._mo.uid)

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(inteam)

	local episodeId = HeroGroupModel.instance.episodeId

	self._isRepress = Act183Model.instance:isHeroRepressInPreEpisode(episodeId, self._mo.heroId)

	gohelper.setActive(self._gorepress, self._isRepress)
	self._heroItem._commonHeroCard:setGrayScale(self._isRepress)
end

function Act183HeroGroupEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isTrial() or nil) and luaLang("herogroup_trial_tag0"))
end

function Act183HeroGroupEditItem:updateTrialRepeat()
	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = Act183HeroGroupEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function Act183HeroGroupEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function Act183HeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if self._isRepress then
		GameFacade.showToast(ToastEnum.Act183HeroRepress)

		return
	end

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and Act183HeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

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

function Act183HeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function Act183HeroGroupEditItem:onDestroy()
	return
end

function Act183HeroGroupEditItem:getAnimator()
	return self._animator
end

return Act183HeroGroupEditItem
