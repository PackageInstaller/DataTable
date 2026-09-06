-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyMainView.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyMainView", package.seeall)

local MiracleHeroCopyMainView = class("MiracleHeroCopyMainView", MiracleHeroMainView)

function MiracleHeroCopyMainView:ctor()
	MiracleHeroCopyMainView.super.ctor(self)
end

function MiracleHeroCopyMainView:unbindEvents()
	MiracleHeroCopyMainView.super.unbindEvents(self)
end

function MiracleHeroCopyMainView:bindEvents()
	MiracleHeroCopyMainView.super.bindEvents(self)
end

function MiracleHeroCopyMainView:buildUI()
	MiracleHeroCopyMainView.super.buildUI(self)
end

function MiracleHeroCopyMainView:onExit()
	MiracleHeroCopyMainView.super.onExit(self)
end

function MiracleHeroCopyMainView:onEnter()
	MiracleHeroCopyMainView.super.onEnter(self)
end

function MiracleHeroCopyMainView:_jumpStageView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroCopyStageView, ...)
end

function MiracleHeroCopyMainView:_jumpMyTeamView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroCopyMyTeamView, ...)
end

return MiracleHeroCopyMainView
