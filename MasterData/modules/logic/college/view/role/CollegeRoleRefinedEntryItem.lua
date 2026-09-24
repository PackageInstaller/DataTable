-- chunkname: @modules/logic/college/view/role/CollegeRoleRefinedEntryItem.lua

module("modules.logic.college.view.role.CollegeRoleRefinedEntryItem", package.seeall)

local CollegeRoleRefinedEntryItem = class("CollegeRoleRefinedEntryItem", CollegeRoleBaseEntryItem)

function CollegeRoleRefinedEntryItem:init(go)
	CollegeRoleRefinedEntryItem.super.init(self, go)

	self._btnWordsLocked = gohelper.findChildButtonWithAudio(self.go, "#go_UnLocked/#go_WordsLocked")
	self._btnWordsUnlocked = gohelper.findChildButtonWithAudio(self.go, "#go_UnLocked/#go_WordsUnlocked")
end

function CollegeRoleRefinedEntryItem:addEventListeners()
	CollegeRoleRefinedEntryItem.super.addEventListeners(self)
	self._btnWordsLocked:AddClickListener(self._btnWordsLockedOnClick, self)
	self._btnWordsUnlocked:AddClickListener(self._btnWordsUnlockedOnClick, self)
end

function CollegeRoleRefinedEntryItem:removeEventListeners()
	CollegeRoleRefinedEntryItem.super.removeEventListeners(self)
	self._btnWordsLocked:RemoveClickListener()
	self._btnWordsUnlocked:RemoveClickListener()
end

function CollegeRoleRefinedEntryItem:_btnWordsLockedOnClick()
	CollegeRpc.instance:sendCollegeBuildingLockEntry(self._characterMo.uid, self._index - 1, false)
end

function CollegeRoleRefinedEntryItem:_btnWordsUnlockedOnClick()
	local curLockEntriesNum = self._characterMo:getLockEntriesNum()

	if curLockEntriesNum >= self._maxLockNum then
		GameFacade.showToast(ToastEnum.CollegeLockRoleEntries)

		return
	end

	CollegeRpc.instance:sendCollegeBuildingLockEntry(self._characterMo.uid, self._index - 1, true)
end

function CollegeRoleRefinedEntryItem:refreshOtherUI()
	CollegeRoleRefinedEntryItem.super.refreshOtherUI(self)

	local refinedBuildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.TrainCharacter)

	if refinedBuildingMo then
		self._maxLockNum = refinedBuildingMo.refineCanLockNum or 0
	end

	self._maxLockNum = math.min(self._maxLockNum, #self._characterMo.entries - 1)

	local isLock = self._maxLockNum > 0 and self._entryMo.locked
	local isUnlock = self._maxLockNum > 0 and not self._entryMo.locked

	gohelper.setActive(self._goWordsLocked, isLock)
	gohelper.setActive(self._goWordsUnlocked, isUnlock)
	gohelper.setActive(self._goRefreshBg, isUnlock)
end

return CollegeRoleRefinedEntryItem
