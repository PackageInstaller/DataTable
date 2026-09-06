-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/remembertheater/view/RememberTheaterView.lua

module("logic.extensions.remembertheater.view.RememberTheaterView", package.seeall)

local RememberTheaterView = class("RememberTheaterView", ViewComponent)

function RememberTheaterView:ctor()
	RememberTheaterView.super.ctor(self)

	self._activityStartTime = 0
	self._activityEndTime = 0
end

function RememberTheaterView:buildUI()
	RememberTheaterView.super.buildUI(self)

	self._activityTimeTxt = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._closeBtn = self:getBtn("btnClose")
end

function RememberTheaterView:destroyUI()
	RememberTheaterView.super.destroyUI(self)
end

function RememberTheaterView:bindEvents()
	RememberTheaterView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function RememberTheaterView:unbindEvents()
	RememberTheaterView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function RememberTheaterView:onEnter()
	RememberTheaterView.super.onEnter(self)

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(587)
	local params = string.split(cfg.openTime, "#")
	local timeParams = "%d+%-0?(%d+)%-0?(%d+) 0?(%d+):(%d+):(%d+)"
	local month, date, hour, min

	_, _, month, date, hour, min = string.find(params[1], timeParams)
	self._activityStartTime = string.format("%s.%s %s:%s", month, date, hour, min)
	_, _, month, date, hour, min = string.find(params[2], timeParams)
	self._activityEndTime = string.format("%s.%s %s:%s", month, date, hour, min)
	self._activityTimeTxt.text = string.format("活动时间：%s-%s", self._activityStartTime, self._activityEndTime)
end

return RememberTheaterView
