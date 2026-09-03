-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/MessageTaskMediator.lua

MessageTaskMediator = class("MessageTaskMediator", DmPopupViewMediator, _M)

MessageTaskMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MessageTaskMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")

local kBtnHandlers = {}

function MessageTaskMediator:initialize()
	super.initialize(self)
end

function MessageTaskMediator:dispose()
	super.dispose(self)
end

function MessageTaskMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshData)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Info_UI04"),
		bgSize = {
			width = 837,
			height = 470
		}
	})
end

function MessageTaskMediator:enterWithData(data)
	self:initView()
	self:refreshData(function()
		self:initData()
	end)
end

function MessageTaskMediator:refreshData(onComplete)
	local params = {
		taskType = {
			TaskType.kMessage
		}
	}

	self._taskSystem:requestTaskList(params, function(response)
		self._messageTaskList = response.data.showTasks or {}

		if DisposableObject:isDisposed(self) then
			return
		end

		if type(onComplete) == "function" then
			onComplete()
		end
	end, self)
end

function MessageTaskMediator:initView()
	self._main = self:getView():getChildByFullName("main")
end

function MessageTaskMediator:initData()
	local index = 1
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local taskList = self._taskSystem:getTaskListByType(TaskType.kMessage)
	local taskLists = {}

	for key, v in pairs(self._messageTaskList) do
		table.insert(taskLists, key)
	end

	table.sort(taskLists, function(a, b)
		local typeA = ConfigReader:getRecordById("Task", a).OrderNum
		local typeB = ConfigReader:getRecordById("Task", b).OrderNum

		if typeA == typeB then
			return a < b
		else
			return typeA < typeB
		end
	end)

	for _, taskId in pairs(taskLists) do
		local cloneCell = self._main:getChildByName("cloneCell" .. index)
		local content = cloneCell:getChildByName("content")
		local progText = cloneCell:getChildByName("progress")
		local rewardBg = cloneCell:getChildByName("reward")
		local recieve = cloneCell:getChildByName("recieve")

		recieve:setVisible(false)

		local btnGet = cloneCell:getChildByName("actBtn")

		btnGet:setVisible(false)
		btnGet:setGray(false)

		local rewardBg = cloneCell:getChildByName("reward")

		for _, taskData in pairs(taskList) do
			if taskData:getId() == taskId then
				local str = conditionkeeper:getConditionDesc(taskData:getCondition()[1])

				content:setString(str)

				local taskStatus = taskData:getStatus()
				local show = taskData:isProgressTask() and taskStatus == TaskStatus.kUnfinish
				local taskValueList = taskData:getTaskValueList()

				progText:setVisible(true)

				if progText:isVisible() then
					progText:setString(taskValueList[1].currentValue .. "/" .. taskValueList[1].targetValue)
				end

				local rewards = taskData:getReward()

				rewardBg:removeAllChildren()

				if rewards then
					for i = 1, #rewards do
						local reward = rewards[i]

						if reward then
							local rewardIcon = IconFactory:createRewardIcon(reward, {
								isWidget = true
							})

							rewardBg:addChild(rewardIcon)
							rewardIcon:setAnchorPoint(cc.p(0, 0.5))
							rewardIcon:setPosition(cc.p(0 + (i - 1) * 68, 15))
							rewardIcon:setScaleNotCascade(0.55)
							IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
								needDelay = true
							})
						end
					end
				end

				if taskStatus == TaskStatus.kGet then
					recieve:setVisible(true)
				elseif taskStatus == TaskStatus.kFinishNotGet then
					btnGet:setVisible(true)
					btnGet:addClickEventListener(function()
						self:onClickGetReward(taskData)
					end)
				elseif taskStatus == TaskStatus.kUnfinish then
					btnGet:setVisible(true)
					btnGet:setGray(true)
				end
			end
		end

		index = index + 1
	end
end

function MessageTaskMediator:onClickGetReward(data)
	AudioEngine:getInstance():playEffect("Se_Click_Get", false)

	if data:getStatus() == TaskStatus.kFinishNotGet then
		self._taskSystem:requestTaskReward({
			taskId = data:getId()
		}, function(response)
			local rewards = response.data.rewards

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards
				}))
			end

			self:refreshData(function()
				self:initData()
			end)

			if DisposableObject:isDisposed(self) then
				return
			end
		end)
	end
end

function MessageTaskMediator:onClickBack()
	self:close()
end
