-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/view/TaskWeekMediator.lua

TaskWeekMediator = class("TaskWeekMediator", DmPopupViewMediator, _M)

TaskWeekMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
TaskWeekMediator:has("_taskListModel", {
	is = "r"
}):injectWith("TaskListModel")

local kBtnHandlers = {}
local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WeekActiveReward", "content")

function TaskWeekMediator:initialize()
	super.initialize(self)
end

function TaskWeekMediator:dispose()
	super.dispose(self)
end

function TaskWeekMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local bgNode = self:getView():getChildByFullName("main.bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		ignoreBtnBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Task_UI34"),
		title1 = Strings:get("UITitle_EN_Zhouchangjiajiang"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 30 or nil
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BOX_REWARD_SUCC, self, self.refreshView)
end

function TaskWeekMediator:enterWithData(data)
	self._rewardList = {}

	for i, v in pairs(config) do
		local reward = {
			num = tonumber(i),
			rewardId = v[1],
			name = Strings:get(v[2]),
			desc = Strings:get("RewardPreview_2", {
				num = i
			})
		}

		table.insert(self._rewardList, reward)
	end

	table.sort(self._rewardList, function(a, b)
		return a.num < b.num
	end)

	self._maxNum = self._rewardList[#self._rewardList].num

	self:initView()
	self:refreshView()
end

function TaskWeekMediator:initView()
	local view = self:getView()

	self._main = view:getChildByFullName("main")
	self._totalNumTxt = self._main:getChildByFullName("totalNum")
	self._totalNumTxt1 = self._main:getChildByFullName("totalNum_0")
	self._totalText = self._main:getChildByFullName("text")
	self._loadingBar_1 = self._main:getChildByFullName("Image_1.LoadingBar_1")
	self._listView = self._main:getChildByFullName("listView")

	self._listView:setScrollBarEnabled(false)

	self._cellClone = self._main:getChildByFullName("cell")

	self._cellClone:setVisible(false)
end

function TaskWeekMediator:refreshView()
	self._totalNum = self._taskListModel:getWeekLiveness()

	self._totalNumTxt:setString(self._totalNum)
	self._totalNumTxt1:setString("/" .. self._maxNum)
	self._loadingBar_1:setPercent(self._totalNum / self._maxNum * 100)
	self._listView:removeAllItems()
	self._totalNumTxt:setPositionX(self._totalNumTxt1:getPositionX() - self._totalNumTxt1:getContentSize().width)
	self._totalText:setPositionX(self._totalNumTxt:getPositionX() - self._totalNumTxt:getContentSize().width - 3)

	for i = 1, #self._rewardList do
		local data = self._rewardList[i]
		local panel = self:addReward(data)

		self._listView:pushBackCustomItem(panel)
	end
end

function TaskWeekMediator:addRewardIcons(rewards, panel)
	local count = #rewards
	local width = panel:getContentSize().width
	local height = panel:getContentSize().height

	for index = 1, count do
		local reward = rewards[index]
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
		icon:addTo(panel)
		icon:setAnchorPoint(cc.p(1, 0.5))
		icon:setPosition(cc.p(width - (width + 10) * (index - 1), height / 2))
		icon:setScaleNotCascade(0.55)
	end
end

function TaskWeekMediator:addReward(data)
	local panel = self._cellClone:clone()

	panel:setVisible(true)

	local title = panel:getChildByFullName("Panel_1.title")

	title:setString(data.name)

	local desc = panel:getChildByFullName("desc")

	desc:setString(data.desc)

	local rewardicon = panel:getChildByFullName("rewardicon")
	local rewards = RewardSystem:getRewardsById(data.rewardId)

	if rewards then
		self:addRewardIcons(rewards, rewardicon)
	end

	local doneanim = panel:getChildByFullName("doneanim")

	doneanim:setVisible(false)

	local btn_notget = panel:getChildByFullName("btn_notget")

	btn_notget:setVisible(false)

	local btn_get = panel:getChildByFullName("btn_get")

	btn_get:setVisible(false)
	btn_get:addClickEventListener(function()
		self:onClickGetWeekBox(tostring(data.num))
	end)

	local var_9_0 = self:getTaskListModel():getWeekBoxStatusMap()

	if not var_9_0 then
		var_9_0 = {}

		local weekBoxStatusMap = var_9_0

		if self._totalNum >= data.num and not self._taskSystem:findValueByKey(weekBoxStatusMap, data.num) then
			btn_get:setVisible(true)
		else
			doneanim:setVisible(self._totalNum >= data.num)
			btn_notget:setVisible(self._totalNum < data.num)
		end

		panel:setAnchorPoint(cc.p(0, 0))
		panel:setPosition(cc.p(0, 0))

		return panel
	end
end

function TaskWeekMediator:onClickGetWeekBox(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._taskSystem:requestWeekBoxReward({
		type = data
	})
end

function TaskWeekMediator:onClickClose()
	self:close()
end
