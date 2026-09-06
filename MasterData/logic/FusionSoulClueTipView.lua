-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulClueTipView.lua

module("logic.extensions.fusionsoul.view.FusionSoulClueTipView", package.seeall)

local FusionSoulClueTipView = class("FusionSoulClueTipView", ViewComponent)

function FusionSoulClueTipView:ctor()
	FusionSoulClueTipView.super.ctor(self)
end

function FusionSoulClueTipView:unbindEvents()
	FusionSoulClueTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function FusionSoulClueTipView:bindEvents()
	FusionSoulClueTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
end

function FusionSoulClueTipView:buildUI()
	FusionSoulClueTipView.super.buildUI(self)

	self._btnClose = self:getGo("Nego_Main/Btn_Close")
	self._btnSure = self:getGo("Nego_Main/Btns/Btn1")
	self._btnCancel = self:getGo("Nego_Main/Btns/Btn2")
	self._txtDesc = self:getTxt("Nego_Main/ScrollView/Viewport/Content")
	self._txtName = self:getTxt("Nego_Main/Txt_Title")
end

function FusionSoulClueTipView:onExit()
	FusionSoulClueTipView.super.onExit(self)
end

function FusionSoulClueTipView:onEnter()
	FusionSoulClueTipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._clueId = checknumber(params[2])
	self._isShowOnly = checkbool(params[3])

	local clueCfg = FusionSoulConfig.instance:getClueCfg(self._activityId, self._clueId)

	self._txtName.text = clueCfg.name
	self._txtDesc.text = clueCfg.desc

	GameUtil.SetActive(self._btnSure, not self._isShowOnly)
	GameUtil.SetActive(self._btnCancel, not self._isShowOnly)
end

function FusionSoulClueTipView:_onClickSure()
	GlobalDispatcher:dispatch(GlobalNotify.FusionSoulAddTip, self._clueId)
	self:close()
end

return FusionSoulClueTipView
