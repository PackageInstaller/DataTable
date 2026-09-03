-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityTaskCollectStarMediator.lua

ActivityTaskCollectStarMediator = class("ActivityTaskCollectStarMediator", DmPopupViewMediator, _M)

ActivityTaskCollectStarMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityTaskCollectStarMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ActivityTaskCollectStarMediator:initialize()
	super.initialize(self)
end

function ActivityTaskCollectStarMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityTaskCollectStarMediator:onRegister()
	super.onRegister(self)
end

function ActivityTaskCollectStarMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function ActivityTaskCollectStarMediator:resumeView()
	self._tableView:reloadData()
end

function ActivityTaskCollectStarMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")
	self._descPanel = self._main:getChildByName("desc")
	self._cloneCell = self:getView():getChildByName("cloneCell")

	self._cloneCell:setVisible(false)

	self._notGetPanel = self:getView():getChildByName("notGetPanel")

	self._notGetPanel:setVisible(false)

	self._starPanel = self:getView():getChildByName("starPanel")

	self._starPanel:setVisible(false)

	self._taskList = self._activity:getSortActivityList()

	self._descPanel:setString(Strings:get(self._activity:getDesc()))
	self._descPanel:getVirtualRenderer():setLineSpacing(2)

	self._refreshPanel = self._main:getChildByName("refreshPanel")
	self._refreshTime = self._refreshPanel:getChildByName("times")

	self:createTableView()
	self:setTimer()

	local activityConfig = self._activity:getActivityConfig()

	if activityConfig and activityConfig.TaskTopUI then
		self._main:getChildByName("Image_9"):loadTexture(activityConfig.TaskTopUI .. ".png", ccui.TextureResType.plistType)
	end
end

function ActivityTaskCollectStarMediator:createTableView()
	local size = self._cloneCell:getContentSize()
	local tableView = cc.TableView:create(cc.size(size.width, 360))

	local function numberOfCells(view)
		return #self._taskList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local cloneCell = self._cloneCell:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setName("main")
			cloneCell:setPosition(cc.p(0, 4))

			local actBtn = cloneCell:getChildByName("actBtn")

			actBtn:setSwallowTouches(false)
			actBtn:getChildByName("Text_str"):setAdditionalKerning(4)
			cloneCell:getChildByName("title"):setAdditionalKerning(2)
		end

		self:updataCell(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0.5, 0.5))
	tableView:setPosition(cc.p(10, 11))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:addTo(self._listView)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function ActivityTaskCollectStarMediator:updataCell(cell, index)
	local mainView = cell:getChildByName("main")
	local data = self._taskList[index]
	local name = data._config.Name
	local nameText = mainView:getChildByName("title")

	nameText:setString(Strings:get(name))

	local target = mainView:getChildByName("target")

	target:removeAllChildren()

	local condition = data._config.Condition

	for i = 1, #condition do
		local heroId = condition[i].params[1]
		local heroSystem = self._developSystem:getHeroSystem()
		local has = heroSystem:hasHero(heroId)
		local hero = heroSystem:getHeroById(heroId)
		local needCount = heroSystem:getHeroComposeFragCount(heroId)
		local hasCount = heroSystem:getHeroDebrisCount(heroId)
		local starAchieve = false
		local reward = {
			type = 3,
			amount = 0,
			code = condition[i].params[1]
		}
		local rewardIcon = IconFactory:createRewardIcon(reward, {
			showAmount = false,
			isWidget = true
		})

		target:addChild(rewardIcon)
		rewardIcon:setScaleNotCascade(0.6)
		rewardIcon:setPositionX((i - 1) * 78)
		rewardIcon:setAnchorPoint(0, 0)

		if has then
			local star = hero:getStar()
			local starPanel = self._starPanel:clone()

			target:addChild(starPanel)
			starPanel:setVisible(true)
			starPanel:setPosition((i - 1) * 78 + 6 * (6 - star), 0)
			starPanel:setAnchorPoint(0, 0)

			for i = 1, 6 do
				starPanel:getChildByName("star_" .. i):setVisible(i <= star and true or false)
			end

			local requireStar = condition[i].factor1[1]

			if star < requireStar then
				rewardIcon:setColor(cc.c3b(125, 125, 125))
			else
				starAchieve = true
			end
		else
			rewardIcon:setGray(not has)

			local notGetPanel = self._notGetPanel:clone()

			target:addChild(notGetPanel)
			notGetPanel:setVisible(true)
			notGetPanel:setPosition((i - 1) * 78 - 2, -3)
			notGetPanel:setAnchorPoint(0, 0)

			if hasCount < needCount then
				notGetPanel:getChildByName("nogetstr"):setString(Strings:get("Activity_Collect_UnGain"))
			else
				notGetPanel:getChildByName("nogetstr"):setString(Strings:get("Activity_Collect_Summon"))
			end
		end

		IconFactory:bindClickAction(rewardIcon, function()
			AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)

			if starAchieve then
				return
			end

			if has then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Activity_Collect_StarTips")
				}))
			elseif hasCount < needCount then
				local view = self:getInjector():getInstance("HeroShowNotOwnView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					showType = 1,
					id = heroId
				}))
			else
				local view = self:getInjector():getInstance("HeroShowListView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					id = heroId
				}))
			end
		end, {
			runAction = false
		})
	end

	local rewardPanel = mainView:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local rewards = data:getReward()

	if rewards and rewards.Content then
		for i, rewardData in pairs(rewards.Content) do
			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setAnchorPoint(cc.p(0, 0))
			icon:setScaleNotCascade(0.5)
			icon:addTo(rewardPanel):posite(-4.5 + (i - 1) * 66, 0)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
				needDelay = true
			})
		end
	end

	local status = data:getStatus()
	local actBtn = mainView:getChildByName("actBtn")

	actBtn:setVisible(true)

	local recieveImg = mainView:getChildByName("recieve")

	recieveImg:setVisible(false)

	if status == ActivityTaskStatus.kUnfinish then
		local text = actBtn:getChildByName("Text_str")

		text:setString(Strings:get("Task_UI11"))
		actBtn:setGray(true)
		actBtn:loadTexture("hd_btn_qw.png", ccui.TextureResType.plistType)
	elseif status == ActivityTaskStatus.kFinishNotGet then
		local text = actBtn:getChildByName("Text_str")

		text:setString(Strings:get("Task_UI11"))

		local function callFuncGo(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self:onClickGet(data, cell:getIdx())
			end
		end

		actBtn:loadTexture("hd_btn_lq.png", ccui.TextureResType.plistType)
		mapButtonHandlerClick(nil, actBtn, {
			func = callFuncGo
		})
	else
		local children = rewardPanel:getChildren()

		for i = 1, #children do
			local node = children[i]

			node:setColor(cc.c3b(120, 120, 120))

			local img = ccui.ImageView:create("hd_14r_btn_go.png", 1)

			img:setScale(0.5)
			img:addTo(rewardPanel)
			img:setPosition(cc.p(-42 + i * 66, 28))
		end

		actBtn:setVisible(false)
		recieveImg:setVisible(true)
	end
end

function ActivityTaskCollectStarMediator:onClickGo(data)
	local url = data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ActivityTaskCollectStarMediator:onClickGet(data, index)
	local status = data:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local data = {
		doActivityType = 101,
		taskId = data:getId()
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end

		self._tableView:updateCellAtIndex(index)
	end)
end

function ActivityTaskCollectStarMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self._refreshPanel:setVisible(false)
end

function ActivityTaskCollectStarMediator:setTimer()
	self:stopTimer()

	if not self._activity then
		return
	end

	self._refreshPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._activity:getEndTime() / 1000

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = self._activity:getEndTime() / 1000
			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				self:stopTimer()

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			self._refreshTime:setString((timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")) .. Strings:get("Activity_Collect_Finish"))
			self._refreshPanel:setVisible(true)
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end
