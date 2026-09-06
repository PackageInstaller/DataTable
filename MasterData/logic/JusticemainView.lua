-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticemainView.lua

module("logic.extensions.justice.view.JusticemainView", package.seeall)

local JusticemainView = class("JusticemainView", HuoqilinmainView)

function JusticemainView:ctor()
	JusticemainView.super.ctor(self)

	self._HUOQILIN_CHALLENGEID = "JUSTICE_CHALLENGEID"
	self._HUOQILIN_TITLE = "JUSTICE_TITLE"
	self._HUOQILIN_ACTIVITY_TIME = "JUSTICE_ACTIVITY_TIME"
	self._HUOQILIN_SKIN_ID = "JUSTICE_SKIN_ID"
	self._HUOQILIN_ITEMS = "JUSTICE_ITEMS"
	self._HUOQILIN_LOTTERY_JUMP = "JUSTICE_LOTTERY_JUMP"
	self._HUOQILIN_RANK_JUMP = "JUSTICE_RANK_JUMP"
	self._HUOQILIN_YANGCHENG_JUMP = "JUSTICE_YANGCHENG_JUMP"
	self._HUOQILIN_REBATE_JUMP = "JUSTICE_REBATE_JUMP"
end

function JusticemainView:unbindEvents()
	JusticemainView.super.unbindEvents(self)
end

function JusticemainView:bindEvents()
	JusticemainView.super.bindEvents(self)
end

function JusticemainView:buildUI()
	JusticemainView.super.buildUI(self)
end

function JusticemainView:onExit()
	JusticemainView.super.onExit(self)
end

function JusticemainView:onEnter()
	JusticemainView.super.onEnter(self)
end

return JusticemainView
