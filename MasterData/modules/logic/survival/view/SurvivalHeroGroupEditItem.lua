-- chunkname: @modules/logic/survival/view/SurvivalHeroGroupEditItem.lua

module("modules.logic.survival.view.SurvivalHeroGroupEditItem", package.seeall)

local SurvivalHeroGroupEditItem = class("SurvivalHeroGroupEditItem", HeroGroupEditItem)

function SurvivalHeroGroupEditItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:setSelectFrameSize(245, 583, 0, -12)

	self._hptextwhite = gohelper.findChildText(go, "hpbg/hptextwhite")
	self._hptextred = gohelper.findChildText(go, "hpbg/hptextred")
	self._hpimage = gohelper.findChildImage(go, "hpbg/hp")
	self._gohp = gohelper.findChild(go, "hpbg")

	self:_initObj(go)

	self._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalHeroHealthPart)
	self._goRound = gohelper.findChild(go, "#go_round")
	self._roundText = gohelper.findChildText(go, "#go_round/#txt_round")
end

function SurvivalHeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
	self._heroItem:setStyle_SurvivalHeroGroupEdit()
end

function SurvivalHeroGroupEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
end

function SurvivalHeroGroupEditItem:removeEventListeners()
	return
end

function SurvivalHeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function SurvivalHeroGroupEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function SurvivalHeroGroupEditItem:updateLimitStatus()
	gohelper.setActive(self._gohp, false)
	self._heroItem:setRestrict(false)
end

function SurvivalHeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	if not mo:isTrial() then
		local lv = SurvivalBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()

	local inteam = SurvivalHeroGroupEditListModel.instance:isInTeamHero(self._mo.uid)

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(inteam)
	self._healthPart:setHeroId(self._mo.heroId)
	self:refreshRound()
end

function SurvivalHeroGroupEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isTrial() or nil) and luaLang("herogroup_trial_tag0"))
end

function SurvivalHeroGroupEditItem:updateTrialRepeat()
	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = SurvivalHeroGroupEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function SurvivalHeroGroupEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function SurvivalHeroGroupEditItem:_onItemClick()
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

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and SurvivalHeroGroupEditListModel.instance:isTrialLimit() then
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
end

function SurvivalHeroGroupEditItem:refreshRound()
	local index = SurvivalHeroGroupEditListModel.instance:getSelectByIndex(self._mo.heroId)

	gohelper.setActive(self._goRound, index ~= nil)

	if index ~= nil then
		self._roundText.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_herogroup_round"), GameUtil.getNum2Chinese(index))
	end
end

function SurvivalHeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function SurvivalHeroGroupEditItem:onDestroy()
	return
end

function SurvivalHeroGroupEditItem:getAnimator()
	return self._animator
end

return SurvivalHeroGroupEditItem
