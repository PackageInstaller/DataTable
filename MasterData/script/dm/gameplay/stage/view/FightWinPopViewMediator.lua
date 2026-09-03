-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/FightWinPopViewMediator.lua

FightWinPopViewMediator = class("FightWinPopViewMediator", DmPopupViewMediator, _M)

FightWinPopViewMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout"
}

function FightWinPopViewMediator:initialize()
	super.initialize(self)
end

function FightWinPopViewMediator:dispose()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_minigame_win_view")
	super.dispose(self)
end

function FightWinPopViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function FightWinPopViewMediator:onRemove()
	super.onRemove(self)
end

function FightWinPopViewMediator:enterWithData(data)
	self._data = data
	self._starNum = 0
	self._stars = {}

	if self._data.stars then
		for _, index in pairs(self._data.stars) do
			self._starNum = self._starNum + 1
			self._stars[index] = true
		end
	end

	self:initWidget()
	self:refreshView()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("enter_minigame_win_view")
end

function FightWinPopViewMediator:initWidget()
	self._main = self:getView():getChildByName("content")
	self._title = self:getView():getChildByFullName("content.title")

	local lineGradiantVec1 = {
		{
			ratio = 0.1,
			color = cc.c4b(250, 210, 140, 255)
		},
		{
			ratio = 0.5,
			color = cc.c4b(240, 170, 90, 255)
		},
		{
			ratio = 0.9,
			color = cc.c4b(160, 120, 80, 255)
		}
	}

	self._title:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	self._level = self:getView():getChildByFullName("content.mLevelNum")
	self._exp = self:getView():getChildByFullName("content.mExpNum")
	self._crystal = self:getView():getChildByFullName("content.mCrystalNum")
	self._gold = self:getView():getChildByFullName("content.mGoldNum")
	self._expBar = self:getView():getChildByFullName("content.mExpBar")
	self._starPanel = self._main:getChildByFullName("Panel_star")
	self._rewardPanel = self._main:getChildByFullName("Panel_reward")
	self._rewardListView = self._rewardPanel:getChildByFullName("mRewardList")

	self._rewardListView:setScrollBarEnabled(false)

	self._expPanel = self._main:getChildByFullName("Panel_exp")

	self._expPanel:setVisible(false)

	self._state = 1
end

function FightWinPopViewMediator:refreshView()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local config = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel()))
	local percent = player:getExp() / config.PlayerExp * 100

	self._expBar:setPercent(percent)
	self._exp:setString(player:getExp())
	self._level:setString(player:getLevel())

	local bagSystem = self:getInjector():getInstance(DevelopSystem):getBagSystem()
	local text, huge = CurrencySystem:formatCurrency(bagSystem:getItemCount(CurrencyIdKind.kGold))

	self._gold:setString(text)

	local text = bagSystem:getItemCount(CurrencyIdKind.kCrystal)
	local crystalAmount = 0
	local goldAmount = 0

	if self._data.rewards.goldReward then
		goldAmount = tonumber(self._data.rewards.goldReward)
	end

	if self._data.rewards.playerExp then
		self._exp:setString("" .. self._data.rewards.playerExp)
	else
		self._exp:setString("0")
	end

	self._rewardList = {}
	self._data.rewards.itemRewards = self._data.rewards.itemRewards or {}

	if self._data.rewards.firstRewards then
		for k, v in ipairs(self._data.rewards.firstRewards) do
			self._data.rewards.itemRewards[#self._data.rewards.itemRewards + 1] = v
		end
	end

	for k, v in ipairs(self._data.rewards.itemRewards) do
		if tostring(v.code) == CurrencyIdKind.kCrystal then
			crystalAmount = crystalAmount + v.amount
		elseif tostring(v.code) == CurrencyIdKind.kGold then
			goldAmount = goldAmount + v.amount
		elseif v.code == "5" or v.code == "6" then
			dump(v, "经验数据")
			self._exp:setString(v.amount)
		else
			local scale = 0.8

			self._rewardList[k] = IconFactory:createRewardIcon(v, {
				isWidget = true
			})

			IconFactory:bindTouchHander(self._rewardList[k], IconTouchHandler:new(self), v, {
				needDelay = true
			})

			if self._rewardList[k] then
				local size = cc.size(self._rewardList[k]:getContentSize().width * scale, self._rewardList[k]:getContentSize().height * scale)
				local layout = ccui.Layout:create()

				self._rewardList[k]:setPosition(cc.p(size.width / 2, size.height / 2))
				self._rewardList[k]:setScale(scale)
				layout:addChild(self._rewardList[k])
				layout:setContentSize(size)
				self._rewardListView:pushBackCustomItem(layout)
			end
		end
	end

	if next(self._rewardList) == nil then
		self._rewardListView:setVisible(false)
	end

	self._crystal:setString(tostring(crystalAmount))
	self._gold:setString(tostring(goldAmount))

	if self._data.maze then
		self._starPanel:setVisible(false)

		return
	end

	local point = self._stageSystem:getPointById(self._data.pointId)
	local starPanel = self._starPanel
	local descs = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Block_StarConditionDesc", "content")
	local starCondition = point:getStarCondition()

	for i = 1, 3 do
		local star = starPanel:getChildByFullName("star" .. i)
		local labelText = star:getChildByFullName("text")

		labelText:setString(Strings:get(descs[starCondition[i].type], {
			value = starCondition[i].value
		}))

		if self._stars[i] then
			star:getChildByFullName("gou"):setVisible(true)
		else
			star:getChildByFullName("gou"):setVisible(false)
		end
	end
end

function FightWinPopViewMediator:showExpPanel()
	self._state = 2

	self._starPanel:setVisible(false)
	self._rewardPanel:setVisible(false)
	self._expPanel:setVisible(true)

	local exp = "+" .. self._data.rewards.heroExp
	local cloneCell = self._expPanel:getChildByName("clone_cell")
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local heroSystem = developSystem:getHeroSystem()
	local team = developSystem:getTeamByType(StageTeamType.STAGE_NORMAL)
	local ids = team:getHeroes()

	for k, v in ipairs(ids) do
		local heroInfo = heroSystem:getHeroById(v)
		local heroData = {
			id = heroInfo:getId(),
			level = heroInfo:getLevel(),
			star = heroInfo:getStar(),
			quality = heroInfo:getQuality(),
			rareity = heroInfo:getRarity(),
			qualityLevel = heroInfo:getQualityLevel(),
			name = heroInfo:getName()
		}
		local cell = cloneCell:clone()

		cell:setVisible(true)

		local expStr = cell:getChildByName("exp")

		expStr:setString(exp)

		local iconNode = cell:getChildByName("icon")
		local icon = IconFactory:createHeroIcon(heroData, {
			hideLevel = false,
			isRect = true,
			scale = 0.6,
			hideName = true
		})

		icon:addTo(cell):posite(43, 66)

		local x = ((k - 1) % 5 + 1) * 108 - 55
		local y = 172 - math.floor((k - 1) / 5) * 132

		cell:addTo(self._expPanel):posite(x, y)
	end
end

function FightWinPopViewMediator:leaveWithData()
	self:onTouchLayout(nil, ccui.TouchEventType.ended)
end

function FightWinPopViewMediator:onTouchLayout(sender, eventType)
	if eventType ~= ccui.TouchEventType.ended then
		return
	end

	if self._data.maze and self._data.mazeState == 1 then
		local dispatchdata = self._data
		local view = dispatchdata.mazedispatcher:getInjector():getInstance("MazeEventMainView")

		dispatchdata.mazedispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))

		return
	elseif self._data.maze and self._data.mazeState == 0 then
		BattleLoader:popBattleView(self, {
			viewName = "MazeMainView",
			userdata = {}
		})

		return
	end

	if self._state == 1 then
		self:showExpPanel()

		return
	end

	if self._state ~= 2 then
		return
	end

	self._state = 3

	self._stageSystem:requestStageProgress(function()
		local point = self._stageSystem:getPointById(self._data.pointId)
		local stageType = point:getType()
		local pointData = self._stageSystem:parseStageIndex(self._data.pointId, stageType)
		local chapterIndex = pointData.mapIndex
		local data = {}
		local mapLastPointIndex = self._stageSystem:getLastPointIndexByMapIndex(chapterIndex, stageType)
		local lastOpenChapterIndex = self._stageSystem:getLastOpenMapIndex(stageType)

		if (point:getOldStar() or 0) > 0 then
			data.chapterId = self._stageSystem:index2MapId(chapterIndex, stageType)
			data.pointId = self._data.pointId
		elseif lastOpenChapterIndex == chapterIndex then
			data.chapterId = self._stageSystem:index2MapId(chapterIndex, stageType)
		else
			data.openAni = true
			data.chapterId = self._stageSystem:index2MapId(lastOpenChapterIndex, stageType)
		end

		BattleLoader:popBattleView(self, data)
	end, false)
end
