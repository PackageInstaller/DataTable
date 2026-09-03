-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingQueueBuyCheckMediator.lua

BuildingQueueBuyCheckMediator = class("BuildingQueueBuyCheckMediator", DmPopupViewMediator)

BuildingQueueBuyCheckMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingQueueBuyCheckMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local clickEventMap = {}

function BuildingQueueBuyCheckMediator:initialize()
	super.initialize(self)
end

function BuildingQueueBuyCheckMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function BuildingQueueBuyCheckMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingQueueBuyCheckMediator:mapEventListeners()
	return
end

function BuildingQueueBuyCheckMediator:enterWithData(data)
	self._queueIndex = data.queueIndex
	self._buyQueueCostNum = -200

	self:setupView()

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:refreshView()
	end, 1, false)

	self:refreshView()
end

function BuildingQueueBuyCheckMediator:setupView()
	self._bgWidget = bindWidget(self, "main.panel", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Tip_Remind"),
		title1 = Strings:get("UITitle_EN_Tishi")
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
end

function BuildingQueueBuyCheckMediator:refreshView()
	local workers = self._buildingSystem:getWorkers()
	local timeEnd = workers[self._queueIndex]

	if timeEnd ~= nil then
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local time = timeEnd / 1000 - timeNow

		if time > 0 then
			local costNum = self._buildingSystem:getBuildQueueCostByTime(time)

			if costNum ~= self._buyQueueCostNum then
				self._buyQueueCostNum = costNum

				local node_des = self:getView():getChildByFullName("main.Node_des")
				local descLab = self:getView():getChildByFullName("main.desc")

				node_des:removeAllChildren()

				local desc = Strings:get("Building_Finish_Text", {
					fontSize = 20,
					fontName = TTF_FONT_FZYH_M,
					num = costNum
				})
				local contentText = ccui.RichText:createWithXML(desc, {})

				contentText:setWrapMode(1)
				contentText:ignoreContentAdaptWithSize(false)
				contentText:setAnchorPoint(cc.p(0.5, 0.5))
				contentText:addTo(node_des)
				contentText:setPosition(cc.p(0, 0))
				contentText:renderContent(0, 0, true)

				local width = contentText:getContentSize().width

				contentText:renderContent(width, 0, true)
			end
		else
			self:onClickClose()
		end
	end
end

function BuildingQueueBuyCheckMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingQueueBuyCheckMediator:onClickCancel(sender, eventType)
	self:close()
end

function BuildingQueueBuyCheckMediator:onClickSure(sender, eventType)
	local cost = self._buyQueueCostNum

	if CurrencySystem:checkEnoughDiamond(self, cost) then
		local params = {}

		params.index = self._queueIndex

		self._buildingSystem:sendclearWorkerCD(params, true)
		self:close()
	end
end
