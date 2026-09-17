SupermarketLimitedTimePackageLayer = class("SupermarketLimitedTimePackageLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "mainScenebg/active/"
local recharge_manager = require("controller.recharge_manager")
local texture_manager = require("controller.texture_manager")
local var_0_5 = require("controller.GlobalConstantsManager"):getInstance()
local var_0_6 = setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		return 1
	end
})
local var_0_7 = setmetatable({}, {
	__index = function(arg_2_0, arg_2_1)
		return 2
	end
})
local var_0_8 = {
	received_btn_pos_x_2 = -22,
	received_btn_pos_x_1 = -17,
	received_btn_pos_y_83005_2 = 40,
	received_btn_pos_y_1 = 40,
	received_btn_pos_y_83005_1 = 40,
	received_btn_pos_y_2 = 40,
	received_btn_pos_x_83005_1 = -17,
	received_btn_pos_x_83005_2 = -22
}

function SupermarketLimitedTimePackageLayer:ctor()
	SupermarketLimitedTimePackageLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.supermarket_limited_time_package_manager"):getInstance()
end

function SupermarketLimitedTimePackageLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = SupermarketLimitedTimePackageLayer.new()

	if var_4_0 and var_4_0:init(arg_4_1) then
		return var_4_0
	end

	return nil
end

function SupermarketLimitedTimePackageLayer:onEnter()
	SupermarketLimitedTimePackageLayer.super.onEnter(self)
	self.manager:requestInfo(self._group)
end

function SupermarketLimitedTimePackageLayer.onExit(arg_6_0)
	SupermarketLimitedTimePackageLayer.super.onExit(arg_6_0)
end

function SupermarketLimitedTimePackageLayer:init(arg_7_1)
	self.ruleId = self:getRuleId(arg_7_1)

	local var_7_0 = string.split(var_0_5:getValueById(self.ruleId), "#")

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = string.split(var_7_0[iter_7_0], "&")

		var_0_6[tonumber(var_7_1[1])] = tonumber(var_7_1[2])
	end

	local var_7_2 = string.split(var_0_5:getValueById(10), "#")

	for iter_7_1 = 1, #var_7_2 do
		local var_7_3 = string.split(var_7_2[iter_7_1], "&")

		var_0_7[tonumber(var_7_3[1])] = tonumber(var_7_3[2])
	end

	self.showDir = var_0_7[arg_7_1]
	self._group = arg_7_1
	var_0_2 = "mainScenebg/active/" .. arg_7_1 .. "/" .. arg_7_1 .. "_"

	if self.ruleId == 11 then
		var_0_2 = "mainScenebg/active/" .. arg_7_1 .. "/"
	end

	self:initLayer()
	self:initListener()

	return true
end

function SupermarketLimitedTimePackageLayer.getRuleId(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs((require("data.global_constants_data"))) do
		local var_8_0 = string.split(iter_8_1.value, "#")

		for iter_8_2 = 1, #var_8_0 do
			if tonumber(string.split(var_8_0[iter_8_2], "&")[1]) == arg_8_1 then
				return iter_8_1.id
			end
		end
	end
end

function SupermarketLimitedTimePackageLayer:initLayer()
	local var_9_0 = TempWidget:CreateTempLayout(self)

	var_9_0:setContentSize(637, 100)

	self._root = var_9_0

	local var_9_1 = TempWidget:CreateTempImg("mainScenebg/active/count_down_bg.png", var_9_0, 0)

	var_9_1:align(cc.p(0, 1), 0, var_9_0:size().h - 76)
	var_9_1:hide()
	var_9_1:setLocalZOrder(999)

	function var_9_1.afterLoadSuccess()
		var_9_1:align(cc.p(0, 1), 0, var_9_0:size().h - 76)

		if self.listView then
			self.listView:align(cc.p(0.5, 1), self._root:size().w / 2, self.countDownBg:pos().y - self.countDownBg:size().h - 10)
		end
	end

	self.countDownBg = var_9_1

	local var_9_2 = TempWidget:CreateTempLabel("", FONT_NAME, 20, var_9_1)

	var_9_2:align(cc.p(0, 0.5), 56, 16)

	self.countDownText = var_9_2

	if self.showDir == self.manager.SHOW_DIR.UP_DOWN then
		self:initVerticalLayer()
	elseif self.showDir == self.manager.SHOW_DIR.LEFT_RIGHT then
		self:initHorizontalLayer()
	end
end

function SupermarketLimitedTimePackageLayer:initHorizontalLayer()
	local var_11_0 = ccui.PageView:create()

	var_11_0:setContentSize(cc.size(GameDisplay.width, 658))
	var_11_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + 200))
	self._root:addChild(var_11_0)

	self.pageView = var_11_0

	self:initBuyLayout()
end

function SupermarketLimitedTimePackageLayer:initBuyLayout()
	local var_12_0 = TempWidget:CreateTempLayout(self._root)

	var_12_0:setContentSize(cc.size(GameDisplay.width, 100))
	var_12_0:align(cc.p(0.5, 1), GameDisplay.cx, self.pageView:getPositionY() - self.pageView:getContentSize().height / 2 - 50)

	self.buyLayout = var_12_0
end

function SupermarketLimitedTimePackageLayer:initVerticalLayer()
	local var_13_0 = TempWidget:CreateTempListView(self._root)

	var_13_0:setContentSize(cc.size(self._root:size().w, self._root:size().h - 290))
	var_13_0:align(cc.p(0.5, 1), self._root:size().w / 2, self.countDownBg:pos().y - self.countDownBg:size().h - 10)

	self.listView = var_13_0
end

function SupermarketLimitedTimePackageLayer:initExtraGiftLayout()
	if var_0_6[self._group] == 1 then
		self:initExtraGiftLayoutShowType1()
	elseif var_0_6[self._group] == 2 then
		self:initExtraGiftLayoutShowType2()
	end
end

function SupermarketLimitedTimePackageLayer:initExtraGiftLayoutShowType1()
	local var_15_0 = self.pageView:getPages()
	local var_15_1 = self.manager:getInfo()
	local var_15_2 = self.manager:getExtraGiftInfo()

	local function var_15_3(arg_16_0, arg_16_1)
		local var_16_0 = TempWidget:CreateTempLayout(arg_16_0._childData.bg)

		var_16_0:setContentSize(cc.size(150, 200))
		var_16_0:align(cc.p(0, 1), 35, arg_16_0._childData.bg:size().h - 50)

		local var_16_1 = TempWidget:CreateTempListView(var_16_0)

		var_16_1:setContentSize(var_16_0:size())

		arg_16_0._childData.lv = var_16_1

		local var_16_2 = cc.size(var_16_0:size().w, var_16_0:size().h / 2)

		arg_16_0._childData.giftLayoutTable = {}

		for iter_16_0 = 1, #arg_16_1 do
			arg_16_0._childData.giftLayoutTable[iter_16_0] = {}

			local var_16_4 = TempWidget:CreateTempLayout()

			var_16_4:setContentSize(var_16_2)
			TempWidget:CreateTempImg(var_0_2 .. arg_16_1[iter_16_0].typeImgName, var_16_4, 0):align(cc.p(0, 1), 5, var_16_4:size().h - 10)

			local var_16_5 = TempWidget:CreateTempImg(var_0_2 .. arg_16_1[iter_16_0].imgName, var_16_4, 0)

			var_16_5:align(cc.p(0.5, 1), var_16_4:size().w / 2 + 10, var_16_4:size().h)
			var_16_5:_addEvent(function()
				if arg_16_1[iter_16_0].callBack then
					arg_16_1[iter_16_0].callBack()
				end
			end)

			arg_16_0._childData.giftLayoutTable[iter_16_0].img = var_16_5

			if arg_16_1[iter_16_0].tipsStr then
				local var_16_6 = TempWidget:CreateTempLabel(arg_16_1[iter_16_0].tipsStr, arg_16_1[iter_16_0].tipsStrFontInfo.font, arg_16_1[iter_16_0].tipsStrFontInfo.size, var_16_4)

				var_16_6:_setColor(arg_16_1[iter_16_0].tipsStrFontInfo.color)
				var_16_6:align(cc.p(0.5, 0), var_16_4:property().top_bottom)
			end

			var_16_1:pushBackCustomItem(var_16_4)
		end
	end

	for iter_15_0 = 1, #var_15_0 do
		if var_15_2[iter_15_0] then
			if #var_15_1 == 1 then
				var_15_3(var_15_0[iter_15_0], var_15_2[iter_15_0])
			else
				var_15_3(var_15_0[iter_15_0 + 1], var_15_2[iter_15_0])
			end
		end

		if #var_15_1 ~= 1 then
			var_15_3(var_15_0[1], var_15_2[#var_15_2])
			var_15_3(var_15_0[#var_15_0], var_15_2[1])
		end
	end
end

function SupermarketLimitedTimePackageLayer:initExtraGiftLayoutShowType2()
	local var_18_0 = self.pageView:getPages()
	local var_18_1 = self.manager:getInfo()
	local var_18_2 = self.manager:getExtraGiftInfo()

	local function var_18_3(arg_19_0, arg_19_1)
		local var_19_0 = TempWidget:CreateTempLayout(arg_19_0._childData.bg)

		var_19_0:setContentSize(cc.size(self._root:size().w - 210, 200))
		var_19_0:setBackGroundColorOpacity(200)
		var_19_0:align(cc.p(0, 0), 190, 20)

		local var_19_1 = TempWidget:CreateTempListView(var_19_0)

		var_19_1:setDirection(ccui.ListViewDirection.horizontal)
		var_19_1:setContentSize(var_19_0:size())

		arg_19_0._childData.lv = var_19_1

		local var_19_2 = cc.size(var_19_0:size().w / 2, var_19_0:size().h)

		arg_19_0._childData.giftLayoutTable = {}

		for iter_19_0 = 1, #arg_19_1 do
			arg_19_0._childData.giftLayoutTable[iter_19_0] = {}

			local var_19_4 = TempWidget:CreateTempLayout()

			var_19_4:setContentSize(var_19_2)
			TempWidget:CreateTempImg(var_0_2 .. arg_19_1[iter_19_0].typeImgName, var_19_4, 0):align(cc.p(0, 1), 5, var_19_4:size().h - 10)

			local var_19_5 = TempWidget:CreateTempImg(var_0_2 .. arg_19_1[iter_19_0].imgName, var_19_4, 0)

			var_19_5:align(cc.p(0.5, 1), var_19_4:size().w / 2 + 10, var_19_4:size().h)
			var_19_5:_addEvent(function()
				if arg_19_1[iter_19_0].callBack then
					arg_19_1[iter_19_0].callBack()
				end
			end)

			arg_19_0._childData.giftLayoutTable[iter_19_0].img = var_19_5

			if arg_19_1[iter_19_0].tipsStr then
				local var_19_6 = arg_19_1[iter_19_0].tipsStrFontInfo

				if self._group == 23007 then
					var_19_6.color = "b1441a"
					var_19_6.size = 22
				elseif self._group == 31301 then
					var_19_6.color = "f0f0f0"
					var_19_6.size = 22
				elseif self._group == 32001 then
					var_19_6.color = "342e3d"
					var_19_6.size = 22
				elseif self._group == 41706 then
					var_19_6.color = "ffffff"
					var_19_6.size = 22
				end

				local var_19_7 = TempWidget:CreateTempLabel(arg_19_1[iter_19_0].tipsStr, var_19_6.font, var_19_6.size, var_19_4)

				var_19_7:_setColor(var_19_6.color)
				var_19_7:align(cc.p(0.5, 0), var_19_5:pos().x, 0)

				arg_19_0._childData.giftLayoutTable[iter_19_0].tipsText = var_19_7
			end

			if arg_19_1[iter_19_0].btnImage then
				local var_19_8 = TempWidget:CreateTempBtn(var_0_2 .. arg_19_1[iter_19_0].btnImage, var_19_4, 0)

				var_19_8:align(cc.p(0.5, 0), var_19_5:pos().x + (var_0_8["received_btn_pos_x_" .. self._group .. "_" .. iter_19_0] or var_0_8["received_btn_pos_x_" .. iter_19_0] or 0), var_0_8["received_btn_pos_y_" .. self._group .. "_" .. iter_19_0] or var_0_8["received_btn_pos_y_" .. iter_19_0] or 40)
				var_19_8:_addEvent(arg_19_1[iter_19_0].btnCallBack)

				arg_19_0._childData.giftLayoutTable[iter_19_0].btn = var_19_8
			end

			var_19_1:pushBackCustomItem(var_19_4)
		end
	end

	for iter_18_0 = 1, #var_18_2 do
		if var_18_2[iter_18_0] then
			if #var_18_1 == 1 then
				var_18_3(var_18_0[iter_18_0], var_18_2[iter_18_0])
			else
				var_18_3(var_18_0[iter_18_0 + 1], var_18_2[iter_18_0])
			end
		end
	end

	if #var_18_1 ~= 1 then
		var_18_3(var_18_0[1], var_18_2[#var_18_2])
		var_18_3(var_18_0[#var_18_0], var_18_2[1])
	end
end

function SupermarketLimitedTimePackageLayer:initPropressLayout()
	local var_21_0 = TempWidget:CreateTempLayout(self._root)

	var_21_0:setContentSize(cc.size(GameDisplay.width, 15))
	var_21_0:align(cc.p(0.5, 1), GameDisplay.cx, self.pageView:getPositionY() - self.pageView:getContentSize().height / 2 - 10)

	self.propressLayout = var_21_0

	local var_21_1 = #self.manager:getInfo()
	local var_21_2 = TempWidget:CreateTempImg(var_0_2 .. "pro_dark.png", nil, 0):size()
	local var_21_3 = var_21_0:size().w / 2 - (var_21_2.w * var_21_1 + 0 * (var_21_1 - 1)) / 2

	var_21_0._childData = {}
	var_21_0._childData.imgTab = {}

	for iter_21_0 = 1, var_21_1 do
		local var_21_4 = TempWidget:CreateTempImg(var_0_2 .. "pro_dark.png", var_21_0, 0)

		var_21_4:align(cc.p(0, 0.5), var_21_3 + (var_21_2.w + 0) * (iter_21_0 - 1), var_21_0:size().h / 2)

		var_21_0._childData.imgTab[iter_21_0] = var_21_4
	end
end

function SupermarketLimitedTimePackageLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_24_0)
		self.manager:buySuccess(arg_24_0)
	end), self)
end

function SupermarketLimitedTimePackageLayer:updateLayer()
	if self.showDir == self.manager.SHOW_DIR.UP_DOWN then
		self:updateVerticalLayer()
	elseif self.showDir == self.manager.SHOW_DIR.LEFT_RIGHT then
		self:updateHorizontalLayer()
	end
end

function SupermarketLimitedTimePackageLayer:updateHorizontalLayer()
	self:updatePageView()
	self:initPropressLayout()
	self:updatePropressLayout()
	self:updateBuyLayout()
	self:updateCountDown()
end

function SupermarketLimitedTimePackageLayer:updateVerticalLayer()
	self:updateListView()
	self:updateCountDown()
end

function SupermarketLimitedTimePackageLayer.updateRed(arg_28_0)
	return
end

function SupermarketLimitedTimePackageLayer:updatePageView()
	local var_29_0 = self.pageView

	self.pageView:removeAllPages()

	local var_29_1 = require("controller.GlobalConstantsManager"):getInstance()
	local var_29_2 = {}
	local var_29_3 = string.split(var_29_1:getValueById(12) or "", "&")

	for iter_29_0 = 1, #var_29_3 do
		var_29_3[iter_29_0] = string.split(var_29_3[iter_29_0], "#")

		if tonumber(var_29_3[iter_29_0][1]) == self._group then
			for iter_29_1 = 2, #var_29_3[iter_29_0] do
				table.insert(var_29_2, tonumber(var_29_3[iter_29_0][iter_29_1]))
			end
		end
	end

	local var_29_4 = 100
	local var_29_5 = self.manager:getInfo()
	local var_29_6 = self.pageView:getContentSize()

	for iter_29_2 = 1, #var_29_5 do
		local var_29_7 = TempWidget:CreateTempLayout()

		var_29_7:setContentSize(var_29_6)

		var_29_7._childData = {}

		local var_29_8 = self.ruleId == 11 and TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_29_7, 0) or TempWidget:CreateTempImg(var_0_2 .. "bg_" .. var_29_5[iter_29_2].id .. ".png", var_29_7, 0)

		var_29_8:align(cc.p(0.5, 0), var_29_7:property().top_bottom)

		var_29_7._childData.bg = var_29_8

		local var_29_9 = var_29_1:getValueById(var_29_2[iter_29_2])

		if var_29_9 then
			local var_29_10 = string.split(var_29_9, "#")
			local var_29_11 = string.split(var_29_10[1], "&")
			local var_29_12 = string.split(var_29_10[2], "&")
			local var_29_13 = string.split(var_29_10[3], "&")
			local var_29_14 = string.split(var_29_10[4], "&")
			local var_29_15 = string.split(var_29_10[5], "&")

			for iter_29_3 = 1, #var_29_11 do
				local var_29_16 = TempWidget:CreateTempLayout(var_29_8)

				if config._DEBUG then
					var_29_16:_setBack()
				end

				var_29_16:setLocalZOrder(var_29_4)
				var_29_16:move(cc.p(tonumber(var_29_11[iter_29_3]), tonumber(var_29_12[iter_29_3])))
				var_29_16:setContentSize(cc.size(tonumber(var_29_13[iter_29_3]), tonumber(var_29_14[iter_29_3])))
				var_29_16:_addEvent(function()
					PopLayer:Item({
						hideGainButton = true,
						itemid = tonumber(var_29_15[iter_29_3])
					})
				end)
			end
		end

		local var_29_17 = 120
		local var_29_18 = 20

		if self._group == 23007 then
			var_29_17 = 330
			var_29_18 = 5
		end

		local var_29_19 = TempWidget:CreateTempBtn(var_0_2 .. "left_btn.png", var_29_8, 0)

		var_29_19:align(cc.p(0, 0), var_29_18, var_29_17)
		var_29_19:_addEvent(function()
			local var_31_0 = var_29_0:getCurPageIndex()

			if #var_29_5 ~= 1 and var_31_0 > 0 then
				var_29_0:scrollToPage(var_31_0 - 1)
			end
		end)
		var_29_19:setVisible(#var_29_5 > 1)

		local var_29_20 = TempWidget:CreateTempBtn(var_0_2 .. "right_btn.png", var_29_8, 0)

		var_29_20:align(cc.p(1, 0), var_29_8:size().w - var_29_18, var_29_17)
		var_29_20:_addEvent(function()
			local var_32_0 = var_29_0:getCurPageIndex()

			if #var_29_5 ~= 1 and var_32_0 < #var_29_5 + 1 then
				var_29_0:scrollToPage(var_32_0 + 1)
			end
		end)
		var_29_20:setVisible(#var_29_5 > 1)
		self.pageView:addPage(var_29_7)
	end

	if #var_29_5 ~= 1 then
		self:pagesInsertFront()
		self:pagesInsertLast()

		if not self.bFirstInto and var_0_6[self._group] then
			self.bFirstInto = true

			self.pageView:scrollToPage(#var_29_5)
		else
			self.pageView:scrollToPage(1)
		end
	end

	self.pageView:addEventListener(handler(self, self.onPageViewScroll))
	self:initExtraGiftLayout()
end

function SupermarketLimitedTimePackageLayer:pagesInsertFront()
	local var_33_0 = require("controller.GlobalConstantsManager"):getInstance()
	local var_33_1 = {}
	local var_33_2 = string.split(var_33_0:getValueById(11) or "", "&")

	for iter_33_0 = 1, #var_33_2 do
		var_33_2[iter_33_0] = string.split(var_33_2[iter_33_0], "#")

		if tonumber(var_33_2[iter_33_0][1]) == self._group then
			for iter_33_1 = 2, #var_33_2[iter_33_0] do
				table.insert(var_33_1, tonumber(var_33_2[iter_33_0][iter_33_1]))
			end
		end
	end

	local var_33_3 = 100
	local var_33_4 = self.manager:getInfo()
	local var_33_5 = TempWidget:CreateTempLayout()

	var_33_5:setContentSize((self.pageView:getContentSize()))

	var_33_5._childData = {}

	local var_33_6 = self.ruleId == 11 and TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_33_5, 0) or TempWidget:CreateTempImg(var_0_2 .. "bg_" .. var_33_4[#var_33_4].id .. ".png", var_33_5, 0)

	var_33_6:align(cc.p(0.5, 0), var_33_5:property().top_bottom)

	var_33_5._childData.bg = var_33_6

	local var_33_7 = var_33_0:getValueById(var_33_1[#var_33_4])

	if var_33_7 then
		local var_33_8 = string.split(var_33_7, "#")
		local var_33_9 = string.split(var_33_8[1], "&")
		local var_33_10 = string.split(var_33_8[2], "&")
		local var_33_11 = string.split(var_33_8[3], "&")
		local var_33_12 = string.split(var_33_8[4], "&")
		local var_33_13 = string.split(var_33_8[5], "&")

		for iter_33_2 = 1, #var_33_9 do
			local var_33_14 = TempWidget:CreateTempLayout(var_33_6)

			if config._DEBUG then
				var_33_14:_setBack()
			end

			var_33_14:setLocalZOrder(var_33_3)
			var_33_14:move(cc.p(tonumber(var_33_9[iter_33_2]), tonumber(var_33_10[iter_33_2])))
			var_33_14:setContentSize(cc.size(tonumber(var_33_11[iter_33_2]), tonumber(var_33_12[iter_33_2])))
			var_33_14:_addEvent(function()
				PopLayer:Item({
					hideGainButton = true,
					itemid = tonumber(var_33_13[iter_33_2])
				})
			end)
		end
	end

	local var_33_15 = 120
	local var_33_16 = 20

	if self._group == 23007 then
		var_33_15 = 330
		var_33_16 = 5
	end

	local var_33_17 = TempWidget:CreateTempBtn(var_0_2 .. "left_btn.png", var_33_6, 0)

	var_33_17:align(cc.p(0, 0), var_33_16, var_33_15)
	var_33_17:_addEvent(function()
		return
	end)

	local var_33_18 = TempWidget:CreateTempBtn(var_0_2 .. "right_btn.png", var_33_6, 0)

	var_33_18:align(cc.p(1, 0), var_33_6:size().w - var_33_16, var_33_15)
	var_33_18:_addEvent(function()
		return
	end)
	self.pageView:insertPage(var_33_5, 0)
end

function SupermarketLimitedTimePackageLayer:pagesInsertLast()
	local var_37_0 = require("controller.GlobalConstantsManager"):getInstance()
	local var_37_1 = {}
	local var_37_2 = string.split(var_37_0:getValueById(11) or "", "&")

	for iter_37_0 = 1, #var_37_2 do
		var_37_2[iter_37_0] = string.split(var_37_2[iter_37_0], "#")

		if tonumber(var_37_2[iter_37_0][1]) == self._group then
			for iter_37_1 = 2, #var_37_2[iter_37_0] do
				table.insert(var_37_1, tonumber(var_37_2[iter_37_0][iter_37_1]))
			end
		end
	end

	local var_37_3 = 100
	local var_37_4 = TempWidget:CreateTempLayout()

	var_37_4:setContentSize((self.pageView:getContentSize()))

	var_37_4._childData = {}

	local var_37_5 = self.ruleId == 11 and TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_37_4, 0) or TempWidget:CreateTempImg(var_0_2 .. "bg_" .. self.manager:getInfo()[1].id .. ".png", var_37_4, 0)

	var_37_5:align(cc.p(0.5, 0), var_37_4:property().top_bottom)

	var_37_4._childData.bg = var_37_5

	local var_37_6 = var_37_0:getValueById(var_37_1[1])

	if var_37_6 then
		local var_37_7 = string.split(var_37_6, "#")
		local var_37_8 = string.split(var_37_7[1], "&")
		local var_37_9 = string.split(var_37_7[2], "&")
		local var_37_10 = string.split(var_37_7[3], "&")
		local var_37_11 = string.split(var_37_7[4], "&")
		local var_37_12 = string.split(var_37_7[5], "&")

		for iter_37_2 = 1, #var_37_8 do
			local var_37_13 = TempWidget:CreateTempLayout(var_37_5)

			if config._DEBUG then
				var_37_13:_setBack()
			end

			var_37_13:setLocalZOrder(var_37_3)
			var_37_13:move(cc.p(tonumber(var_37_8[iter_37_2]), tonumber(var_37_9[iter_37_2])))
			var_37_13:setContentSize(cc.size(tonumber(var_37_10[iter_37_2]), tonumber(var_37_11[iter_37_2])))
			var_37_13:_addEvent(function()
				PopLayer:Item({
					hideGainButton = true,
					itemid = tonumber(var_37_12[iter_37_2])
				})
			end)
		end
	end

	local var_37_14 = 120
	local var_37_15 = 20

	if self._group == 23007 then
		var_37_14 = 330
		var_37_15 = 5
	end

	local var_37_16 = TempWidget:CreateTempBtn(var_0_2 .. "left_btn.png", var_37_5, 0)

	var_37_16:align(cc.p(0, 0), var_37_15, var_37_14)
	var_37_16:_addEvent(function()
		return
	end)

	local var_37_17 = TempWidget:CreateTempBtn(var_0_2 .. "right_btn.png", var_37_5, 0)

	var_37_17:align(cc.p(1, 0), var_37_5:size().w - var_37_15, var_37_14)
	var_37_17:_addEvent(function()
		return
	end)
	self.pageView:insertPage(var_37_4, #self.pageView:getPages())
end

function SupermarketLimitedTimePackageLayer:updatePropressLayout()
	local var_41_0 = self.manager:getInfo()
	local var_41_1 = self.pageView:getChildren()
	local var_41_2 = self.pageView:getCurPageIndex()

	for iter_41_0 = 1, #self.propressLayout._childData.imgTab do
		if #var_41_0 == 1 then
			if iter_41_0 == var_41_2 + 1 then
				self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_light.png", 0)
			else
				self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_dark.png", 0)
			end
		elseif var_41_2 == 0 then
			if iter_41_0 == #self.propressLayout._childData.imgTab then
				self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_light.png", 0)
			else
				self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_dark.png", 0)
			end
		elseif var_41_2 == #var_41_1 then
			if iter_41_0 == 1 then
				self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_light.png", 0)
			else
				self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_dark.png", 0)
			end
		elseif iter_41_0 == var_41_2 then
			self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_light.png", 0)
		else
			self.propressLayout._childData.imgTab[iter_41_0]:loadTexture(var_0_2 .. "pro_dark.png", 0)
		end
	end
end

function SupermarketLimitedTimePackageLayer:onPageViewScroll(arg_42_1, arg_42_2)
	if arg_42_2 == ccui.PageViewEventType.turning then
		local var_42_0 = self.manager:getInfo()

		if #var_42_0 ~= 1 then
			local var_42_1 = arg_42_1:getCurPageIndex()

			if var_42_1 == 0 then
				self:updatePageView()
				arg_42_1:scrollToPage(#var_42_0)
			elseif #var_42_0 + 1 == var_42_1 then
				self:updatePageView()
				arg_42_1:scrollToPage(1)
			end

			self:updatePropressLayout()
			self:updateBuyLayout()
		else
			self:updatePropressLayout()
			self:updateBuyLayout()
		end
	end
end

function SupermarketLimitedTimePackageLayer:updateBuyLayout()
	self.buyLayout:removeAllChildren()

	local var_43_0 = self.pageView:getCurPageIndex()
	local var_43_1 = self.manager:getInfo()
	local var_43_2 = var_43_0 + 1

	if #var_43_1 ~= 1 then
		var_43_2 = var_43_0 == 0 and #var_43_1 or #var_43_1 + 1 == var_43_0 and 1 or var_43_0
	end

	local var_43_3 = var_43_1[var_43_2]
	local var_43_4, var_43_5 = self.manager:canBuy(var_43_2)

	if var_43_4 then
		local var_43_6 = self.ruleId == 11 and TempWidget:CreateTempBtn(var_0_2 .. "buy.png", self.buyLayout, 0) or TempWidget:CreateTempBtn(var_0_2 .. "buy_" .. var_43_3.id .. ".png", self.buyLayout, 0)

		var_43_6:align(cc.p(0.5, 1), self.buyLayout:property().top_center)
		var_43_6:_addEvent(function()
			self.manager:requestBuy(var_43_2, true)
		end)

		local var_43_7 = TempWidget:CreateTempLabel(recharge_manager:getCommodityPriceStr(var_43_3.id) .. "  " .. L_ACTIVITY_EXPLORE_BUY_TIMES.button, FONT_NAME, 28, var_43_6)

		var_43_7:align(cc.p(0.5, 1), var_43_6:size().w / 2, var_43_6:size().h / 2 + 15)
		var_43_7:setColor(cc.c3b(0, 0, 0))
	elseif var_43_5 == self.manager.BUY_STATE.LOCK then
		local var_43_8 = TempWidget:CreateTempBtn(var_0_2 .. "buy_lock_" .. var_43_3.id .. ".png", self.buyLayout, 0)

		var_43_8:align(cc.p(0.5, 1), self.buyLayout:property().top_center)
		var_43_8:_addEvent(function()
			self.manager:requestBuy(var_43_2, true)
		end)
		TempWidget:CreateTempLabel(L_RECHARGE_BOUGHT_LOCK, FONT_NAME, 18, self.buyLayout):align(cc.p(0.5, 1), self.buyLayout:size().w / 2, var_43_8:pos().y - var_43_8:size().h - 10)
	elseif var_43_5 == self.manager.BUY_STATE.OWNED then
		local var_43_9 = TempWidget:CreateTempBtn(var_0_2 .. "owned.png", self.buyLayout, 0)

		var_43_9:align(cc.p(0.5, 1), self.buyLayout:property().top_center)

		local var_43_10 = TempWidget:CreateTempLabel(L_BOUGHT, FONT_NAME, 28, var_43_9)

		var_43_10:align(cc.p(0.5, 1), var_43_9:size().w / 2, var_43_9:size().h / 2 + 15)
		var_43_10:setColor(cc.c3b(0, 0, 0))
	end
end

function SupermarketLimitedTimePackageLayer:updateExtraGiftLayout()
	if self.showDir == self.manager.SHOW_DIR.UP_DOWN then
		self:updateVerticalExtraGiftLayout()
	elseif self.showDir == self.manager.SHOW_DIR.LEFT_RIGHT then
		self:updateHorizontalExtraGiftLayout()
	end
end

function SupermarketLimitedTimePackageLayer:updateHorizontalExtraGiftLayout()
	local var_47_0 = self.pageView:getPages()
	local var_47_1 = self.manager:getInfo()
	local var_47_2 = self.manager:getExtraGiftInfo()

	local function var_47_3(arg_48_0, arg_48_1)
		for iter_48_0 = 1, #arg_48_1 do
			arg_48_0._childData.giftLayoutTable[iter_48_0].img:loadTexture(var_0_2 .. arg_48_1[iter_48_0].imgName, 0)

			if arg_48_0._childData.giftLayoutTable[iter_48_0].btn and arg_48_1[iter_48_0].btnImage then
				arg_48_0._childData.giftLayoutTable[iter_48_0].btn:loadTextures(var_0_2 .. arg_48_1[iter_48_0].btnImage, nil, nil, 0)
			end

			if arg_48_0._childData.giftLayoutTable[iter_48_0].tipsText and arg_48_1[iter_48_0].tipsStr then
				arg_48_0._childData.giftLayoutTable[iter_48_0].tipsText:setString(arg_48_1[iter_48_0].tipsStr)
			end
		end
	end

	for iter_47_0 = 1, #var_47_1 do
		local var_47_4 = var_47_2[iter_47_0]

		if var_47_2[iter_47_0] then
			var_47_3(#var_47_1 == 1 and var_47_0[iter_47_0] or var_47_0[iter_47_0 + 1], var_47_4)

			if iter_47_0 == 1 then
				if #var_47_1 ~= 1 then
					var_47_3(var_47_0[#var_47_1 + 2], var_47_4)
				end
			elseif #var_47_1 == iter_47_0 and #var_47_1 ~= 1 then
				var_47_3(var_47_0[1], var_47_4)
			end
		end
	end
end

function SupermarketLimitedTimePackageLayer:updateVerticalExtraGiftLayout()
	local var_49_0 = self.listView:getChildren()
	local var_49_1 = self.manager:getExtraGiftInfo()

	local function var_49_2(arg_50_0, arg_50_1, arg_50_2)
		for iter_50_0 = 1, #arg_50_1 do
			arg_50_0._childData.giftLayoutTable[iter_50_0].img:loadTexture(var_0_2 .. arg_50_1[iter_50_0].imgName, 0)

			if arg_50_0._childData.giftLayoutTable[iter_50_0].btn and arg_50_1[iter_50_0].btnImage then
				arg_50_0._childData.giftLayoutTable[iter_50_0].btn:loadTextures(var_0_2 .. arg_50_1[iter_50_0].btnImage, nil, nil, 0)
			end

			if arg_50_0._childData.giftLayoutTable[iter_50_0].tipsText and arg_50_1[iter_50_0].tipsStr then
				arg_50_0._childData.giftLayoutTable[iter_50_0].tipsText:setString(arg_50_1[iter_50_0].tipsStr)
			end
		end

		self:updateVerticalBuyLayout(arg_50_0, arg_50_2)
	end

	for iter_49_0 = 1, #self.manager:getInfo() do
		if var_49_1[iter_49_0] then
			var_49_2(var_49_0[iter_49_0], var_49_1[iter_49_0], iter_49_0)
		end
	end
end

function SupermarketLimitedTimePackageLayer:receiveAccumulatedRewardsSuccess()
	self:updateExtraGiftLayout()
end

function SupermarketLimitedTimePackageLayer:buySuccess()
	self:updateExtraGiftLayout()

	if self.showDir == self.manager.SHOW_DIR.UP_DOWN then
		-- block empty
	elseif self.showDir == self.manager.SHOW_DIR.LEFT_RIGHT then
		self:updateBuyLayout()
	end

	self:updateCountDown()
end

function SupermarketLimitedTimePackageLayer:onReceiveGiftDailyReward()
	self:updateExtraGiftLayout()
end

function SupermarketLimitedTimePackageLayer.updateBySupermarketLayer(arg_54_0, arg_54_1)
	return
end

function SupermarketLimitedTimePackageLayer:updateCountDown()
	if self.manager:canShowFinishTimeString() then
		self.countDownBg:show()
		self.countDownText:setString(self.manager:getFinishTimeShowString())
	else
		self.countDownBg:hide()
	end
end

function SupermarketLimitedTimePackageLayer:updateListView()
	self.listView:removeAllItems()

	local var_56_0 = require("controller.GlobalConstantsManager"):getInstance()
	local var_56_1 = {}
	local var_56_2 = string.split(var_56_0:getValueById(11) or "", "&")

	for iter_56_0 = 1, #var_56_2 do
		var_56_2[iter_56_0] = string.split(var_56_2[iter_56_0], "#")

		if tonumber(var_56_2[iter_56_0][1]) == self._group then
			for iter_56_1 = 2, #var_56_2[iter_56_0] do
				table.insert(var_56_1, tonumber(var_56_2[iter_56_0][iter_56_1]))
			end
		end
	end

	local var_56_3 = 100
	local var_56_4 = self.manager:getInfo()
	local var_56_5 = cc.size(self.listView:getContentSize().width, 750)

	for iter_56_2 = 1, #var_56_4 do
		local var_56_6 = TempWidget:CreateTempLayout()

		var_56_6:setContentSize(var_56_5)

		var_56_6._childData = {}

		local var_56_7 = self.ruleId == 11 and TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_56_6, 0) or TempWidget:CreateTempImg(var_0_2 .. "bg_" .. var_56_4[iter_56_2].id .. ".png", var_56_6, 0)

		var_56_7:align(cc.p(0.5, 0), var_56_6:property().top_bottom)

		function var_56_7.afterLoadSuccess()
			if var_56_6._childData.sLayout then
				var_56_6._childData.sLayout:align(cc.p(0, 0), 190, 150)
			end

			if var_56_6._childData.buyLayout then
				var_56_6._childData.buyLayout:align(cc.p(0.5, 0), var_56_7:size().w / 2 + 100, 50)
			end
		end

		var_56_6._childData.bg = var_56_7

		local var_56_8 = var_56_0:getValueById(var_56_1[iter_56_2])

		if var_56_8 then
			local var_56_9 = string.split(var_56_8, "#")
			local var_56_10 = string.split(var_56_9[1], "&")
			local var_56_11 = string.split(var_56_9[2], "&")
			local var_56_12 = string.split(var_56_9[3], "&")
			local var_56_13 = string.split(var_56_9[4], "&")
			local var_56_14 = string.split(var_56_9[5], "&")

			for iter_56_3 = 1, #var_56_10 do
				local var_56_15 = TempWidget:CreateTempLayout(var_56_7)

				if config._DEBUG then
					var_56_15:_setBack()
				end

				var_56_15:setLocalZOrder(var_56_3)
				var_56_15:move(cc.p(tonumber(var_56_10[iter_56_3]), tonumber(var_56_11[iter_56_3])))
				var_56_15:setContentSize(cc.size(tonumber(var_56_12[iter_56_3]), tonumber(var_56_13[iter_56_3])))
				var_56_15:_addEvent(function()
					PopLayer:Item({
						hideGainButton = true,
						itemid = tonumber(var_56_14[iter_56_3])
					})
				end)
			end
		end

		if self._group == 23007 then
			-- block empty
		end

		self.listView:pushBackCustomItem(var_56_6)
	end

	self:initVerticalExtraGiftLayout()
end

function SupermarketLimitedTimePackageLayer:initVerticalExtraGiftLayout()
	local var_59_0 = self.listView:getChildren()
	local var_59_1 = self.manager:getInfo()
	local var_59_2 = self.manager:getExtraGiftInfo()

	local function var_59_3(arg_60_0, arg_60_1, arg_60_2)
		local var_60_0 = TempWidget:CreateTempLayout(arg_60_0._childData.bg)

		var_60_0:setContentSize(cc.size(self._root:size().w - 210, 200))
		var_60_0:setBackGroundColorOpacity(200)
		var_60_0:align(cc.p(0, 0), 190, 150)

		arg_60_0._childData.sLayout = var_60_0

		local var_60_1 = TempWidget:CreateTempListView(var_60_0)

		var_60_1:setDirection(ccui.ListViewDirection.horizontal)
		var_60_1:setContentSize(var_60_0:size())

		arg_60_0._childData.lv = var_60_1

		local var_60_2 = cc.size(var_60_0:size().w / 2, var_60_0:size().h)

		arg_60_0._childData.giftLayoutTable = {}

		for iter_60_0 = 1, #arg_60_1 do
			arg_60_0._childData.giftLayoutTable[iter_60_0] = {}

			local var_60_4 = TempWidget:CreateTempLayout()

			var_60_4:setContentSize(var_60_2)
			TempWidget:CreateTempImg(var_0_2 .. arg_60_1[iter_60_0].typeImgName, var_60_4, 0):align(cc.p(0, 1), 5, var_60_4:size().h - 10)

			local var_60_5 = TempWidget:CreateTempImg(var_0_2 .. arg_60_1[iter_60_0].imgName, var_60_4, 0)

			var_60_5:align(cc.p(0.5, 1), var_60_4:size().w / 2 + 10, var_60_4:size().h)
			var_60_5:_addEvent(function()
				if arg_60_1[iter_60_0].callBack then
					arg_60_1[iter_60_0].callBack()
				end
			end)

			arg_60_0._childData.giftLayoutTable[iter_60_0].img = var_60_5

			if arg_60_1[iter_60_0].tipsStr then
				local var_60_6 = arg_60_1[iter_60_0].tipsStrFontInfo

				if self._group == 23007 then
					var_60_6.color = "b1441a"
					var_60_6.size = 22
				elseif self._group == 33007 then
					var_60_6.color = "FFFFFF"
					var_60_6.size = 20
				end

				local var_60_7 = TempWidget:CreateTempLabel(arg_60_1[iter_60_0].tipsStr, var_60_6.font, var_60_6.size, var_60_4)

				var_60_7:_setColor(var_60_6.color)
				var_60_7:align(cc.p(0.5, 0), var_60_5:pos().x, 0)

				arg_60_0._childData.giftLayoutTable[iter_60_0].tipsText = var_60_7
			end

			if arg_60_1[iter_60_0].btnImage then
				local var_60_8 = TempWidget:CreateTempBtn(var_0_2 .. arg_60_1[iter_60_0].btnImage, var_60_4, 0)

				var_60_8:align(cc.p(0.5, 0), var_60_5:pos().x + (var_0_8["received_btn_pos_x_" .. self._group .. "_" .. iter_60_0] or var_0_8["received_btn_pos_x_" .. iter_60_0] or 0), var_0_8["received_btn_pos_y_" .. self._group .. "_" .. iter_60_0] or var_0_8["received_btn_pos_y_" .. iter_60_0] or 40)
				var_60_8:_addEvent(arg_60_1[iter_60_0].btnCallBack)

				arg_60_0._childData.giftLayoutTable[iter_60_0].btn = var_60_8
			end

			var_60_1:pushBackCustomItem(var_60_4)
		end

		local var_60_9 = self:createVerticalBuyLayout(arg_60_2)

		arg_60_0._childData.bg:addChild(var_60_9)
		var_60_9:align(cc.p(0.5, 0), arg_60_0._childData.bg:size().w / 2 + 100, 50)

		arg_60_0._childData.buyLayout = var_60_9
	end

	for iter_59_0 = 1, #var_59_2 do
		if var_59_2[iter_59_0] then
			var_59_3(var_59_0[iter_59_0], var_59_2[iter_59_0], iter_59_0)
		end
	end
end

function SupermarketLimitedTimePackageLayer:createVerticalBuyLayout(arg_62_1)
	local var_62_0 = TempWidget:CreateTempLayout()

	var_62_0:setName("buyLayout")
	var_62_0:setContentSize(cc.size(200, 100))

	local var_62_1 = arg_62_1
	local var_62_2 = self.manager:getInfo()[arg_62_1]
	local var_62_3, var_62_4 = self.manager:canBuy(arg_62_1)

	if var_62_3 then
		local var_62_5 = self.ruleId == 11 and TempWidget:CreateTempBtn(var_0_2 .. "buy.png", var_62_0, 0) or TempWidget:CreateTempBtn(var_0_2 .. "buy_" .. var_62_2.id .. ".png", var_62_0, 0)

		var_62_5:setName("buyBtn")
		var_62_5:align(cc.p(0.5, 0.5), var_62_0:property().center)
		var_62_5:_addEvent(function()
			self.manager:requestBuy(var_62_1, true)
		end)
	elseif var_62_4 == self.manager.BUY_STATE.LOCK then
		local var_62_6 = TempWidget:CreateTempBtn(var_0_2 .. "buy_lock_" .. var_62_2.id .. ".png", var_62_0, 0)

		var_62_6:setName("buyBtn")
		var_62_6:align(cc.p(0.5, 0.5), var_62_0:property().center)
		var_62_6:_addEvent(function()
			self.manager:requestBuy(var_62_1, true)
		end)

		local var_62_7 = TempWidget:CreateTempLabel("购买前置礼包后方可解锁该礼包", FONT_NAME, 18, var_62_0)

		var_62_7:setName("tipsText")
		var_62_7:align(cc.p(0.5, 1), var_62_0:size().w / 2, var_62_6:pos().y - var_62_6:size().h - 10)
	elseif var_62_4 == self.manager.BUY_STATE.OWNED then
		local var_62_8 = TempWidget:CreateTempBtn(var_0_2 .. "owned.png", var_62_0, 0)

		var_62_8:setName("buyBtn")
		var_62_8:align(cc.p(0.5, 0.5), var_62_0:property().center)
	end

	return var_62_0
end

function SupermarketLimitedTimePackageLayer:updateVerticalBuyLayout(arg_65_1, arg_65_2)
	local var_65_0 = arg_65_1._childData.bg:getChildByName("buyLayout")
	local var_65_1 = var_65_0:getChildByName("buyBtn")
	local var_65_2 = var_65_0:getChildByName("tipsText")
	local var_65_3 = self.manager:getInfo()[arg_65_2]
	local var_65_4, var_65_5 = self.manager:canBuy(arg_65_2)

	if var_65_4 then
		if self.ruleId == 11 then
			var_65_1:loadTextureNormal(var_0_2 .. "buy.png", 0)
		else
			var_65_1:loadTextureNormal(var_0_2 .. "buy_" .. var_65_3.id .. ".png", 0)
		end
	elseif var_65_5 == self.manager.BUY_STATE.LOCK then
		var_65_1:loadTextureNormal(var_0_2 .. "buy_lock_" .. var_65_3.id .. ".png", 0)

		if var_65_2 then
			var_65_2:setString("购买前置礼包后方可解锁该礼包")
		end
	elseif var_65_5 == self.manager.BUY_STATE.OWNED then
		var_65_1:loadTextureNormal(var_0_2 .. "owned.png", 0)
	end
end

return SupermarketLimitedTimePackageLayer
