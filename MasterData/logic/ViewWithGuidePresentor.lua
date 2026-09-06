-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/ViewWithGuidePresentor.lua

module("logic.extensions.guide.view.ViewWithGuidePresentor", package.seeall)

local ViewWithGuidePresentor = class("ViewWithGuidePresentor", ViewPresentor)

function ViewWithGuidePresentor:ctor()
	ViewWithGuidePresentor.super.ctor(self)

	self.viewWithGuide = true
	self.isViewGuidable = nil
	self.aniDone = false
	self.rcdAniDeal = false
	self.animatorStateName = "show"
end

function ViewWithGuidePresentor:showSelf()
	ViewWithGuidePresentor.super.showSelf(self)

	self.aniDone = true

	GuideController.instance:tryStopAni(self)
end

function ViewWithGuidePresentor:_doRealOpen()
	if self.isViewGuidable and self.aniDone then
		GuideController.instance:onViewEnterFinish(self.viewName)
	end
end

function ViewWithGuidePresentor:_onEnterAnimationDone()
	self:_onVisualEvent(ViewPresentor.kOnEnterFinished)
	GlobalDispatcher:dispatch(GlobalNotify.OnViewOpenDone, self)
	self:setClickEnable()

	if self._opType == ViewPresentor.kViewOpClose then
		self.isViewGuidable = nil

		self:_doClose()
	elseif self._status == ViewPresentor.kViewStatusOpening then
		self._status = ViewPresentor.kViewStatusOpen
		self.isViewGuidable = true

		self:_doRealOpen()
	end

	if self.priority then
		ViewPriorityMgr.instance:handleViewsPriority()
	end
end

function ViewWithGuidePresentor:_onCloseAnimationDone()
	self:_onVisualEvent(ViewPresentor.kOnExitFinished)
	self.mainGO:SetActive(false)

	if self.closeCallBack then
		self.closeCallBack()

		self.closeCallBack = nil
	end

	if self._opType == ViewPresentor.kViewOpOpen then
		self:_doOpen()
	elseif self._status == ViewPresentor.kViewStatusClosing then
		self._status = ViewPresentor.kViewStatusClose
		self._openParam = nil
		self.isViewGuidable = nil

		GlobalDispatcher:dispatch(GlobalNotify.OnViewClose, self)
		GlobalModel.instance:checkShowGrayMask()
		GuideController.instance:onViewExitFinish(self.viewName)
	end

	if self.priority then
		ViewPriorityMgr.instance:popPriorityViewsList(self)
		ViewPriorityMgr.instance:handleViewsPriority()
	end
end

function ViewWithGuidePresentor:setClickEnable()
	if self.hasSetSlickEnabled == true then
		self.hasSetSlickEnabled = false

		GameUtil.clickEnabled(true, self)
		print(">>>>>>>>###", self.viewName, "click enable = true")
	end
end

function ViewWithGuidePresentor:open(param)
	self.hasSetSlickEnabled = true

	GameUtil.clickEnabled(false, self)
	print(">>>>>>>>###", self.viewName, "click enable = false")
	ViewWithGuidePresentor.super.open(self, param)
end

function ViewWithGuidePresentor:close()
	self:setClickEnable()
	ViewWithGuidePresentor.super.close(self)
end

function ViewWithGuidePresentor:destroy()
	self:setClickEnable()
	ViewWithGuidePresentor.super.destroy(self)
end

return ViewWithGuidePresentor
