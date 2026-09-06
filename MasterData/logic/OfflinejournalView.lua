-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinejournalView.lua

module("logic.extensions.offline.view.OfflinejournalView", package.seeall)

local OfflinejournalView = class("OfflinejournalView", OfflineBaseView)

function OfflinejournalView:ctor()
	OfflinejournalView.super.ctor(self)
end

function OfflinejournalView:unbindEvents()
	OfflinejournalView.super.unbindEvents(self)
end

function OfflinejournalView:bindEvents()
	OfflinejournalView.super.bindEvents(self)
end

function OfflinejournalView:buildUI()
	OfflinejournalView.super.buildUI(self)
end

function OfflinejournalView:onExit()
	OfflinejournalView.super.onExit(self)
end

function OfflinejournalView:onEnter()
	OfflinejournalView.super.onEnter(self)
end

return OfflinejournalView
