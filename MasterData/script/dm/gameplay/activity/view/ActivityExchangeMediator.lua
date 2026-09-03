-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityExchangeMediator.lua

ActivityExchangeMediator = class("ActivityExchangeMediator", DmPopupViewMediator, _M)

ActivityExchangeMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityExchangeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

KBubleEnterStatus = {
	ExchangeEnd = 2,
	ClickHero = 3,
	ClickText = 4,
	FirstEnter = 1
}

function ActivityExchangeMediator:initialize()
	super.initialize(self)
end

function ActivityExchangeMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityExchangeMediator:onRegister()
	super.onRegister(self)
end

function ActivityExchangeMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
end

function ActivityExchangeMediator:resumeView()
	self._tableView:reloadData()
end

function ActivityExchangeMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")
	self._descPanel = self._main:getChildByName("desc")
	self._cloneCell = self:getView():getChildByName("cloneCell")

	self._cloneCell:setVisible(false)

	self._taskList = self._activity:getSortExchangeList()

	local endTime = ConfigReader:getDataByNameIdAndKey("Activity", "VTExtraNormal_20200412_0420", "TimeFactor")
	local remoteTime = TimeUtil:formatStrToRemoteTImestamp(endTime["end"])
	local localDate = TimeUtil:localDate("%Y-%m-%d  %H:%M:%S", remoteTime)

	self._descPanel:setString(Strings:get(self._activity:getDesc(), {
		time = localDate
	}))
	self._descPanel:getVirtualRenderer():setLineSpacing(2)

	self._iconClone = self:getView():getChildByName("iconPanel")

	self._iconClone:setVisible(false)

	self._refreshPanel = self._main:getChildByName("refreshPanel")
	self._refreshTime = self._refreshPanel:getChildByName("times")
	self._bubblePanel = self._main:getChildByName("bubblePanel")

	self._bubblePanel:addClickEventListener(function()
		self:setBubleView(KBubleEnterStatus.ClickText)
	end)

	local activityConfig = self._activity:getActivityConfig()
	local heroPanel = self._main:getChildByName("heroPanel")
	local modelId = activityConfig.ModelId

	heroPanel:getChildByFullName("Image_33"):setVisible(not modelId)

	if modelId and modelId ~= "no" then
		local roleModel = activityConfig.ModelId
		local heroSprite = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = roleModel
		})

		heroSprite:setScale(0.85)
		heroSprite:addTo(heroPanel)
		heroSprite:setPosition(cc.p(595, 145))

		if self._activity:getId() == "Exchange_20200318_0325" then
			heroSprite:setScale(0.8)
			heroSprite:setPosition(cc.p(480, 160))
		end

		local param = activityConfig.ModelIdOffset

		if param and param.scale then
			heroSprite:setScale(param.scale)
		end

		if param and param.pos then
			heroSprite:setPosition(cc.p(param.pos[1], param.pos[2]))
		end
	end

	heroPanel:setTouchEnabled(true)
	heroPanel:addClickEventListener(function()
		self:setBubleView(KBubleEnterStatus.ClickHero)
	end)

	local topIcon = self._main:getChildByName("Image_9")
	local taskTopUI = activityConfig.TaskTopUI

	if taskTopUI then
		topIcon:loadTexture(taskTopUI .. ".png", ccui.TextureResType.plistType)
		topIcon:ignoreContentAdaptWithSize(true)
	end

	local taskTopUIPos = activityConfig.TaskTopUIPos

	if taskTopUIPos and taskTopUIPos.x and taskTopUIPos.y then
		topIcon:setPosition(cc.p(taskTopUIPos.x, taskTopUIPos.y))
	end

	local taskBgUI = activityConfig.TaskBgUI

	if taskBgUI then
		self._main:getChildByName("Image_18"):loadTexture("asset/scene/" .. taskBgUI .. ".jpg")
	end

	local taskCellBg = activityConfig.TaskCellBg

	if taskCellBg then
		self._cloneCell:getChildByName("Image_15"):loadTexture(taskCellBg .. ".png", ccui.TextureResType.plistType)
	end

	local taskCellArrow = activityConfig.TaskCellArrow

	if taskCellArrow then
		self._cloneCell:getChildByName("arrow"):loadTexture(taskCellArrow .. ".png", ccui.TextureResType.plistType)
	end

	self:createTableView()
	self:setBubleView(KBubleEnterStatus.FirstEnter)
	self:setTimer1()
end

function ActivityExchangeMediator:setBubleView(status)
	local bubleDesc = self._activity:getBubleDesc()
	local txt = self._bubblePanel:getChildByFullName("txt")
	local bg = self._bubblePanel:getChildByFullName("bg")
	local str = ""

	if status == KBubleEnterStatus.ClickHero then
		local v = self._bubblePanel:isVisible()

		self._bubblePanel:setVisible(not v)

		if v then
			return
		end

		str = self:getTalkShow()
	else
		self._bubblePanel:setVisible(true)

		if status == KBubleEnterStatus.FirstEnter then
			local mount = self._activity:getExchangeAmountStatus()

			str = mount and bubleDesc[1] or bubleDesc[2]
		elseif status == KBubleEnterStatus.ExchangeEnd then
			str = bubleDesc[3]
		elseif status == KBubleEnterStatus.ClickText then
			str = self:getTalkShow()
		end
	end

	local nickName = self._developSystem:getNickName()

	txt:getVirtualRenderer():setDimensions(200, 0)
	txt:setString(Strings:get(str, {
		name = nickName
	}))
	bg:setContentSize(cc.size(274, txt:getContentSize().height + 75))
	txt:setPositionY(40 + txt:getContentSize().height)
end

function ActivityExchangeMediator:getTalkShow()
	local content = self._activity:getBubleDesc()
	local index = math.random(4, #content)

	if not content[index] then
		return content[index]
	end
end

function ActivityExchangeMediator:createTableView()
	local size = self._cloneCell:getContentSize()
	local tableView = cc.TableView:create(cc.size(size.width, 394))

	local function numberOfCells(view)
		return #self._taskList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height + 7
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
		end

		self:updataCell(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0.5, 0.5))
	tableView:setPosition(cc.p(8, 12))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:addTo(self._listView)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function ActivityExchangeMediator:updataCell(cell, index)
	local mainView = cell:getChildByName("main")
	local data = self._taskList[index]
	local config = data.config
	local rewardPanel = mainView:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local costList = config.Cost

	self._enough = true

	for i, value in pairs(costList) do
		local iconPanel = self._iconClone:clone()

		iconPanel:setVisible(true)

		local icon = IconFactory:createRewardIcon(value, {
			showAmount = false,
			isWidget = true
		})

		icon:addTo(iconPanel, -1):center(iconPanel:getContentSize())
		icon:setScaleNotCascade(0.5)
		IconFactory:bindTouchHander(iconPanel, IconTouchHandler:new(self._parentMediator), value, {
			needDelay = true
		})
		iconPanel:addTo(rewardPanel):posite((i - 1) * 66, -10)

		local curText = iconPanel:getChildByName("Text_curvalue")
		local targetText = iconPanel:getChildByName("Text_target")
		local count = self._developSystem:getBagSystem():getItemCount(value.code)

		curText:setString(count)
		targetText:setString("/" .. value.amount)
		curText:setColor(cc.c3b(180, 233, 59))

		if count < value.amount then
			self._enough = false

			curText:setColor(cc.c3b(255, 73, 37))
		end
	end

	local targetPanel = mainView:getChildByName("target")

	targetPanel:removeAllChildren()

	local targetList = ConfigReader:getDataByNameIdAndKey("Reward", config.Target, "Content")

	if targetList then
		for j, v in pairs(targetList) do
			local icon = IconFactory:createRewardIcon(v, {
				showAmount = true,
				isWidget = true
			})

			icon:addTo(targetPanel, -1):posite((j - 1) * 66 + 30, 25):setScaleNotCascade(0.5)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), v, {
				needDelay = true
			})
		end
	end

	local status = self._enough
	local haveAmount = self._activity:getExchangeAmount(data.id)
	local enoughAmount = self._activity:getExchangeCountById(data.id)
	local canExchangeAmount = haveAmount < enoughAmount and haveAmount or enoughAmount
	local times = config.Times
	local actBtn = mainView:getChildByName("actBtn")
	local tipPanel = mainView:getChildByFullName("tipPanel")
	local allTipTxt = mainView:getChildByFullName("allTipTxt")
	local duigou = tipPanel:getChildByFullName("duigou")
	local count = times - haveAmount

	if haveAmount <= 0 then
		allTipTxt:setVisible(true)
		tipPanel:setVisible(false)
		actBtn:setGray(true)

		local function callFuncGo(sender, eventType)
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("VT_Exchange_AllClear")
			}))
		end

		mapButtonHandlerClick(nil, actBtn, {
			func = callFuncGo
		})

		count = times
	else
		allTipTxt:setVisible(false)
		tipPanel:setVisible(true)
		tipPanel:setTouchEnabled(true)
		tipPanel:addClickEventListener(function()
			self:clickTipPanel(data, duigou, true)
		end)
		self:clickTipPanel(data, duigou)

		if status then
			actBtn:setGray(false)

			local function callFuncGo(sender, eventType)
				local data = {
					activityId = self._activity:getId(),
					id = data.id,
					count = canExchangeAmount,
					callback = function()
						if DisposableObject:isDisposed(self) then
							return
						end

						self:setBubleView(KBubleEnterStatus.ExchangeEnd)

						local offsetY = self._tableView:getContentOffset().y

						self._tableView:reloadData()
						self._tableView:setContentOffset(cc.p(0, offsetY))
					end
				}
				local activityExchangeView = self:getInjector():getInstance("ActivityExchangeTipView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, activityExchangeView, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, nil))
			end

			mapButtonHandlerClick(nil, actBtn, {
				func = callFuncGo
			})
		else
			actBtn:setGray(true)

			local function callFuncGo(sender, eventType)
				self:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("VT_Exchange_Lack")
				}))
			end

			mapButtonHandlerClick(nil, actBtn, {
				func = callFuncGo
			})
		end
	end

	actBtn:getChildByFullName("Text_str"):setString(Strings:get("VT_Exchange_Button_Exchange") .. "(" .. tostring(count) .. "/" .. tostring(times) .. ")")
end

function ActivityExchangeMediator:clickTipPanel(data, view, click)
	local rid = self._developSystem:getPlayer():getRid()
	local key = "ActivityExchange_" .. self._activity:getId() .. "_" .. rid .. "_" .. data.index
	local value = cc.UserDefault:getInstance():getBoolForKey(key, (data.config.isRemind == 0 or nil) and false)

	if click then
		value = not value
	end

	cc.UserDefault:getInstance():setBoolForKey(key, value)
	view:setVisible(value)

	if click then
		self._parentMediator:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	end
end

function ActivityExchangeMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._refreshPanel then
		self._refreshPanel:setVisible(false)
	end
end

function ActivityExchangeMediator:setTimer()
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

function ActivityExchangeMediator:setTimer1()
	self._refreshPanel:setVisible(true)
	self._refreshTime:setString(self._activity:getTimeStr1())
end
