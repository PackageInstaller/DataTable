-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelDetailView.lua

module("logic.extensions.timewheel.view.TimeWheelDetailView", package.seeall)

local TimeWheelDetailView = class("TimeWheelDetailView", ViewComponent)

function TimeWheelDetailView:ctor()
	TimeWheelDetailView.super.ctor(self)
end

function TimeWheelDetailView:buildUI()
	TimeWheelDetailView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._title = {}
	self._desc = {}

	for i = 1, 3 do
		local go = self:getGo("point" .. i)

		self._title[i] = goutil.findChildTextComponent(go, "title")
		self._desc[i] = goutil.findChildTextComponent(go, "desc")
	end
end

function TimeWheelDetailView:destroyUI()
	TimeWheelDetailView.super.destroyUI(self)
end

function TimeWheelDetailView:bindEvents()
	TimeWheelDetailView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function TimeWheelDetailView:unbindEvents()
	TimeWheelDetailView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function TimeWheelDetailView:onEnter()
	TimeWheelDetailView.super.onEnter(self)

	for i = 1, 3 do
		local cfg = TimeWheelConfig.instance:getExplainCfg(i)

		if cfg then
			self._title[i].text = cfg.titleName
			self._desc[i].text = cfg.content
		end
	end
end

function TimeWheelDetailView:onExit()
	TimeWheelDetailView.super.onExit(self)
end

function TimeWheelDetailView:_onClickClose()
	self:close()
end

return TimeWheelDetailView
