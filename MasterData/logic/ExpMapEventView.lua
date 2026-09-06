-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpMapEventView.lua

module("logic.extensions.expedition.view.ExpMapEventView", package.seeall)

local ExpMapEventView = class("ExpMapEventView", ViewComponent)

function ExpMapEventView:unbindEvents()
	ExpMapEventView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
	self._bgMaskButton:RemoveClickListener()
	self._bgButton:RemoveClickListener()
end

function ExpMapEventView:bindEvents()
	ExpMapEventView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._bgMaskButton:AddClickListener(self._onClickClose, self)
	self._bgButton:AddClickListener(self._onClickClose, self)
end

function ExpMapEventView:buildUI()
	self._btnGet = self:getBtn("BtnGet")
	self._txtTips = self:getTxt("Txt_Tips")
	self._bgMaskButton = self:getBtn("bgMask")
	self._bgButton = self:getBtn("bgButton")
	self._evtIcon = self:getGo("evtIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._evtName = self:getTxt("evtName")
end

function ExpMapEventView:onEnter()
	ExpMapEventView.super.onEnter(self)

	self._data = self._viewPresentor._openParam[1]

	local canGet = self._viewPresentor._openParam[2]

	self._canGet = canGet

	self._btnGet.gameObject:SetActive(canGet or false)
	self:_updateEvt()
end

function ExpMapEventView:_updateEvt()
	local cfg = ExpeditionConfig.instance:getMapGripTypeCfg(self._data.eventId)

	self._evtIcon:ChangeSprite(cfg.eventPic)

	self._evtName.text = cfg.name
	self._txtTips.text = cfg.desc
end

function ExpMapEventView:_onClickGet()
	local gridData = self._data

	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.OnExeExpMapEvent, gridData, function()
		if ExpeditionTilingModel.instance:isTilingMapValid(gridData.xAxis, gridData.yAxis, gridData.eventIndex) then
			GlobalDispatcher:dispatch(GlobalNotify.OnExpedSelectGrid)
		else
			ExpeditionTilingModel.instance:setTilingMapGrid(gridData.xAxis, gridData.yAxis, gridData.eventIndex)
			ExpeditionAgent.instance:sendPM_ExpeditionSelectGridReq(gridData.eventIndex)
		end
	end)
end

function ExpMapEventView:_onClickClose()
	self:close()
end

return ExpMapEventView
