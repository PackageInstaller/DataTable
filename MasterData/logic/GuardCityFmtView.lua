-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityFmtView.lua

module("logic.extensions.guardcity.view.GuardCityFmtView", package.seeall)

local GuardCityFmtView = class("GuardCityFmtView", ViewComponent)

function GuardCityFmtView:buildUI()
	GuardCityFmtView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
end

function GuardCityFmtView:bindEvents()
	GuardCityFmtView.super.bindEvents(self)

	self._txtCost = self:getTxt("limit/txtCost")
end

function GuardCityFmtView:unbindEvents()
	GuardCityFmtView.super.unbindEvents(self)
end

function GuardCityFmtView:onEnter()
	GuardCityFmtView.super.onEnter(self)

	local params = self:getFirstParam()
	local isPowerful = params._isPowerful
	local cost = GuardCityConfig.instance:getCommonValue("CHALLENGE_STRENGTH_COST", true)

	if isPowerful == true then
		cost = math.ceil(cost * GuardCityConfig.instance:getCommonValue("STRONG_CHALLENGE_COST_MULTIPLE", true))
	end

	self._txtCost.text = cost
end

function GuardCityFmtView:onExit()
	GuardCityFmtView.super.onExit(self)
end

return GuardCityFmtView
