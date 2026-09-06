-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/MiraclearuishimainView.lua

module("logic.extensions.xiunuobrotherhood.view.copy.MiraclearuishimainView", package.seeall)

local MiraclearuishimainView = class("MiraclearuishimainView", XiuNuoBrotherhoodMainView)

function MiraclearuishimainView:ctor()
	self._selectViewName = ViewName.MiraclearuishiselectView
end

function MiraclearuishimainView:buildUI()
	MiraclearuishimainView.super.buildUI(self)

	self._btnQuanEFan = self:getBtn("btnQuanEFan")
	self._btnTehui = self:getBtn("btnTehui")
end

function MiraclearuishimainView:bindEvents()
	MiraclearuishimainView.super.bindEvents(self)
	self._btnQuanEFan:AddClickListener(self._onClickbtnQuanEFan, self)
	self._btnTehui:AddClickListener(self._onClickbtnTehui, self)
end

function MiraclearuishimainView:unbindEvents()
	MiraclearuishimainView.super.unbindEvents(self)
	self._btnQuanEFan:RemoveClickListener()
	self._btnTehui:RemoveClickListener()
end

function MiraclearuishimainView:initData()
	self._activityId = 208003
	self._actCfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(self._activityId)
end

function MiraclearuishimainView:_setJumpViewNames()
	XiuNuoBrotherhoodModel.instance.instance:setJumpViewNames(ViewName.MiraclearuishimainView, nil, ViewName.MiraclearuishigameView)
end

function MiraclearuishimainView:_onClickbtnQuanEFan()
	GotoMgr.gotoByString(self._actCfg.params.btnQuanEFanJump)
end

function MiraclearuishimainView:_onClickbtnTehui()
	GotoMgr.gotoByString(self._actCfg.params.btnTehuiJump)
end

return MiraclearuishimainView
