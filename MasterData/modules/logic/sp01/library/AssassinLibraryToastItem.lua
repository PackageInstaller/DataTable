-- chunkname: @modules/logic/sp01/library/AssassinLibraryToastItem.lua

module("modules.logic.sp01.library.AssassinLibraryToastItem", package.seeall)

local AssassinLibraryToastItem = class("AssassinLibraryToastItem", LuaCompBase)
local OutSidePos = 10000
local csTweenHelper = ZProj.TweenHelper

function AssassinLibraryToastItem:init(go)
	self.tr = go.transform
	self._btnclick = gohelper.findChildButtonWithAudio(go, "btn_click")
	self._simageicon = gohelper.findChildSingleImage(go, "simage_icon")
	self._txttitle = gohelper.findChildText(go, "txt_title")
	self.canvasGroup = gohelper.onceAddComponent(go, gohelper.Type_CanvasGroup)
	self._duration = 0.5
	self._showToastDuration = 3
	self.height = recthelper.getHeight(self.tr)
	self.width = recthelper.getWidth(self.tr)
	self.startAnchorPositionY = 0
end

function AssassinLibraryToastItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinLibraryToastItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinLibraryToastItem:_btnclickOnClick()
	if not self.libraryCo then
		return
	end

	AssassinController.instance:openAssassinLibraryDetailView(self.libraryId)
	AssassinController.instance:dispatchEvent(AssassinEvent.RecycleToast, self)
end

function AssassinLibraryToastItem:setMsg(msg)
	self.msg = msg
	self.libraryId = msg
	self.canvasGroup.alpha = 1
	self.libraryCo = AssassinConfig.instance:getLibrarConfig(self.libraryId)
	self._txttitle.text = self.libraryCo and self.libraryCo.title

	AssassinHelper.setLibraryToastIcon(self.msg, self._simageicon)
end

function AssassinLibraryToastItem:_delay()
	AssassinController.instance:dispatchEvent(AssassinEvent.RecycleToast, self)
end

function AssassinLibraryToastItem:appearAnimation()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	recthelper.setAnchorX(self.tr, self.width)
	csTweenHelper.KillById(self.startTweenId or -1)

	self.startTweenId = csTweenHelper.DOAnchorPosX(self.tr, 0, self._duration, function()
		self.startTweenId = nil

		TaskDispatcher.runDelay(self._delay, self, self._showToastDuration)
	end)
end

function AssassinLibraryToastItem:upAnimation(targetPosY)
	csTweenHelper.KillById(self.upTweenId or -1)

	self.upTweenId = csTweenHelper.DOAnchorPosY(self.tr, targetPosY, self._duration, function()
		self.upTweenId = nil
	end)
end

function AssassinLibraryToastItem:quitAnimation(quitAnimationDoneCallback, callbackObj)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.quitAnimationDoneCallback = quitAnimationDoneCallback
	self.callbackObj = callbackObj
	self.startAnchorPositionY = self.tr.anchoredPosition.y
	self.quitTweenId = csTweenHelper.DOTweenFloat(1, 0, self._duration, self.quitAnimationFrame, self.quitAnimationDone, self)
end

function AssassinLibraryToastItem:quitAnimationFrame(value)
	local upPositionY = (1 - value) * self.height

	recthelper.setAnchorY(self.tr, self.startAnchorPositionY + upPositionY)

	self.canvasGroup.alpha = value
end

function AssassinLibraryToastItem:quitAnimationDone()
	if self.quitAnimationDoneCallback then
		self.quitAnimationDoneCallback(self.callbackObj, self)
	end

	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
	self.quitTweenId = nil
end

function AssassinLibraryToastItem:clearAllTask()
	TaskDispatcher.cancelTask(self._delay, self)
	csTweenHelper.KillById(self.startTweenId or -1)
	csTweenHelper.KillById(self.upTweenId or -1)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.startTweenId = nil
	self.upTweenId = nil
	self.quitTweenId = nil
	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
end

function AssassinLibraryToastItem:reset()
	self.msg = nil
	self.startAnchorPositionY = 0

	recthelper.setAnchor(self.tr, OutSidePos, OutSidePos)
end

function AssassinLibraryToastItem:onDestroy()
	self._simageicon:UnLoadImage()
	self:clearAllTask()
end

return AssassinLibraryToastItem
