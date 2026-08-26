-- chunkname: @modules/logic/character/view/CharacterTalentChessFilterItem.lua

module("modules.logic.character.view.CharacterTalentChessFilterItem", package.seeall)

local CharacterTalentChessFilterItem = class("CharacterTalentChessFilterItem", ListScrollCellExtend)

function CharacterTalentChessFilterItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._gousing = gohelper.findChild(self.viewGO, "#go_using")
	self._txtstylename = gohelper.findChildText(self.viewGO, "layout/#txt_stylename")
	self._gocareer = gohelper.findChild(self.viewGO, "layout/#go_career")
	self._txtlabel = gohelper.findChildText(self.viewGO, "layout/#go_career/#txt_label")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentChessFilterItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterTalentChessFilterItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function CharacterTalentChessFilterItem:_btnclickOnClick()
	TalentStyleModel.instance:UseStyle(self._heroId, self._mo)
end

function CharacterTalentChessFilterItem:_editableInitView()
	self._styleslot = gohelper.findChildImage(self.viewGO, "layout/slot")
	self._styleicon = gohelper.findChildImage(self.viewGO, "layout/slot/icon")
	self._styleglow = gohelper.findChildImage(self.viewGO, "layout/slot/glow")
	self._unlock = gohelper.findChild(self.viewGO, "unlock")

	local layout = gohelper.findChild(self.viewGO, "layout")

	self._layoutCanvasGroup = layout:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function CharacterTalentChessFilterItem:_editableAddEvents()
	return
end

function CharacterTalentChessFilterItem:_editableRemoveEvents()
	return
end

function CharacterTalentChessFilterItem:onUpdateMO(mo)
	self._mo = mo
	self._heroId = TalentStyleModel.instance._heroId

	self:refreshItem()
end

function CharacterTalentChessFilterItem:onSelect(isSelect)
	return
end

function CharacterTalentChessFilterItem:onDestroyView()
	TaskDispatcher.cancelTask(self.hideUnlockAnim, self)
end

function CharacterTalentChessFilterItem:showItemState()
	gohelper.setActive(self._goselect, self._mo._isUnlock and self._mo._isSelect)
	gohelper.setActive(self._gousing, self._mo._isUnlock and self._mo._isUse)
	gohelper.setActive(self._golocked, not self._mo._isUnlock)

	if self._mo._isUnlock then
		local style = self._mo._styleId

		if style ~= 0 and TalentStyleModel.instance:isPlayAnim(self._heroId, style) then
			self._isPlayAnim = true

			gohelper.setActive(self._unlock, true)
			TalentStyleModel.instance:setPlayAnim(self._heroId, style)
			TaskDispatcher.runDelay(self.hideUnlockAnim, self, 0.5)
		end
	elseif not self._isPlayAnim then
		self:hideUnlockAnim()
	end

	self._layoutCanvasGroup.alpha = self._mo._isUnlock and 1 or 0.5
end

function CharacterTalentChessFilterItem:hideUnlockAnim()
	gohelper.setActive(self._unlock, false)

	self._isPlayAnim = false
end

function CharacterTalentChessFilterItem:refreshItem()
	local growTagIcon, nomalTagIcon = self._mo:getStyleTagIcon()
	local name, tag = self._mo:getStyleTag()

	self._txtstylename.text = name
	self._txtlabel.text = tag

	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleslot, nomalTagIcon, true)

	local _isUse = self._mo._isUse

	if _isUse then
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleicon, growTagIcon, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleglow, growTagIcon, true)
	end

	self._styleicon.enabled = _isUse
	self._styleglow.enabled = _isUse

	self:showItemState()
end

return CharacterTalentChessFilterItem
