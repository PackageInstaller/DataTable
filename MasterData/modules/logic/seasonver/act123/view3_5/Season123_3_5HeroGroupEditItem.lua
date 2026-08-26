-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5HeroGroupEditItem.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5HeroGroupEditItem", package.seeall)

local Season123_3_5HeroGroupEditItem = class("Season123_3_5HeroGroupEditItem", ListScrollCell)

function Season123_3_5HeroGroupEditItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)

	self._gohp = gohelper.findChild(go, "#go_hp")
	self._sliderhp = gohelper.findChildSlider(go, "#go_hp/#slider_hp")
	self._imagehp = gohelper.findChildImage(go, "#go_hp/#slider_hp/Fill Area/Fill")
	self._godead = gohelper.findChild(go, "#go_dead")

	self:_initObj(go)
end

function Season123_3_5HeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
end

function Season123_3_5HeroGroupEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
end

function Season123_3_5HeroGroupEditItem:removeEventListeners()
	return
end

function Season123_3_5HeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function Season123_3_5HeroGroupEditItem:_onAttributeChanged(level, heroId)
	self._heroItem:setLevel(level, heroId)
end

function Season123_3_5HeroGroupEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function Season123_3_5HeroGroupEditItem:updateLimitStatus()
	if HeroGroupModel.instance:isRestrict(self._mo.uid) then
		self._heroItem:setRestrict(true)
	else
		self._heroItem:setRestrict(false)
	end
end

function Season123_3_5HeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self:updateLimitStatus()

	local inteam = Season123HeroGroupEditModel.instance:isInTeamHero(self._mo.uid)

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(inteam)
	self:refreshHp()
	self:refreshDead()
	self:updateTrialTag()
	self:updateTrialRepeat()
end

function Season123_3_5HeroGroupEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isTrial() or nil) and luaLang("herogroup_trial_tag0"))
end

function Season123_3_5HeroGroupEditItem:updateTrialRepeat()
	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = Season123HeroGroupEditModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function Season123_3_5HeroGroupEditItem:refreshHp()
	gohelper.setActive(self._gohp, false)
	gohelper.setActive(self._godead, false)
end

function Season123_3_5HeroGroupEditItem:refreshDead()
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local isDead = false
		local actId = Season123HeroGroupEditModel.instance.activityId
		local stage = Season123HeroGroupEditModel.instance.stage
		local layer = Season123HeroGroupEditModel.instance.layer
		local seasonHeroMO = Season123Model.instance:getSeasonHeroMO(actId, stage, layer, self._mo.uid)

		if seasonHeroMO ~= nil then
			isDead = seasonHeroMO.hpRate <= 0
		end

		self._heroItem:setDamage(isDead)
		gohelper.setActive(self._heroItem._maskgray, isDead)
	end
end

function Season123_3_5HeroGroupEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function Season123_3_5HeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and Season123HeroGroupEditModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo.isPosLock or not singleGroupMO:isEmpty() and singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self:checkRestrict(self._mo.uid) then
		return
	end

	if self._isSelect and self._enableDeselect and not self._mo.isPosLock then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

function Season123_3_5HeroGroupEditItem:checkRestrict(heroUid)
	if HeroGroupModel.instance:isRestrict(heroUid) then
		local battleCo = HeroGroupModel.instance:getCurrentBattleConfig()
		local restrictReason = battleCo and battleCo.restrictReason

		if not string.nilorempty(restrictReason) then
			ToastController.instance:showToastWithString(restrictReason)
		end

		return true
	end

	return false
end

function Season123_3_5HeroGroupEditItem:checkHpZero(heroUid)
	local actId = Season123HeroGroupEditModel.instance.activityId
	local stage = Season123HeroGroupEditModel.instance.stage
	local layer = Season123HeroGroupEditModel.instance.layer
	local seasonHeroMO = Season123Model.instance:getSeasonHeroMO(actId, stage, layer, heroUid)

	if seasonHeroMO == nil then
		return
	end

	if seasonHeroMO.hpRate <= 0 then
		return true
	end

	return false
end

function Season123_3_5HeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function Season123_3_5HeroGroupEditItem:setHp(hpRate)
	local hp100Per = math.floor(hpRate / 10)
	local rate = Mathf.Clamp(hp100Per / 100, 0, 1)

	self._sliderhp:SetValue(rate)
	Season123HeroGroupUtils.setHpBar(self._imagehp, rate)
	gohelper.setActive(self._godead, rate <= 0)
end

function Season123_3_5HeroGroupEditItem:onDestroy()
	return
end

function Season123_3_5HeroGroupEditItem:getAnimator()
	return self._animator
end

return Season123_3_5HeroGroupEditItem
