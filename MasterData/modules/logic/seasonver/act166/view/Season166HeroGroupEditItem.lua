-- chunkname: @modules/logic/seasonver/act166/view/Season166HeroGroupEditItem.lua

module("modules.logic.seasonver.act166.view.Season166HeroGroupEditItem", package.seeall)

local Season166HeroGroupEditItem = class("Season166HeroGroupEditItem", ListScrollCell)

function Season166HeroGroupEditItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)

	self._goSelectState = gohelper.findChild(go, "selectState")
	self._goCurSelect = gohelper.findChild(go, "selectState/go_currentSelect")
	self._goMainSelect = gohelper.findChild(go, "selectState/go_mainSelect")
	self._goHelpSelect = gohelper.findChild(go, "selectState/go_helpSelect")

	self:_initObj(go)
end

function Season166HeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._itemAnim = go:GetComponent(typeof(UnityEngine.Animator))
	self._itemAnim.keepAnimatorStateOnDisable = true
	self._itemAnim.speed = 0
	self._isFirstEnter = true
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
end

Season166HeroGroupEditItem.CurSelectItem = 2
Season166HeroGroupEditItem.OtherSelectItem = 1

function Season166HeroGroupEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
end

function Season166HeroGroupEditItem:removeEventListeners()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
end

function Season166HeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function Season166HeroGroupEditItem:_onAttributeChanged(level, heroId)
	self._heroItem:setLevel(level, heroId)
end

function Season166HeroGroupEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function Season166HeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	if self._isFirstEnter then
		self._isFirstEnter = false

		local index = Season166HeroGroupEditModel.instance:getIndex(self._mo)

		TaskDispatcher.runDelay(self.playEnterAnim, self, math.ceil((index - 1) % 5) * 0.001)
	end

	if not mo:isTrial() then
		local lv = HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	local inteam = Season166HeroGroupEditModel.instance:isInTeamHero(self._mo.uid)

	self._heroItem:setNewShow(false)
	self:refreshSelectState(inteam)
	self:updateTrialTag()
	self:updateTrialRepeat()
end

function Season166HeroGroupEditItem:playEnterAnim()
	self._itemAnim.speed = 1

	TaskDispatcher.cancelTask(self.playEnterAnim, self)
end

function Season166HeroGroupEditItem:checkIsAssist()
	local assistMO = Season166HeroSingleGroupModel.instance.assistMO

	return assistMO and self._mo.uid == assistMO.heroUid
end

function Season166HeroGroupEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isTrial() or nil) and luaLang("herogroup_trial_tag0"))
end

function Season166HeroGroupEditItem:updateTrialRepeat()
	local assistMO = Season166HeroSingleGroupModel.instance.assistMO
	local singleGroupMO = Season166HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if assistMO and singleGroupMO and singleGroupMO.heroUid == assistMO.heroUid then
		return
	end

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = Season166HeroGroupEditModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function Season166HeroGroupEditItem:refreshSelectState(inteam)
	gohelper.setActive(self._goCurSelect, inteam == Season166HeroGroupEditItem.CurSelectItem)

	local isMainHero, posIndex = Season166HeroSingleGroupModel.instance:checkIsMainHero(self._mo.uid)

	gohelper.setActive(self._goMainSelect, isMainHero and inteam == Season166HeroGroupEditItem.OtherSelectItem)
	gohelper.setActive(self._goHelpSelect, not isMainHero and posIndex ~= 0 and inteam == Season166HeroGroupEditItem.OtherSelectItem)
end

function Season166HeroGroupEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function Season166HeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local singleGroupMO = Season166HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not Season166HeroSingleGroupModel.instance:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and Season166HeroGroupEditModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo.isPosLock or not singleGroupMO:isEmpty() and singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._isSelect and self._enableDeselect then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

function Season166HeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function Season166HeroGroupEditItem:onDestroy()
	TaskDispatcher.cancelTask(self.playEnterAnim, self)
end

function Season166HeroGroupEditItem:getAnimator()
	return self._animator
end

return Season166HeroGroupEditItem
