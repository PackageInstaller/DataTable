-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingCancelCheckMediator.lua

BuildingCancelCheckMediator = class("BuildingCancelCheckMediator", DmPopupViewMediator, _M)

BuildingCancelCheckMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingCancelCheckMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {}

function BuildingCancelCheckMediator:initialize()
	super.initialize(self)
end

function BuildingCancelCheckMediator:dispose()
	super.dispose(self)
end

function BuildingCancelCheckMediator:onRemove()
	super.onRemove(self)
end

function BuildingCancelCheckMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bgWidget = bindWidget(self, "main.panel", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("BuildingTitle_CancelBuild"),
		title1 = Strings:get("UITitle_EN_Quxiao")
	})
	self._sureBtn = self:bindWidget("main.sureBtn", OneLevelViceButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickSure, self)
		}
	})
	self._cancelBtn = self:bindWidget("main.cancelBtn", OneLevelMainButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickCancel, self)
		}
	})

	self:mapEventListeners()
end

function BuildingCancelCheckMediator:mapEventListeners()
	return
end

function BuildingCancelCheckMediator:refreshInfo(event)
	return
end

function BuildingCancelCheckMediator:enterWithData(data)
	self._buildingId = data.buildingId
	self._roomId = data.roomId
	self._id = data.id
	self._subId = data.subId

	self:initView()
	self:updateView()
end

function BuildingCancelCheckMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._desc = self._main:getChildByName("desc")

	self._desc:getVirtualRenderer():setLineHeight(26)

	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local levelConfigId = buildingData._levelConfigId
	local config = ConfigReader:getRecordById("VillageBuildingLevel", levelConfigId)
	local lvConfig = ConfigReader:getRecordById("VillageBuildingLevel", config.NextBuilding) or {}

	self._desc:setString((Strings:get("BuildingText_CancelBuild", {
		num = lvConfig.ReturnFactor * 100
	})))
	self._desc:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function BuildingCancelCheckMediator:updateView()
	return
end

function BuildingCancelCheckMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingCancelCheckMediator:onClickCancel(sender, eventType)
	self:close()
end

function BuildingCancelCheckMediator:onClickSure(sender, eventType)
	local buildingData = self._buildingSystem:getBuildingData(self._roomId, self._id)
	local timeNow = self._gameServerAgent:remoteTimestamp()

	if self._subId then
		local subOrcList = buildingData._subOreList
		local subOrc = subOrcList[self._subId]
		local status = subOrc.status

		if status == KBuildingStatus.kLvUp then
			local endTime = subOrc.finishTime

			if timeNow < endTime then
				local params = {}

				params.roomId = self._roomId
				params.buildId = self._id
				params.subId = self._subId

				self._buildingSystem:sendSubOrcCancelLevelUp(params, true)
			end
		end
	else
		local status = buildingData._status

		if status == KBuildingStatus.kLvUp then
			local endTime = buildingData._finishTime

			if timeNow < endTime then
				local params = {}

				params.roomId = self._roomId
				params.buildId = self._id

				self._buildingSystem:sendBuildingLvUpCanel(params, true)
			end
		end
	end

	self:close()
end
