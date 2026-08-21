-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryIntroView.lua

module("logic.extensions.story.view.StoryIntroView", package.seeall)

local M = class("StoryIntroView", ViewComponent)

function M:buildUI()
	self._introPanel = self:getGo("story_main_view_-1947114781")
	self._txtName = self:getText("story_main_view_-20966836")
	self._txtContent = self:getText("story_main_view_-127815759")
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	self:registerLocalNotify(StoryNotifyName.HideUIByManual, self._OnHideUIByManual, self)
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogEnter, self.OnShowDialog, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIDialogExit, self.OnDialogExit, self)
	self:unregisterLocalNotify(StoryNotifyName.HideUIByManual, self._OnHideUIByManual, self)
end

function M:_OnHideUIByManual(evt, isHide)
	if not goutil.isNil(self._introPanel) and self._isShow then
		goutil.setActive(self._introPanel, not isHide)
	end
end

function M:OnShowDialog(_, data)
	local _dialogType = data.dialogType

	if _dialogType == StoryConstDef.EStoryDialogUIStyleType.Intro then
		StoryFacde.instance:showAll(StoryConst.DefaultStateKey)

		self._txtName.text = data.content
		self._txtContent.text = data.content2
		self._isShow = true

		goutil.setActive(self._introPanel, true)
	end
end

function M:OnDialogExit(evt, data)
	if not data then
		return
	end

	local _dialogType = data.dialogType

	if _dialogType == StoryConstDef.EStoryDialogUIStyleType.Intro then
		self:_hideIntroAndTryNext()
	end
end

function M:_hideIntroAndTryNext()
	self._isShow = false

	goutil.setActive(self._introPanel, false)
end

function M:destroyUI()
	return
end

return M
