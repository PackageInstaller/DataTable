-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticeruleView.lua

module("logic.extensions.justice.view.JusticeruleView", package.seeall)

local JusticeruleView = class("JusticeruleView", HuoqilinruleView)

function JusticeruleView:ctor()
	JusticeruleView.super.ctor(self)
end

function JusticeruleView:unbindEvents()
	JusticeruleView.super.unbindEvents(self)
end

function JusticeruleView:bindEvents()
	JusticeruleView.super.bindEvents(self)
end

function JusticeruleView:buildUI()
	JusticeruleView.super.buildUI(self)
end

function JusticeruleView:onExit()
	JusticeruleView.super.onExit(self)
end

function JusticeruleView:onEnter()
	JusticeruleView.super.onEnter(self)
end

return JusticeruleView
