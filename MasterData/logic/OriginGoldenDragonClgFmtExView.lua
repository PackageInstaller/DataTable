-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgFmtExView.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgFmtExView", package.seeall)

local OriginGoldenDragonClgFmtExView = class("OriginGoldenDragonClgFmtExView", ViewComponent)

function OriginGoldenDragonClgFmtExView:ctor()
	OriginGoldenDragonClgFmtExView.super.ctor(self)
end

function OriginGoldenDragonClgFmtExView:unbindEvents()
	OriginGoldenDragonClgFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSelect)
end

function OriginGoldenDragonClgFmtExView:bindEvents()
	OriginGoldenDragonClgFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSelect, GameUtil.handler(self._onClickBtnSelect, self))
end

function OriginGoldenDragonClgFmtExView:buildUI()
	OriginGoldenDragonClgFmtExView.super.buildUI(self)

	self._btnSelect = self:getGo("btnSelect")
	self._txtTopDesc = self:getTxt("topDesc/txt")
	self._txtName = self:getTxt("btnSelect/txtName")
end

function OriginGoldenDragonClgFmtExView:onExit()
	OriginGoldenDragonClgFmtExView.super.onExit(self)
end

function OriginGoldenDragonClgFmtExView:onEnter()
	OriginGoldenDragonClgFmtExView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginGoldenDragonClgChangeProphecyId, self._onProphecyIdChanged, self)

	self._fmtMo = self:getFirstParam()

	if self._fmtMo == nil then
		printError("OriginGoldenDragonClgFmtExView:onEnter fmtMo is nil")
		self:close()

		return
	end

	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()

	self:_onProphecyIdChanged()
end

function OriginGoldenDragonClgFmtExView:_onProphecyIdChanged()
	local prophecyId = OriginGoldenDragonClgController.instance:getCurSelectProphecyId()
	local prophecyCfg = OriginGoldenDragonClgConfig.instance:getProphecyCfgById(self._activityId, prophecyId)

	if prophecyCfg then
		self._txtTopDesc.text = prophecyCfg.fmtTips or ""
	end

	if prophecyCfg then
		self._txtName.text = prophecyCfg.name or ""
	end
end

function OriginGoldenDragonClgFmtExView:_onClickBtnSelect()
	UIStateManager.instance:push(ViewName.OriginGoldenDragonClgSelectView, self._activityId, self._stageId, true)
end

return OriginGoldenDragonClgFmtExView
