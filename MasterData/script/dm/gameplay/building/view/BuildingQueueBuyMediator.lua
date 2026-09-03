-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingQueueBuyMediator.lua

BuildingQueueBuyMediator = class("BuildingQueueBuyMediator", DmPopupViewMediator)

BuildingQueueBuyMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingQueueBuyMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local clickEventMap = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function BuildingQueueBuyMediator:initialize()
	super.initialize(self)
end

function BuildingQueueBuyMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function BuildingQueueBuyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingQueueBuyMediator:mapEventListeners()
	return
end

function BuildingQueueBuyMediator:enterWithData()
	self:setupView()

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:refreshView()
	end, 1, false)

	self.mapEventListener(self, self:getEventDispatcher(), SUBORC_CLEAR_WORKERS_CD_SUC, self, self.refreshView)
	self:refreshView()
end

function BuildingQueueBuyMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")

	local node_name = self._mainPanel:getChildByFullName("title_node")

	bindWidget(self, node_name, PopupNormalTitle, {
		title = Strings:get("Building_BuildWorker"),
		title1 = Strings:get("UITitle_EN_Zhuangxiugongren")
	})

	local index = 1

	for k, v in pairs(self._buildingSystem:getWorkers()) do
		local panelBase = self._mainPanel:getChildByFullName("Panel_" .. index)

		if panelBase then
			local btn = panelBase:getChildByFullName("Node_buy.button")

			local function cliclBuyQueue()
				self:onClickBuyQueue(k)
			end

			self:bindWidget(btn, ThreeLevelViceButton, {
				handler = {
					func = bind1(cliclBuyQueue, self)
				}
			})
		end

		index = index + 1
	end
end

function BuildingQueueBuyMediator:refreshView()
	local timeNow = self._gameServerAgent:remoteTimestamp()
	local index = 1

	for k, v in pairs(self._buildingSystem:getWorkers()) do
		local panelBase = self._mainPanel:getChildByFullName("Panel_" .. index)

		if panelBase then
			local bg_free = panelBase:getChildByFullName("bg_free")
			local bg_sleep = panelBase:getChildByFullName("bg_sleep")
			local node_anim = panelBase:getChildByFullName("Node_anim")
			local des = panelBase:getChildByFullName("des")
			local des1 = panelBase:getChildByFullName("des1")
			local des2 = panelBase:getChildByFullName("des2")
			local node_buy = panelBase:getChildByFullName("Node_buy")
			local time = v / 1000 - timeNow

			if time >= 0 then
				bg_sleep:setVisible(true)
				des1:setVisible(true)
				des2:setVisible(true)
				node_buy:setVisible(true)
				bg_free:setVisible(false)
				des:setVisible(false)

				if not node_anim:getChildByFullName("xian") then
					node_anim:removeAllChildren()

					local anim = cc.MovieClip:create("xian_xiaoguaijianzao")

					node_anim:addChild(anim)
					anim:gotoAndPlay(1)
					anim:setName("xian")
					anim:setPosition(cc.p(2, 5))
				end

				local t1, t2 = self._buildingSystem:getTimeText(time)

				des2:setString(t2)

				local costNum = self._buildingSystem:getBuildQueueCostByTime(time)

				node_buy:getChildByFullName("costvalue"):setString(costNum)
			else
				bg_sleep:setVisible(false)
				des1:setVisible(false)
				des2:setVisible(false)
				node_buy:setVisible(false)
				bg_free:setVisible(true)
				des:setVisible(true)

				if not node_anim:getChildByFullName("build") then
					node_anim:removeAllChildren()

					local anim = cc.MovieClip:create("build_xiaoguaijianzao")

					node_anim:addChild(anim)
					anim:gotoAndPlay(1)
					anim:setName("build")
					anim:setPosition(cc.p(6, 0))
				end
			end
		end

		index = index + 1
	end
end

function BuildingQueueBuyMediator:onClickClose(sender, eventType)
	self:close()
end

function BuildingQueueBuyMediator:onClickBuyQueue(queueIndex)
	local workers = self._buildingSystem:getWorkers()
	local timeEnd = workers[queueIndex]

	if timeEnd ~= nil then
		local timeNow = self._gameServerAgent:remoteTimestamp()
		local time = timeEnd / 1000 - timeNow

		if time > 0 then
			local costNum = self._buildingSystem:getBuildQueueCostByTime(time)

			if costNum > 0 then
				local view = self._buildingSystem:getInjector():getInstance("BuildingQueueBuyCheckView")
				local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					queueIndex = queueIndex
				})

				self._buildingSystem:dispatch(event)
			else
				local params = {}

				params.index = queueIndex

				self._buildingSystem:sendclearWorkerCD(params, true)
			end
		end
	end
end
