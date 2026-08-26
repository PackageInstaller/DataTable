-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaStoryViewItem.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaStoryViewItem", package.seeall)

local LanShouPaStoryViewItem = class("LanShouPaStoryViewItem", ListScrollCellExtend)

function LanShouPaStoryViewItem:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "#txt_Num")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#txt_Num/#txt_TitleEn")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goUnLocked = gohelper.findChild(self.viewGO, "#go_UnLocked")
	self._simageModIcon = gohelper.findChildSingleImage(self.viewGO, "#go_UnLocked/image_UnLockedMod/#simage_ModIcon")
	self._txtModName = gohelper.findChildText(self.viewGO, "#go_UnLocked/#txt_ModName")
	self._btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "Review/#btn_Review")
	self._goTxtReview = gohelper.findChild(self.viewGO, "Review/#btn_Review/#go_TxtReview")
	self._goTxtLocked = gohelper.findChild(self.viewGO, "Review/#btn_Review/#go_TxtLocked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaStoryViewItem:addEvents()
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
end

function LanShouPaStoryViewItem:removeEvents()
	self._btnReview:RemoveClickListener()
end

function LanShouPaStoryViewItem:_btnReviewOnClick()
	if not self._storyMO then
		return
	end

	if self._storyMO:isLocked() then
		return
	end

	local param = {}

	param.hideStartAndEndDark = true

	StoryController.instance:playStory(self._storyMO.storyId, param, self.afterPlayStory, self)

	local needBg = self._storyMO.config and self._storyMO.config.needbg == 1 or false

	self._needBg = needBg

	if self._needBg then
		local bgPath = self._storyMO.config.bgPath

		ChessController.instance:dispatchEvent(ChessGameEvent.StoryReviewSceneActvie, self._needBg, bgPath)
	end

	LanShouPaController.instance:dispatchEvent(LanShouPaEvent.MapSceneActvie, needBg)
end

function LanShouPaStoryViewItem:afterPlayStory()
	if self._needBg then
		ChessController.instance:dispatchEvent(ChessGameEvent.StoryReviewSceneActvie, false)
	end

	ChessController.instance:dispatchEvent(ChessGameEvent.MapSceneActvie, true)
end

function LanShouPaStoryViewItem:_editableInitView()
	local goReview = gohelper.findChild(self.viewGO, "Review")

	self._canvasGroup = goReview:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function LanShouPaStoryViewItem:_editableAddEvents()
	return
end

function LanShouPaStoryViewItem:_editableRemoveEvents()
	return
end

function LanShouPaStoryViewItem:onUpdateMO(mo)
	self._storyMO = mo

	self:_refreshUI()
end

function LanShouPaStoryViewItem:onSelect(isSelect)
	return
end

function LanShouPaStoryViewItem:onDestroyView()
	self._simageModIcon:UnLoadImage()
end

function LanShouPaStoryViewItem:_refreshUI()
	if not self._storyMO then
		return
	end

	local isLocked = self._storyMO:isLocked()

	self._txtNum.text = self:_getNumStr(self._storyMO.index)
	self._txtModName.text = self._storyMO.config.name
	self._txtTitleEn.text = isLocked and "UNKNOWN" or self._storyMO.config.nameen

	if not isLocked then
		self._simageModIcon:LoadImage(string.format("%s.png", self._storyMO.config.icon))
	end

	gohelper.setActive(self._goLocked, isLocked)
	gohelper.setActive(self._goUnLocked, not isLocked)

	if self._lastIsLocked ~= isLocked then
		self._lastIsLocked = isLocked
		self._canvasGroup.alpha = isLocked and 0.5 or 1

		local colorStr = isLocked and "#3B3E47" or "#A7AAAF"

		SLFramework.UGUI.GuiHelper.SetColor(self._txtNum, colorStr)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtTitleEn, colorStr)
	end
end

function LanShouPaStoryViewItem:_getNumStr(num)
	if num < 10 then
		return "0" .. num
	end

	return tostring(num)
end

LanShouPaStoryViewItem.prefabPath = "ui/viewres/versionactivity_2_1/v2a1_tuesday/v2a1_tuesday_storyviewitem.prefab"

return LanShouPaStoryViewItem
