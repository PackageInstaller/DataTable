-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassShopMediator.lua

PassShopMediator = class("PassShopMediator", DmPopupViewMediator, _M)

PassShopMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassShopMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kNum = 4
local kBtnHandlers = {}

function PassShopMediator:initialize()
	super.initialize(self)
end

function PassShopMediator:dispose()
	self:stopEffect()
	super.dispose(self)

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function PassShopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_REFRESH, self, self.doPassPortRefresh)
end

function PassShopMediator:removeTableView()
	self:getView():stopAllActions()

	if self._tableView then
		self._tableView:removeFromParent()

		self._tableView = nil
	end
end

function PassShopMediator:stopEffect()
	if self._passSpineTalkVoice ~= nil then
		self._passSpineTalkVoice:stopEffect()
	end
end

function PassShopMediator:setTabIndex(index)
	self._tabIndex = index
end

function PassShopMediator:doPassPortRefresh()
	self:refreshData()
	self:refreshView()
end

function PassShopMediator:setupView(parent)
	self._parent = parent

	self:initData()
	self:initWidget()
	self:initTableView()
end

function PassShopMediator:initData()
	self._exchangeList = self._passSystem:getPassListModel():getPassShopList()
	self._showPassEnter, self._showPass, self._showPassShop = self._passSystem:checkShowPassAndPassShop()
end

function PassShopMediator:initWidget()
	self._mainPanel = self:getView():getChildByName("main")
	self._roleNode = self._mainPanel:getChildByName("roleNode")
	self._timeNode = self._mainPanel:getChildByName("timeNode")

	self._timeNode:getChildByName("name"):setString(Strings:get("Pass_UI58"))

	self._bubbleNode = self._mainPanel:getChildByName("bubbleNode")
	self._viewPanel = self._mainPanel:getChildByName("panel")
	self._cloneCell = self._mainPanel:getChildByName("cloneCell")

	self._cloneCell:setVisible(false)

	self._roleNode = self._mainPanel:getChildByName("roleNode")
	self._touchPanelRole = self._mainPanel:getChildByName("Panel_Hero")
	self._talkBg = self._touchPanelRole:getChildByName("Image_20")
	self._talkText = self._touchPanelRole:getChildByName("Text_talk")
	self._passSpineTalkVoice = PassSpineTalkVoice:new(self._passSystem)

	self._passSpineTalkVoice:addSpine(self._roleNode, 2)
	self:updateRemainTime()
end

function PassShopMediator:initTableView()
	local viewSize = self._viewPanel:getContentSize()
	local width, height = viewSize.width, self._cloneCell:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function numberOfCells(view)
		return math.ceil(#self._exchangeList / kNum)
	end

	local function cellSize(table, idx)
		return width, height
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layout = ccui.Layout:create()

			layout:addTo(cell):posite(0, 0)
			layout:setAnchorPoint(cc.p(0, 0))
			layout:setTag(123)
		end

		local index = idx + 1
		local cell_Old = cell:getChildByTag(123)

		self:createCell(cell_Old, index)

		return cell
	end

	local tableView = cc.TableView:create(viewSize)

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._viewPanel)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(20)

	self._tableView = tableView
end

function PassShopMediator:createCell(cell, index)
	cell:removeAllChildren()

	for i = 1, kNum do
		local onePassExchange = self._exchangeList[kNum * (index - 1) + i]

		if onePassExchange then
			local panel = self._cloneCell:clone()

			panel:setVisible(true)
			panel:setTag(i)
			panel:addTo(cell):posite(182 * (i - 1), 0)

			local cellpanel = panel:getChildByFullName("cell")
			local icon_layout = cellpanel:getChildByName("icon_layout")

			icon_layout:removeAllChildren()

			local targetItem = onePassExchange:getTargetItem()
			local icon = IconFactory:createIcon({
				rewardType = targetItem.type,
				id = targetItem.code,
				amount = targetItem.amount
			}, {
				hideLevel = true,
				showAmount = false,
				isWidget = false
			})

			icon:addTo(icon_layout, -1):center(icon_layout:getContentSize()):setScale(0.7)
			IconFactory:bindTouchHander(icon_layout, IconTouchHandler:new(self), targetItem, {
				needDelay = true
			})

			local nameText = cellpanel:getChildByName("goods_name")
			local goods_num = cellpanel:getChildByName("goods_num")
			local limitMark = cellpanel:getChildByName("limitMark")

			nameText:setString(Strings:get(onePassExchange:getName()))
			limitMark:setString(Strings:get("Pass_UI37", {
				num = string.format("%d/%d", onePassExchange:getExchangeCount() - onePassExchange:getLeftExchangeCount(), onePassExchange:getExchangeCount())
			}))
			goods_num:setString(targetItem.amount)

			if targetItem.type == RewardType.kHero then
				goods_num:setString("1")
			end

			local noLeftColor = cellpanel:getChildByFullName("noLeftColor")
			local noLeftImage = cellpanel:getChildByFullName("noLeftImage")

			if onePassExchange:getLeftExchangeCount() <= 0 then
				noLeftColor:setVisible(true)
				noLeftImage:setVisible(true)
			else
				noLeftColor:setVisible(false)
				noLeftImage:setVisible(false)
			end

			local money = cellpanel:getChildByFullName("money_layout.money")
			local moneyIcon = cellpanel:getChildByFullName("money_layout.money_icon")
			local costItem = onePassExchange:getCostItem()
			local icon = IconFactory:createIcon({
				id = costItem.code,
				amount = costItem.amount
			}, {
				hideLevel = true,
				showAmount = false,
				notShowQulity = true,
				isWidget = false
			})

			icon:addTo(moneyIcon):center(moneyIcon:getContentSize()):setScale(0.3)
			moneyIcon:setPositionX(money:getPositionX() - money:getContentSize().width / 2)
			money:setString(costItem.amount)

			local touchPanel = cellpanel:getChildByName("touch_panel")

			touchPanel:setTouchEnabled(true)
			touchPanel:setSwallowTouches(false)
			touchPanel:addTouchEventListener(function(sender, eventType)
				self:onClickGet(sender, eventType, onePassExchange)
			end)
		end
	end
end

function PassShopMediator:refreshData(fromParent)
	self._exchangeList = self._passSystem:getPassListModel():getPassShopList()
	self._showPassEnter, self._showPass, self._showPassShop = self._passSystem:checkShowPassAndPassShop()
end

function PassShopMediator:refreshView(hasAnim)
	if not self._tableView then
		self:initTableView()
	end

	self:setTalkView()

	if hasAnim then
		self:runStartAction()

		return
	end

	self:getView():stopAllActions()
	self._tableView:reloadData()
	self._tableView:setTouchEnabled(true)
end

function PassShopMediator:onClickGet(sender, eventType, onePassExchange)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local activityId = self._passSystem:getShopActivityID()
		local view = self:getInjector():getInstance("PassBuyItemView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			shopType = 2,
			itemData = onePassExchange,
			activityId = activityId
		}))
	end
end

function PassShopMediator:setTalkView()
	if self._passSpineTalkVoice ~= nil then
		if self._passSystem:getShowViewTabIndex() == self._tabIndex then
			local talkStr = self:playAnimation()

			self._talkText:setString(talkStr)
		else
			self._passSpineTalkVoice:stopEffect()
		end
	end
end

function PassShopMediator:playAnimation()
	local desStr = ""

	if self._passSystem:getPlaySoldOutVoice() then
		self._passSystem:setPlaySoldOutVoice(false)
		self._passSystem:setPlayBuyEndVoice(false)

		desStr = self._passSpineTalkVoice:playVoice(2, KPassVoiceType.soldout)

		return desStr
	end

	if self._passSystem:getPlayBuyEndVoice() then
		self._passSystem:setPlayBuyEndVoice(false)

		desStr = self._passSpineTalkVoice:playVoice(2, KPassVoiceType.buyEnd)

		return desStr
	end

	desStr = self._passSpineTalkVoice:playVoice(2, KPassVoiceType.begin)

	return desStr
end

function PassShopMediator:runStartAction()
	performWithDelay(self:getView(), function()
		self._tableView:stopScroll()
		self._tableView:reloadData()
		self:runListAnim()
	end, 0.16666666666666666)
end

function PassShopMediator:runListAnim()
	self:getView():stopAllActions()

	local showNum = 3

	self._tableView:setTouchEnabled(false)

	local allCells = self._tableView:getContainer():getChildren()

	for i = 1, showNum do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local child = child:getChildByTag(123)

			for j = 1, 4 do
				local node = child:getChildByTag(j)

				if node then
					node = node:getChildByFullName("cell")

					node:stopAllActions()
					node:setOpacity(0)
				end
			end
		end
	end

	local length = math.min(showNum, #allCells)
	local delayTime = 0.16666666666666666
	local delayTime1 = 0.06666666666666667

	for i = 1, showNum do
		local child = allCells[i]

		if child and child:getChildByTag(123) then
			local child = child:getChildByTag(123)
			local alltime = 0

			for j = 1, 4 do
				local node = child:getChildByTag(j)

				if node then
					node = node:getChildByFullName("cell")

					node:stopAllActions()

					local time = (i - 1) * delayTime + (j - 1) * delayTime1
					local delayAction = cc.DelayTime:create(time)

					alltime = alltime + time

					local callfunc = cc.CallFunc:create(function()
						CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
					end)
					local callfunc1 = cc.CallFunc:create(function()
						node:setOpacity(255)
					end)
					local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

					child:runAction(seq)
				end
			end

			local allDelayAction = cc.DelayTime:create(alltime)
			local callfunc2 = cc.CallFunc:create(function()
				if length == i then
					self._tableView:setTouchEnabled(true)
				end
			end)
			local allSeq = cc.Sequence:create(allDelayAction, callfunc2)

			self:getView():runAction(allSeq)
		end
	end
end

function PassShopMediator:updateRemainTime()
	if self._showPassShop == false then
		self._timeNode:setVisible(false)

		return
	end

	if not self._timer then
		local remoteTimestamp = self._passSystem:getCurrentTime()
		local refreshTiem = self._passSystem:getCurrentPassShopActivity():getEndTime() / 1000

		local function checkTimeFunc()
			remoteTimestamp = self._passSystem:getCurrentTime()

			local remainTime = refreshTiem - remoteTimestamp

			if remainTime <= 0 then
				self._timer:stop()

				self._timer = nil

				return
			end

			self:refreshRemainTime(remainTime)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function PassShopMediator:refreshRemainTime(remainTime)
	local str = ""
	local fmtStr = "${d}:${H}:${M}:${S}"
	local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
	local parts = string.split(timeStr, ":", nil, true)
	local timeTab = {}

	timeTab.day = tonumber(parts[1])
	timeTab.hour = tonumber(parts[2])
	timeTab.min = tonumber(parts[3])
	timeTab.sec = tonumber(parts[4])
	str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

	local str1 = Strings:get("Pass_UI32", {
		time = str,
		fontName = TTF_FONT_FZYH_M
	})
	local node = self._timeNode:getChildByName("time")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local image = self._timeNode:getChildByFullName("Image_14")

		image:setContentSize(cc.size(240, 45))
	end

	node:removeAllChildren()

	local contentText = ccui.RichText:createWithXML(str1, {})

	contentText:addTo(node)
	contentText:setAnchorPoint(cc.p(0, 0.5))
	contentText:setPosition(cc.p(-70, 0))
	contentText:renderContent(180, 0, true)
end
