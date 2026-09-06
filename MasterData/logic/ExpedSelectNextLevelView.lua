-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpedSelectNextLevelView.lua

module("logic.extensions.expedition.view.ExpedSelectNextLevelView", package.seeall)

local ExpedSelectNextLevelView = class("ExpedSelectNextLevelView", ViewComponent)

function ExpedSelectNextLevelView:unbindEvents()
	ExpedSelectNextLevelView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
	self._bgMaskButton:RemoveClickListener()
	self._bgButton:RemoveClickListener()
end

function ExpedSelectNextLevelView:bindEvents()
	ExpedSelectNextLevelView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._bgMaskButton:AddClickListener(self._onClickClose, self)
	self._bgButton:AddClickListener(self._onClickClose, self)
end

function ExpedSelectNextLevelView:buildUI()
	self._bgButton = self:getBtn("bgButton")
	self._btnGet = self:getBtn("Node/BtnGet")
	self._txtTips = self:getTxt("Node/Txt_Tips")
	self._bgMaskButton = self:getBtn("Node/bgMask")
	self._effNode = self:getGo("Node/EffNode")
	self._title = self:getTxt("Node/title")
end

function ExpedSelectNextLevelView:onExit()
	ExpedSelectNextLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnExeExpNextLevel, self._onClickClose, self)
end

function ExpedSelectNextLevelView:onEnter()
	ExpedSelectNextLevelView.super.onEnter(self)

	local eventIndex = self._viewPresentor._openParam[1]

	self._nextLevel = self._viewPresentor._openParam[2]

	local effPath

	if eventIndex == 1 then
		self._txtTips.text = lang("expedition_normal_tips")
		effPath = "fx_ui_shiluoyiji/fx_ui_chuansongmen_lan_shiluoyiji.prefab"
		self._title.text = "普通模式"
	else
		self._txtTips.text = lang("expedition_hard_tips")
		self._title.text = "困难模式"
		effPath = "fx_ui_shiluoyiji/fx_ui_chuansongmen_hong_shiluoyiji.prefab"
	end

	self._effect = UIEffectManager.instance:playEffectBrief(self, effPath, self._effNode, true)

	self._effect:setParent(self._effNode.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
	GlobalDispatcher:addListener(GlobalNotify.OnExeExpNextLevel, self._onClickClose, self)
end

function ExpedSelectNextLevelView:_onClickGet()
	ExpeditionAgent.instance:sendPM_ExpeditionNextLevelReq(self._nextLevel)
end

function ExpedSelectNextLevelView:_onClickClose()
	self:close()
end

return ExpedSelectNextLevelView
