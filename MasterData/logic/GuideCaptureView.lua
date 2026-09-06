-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideCaptureView.lua

module("logic.extensions.guide.view.GuideCaptureView", package.seeall)

local GuideCaptureView = class("GuideCaptureView", ViewComponent)

function GuideCaptureView:ctor()
	GuideCaptureView.super.ctor(self)
end

function GuideCaptureView:buildUI()
	GuideCaptureView.super.buildUI(self)

	self._blurBg = goutil.findChildComponent(self.mainGO, "blurBg", "StaticBluredScreen")
	self._blurBg.blur = 0.2
end

function GuideCaptureView:bindEvents()
	GuideCaptureView.super.bindEvents(self)
end

function GuideCaptureView:unbindEvents()
	GuideCaptureView.super.unbindEvents(self)
end

function GuideCaptureView:destroyUI()
	GuideCaptureView.super.destroyUI(self)
end

function GuideCaptureView:onEnter()
	GuideCaptureView.super.onEnter(self)

	self._currGuideBranch = GuideModel.instance:getCurrGuideBranch()
	self._currGuide = self._currGuideBranch:getGuide()

	local params = self._currGuide:getJsonParams()

	if params then
		self.storyId = params.storyId
	end

	if self.storyId > 0 then
		GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
		self._blurBg:Release()
		self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
		self._blurBg:Capture()
	else
		print(">>>>>>>>>>>>>>>>>  GuideCaptureView  story ID 错误 退出")
		self:close()
	end
end

function GuideCaptureView:onEnterFinished()
	GuideCaptureView.super.onEnterFinished(self)
end

function GuideCaptureView:onExit()
	GuideCaptureView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	self._blurBg:Release()
end

function GuideCaptureView:onExitFinished()
	GuideCaptureView.super.onExitFinished(self)
end

function GuideCaptureView:_onCaptureScreenFinish(tex)
	AMBlurScreenEffect.finalTexture = self._blurBg.texture

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, self.storyId)
end

function GuideCaptureView:_onViewClose(view)
	if view.viewName == ViewName.Story then
		goutil.destroy(AMBlurScreenEffect.finalTexture)

		AMBlurScreenEffect.finalTexture = nil

		GuideController.instance:finishGuide()
		self:close()
	end
end

return GuideCaptureView
