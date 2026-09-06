-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/EndlessBattleStartView.lua

module("logic.extensions.battle.view.EndlessBattleStartView", package.seeall)

local EndlessBattleStartView = class("EndlessBattleStartView", ViewComponent)

function EndlessBattleStartView:unbindEvents()
	EndlessBattleStartView.super.unbindEvents(self)
end

function EndlessBattleStartView:bindEvents()
	EndlessBattleStartView.super.bindEvents(self)
end

function EndlessBattleStartView:onExit()
	EndlessBattleStartView.super.onExit(self)
end

function EndlessBattleStartView:buildUI()
	EndlessBattleStartView.super.buildUI(self)
end

function EndlessBattleStartView:onEnter()
	EndlessBattleStartView.super.onEnter(self)
end

function EndlessBattleStartView:_onClickClose()
	self:close()
end

return EndlessBattleStartView
