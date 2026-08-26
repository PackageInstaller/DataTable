-- chunkname: @modules/logic/rouge/view/RougeTeamHeroItem.lua

module("modules.logic.rouge.view.RougeTeamHeroItem", package.seeall)

local RougeTeamHeroItem = class("RougeTeamHeroItem", RougeLuaCompBase)

function RougeTeamHeroItem:init(go)
	RougeTeamHeroItem.super.init(self, go)

	self._go = go
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:hideFavor(true)
	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:setStyle_CharacterBackpack()

	self._gohp = gohelper.findChild(go, "#go_hp")
	self._sliderhp = gohelper.findChildSlider(go, "#go_hp/#slider_hp")
	self._godead = gohelper.findChild(go, "#go_dead")
	self._goassit = gohelper.findChild(go, "assit")
	self._goFrame = gohelper.findChild(go, "frame_hp")

	self:_initCapacity()
	self:_initObj(go)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnTeamViewSelectedHeroPlayEffect, self._onTeamViewSelectedHeroPlayEffect, self)
end

function RougeTeamHeroItem:_onTeamViewSelectedHeroPlayEffect(teamType)
	if not self._isSelected then
		return
	end

	if teamType == RougeEnum.TeamType.Treat then
		local go = gohelper.findChild(self._go, "Reply")

		gohelper.setActive(go, true)
		TaskDispatcher.runDelay(self._delayPlayHpEffect, self, 0.6)

		return
	end

	if teamType == RougeEnum.TeamType.Revive then
		local go = gohelper.findChild(self._go, "Resurrection")

		gohelper.setActive(go, true)
		TaskDispatcher.runDelay(self._delayPlayReviveEffect, self, 0.6)

		return
	end

	if teamType == RougeEnum.TeamType.Assignment then
		local go = gohelper.findChild(self._go, "Dispatch")

		gohelper.setActive(go, true)

		return
	end
end

function RougeTeamHeroItem:_delayPlayHpEffect()
	self._dotweenId = ZProj.TweenHelper.DOTweenFloat(self._hpValue, 1, 1, self.everyFrame, nil, self)
end

function RougeTeamHeroItem:everyFrame(value)
	self._sliderhp:SetValue(value)
end

function RougeTeamHeroItem:_delayPlayReviveEffect()
	self:_updateHp(1000)
end

function RougeTeamHeroItem:_initCapacity()
	self._gopoint = gohelper.findChild(self._go, "volume/point")

	gohelper.setActive(self._gopoint, false)

	self._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._go, RougeCapacityComp)

	self._capacityComp:setSpriteType("rouge_team_volume_3", "rouge_team_volume_3")
	self._capacityComp:setPoint(self._gopoint)
	self._capacityComp:initCapacity()
end

function RougeTeamHeroItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
end

function RougeTeamHeroItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	local lv = RougeHeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

	if lv > mo.level then
		self._heroItem:setBalanceLv(lv)
	end

	self._capacity = RougeController.instance:useHalfCapacity() and RougeConfig1.instance:getRoleHalfCapacity(mo.config.rare) or RougeConfig1.instance:getRoleCapacity(mo.config.rare)

	self._capacityComp:updateMaxNum(self._capacity)
	self:_updateStatus()
	self:_updateSelected()
	self:tickUpdateDLCs(mo)
end

function RougeTeamHeroItem:_updateStatus()
	local hpValue = RougeTeamListModel.instance:getHp(self._mo)

	self:_updateHp(hpValue)
end

function RougeTeamHeroItem:_updateHp(hpValue)
	local isDead = hpValue <= 0
	local isInTeam = RougeTeamListModel.instance:isInTeam(self._mo)
	local showAssit = RougeTeamListModel.instance:isAssit(self._mo)
	local showInTeam = isInTeam and 1 or 0

	self._heroItem:setInteam(showInTeam)
	gohelper.setActive(self._goassit, showAssit)
	gohelper.setActive(self._godead, isDead)

	self._hpValue = hpValue / 1000

	self._sliderhp:SetValue(self._hpValue)
	self._heroItem:setNewShow(false)
	self._heroItem:setDamage(isDead)

	self._heroItem._isInjury = false

	gohelper.setActive(self._heroItem._maskgray, isDead)
end

function RougeTeamHeroItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if RougeTeamListModel.instance:getTeamType() ~= RougeEnum.TeamType.View then
		RougeTeamListModel.instance:selectHero(self._mo)
		self:_updateSelected()
		RougeController.instance:dispatchEvent(RougeEvent.OnTeamViewSelectedHero)

		return
	end

	CharacterController.instance:openCharacterView(self._mo, nil, {
		isOwnHero = false,
		hideHomeBtn = true,
		fromHeroDetailView = true,
		hideTrialTip = true
	})
end

function RougeTeamHeroItem:_updateSelected()
	local isSelected = RougeTeamListModel.instance:isHeroSelected(self._mo)

	gohelper.setActive(self._goFrame, isSelected)

	self._isSelected = isSelected
end

function RougeTeamHeroItem:onDestroy()
	if self._dotweenId then
		ZProj.TweenHelper.KillById(self._dotweenId, false)

		self._dotweenId = nil
	end

	TaskDispatcher.cancelTask(self._delayPlayHpEffect, self)
	RougeTeamHeroItem.super.onDestroy(self)
end

function RougeTeamHeroItem:getAnimator()
	return self._animator
end

return RougeTeamHeroItem
