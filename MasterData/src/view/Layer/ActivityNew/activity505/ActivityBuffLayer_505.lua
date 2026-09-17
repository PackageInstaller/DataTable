local ActivityBuffLayer_505 = class("ActivityBuffLayer_505", function()
	return cc.Layer:create()
end)
local rougeexplore_buff_data = require("data.activity_505.rougeexplore_buff_data")
local item_manager = require("controller.item_manager")
local l2utils = require("controller.l2utils")
local var_0_4 = 50502001
local var_0_5 = config._DEBUG and 0 or 1

function ActivityBuffLayer_505:create()
	local var_2_0 = ActivityBuffLayer_505.new()

	var_2_0:init()

	return var_2_0
end

function ActivityBuffLayer_505:init()
	self:initData()
	self:initUI()
	self:initList()
end

function ActivityBuffLayer_505:initData()
	self.dataInfo = rougeexplore_buff_data
	self.curStarNum = item_manager:getItemNumber(var_0_4)
	self.curBuffIndex = 0

	for iter_4_0 = #self.dataInfo, 1, -1 do
		if self.dataInfo[iter_4_0].starnum <= self.curStarNum then
			self.curBuffIndex = iter_4_0

			break
		end
	end
end

function ActivityBuffLayer_505:initUI()
	local var_5_0 = ccui.Layout:create()

	var_5_0:setTouchEnabled(true)
	var_5_0:setPosition(0, -GameDisplay.fix_y)
	var_5_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_5_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_5_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_5_0:setBackGroundColorOpacity(150)
	self:addChild(var_5_0)
	var_5_0:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	local var_5_1 = ccui.ImageView:create("ActivityBuffLayer_505/mid_bg.png", var_0_5)

	var_5_1:setPosition(GameDisplay.cx, GameDisplay.cy)
	self:addChild(var_5_1)

	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setContentSize(cc.size(628, 595))
	self.scrollView:setPosition(cc.p(0, 35))
	self.scrollView:setName("scrollView")
	self.scrollView:setDirection(ccui.ScrollViewDir.vertical)
	var_5_1:addChild(self.scrollView)
end

function ActivityBuffLayer_505:initList()
	self.scrollView:setInnerContainerSize(cc.size(628, 118 * #self.dataInfo))

	for iter_7_0, iter_7_1 in ipairs(self.dataInfo) do
		local var_7_0 = self:createSp(iter_7_0, iter_7_1)

		var_7_0:setPosition(cc.p(314, 118 * #self.dataInfo - (iter_7_0 - 1) * 108))
		self.scrollView:addChild(var_7_0)
	end
end

function ActivityBuffLayer_505:createSp(arg_8_1, arg_8_2)
	local var_8_0 = ccui.ImageView:create("ActivityBuffLayer_505/list_bg.png", var_0_5)

	var_8_0:setAnchorPoint(cc.p(0.5, 1))

	local var_8_1 = ccui.ImageView:create("ActivityBuffLayer_505/star.png", var_0_5)

	var_8_1:setPosition(45, 70)
	var_8_0:addChild(var_8_1)

	local var_8_2 = cc.Label:createWithTTF(self.curStarNum .. "/" .. arg_8_2.starnum, FONT_NAME, 22)

	var_8_2:setColor(cc.c3b(142, 102, 48))
	var_8_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_2:setPosition(45, 24)
	var_8_0:addChild(var_8_2)

	local var_8_3 = cc.Label:createWithTTF(arg_8_2.des, FONT_NAME, 22)

	var_8_3:setColor(cc.c3b(142, 102, 48))
	var_8_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_3:setPosition(300, 60)
	var_8_0:addChild(var_8_3)

	if arg_8_1 > self.curBuffIndex then
		var_8_0:setColor(cc.c3b(115, 115, 115))
		var_8_1:setColor(cc.c3b(217, 217, 217))
	end

	return var_8_0
end

return ActivityBuffLayer_505
