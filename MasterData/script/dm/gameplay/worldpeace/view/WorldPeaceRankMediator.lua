-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceRankMediator.lua

WorldPeaceRankMediator = class("WorldPeaceRankMediator", DmPopupViewMediator, _M)

WorldPeaceRankMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

local kTabViewNames = {
	[viewRankType.kClub] = {
		viewName = "WorldPeaceClubRankView",
		title = "ClubMapBoss_Rank",
		tabName = "ClubMapBoss_Result_Page1",
		rewardType = {
			WPRewardType.kClubDaily
		}
	},
	[viewRankType.kHurt] = {
		viewName = "WordPeaceHurtView",
		title = "ClubMapBoss_Rank",
		tabName = "ClubMapBoss_KillRank",
		rankType = RankType.KWorldPeaceHurt
	},
	[viewRankType.kScore] = {
		viewName = "WordPeaceHurtView",
		title = "ClubMapBoss_Rank",
		tabName = "ClubMapBoss_DamageRank",
		rankType = RankType.KWorldPeaceScore
	},
	[viewRankType.kTask] = {
		viewName = "WorldPeaceTaskView",
		title = "ClubMapBoss_MapBossTask",
		tabName = "ClubMapBoss_PersonalTask",
		rewardType = {
			WPRewardType.kPersonTask
		}
	},
	[viewRankType.kRule] = {
		viewName = "WorldPeaceRuleView",
		title = "EXPLORE_UI16",
		tabName = "EXPLORE_UI16",
		rewardType = {}
	}
}

function WorldPeaceRankMediator:initialize()
	super.initialize(self)
end

function WorldPeaceRankMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function WorldPeaceRankMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByFullName("main")
	self._tabpanel = self._main:getChildByName("tabpanel")
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		ignoreBg1 = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:find("ClubMapBoss_Result_Title1")
	})
end

function WorldPeaceRankMediator:enterWithData(data)
	if data then
		self._curTabType = data.tabType or 1
	end

	self._viewCache = {}

	self:mapEventListeners()
	self:setupView()
	self:startTimer()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REDPOINT_REFRESH, self, self.refreshRedPoint)
end

function WorldPeaceRankMediator:mapEventListeners()
	return
end

function WorldPeaceRankMediator:setupView()
	self:createTabController()
end

function WorldPeaceRankMediator:showView()
	local viewData = kTabViewNames[self._curTabType]
	local viewName = viewData.viewName
	local view = self._viewCache[self._curTabType]

	if not view then
		view = self:getInjector():getInstance(viewName)
		self._viewCache[self._curTabType] = view

		self._main:addChild(view, 1)
	end

	if view then
		for i, view in pairs(self._viewCache) do
			view:setVisible(i == self._curTabType)
		end

		self._selectView = view

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			local data = {}

			data.mediator = self
			data.tabType = self._curTabType
			data.rankType = viewData.rankType

			mediator:setupView(viewData)
		end

		self._bgWidget:updateTitle({
			title = Strings:get(kTabViewNames[self._curTabType].title)
		})
	end
end

function WorldPeaceRankMediator:createTabController()
	local worldPeace = self._worldPeaceSystem:getWorldPeace()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #kTabViewNames do
		local tabText = Strings:get(kTabViewNames[i].tabName)

		data[#data + 1] = {
			tabText = tabText,
			redPointFunc = function()
				if kTabViewNames[i].rewardType then
					for i, v in pairs(kTabViewNames[i].rewardType) do
						if self._worldPeaceSystem:hasRewardGetByType(v) then
							return true
						end
					end
				end

				return false
			end
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 537)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, -25)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabType)
end

function WorldPeaceRankMediator:refreshRedPoint()
	self._tabBtnWidget:refreshAllRedPoint()
end

function WorldPeaceRankMediator:startTimer()
	local function update()
		return
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

	update()
end

function WorldPeaceRankMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function WorldPeaceRankMediator:onClickTab(name, tag)
	self._curTabType = tag

	self:showView()
end
