-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvBlackMaskView.lua

module("logic.extensions.domainadventure.view.DomAdvBlackMaskView", package.seeall)

local DomAdvBlackMaskView = class("DomAdvBlackMaskView", ViewComponent)

function DomAdvBlackMaskView:ctor()
	DomAdvBlackMaskView.super.ctor(self)
end

function DomAdvBlackMaskView:buildUI()
	DomAdvBlackMaskView.super.buildUI(self)
end

function DomAdvBlackMaskView:bindEvents()
	DomAdvBlackMaskView.super.bindEvents(self)
end

function DomAdvBlackMaskView:unbindEvents()
	DomAdvBlackMaskView.super.unbindEvents(self)
end

function DomAdvBlackMaskView:onEnter()
	DomAdvBlackMaskView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._storyId = checknumber(params[1])
	self._callBack = params[2]

	self.addGEvent(self, GlobalNotify.EndStory, self._onEndStory, self)
	GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._storyId, StoryModel.StoryType.SCCopy)
end

function DomAdvBlackMaskView:onExit()
	DomAdvBlackMaskView.super.onExit(self)
end

function DomAdvBlackMaskView:_onEndStory(storyId, isAllEnd)
	if not isAllEnd then
		return
	end

	if self._storyId ~= storyId then
		return
	end

	self:_finishCallBack()
end

function DomAdvBlackMaskView:_finishCallBack()
	GameUtil.callBack(self._callBack)
end

return DomAdvBlackMaskView
