PopShowArenaInfo = class("PopShowArenaInfo", function()
	return PopBaseLayer:create()
end)

local TempWidget = require("view/Sprite/TempWidget")

function PopShowArenaInfo.create(arg_2_0, arg_2_1)
	local var_2_0 = PopShowArenaInfo.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopShowArenaInfo:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Arean_DetailInfo.json" or "Arean_DetailInfo.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer)

	self.rootpanel = self.rootLayer
	self.zhupanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")
	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

	global_window_open_action(self.zhupanel)
	self:initpanel(arg_3_1)
	self:fullScreen(self.rootLayer)

	local function var_3_0()
		LayerManager:removePopLayer(self.__queueindex)
	end

	self.surebtn:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.zhupanel, var_3_0)
	end)
	self.rootLayer:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.zhupanel, var_3_0)
	end)
end

function PopShowArenaInfo:initpanel(arg_7_1)
	local var_7_0 = {
		cc.p(305, 620 + 280),
		cc.p(305, 550 + 280),
		cc.p(305, 457 + 280),
		cc.p(305, 364 + 280),
		cc.p(305, 295 + 280),
		cc.p(305, 295 - 32.5 + 280),
		cc.p(305, 295 - 32.5 * 2 + 280),
		cc.p(305, 295 - 32.5 * 3 + 280),
		cc.p(305, 295 - 32.5 * 4 + 280),
		cc.p(305, 295 - 32.5 * 5 + 280),
		cc.p(305, 295 - 32.5 * 6 + 280),
		cc.p(305, 295 - 32.5 * 7 + 280),
		(cc.p(305, 295 - 32.5 * 8 + 280))
	}

	for iter_7_0 = 1, 13 do
		local var_7_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_" .. iter_7_0)

		if iter_7_0 == 10 and var_7_1:getParent():getName() == "Label_4" then
			var_7_1:removeFromParent()
			ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):addChild(var_7_1)
		end

		var_7_1:setString("")
		var_7_1:setPosition(var_7_0[iter_7_0])
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_" .. iter_7_0 .. "_0"):setString("")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_" .. iter_7_0 .. "_0"):setPositionX(136)

		if iter_7_0 == 2 then
			local var_7_2 = TempWidget:CreateTempImg("ArenaScene/first_head_bg.png", var_7_1:getParent())

			var_7_2:align(cc.p(0.5, 0.5), 420, var_7_1:getPositionY() - 670)
			var_7_2:setScale(1.6)

			local var_7_3 = TempWidget:CreateTempImg("ArenaScene/first_head_img.png", var_7_2)

			var_7_3:setScale(0.32)
			var_7_3:align(cc.p(0.5, 0), var_7_2:size().w / 2, 0)
		end
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_1"):setString("")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_1_0"):setString("")
	self.surebtn:setPosition(cc.p(286, -20))

	if not arg_7_1 then
		return
	end

	local var_7_4 = {}
	local var_7_5 = tostring(arg_7_1.diamond)
	local var_7_6 = tostring(arg_7_1.honor)

	if var_7_5 == "nil" then
		var_7_5 = "0"
	end

	if var_7_6 == "nil" then
		var_7_6 = "0"
	end

	for iter_7_1, iter_7_2 in ipairs(arg_7_1.labels.des.value) do
		local var_7_7 = string.match(iter_7_2, "(%d+)")
		local var_7_8 = string.len(iter_7_2)
		local var_7_9, var_7_10 = string.find(iter_7_2, var_7_7)

		table.insert(var_7_4, {
			diamond = var_7_7,
			horor = string.match(string.sub(iter_7_2, var_7_10 + 1, var_7_8), "(%d+)")
		})
	end

	for iter_7_3, iter_7_4 in ipairs(var_7_4) do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_" .. iter_7_3 + 1):setString(iter_7_4.diamond)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_" .. iter_7_3 + 1 .. "_0"):setString(iter_7_4.horor)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_1"):setString(var_7_5)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_1_0"):setString(var_7_6)
end

function PopShowArenaInfo:fullScreen(arg_8_1)
	arg_8_1:setContentSize((GameDisplay.getScreenSize()))
	arg_8_1:setPositionY(arg_8_1:getPositionY() - GameDisplay.fix_y)
	self.zhupanel:setPositionY(self.zhupanel:getPositionY() + GameDisplay.fix_y)
end

function PopShowArenaInfo:initBg(arg_9_1)
	local var_9_0 = ccui.Layout:create()

	var_9_0:setTouchEnabled(true)
	var_9_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_9_0:setAnchorPoint(cc.p(0, 0))
	var_9_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_9_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_9_0:setOpacity(0)
	var_9_0:setCascadeOpacityEnabled(false)
	self:addChild(var_9_0, -1)

	local var_9_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_9_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_1:setPositionX(var_9_0:getContentSize().width / 2)
	var_9_1:setPositionY(var_9_0:getContentSize().height / 2)
	var_9_0:addChild(var_9_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_10_0)
		self:addChild(arg_10_0, -2)
		arg_10_0:setPositionY(arg_10_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_9_1)
		var_9_0:setOpacity(102)
		var_9_0:setTouchEnabled(false)
	end)
end

function PopShowArenaInfo:exit()
	if self.msg.cancelcallback then
		self.msg.cancelcallback()
	end

	self.hideActions.shrinkHorizon(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
