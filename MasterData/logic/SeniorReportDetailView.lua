-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorReportDetailView.lua

module("logic.extensions.seniorarena.view.SeniorReportDetailView", package.seeall)

local SeniorReportDetailView = class("SeniorReportDetailView", TwoFormsBaseView)

function SeniorReportDetailView:unbindEvents()
	SeniorReportDetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SeniorReportDetailView:bindEvents()
	SeniorReportDetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function SeniorReportDetailView:onExit()
	SeniorReportDetailView.super.onExit(self)
end

function SeniorReportDetailView:buildUI()
	SeniorReportDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime")
end

function SeniorReportDetailView:onEnter()
	SeniorReportDetailView.super.onEnter(self)

	local params = self:getOpenParam()

	self._txtTime.text = params[4] or ""

	print("xxxenter SeniorReportDetailView")
end

function SeniorReportDetailView:_updateOneForms(cell, data)
	SeniorReportDetailView.super._updateOneForms(self, cell, data)

	local btnVideo = Framework.ButtonAdapter.GetFrom(cell, "btnVideo")

	btnVideo:AddClickListener(function()
		self:_onClickVideo(data.battleId)
	end)
end

function SeniorReportDetailView:_onClickVideo(battleId)
	if not SeniorArenaController.instance:getIsOpen(true) then
		return
	end

	print("click battleId = " .. battleId)
	UIJumper.instance:saveCurStack()
	Arena3v3Agent.instance:sendArena3v3VideoReq(battleId, self._viewSeniorVideo, self)
end

function SeniorReportDetailView:_viewSeniorVideo(msg)
	UIJumper.instance:pushOneStack(ViewName.SeniorArenaMainView, true)
	BattleFacade.instance:onViewUserFightMonsterBtlResult(msg.btlResult)
end

return SeniorReportDetailView
