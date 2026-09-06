-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/view/GodDiShiTianScoreView.lua

module("logic.extensions.goddishitian.view.GodDiShiTianScoreView", package.seeall)

local GodDiShiTianScoreView = class("GodDiShiTianScoreView", ViewComponent)

function GodDiShiTianScoreView:ctor()
	GodDiShiTianScoreView.super.ctor(self)
end

function GodDiShiTianScoreView:buildUI()
	GodDiShiTianScoreView.super.buildUI(self)

	self._btnOk = self:getBtn("btnOk")
	self._btnCancel = self:getBtn("btnCancel")
	self._txtOldScore = self:getTxt("score/oldTxt")
	self._txtNewScore = self:getTxt("score/newTxt")
end

function GodDiShiTianScoreView:bindEvents()
	GodDiShiTianScoreView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
end

function GodDiShiTianScoreView:unbindEvents()
	GodDiShiTianScoreView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function GodDiShiTianScoreView:onEnter()
	GodDiShiTianScoreView.super.onEnter(self)

	local param = self:getOpenParam()

	self._battleStageId = param[3]
	self._txtOldScore.text = param[1]
	self._txtNewScore.text = param[2]
end

function GodDiShiTianScoreView:onExit()
	GodDiShiTianScoreView.super.onExit(self)
end

function GodDiShiTianScoreView:_onClickOk()
	GodDiShiTianAgent.instance:sendPM_GodDiShiTianSetScoreReq(self._battleStageId)
	self:close()
end

function GodDiShiTianScoreView:_onClickCancel()
	self:close()
end

return GodDiShiTianScoreView
