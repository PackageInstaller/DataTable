-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagURMapMediator.lua

BagURMapMediator = class("BagURMapMediator", DmAreaViewMediator, _M)

BagURMapMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
BagURMapMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")

local kBtnHandlers = {
	["main.Button_left"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.Button_right"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["main.Panel_bottom.btn_reward"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBottomReward"
	},
	["main.Button_1"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickShop"
	},
	btn_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}
local showNum = 5
local itemPos = {
	{
		cc.p(79, 250)
	},
	{
		cc.p(95, 290),
		cc.p(52, 180)
	},
	{
		cc.p(57, 374),
		cc.p(95, 262),
		cc.p(62, 148)
	},
	{
		cc.p(93, 375),
		cc.p(64, 284),
		cc.p(95, 201),
		cc.p(57, 111)
	},
	{
		cc.p(61, 396),
		cc.p(95, 323),
		cc.p(53, 258),
		cc.p(92, 185),
		cc.p(58, 110)
	}
}

function BagURMapMediator:initialize()
	super.initialize(self)
end

function BagURMapMediator:dispose()
	super.dispose(self)
end

function BagURMapMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_URMAP_GetReward_SUCC, self, self.resumeWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REWARD_SUCC, self, self.refreshBottomView)

	local developSystem = self:getInjector():getInstance("DevelopSystem")

	self._bagSystem = developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
end

function BagURMapMediator:enterWithData(data)
	self:setupView()
	self:runStartAnim()
end

function BagURMapMediator:resumeWithData()
	self:initData()

	local offsetX = self._tableView:getContentOffset().x

	self._tableView:reloadData()
	self._tableView:setContentOffset(cc.p(offsetX, 0))
	self:refreshBottomView()
end

function BagURMapMediator:setupView()
	self:setupTopInfoWidget()

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("listView")
	self._cloneCell = self._main:getChildByName("Panel_clone")

	self._cloneCell:setVisible(false)

	self._panelBottom = self._main:getChildByName("Panel_bottom")
	self._leftBtn = self._main:getChildByFullName("Button_left")
	self._rightBtn = self._main:getChildByFullName("Button_right")

	local bg = self._main:getChildByName("bg")

	bg:ignoreContentAdaptWithSize(true)
	bg:loadTexture("asset/scene/scene_exhibition_1.jpg", ccui.TextureResType.localType)
	self:initData()
	self:createTableView()
	self:refreshBottomView()
end

function BagURMapMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(999)

	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("URMap_Unlock")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("URMaps_Name")
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function BagURMapMediator:initData()
	self._taskList = self._bagSystem:getURMapInfo()
end

function BagURMapMediator:createTableView()
	local size = self._cloneCell:getContentSize()
	local tableView = cc.TableView:create(cc.size(1086, 560))

	local function scrollViewDidScroll(table)
		if not table:isDragging() and not table:isTouchMoved() then
			self:setBtnVisible()
		end
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
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local cloneCell = self._cloneCell:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setName("main")

			local posY = index % 2 == 0 and 50 or 0

			cloneCell:setPosition(cc.p(0, posY))
		end

		self:updataCell(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setDelegate()
	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(0, 0))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._listView)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function BagURMapMediator:updataCell(cell, index)
	local mainView = cell:getChildByName("main")
	local nodeAnim = mainView:getChildByName("Image_1")
	local data = self._taskList[index].config
	local state = self._taskList[index].state
	local pro1, pro2 = self._bagSystem:getProcessByURMapId(data.Id)

	nodeAnim:removeAllChildren()

	local animName = pro2 <= pro1 and "eff_guizi4chang_shengmingguanzhujiemian" or "eff_guizi3chang_shengmingguanzhujiemian"
	local poss = pro2 <= pro1 and {
		18,
		18
	} or {
		18,
		14
	}
	local anim = cc.MovieClip:create(animName)

	anim:addTo(nodeAnim):posite(poss[1], poss[2])

	local name = mainView:getChildByName("targetName_0")

	name:setString(Strings:get(data.MapName))

	local panelReward = mainView:getChildByName("Panel_reward")
	local redPoint = panelReward:getChildByName("redPoint")

	redPoint:setVisible(false)

	local img_select = panelReward:getChildByName("Image_select")

	img_select:setVisible(false)

	if state == UPMapStatus.KFinish_WeiLingQu then
		redPoint:setVisible(true)
	elseif state == UPMapStatus.kFinish_YiLingQu then
		img_select:setVisible(true)
	end

	local equipList = data.EquipList
	local poslist = itemPos[#equipList]

	for i = 1, 5 do
		local node = mainView:getChildByFullName("icon" .. i)

		node:removeAllChildren()

		if i <= #equipList then
			node:setPosition(poslist[i])

			local hasEquip = self._bagSystem:getHasURMapEquipId(data.Id, equipList[i].equipment)
			local animName = hasEquip and "eff_yi11_shengmingguanzhujiemian" or "eff_wei21_shengmingguanzhujiemian"
			local anim = cc.MovieClip:create(animName)

			anim:addTo(node):center(node:getContentSize())

			local mc_node = anim:getChildByName("mc_icon")
			local param = {
				id = equipList[i].equipment
			}
			local equipIcon = IconFactory:createEquipPic(param, {
				ignoreScaleSize = true
			})

			equipIcon:setScale(0.22)
			equipIcon:addTo(mc_node):center(mc_node:getContentSize())
			equipIcon:setGray(not hasEquip)
		end
	end

	local Panel_process = mainView:getChildByFullName("Panel_process")

	Panel_process:getChildByFullName("targetName"):setString(pro1 .. "/" .. pro2)
	Panel_process:getChildByFullName("LoadingBar_1"):setPercent(pro1 / pro2 * 100)

	local function callFuncGo(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local beganPos = sender:getTouchBeganPosition()
		local endPos = sender:getTouchEndPosition()

		if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
			local view = self:getInjector():getInstance("BagURMapViewDetailView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				urMapIndex = index
			}))
		end
	end

	local touchPanl = mainView:getChildByFullName("Panel_335")

	touchPanl:setSwallowTouches(false)
	mapButtonHandlerClick(nil, touchPanl, {
		func = callFuncGo
	})
	panelReward:setSwallowTouches(true)

	local function callback(sender, eventType)
		self:onClickGetBox(data, state, index)
	end

	mapButtonHandlerClick(nil, panelReward, {
		func = callback
	})
end

function BagURMapMediator:refreshBottomView()
	local tl = self._taskSystem:getTaskListByType(TaskType.kURMap)
	local taskValue = tl[#tl]:getTaskValueList()
	local tar = taskValue[1].targetValue
	local total = self._bagSystem:getProcessOfURMap()
	local cur = self._bagSystem:getURCount()
	local text_cur = self._panelBottom:getChildByFullName("text_process1")
	local text_total = self._panelBottom:getChildByFullName("text_process2")

	text_cur:setString(cur)
	text_total:setString("/" .. tar)
	self._panelBottom:getChildByFullName("LoadingBar_2"):setPercent(cur / total * 100)

	local rewardPoint = self._panelBottom:getChildByFullName("btn_reward.redPoint")
	local hasRedPoint = self._taskSystem:hasUnreceivedTask(TaskType.kURMap)

	rewardPoint:setVisible(hasRedPoint or self._bagSystem:checkURMapCountKey())

	local btn = self._main:getChildByFullName("Button_1")
	local unlockSystem = self:getInjector():getInstance(SystemKeeper)

	if not unlockSystem:isUnlock("Shop_URMap_Unlock") then
		btn:setVisible(false)
	end

	btn:getChildByFullName("Text_1"):setString(Strings:get("Shop_URMap"))
end

function BagURMapMediator:onClickGetBox(data, state, index)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	if state == UPMapStatus.KFinish_WeiLingQu then
		self._bagSystem:getURSuiteRewards(data.Id)

		return
	end

	local pro1, pro2 = self._bagSystem:getProcessByURMapId(data.Id)
	local color = pro2 <= pro1 and "#00ff00" or "#ff0000"
	local info = {
		title = "URMap_UI2",
		isRich = true,
		descId = "Condi_URMap_URCount_Des",
		liveness = #data.EquipList,
		rewardId = data.UnlockReward,
		hasGet = state == UPMapStatus.kFinish_YiLingQu,
		desc = Strings:get("URMapUnlock_Reward_Des", {
			fontName = TTF_FONT_FZYH_M,
			color = color,
			NUM1 = pro1,
			NUM2 = pro2
		})
	}
	local view = self:getInjector():getInstance("TaskBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, info))
end

function BagURMapMediator:setBtnVisible()
	if self._tableView then
		self._leftBtn:setVisible(true)
		self._rightBtn:setVisible(true)

		local offsetX = self._tableView:getContentOffset().x

		if offsetX >= self._tableView:maxContainerOffset().x then
			self._leftBtn:setVisible(false)
		elseif offsetX <= self._tableView:minContainerOffset().x then
			self._rightBtn:setVisible(false)
		end
	end
end

function BagURMapMediator:onClickGo(data)
	local url = data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function BagURMapMediator:resumeView()
	self._tableView:reloadData()
end

function BagURMapMediator:onClickGet(data, index)
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

function BagURMapMediator:onClickLeft()
	local size = self._cloneCell:getContentSize()
	local offsetX = self._tableView:getContentOffset().x

	self._tableView:setContentOffset(cc.p(offsetX + size.width * 2.5, 0))
end

function BagURMapMediator:onClickRight()
	local size = self._cloneCell:getContentSize()
	local offsetX = self._tableView:getContentOffset().x

	self._tableView:setContentOffset(cc.p(offsetX - size.width * 2.5, 0))
end

function BagURMapMediator:onClickBottomReward()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local function callback()
		self:refreshBottomView()
	end

	local view = self:getInjector():getInstance("BagURMapRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		call = callback
	}))
end

function BagURMapMediator:runStartAnim()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/bagURMap.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.2)

	local rightBtn = self._main:getChildByName("Button_right")
	local leftBtn = self._main:getChildByName("Button_left")
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	rightBtn:setOpacity(0)
	leftBtn:setOpacity(0)
	topInfoNode:setOpacity(0)
	self._tableView:stopScroll()
	self._tableView:reloadData()
	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, showNum do
		allCells[i]:setOpacity(50)
	end

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "iconAnim1" then
			allCells[3]:runAction(cc.FadeIn:create(0.17))
			self:runListAnim()
		end

		if str == "iconAnim2" then
			allCells[2]:runAction(cc.FadeIn:create(0.17))
			allCells[4]:runAction(cc.FadeIn:create(0.17))
		end

		if str == "iconAnim3" then
			allCells[1]:runAction(cc.FadeIn:create(0.17))
			allCells[5]:runAction(cc.FadeIn:create(0.17))
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
	performWithDelay(self:getView(), function()
		topInfoNode:runAction(cc.FadeIn:create(0.15))
		rightBtn:runAction(cc.FadeIn:create(0.15))
		leftBtn:runAction(cc.FadeIn:create(0.15))
	end, 0.5)
end

function BagURMapMediator:runListAnim()
	local allCells = self._tableView:getContainer():getChildren()

	local function func(i)
		local child = allCells[i]

		if child and child:getChildByName("main") then
			local cell = child:getChildByName("main")
			local animNode = cell:getChildByFullName("Image_2")
			local data = self._taskList[i].config
			local pro1, pro2 = self._bagSystem:getProcessByURMapId(data.Id)
			local animName = pro2 <= pro1 and "chengguang_shengmingguanzhujiemian" or "ziguang_shengmingguanzhujiemian"
			local anim = cc.MovieClip:create(animName)
			local poss = pro2 <= pro1 and {
				18,
				50
			} or {
				18,
				70
			}

			anim:addTo(animNode):posite(poss[1], poss[2])
			anim:addEndCallback(function(cid, mc)
				mc:stop()
			end)
			performWithDelay(self:getView(), function()
				local anim = cc.MovieClip:create("eff_saoguang_shengmingguanzhujiemian")

				anim:addTo(animNode):posite(0, -50)
				anim:addCallbackAtFrame(60, function(cid, mc)
					mc:stop()
				end)
			end, 0.13333333333333333)
		end
	end

	func(3)
	performWithDelay(self:getView(), function()
		func(2)
		func(4)
		self._tableView:setTouchEnabled(true)
	end, 0.13333333333333333)
	performWithDelay(self:getView(), function()
		func(1)
		func(5)
	end, 0.26666666666666666)
end

function BagURMapMediator:onClickBack()
	self:dismiss()
end

function BagURMapMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "URMap_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {}
	}))
end

function BagURMapMediator:onClickShop()
	local shopSystem = self:getInjector():getInstance("ShopSystem")

	shopSystem:requestGetShop("Shop_URMap", function()
		shopSystem:tryEnter({
			shopId = "Shop_Normal",
			rightTabIndex = 5
		})
	end)
end
