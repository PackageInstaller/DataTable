-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefutureresetView.lua

module("logic.extensions.infinitefuture.view.InfinitefutureresetView", package.seeall)

local InfinitefutureresetView = class("InfinitefutureresetView", ViewComponent)

function InfinitefutureresetView:ctor()
	InfinitefutureresetView.super.ctor(self)
end

function InfinitefutureresetView:unbindEvents()
	InfinitefutureresetView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function InfinitefutureresetView:bindEvents()
	InfinitefutureresetView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnCancel:AddClickListener(function()
		self:close()
	end, self)
	self._btnSure:AddClickListener(function()
		local params = self:getOpenParam()

		InfinitefutureController.instance:sendResetReq(params[1], params[2], params[3])
		self:close()
	end, self)
end

function InfinitefutureresetView:buildUI()
	InfinitefutureresetView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._formation = self:getGo("formation")
end

function InfinitefutureresetView:onExit()
	InfinitefutureresetView.super.onExit(self)

	for _, v in pairs(self._cellList) do
		MaterialMgr.clearIcon(v)
	end
end

function InfinitefutureresetView:onEnter()
	InfinitefutureresetView.super.onEnter(self)

	local params = self:getOpenParam()
	local teamId = params[3]

	self._cellList = {}

	for i = 1, 9 do
		local obj = goutil.findChild(self._formation, string.format("cell_%d/con", i))

		MaterialMgr.clearIcon(obj)

		self._cellList[i] = obj

		obj.transform.parent.gameObject:SetActive(false)
	end

	local raceIds = InfinitefutureModel.instance:getLockTeams(teamId)

	if not raceIds then
		return
	end

	for i = 1, #raceIds do
		local raceId = raceIds[i]

		if raceId > 0 then
			self._cellList[i].transform.parent.gameObject:SetActive(true)
			MaterialMgr.setIcon(self._cellList[i], MatType.Pet, raceId)
		end
	end
end

return InfinitefutureresetView
