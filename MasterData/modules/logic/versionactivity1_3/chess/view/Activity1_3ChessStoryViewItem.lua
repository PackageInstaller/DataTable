-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessStoryViewItem.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryViewItem", package.seeall)

local Activity1_3ChessStoryViewItem = class("Activity1_3ChessStoryViewItem", ListScrollCellExtend)

function Activity1_3ChessStoryViewItem:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "#txt_Num")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#txt_Num/#txt_TitleEn")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goUnLocked = gohelper.findChild(self.viewGO, "#go_UnLocked")
	self._simageModIcon = gohelper.findChildSingleImage(self.viewGO, "#go_UnLocked/image_UnLockedMod/#simage_ModIcon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_UnLocked/image_UnLockedMod/#simage_ModIcon")
	self._txtModName = gohelper.findChildText(self.viewGO, "#go_UnLocked/#txt_ModName")
	self._btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "Review/#btn_Review")
	self._goTxtReview = gohelper.findChild(self.viewGO, "Review/#btn_Review/#go_TxtReview")
	self._goTxtLocked = gohelper.findChild(self.viewGO, "Review/#btn_Review/#go_TxtLocked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessStoryViewItem:addEvents()
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
end

function Activity1_3ChessStoryViewItem:removeEvents()
	self._btnReview:RemoveClickListener()
end

function Activity1_3ChessStoryViewItem:_btnReviewOnClick()
	if not self._storyMO then
		return
	end

	if self._storyMO:isLocked() then
		GameFacade.showToast(ToastEnum.Va3Act122StoryIsLock)

		return
	end

	self._needBg = self._storyMO.cfg.needbg == 1

	local bgPath = self._storyMO.cfg.bgPath

	if self._needBg then
		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, self._needBg, bgPath)
	end

	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.MapSceneActvie, self._needBg)

	local param = {}

	param.hideStartAndEndDark = true

	StoryController.instance:playStory(self._storyMO.storyId, param, self.afterPlayStory, self)
end

function Activity1_3ChessStoryViewItem:afterPlayStory()
	if self._needBg then
		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, false)
	end

	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.MapSceneActvie, true)
end

function Activity1_3ChessStoryViewItem:_editableInitView()
	local goReview = gohelper.findChild(self.viewGO, "Review")

	self._canvasGroup = goReview:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function Activity1_3ChessStoryViewItem:_editableAddEvents()
	return
end

function Activity1_3ChessStoryViewItem:_editableRemoveEvents()
	return
end

function Activity1_3ChessStoryViewItem:onUpdateMO(mo)
	self._storyMO = mo

	self:_refreshUI()
end

function Activity1_3ChessStoryViewItem:onSelect(isSelect)
	return
end

function Activity1_3ChessStoryViewItem:onDestroyView()
	self._simageModIcon:UnLoadImage()
end

function Activity1_3ChessStoryViewItem:_refreshUI()
	if not self._storyMO then
		return
	end

	local isLocked = self._storyMO:isLocked()

	self._txtNum.text = self:_getNumStr(self._storyMO.index)
	self._txtModName.text = self._storyMO.cfg.name
	self._txtTitleEn.text = isLocked and "UNKNOWN" or self._storyMO.cfg.nameen

	gohelper.setActive(self._goLocked, isLocked)
	gohelper.setActive(self._goUnLocked, not isLocked)

	if not isLocked then
		self._simageModIcon:LoadImage(string.format("%s.png", self._storyMO.cfg.icon), self._onLoadIconDone, self)
	end

	if self._lastIsLocked ~= isLocked then
		self._lastIsLocked = isLocked
		self._canvasGroup.alpha = isLocked and 0.5 or 1

		local colorStr = isLocked and "#3B3E47" or "#A69F83"

		SLFramework.UGUI.GuiHelper.SetColor(self._txtNum, colorStr)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtTitleEn, colorStr)
	end
end

function Activity1_3ChessStoryViewItem:_onLoadIconDone()
	if self._imageicon and not gohelper.isNil(self._imageicon) then
		self._imageicon:SetNativeSize()
	end
end

function Activity1_3ChessStoryViewItem:_getNumStr(num)
	if num < 10 then
		return "0" .. num
	end

	return tostring(num)
end

Activity1_3ChessStoryViewItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_storyviewitem.prefab"

return Activity1_3ChessStoryViewItem
