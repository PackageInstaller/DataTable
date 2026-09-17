PopTGVRechargeInfoLayer = class("PopTGVRechargeInfoLayer", function()
	return PopBaseLayer:create()
end)

function PopTGVRechargeInfoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTGVRechargeInfoLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local activity_manager = require("controller.activity_manager")

function PopTGVRechargeInfoLayer:init(arg_3_1)
	print("open poplayer : PopTGVRechargeInfoLayer")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0, 0.5))
	self.rootLayer:setPositionY(GameDisplay:getScreenSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	self.activityId = require("controller.time_check_manager"):getCurTime() < os.time(parse_time("2025-11-25 00:00:00")) and 770 or 853
	self.imgPath = "activitiesRes/activity" .. self.activityId .. "/showlist/"

	self:initUI(arg_3_1)
	self:initData()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopTGVRechargeInfoLayer.initData(arg_5_0)
	return
end

function PopTGVRechargeInfoLayer:initUI(arg_6_1)
	self:initExitTouchEvent()
end

function PopTGVRechargeInfoLayer:initExitTouchEvent()
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self:exit()
	end)

	self.bg = ccui.ImageView:create(self.imgPath .. "bg.png")

	self.bg:setTouchEnabled(true)
	self.bg:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootLayer:addChild(self.bg)
	self.rootLayer:setScaleY(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1)))

	local var_7_0 = cc.Label:createWithTTF("0元", "fonts/W5.ttf", 25)

	var_7_0:setPosition(cc.p(420, 340))
	var_7_0:setColor(cc.c3b(255, 186, 0))
	self.bg:addChild(var_7_0)

	local var_7_1 = cc.Label:createWithTTF(0, "fonts/W5.ttf", 25)

	var_7_1:setPosition(cc.p(480, 220))
	var_7_1:setColor(cc.c3b(255, 186, 0))
	self.bg:addChild(var_7_1)
	activity_manager:getActivityTaskList(self.activityId, nil, function(arg_9_0, arg_9_1)
		if arg_9_0 ~= 1 then
			return
		end

		var_7_0:setString(arg_9_1.list[1].finished .. "元")
		var_7_1:setString(math.floor(arg_9_1.list[1].finished / 100))
	end, false, nil, "total_recharge", "total_recharge")
end

function PopTGVRechargeInfoLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopTGVRechargeInfoLayer:initBg(arg_12_1)
	local var_12_0 = ccui.Layout:create()

	var_12_0:setTouchEnabled(true)
	var_12_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_0:setAnchorPoint(cc.p(0, 0))
	var_12_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_12_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_12_0:setOpacity(0)
	self:addChild(var_12_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_13_0)
		self:addChild(arg_13_0, -2)
		arg_13_0:setPositionY(arg_13_0:getPositionY() - GameDisplay.fix_y)

		local var_13_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_13_0:setAnchorPoint(cc.p(0, 0))
		var_13_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_13_0, -1)
		self:init(arg_12_1)
		var_12_0:setOpacity(102)
		var_12_0:setTouchEnabled(false)
	end)
end
