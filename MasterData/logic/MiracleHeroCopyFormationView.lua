-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyFormationView.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyFormationView", package.seeall)

local MiracleHeroCopyFormationView = class("MiracleHeroCopyFormationView", MiracleHeroFormationView)

function MiracleHeroCopyFormationView:ctor()
	MiracleHeroCopyFormationView.super.ctor(self)
end

function MiracleHeroCopyFormationView:unbindEvents()
	MiracleHeroCopyFormationView.super.unbindEvents(self)
end

function MiracleHeroCopyFormationView:bindEvents()
	MiracleHeroCopyFormationView.super.bindEvents(self)
end

function MiracleHeroCopyFormationView:buildUI()
	MiracleHeroCopyFormationView.super.buildUI(self)
end

function MiracleHeroCopyFormationView:onExit()
	MiracleHeroCopyFormationView.super.onExit(self)
end

function MiracleHeroCopyFormationView:onEnter()
	MiracleHeroCopyFormationView.super.onEnter(self)
end

function MiracleHeroCopyFormationView:_getBattleViewName()
	return ViewName.MiracleHeroCopyBattleView
end

function MiracleHeroCopyFormationView:_jumpToMyTeamView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroCopyMyTeamView, ...)
end

return MiracleHeroCopyFormationView
