-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceEmBattleForScheduleMediator.lua

PetRaceEmBattleForScheduleMediator = class("PetRaceEmBattleForScheduleMediator", DmAreaViewMediator)

PetRaceEmBattleForScheduleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PetRaceEmBattleForScheduleMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
PetRaceEmBattleForScheduleMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {}
local desRoundInfo = {
	Strings:get("Petrace_Text_19"),
	Strings:get("Petrace_Text_20"),
	Strings:get("Petrace_Text_21")
}
local teamDesInfo = {
	Strings:get("Petrace_Text_7"),
	Strings:get("Petrace_Text_9"),
	Strings:get("Petrace_Text_10"),
	Strings:get("Petrace_Text_11"),
	Strings:get("Petrace_Text_12")
}
local kCellWidth, kCellHeight, kCellGap = 376, 170, 5
local costLimit = 15

function PetRaceEmBattleForScheduleMediator:onClickOK()
	self._state = self._petRaceSystem:getMyMatchState()

	local cdtime = self:getCD(self._targetTime)

	if self._state ~= 2 or cdtime <= 0 then
		return
	end

	local args = {}

	args.order = self._order

	self._petRaceSystem:adjustTeamOrder(function()
		self:showTip(Strings:get("Petrace_Text_14"))
	end, args, true)
end

function PetRaceEmBattleForScheduleMediator:onClickAdjust()
	self._state = self._petRaceSystem:getMyMatchState()

	local cdtime = self:getCD(self._targetTime)

	if self._state ~= 2 or cdtime <= 0 then
		return
	end

	local view = self:getInjector():getInstance("PetRaceAllTeamEmBattleForScheduleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		targetTime = self._targetTime
	})

	self:dispatch(event)
end

function PetRaceEmBattleForScheduleMediator:initialize()
	super.initialize(self)
end

function PetRaceEmBattleForScheduleMediator:dispose()
	super.dispose(self)

	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end
end

function PetRaceEmBattleForScheduleMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	costLimit = self._petRaceSystem:getMaxCost()
end

function PetRaceEmBattleForScheduleMediator:updateFightdata()
	local embattleInfo = self._petRaceSystem:getEmbattleInfo(self._round)

	self._embattleInfo = table.deepcopy(embattleInfo)
	self._order = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	}
end

function PetRaceEmBattleForScheduleMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_ADJUSTTEAMORDER, self, self.onClickOkSuc)
end

function PetRaceEmBattleForScheduleMediator:enterWithData(data)
	self._targetTime = data.targetTime
	self._scoreMaxRound = self._petRaceSystem:getScoreMaxRound()
	self._state = self._petRaceSystem:getMyMatchState()
	self._round = self._petRaceSystem:getRound()
	self._knockout = self._petRaceSystem:knockout()
	self._roundList = self._petRaceSystem:getRoundList()

	self:setupTopInfoWidget()
	self:updateFightdata()
	self:setupView()
	self:createTeamTableView()

	if self._round < 11 then
		self._isPrelim = true

		self:initPrelimEmbattle()
		self._node_embattle_prelim:setVisible(true)
	else
		self:initFinalEmbattle()
		self._node_embattle_final:setVisible(true)
	end

	self:updateViewInfo()
	self:updateCD()
	self:registerTouchEvent()
	self:mapEventListeners()
	self:createAnim()
end

function PetRaceEmBattleForScheduleMediator:setupView()
	self._panel_base = self:getView():getChildByName("Panel_base")
	self._node_embattle_prelim = self._panel_base:getChildByName("Node_embattle_prelim")
	self._node_embattle_final = self._panel_base:getChildByName("Node_embattle_final")
	self._text_name_l = self._node_embattle_prelim:getChildByFullName("Text_name_l")

	self._text_name_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_name_r = self._node_embattle_prelim:getChildByFullName("Text_name_r")

	self._text_name_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_power_l = self._node_embattle_prelim:getChildByFullName("Node_info_l.Text_power")

	self._text_power_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_power_r = self._node_embattle_prelim:getChildByFullName("Node_info_r.Text_power")

	self._text_power_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_cost_l = self._node_embattle_prelim:getChildByFullName("Node_info_l.Text_cost")

	self._text_cost_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_cost_r = self._node_embattle_prelim:getChildByFullName("Node_info_r.Text_cost")

	self._text_cost_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_level_l = self._node_embattle_prelim:getChildByFullName("Text_lv_l")

	self._text_level_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_level_r = self._node_embattle_prelim:getChildByFullName("Text_lv_r")

	self._text_level_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_first_l = self._node_embattle_prelim:getChildByFullName("Node_info_l.Text_first")

	self._text_first_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._text_first_r = self._node_embattle_prelim:getChildByFullName("Node_info_r.Text_first")

	self._text_first_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._final_name_r = self._node_embattle_final:getChildByName("Text_name_r")

	self._final_name_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._final_name_l = self._node_embattle_final:getChildByName("Text_name_l")

	self._final_name_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._final_lv_r = self._node_embattle_final:getChildByName("Text_lv_r")

	self._final_lv_r:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._final_lv_l = self._node_embattle_final:getChildByName("Text_lv_l")

	self._final_lv_l:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._node_anim = self:getView():getChildByName("Node_anim")
	self._node_time_prelim = self._node_embattle_prelim:getChildByName("Node_time")
	self._node_time_final = self._node_embattle_final:getChildByName("Node_time")

	self._node_embattle_prelim:setVisible(false)
	self._node_embattle_final:setVisible(false)
end

function PetRaceEmBattleForScheduleMediator:getCD(targetTime)
	return math.floor(targetTime - self._gameServerAgent:remoteTimestamp())
end

function PetRaceEmBattleForScheduleMediator:updateCD()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	local function updataTime()
		self._petRaceSystem:updateTimeDes(self._node_time_prelim, self._round, self._state, self._targetTime)
		self._petRaceSystem:updateTimeDes(self._node_time_final, self._round, self._state, self._targetTime)
	end

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		updataTime()
	end, 1, false)

	updataTime()
end

function PetRaceEmBattleForScheduleMediator:initPrelimEmbattle()
	self._node_embattle_prelim:setVisible(true)

	self._node_9frame_l = self._node_embattle_prelim:getChildByName("Node_frame9_l")
	self._node_9frame_r = self._node_embattle_prelim:getChildByName("Node_frame9_r")
	self.Node_frame9_l_end = self._node_embattle_prelim:getChildByName("Node_frame9_l_end")
	self._node_myTeam_container = self._node_embattle_prelim

	local myInfo = self._petRaceSystem:getMyCurrentEmbattleInfo(self._round)
	local enemyInfo = self._petRaceSystem:getEnemyCurrentEmbattleInfo(self._round)

	self._petRaceSystem:refreshNineEmbattle(myInfo.embattle, self._node_9frame_l)
	self._petRaceSystem:refreshNineEmbattle(enemyInfo.embattle, self._node_9frame_r)
end

function PetRaceEmBattleForScheduleMediator:initFinalEmbattle()
	self._node_embattle_final:setVisible(true)

	self._node_team_l = self._node_embattle_final:getChildByFullName("Node_team_l")
	self._node_team_r = self._node_embattle_final:getChildByFullName("Node_team_r")
	self._node_myTeam_container = self._node_embattle_final

	local myInfo = self._petRaceSystem:getMyCurrentEmbattleInfo(self._round)
	local enemyInfo = self._petRaceSystem:getEnemyCurrentEmbattleInfo(self._round)

	self:refreshFinalTeam(myInfo.embattleAll or {}, self._node_team_l, true)
	self:refreshFinalTeam(enemyInfo.embattleAll or {}, self._node_team_r)
end

function PetRaceEmBattleForScheduleMediator:getRoleIcon(data)
	return self._petRaceSystem:getRoleIcon(data)
end

function PetRaceEmBattleForScheduleMediator:updateViewInfo()
	local myCost = 0
	local myCombat = 0
	local enemyCost = 0
	local enemyCombat = 0
	local mySpeed = 0
	local enemySpeed = 0
	local myInfo = self._petRaceSystem:getMyCurrentEmbattleInfo(self._round)
	local enemyInfo = self._petRaceSystem:getEnemyCurrentEmbattleInfo(self._round)

	if self._round < 11 then
		myCost = myInfo.cost or 0
		myCombat = myInfo.combat or 0
		mySpeed = myInfo.speed or 0
		enemyCost = enemyInfo.cost or 0
		enemyCombat = enemyInfo.combat or 0
		enemySpeed = enemyInfo.speed or 0
	else
		for i = 1, 3 do
			if myInfo.embattleAll and myInfo.embattleAll[i] then
				local info = myInfo.embattleAll[i]

				myCost = myCost + info.cost or 0
				myCombat = myCombat + info.combat or 0
				mySpeed = mySpeed + info.speed or 0
			end

			if enemyInfo.embattleAll and enemyInfo.embattleAll[i] then
				local info = enemyInfo.embattleAll[i]

				enemyCost = enemyCost + info.cost or 0
				enemyCombat = enemyCombat + info.combat or 0
				enemySpeed = enemySpeed + info.speed or 0
			end
		end
	end

	self._text_name_l:setString(myInfo.name)
	self._text_level_l:setString("Lv." .. myInfo.level)
	self._text_power_l:setString(tostring(myCombat))
	self._text_cost_l:setString(myCost)
	self._text_first_l:setString(mySpeed)
	self._text_name_r:setString(enemyInfo.name)
	self._text_level_r:setString("Lv." .. enemyInfo.level)
	self._text_power_r:setString(tostring(enemyCombat))
	self._text_cost_r:setString(enemyCost)
	self._text_first_r:setString(enemySpeed)
	self._final_name_l:setString(myInfo.name)
	self._final_lv_l:setString("Lv." .. myInfo.level)
	self._final_name_r:setString(enemyInfo.name)
	self._final_lv_r:setString("Lv " .. enemyInfo.level)
end

function PetRaceEmBattleForScheduleMediator:createTeamTableView()
	local listLocator = self:getView():getChildByFullName("Panel_bottom.Panel_listLocator")

	if not listLocator then
		return
	end

	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._embattleInfo
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return kCellWidth + kCellGap, kCellHeight
	end

	local function cellAtIndex(tableView, index)
		index = index + 1

		local data = {}

		data.embattleInfo = self._embattleInfo[index] or {}

		local cell = tableView:dequeueCell()

		if self._round <= self._scoreMaxRound then
			data.des = string.format(teamDesInfo[1], index)

			if not self._roundList[index] then
				local info = {}

				if info.winId and #info.winId > 0 then
					data.isWin = info.userId == info.winId
				end
			end
		elseif index == 10 then
			data.des = string.format(teamDesInfo[5])
		else
			local desIndex = math.floor((index - 1) / 3) + 2

			data.des = string.format(teamDesInfo[desIndex], (index - 1) % 3 + 1)

			local teamResultIndex = math.ceil(index / 3) + self._scoreMaxRound

			if not self._roundList[teamResultIndex] then
				local info = {}

				if info.winId and #info.winId > 0 then
					data.isWin = info.userId == info.winId
				end
			end
		end

		if cell == nil then
			cell = cc.TableViewCell:new()

			local realCell = self:getInjector():getInstance("PetRaceTeamCellForSchedule")

			cell.m_cellMediator = self:getInjector():instantiate(PetRaceTeamCellForSchedule, {
				view = realCell
			})

			cell:addChild(realCell)
		end

		cell.m_cellMediator:update(data, index)

		cell.m_cellMediator.showIndex = index

		return cell
	end

	local function onScroll()
		return
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setPositionX(listLocator:getPositionX() - viewSize.width / 2)
	tableView:setPositionY(listLocator:getPositionY())
	tableView:setDelegate()
	listLocator:getParent():addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)

	self._tableView = tableView

	listLocator:removeFromParent(true)
	self._tableView:reloadData()

	local shiftX = 0 - (self._round <= self._scoreMaxRound and self._round - 1 or (self._round - self._scoreMaxRound - 1) * 3) * (kCellWidth + kCellGap)

	self._tableView:setContentOffset(cc.p(shiftX, 0))
end

function PetRaceEmBattleForScheduleMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kHonor,
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPetRace
		},
		btnHandler = bind1(self.onClickBack, self),
		title = Strings:get("Petrace")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function PetRaceEmBattleForScheduleMediator:showTip(str)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = str
	}))
end

function PetRaceEmBattleForScheduleMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1")
		self:dismiss()
	end
end

function PetRaceEmBattleForScheduleMediator:tableViewReloadData(view)
	local offset = view:getContentOffset()

	view:reloadData()
	view:setContentOffset(offset)
end

function PetRaceEmBattleForScheduleMediator:refreshEmbattle()
	self:tableViewReloadData(self._tableView)
	self:updateViewInfo()

	if self._isPrelim then
		if not self._embattleInfo[self._round] then
			local embattleInfo = {}

			self._petRaceSystem:refreshNineEmbattle(embattleInfo.embattle or {}, self._node_9frame_l)
		end
	else
		local startIndex = (self._round - 10 - 1) * 3
		local embattleAll = {}

		for i = 1, 3 do
			local info = {}
			local index = startIndex + i

			if not self._embattleInfo[index] then
				if not self._embattleInfo[index].embattle then
					local embattle = {}

					info.embattle = embattle
					info.combat = self._embattleInfo[index].combat or 0
					info.speed = self._petRaceSystem:getTeamSpeedByEmbattle(embattle) or 0
					info.cost = self._petRaceSystem:getTeamCostByEmbattle(embattle) or 0
					embattleAll[#embattleAll + 1] = info
				end
			end
		end

		self:refreshFinalTeam(embattleAll, self._node_team_l, true)
	end
end

function PetRaceEmBattleForScheduleMediator:onClickOkSuc(event)
	self:updateFightdata()
	self:refreshEmbattle()
end

function PetRaceEmBattleForScheduleMediator:dealMoveForPrelim()
	local iconPos = self._touchEmbattleIcon:convertToWorldSpace(cc.p(0, 0))

	iconPos.x = iconPos.x + kCellWidth / 2
	iconPos.y = iconPos.y + kCellHeight / 2

	local node_9frame_pos = self._node_9frame_l:convertToWorldSpace(cc.p(0, 0))
	local node_9frame_end_pos = self.Node_frame9_l_end:convertToWorldSpace(cc.p(0, 0))
	local rect = cc.rect(node_9frame_pos.x, node_9frame_pos.y, node_9frame_end_pos.x - node_9frame_pos.x, node_9frame_end_pos.y - node_9frame_pos.y)

	if cc.rectContainsPoint(rect, iconPos) and self._round ~= self._touchEmbattleIcon.index then
		self._order[self._round] = self._order[self._touchEmbattleIcon.index]
		self._order[self._touchEmbattleIcon.index] = self._order[self._round]
		self._embattleInfo[self._round] = self._embattleInfo[self._touchEmbattleIcon.index]
		self._embattleInfo[self._touchEmbattleIcon.index] = self._embattleInfo[self._round]

		self:refreshEmbattle()

		return true
	end
end

function PetRaceEmBattleForScheduleMediator:dealMoveForFinal()
	local selectIndex = 0

	for i = 1, 3 do
		local node_team = self._node_team_l:getChildByName("Node_team_" .. i)
		local targetPos = node_team:convertToWorldSpace(cc.p(0, 0))
		local curPos = self._touchEmbattleIcon:convertToWorldSpace(cc.p(0, 0))

		curPos.x = curPos.x + kCellWidth / 2
		curPos.y = curPos.y + kCellHeight / 2

		local rect = cc.rect(targetPos.x, targetPos.y, 500, 120)

		if cc.rectContainsPoint(rect, curPos) then
			selectIndex = i

			break
		end
	end

	if selectIndex > 0 then
		local targetIndex = (self._round - 10 - 1) * 3 + selectIndex

		self._order[targetIndex] = self._order[self._touchEmbattleIcon.index]
		self._order[self._touchEmbattleIcon.index] = self._order[targetIndex]
		self._embattleInfo[targetIndex] = self._embattleInfo[self._touchEmbattleIcon.index]
		self._embattleInfo[self._touchEmbattleIcon.index] = self._embattleInfo[targetIndex]

		self:refreshEmbattle()

		return true
	end
end

function PetRaceEmBattleForScheduleMediator:dealMove()
	return self._isPrelim and self:dealMoveForPrelim() or self:dealMoveForFinal()
end

function PetRaceEmBattleForScheduleMediator:onTouchBegan(touch, event)
	self._state = self._petRaceSystem:getMyMatchState()

	local cdtime = self:getCD(self._targetTime)

	if self._state ~= 2 or cdtime <= 0 then
		self:showTip(Strings:get("Petrace_Text_13"))

		return false
	end

	local pt = touch:getLocation()

	if not self._touchEmbattleIcon then
		for i = 0, #self._embattleInfo - 1 do
			local cell = self._tableView:cellAtIndex(i)

			if cell and cell.m_cellMediator then
				local m_cellMediator = cell.m_cellMediator
				local view = m_cellMediator:getView()
				local index = m_cellMediator.showIndex

				if view:getParent() and m_cellMediator:isWin() == nil then
					local pos = view:convertToWorldSpace(cc.p(0, 0))
					local rectTmp = cc.rect(pos.x, pos.y, kCellWidth, kCellHeight)

					if cc.rectContainsPoint(rectTmp, pt) then
						local cloneView = m_cellMediator:getBasePanel():clone()
						local localPos = self._node_myTeam_container:convertToNodeSpace(view:convertToWorldSpace(cc.p(0, 0)))

						cloneView:setPosition(localPos.x, localPos.y)
						cloneView:setOpacity(125)
						cloneView:setVisible(false)
						self._node_myTeam_container:addChild(cloneView)

						self._touchEmbattleIcon = cloneView
						self._touchEmbattleIcon.index = index

						if view:getChildByFullName("Panel_base.Image_bg_select") then
							view:getChildByFullName("Panel_base.Image_bg_select"):setVisible(true)
						end

						break
					end
				end
			end
		end
	end

	if self._touchEmbattleIcon then
		local x, y = self._touchEmbattleIcon:getPosition()

		self._touchEmbattleIcon.originalPos = {
			x = x,
			y = y
		}

		self._touchEmbattleIcon:setLocalZOrder(99)

		return true
	end

	return false
end

function PetRaceEmBattleForScheduleMediator:onTouchMoved(touch, event)
	local curp = touch:getLocation()
	local startP = touch:getStartLocation()
	local diffx, diffy = curp.x - startP.x, curp.y - startP.y
	local localPos = self._touchEmbattleIcon:getParent():convertToNodeSpace(curp)

	if math.abs(diffy) > 20 then
		self._touchEmbattleIcon:setVisible(true)
		self.listener:setSwallowTouches(true)
		self._touchEmbattleIcon:setPosition(localPos)
	end
end

function PetRaceEmBattleForScheduleMediator:onTouchEnded(touch, event)
	self._state = self._petRaceSystem:getMyMatchState()

	local cdtime = self:getCD(self._targetTime)
	local moveSta = false

	if self._state ~= 2 or cdtime <= 0 then
		self:showTip(Strings:get("Petrace_Text_13"))
	else
		moveSta = self:dealMove()
	end

	if self._touchEmbattleIcon then
		self._touchEmbattleIcon:removeFromParent()

		self._touchEmbattleIcon = nil
	end

	self.listener:setSwallowTouches(false)

	if moveSta then
		self:onClickOK()
	end

	for i = 0, #self._embattleInfo - 1 do
		local cell = self._tableView:cellAtIndex(i)

		if cell and cell.m_cellMediator then
			local m_cellMediator = cell.m_cellMediator
			local view = m_cellMediator:getView()

			if view:getChildByFullName("Panel_base.Image_bg_select") then
				view:getChildByFullName("Panel_base.Image_bg_select"):setVisible(false)
			end
		end
	end
end

function PetRaceEmBattleForScheduleMediator:onTouchCanceled(touch, event)
	if self._touchEmbattleIcon then
		self._touchEmbattleIcon:removeFromParent()

		self._touchEmbattleIcon = nil
	end

	self.listener:setSwallowTouches(false)
end

function PetRaceEmBattleForScheduleMediator:registerTouchEvent()
	local function onTouched(touch, event)
		local eventType = event:getEventCode()

		if eventType == ccui.TouchEventType.began then
			return self:onTouchBegan(touch, event)
		elseif eventType == ccui.TouchEventType.moved then
			self:onTouchMoved(touch, event)
		elseif eventType == ccui.TouchEventType.ended then
			self:onTouchEnded(touch, event)
		else
			self:onTouchCanceled(touch, event)
		end
	end

	self.listener = cc.EventListenerTouchOneByOne:create()

	self.listener:setSwallowTouches(false)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_BEGAN)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_MOVED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_ENDED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_CANCELLED)

	local touchPanel = self:getView():getChildByName("Panel_touch")

	touchPanel:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, touchPanel)
end

function PetRaceEmBattleForScheduleMediator:refreshFinalTeam(data, node, isSelf)
	for i = 1, 3 do
		if not data[i] then
			local teamNode = node:getChildByName("Node_team_" .. i)

			teamNode:getChildByFullName("Panel_base.Text_cost"):setString((not data[i].cost or nil) and 0)
			teamNode:getChildByFullName("Panel_base.Text_speed"):setString(data[i].speed or 0)
			teamNode:getChildByFullName("Panel_base.Text_power"):setString(data[i].combat or 0)
			teamNode:getChildByFullName("Panel_base.Text_num"):setString(i)

			local node_role = teamNode:getChildByFullName("Panel_base.Node_role")

			self._petRaceSystem:refreshIconEmbattle(data[i].embattle or {}, node_role, isSelf)
		end
	end
end

function PetRaceEmBattleForScheduleMediator:createAnim()
	local anim = cc.MovieClip:create("all_shengshizhengba")

	anim:setPlaySpeed(2)
	anim:addTo(self._node_anim)
	anim:gotoAndPlay(0)
	anim:addEndCallback(function(cid, mc)
		mc:gotoAndPlay(0)
	end)

	local jjAnim = cc.MovieClip:create("jingjirukou_jingjirukou")

	jjAnim:setPosition(cc.p(0, 0))
	self._node_anim:addChild(jjAnim)
	jjAnim:addCallbackAtFrame(12, function()
		jjAnim:stop()
	end)
end
