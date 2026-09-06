-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexuanmingtianlong/view/DivinexuanmingtianlongposView.lua

module("logic.extensions.divinexuanmingtianlong.view.DivinexuanmingtianlongposView", package.seeall)

local DivinexuanmingtianlongposView = class("DivinexuanmingtianlongposView", FanRuiChallengePosView)

function DivinexuanmingtianlongposView:ctor()
	DivinexuanmingtianlongposView.super.ctor(self)
end

function DivinexuanmingtianlongposView:unbindEvents()
	DivinexuanmingtianlongposView.super.unbindEvents(self)
end

function DivinexuanmingtianlongposView:bindEvents()
	DivinexuanmingtianlongposView.super.bindEvents(self)
end

function DivinexuanmingtianlongposView:buildUI()
	DivinexuanmingtianlongposView.super.buildUI(self)
end

function DivinexuanmingtianlongposView:onExit()
	DivinexuanmingtianlongposView.super.onExit(self)
end

function DivinexuanmingtianlongposView:onEnter()
	DivinexuanmingtianlongposView.super.onEnter(self)
end

function DivinexuanmingtianlongposView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivinexuanmingtianlongforecastView, self._creepsMasterId)
end

return DivinexuanmingtianlongposView
