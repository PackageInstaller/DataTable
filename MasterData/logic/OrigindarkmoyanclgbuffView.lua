-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgbuffView.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgbuffView", package.seeall)

local OrigindarkmoyanclgbuffView = class("OrigindarkmoyanclgbuffView", ViewComponent)

function OrigindarkmoyanclgbuffView:ctor()
	OrigindarkmoyanclgbuffView.super.ctor(self)
end

function OrigindarkmoyanclgbuffView:unbindEvents()
	OrigindarkmoyanclgbuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function OrigindarkmoyanclgbuffView:bindEvents()
	OrigindarkmoyanclgbuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function OrigindarkmoyanclgbuffView:buildUI()
	OrigindarkmoyanclgbuffView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._txtBuff = self:getTxt("txtBuff")
end

function OrigindarkmoyanclgbuffView:onExit()
	OrigindarkmoyanclgbuffView.super.onExit(self)
end

function OrigindarkmoyanclgbuffView:onEnter()
	OrigindarkmoyanclgbuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._x = checknumber(params[3])
	self._y = checknumber(params[4])

	local cellCfg = OrigindarkmoyanclgConfig.instance:getCellCfg(self._activityId, self._stageId, self._x, self._y)

	self._txtBuff.text = cellCfg.buffDesc
end

function OrigindarkmoyanclgbuffView:_onClickSure()
	local data = OrigindarkmoyanclgModel.instance:getCellData(self._activityId, self._stageId, self._x, self._y)

	if not data then
		OriginDarkMoYanClgAgent.instance:sendPM_OriginDarkMoYanClgSelectBuffCellReq(self._activityId, self._stageId, self._x, self._y)
	end

	self:close()
end

return OrigindarkmoyanclgbuffView
