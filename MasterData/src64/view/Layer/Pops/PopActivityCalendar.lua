PopActivityCalendar = class("PopActivityCalendar", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_calendar_data = require("data.activity_calendar_data")
local time_check_manager = require("controller.time_check_manager")
local hexie_manager = require("controller.hexie_manager")

function PopActivityCalendar.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityCalendar.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActivityCalendar:init(arg_3_1)
	print("open poplayer : PopActivityCalendar")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopActivityCalendar.json" or "PopActivityCalendar.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}

	self:initData()
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and arg_3_1.callback then
			arg_3_1.callback()
		end
	end)
end

local function var_0_4(arg_5_0)
	return RoleDefault:getInstance():getBoolForKey("new_act_" .. arg_5_0, true)
end

local function var_0_6(arg_6_0)
	if hexie_manager:needHexieCalendar(arg_6_0.id) then
		return false
	end

	if arg_6_0.unlocklevel then
		if not require("controller.level_manager"):isPlayerPassLevel(arg_6_0.unlocklevel) then
			return false
		end
	end

	return true
end

function PopActivityCalendar:initData()
	local var_7_0 = os.date("*t", (time_check_manager:getCurTime()))
	local var_7_1 = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_7_0.year,
		month = var_7_0.month,
		day = var_7_0.day
	})
	local var_7_2 = var_7_1 + 604800

	self.dataList = {}

	for iter_7_0, iter_7_1 in pairs(activity_calendar_data) do
		local var_7_3 = global_get_time_by_date(iter_7_1.starttime)
		local var_7_4 = global_get_time_by_date(iter_7_1.finishtime)

		if var_7_2 >= var_7_3 and var_7_4 >= var_7_1 and var_0_6(iter_7_1) then
			local var_7_5 = {}
			local var_7_6 = {}
			local var_7_7 = 0

			for iter_7_2 = 1, 7 do
				if var_7_3 < var_7_1 + iter_7_2 * 86400 and var_7_4 >= var_7_1 + iter_7_2 * 86400 - 1 then
					var_7_6[iter_7_2] = iter_7_2 == 1 and (isdifferentday(var_7_3, var_7_1) and 2 or 1) or iter_7_2 == 7 and (isdifferentday(var_7_4, var_7_2) and 2 or 1) or 1
					var_7_7 = var_7_7 + 1
				end
			end

			var_7_5.id = iter_7_1.id
			var_7_5.len = var_7_7
			var_7_5.timelist = var_7_6
			var_7_5.style = iter_7_1.style
			var_7_5.name = iter_7_1.name
			var_7_5.jumpto = iter_7_1.jumpto
			var_7_5.order = iter_7_1.order
			var_7_5.new = var_0_4(iter_7_1.id)
			var_7_5.starttime = iter_7_1.starttime
			var_7_5.first = var_7_1 < var_7_3 and 1 + math.floor((var_7_3 - var_7_1) / 86400) or 1

			table.insert(self.dataList, var_7_5)
		end
	end

	table.sort(self.dataList, function(arg_8_0, arg_8_1)
		return arg_8_0.order < arg_8_1.order
	end)
end

function PopActivityCalendar:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:initActivities()
	self:playJoinInEffect()
end

function PopActivityCalendar:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self:exit()
	end)

	self.bg = self.rootLayer:getChildByName("bg")

	self.bg:setTouchEnabled(true)
	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y)
end

function PopActivityCalendar:initTitle()
	local var_12_0 = time_check_manager:getCurTime()

	for iter_12_0 = 1, 7 do
		local var_12_1 = os.date("*t", var_12_0)

		var_12_0 = var_12_0 + 86400

		local var_12_3 = self.bg:getChildByName("day_" .. iter_12_0)
		local var_12_4 = self.bg:getChildByName("date_" .. iter_12_0)

		var_12_3:setString((iter_12_0 == 1 or nil) and L_TODAY)
		var_12_4:setString(var_12_1.month .. "." .. var_12_1.day)
		var_12_3:setColor(cc.c3b(172, 150, 255))
		var_12_4:setColor(cc.c3b(172, 150, 255))
	end
end

function PopActivityCalendar:initActivities()
	local var_13_0 = #self.dataList * 120

	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setBounceEnabled(true)
	self.scrollView:setInnerContainerSize(cc.size(560, var_13_0))
	self.scrollView:setDirection(ccui.ScrollViewDir.vertical)
	self.scrollView:setContentSize(cc.size(600, 680))
	self.scrollView:setAnchorPoint(cc.p(0.5, 0))
	self.scrollView:setPosition(300, 10)
	self.bg:addChild(self.scrollView)

	for iter_13_0 = 1, #self.dataList do
		local var_13_1 = ccui.ImageView:create(string.format("PopActivityCalendar/act_line_%d.png", self.dataList[iter_13_0].style), var_0_0)

		var_13_1:setScale9Enabled(true)
		var_13_1:setCapInsets(cc.rect(41, 25, 1, 1))
		var_13_1:setContentSize(cc.size(82 * self.dataList[iter_13_0].len + 2, 52))
		var_13_1:setAnchorPoint(cc.p(0, 0.5))
		var_13_1:setPositionX(-72 + self.dataList[iter_13_0].first * 82)
		var_13_1:setPositionY(var_13_0 - iter_13_0 * 70 + 35)
		self.scrollView:addChild(var_13_1, 10)

		local var_13_2 = 0

		for iter_13_1 = 1, 7 do
			if self.dataList[iter_13_0].timelist[iter_13_1] then
				var_13_2 = var_13_2 + 1

				local var_13_3 = ccui.ImageView:create(string.format("PopActivityCalendar/act_bg_%d.png", self.dataList[iter_13_0].style), var_0_0)

				var_13_3:setPositionY(var_13_0 - iter_13_0 * 70 + 35)
				var_13_3:setPositionX(-31 + iter_13_1 * 82)
				self.scrollView:addChild(var_13_3, 9)

				if self.dataList[iter_13_0].timelist[iter_13_1] == 2 then
					local var_13_4 = ccui.ImageView:create(string.format("PopActivityCalendar/act_%d.png", self.dataList[iter_13_0].style), var_0_0)

					self.scrollView:addChild(var_13_4, 11)

					local var_13_5 = iter_13_1 == 1 and -1 or 1

					var_13_4:setScaleX(iter_13_1 == 1 and -1 or 1)
					var_13_4:setPositionY(var_13_0 - iter_13_0 * 70 + 35)
					var_13_4:setPositionX(-31 + iter_13_1 * 82 + var_13_5 * 7)
				end
			end
		end

		local var_13_6 = var_13_2 <= 2 and cc.Label:createWithTTF(self.dataList[iter_13_0].name, FONT_NAME, 16) or cc.Label:createWithTTF(self.dataList[iter_13_0].name, FONT_NAME, 24)

		var_13_6:setPosition(cc.p(var_13_1:getContentSize().width / 2, 27))
		var_13_1:addChild(var_13_6, 20)

		if self.dataList[iter_13_0].new then
			local var_13_7 = ccui.ImageView:create("public/reddot/new.png", var_0_0)

			var_13_7:setPosition(cc.p(var_13_1:getContentSize().width - 15, 60))
			var_13_1:addChild(var_13_7)
		end

		var_13_1:setTouchEnabled(true)
		var_13_1:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			RoleDefault:getInstance():setBoolForKey("new_act_" .. self.dataList[iter_13_0].id, false)

			if global_get_time_by_date(self.dataList[iter_13_0].starttime) > time_check_manager:getCurTime() then
				global_ShowBlockWords(L_ACTIVITY_NOT_OPEN)

				return
			end

			goto_complete_system({
				jump_to_system = self.dataList[iter_13_0].jumpto
			})
		end)
	end
end

function PopActivityCalendar:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopActivityCalendar:exit()
	for iter_16_0, iter_16_1 in pairs(self.dataList) do
		RoleDefault:getInstance():setBoolForKey("new_act_" .. iter_16_1.id, false)
	end

	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopActivityCalendar:initBg(arg_18_1)
	local var_18_0 = ccui.Layout:create()

	var_18_0:setTouchEnabled(true)
	var_18_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_18_0:setAnchorPoint(cc.p(0, 0))
	var_18_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_18_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_18_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_18_0:setOpacity(0)
	self:addChild(var_18_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_19_0)
		self:addChild(arg_19_0, -2)
		arg_19_0:setPositionY(arg_19_0:getPositionY() - GameDisplay.fix_y)

		local var_19_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_19_0:setAnchorPoint(cc.p(0, 0))
		var_19_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_19_0, -1)
		self:init(arg_18_1)
		var_18_0:setOpacity(102)
		var_18_0:setTouchEnabled(false)
	end)
end
