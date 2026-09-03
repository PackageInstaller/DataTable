-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerAwardMediator.lua

TowerAwardMediator = class("TowerAwardMediator", DmPopupViewMediator, _M)

TowerAwardMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBack"
	},
	["main.button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}

function TowerAwardMediator:initialize()
	super.initialize(self)
end

function TowerAwardMediator:dispose()
	super.dispose(self)
end

function TowerAwardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TowerAwardMediator:enterWithData(data)
	local tower = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())

	self._pointRewardList = tower:getPointRewardList()
	self._maxExpAwardList = tower:getMaxExpAwardList()

	self:initContent()
end

function TowerAwardMediator:initContent()
	self:getView():getChildByFullName("main.title_node.Text_1"):setString(Strings:get("Tower_Button_Reward"))
	self:getView():getChildByFullName("main.title_node.Text_2"):setString(Strings:get("UITitle_EN_Jiangli"))
	self:getView():getChildByFullName("main.button_rule"):setVisible(false)
	self:getView():getChildByFullName("main.Text_191_0_0"):setVisible(false)

	self._listView = self:getView():getChildByFullName("main.listview")
	self._titlePanel = self:getView():getChildByFullName("main.title_panel")

	self._titlePanel:setVisible(false)

	self._contentPanel = self:getView():getChildByFullName("main.content_panel")

	self._contentPanel:setVisible(false)
	self._listView:setScrollBarEnabled(false)

	self._width = self._listView:getContentSize().width

	self:getView():getChildByFullName("main.textNoTip"):setVisible(false)

	if #self._pointRewardList <= 0 and #self._maxExpAwardList <= 0 then
		self:getView():getChildByFullName("main.textNoTip"):setVisible(true)
	end

	local height = 0
	local contentHeight = 80
	local titleHeight = 40

	local function addTitle(type)
		local p = self._titlePanel:clone()

		p:setVisible(true)

		local t1 = p:getChildByFullName("Text_title")

		self._listView:pushBackCustomItem(p)
		p:setPosition(0, height)

		if type == "exp" then
			t1:setString(Strings:get("Tower_Synthetize_Reward"))
		elseif type == "point" then
			t1:setString(Strings:get("Tower_Pass_Reward"))
		end

		height = height + titleHeight
	end

	local function addContent(rewardList, type, index)
		local panel = self._contentPanel:clone()

		panel:setVisible(true)

		for idx, reward in ipairs(rewardList) do
			local rewardIcon = self:addIcon(reward, panel)

			rewardIcon:setPosition(90 + idx * 100, 50)
		end

		self._listView:pushBackCustomItem(panel)
		panel:setPosition(0, height)

		height = height + contentHeight

		local title = ""

		if type == "exp" then
			title = ""

			panel:getChildByFullName("line"):setVisible(false)
		elseif type == "point" then
			title = Strings:get("Tower_Battle_PointNum", {
				num = index
			})
		end

		panel:getChildByFullName("title"):setString(title)

		return panel
	end

	if #self._maxExpAwardList > 0 then
		addTitle("exp")
	end

	local list = {}

	for index, value in ipairs(self._maxExpAwardList) do
		list[#list + 1] = self._maxExpAwardList[index]

		if math.fmod(index, 5) == 0 then
			addContent(list, "exp")

			list = {}
		end
	end

	if #list > 0 then
		addContent(list, "exp")
	end

	if #self._pointRewardList > 0 then
		addTitle("point")
	end

	for index = 1, #self._pointRewardList do
		local idx = #self._pointRewardList - index + 1
		local rewardList = self._pointRewardList[idx]

		addContent(rewardList, "point", idx)
	end
end

function TowerAwardMediator:addIcon(reward, panel)
	if panel then
		local rewardIcon = IconFactory:createRewardIcon(reward, {
			showAmount = true,
			isWidget = true
		})

		panel:addChild(rewardIcon)
		rewardIcon:setScaleNotCascade(0.68)
		IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
			stopActionWhenMove = true,
			needDelay = true
		})

		return rewardIcon
	end
end

function TowerAwardMediator:onClickBack()
	self:close()
end

function TowerAwardMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end
