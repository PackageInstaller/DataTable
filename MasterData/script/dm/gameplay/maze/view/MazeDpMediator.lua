-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeDpMediator.lua

MazeDpMediator = class("MazeDpMediator", DmPopupViewMediator, _M)

MazeDpMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	okbtn = "onClickEnableTalent",
	resetBtn = "onClickResetTalent"
}
local tcolor = {
	cc.c4b(80, 50, 20, 255),
	cc.c4b(101, 134, 42, 255),
	cc.c4b(255, 255, 255, 255),
	(cc.c4b(0, 0, 0, 255))
}

function MazeDpMediator:initialize()
	super.initialize(self)
end

function MazeDpMediator:dispose()
	super.dispose(self)
end

function MazeDpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeDpMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_TALENT_ENABLE_SUC, self, self.updateTalentTree)
end

function MazeDpMediator:dispose()
	super.dispose(self)
end

function MazeDpMediator:enterWithData(data)
	self:initData()
	self:initView()
	self:updateTalentTree()
	self:updateLastStar()
	self:updateBoxByData()
	self:updateDp()
	self:createTaskTableView()
	self:updateDpProgress()
	self:registTalentsTouch()
end

function MazeDpMediator:initView()
	self._taskClone = self:getView():getChildByFullName("dpjd.taskclone")
	self._taskPanel = self:getView():getChildByFullName("dpjd.taskPanel")
	self._leftPanel = self:getView():getChildByFullName("dpjd")

	self._leftPanel:setRotation(9)
end

function MazeDpMediator:initData()
	self._mazeEvent = self._mazeSystem:getMazeEvent()
end

function MazeDpMediator:registTalentsTouch()
	for i = 1, 10 do
		local touchmask = self:getView():getChildByFullName("dptree.talents.talent_" .. i)

		touchmask:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._talentIndex = i

				local server, config = self:getTalentByIndex(self._talentIndex)

				self:showSelectTalent(server, config)
			end
		end)
	end
end

function MazeDpMediator:showSelectTalent(datas, datac)
	local nameView = self:getView():getChildByFullName("Text_16")

	nameView:setString(Strings:get(datac.Name))

	local des = ""

	if datac.Type == "ATTR" then
		des = Strings:get(ConfigReader:getDataByNameIdAndKey("SkillAttrEffect", datac.Effect, "EffectDesc"))
	elseif datac.Type == "SPECIAL" then
		des = Strings:get(ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", datac.Effect, "EffectDesc"))
	end

	local descView = self:getView():getChildByFullName("Text_17")

	descView:setString(des)
	self:updateLastStar()
	print("datac.Effect--->", datac.Effect)
end

function MazeDpMediator:updateLastStar()
	local lastStar = self:getView():getChildByFullName("starV")

	self._lastStarNum = self._mazeEvent:getTalentStar() - self._mazeEvent:getTalentCost()

	if self._lastStarNum < 0 then
		self._lastStarNum = 0
	end

	lastStar:setString(self._lastStarNum)
end

function MazeDpMediator:getTalentByIndex(index)
	local talents = self._mazeEvent:getTalents()

	for k, v in pairs(talents) do
		local data = ConfigReader:getRecordById("PansLabTalent", k)
		local site = data.Site

		if index == site then
			return v, data
		end
	end

	return nil
end

function MazeDpMediator:updateTalentTree()
	local talents = self._mazeEvent:getTalents()
	local t_6, t_3
	local line_11 = self:getView():getChildByFullName("dptree.line.line_11")
	local line_12 = self:getView():getChildByFullName("dptree.line.line_12")

	for k, v in pairs(talents) do
		local data = ConfigReader:getRecordById("PansLabTalent", k)
		local index = data.Site
		local view = self:getView():getChildByFullName("dptree.talents.talent_" .. index)

		if index == 10 then
			if v then
				line_11:setGray(false)
				line_11:setOpacity(255)
			else
				line_11:setGray(true)
				line_11:setOpacity(153)
			end
		end

		if index == 10 then
			if v then
				line_12:setGray(false)
				line_12:setOpacity(255)
			else
				line_12:setGray(true)
				line_12:setOpacity(153)
			end
		end

		local line = self:getView():getChildByFullName("dptree.line.line_" .. index)

		if v then
			view:setOpacity(255)

			if line then
				line:setGray(false)
				line:setOpacity(255)
			end
		else
			view:setOpacity(153)

			if line then
				line:setGray(true)
				line:setOpacity(153)
			end
		end
	end

	self:updateLastStar()
	dump(talents, "talents")
end

function MazeDpMediator:updateDpProgress()
	local value = self._mazeEvent:getDp() .. "/" .. self._mazeEvent:getEventMaxDp()

	self:getView():getChildByFullName("dpjd.dp_value"):setString(value)
end

function MazeDpMediator:updateTaskList()
	for k, v in pairs(self._mazeEvent:getEventAllDpTask()) do
		local cellPanel = self._taskClone:clone()

		cellPanel:setPosition(0, self._taskPanel:getContentSize().height)

		local taskProgressCur, taskProgressNeeed = self._mazeEvent:getEventDpTaskProgressById(k)
		local tdesc = cellPanel:getChildByFullName("taskDesc")
		local tProgress = cellPanel:getChildByFullName("taskProgess")
		local tDp = cellPanel:getChildByFullName("taskDp")

		tdesc:setString(self._mazeEvent:getEventDpTaskDescById(k) .. "(" .. taskProgressCur .. "/" .. taskProgressNeeed .. ")")
		tDp:setString(self._mazeEvent:getEventDpTaskRewardById(k))
		tdesc:disableEffect()
		tProgress:disableEffect()
		tDp:disableEffect()

		if taskProgressNeeed <= taskProgressCur then
			self:setTextColor(tdesc, 2)
			self:setTextColor(tProgress, 2)
			self:setTextColor(tDp, 2)
		else
			self:setTextColor(tdesc, 4)
			self:setTextColor(tProgress, 4)
			self:setTextColor(tDp, 4)
		end

		self._taskPanel:addChild(cellPanel)
	end
end

function MazeDpMediator:setTextColor(text, clorr)
	text:getVirtualRenderer():disableEffect(1)
	text:setTextColor(tcolor[clorr])
end

function MazeDpMediator:createTaskTableView()
	local scrollPanel = self._taskPanel
	local cellPanel = self:getView():getChildByFullName("dpjd.taskclone")
	local tableView = cc.TableView:create(cc.size(520, 327))

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return cellPanel:getContentSize().width + 30, cellPanel:getContentSize().height + 2
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = cellPanel:clone()

			sprite:setPosition(0, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(123)

			local cell_Old = cell:getChildByTag(123)

			self:createTaskCell(cell_Old, idx + 1)
			cell:setTag(idx)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createTaskCell(cell_Old, idx + 1)
			cell:setTag(idx)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return self._mazeEvent:getEventDpTaskCount()
	end

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	scrollPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function MazeDpMediator:createTaskCell(cell, idx)
	local taskData = self._mazeEvent:getEventDpTaskByIndex(idx)

	if taskData == nil then
		return
	end

	local taskProgressCur = taskData.taskValues["0"].currentValue
	local taskProgressNeeed = taskData.taskValues["0"].targetValue
	local tdesc = cell:getChildByFullName("taskDesc")
	local tProgress = cell:getChildByFullName("taskProgess")
	local tDp = cell:getChildByFullName("taskDp")
	local desc = self._mazeEvent:getEventDpTaskDescById(taskData.taskId, self)

	tdesc:setString(desc .. "(" .. taskProgressCur .. "/" .. taskProgressNeeed .. ")")
	tProgress:setString("")
	tDp:setString(self._mazeEvent:getEventDpTaskRewardById(taskData.taskId))
	tdesc:disableEffect()
	tProgress:disableEffect()
	tDp:disableEffect()

	if taskProgressNeeed <= taskProgressCur then
		self:setTextColor(tdesc, 2)
		self:setTextColor(tProgress, 2)
		self:setTextColor(tDp, 2)
	else
		self:setTextColor(tdesc, 3)
		self:setTextColor(tProgress, 3)
		self:setTextColor(tDp, 3)
	end
end

function MazeDpMediator:checkPreTalentEnable(id)
	local precon = ConfigReader:getDataByNameIdAndKey("PansLabTalent", id, "Need")

	if #precon <= 0 then
		return true
	end

	for k, v in pairs(precon) do
		local talens = self._mazeEvent:getTalents()

		if not talens[v] then
			return false
		end
	end

	return true
end

function MazeDpMediator:checkStarEnough(id)
	local needstar = ConfigReader:getDataByNameIdAndKey("PansLabTalent", id, "Pay")

	if needstar > self._lastStarNum then
		return false
	end

	return true
end

function MazeDpMediator:onClickEnableTalent(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if self._talentIndex then
			local talents, talentc = self:getTalentByIndex(self._talentIndex)

			if not self:checkStarEnough(talentc.Id) then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("MAZE_TALENT_TIPS_STAR")
				}))

				return
			end

			if not self:checkPreTalentEnable(talentc.Id) then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("MAZE_TALENT_TIPS_PRE")
				}))

				return
			end

			self._mazeSystem:requestMazeEnableTalent(self._mazeEvent:getConfigId(), talentc.Id)
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("MAZE_TALENT_SELECT")
			}))
		end
	end
end

function MazeDpMediator:onClickResetTalent(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local talents, talentc = self:getTalentByIndex(self._talentIndex)

		self._mazeSystem:requestMazeResetTalent(self._mazeEvent:getConfigId())
	end
end

function MazeDpMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end

function MazeDpMediator:initAllBox()
	for i = 1, 5 do
		local box = self:getView():getChildByFullName("dpjd.box_" .. i)

		box:setVisible(false)
	end
end

function MazeDpMediator:updateDp()
	local curDp = self._mazeEvent:getDp()
	local maxDp = self._mazeEvent:getEventMaxDp()
	local loadingBar = self:getView():getChildByFullName("dpjd.loadingBar")

	loadingBar:setPercent(100 * (curDp / maxDp))
end

function MazeDpMediator:updateBoxByData()
	self:initAllBox()

	local dpconfigrewards = self._mazeEvent:getEventConfigDpReward()
	local dpSRewards = self._mazeEvent:getDpGotRewards()

	dump(dpconfigrewards, "dpconfigrewards")
	dump(dpSRewards, "dpSRewards")

	local box_1 = self:getView():getChildByFullName("dpjd.box_1")

	for i = 1, #dpconfigrewards do
		local box = self:getView():getChildByFullName("dpjd.box_" .. i)

		box:setPosition(box_1:getPositionX() + (i - 1) * (345 / #dpconfigrewards + 10), box_1:getPositionY())
		box:setVisible(i <= #dpconfigrewards)

		local canValue = self._mazeEvent:getBoxCanGetDp(i)
		local can = canValue <= self._mazeEvent:getDp()
		local state = 1

		if can then
			state = 2

			if self._mazeEvent:haveGetRewards(canValue) then
				state = 3
			end
		end

		self:setBoxState(box, state)
	end
end

function MazeDpMediator:setBoxState(box, state)
	box:getChildByFullName("normal"):setVisible(state == 1)
	box:getChildByFullName("canReceive"):setVisible(state == 2)
	box:getChildByFullName("hasReceive"):setVisible(state == 3)
end
