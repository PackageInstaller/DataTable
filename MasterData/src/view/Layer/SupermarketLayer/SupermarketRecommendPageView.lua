SupermarketRecommendPageView = class("SupermarketMarketSprite", function()
	return cc.Layer:create()
end)

local shop_recommend_data = require("data.shop_recommend_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_3 = 40
local var_0_4 = 40
local var_0_5 = 0.01
local var_0_6 = 0.5
local var_0_7 = 200
local var_0_8 = 8
local var_0_9 = 0.6
local var_0_10 = 1
local var_0_11 = {
	-490,
	0,
	490
}

local function var_0_12(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:convertTouchToNodeSpace(arg_2_0)

	if var_2_0.x >= 0 and var_2_0.x <= arg_2_2.width and var_2_0.y >= 0 and var_2_0.y <= arg_2_2.height then
		return true
	end
end

function SupermarketRecommendPageView.create(arg_3_0, arg_3_1)
	local var_3_0 = SupermarketRecommendPageView.new()

	var_3_0:init(arg_3_1, jumpToCB)

	return var_3_0
end

function SupermarketRecommendPageView:init(arg_4_1)
	self._isCachePanelInAnim = true
	self._isTouchMove = false

	self:initPageData()
	self:initUI()
	self:updatePageView()
	self:initScheduler()
end

function SupermarketRecommendPageView:initPageData()
	self.pageDataList = {}

	for iter_5_0, iter_5_1 in ipairs(shop_recommend_data) do
		if global_is_in_time(iter_5_1.starttime, iter_5_1.finishtime) then
			if iter_5_1.jumpto == "2600710" then
				if not activity_manager:is_module_stat_finished(2, "wake_fund") or not activity_manager:is_module_stat_finished(406, "wake_fund") or not activity_manager:is_module_stat_finished(486, "wake_fund") or not activity_manager:is_module_stat_finished(710, "wake_fund") then
					table.insert(self.pageDataList, iter_5_1)
				end
			else
				table.insert(self.pageDataList, iter_5_1)
			end
		end
	end

	table.sort(self.pageDataList, function(arg_6_0, arg_6_1)
		return arg_6_0.order < arg_6_1.order
	end)

	self.selectIndex = 1
end

function SupermarketRecommendPageView:initUI()
	local var_7_0 = ccui.Layout:create()

	var_7_0:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y - 470))
	var_7_0:setLayoutType(ccui.LayoutType.HORIZONTAL)
	var_7_0:setAnchorPoint(cc.p(0.5, 0.5))
	self:addChild(var_7_0)

	self.bars = {}

	local var_7_1 = ccui.Button:create("mainScenebg/shopRecommendPageView/btn_left.png")

	var_7_0:addChild(var_7_1)

	local var_7_2 = var_7_1:getContentSize().width

	for iter_7_0 = 1, #self.pageDataList do
		local var_7_3 = ccui.ImageView:create("mainScenebg/shopRecommendPageView/bar_off.png")

		var_7_3:setName("bar" .. iter_7_0)
		var_7_0:addChild(var_7_3)
		table.insert(self.bars, var_7_3)

		local var_7_4 = ccui.LinearLayoutParameter:create()

		var_7_4:setGravity(ccui.LinearGravity.centerHorizontal)
		var_7_4:setMargin({
			top = 20,
			bottom = 10,
			left = 10,
			right = 10
		})
		var_7_3:setLayoutParameter(var_7_4)

		var_7_2 = var_7_2 + var_7_3:getContentSize().width + 20
	end

	local var_7_5 = ccui.Button:create("mainScenebg/shopRecommendPageView/btn_right.png")

	var_7_0:addChild(var_7_5)
	var_7_0:setPositionX(var_7_0:getPositionX() - (var_7_2 + var_7_5:getContentSize().width) / 2)
	self:updateBottomBar()
	var_7_1:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkTouchEnabled() and not self._isTouchMove then
			self:playAnim(0, false, 1)
		end
	end)
	var_7_5:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkTouchEnabled() and not self._isTouchMove then
			self:playAnim(0, false, -1)
		end
	end)
end

function SupermarketRecommendPageView:updatePageView()
	if self.pageViewList then
		self.pageViewList:getChildByName("page1"):loadTexture("mainScenebg/shopRecommendPageView/page/pageView_" .. self.pageDataList[(self.selectIndex == 1 or nil) and (#self.pageDataList or self.selectIndex - 1)].id .. ".png")
		self.pageViewList:getChildByName("page1"):setOpacity(var_0_4)
		self.pageViewList:getChildByName("page2"):loadTexture("mainScenebg/shopRecommendPageView/page/pageView_" .. self.pageDataList[self.selectIndex].id .. ".png")
		self.pageViewList:getChildByName("page2"):setOpacity(255)
		self.pageViewList:getChildByName("page3"):loadTexture("mainScenebg/shopRecommendPageView/page/pageView_" .. self.pageDataList[self.selectIndex == #self.pageDataList and 1 or self.selectIndex + 1].id .. ".png")
		self.pageViewList:getChildByName("page3"):setOpacity(var_0_4)
	else
		self:createPageViewList()
	end
end

function SupermarketRecommendPageView:createPageViewList()
	local var_11_0 = ccui.Layout:create()

	var_11_0:setContentSize(GameDisplay.width, 800)
	var_11_0:setPosition(cc.p(0, GameDisplay.height / 2 - GameDisplay.fix_y - 400))
	self:addChild(var_11_0)

	self.touchPanel = var_11_0

	self.touchPanel:setTouchEnabled(false)

	local var_11_1 = ccui.Layout:create()

	var_11_1:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2))
	var_11_1:setAnchorPoint(cc.p(0.5, 0.5))

	local var_11_2 = ccui.ImageView:create("mainScenebg/shopRecommendPageView/page/pageView_" .. self.pageDataList[self.selectIndex].id .. ".png")

	var_11_1:addChild(var_11_2)
	var_11_2:setName("page1")
	var_11_2:setPositionY(-GameDisplay.fix_y)
	var_11_2:setPositionX(-490)

	local var_11_3 = ccui.ImageView:create("mainScenebg/shopRecommendPageView/page/pageView_" .. self.pageDataList[self.selectIndex].id .. ".png")

	var_11_1:addChild(var_11_3)
	var_11_3:setName("page2")
	var_11_3:setPositionY(-GameDisplay.fix_y)

	local var_11_4 = ccui.ImageView:create("mainScenebg/shopRecommendPageView/page/pageView_" .. self.pageDataList[self.selectIndex].id .. ".png")

	var_11_1:addChild(var_11_4)
	var_11_4:setName("page3")
	var_11_4:setPositionY(-GameDisplay.fix_y)
	var_11_4:setPositionX(490)
	self:addChild(var_11_1)

	self.pageViewList = var_11_1

	self:registerTouchEvent()
	self:updatePageView()
end

function SupermarketRecommendPageView:registerTouchEvent()
	if self.touchListener then
		return
	end

	self._controlPoint = 0
	self._isCachePanelInAnim = false
	self._autoscroll = false
	self._autoscrollaction = nil
	self._autoscrollpos = nil

	local var_12_0 = cc.EventListenerTouchOneByOne:create()

	var_12_0:setSwallowTouches(false)
	var_12_0:registerScriptHandler(function(arg_13_0, arg_13_1)
		if not self:checkTouchEnabled() or not var_0_12(arg_13_0, self.touchPanel, self.touchPanel:getContentSize()) then
			return false
		else
			self.startTime = os.clock()

			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_12_0:registerScriptHandler(function(arg_14_0, arg_14_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleMoveLogic(arg_14_0)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_12_0:registerScriptHandler(function(arg_15_0, arg_15_1)
		if not self:checkTouchEnabled() then
			return
		end

		self.startTime = 0

		self:handleReleaseLogic(arg_15_0, os.clock() - self.startTime)

		self._isTouchMove = false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_12_0:registerScriptHandler(function(arg_16_0, arg_16_1)
		if not self:checkTouchEnabled() then
			return
		end

		local var_16_0 = os.clock() - self.startTime

		self.startTime = 0
		self._isTouchMove = false
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_12_0, self.touchPanel)

	self.touchListener = var_12_0
end

function SupermarketRecommendPageView:updateTouch(arg_17_1)
	if arg_17_1 then
		self:registerTouchEvent()
	else
		self:getEventDispatcher():removeEventListener(self.touchListener)

		self.touchListener = nil
	end
end

function SupermarketRecommendPageView:checkTouchEnabled()
	if self._isCachePanelInAnim then
		return false
	end

	return true
end

function SupermarketRecommendPageView:handleReleaseLogic(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:getLocation().x - arg_19_1:getStartLocation().x

	if arg_19_2 <= var_0_6 then
		if math.abs(var_19_0) < 20 then
			if var_0_12(arg_19_1, self.pageViewList:getChildByName("page2"), self.pageViewList:getChildByName("page2"):getContentSize()) then
				self:pageClick()

				if self and self.playAnim then
					self:playAnim(var_19_0, true)
				end

				goto label_19_0
			end
		end

		if arg_19_2 >= var_0_5 then
			self:playAnim(var_19_0, math.abs(var_19_0) <= 40)
		else
			self:playAnim(var_19_0, true)
		end
	else
		self:playAnim(var_19_0, math.abs(var_19_0) <= 40)
	end

	::label_19_0::
end

function SupermarketRecommendPageView:handleMoveLogic(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1:getLocation().x - arg_20_1:getStartLocation().x

	if math.abs(var_20_0) >= var_0_7 then
		var_20_0 = var_20_0 / math.abs(var_20_0) * var_0_7
	end

	self:movePanelCache(var_20_0)
end

function SupermarketRecommendPageView:movePanelCache(arg_21_1)
	self._isTouchMove = true

	for iter_21_0, iter_21_1 in ipairs(self.pageViewList:getChildren()) do
		iter_21_1:setPositionX(var_0_11[tonumber(string.match(iter_21_1:getName(), "%d+"))] + arg_21_1)
		iter_21_1:setOpacity(math.max(255 - 215 * math.abs(iter_21_1:getPositionX()) / 490, 40))
	end
end

function SupermarketRecommendPageView:playAnim(arg_22_1, arg_22_2, arg_22_3)
	self._isCachePanelInAnim = true

	local var_22_0
	local var_22_1 = arg_22_3 and arg_22_3 or math.abs(arg_22_1) / arg_22_1

	if arg_22_2 then
		var_22_0 = -self.pageViewList:getChildByName("page2"):getPositionX()
		var_22_1 = 0
	else
		var_22_0 = var_22_1 * (450 + var_0_3 - math.abs(self.pageViewList:getChildByName("page2"):getPositionX()))

		self:beforeAnim(var_22_1)
	end

	local function var_22_2()
		self._isCachePanelInAnim = false

		if self.pageViewList:getChildrenCount() <= 3 then
			return
		end

		self.pageViewList:getChildByName("page" .. 2 + var_22_1):removeFromParent()
		self.pageViewList:getChildByName("page2"):setName("page" .. 2 + var_22_1)
		self.pageViewList:getChildByName("page" .. 2 - var_22_1):setName("page" .. 2)
		self.pageViewList:getChildByName("pagePre"):setName("page" .. 2 - var_22_1)
		self:updatePageView()
	end

	local var_22_3

	if arg_22_3 then
		var_22_3 = var_0_10 or var_0_9
	end

	for iter_22_0, iter_22_1 in ipairs(self.pageViewList:getChildren()) do
		iter_22_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeTo:create(var_22_3, iter_22_1:getName() == "page" .. 2 - var_22_1 and 255 or 40), (cc.MoveBy:create(var_22_3, cc.p(var_22_0, 0)))), cc.CallFunc:create(var_22_2)))
	end

	self:refreshScheduler()
end

function SupermarketRecommendPageView:beforeAnim(arg_24_1)
	local var_24_0 = ccui.ImageView:create("mainScenebg/shopRecommendPageView/page/pageView_" .. self.pageDataList[self.selectIndex].id .. ".png")

	self.pageViewList:addChild(var_24_0)
	var_24_0:setPositionY(-GameDisplay.fix_y)
	var_24_0:setName("pagePre")
	var_24_0:setPositionX(self.pageViewList:getChildByName("page" .. 2 - arg_24_1):getPositionX() - arg_24_1 * 490)
	var_24_0:setOpacity(0)

	self.selectIndex = self.selectIndex - arg_24_1

	if self.selectIndex == 0 then
		self.selectIndex = #self.pageDataList
	elseif self.selectIndex > #self.pageDataList then
		self.selectIndex = 1
	end

	self:updateBottomBar()
end

function SupermarketRecommendPageView:updateBottomBar()
	for iter_25_0, iter_25_1 in ipairs(self.bars) do
		if iter_25_1:getName() == "bar" .. self.selectIndex then
			iter_25_1:loadTexture("mainScenebg/shopRecommendPageView/bar_on.png")
		else
			iter_25_1:loadTexture("mainScenebg/shopRecommendPageView/bar_off.png")
		end
	end
end

function SupermarketRecommendPageView:initScheduler()
	self:registerScriptHandler(function(arg_27_0)
		if arg_27_0 == "exit" and self.scheduler then
			time_check_manager:removeUpdatePool(self.scheduler)

			self.scheduler = nil
		end
	end)

	self.scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_0_8, function(arg_28_0)
		if arg_28_0 <= 0 and self.scheduler then
			if tolua.isnull(self) then
				return
			end

			if self:checkTouchEnabled() and not self._isTouchMove then
				self:playAnim(0, false, -1)
			end
		end
	end)))
end

function SupermarketRecommendPageView:pageClick()
	if not self.pageDataList[self.selectIndex].jumpto then
		hx_print("活动推荐页的跳转信息未配置", CONSOLE_BG_COLOR_RED)

		return
	end

	local var_29_0

	if type(self.pageDataList[self.selectIndex].jumpto) == "string" then
		var_29_0 = tonumber(self.pageDataList[self.selectIndex].jumpto)
	end

	if var_29_0 >= 3800000 and var_29_0 <= 3899999 then
		local var_29_2 = cc.EventCustom:new("marketRecommendJumpTo")

		var_29_2.tab = var_29_0 % 3800000

		AnalyticManager.activityJumpTo({
			activityid = 9999,
			module = "SupermarketLayer",
			from = "recommended_tab_" .. self.pageDataList[self.selectIndex].id,
			jump = self.pageDataList[self.selectIndex].jumpto
		})
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_29_2)
	else
		local var_29_3 = goto_complete_system({
			jump_to_system = self.pageDataList[self.selectIndex].jumpto
		})

		if var_29_3 then
			AnalyticManager.activityJumpTo({
				activityid = 9999,
				module = var_29_3,
				from = "recommended_tab_" .. self.pageDataList[self.selectIndex].id,
				jump = self.pageDataList[self.selectIndex].jumpto
			})
		end

		return
	end
end

function SupermarketRecommendPageView:refreshScheduler()
	if self.scheduler then
		time_check_manager:removeUpdatePool(self.scheduler)

		self.scheduler = nil
		self.scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_0_8, function(arg_31_0)
			if arg_31_0 <= 0 then
				if tolua.isnull(self) then
					return
				end

				if self:checkTouchEnabled() and not self._isTouchMove then
					self:playAnim(0, false, -1)
				end
			end
		end)))
	end
end
