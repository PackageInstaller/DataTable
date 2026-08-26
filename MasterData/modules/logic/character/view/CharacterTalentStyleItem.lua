-- chunkname: @modules/logic/character/view/CharacterTalentStyleItem.lua

module("modules.logic.character.view.CharacterTalentStyleItem", package.seeall)

local CharacterTalentStyleItem = class("CharacterTalentStyleItem", ListScrollCellExtend)

function CharacterTalentStyleItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._txtstyle = gohelper.findChildText(self.viewGO, "#txt_style")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._gouse = gohelper.findChild(self.viewGO, "#go_use")
	self._gonew = gohelper.findChild(self.viewGO, "#go_new")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentStyleItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterTalentStyleItem:removeEvents()
	self._btnclick:RemoveClickListener()
	TaskDispatcher.cancelTask(self._hideNewAnim, self)
	TaskDispatcher.cancelTask(self._hideUnlockAnim, self)
	TaskDispatcher.cancelTask(self._hideSelectAnim, self)
end

function CharacterTalentStyleItem:_btnclickOnClick()
	if self._mo then
		TalentStyleModel.instance:selectCubeStyle(self._heroId, self._mo._styleId)
		gohelper.setActive(self._gonew, false)
	end
end

function CharacterTalentStyleItem:_editableInitView()
	self._styleslot = gohelper.findChildImage(self.viewGO, "slot")
	self._styleicon = gohelper.findChildImage(self.viewGO, "slot/icon")
	self._styleglow = gohelper.findChildImage(self.viewGO, "slot/glow")
	self._goselectQuan = gohelper.findChild(self.viewGO, "#go_select/quan")
	self._gohot = gohelper.findChild(self.viewGO, "#go_hot")
	self._imglock = self._golocked:GetComponent(typeof(UnityEngine.UI.Image))
end

function CharacterTalentStyleItem:_editableAddEvents()
	return
end

function CharacterTalentStyleItem:_editableRemoveEvents()
	return
end

function CharacterTalentStyleItem:onUpdateMO(mo)
	self._mo = mo
	self._heroId = TalentStyleModel.instance._heroId

	self:refreshItem()
end

function CharacterTalentStyleItem:onSelect(isSelect)
	return
end

function CharacterTalentStyleItem:onDestroyView()
	TaskDispatcher.cancelTask(self._hideUnlockAnim, self)
	TaskDispatcher.cancelTask(self._hideSelectAnim, self)
end

function CharacterTalentStyleItem:showItemState()
	gohelper.setActive(self._gouse, self._mo._isUse)
	gohelper.setActive(self._golocked, not self._mo._isUnlock)
	gohelper.setActive(self._gonormal, self._mo._isUnlock)

	local _newUnlockStyle = TalentStyleModel.instance:getNewUnlockStyle()
	local _newSelectStyle = TalentStyleModel.instance:getNewSelectStyle()

	TaskDispatcher.cancelTask(self._hideUnlockAnim, self)
	TaskDispatcher.cancelTask(self._hideSelectAnim, self)
	TaskDispatcher.cancelTask(self._hideNewAnim, self)
	gohelper.setActive(self._gounlock, _newUnlockStyle == self._mo._styleId)
	gohelper.setActive(self._goselectQuan, _newSelectStyle == self._mo._styleId)
	gohelper.setActive(self._goselect, self._mo._isSelect)

	if _newUnlockStyle == self._mo._styleId then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_unlock_01)
		TaskDispatcher.runDelay(self._hideUnlockAnim, self, 0.5)
	end

	if _newSelectStyle then
		TaskDispatcher.runDelay(self._hideSelectAnim, self, 0.5)
	end

	gohelper.setActive(self._gonew, self._mo._isNew)

	self._styleglow.color = Color(1, 1, 1, self._mo._isUnlock and 1 or 0.3)
	self._imglock.color = Color(1, 1, 1, self._mo._isUnlock and 1 or 0.5)
	self._styleslot.enabled = self._mo._isUnlock
	self._styleicon.enabled = self._mo._isUnlock

	gohelper.setActive(self._gohot, self._mo:isHotUnlock())
end

function CharacterTalentStyleItem:_hideUnlockAnim()
	gohelper.setActive(self._gounlock, false)
	TalentStyleModel.instance:setNewUnlockStyle()
end

function CharacterTalentStyleItem:_hideNewAnim()
	gohelper.setActive(self._gonew, false)

	self._isShowNew = false
end

function CharacterTalentStyleItem:_hideSelectAnim()
	gohelper.setActive(self._goselectQuan, false)
	TalentStyleModel.instance:setNewSelectStyle()
end

function CharacterTalentStyleItem:refreshItem()
	local growTagIcon, nomalTagIcon = self._mo:getStyleTagIcon()

	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleslot, nomalTagIcon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleicon, growTagIcon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleglow, growTagIcon, true)
	self:showItemState()
end

return CharacterTalentStyleItem
