-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanextView.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanextView", package.seeall)

local DivinewatertianyanextView = class("DivinewatertianyanextView", ViewComponent)

function DivinewatertianyanextView:ctor()
	DivinewatertianyanextView.super.ctor(self)
end

function DivinewatertianyanextView:unbindEvents()
	DivinewatertianyanextView.super.unbindEvents(self)
	self._btnProtocal:RemoveClickListener()
end

function DivinewatertianyanextView:bindEvents()
	DivinewatertianyanextView.super.bindEvents(self)
	self._btnProtocal:AddClickListener(self._onClickbtnProtocol, self)
end

function DivinewatertianyanextView:buildUI()
	DivinewatertianyanextView.super.buildUI(self)

	self._btnProtocal = self:getBtn("btnProtocal")
	self._txtDesc = self:getTxt("bg/txtDesc")
end

function DivinewatertianyanextView:onExit()
	DivinewatertianyanextView.super.onExit(self)
end

function DivinewatertianyanextView:onEnter()
	DivinewatertianyanextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._stageType = self._fmtMo:getStageType()
	self._isFire = self._stageType == DivinewatertianyanController.StageType.Fire

	goutil.setActive(self._btnProtocal.gameObject, not self._isFire)

	local stageCfg = self._fmtMo:getStageCfg()

	self._txtDesc.text = stageCfg.missionTips
end

function DivinewatertianyanextView:_onClickbtnProtocol()
	UIStateManager.instance:push(ViewName.DivinewatertianyanprotocolView, self._fmtMo:getActId())
end

return DivinewatertianyanextView
