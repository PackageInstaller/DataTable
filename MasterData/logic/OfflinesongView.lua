-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinesongView.lua

module("logic.extensions.offline.view.OfflinesongView", package.seeall)

local OfflinesongView = class("OfflinesongView", OfflineBaseView)

function OfflinesongView:ctor()
	OfflinesongView.super.ctor(self)
end

function OfflinesongView:unbindEvents()
	OfflinesongView.super.unbindEvents(self)
end

function OfflinesongView:bindEvents()
	OfflinesongView.super.bindEvents(self)
end

function OfflinesongView:buildUI()
	OfflinesongView.super.buildUI(self)
end

function OfflinesongView:onExit()
	OfflinesongView.super.onExit(self)
end

function OfflinesongView:onEnter()
	OfflinesongView.super.onEnter(self)
end

return OfflinesongView
