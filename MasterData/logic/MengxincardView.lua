-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MengxincardView.lua

module("logic.extensions.monthcard.view.MengxincardView", package.seeall)

local MengxincardView = class("MengxincardView", WeekCardBaseView)

function MengxincardView:ctor()
	MengxincardView.super.ctor(self)
end

function MengxincardView:buildUI()
	MengxincardView.super.buildUI(self)
end

function MengxincardView:bindEvents()
	MengxincardView.super.bindEvents(self)
end

function MengxincardView:unbindEvents()
	MengxincardView.super.unbindEvents(self)
end

function MengxincardView:destroyUI()
	MengxincardView.super.destroyUI(self)
end

function MengxincardView:onEnter()
	MengxincardView.super.onEnter(self)
end

function MengxincardView:onEnterFinished()
	MengxincardView.super.onEnterFinished(self)
end

function MengxincardView:onExit()
	MengxincardView.super.onExit(self)
end

function MengxincardView:onExitFinished()
	MengxincardView.super.onExitFinished(self)
end

function MengxincardView:_getCardId()
	return 5
end

function MengxincardView:_getCanActiveDayColor()
	return "#00FF21"
end

function MengxincardView:_getEffectName()
	return "fx_ui_shangchengyouhua/fx_ui_shangcheng02_mengxinka.prefab"
end

return MengxincardView
