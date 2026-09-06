-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpSweepEventView.lua

module("logic.extensions.expedition.view.ExpSweepEventView", package.seeall)

local ExpSweepEventView = class("ExpSweepEventView", ViewComponent)

function ExpSweepEventView:buildUI()
	ExpSweepEventView.super.buildUI(self)

	self._closeButton = self:getBtn("sweepNode/btnClose")
	self._cancelButton = self:getBtn("sweepNode/btnCancel")
	self._sureButton = self:getBtn("sweepNode/btnSure")
	self._maskButton = self:getBtn("bgButton")
	self._txtContent = self:getTxt("sweepNode/txtContent")
	self._btnAll = self:getGo("sweepNode/btnAll")
	self._btnSure = self:getGo("sweepNode/btnSure")
end

function ExpSweepEventView:destroyUI()
	ExpSweepEventView.super.destroyUI(self)
end

function ExpSweepEventView:onExitFinished()
	ExpSweepEventView.super.onExitFinished(self)
end

function ExpSweepEventView:onEnterFinished()
	ExpSweepEventView.super.onEnterFinished(self)
end

function ExpSweepEventView:unbindEvents()
	ExpSweepEventView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._maskButton:RemoveClickListener()
	self._sureButton:RemoveClickListener()
	self._cancelButton:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnAll)
end

function ExpSweepEventView:bindEvents()
	ExpSweepEventView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._maskButton:AddClickListener(self._onClickClose, self)
	self._cancelButton:AddClickListener(self._onClickClose, self)
	self._sureButton:AddClickListener(self._onClickSure, self)
	GameUtil.addClickHandler(self._btnAll, self._OnClickAll, self)
end

function ExpSweepEventView:onExit()
	ExpSweepEventView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnExpedSweepLevel, self._onExpedSweepLevel, self)
end

function ExpSweepEventView:onEnter()
	ExpSweepEventView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnExpedSweepLevel, self._onExpedSweepLevel, self)
	self.addGEvent(self, GlobalNotify.OnExpedOneKeySweep, self._onExpedSweepLevel, self)

	local info = ExpeditionModel.instance:getInfo()

	if info and info.level then
		self._level = info.level + 1 or 1
	end

	local curLevelCfg = ExpeditionConfig.instance:getNextLevelCo(checkint(self._level))

	GameUtil.SetActive(self._btnAll, false)
	GameUtil.setAnchoredPos(self._btnSure, 240, -188)

	self._txtContent.text = langPara("是否快速扫荡%s全部战斗？\n（圣器与事件在扫荡后选择）", curLevelCfg.levelName)

	if GoldenDiamondCardModel.instance.isUser == true and curLevelCfg and curLevelCfg.level <= GoldenDiamondCardConfig.instance:getPrivilegeDefaultValue(GoldenDiamondCardModel.PrivilegeType.ExpMapSweepLevel) then
		GameUtil.SetActive(self._btnAll, true)
		GameUtil.setAnchoredPos(self._btnSure, 0, -188)

		self._txtContent.text = "是否进行快速扫荡？\n扫荡一层：扫荡后需要选择圣器与事件\n扫荡所有层：直接进行奖励结算"
	end
end

function ExpSweepEventView:_onClickClose()
	self:close()
end

function ExpSweepEventView:_onClickSure()
	ExpeditionAgent.instance:sendPM_ExpeditionSweepLevelReq()
end

function ExpSweepEventView:_OnClickAll()
	ExpeditionAgent.instance:sendPM_ExpeditionOneKeySweepReq()
end

function ExpSweepEventView:_onExpedSweepLevel()
	self:close()
end

return ExpSweepEventView
