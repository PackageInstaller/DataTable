-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originguangmingwang/view/OriginGuangMingWangMainView.lua

module("logic.extensions.originguangmingwang.view.OriginGuangMingWangMainView", package.seeall)

local OriginGuangMingWangMainView = class("OriginGuangMingWangMainView", OriginDiShiTianMainView)

function OriginGuangMingWangMainView:ctor()
	OriginGuangMingWangMainView.super.ctor(self)
end

function OriginGuangMingWangMainView:unbindEvents()
	OriginGuangMingWangMainView.super.unbindEvents(self)
end

function OriginGuangMingWangMainView:bindEvents()
	OriginGuangMingWangMainView.super.bindEvents(self)
end

function OriginGuangMingWangMainView:buildUI()
	OriginGuangMingWangMainView.super.buildUI(self)
end

function OriginGuangMingWangMainView:onExit()
	OriginGuangMingWangMainView.super.onExit(self)
end

function OriginGuangMingWangMainView:onEnter()
	OriginGuangMingWangMainView.super.onEnter(self)
end

function OriginGuangMingWangMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.OriginGuangMingWangStageView, self._activityId)
end

function OriginGuangMingWangMainView:_onClickTip()
	TipsFacade.instance:openRulesView("origin_guang_ming_wang_rule")
end

return OriginGuangMingWangMainView
