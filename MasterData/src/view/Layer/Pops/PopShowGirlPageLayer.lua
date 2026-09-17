PopShowGirlPageLayer = class("PopShowGirlPageLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = 1
local network = require("network.network")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local show_girl_page_data = require("data.show_girl_page_data")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local recharge_manager = require("controller.recharge_manager")
local spinecache_manager = require("controller.spinecache_manager")
local var_0_13 = 1
local var_0_14 = 2
local var_0_16 = 2
local var_0_17 = 3
local var_0_18 = 200

function PopShowGirlPageLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopShowGirlPageLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopShowGirlPageLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.pageView = ccui.Layout:create()

	self.pageView:setTouchEnabled(true)
	self.pageView:setAnchorPoint(cc.p(0.5, 0.5))
	self.pageView:setPosition(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2)
	self.pageView:setContentSize(cc.size(640 * var_0_0, 1136 * var_0_0))
	self.rootLayer:addChild(self.pageView)

	if arg_3_1 then
		self.id = arg_3_1.id or nil
	end

	if arg_3_1 then
		self.exitcallback = arg_3_1.exitcallback or nil
	end

	if arg_3_1 then
		self.showmodule = arg_3_1.showmodule or nil
	end

	self:registerRechargeEventListener()
	self:initPageData()
	self:initPageView()
	self:initPageSpot()
	self:initOtherUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and arg_3_1 and arg_3_1.exitcallback then
			arg_3_1.exitcallback()
		end
	end)
end

function PopShowGirlPageLayer:registerRechargeEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_6_0)
		LayerManager:removePopLayer(self.__queueindex)
	end), self)
end

function PopShowGirlPageLayer:initPageData()
	self.dataList = {}

	if self.id then
		while show_girl_page_data[self.id]["modelid_" .. 1] do
			local var_7_0 = {
				modelid = show_girl_page_data[self.id]["modelid_" .. 1],
				rechargeid = show_girl_page_data[self.id]["rechargeid_" .. 1],
				readType = show_girl_page_data[self.id]["read_type_" .. 1],
				stat = self:getRechargeStat(show_girl_page_data[self.id]["rechargeid_" .. 1])
			}

			var_7_0.isrecharged = self:isSkinRecharged(show_girl_page_data[self.id]["rechargeid_" .. 1]) or 13

			table.insert(self.dataList, var_7_0)
		end
	end
end

function PopShowGirlPageLayer:initPageView()
	self.pages = {}
	self.curPage = 1
	self._isOnTouch = false

	local function var_8_0(arg_9_0)
		if self.curPage % #self.dataList == 1 and arg_9_0 < 0 then
			return self.curPage + (#self.dataList - 1)
		elseif self.curPage % 7 == 0 and arg_9_0 > 0 then
			return self.curPage - (#self.dataList - 1)
		else
			return self.curPage + arg_9_0
		end
	end

	for iter_8_0 = 1, 3 do
		local var_8_1 = self:createSelectLayout((var_8_0(iter_8_0 - 2)))

		var_8_1:setPosition(cc.p((-960 + 640 * iter_8_0) * var_0_0, 1136 * var_0_0 / 2))
		self.pageView:addChild(var_8_1)

		self.pages[iter_8_0] = var_8_1
	end

	local var_8_2 = cc.EventListenerTouchOneByOne:create()

	var_8_2:setSwallowTouches(true)
	var_8_2:registerScriptHandler(function(arg_10_0, arg_10_1)
		if self._isOnTouch then
			return
		end

		self._isOnTouch = true

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_8_2:registerScriptHandler(function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0:getLocation().x - arg_11_0:getPreviousLocation().x

		for iter_11_0, iter_11_1 in pairs(self.pages) do
			iter_11_1:setPositionX(iter_11_1:getPositionX() + var_11_0)
		end

		self:updateSpotPositionX(var_11_0)

		return true
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_8_2:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:getLocation().x - arg_12_0:getStartLocation().x

		if math.abs(var_12_0) > var_0_18 then
			self:updatePageViewUI(-1 * var_12_0 / math.abs(var_12_0))
			self:updatePageSpot(-1 * var_12_0 / math.abs(var_12_0))
		else
			self:recoveryPages()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_8_2:registerScriptHandler(function(arg_13_0, arg_13_1)
		return true
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_8_2, self.pageView)
end

function PopShowGirlPageLayer:recoveryPages()
	for iter_14_0, iter_14_1 in pairs(self.pages) do
		iter_14_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p((-960 + 640 * iter_14_0) * var_0_0, 1136 * var_0_0 / 2))))
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			self._isOnTouch = false
		end)))
	end

	self:updatePageSpot()
end

function PopShowGirlPageLayer.getBtnActionObj(arg_16_0, arg_16_1)
	return (cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.2 * 0.5, cc.p(16 * arg_16_1 * 0.5, 0)), cc.MoveBy:create(0.3 * 0.5, cc.p(-24 * arg_16_1 * 0.5, 0)), cc.MoveBy:create(0.1 * 0.5, cc.p(8 * arg_16_1 * 0.5, 0)), cc.DelayTime:create(0.8 * 0.5))))
end

function PopShowGirlPageLayer:initPageSpot()
	self.spots = {}

	for iter_17_0 = 1, 5 do
		local var_17_0 = self.curPage + (iter_17_0 - 3)

		if self.curPage + (iter_17_0 - 3) <= 0 then
			var_17_0 = #self.dataList + var_17_0
		elseif #self.dataList < var_17_0 then
			var_17_0 = var_17_0 - #self.dataList
		end

		local var_17_1 = self.dataList[var_17_0].modelid
		local var_17_2 = ccui.ImageView:create(string.format("mainScenebg/show_girl_page/%s_%s.png", self.dataList[var_17_0].modelid, self.dataList[var_17_0].stat))

		if iter_17_0 == 3 then
			var_17_2:loadTexture(string.format("mainScenebg/show_girl_page/%s_on_%s.png", var_17_1, self.dataList[var_17_0].stat))
		end

		var_17_2:setPosition(cc.p(-50 + (iter_17_0 - 1) * 185, 120))
		self.rootLayer:addChild(var_17_2, 5)

		self.spots[iter_17_0] = var_17_2

		if iter_17_0 > 1 or iter_17_0 < 5 then
			var_17_2:setTouchEnabled(true)
			var_17_2:addTouchEventListener(function(arg_18_0, arg_18_1)
				if arg_18_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_18_0 = iter_17_0 - 3

				if iter_17_0 - 3 == 0 then
					return
				end

				self:updatePageViewTexture(var_18_0)
				self:updatePageSpot(var_18_0)
			end)
		end
	end

	local var_17_3 = ccui.ImageView:create("mainScenebg/show_girl_page/left.png")

	var_17_3:setPosition(cc.p(230, 120))
	var_17_3:runAction(self:getBtnActionObj(1))
	self.rootLayer:addChild(var_17_3, 4)
	var_17_3:setTouchEnabled(true)
	var_17_3:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updatePageViewTexture(1)
		self:updatePageSpot(1)
	end)

	local var_17_4 = ccui.ImageView:create("mainScenebg/show_girl_page/right.png")

	var_17_4:setPosition(cc.p(410, 120))
	var_17_4:runAction(self:getBtnActionObj(-1))
	self.rootLayer:addChild(var_17_4, 4)
	var_17_4:setTouchEnabled(true)
	var_17_4:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updatePageViewTexture(-1)
		self:updatePageSpot(-1)
	end)
end

function PopShowGirlPageLayer:updatePageSpot()
	for iter_21_0 = 1, 5 do
		local var_21_0 = self.curPage + (iter_21_0 - 3)

		if self.curPage + (iter_21_0 - 3) <= 0 then
			var_21_0 = #self.dataList + var_21_0
		elseif #self.dataList < var_21_0 then
			var_21_0 = var_21_0 - #self.dataList
		end

		local var_21_1 = self.dataList[var_21_0].modelid

		self.spots[iter_21_0]:setPositionX(-50 + (iter_21_0 - 1) * 185)

		if iter_21_0 == 3 then
			self.spots[iter_21_0]:loadTexture(string.format("mainScenebg/show_girl_page/%s_on_%s.png", var_21_1, self.dataList[var_21_0].stat))
		else
			self.spots[iter_21_0]:loadTexture(string.format("mainScenebg/show_girl_page/%s_%s.png", var_21_1, self.dataList[var_21_0].stat))
		end
	end
end

function PopShowGirlPageLayer:updateSpotPositionX(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self.spots) do
		iter_22_1:setPositionX(iter_22_1:getPositionX() + arg_22_1 * 0.286)
	end
end

function PopShowGirlPageLayer:createSelectLayout(arg_23_1)
	local var_23_0 = self.dataList[arg_23_1].modelid
	local var_23_1 = ccui.Layout:create()

	var_23_1:setContentSize(cc.size(640 * var_0_0, 1136 * var_0_0))
	var_23_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_1:setClippingEnabled(true)

	if self.dataList[arg_23_1].readType ~= var_0_17 then
		local var_23_3 = ccui.ImageView:create((self.dataList[arg_23_1].readType == var_0_16 or nil) and string.format("mainScenebg/show_girl_page/skin_%s_%s.png", var_23_0, self.dataList[arg_23_1].stat))

		var_23_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_23_3:setScale(var_0_0)
		var_23_3:setName("show_girl")
		var_23_3:setPosition(cc.p(var_23_1:getContentSize().width / 2, var_23_1:getContentSize().height / 2 + 20))
		var_23_1:addChild(var_23_3)
	else
		local var_23_4 = cc.Node:create()

		var_23_4:setName("show_girl")
		var_23_4:setPosition(cc.p(0, 0))
		var_23_1:addChild(var_23_4)

		local var_23_5 = ROLE_SPINE_PATH .. model_data[var_23_0].rolespine .. ".json"
		local var_23_6 = ROLE_SPINE_PATH .. model_data[var_23_0].rolespine .. ".atlas"
		local var_23_7 = spinecache_manager:addSpineData(ROLE_SPINE_PATH .. model_data[var_23_0].rolespine .. ".json", ROLE_SPINE_PATH .. model_data[var_23_0].rolespine .. ".atlas")

		var_23_7:retain()

		local var_23_8 = sp.SkeletonAnimation:create(var_23_7:getData())

		var_23_8:setPosition(cc.p(GameDisplay.cx, 30))
		var_23_4:addChild(var_23_8, 2)
		var_23_8:setScale(0.72)
		var_23_8:setAnimation(0, "idle", true)
		var_23_4:registerScriptHandler(function(arg_24_0)
			if arg_24_0 == "exit" then
				var_23_7:release()
				spinecache_manager:removeSpineDataForKey(var_23_5, var_23_6)
			end
		end)
	end

	local var_23_9 = ccui.ImageView:create("mainScenebg/show_girl_page/img_other.png")

	var_23_9:setAnchorPoint(cc.p(1, 0.5))
	var_23_9:setPosition(cc.p(640, 280))
	var_23_1:addChild(var_23_9, 20)

	local var_23_10 = "mainScenebg/show_girl_page/btn_" .. model_data[var_23_0].role_image .. "_buy.png"

	if self.dataList[arg_23_1].isrecharged then
		var_23_10 = "mainScenebg/show_girl_page/btn_bought.png"
	end

	local var_23_11 = ccui.Button:create(var_23_10, nil, var_23_10)

	var_23_11:setAnchorPoint(cc.p(0.5, 0))
	var_23_11:setPosition(cc.p(320, 165 - GameDisplay.fix_y * 0.5))
	var_23_11:setName("btn_info")

	var_23_11.modelid = var_23_0
	var_23_11.rechargeid = self.dataList[arg_23_1].rechargeid

	var_23_1:addChild(var_23_11, 20)
	var_23_11:setVisible(self.dataList[arg_23_1].stat == var_0_13)
	var_23_11:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("DormitoryLayer")

		do return end

		network:rpc("check_recharge", {
			id = rechargeid,
			client = config.clientmode
		}, function(arg_26_0)
			if arg_26_0.result == 1 then
				self.recharging = false

				AnalyticManager.clickPurchaseItem({
					product = id,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(rechargeid)
			elseif arg_26_0.result == 2 then
				print("测试模式")
			elseif arg_26_0.result == 3 then
				global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
			elseif arg_26_0.result == 4 then
				global_ShowBlockWords(L_RECHARGE_OUT_TIME)
			elseif arg_26_0.result == 5 then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
			elseif arg_26_0.result == 6 then
				global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
			end
		end)
	end)

	return var_23_1
end

function PopShowGirlPageLayer:updatePageViewUI(arg_27_1)
	local var_27_0
	local var_27_1 = #self.dataList

	if arg_27_1 > 0 then
		var_27_0 = table.remove(self.pages, 1)

		table.insert(self.pages, var_27_0)

		local var_27_2 = self.curPage + 2

		if var_27_1 < self.curPage + 2 then
			var_27_2 = var_27_2 - var_27_1
		end

		self:updateSelectLayout(var_27_0, var_27_2)
	elseif arg_27_1 < 0 then
		var_27_0 = table.remove(self.pages)

		table.insert(self.pages, 1, var_27_0)

		local var_27_3 = self.curPage - 2

		if self.curPage - 2 <= 0 then
			var_27_3 = var_27_1 + var_27_3
		end

		self:updateSelectLayout(var_27_0, var_27_3)
	end

	var_27_0:setVisible(false)

	for iter_27_0, iter_27_1 in pairs(self.pages) do
		iter_27_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p((-960 + 640 * iter_27_0) * var_0_0, 1136 * var_0_0 / 2))))
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			self._isOnTouch = false

			var_27_0:setVisible(true)
		end)))
	end

	self.curPage = self.curPage % var_27_1 == 0 and arg_27_1 > 0 and self.curPage - (var_27_1 - 1) or self.curPage % var_27_1 == 1 and arg_27_1 < 0 and self.curPage + (var_27_1 - 1) or self.curPage + arg_27_1
end

function PopShowGirlPageLayer:updatePageViewTexture(arg_29_1)
	for iter_29_0 = 0, 2 do
		local var_29_0 = self.curPage + arg_29_1 + (iter_29_0 - 1)

		if #self.dataList < self.curPage + arg_29_1 + (iter_29_0 - 1) then
			var_29_0 = var_29_0 - #self.dataList
		end

		if var_29_0 <= 0 then
			var_29_0 = #self.dataList + var_29_0
		end

		self:updateSelectLayout(self.pages[iter_29_0 + 1], var_29_0)
	end

	self.curPage = self.curPage % #self.dataList == 0 and arg_29_1 > 0 and self.curPage - (#self.dataList - 1) or self.curPage % #self.dataList == 1 and arg_29_1 < 0 and self.curPage + (#self.dataList - 1) or self.curPage + arg_29_1
end

function PopShowGirlPageLayer:updateSelectLayout(arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1:getChildByName("show_girl")
	local var_30_1 = self.dataList[arg_30_2].modelid

	if var_30_0 then
		var_30_0:removeFromParent()
	end

	if self.dataList[arg_30_2].readType ~= var_0_17 then
		local var_30_3 = ccui.ImageView:create((self.dataList[arg_30_2].readType == var_0_16 or nil) and string.format("mainScenebg/show_girl_page/skin_%s_%s.png", var_30_1, self.dataList[arg_30_2].stat))

		var_30_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_30_3:setScale(var_0_0)
		var_30_3:setName("show_girl")
		var_30_3:setPosition(cc.p(arg_30_1:getContentSize().width / 2, arg_30_1:getContentSize().height / 2 + 20))
		arg_30_1:addChild(var_30_3)
	else
		local var_30_4 = cc.Node:create()

		var_30_4:setName("show_girl")
		var_30_4:setPosition(cc.p(0, 0))
		arg_30_1:addChild(var_30_4)

		local var_30_5 = ROLE_SPINE_PATH .. model_data[var_30_1].rolespine .. ".json"
		local var_30_6 = ROLE_SPINE_PATH .. model_data[var_30_1].rolespine .. ".atlas"
		local var_30_7 = spinecache_manager:addSpineData(ROLE_SPINE_PATH .. model_data[var_30_1].rolespine .. ".json", ROLE_SPINE_PATH .. model_data[var_30_1].rolespine .. ".atlas")

		var_30_7:retain()

		local var_30_8 = sp.SkeletonAnimation:create(var_30_7:getData())

		var_30_8:setPosition(cc.p(GameDisplay.cx, 0))
		var_30_4:addChild(var_30_8, 2)
		var_30_8:setScale(0.72)
		var_30_8:setAnimation(0, "idle", true)
		var_30_4:registerScriptHandler(function(arg_31_0)
			if arg_31_0 == "exit" then
				var_30_7:release()
				spinecache_manager:removeSpineDataForKey(var_30_5, var_30_6)
			end
		end)
	end

	local var_30_9 = "mainScenebg/show_girl_page/btn_" .. model_data[var_30_1].role_image .. "_buy.png"

	if self.dataList[arg_30_2].isrecharged then
		var_30_9 = "mainScenebg/show_girl_page/btn_bought.png"
	end

	local var_30_10 = arg_30_1:getChildByName("btn_info")

	var_30_10:loadTextures(var_30_9, nil, var_30_9)

	var_30_10.modelid = var_30_1
	var_30_10.rechargeid = self.dataList[arg_30_2].rechargeid

	var_30_10:setVisible(self.dataList[arg_30_2].stat == var_0_13)
end

function PopShowGirlPageLayer:initOtherUI()
	self.rootLayer:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	local var_32_0 = ccui.ImageView:create("mainScenebg/show_girl_page/title_" .. self.id .. ".png")

	var_32_0:setPosition(cc.p(320, GameDisplay.getScreenSize().height - 110))
	self.rootLayer:addChild(var_32_0)

	local var_32_1 = ccui.ImageView:create("mainScenebg/show_girl_page/bottom.png")

	var_32_1:setTouchEnabled(true)
	var_32_1:setPosition(cc.p(320, 120))
	self.rootLayer:addChild(var_32_1)

	local var_32_2 = ccui.Layout:create()

	var_32_2:setContentSize(cc.size(640, 70))
	var_32_2:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_32_2:setTouchEnabled(true)
	self:addChild(var_32_2, 20000)
	var_32_2:setTouchEnabled(true)
	var_32_2:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	local var_32_3 = ccui.Layout:create()

	var_32_3:setContentSize(cc.size(640, 200))
	var_32_3:setAnchorPoint(cc.p(0.5, 1))
	var_32_3:setPosition(cc.p(320, GameDisplay.height))
	var_32_3:setTouchEnabled(true)
	self:addChild(var_32_3, 20000)
	var_32_3:setTouchEnabled(true)
	var_32_3:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopShowGirlPageLayer.getRechargeStat(arg_36_0, arg_36_1)
	do return var_0_13 end

	if global_get_time_by_date(recharge_data[arg_36_1].starttime) > time_check_manager:getCurTime() then
		return var_0_14
	end

	return var_0_13
end

function PopShowGirlPageLayer.isSkinRecharged(arg_37_0, arg_37_1)
	do return true end

	for iter_37_0, iter_37_1 in pairs((drop_manager:getAllDrops(item_data[recharge_data[arg_37_1].dropitem].mode_id))) do
		if item_data[iter_37_1.dropid].bag_item_type == kITEM_SKIN then
			return item_manager:haveItem(iter_37_1.dropid)
		end
	end

	return false
end

function PopShowGirlPageLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopShowGirlPageLayer:initBg(arg_40_1)
	local var_40_0 = ccui.Layout:create()

	var_40_0:setTouchEnabled(true)
	var_40_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_40_0:setAnchorPoint(cc.p(0, 0))
	var_40_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_40_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_40_0:setOpacity(0)
	self:addChild(var_40_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_41_0)
		self:addChild(arg_41_0, -2)
		arg_41_0:setPositionY(arg_41_0:getPositionY() - GameDisplay.fix_y)

		local var_41_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_41_0:setAnchorPoint(cc.p(0, 0))
		var_41_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_41_0, -1)
		self:init(arg_40_1)
		var_40_0:setOpacity(102)
		var_40_0:setTouchEnabled(false)
	end)
end
