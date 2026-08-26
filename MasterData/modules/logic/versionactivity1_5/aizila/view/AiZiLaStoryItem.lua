-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaStoryItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStoryItem", package.seeall)

local AiZiLaStoryItem = class("AiZiLaStoryItem", ListScrollCellExtend)

function AiZiLaStoryItem:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtLockTitleEn = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_LockTitleEn")
	self._txtLockNum = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_LockNum")
	self._btnLockReview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Locked/Review/#btn_LockReview")
	self._goTxtLocked = gohelper.findChild(self.viewGO, "#go_Locked/Review/#btn_LockReview/#go_TxtLocked")
	self._goUnLocked = gohelper.findChild(self.viewGO, "#go_UnLocked")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_UnLocked/#txt_TitleEn")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_UnLocked/#txt_Num")
	self._simageModIcon1 = gohelper.findChildSingleImage(self.viewGO, "#go_UnLocked/#simage_ModIcon1")
	self._simageModIcon2 = gohelper.findChildSingleImage(self.viewGO, "#go_UnLocked/#simage_ModIcon2")
	self._txtModName = gohelper.findChildText(self.viewGO, "#go_UnLocked/#txt_ModName")
	self._txtModNameEn = gohelper.findChildText(self.viewGO, "#go_UnLocked/#txt_ModNameEn")
	self._btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_UnLocked/Review/#btn_Review")
	self._goTxtReview = gohelper.findChild(self.viewGO, "#go_UnLocked/Review/#btn_Review/#go_TxtReview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaStoryItem:addEvents()
	self._btnLockReview:AddClickListener(self._btnLockReviewOnClick, self)
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
end

function AiZiLaStoryItem:removeEvents()
	self._btnLockReview:RemoveClickListener()
	self._btnReview:RemoveClickListener()
end

function AiZiLaStoryItem:_btnLockReviewOnClick()
	GameFacade.showToast(ToastEnum.V1a5AiZiLaStroyLock)
end

function AiZiLaStoryItem:_btnReviewOnClick()
	if not self._storyMO then
		return
	end

	if self._storyMO:isLocked() then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaStroyLock)

		return
	end

	local param = {}

	param.hideStartAndEndDark = true

	StoryController.instance:playStory(self._storyMO.storyId, param)
end

function AiZiLaStoryItem:_editableInitView()
	return
end

function AiZiLaStoryItem:_editableAddEvents()
	return
end

function AiZiLaStoryItem:_editableRemoveEvents()
	return
end

function AiZiLaStoryItem:onUpdateMO(mo)
	self._storyMO = mo

	self:_refreshUI()
end

function AiZiLaStoryItem:onSelect(isSelect)
	return
end

function AiZiLaStoryItem:onDestroyView()
	self._simageModIcon2:UnLoadImage()
end

function AiZiLaStoryItem:_refreshUI()
	if not self._storyMO then
		return
	end

	local isLocked = self._storyMO:isLocked()
	local numStr = self:_getNumStr(self._storyMO.index)

	self._txtNum.text = numStr
	self._txtLockNum.text = numStr
	self._txtModName.text = self._storyMO.config.name
	self._txtTitleEn.text = self._storyMO.config.nameen
	self._txtLockTitleEn.text = self._storyMO.config.nameen
	self._txtModNameEn.text = self._storyMO.config.titleen

	local show1 = self._storyMO.index == 1

	gohelper.setActive(self._simageModIcon2, not show1)
	gohelper.setActive(self._simageModIcon1, show1)
	gohelper.setActive(self._goLocked, isLocked)
	gohelper.setActive(self._goUnLocked, not isLocked)
end

function AiZiLaStoryItem:_getNumStr(num)
	if num < 10 then
		return "0" .. num
	end

	return tostring(num)
end

AiZiLaStoryItem.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_storyviewitem.prefab"

return AiZiLaStoryItem
