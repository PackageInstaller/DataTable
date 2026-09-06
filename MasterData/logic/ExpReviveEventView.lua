-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpReviveEventView.lua

module("logic.extensions.expedition.view.ExpReviveEventView", package.seeall)

local ExpReviveEventView = class("ExpReviveEventView", ViewComponent)

function ExpReviveEventView:unbindEvents()
	ExpReviveEventView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
	self._bgMaskButton:RemoveClickListener()
	self._bgButton:RemoveClickListener()
	self._btnSureResult:RemoveClickListener()
	self._closeButtonResult:RemoveClickListener()
end

function ExpReviveEventView:bindEvents()
	ExpReviveEventView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._bgMaskButton:AddClickListener(self._onClickClose, self)
	self._bgButton:AddClickListener(self._onClickClose, self)
	self._btnSureResult:AddClickListener(self._onClickClose, self)
	self._closeButtonResult:AddClickListener(self._onClickClose, self)
end

function ExpReviveEventView:buildUI()
	self._bgButton = self:getBtn("bgButton")

	self:_initReviveNode()
	self:_initReviveResultNode()
end

function ExpReviveEventView:_initReviveNode()
	self._reviveNode = self:getGo("ReviveNode")
	self._btnGet = self:getBtn("ReviveNode/BtnGet")
	self._txtTips = self:getTxt("ReviveNode/Txt_Tips")
	self._bgMaskButton = self:getBtn("ReviveNode/bgMask")

	local effTips = self:getTxt("ReviveNode/EffTips")

	self._txtTips.text = lang("expedition_reviveevent")
	effTips.text = lang("expedition_reviveevent_desc")
end

function ExpReviveEventView:_initReviveResultNode()
	self._reviveResultNode = self:getGo("ReviveResult")
	self._closeButtonResult = self:getBtn("ReviveResult/Btn_Close")
	self._btnSureResult = self:getBtn("ReviveResult/BtnSure")
	self._petTips = self:getTxt("ReviveResult/PetTips")
	self._petCell = self:getGo("ReviveResult/PetCell")
end

function ExpReviveEventView:onExit()
	ExpReviveEventView.super.onExit(self)
	GlobalDispatcher:removeListener(ExpeditionAgent.PM_ExpeditionDoEventOverRes, self._onExpeditionDoEventOverRes, self)

	self._data = nil

	ItemPet.Remove(self._petCell)
end

function ExpReviveEventView:onEnter()
	ExpReviveEventView.super.onEnter(self)
	self:_showReviveNode()
	GlobalDispatcher:addListener(ExpeditionAgent.PM_ExpeditionDoEventOverRes, self._onExpeditionDoEventOverRes, self)
end

function ExpReviveEventView:_onClickGet()
	local gridData = self._data
	local param = ExpeditionExtension_pb.PM_ExpeditionEventParam()

	if not self._isSweep then
		ExpeditionAgent.instance:sendPM_ExpeditionDoGridEventReq(gridData.eventIndex, param)
	else
		ExpeditionAgent.instance:sendPM_ExpeditionDoSweepEventReq(gridData.eventIndex, param)
		self:close()
	end
end

function ExpReviveEventView:_showReviveNode()
	self._reviveNode:SetActive(true)
	self._reviveResultNode:SetActive(false)

	self._data = self._viewPresentor._openParam[1][1]

	local canGet = self._viewPresentor._openParam[2]

	self._isSweep = self._viewPresentor._openParam[3] or false
	self._canGet = canGet

	self._btnGet.gameObject:SetActive(canGet or false)
end

function ExpReviveEventView:_showReviveResultNode(msg)
	self._reviveNode:SetActive(false)
	self._reviveResultNode:SetActive(true)

	if msg.petStates and #msg.petStates > 0 then
		local petId = msg.petStates[1].petId

		if not petId then
			self:close()

			return
		end

		local petInfo = ExpeditionFmtModel.instance:getPet(petId)

		if not petInfo then
			self:close()

			return
		end

		self._petTips.text = string.format("曙光泉水已经将[%s]恢复到最佳状态", petInfo.name)
		petInfo.isDead = ExpeditionModel.instance:isPetDead(petId)

		local component = ItemPet.AddOnce(self._petCell)

		component:Init(petInfo)
		component:setSelected(false)

		local inTeamId = ExpeditionFmtModel.instance:getPetIdInTeamByRaceId(petInfo.raceId)

		component:SetInTeam(inTeamId == petInfo.petId)
		component:removeAllListener(ItemPet.Events.Click)
		component:addListener(ItemPet.Events.Click, function(data)
			CommonTipsMgr.instance:showPetTips(petInfo)
		end)
	else
		self:close()
	end
end

function ExpReviveEventView:_onClickClose()
	self:close()
end

function ExpReviveEventView:_onExpeditionDoEventOverRes(status, msg)
	if status == 0 and self._canGet then
		self:_showReviveResultNode(msg)
	else
		self:close()
	end
end

return ExpReviveEventView
