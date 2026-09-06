-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinenoticeView.lua

module("logic.extensions.offline.view.OfflinenoticeView", package.seeall)

local OfflinenoticeView = class("OfflinenoticeView", OfflineBaseView)

function OfflinenoticeView:ctor()
	OfflinenoticeView.super.ctor(self)
end

function OfflinenoticeView:unbindEvents()
	OfflinenoticeView.super.unbindEvents(self)
end

function OfflinenoticeView:bindEvents()
	OfflinenoticeView.super.bindEvents(self)
end

function OfflinenoticeView:buildUI()
	OfflinenoticeView.super.buildUI(self)

	self._txtContent = self:getTxt("ScorllView/Viewport/Content")
end

function OfflinenoticeView:onExit()
	OfflinenoticeView.super.onExit(self)
end

function OfflinenoticeView:onEnter()
	OfflinenoticeView.super.onEnter(self)

	self._txtContent.text = self.data.content
end

return OfflinenoticeView
