-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaStoryViewItem.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaStoryViewItem", package.seeall)

local JiaLaBoNaStoryViewItem = class("JiaLaBoNaStoryViewItem", ListScrollCellExtend)

function JiaLaBoNaStoryViewItem:onInitView()
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

function JiaLaBoNaStoryViewItem:addEvents()
	self._btnReview:AddClickListener(self._btnReviewOnClick, self)
end

function JiaLaBoNaStoryViewItem:removeEvents()
	self._btnReview:RemoveClickListener()
end

function JiaLaBoNaStoryViewItem:_btnReviewOnClick()
	if not self._storyMO then
		return
	end

	if self._storyMO:isLocked() then
		GameFacade.showToast(ToastEnum.Va3Act120ChapterStroyLock)

		return
	end

	local param = {}

	param.hideStartAndEndDark = true

	StoryController.instance:playStory(self._storyMO.storyId, param, self.afterPlayStory, self)

	local needBg = self._storyMO.config and self._storyMO.config.needbg == 1 or false

	self._needBg = needBg

	if self._needBg then
		local bgPath = self._storyMO.config.bgPath

		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, self._needBg, bgPath)
	end

	JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.MapSceneActvie, needBg)
end

function JiaLaBoNaStoryViewItem:afterPlayStory()
	if self._needBg then
		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, false)
	end

	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.MapSceneActvie, true)
end

function JiaLaBoNaStoryViewItem:_editableInitView()
	local goReview = gohelper.findChild(self.viewGO, "Review")

	self._canvasGroup = goReview:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function JiaLaBoNaStoryViewItem:_editableAddEvents()
	return
end

function JiaLaBoNaStoryViewItem:_editableRemoveEvents()
	return
end

function JiaLaBoNaStoryViewItem:onUpdateMO(mo)
	self._storyMO = mo

	self:_refreshUI()
end

function JiaLaBoNaStoryViewItem:onSelect(isSelect)
	return
end

function JiaLaBoNaStoryViewItem:onDestroyView()
	self._simageModIcon:UnLoadImage()
end

function JiaLaBoNaStoryViewItem:_refreshUI()
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

function JiaLaBoNaStoryViewItem:_getNumStr(num)
	if num < 10 then
		return "0" .. num
	end

	return tostring(num)
end

JiaLaBoNaStoryViewItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonastoryviewitem.prefab"

return JiaLaBoNaStoryViewItem
