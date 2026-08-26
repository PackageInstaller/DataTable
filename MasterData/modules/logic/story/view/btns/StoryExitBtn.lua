-- chunkname: @modules/logic/story/view/btns/StoryExitBtn.lua

module("modules.logic.story.view.btns.StoryExitBtn", package.seeall)

local StoryExitBtn = class("StoryExitBtn", UserDataDispose)

function StoryExitBtn:ctor(go, callback, frontView)
	self:__onInit()

	self.frontView = frontView
	self.go = go
	self.callback = callback
	self.btn = gohelper.findButtonWithAudio(go)

	self.addClickCb(self, self.btn, self.onClickExitBtn, self)
	gohelper.setActive(self.go, false)

	self.isActive = false
	self.isInVideo = false

	self.addEventCb(self, StoryController.instance, StoryEvent.VideoChange, self._onVideoChange, self)
end

function StoryExitBtn:onClickExitBtn()
	StoryModel.instance:setStoryAuto(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.ExitStoryReplay, MsgBoxEnum.BoxType.Yes_No, self.onMessageYes, nil, nil, self)
end

function StoryExitBtn:onMessageYes()
	StoryController.instance:dispatchEvent(StoryEvent.OnSkipConfirm, true)
end

function StoryExitBtn:onClickNext()
	if StoryModel.instance:isPlayFinished() then
		return
	end

	if not self:checkBtnCanShow() then
		return
	end

	self:setActive(true)

	if not self.isInVideo then
		return
	end

	self:_startHideTime()
end

function StoryExitBtn:refresh(btnVisible)
	if StoryModel.instance:isPlayFinished() then
		return
	end

	if self.frontView then
		local btnVisible = self.frontView.btnVisible
		local isCanShow = self:checkBtnCanShow()

		if isCanShow then
			local isPlayVideo = StoryModel.instance:isPlayingVideo()

			if not btnVisible and isPlayVideo then
				if not self.isInVideo then
					self:setActive(false)
				end

				self.isInVideo = true
			else
				TaskDispatcher.cancelTask(self._hideCallback, self)

				self.isInVideo = false

				self:setActive(true)
			end
		else
			TaskDispatcher.cancelTask(self._hideCallback, self)

			self.isInVideo = false

			self:setActive(false)
		end
	end
end

function StoryExitBtn:_onVideoChange()
	self:refresh()
end

function StoryExitBtn:_startHideTime()
	local hideTime = 5

	TaskDispatcher.cancelTask(self._hideCallback, self)
	TaskDispatcher.runDelay(self._hideCallback, self, hideTime)
end

function StoryExitBtn:_hideCallback()
	self:setActive(false)
end

function StoryExitBtn:_isForceHideTopBtn()
	self._ForceHideTopView = self._ForceHideTopView or {
		ViewName.V3a4BBSView
	}

	for _, viewName in ipairs(self._ForceHideTopView) do
		if ViewMgr.instance:isOpen(viewName) then
			return true
		end
	end
end

function StoryExitBtn:setActive(isActive)
	local hideTopBtns = StoryModel.instance:getHideBtns()

	if hideTopBtns then
		gohelper.setActive(self.go, false)

		self.isActive = false

		return
	end

	if isActive == self.isActive then
		return
	end

	self.isActive = isActive

	local isForceHide = self:_isForceHideTopBtn()

	gohelper.setActive(self.go, not isForceHide and isActive)

	if self.callback then
		self.callback(self.frontView)
	end
end

function StoryExitBtn:checkBtnCanShow()
	local isReplay = StoryModel.instance:isReplay()
	local isPv = StoryModel.instance:isVersionActivityPV()

	return isReplay and not isPv
end

function StoryExitBtn:destroy()
	TaskDispatcher.cancelTask(self._hideCallback, self)
	self:__onDispose()
end

return StoryExitBtn
