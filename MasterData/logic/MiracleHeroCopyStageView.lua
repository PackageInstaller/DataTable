-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyStageView.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyStageView", package.seeall)

local MiracleHeroCopyStageView = class("MiracleHeroCopyStageView", MiracleHeroStageView)

function MiracleHeroCopyStageView:ctor()
	MiracleHeroCopyStageView.super.ctor(self)
end

function MiracleHeroCopyStageView:unbindEvents()
	MiracleHeroCopyStageView.super.unbindEvents(self)
end

function MiracleHeroCopyStageView:bindEvents()
	MiracleHeroCopyStageView.super.bindEvents(self)
end

function MiracleHeroCopyStageView:buildUI()
	MiracleHeroCopyStageView.super.buildUI(self)
end

function MiracleHeroCopyStageView:onExit()
	MiracleHeroCopyStageView.super.onExit(self)
end

function MiracleHeroCopyStageView:onEnter()
	MiracleHeroCopyStageView.super.onEnter(self)
end

function MiracleHeroCopyStageView:_jumpToFormationView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroCopyFormationView, ...)
end

return MiracleHeroCopyStageView
