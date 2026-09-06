-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinepvView.lua

module("logic.extensions.offline.view.OfflinepvView", package.seeall)

local OfflinepvView = class("OfflinepvView", OfflineBaseView)

function OfflinepvView:ctor()
	OfflinepvView.super.ctor(self)
end

function OfflinepvView:unbindEvents()
	OfflinepvView.super.unbindEvents(self)
end

function OfflinepvView:bindEvents()
	OfflinepvView.super.bindEvents(self)
end

function OfflinepvView:buildUI()
	OfflinepvView.super.buildUI(self)
end

function OfflinepvView:onExit()
	OfflinepvView.super.onExit(self)
end

function OfflinepvView:onEnter()
	OfflinepvView.super.onEnter(self)
end

return OfflinepvView
