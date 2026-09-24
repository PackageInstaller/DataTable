-- chunkname: @modules/logic/college/view/role/CollegeRoleBaseEntryItem.lua

module("modules.logic.college.view.role.CollegeRoleBaseEntryItem", package.seeall)

local CollegeRoleBaseEntryItem = class("CollegeRoleBaseEntryItem", LuaCompBase)
local PercentColor = "#A57800"
local BracketColor = "#4E6698"

function CollegeRoleBaseEntryItem:init(go)
	self.go = go
	self._goUnLocked = gohelper.findChild(self.go, "#go_UnLocked")
	self._goWordsLocked = gohelper.findChild(self.go, "#go_UnLocked/#go_WordsLocked")
	self._goWordsUnlocked = gohelper.findChild(self.go, "#go_UnLocked/#go_WordsUnlocked")
	self._goLike = gohelper.findChild(self.go, "#go_UnLocked/#go_Like")
	self._goNew = gohelper.findChild(self.go, "#go_UnLocked/#go_New")
	self._txtUnLockDesc = gohelper.findChildText(self.go, "#go_UnLocked/#txt_buff")
	self._imageQuality = gohelper.findChildImage(self.go, "#go_UnLocked/#txt_buff/#image_icon")
	self._goLocked = gohelper.findChild(self.go, "#go_Locked")
	self._txtLockedDesc = gohelper.findChildText(self.go, "#go_Locked/#txt_Locked")
	self._goRefreshBg = gohelper.findChild(self.go, "#go_UnLocked/#go_RefreshBg")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function CollegeRoleBaseEntryItem:addEventListeners()
	return
end

function CollegeRoleBaseEntryItem:removeEventListeners()
	return
end

function CollegeRoleBaseEntryItem:onUpdateMO(entryMo, characterMo, parentView, index)
	self:reset()
	self:updateData(entryMo, characterMo, parentView, index)
	self:refreshUI()
end

function CollegeRoleBaseEntryItem:reset()
	gohelper.setActive(self._goUnLocked, false)
	gohelper.setActive(self._goLocked, false)
	gohelper.setActive(self._goWordsLocked, false)
	gohelper.setActive(self._goWordsUnlocked, false)
	gohelper.setActive(self._goLike, false)
	gohelper.setActive(self._goNew, false)
	gohelper.setActive(self._goRefreshBg, false)
end

function CollegeRoleBaseEntryItem:updateData(entryMo, characterMo, parentView, index)
	self._preCharacterMo = self._characterMo
	self._preIsUnlock = self._isUnlock
	self._entryMo = entryMo
	self._entryId = entryMo.id
	self._characterMo = characterMo
	self._parentView = parentView
	self._index = index
	self._isUnlock = self._entryMo.unlock
end

function CollegeRoleBaseEntryItem:refreshUI()
	self:refreshCommonUI()
	self:refreshOtherUI()
end

function CollegeRoleBaseEntryItem:refreshCommonUI()
	gohelper.setActive(self._goUnLocked, self._isUnlock)
	gohelper.setActive(self._goLocked, not self._isUnlock)

	if self._isUnlock then
		local desc = self._entryMo.co.description

		self._txtUnLockDesc.text = CollegeHelper.instance:replaceColor(SkillHelper.buildDesc(desc, PercentColor, BracketColor))

		UISpriteSetMgr.instance:setCollegeSprite(self._imageQuality, "college_role_dispatch" .. self._entryMo.co.quality)
	else
		local unlockLv = self._entryMo.lvCo.level

		self._txtLockedDesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_roleentryitem_locked"), unlockLv)
	end

	if self._preCharacterMo == self._characterMo and self._preIsUnlock ~= self._isUnlock then
		self:playAnim("update")
	else
		self:playAnim("idle")
	end
end

function CollegeRoleBaseEntryItem:refreshOtherUI()
	return
end

function CollegeRoleBaseEntryItem:playAnim(animName)
	if not self.go.activeInHierarchy then
		return
	end

	self._animator:Play(animName, 0, 0)
end

return CollegeRoleBaseEntryItem
