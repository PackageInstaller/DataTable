-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaResultView.lua

module("logic.extensions.fruitninja.view.FruitNinjaResultView", package.seeall)

local FruitNinjaResultView = class("FruitNinjaResultView", ViewComponent)

function FruitNinjaResultView:buildUI()
	FruitNinjaResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtMaxScore = self:getTxt("txtMaxScore")
	self._txtCurScore = self:getTxt("txtCurScore")
end

function FruitNinjaResultView:bindEvents()
	FruitNinjaResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FruitNinjaResultView:unbindEvents()
	FruitNinjaResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FruitNinjaResultView:onEnter()
	FruitNinjaResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = FruitNinjaController.instance:getActivityType()

	local isInTime = FruitNinjaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._txtMaxScore.text = 0
	self._txtCurScore.text = 0
end

function FruitNinjaResultView:onExit()
	FruitNinjaResultView.super.onExit(self)
end

return FruitNinjaResultView
