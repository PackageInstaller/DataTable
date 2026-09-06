-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/ChallengecardView.lua

module("logic.extensions.monthcard.view.ChallengecardView", package.seeall)

local ChallengecardView = class("ChallengecardView", WeekCardBaseView)

function ChallengecardView:ctor()
	ChallengecardView.super.ctor(self)
end

function ChallengecardView:buildUI()
	ChallengecardView.super.buildUI(self)
end

function ChallengecardView:bindEvents()
	ChallengecardView.super.bindEvents(self)
end

function ChallengecardView:unbindEvents()
	ChallengecardView.super.unbindEvents(self)
end

function ChallengecardView:destroyUI()
	ChallengecardView.super.destroyUI(self)
end

function ChallengecardView:onEnter()
	ChallengecardView.super.onEnter(self)
end

function ChallengecardView:onEnterFinished()
	ChallengecardView.super.onEnterFinished(self)
end

function ChallengecardView:onExit()
	ChallengecardView.super.onExit(self)
end

function ChallengecardView:onExitFinished()
	ChallengecardView.super.onExitFinished(self)
end

function ChallengecardView:_getCardId()
	return 4
end

function ChallengecardView:_getCanActiveDayColor()
	return "#00FF21"
end

function ChallengecardView:_getEffectName()
	return "fx_ui_shangchengyouhua/fx_ui_shangcheng01_maoxianka.prefab"
end

return ChallengecardView
