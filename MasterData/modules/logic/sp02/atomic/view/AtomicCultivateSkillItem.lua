-- chunkname: @modules/logic/sp02/atomic/view/AtomicCultivateSkillItem.lua

module("modules.logic.sp02.atomic.view.AtomicCultivateSkillItem", package.seeall)

local AtomicCultivateSkillItem = class("AtomicCultivateSkillItem", LuaCompBase)

function AtomicCultivateSkillItem:init(go)
	self.go = go
	self.iconList = {}
	self.goPassive = gohelper.findChild(go, "passiveSkill")
	self.goPassiveLock = gohelper.findChild(self.goPassive, "#go_lock")
	self.goPassiveUnlock = gohelper.findChild(self.goPassive, "#go_unlock")
	self.goActive = gohelper.findChild(go, "activeSkill")
	self.goActiveLock = gohelper.findChild(self.goActive, "#go_lock")
	self.goActiveUnlock = gohelper.findChild(self.goActive, "#go_unlock")
	self.goSelect = gohelper.findChild(go, "#go_select")
	self.goCanup = gohelper.findChild(go, "#go_canUp")
	self.btnClick = gohelper.findButtonWithAudio(go, AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.anim = gohelper.findComponentAnim(go)
	self.imageIcon = gohelper.findChildImage(go, "passiveSkill/#simage_skillicon")
	self.imageIconActive = gohelper.findChildImage(go, "activeSkill/#simage_skillicon")
	self.goLoopLight = gohelper.findChild(go, "activeSkill/#select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicCultivateSkillItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._btnclickOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCanUp, self)
end

function AtomicCultivateSkillItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCanUp, self)
end

function AtomicCultivateSkillItem:_btnclickOnClick()
	if not self.data then
		return
	end

	AtomicTalentController.instance:trySelectNodeId(self.data.id)
end

function AtomicCultivateSkillItem:_editableInitView()
	return
end

function AtomicCultivateSkillItem:updateData(data)
	self.data = data

	gohelper.setActive(self.go, data ~= nil)

	if not data then
		self._isUnlock = nil

		return
	end

	if self.data.id ~= self.curId then
		self.curId = self.data.id
		self._isUnlock = nil
	end

	UISpriteSetMgr.instance:setSp02AtomicIconSprite(self.imageIcon, self.data.icon, true)
	UISpriteSetMgr.instance:setSp02AtomicIconSprite(self.imageIconActive, self.data.icon, true)
	self:refreshUI()
end

function AtomicCultivateSkillItem:refreshUI()
	TaskDispatcher.cancelTask(self.refreshUI, self)

	local isSelected = AtomicTalentViewModel.instance:isNodeSelected(self.data.id)
	local isUnlock = AtomicTalentViewModel.instance:isNodeUnlocked(self.data.id)
	local isActive = self.data.mark
	local scale = isActive and 1.6 or 1

	transformhelper.setLocalScale(self.go.transform, scale, scale, scale)

	local arrowScale = 1 / scale

	transformhelper.setLocalScale(self.goCanup.transform, arrowScale, arrowScale, arrowScale)

	if isActive then
		gohelper.setActive(self.goActiveLock, not isUnlock)
		gohelper.setActive(self.goActiveUnlock, isUnlock)

		local isJumpSelected = AtomicTalentViewModel.instance:isNodeSelectedByJump(self.data.id)

		gohelper.setActive(self.goLoopLight, isJumpSelected)
	else
		gohelper.setActive(self.goPassiveLock, not isUnlock)
		gohelper.setActive(self.goPassiveUnlock, isUnlock)
	end

	if isUnlock ~= self._isUnlock then
		local curIsUnlock = self._isUnlock

		self._isUnlock = isUnlock

		if curIsUnlock == false then
			self.anim:Play("unlock")
			gohelper.setActive(self.goActiveLock, true)
			gohelper.setActive(self.goPassiveLock, true)
			AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_skill_light)
			TaskDispatcher.runDelay(self.refreshUI, self, 0.67)
		else
			self.anim:Play(isUnlock and "unlock_idle" or "lock_idle")
		end
	end

	gohelper.setActive(self.goSelect, isSelected)
	gohelper.setActive(self.goPassive, not isActive)
	gohelper.setActive(self.goActive, isActive)
	self:refreshCanUp()
end

function AtomicCultivateSkillItem:refreshCanUp()
	local canUnlock = AtomicTalentViewModel.instance:isCanUnlockTalent(self.data.id)

	gohelper.setActive(self.goCanup, canUnlock)
end

function AtomicCultivateSkillItem:onDestroy()
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

return AtomicCultivateSkillItem
