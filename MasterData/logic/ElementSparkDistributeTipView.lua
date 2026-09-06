-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkDistributeTipView.lua

module("logic.extensions.elementspark.view.ElementSparkDistributeTipView", package.seeall)

local ElementSparkDistributeTipView = class("ElementSparkDistributeTipView", ViewComponent)

function ElementSparkDistributeTipView:ctor()
	ElementSparkDistributeTipView.super.ctor(self)
end

function ElementSparkDistributeTipView:unbindEvents()
	ElementSparkDistributeTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTeam)
end

function ElementSparkDistributeTipView:bindEvents()
	ElementSparkDistributeTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
end

function ElementSparkDistributeTipView:buildUI()
	ElementSparkDistributeTipView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnTeam = self:getBtn("btnTeam")
	self._txtTime = self:getTxt("btnTeam/Text")
end

function ElementSparkDistributeTipView:onExit()
	ElementSparkDistributeTipView.super.onExit(self)
	removetimer(self._refresh, self)
	GameUtil.SetGray(self._btnTeam.gameObject, false)
	ElementSparkModel.instance:clearFirstOpenInfo()
end

function ElementSparkDistributeTipView:onEnter()
	ElementSparkDistributeTipView.super.onEnter(self)

	self._time = 5
	self._isCanClose = false

	settimer(1, self._refresh, self, true)
	GameUtil.SetGray(self._btnTeam.gameObject, true)

	self._txtTitle.text, self._txtDesc.text = ElementSparkController.instance:getDistributeDesc()
end

function ElementSparkDistributeTipView:_refresh()
	self._time = self._time - 1

	if self._time <= 0 then
		self._isCanClose = true

		GameUtil.SetGray(self._btnTeam.gameObject, false)
		removetimer(self._refresh, self)

		self._txtTime.text = "设置队伍"

		return
	end

	self._txtTime.text = string.format("设置队伍(%ds)", self._time)
end

function ElementSparkDistributeTipView:_onClickTeam()
	if self._isCanClose then
		UIStateManager.instance:push(ViewName.ElementSparkSetTeamView)
		self:close()
	end
end

return ElementSparkDistributeTipView
