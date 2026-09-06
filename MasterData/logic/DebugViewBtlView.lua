-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/DebugViewBtlView.lua

module("logic.extensions.gm.view.DebugViewBtlView", package.seeall)

local DebugViewBtlView = class("DebugViewBtlView", ViewComponent)

function DebugViewBtlView:ctor()
	DebugViewBtlView.super:ctor()
end

function DebugViewBtlView:buildUI()
	self._closeButton = self:getBtn("top/Close")
	self._ourFormIdInput = self:getInput("formationview1/our/formId")
	self._challengeBtn = self:getBtn("formationview1/start")
	self._viewBtlBtn = self:getBtn("viewBtlBtn")
	self._our1FormIdInput = self:getInput("formationview1/our1/formId")
	self._formationBtn = self:getBtn("formationview1/FormationBtn")
	self._formationBtnText = self:getGo("formationview1/FormationBtn/Text"):GetComponent("Text")
	self._formationNode = self:getGo("formationview1/FormationList")
	self._formations = {}

	for i = 1, 4 do
		self._formations[i] = self:getBtn("formationview1/FormationList/" .. i)
	end

	self._formationId = 1
	self._formationLeftId = 0
	self._formationRightId = 0
end

function DebugViewBtlView:onEnter()
	self._formationLeftId = self._formationLeftId or 0
	self._formationRightId = self._formationRightId or 0
	self._ourFormIdInput.input.text = tostring(self._formationLeftId)
	self._our1FormIdInput.input.text = tostring(self._formationRightId)

	self._formationNode:SetActive(false)
end

function DebugViewBtlView:bindEvents()
	self._formationBtn:AddClickListener(self._onClickFormation, self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._challengeBtn:AddClickListener(self._onStartChallenge, self)
	self._ourFormIdInput:AddOnValueChanged(self._onOurFormIdValueChange, self)
	self._our1FormIdInput:AddOnValueChanged(self._onOur1FormIdValueChange, self)
	self._viewBtlBtn:AddClickListener(self._viewBtlCallback, self)

	for i = 1, #self._formations do
		self._formations[i]:AddClickListener(function()
			self._formationId = i

			local text = goutil.findChildTextComponent(self._formations[i].gameObject, "Text")

			self._formationBtnText.text = text.text

			self._formationNode:SetActive(false)
		end)
	end
end

function DebugViewBtlView:unbindEvents()
	for i = 1, #self._formations do
		self._formations[i]:RemoveClickListener()
	end

	self._formationBtn:RemoveClickListener()
	self._closeButton:RemoveClickListener()
	self._viewBtlBtn:RemoveClickListener()
	self._ourFormIdInput:RemoveOnValueChanged()
	self._our1FormIdInput:RemoveOnValueChanged()
end

function DebugViewBtlView:_onClickClose()
	UIStateManager.instance:pop()
end

function DebugViewBtlView:_onOurFormIdValueChange(id)
	self._formationLeftId = checknumber(id)
end

function DebugViewBtlView:_onOur1FormIdValueChange(id)
	self._formationRightId = checknumber(id)
end

function DebugViewBtlView:_onStartChallenge()
	if self._formationLeftId and self._formationLeftId > 0 then
		GMAgent.instance:sendPM_UserFightMonsterReq(self._formationId, self._formationLeftId)
	else
		GMAgent.instance:sendPM_CreateActionBtlDemoReq()
	end
end

function DebugViewBtlView:_viewBtlCallback()
	if BattleModel.instance.recentlyBattleId and BattleModel.instance.recentlyBattleId > 0 then
		BattleFacade.instance:viewUserFightMonsterBtl(BattleModel.instance.recentlyBattleId)
	else
		TipsFacade.instance:openCommonTips("先打一场战斗才能看回放！")
	end
end

function DebugViewBtlView:_onClickFormation()
	self._formationNode:SetActive(true)
end

return DebugViewBtlView
