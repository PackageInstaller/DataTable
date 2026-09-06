-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideMaskView.lua

module("logic.extensions.guide.view.GuideMaskView", package.seeall)

local GuideMaskView = class("GuideMaskView", GuideUIObjectBase)

function GuideMaskView:ctor()
	GuideMaskView.super.ctor(self)
end

function GuideMaskView:buildUI()
	GuideMaskView.super.buildUI(self)
end

function GuideMaskView:bindEvents()
	GuideMaskView.super.bindEvents(self)
end

function GuideMaskView:unbindEvents()
	GuideMaskView.super.unbindEvents(self)
end

function GuideMaskView:destroyUI()
	GuideMaskView.super.destroyUI(self)
end

function GuideMaskView:onEnter()
	GuideMaskView.super.onEnter(self)
end

function GuideMaskView:onEnterFinished()
	GuideMaskView.super.onEnterFinished(self)

	local params = self._currGuide:getJsonParams()

	settimer((params.delay or nil) and checknumber(params.delay), self.finishGuide, self, false)
end

function GuideMaskView:onExit()
	GuideMaskView.super.onExit(self)
	removetimer(self.finishGuide, self)
end

function GuideMaskView:onExitFinished()
	GuideMaskView.super.onExitFinished(self)
end

function GuideMaskView:finishGuide()
	removetimer(self.finishGuide, self)
	GuideController.instance:finishGuide()
end

return GuideMaskView
