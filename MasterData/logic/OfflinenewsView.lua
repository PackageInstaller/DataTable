-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinenewsView.lua

module("logic.extensions.offline.view.OfflinenewsView", package.seeall)

local OfflinenewsView = class("OfflinenewsView", OfflineBaseView)

function OfflinenewsView:ctor()
	OfflinenewsView.super.ctor(self)
end

function OfflinenewsView:unbindEvents()
	OfflinenewsView.super.unbindEvents(self)
end

function OfflinenewsView:bindEvents()
	OfflinenewsView.super.bindEvents(self)
end

function OfflinenewsView:buildUI()
	OfflinenewsView.super.buildUI(self)
end

function OfflinenewsView:onExit()
	OfflinenewsView.super.onExit(self)
end

function OfflinenewsView:onEnter()
	OfflinenewsView.super.onEnter(self)
end

return OfflinenewsView
