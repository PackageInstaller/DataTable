-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanconveytipView.lua

module("logic.extensions.richmanxplan.view.RmxplanconveytipView", package.seeall)

local RmxplanconveytipView = class("RmxplanconveytipView", ViewComponent)

function RmxplanconveytipView:ctor()
	RmxplanconveytipView.super.ctor(self)
end

function RmxplanconveytipView:unbindEvents()
	RmxplanconveytipView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function RmxplanconveytipView:bindEvents()
	RmxplanconveytipView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function RmxplanconveytipView:buildUI()
	RmxplanconveytipView.super.buildUI(self)

	self._btnCancel = self:getBtn("btns/btnCancel")
	self._btnSure = self:getBtn("btns/btnSure")
	self._txtDesc = self:getTxt("txtDesc")
end

function RmxplanconveytipView:onExit()
	RmxplanconveytipView.super.onExit(self)
end

function RmxplanconveytipView:onEnter()
	RmxplanconveytipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._conveyData = params[2]
	self._conveyCallBack = params[3]
	self._leftStep = self._conveyData.leftStepNum
	self._targetZoneId = self._conveyData.targetZoneId
	self._targetGridId = self._conveyData.targetGridId
	self._zoneCfg = RichmanxplanConfig.instance:getZoneCfg(self._activityId, self._targetZoneId)

	self:_updateUI()
end

function RmxplanconveytipView:_onClickbtnCancel()
	self:close()
	self._conveyCallBack(false)
end

function RmxplanconveytipView:_onClickbtnSure()
	self:close()
	self._conveyCallBack(true)
end

function RmxplanconveytipView:_updateUI()
	local gridCfg = RichmanxplanConfig.instance:getGridCfg(self._activityId, self._targetZoneId, self._targetGridId)
	local arr = string.split(gridCfg.convey, ",")
	local nextZoneId = checknumber(arr[1])
	local nextZoneCfg = RichmanxplanConfig.instance:getZoneCfg(self._activityId, nextZoneId)

	self._txtDesc.text = string.format("你步入了一道岔路口，做出选择吧！\n当前所在【%s】，是否前往【%s】？\n当前剩余%s步", self._zoneCfg.name, nextZoneCfg.name, self._leftStep)
end

return RmxplanconveytipView
