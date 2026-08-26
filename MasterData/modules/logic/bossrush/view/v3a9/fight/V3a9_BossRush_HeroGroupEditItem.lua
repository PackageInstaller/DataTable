-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupEditItem.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupEditItem", package.seeall)

local V3a9_BossRush_HeroGroupEditItem = class("V3a9_BossRush_HeroGroupEditItem", ListScrollCell)

function V3a9_BossRush_HeroGroupEditItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)

	self._hptextwhite = gohelper.findChildText(go, "hpbg/hptextwhite")
	self._hptextred = gohelper.findChildText(go, "hpbg/hptextred")
	self._hpimage = gohelper.findChildImage(go, "hpbg/hp")
	self._gohp = gohelper.findChild(go, "hpbg")
	self._gobonds = gohelper.findChild(go, "bonds")

	self:_initObj(go)
end

function V3a9_BossRush_HeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
	self._heroItem:setStyle_HeroGroupEdit()
	gohelper.setActive(self._gobonds, true)

	self._bondsItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobonds, V3a9_BossRush_HeroExpandBondsItem)
end

function V3a9_BossRush_HeroGroupEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUseStoneReply, self._onRefreshDestiny, self)
end

function V3a9_BossRush_HeroGroupEditItem:removeEventListeners()
	return
end

function V3a9_BossRush_HeroGroupEditItem:_onRefreshDestiny()
	self._bondsItem:onUpdateMO(self._mo.heroId)
end

function V3a9_BossRush_HeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function V3a9_BossRush_HeroGroupEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function V3a9_BossRush_HeroGroupEditItem:updateLimitStatus()
	gohelper.setActive(self._gohp, false)

	local pos = self:getHeroPos()
	local isRestrict = V3a9_BossRushModel.instance:isRestrict(self._mo.heroId, pos)

	self._heroItem:setRestrict(isRestrict)
	self._heroItem:setDamage(isRestrict)
end

function V3a9_BossRush_HeroGroupEditItem:getHeroPos()
	return V3a9_BossRush_HeroGroupEditListModel.instance:getSelectPos()
end

function V3a9_BossRush_HeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	if not mo:isTrial() then
		local lv = HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self._bondsItem:onUpdateMO(mo.heroId)
	self:updateTrialTag()
	self:updateTrialRepeat()

	local inteam = V3a9_BossRush_HeroGroupEditListModel.instance:isInTeamHero(self._mo.uid)

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(inteam)
end

function V3a9_BossRush_HeroGroupEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isOtherPlayerHero() or nil) and luaLang("herogroup_trial_tag0"))
end

function V3a9_BossRush_HeroGroupEditItem:updateTrialRepeat()
	local isRepeat = V3a9_BossRush_HeroGroupEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function V3a9_BossRush_HeroGroupEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select and self._mo then
		if not self._mo.uid then
			local uid = "0"

			if uid ~= "0" then
				local list = V3a9_BossRush_HeroGroupEditListModel.instance:getReplaceHeroList(uid)

				V3a9_BossRushModel.instance:setEditorHeroList(list)
			end

			if select then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
			end
		end
	end
end

function V3a9_BossRush_HeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local isRestrict = self._heroItem:isRestrict()

	if isRestrict then
		return
	end

	if self._isSelect and self._enableDeselect and not self._mo.isPosLock then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	else
		self._view:selectCell(self._index, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, self._mo)
end

function V3a9_BossRush_HeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function V3a9_BossRush_HeroGroupEditItem:onDestroy()
	return
end

function V3a9_BossRush_HeroGroupEditItem:getAnimator()
	return self._animator
end

return V3a9_BossRush_HeroGroupEditItem
