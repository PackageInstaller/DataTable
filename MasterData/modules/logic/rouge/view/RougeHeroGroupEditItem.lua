-- chunkname: @modules/logic/rouge/view/RougeHeroGroupEditItem.lua

module("modules.logic.rouge.view.RougeHeroGroupEditItem", package.seeall)

local RougeHeroGroupEditItem = class("RougeHeroGroupEditItem", RougeLuaCompBase)

function RougeHeroGroupEditItem:init(go)
	RougeHeroGroupEditItem.super.init(self, go)

	self._go = go
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)

	self._gohp = gohelper.findChild(go, "#go_hp")

	gohelper.setActive(self._gohp, false)

	self._goassit = gohelper.findChild(go, "assit")
	self._sliderhp = gohelper.findChildSlider(go, "#go_hp/#slider_hp")
	self._godead = gohelper.findChild(go, "#go_dead")
	self._goframehp = gohelper.findChild(go, "frame_hp")
	self._itemAnimator = gohelper.onceAddComponent(go, gohelper.Type_Animator)

	self:_initCapacity()
	self:_initObj(go)
end

function RougeHeroGroupEditItem:_initCapacity()
	self._gopoint = gohelper.findChild(self._go, "volume/point")

	gohelper.setActive(self._gopoint, false)

	self._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._go, RougeCapacityComp)

	self._capacityComp:setSpriteType("rouge_team_volume_3", "rouge_team_volume_3")
	self._capacityComp:setPoint(self._gopoint)
	self._capacityComp:initCapacity()
end

function RougeHeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)

	self._heroGroupEditListModel = RougeHeroGroupEditListModel.instance
	self._heroGroupQuickEditListModel = HeroGroupQuickEditListModel.instance
	self._heroSingleGroupModel = RougeHeroSingleGroupModel.instance
	self._heroGroupModel = RougeHeroGroupModel.instance
end

function RougeHeroGroupEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnSwitchHeroGroupEditMode, self._onSwitchHeroGroupEditMode, self)
end

function RougeHeroGroupEditItem:removeEventListeners()
	return
end

function RougeHeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function RougeHeroGroupEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function RougeHeroGroupEditItem:updateLimitStatus()
	if self._heroGroupQuickEditListModel.adventure then
		gohelper.setActive(self._gohp, false)

		local cd = WeekWalkModel.instance:getCurMapHeroCd(self._mo.config.id)

		self._heroItem:setInjury(cd > 0)
	else
		gohelper.setActive(self._gohp, false)

		if self._heroGroupModel:isRestrict(self._mo.uid) then
			self._heroItem:setRestrict(true)
		else
			self._heroItem:setRestrict(false)
		end
	end
end

function RougeHeroGroupEditItem:_updateCapacity(mo)
	self._capacity = RougeConfig1.instance:getRoleCapacity(mo.config.rare)

	if self._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.FightAssit and RougeController.instance:useHalfCapacity() then
		local halfCapacity = RougeConfig1.instance:getRoleHalfCapacity(mo.config.rare)

		self._capacityComp:updateMaxNumAndOpaqueNum(self._capacity, halfCapacity)

		self._capacity = halfCapacity

		return
	end

	self._capacityComp:updateMaxNumAndOpaqueNum(self._capacity, self._capacity)
end

function RougeHeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self:_updateCapacity(mo)

	if not mo:isTrial() then
		local lv = RougeHeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateTrialTag()
	self:updateTrialRepeat()

	local inteam = self._heroGroupEditListModel:isInTeamHero(self._mo.uid)
	local teamPosIndex = self._heroGroupEditListModel:getTeamPosIndex(self._mo.uid)
	local heroGroupEditType = self._heroGroupEditListModel:getHeroGroupEditType()

	if heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit or heroGroupEditType == RougeEnum.HeroGroupEditType.Fight then
		local inAssit = inteam == 1 and teamPosIndex and teamPosIndex > RougeEnum.FightTeamNormalHeroNum

		gohelper.setActive(self._goassit, inAssit)

		if inAssit then
			inteam = nil
		end
	else
		gohelper.setActive(self._goassit, false)
	end

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(inteam)
	self:_updateHp()
	self:tickUpdateDLCs(mo)
end

function RougeHeroGroupEditItem:_isHideHp()
	if self._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.Init or self._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.SelectHero then
		return true
	end
end

function RougeHeroGroupEditItem:_updateHp()
	if self:_isHideHp() then
		return
	end

	local teamInfo = RougeModel.instance:getTeamInfo()
	local hpInfo = teamInfo:getHeroHp(self._mo.heroId)

	if not hpInfo then
		return
	end

	if hpInfo then
		if not hpInfo.life then
			local hpValue = 0

			gohelper.setActive(self._gohp, true)
			self._sliderhp:SetValue(hpValue / 1000)

			local isDead = hpValue <= 0

			gohelper.setActive(self._godead, isDead)
			self._heroItem:setDamage(isDead)

			self._heroItem._isInjury = false
			self._isDead = isDead
		end
	end
end

function RougeHeroGroupEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isTrial() or nil) and luaLang("herogroup_trial_tag0"))
end

function RougeHeroGroupEditItem:updateTrialRepeat()
	local singleGroupMO = self._heroSingleGroupModel:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = self._heroGroupEditListModel:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function RougeHeroGroupEditItem:onSelect(select)
	self._isSelect = select

	local isHideHp = self:_isHideHp()

	self._heroItem:setSelect(select and isHideHp)
	gohelper.setActive(self._goframehp, select and not isHideHp)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function RougeHeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._isDead then
		GameFacade.showToast(ToastEnum.V1a6CachotToast04)

		return
	end

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if not self._heroGroupEditListModel:canAddCapacity(self._view.viewContainer.viewParam.singleGroupMOId, self._mo) then
		GameFacade.showToast(ToastEnum.RougeTeamCapacityFull)

		return
	end

	local singleGroupMO = self._heroSingleGroupModel:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not self._heroSingleGroupModel:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and self._heroGroupEditListModel:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo.isPosLock or not singleGroupMO:isEmpty() and singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._heroGroupModel:isRestrict(self._mo.uid) then
		local battleCo = self._heroGroupModel:getCurrentBattleConfig()
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

function RougeHeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function RougeHeroGroupEditItem:_onSwitchHeroGroupEditMode()
	self._itemAnimator:Play("rougeherogroupedititem_open", 0, 0)
	self._animator:Play("open", 0, 0)
end

function RougeHeroGroupEditItem:onDestroy()
	RougeHeroGroupEditItem.super.onDestroy(self)
end

function RougeHeroGroupEditItem:getAnimator()
	return self._animator
end

return RougeHeroGroupEditItem
