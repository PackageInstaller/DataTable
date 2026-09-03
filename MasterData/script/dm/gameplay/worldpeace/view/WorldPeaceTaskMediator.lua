-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceTaskMediator.lua

WorldPeaceTaskMediator = class("WorldPeaceTaskMediator", DmPopupViewMediator, _M)

WorldPeaceTaskMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceTaskMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function WorldPeaceTaskMediator:initialize()
	super.initialize(self)
end

function WorldPeaceTaskMediator:dispose()
	super.dispose(self)
end

function WorldPeaceTaskMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._cellClone = self._main:getChildByName("cell")

	self._cellClone:setVisible(false)
end

function WorldPeaceTaskMediator:setupView(data)
	self._worldPeaceSystem:requestTaskInfo()

	if not self._init then
		self._init = true
		self._mainPlayer = self._worldPeaceSystem:getMainPlayer()
		self._setMatchLv = self._mainPlayer:getMatchLv()
		self._taskList = self._mainPlayer:getTask()

		self:createTableView()
		self.mapEventListener(self, self:getEventDispatcher(), EVT_WORLDPEACE_TASK_REFRESH, self, self.refreshView)
	else
		self:refreshView()
	end
end

function WorldPeaceTaskMediator:refreshView()
	self._taskList = self._mainPlayer:getTask()

	self._tableView:reloadData()
end

function WorldPeaceTaskMediator:createTableView()
	local size = self._cellClone:getContentSize()
	local tableView = cc.TableView:create(cc.size(860, 435))

	local function scrollViewDidScroll(table)
		return
	end

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
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local cloneCell = self._cellClone:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setTag(111):posite(0, 0)
		end

		self:updateCell(cell:getChildByTag(111), idx + 1)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._main):posite(247, 49)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(36)

	self._tableView = tableView

	self._tableView:reloadData()
end

function WorldPeaceTaskMediator:updateCell(cell, index)
	local data = self._taskList[index]
	local bg = index % 2 ~= 0 and "TSDH_sc9_xinxidiqian.png" or "TSDH_sc9_xinxidisheng.png"

	cell:getChildByFullName("Image_di"):loadTexture(bg, 1)

	local config = ConfigReader:getRecordById("ClubMapTask", data.taskId)
	local descText = cell:getChildByName("Text_desc")

	descText:setString(Strings:get(config.Desc or ""))

	local bar = cell:getChildByName("LoadingBar")
	local percent = data.percent

	bar:setPercent(percent * 100)

	local valueText = cell:getChildByName("Text_value")

	valueText:setString(data.current .. "/" .. data.target)

	local rewardNode = cell:getChildByName("reward")

	rewardNode:removeAllChildren()

	local rewards = ConfigReader:getRecordById("Reward", (self._setMatchLv == 2 or nil) and config.reward_silver).Content

	for i = 1, #rewards do
		local reward = rewards[i]

		if reward then
			local function func()
				local icon = IconFactory:createRewardIcon(reward, {
					showAmount = true,
					isWidget = true
				})

				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})
				icon:setScaleNotCascade(0.45)
				icon:addTo(rewardNode):posite((i - 1) * 65 + 25, 25)
			end

			rewardNode:runAction(DelayAction:create(func, (i - 1) * 0.1))
		end
	end

	local status = data.taskStatus
	local goBtn = cell:getChildByName("btn_go")
	local getBtn = cell:getChildByName("btn_get")
	local doneImg = cell:getChildByName("Image_done")

	doneImg:setVisible(status == 2)
	goBtn:setVisible(status == 0)
	getBtn:setVisible(status == 1)
	getBtn:addClickEventListener(function(sender)
		self:onClickGet(sender, data)
	end)
end

function WorldPeaceTaskMediator:onClickGet(sender, data)
	local status = data.taskStatus

	if status == 1 then
		self._worldPeaceSystem:requestTaskReward({
			taskId = data.taskId
		}, function(response)
			if DisposableObject:isDisposed(self) then
				return
			end

			local rewards = response.data.rewards

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 200
				}, {
					rewards = rewards
				}))
			end

			self:refreshView()
		end)
	end
end
