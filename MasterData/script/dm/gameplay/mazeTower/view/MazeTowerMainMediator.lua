-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/view/MazeTowerMainMediator.lua

MazeTowerMainMediator = class("MazeTowerMainMediator", DmAreaViewMediator, _M)

MazeTowerMainMediator:has("_mazeTowerSystem", {
	is = "r"
}):injectWith("MazeTowerSystem")

local kBtnHandlers = {
	["main.btn_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	["main.btn_rank"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRank"
	},
	["main.btn_reward"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	},
	["main.btn_team"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickTeam"
	},
	["main.btn_challenge"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChallenge"
	}
}

function MazeTowerMainMediator:initialize()
	super.initialize(self)
end

function MazeTowerMainMediator:dispose()
	super.dispose(self)
end

function MazeTowerMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._rewardBtn = self._main:getChildByName("btn_reward")
end

function MazeTowerMainMediator:enterWithData()
	self._mazeTower = self._mazeTowerSystem:getMazeTower()

	self:setupTopInfoWidget()
	self:mapEventListeners()
	self:setupView()
	self:refreshView()
end

function MazeTowerMainMediator:resumeWithData(data)
	if data and data.showTips then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(data.showTips)
		}))
	end
end

function MazeTowerMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Stage_Maze_Name")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MazeTowerMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TOWER_REFRESH, self, self.refreshView)
end

function MazeTowerMainMediator:setupView()
	local heroNode = self._main:getChildByName("Node_hero")
	local heroId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Maze_ShoeHero", "content")
	local modelId = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local heroSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = modelId
	})

	heroSprite:addTo(heroNode):setScale(0.83):posite(60, -110)

	local challengeBtn = self:getView():getChildByFullName("main.btn_challenge")
	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:setScale(0.8)
	mc:addTo(challengeBtn)
	mc:setPosition(cc.p(80, 80))
end

function MazeTowerMainMediator:refreshView()
	local floorText = self._main:getChildByFullName("Text_floor")

	floorText:setString(Strings:get("Maze_Num_Current", {
		Num = self._mazeTower:getTotalPointNum()
	}))

	if not self._rewardBtn.redPoint then
		self._rewardBtn.redPoint = RedPoint:createDefaultNode()

		self._rewardBtn.redPoint:setScale(0.8)
		self._rewardBtn.redPoint:addTo(self._rewardBtn):posite(60, 70)
	end

	self._rewardBtn.redPoint:setVisible(self._mazeTower:hasTaskReward())
end

function MazeTowerMainMediator:onClickBack()
	self:dismiss()
end

function MazeTowerMainMediator:onClickRule()
	local rules = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Maze_RuleTranslate", "content")
	local params = {
		time = TimeUtil:getSystemResetDate()
	}
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		useParam = true,
		rule = rules.Desc,
		extraParams = params
	}, nil)

	self:dispatch(event)
end

function MazeTowerMainMediator:onClickRank()
	local view = self:getInjector():getInstance("MazeTowerRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, nil))
end

function MazeTowerMainMediator:onClickReward()
	local view = self:getInjector():getInstance("MazeTowerRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, nil))
end

function MazeTowerMainMediator:onClickTeam()
	local view = self:getInjector():getInstance("StageTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		hideFightBtn = true,
		isSpecialStage = true,
		stageType = StageTeamType.MAZE_TOWER,
		stageId = self._mazeTower:getCurPointId()
	}))
end

function MazeTowerMainMediator:onClickChallenge()
	local curPointId = self._mazeTower:getCurPointId()
	local pointConfig = ConfigReader:getRecordById("MazeRoom", curPointId)
	local nextPointId = pointConfig.Next

	if self._mazeTowerSystem:checkCurrPointPass() and (nextPointId == nil or nextPointId == "") then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Maze_Tip_1")
		}))

		return
	end

	local view = self:getInjector():getInstance("MazeTowerMapView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
end
