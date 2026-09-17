local level_manager = require("controller.level_manager")
local birthday_party_manager = require("controller.birthday_party_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local recharge_manager = require("controller.recharge_manager")
local playermodel = require("model.playermodel")
local activity_conf_data = require("data.activity_conf_data")
local linkentrance_data = require("data.linkentrance_data")
local activity_entrance_data = require("data.activity_entrance_data")
local var_0_10
local var_0_11 = config._DEBUG and 0 or 1
local var_0_15 = "mainScenebg/activity/common/dianji.png"
local var_0_16 = "mainScenebg/activity/common/new_activity_entrance.png"
local var_0_17 = "mainScenebg/activity/common/link_entrance.png"
local ActivityDoorNewSprite = class("ActivityDoorNewSprite", function()
	return cc.Node:create()
end)

function ActivityDoorNewSprite:create()
	local var_2_0 = ActivityDoorNewSprite.new()

	var_2_0:init()

	return var_2_0
end

function ActivityDoorNewSprite:init()
	var_0_10 = self
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)

	self.isNeedShow = false

	self:initUI()
	self:initActivityList()
	self:registerArrowTouchEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_10 = nil

			if self.scheduler then
				for iter_4_0, iter_4_1 in pairs(self.scheduler) do
					time_check_manager:removeUpdatePool(iter_4_1)

					self.scheduler[iter_4_0] = nil
				end
			end
		end
	end)
end

function ActivityDoorNewSprite:initUI()
	self._maxnumpercol = self:getMaxNumPerCol()
	self.imageBottom = ccui.Layout:create()

	self.imageBottom:setContentSize(cc.size(100, self._maxnumpercol * 100 + 100))
	self.imageBottom:setAnchorPoint(0.5, 1)
	self.imageBottom:setTouchEnabled(true)
	self.imageBottom:setPosition(cc.p(0, -30))
	self.imageBottom:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.imageBottom:setName("imageBottom")
	self.rootLayer:addChild(self.imageBottom)

	self.arrowBtn = ccui.Button:create("MainLayer/secondlist/arrow.png", nil, "MainLayer/secondlist/arrow.png", var_0_11)

	self.arrowBtn:setAnchorPoint(cc.p(0.5, 0))
	self.arrowBtn:setPosition(self.imageBottom:getPositionX(), self.imageBottom:getPositionY() - self.imageBottom:getContentSize().height + 35)
	self.arrowBtn:setName("arrowBtn")
	self.rootLayer:addChild(self.arrowBtn)
	self.arrowBtn:setVisible(false)

	self.arrowCanTouch = false
end

function ActivityDoorNewSprite:registerArrowTouchEvent()
	self.arrowBtn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.arrowCanTouch then
			return
		end

		self:switchListPanel()
	end)
end

function ActivityDoorNewSprite:getListConfig()
	local var_8_0 = activity_manager:getMainlayerList()
	local var_8_1 = {}

	local function var_8_2(arg_9_0)
		if arg_9_0 == 2230001 then
			return playermodel.rechargeamountTGV < 100
		end

		if arg_9_0 == 2860001 then
			return DeviceManager.getChannelID() == "270050"
		end

		if arg_9_0 == 3280001 then
			return DeviceManager:getChannelID() == "270048"
		end

		if arg_9_0 == 176 then
			return DeviceManager:getChannelID() == "270055"
		end

		return false
	end

	local function var_8_3(arg_10_0)
		if arg_10_0.linkage == 1 and DeviceManager:getChannelID() == "999" then
			return false
		end

		return true
	end

	local function var_8_4(arg_11_0)
		if arg_11_0.id == 7300001 or arg_11_0.id == 7310001 or arg_11_0.id == 7350001 or arg_11_0.door_img_path == "mainScenebg@activity@branch746@activity_entrance.png" then
			return level_manager:isPlayerPassLevel("3-10")
		end

		return true
	end

	for iter_8_0, iter_8_1 in pairs((self:getEntranceList())) do
		if not var_8_2(iter_8_1.id) and var_8_3(iter_8_1) and var_8_4(iter_8_1) then
			table.insert(var_8_1, {
				type = "entrance",
				info = iter_8_1,
				order = iter_8_1.order
			})
		end
	end

	local var_8_5 = {
		[2] = {
			weight = 10,
			func = function(self, arg_12_1)
				return (arg_12_1.activityid and os.time(parse_time(activity_conf_data[arg_12_1.activityid].starttime)) or os.time(parse_time(arg_12_1.info.door_starttime))) < (self.activityid and os.time(parse_time(activity_conf_data[self.activityid].starttime)) or os.time(parse_time(self.info.door_starttime)))
			end
		},
		{
			weight = 100,
			func = function(self, arg_13_1)
				return self.order < arg_13_1.order
			end
		}
	}

	table.sort(var_8_5, function(arg_14_0, arg_14_1)
		return arg_14_0.weight > arg_14_1.weight
	end)
	table.sort(var_8_1, function(arg_15_0, arg_15_1)
		for iter_15_0 = 1, #var_8_5 do
			if var_8_5[iter_15_0].func(arg_15_0, arg_15_1) ~= "==" then
				return var_8_5[iter_15_0].func(arg_15_0, arg_15_1)
			end
		end
	end)
	table.insert(var_8_1, 1, {
		type = "menu"
	})

	for iter_8_2, iter_8_3 in pairs(linkentrance_data) do
		local var_8_6 = time_check_manager:getCurTime()
		local var_8_7 = iter_8_3.show_time and os.time(parse_time(iter_8_3.show_time))
		local var_8_8 = activity_manager:getActivityObj(iter_8_3.id)
		local var_8_9

		if var_8_8 then
			::label_8_0::

			var_8_9 = var_8_8.finishtime and os.time(parse_time(var_8_8.finishtime))
		end

		if var_8_7 and var_8_9 and var_8_7 <= var_8_6 and var_8_6 <= var_8_9 and DeviceManager:getChannelID() ~= "999" then
			if #var_8_1 <= 3 then
				table.insert(var_8_1, {
					type = "entrance",
					info = activity_entrance_data[iter_8_3.id * 10000 + 1]
				})
			else
				table.insert(var_8_1, 4, {
					type = "entrance",
					info = activity_entrance_data[iter_8_3.id * 10000 + 1]
				})
			end
		end
	end

	return var_8_1
end

function ActivityDoorNewSprite:getEntranceList()
	local var_16_0 = global_deepCopy(activity_manager:getActivityEntranceList()) or {}

	;(function(...)
		local var_17_0
		local var_17_1
		local var_17_2
		local var_17_3 = {}

		for iter_17_0, iter_17_1 in pairs(var_16_0) do
			if iter_17_1.init_type == BRTH_ACTIVITY then
				if not var_17_0 then
					var_17_0 = iter_17_1.starttime
					var_17_1 = iter_17_1.id
					var_17_2 = iter_17_0
				end

				var_17_3[iter_17_1.jump] = true

				if var_17_0 < iter_17_1.starttime then
					if var_17_1 ~= iter_17_1.id then
						var_16_0[var_17_2] = nil
					end

					var_17_0 = iter_17_1.starttime
					var_17_1 = iter_17_1.id
					var_17_2 = iter_17_0
				elseif var_17_1 ~= iter_17_1.id then
					var_16_0[iter_17_0] = nil
				end
			end
		end

		if var_17_1 then
			local var_17_4 = {
				singleMarket = {
					"1-" .. var_16_0[var_17_1].jump % 1500000
				},
				showType = "1-" .. var_16_0[var_17_1].jump % 1500000
			}

			for iter_17_2, iter_17_3 in pairs(var_17_3) do
				if "1-" .. iter_17_2 % 1500000 ~= "1-" .. var_16_0[var_17_1].jump % 1500000 then
					table.insert(var_17_4.singleMarket, "1-" .. iter_17_2 % 1500000)
				end
			end

			var_16_0[var_17_1].param = var_17_4
		end
	end)()

	local var_16_1 = {}

	local function var_16_2(arg_18_0)
		local var_18_0 = time_check_manager:getCurTime()

		if arg_18_0.door_starttime and var_18_0 < os.time(parse_time(arg_18_0.door_starttime)) then
			return false
		end

		if arg_18_0.door_finishtime and var_18_0 > os.time(parse_time(arg_18_0.door_finishtime)) then
			return false
		end

		return true
	end

	self.unlockNum = 0

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if iter_16_1.isinactivitydoor and var_16_2(iter_16_1) then
			if iter_16_1.unlocklevel and not level_manager:isPlayerPassLevel(iter_16_1.unlocklevel) then
				self.unlockNum = self.unlockNum + 1
				iter_16_1.unlock = true
				iter_16_1.order = -iter_16_1.order

				table.insert(var_16_1, iter_16_1)
			else
				table.insert(var_16_1, iter_16_1)
			end
		end
	end

	local var_16_3 = {}
	local var_16_4 = {
		[8290001] = true,
		[8240001] = true,
		[8170001] = true,
		[8510001] = true,
		[7970001] = true,
		[7930001] = true,
		[8710001] = true,
		[8560001] = true,
		[8770001] = true,
		[7300001] = true,
		[8800001] = true,
		[8840001] = true,
		[8930001] = true,
		[8470001] = true,
		[8730001] = true,
		[7350001] = true,
		[8340001] = true,
		[8640001] = true,
		[8000001] = true,
		[7310001] = true,
		[8260001] = true,
		[8060001] = true,
		[8600001] = true
	}

	for iter_16_2, iter_16_3 in pairs(var_16_1) do
		if (not linkentrance_data[(iter_16_3.id - 1) / 10000] or (iter_16_3.id - 1) / 10000 == 286) and not var_16_4[iter_16_3.id] then
			table.insert(var_16_3, iter_16_3)
		end
	end

	table.sort(var_16_3, function(arg_19_0, arg_19_1)
		return arg_19_0.order < arg_19_1.order
	end)
	self:saveEntranceList(var_16_0)

	return var_16_3
end

function ActivityDoorNewSprite:getMaxNumPerCol()
	return math.floor((GameDisplay.top - 1136 + 542 - GameDisplay.notch_height - 74 - -85 - 100) / 100)
end

function ActivityDoorNewSprite:initActivityList()
	local var_21_0 = self:getListConfig()

	self.iconList = {}
	self.ownIconList = self.ownIconList or {}

	for iter_21_0, iter_21_1 in pairs(self.ownIconList) do
		if self.imageBottom:getChildByName(iter_21_0) then
			self.imageBottom:getChildByName(iter_21_0):setVisible(false)
		end
	end

	if #var_21_0 == 0 then
		self:setVisible(false)

		return
	else
		self:setVisible(true)
	end

	if #var_21_0 > self._maxnumpercol then
		self.arrowBtn:setVisible(true)

		self.arrowCanTouch = true
	else
		self.arrowBtn:setVisible(false)

		self.arrowCanTouch = true
	end

	if #var_21_0 > self._maxnumpercol then
		self.imageBottom.activity_num = self._maxnumpercol or #var_21_0
	end

	local var_21_1 = self.imageBottom:getContentSize().width / 2 - 10
	local var_21_2 = self.imageBottom:getContentSize().height - 50
	local var_21_3 = 100
	local var_21_4 = {}
	local var_21_5 = {}
	local var_21_6

	for iter_21_2 = 1, self.imageBottom.activity_num do
		if var_21_0[iter_21_2].info and var_21_0[iter_21_2].info.id == 176 then
			var_21_6 = iter_21_2
		end
	end

	if var_21_6 then
		var_21_4[1] = var_21_0[1]
		var_21_4[2] = var_21_0[var_21_6]

		for iter_21_3 = 3, #var_21_0 do
			var_21_4[iter_21_3] = iter_21_3 <= var_21_6 and var_21_0[iter_21_3 - 1] or var_21_0[iter_21_3]
		end
	end

	var_21_5 = var_21_6 and var_21_4 or var_21_0

	for iter_21_4 = 1, self.imageBottom.activity_num do
		local var_21_8
		local var_21_9 = var_21_5[iter_21_4]

		if var_21_5[iter_21_4].type == "recharge" then
			var_21_8 = self.imageBottom:getChildByName("btn_recharge")

			if not var_21_8 then
				var_21_8 = self:createRechagreIcon()

				var_21_8:setName("btn_recharge")
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "menu" then
			var_21_8 = self.imageBottom:getChildByName("btn_menu")

			if not var_21_8 then
				var_21_8 = self:createMenuIcon()

				var_21_8:setName("btn_menu")
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "entrance" then
			var_21_8 = self.imageBottom:getChildByName("btn_entrance" .. var_21_9.info.door_img_path)

			if not var_21_8 then
				var_21_8 = self:createEntranceIcon(var_21_9.info)

				var_21_8:setName("btn_entrance" .. var_21_9.info.door_img_path)
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "recharge_gift" then
			var_21_8 = self.imageBottom:getChildByName("btn_recharge_gift")

			if not var_21_8 then
				var_21_8 = self:createRechargeGiftIcon()

				var_21_8:setName("btn_recharge_gift")
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "activity_2_sign" then
			var_21_8 = self.imageBottom:getChildByName("btn_activity_2_sign")

			if not var_21_8 then
				var_21_8 = self:createActivity2SignIcon()

				var_21_8:setName("btn_activity_2_sign")
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "recharge_direct" then
			var_21_8 = self.imageBottom:getChildByName("btn_recharge_direct")

			if not var_21_8 then
				var_21_8 = self:createRechargeDirectIcon()

				var_21_8:setName("btn_recharge_direct")
				self.imageBottom:addChild(var_21_8)

				self.rechargeDirectIcon = var_21_8
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "activity" then
			var_21_8 = self.imageBottom:getChildByName("activity_" .. var_21_9.activityObj:getMainLayerImage())

			if not var_21_8 then
				var_21_8 = self:createActivityIcon(var_21_9.activityid, var_21_9.activityObj)

				var_21_8:setName("activity_" .. var_21_9.activityObj:getMainLayerImage())
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "link" then
			var_21_8 = self.imageBottom:getChildByName("btn_link")

			if not var_21_8 then
				var_21_8 = self:createLinkIcon()

				var_21_8:setName("btn_link")
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		elseif var_21_9.type == "newLink" then
			var_21_8 = self.imageBottom:getChildByName("btn_newLink")

			if not var_21_8 then
				var_21_8 = self:createNewLinkIcon()

				var_21_8:setName("btn_newLink")
				self.imageBottom:addChild(var_21_8)
			end

			var_21_8:setVisible(true)
		end

		if var_21_9.info and var_21_9.info.unlock then
			var_21_8:setOpacity(122)

			var_21_8.notNeedAlert = true
		end

		var_21_8:setPosition(cc.p(var_21_1, var_21_2 - 20))

		self.ownIconList[var_21_8:getName()] = true
		var_21_2 = var_21_2 - var_21_3

		if var_21_8 then
			self.iconList[iter_21_4] = var_21_8
		end
	end

	self.activityList = var_21_5

	self:redrawActivityAlert()

	if self.isNeedShow then
		self:switchListPanel()
	end
end

function ActivityDoorNewSprite:checkIsShowRecharge()
	return not playermodel.haverechargeaward
end

function ActivityDoorNewSprite:checkIsRechargeFirst()
	local var_23_0 = os.date("*t", playermodel.create_time)
	local var_23_1 = os.date("*t", time_check_manager:getCurTime())

	if playermodel.haverecharge then
		return true
	end

	if math.abs(var_23_0.year - var_23_1.year) > 1 or math.abs(var_23_0.month - var_23_1.month) > 1 then
		return false
	else
		return true
	end
end

function ActivityDoorNewSprite:createRechagreIcon()
	local var_24_0 = ccui.Button:create(var_0_15, nil, var_0_15)

	var_24_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_0:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_25_0:isBright() then
			return
		end

		self:createAwardPanel({
			paneltype = 1
		})
	end)

	if playermodel.haverecharge == true then
		local var_24_1 = ccui.ImageView:create("mainScenebg/activity/common/effect.png")

		var_24_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_24_1:setPosition(cc.p(var_24_0:getContentSize().width / 2, var_24_0:getContentSize().height / 2))
		var_24_0:addChild(var_24_1)
		var_24_1:setOpacity(40)
		var_24_1:setScale(0.5)
		var_24_1:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.Spawn:create(cc.EaseOut:create(cc.ScaleTo:create(1, 3, 3), 2), cc.Sequence:create(cc.FadeTo:create(1 / 3, 255), cc.FadeTo:create(1 * 2 / 3, 40))), cc.CallFunc:create(function()
			var_24_1:setOpacity(40)
			var_24_1:setScale(0.5)

			if playermodel.haverechargeaward == true then
				var_24_1:stopAllActions()
			end
		end), cc.DelayTime:create(1 / 2))))))
	end

	var_24_0.type = "recharge"

	return var_24_0
end

function ActivityDoorNewSprite:createActivityIcon(arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2:getMainLayerImage()
	local var_27_1 = ccui.Button:create(var_27_0[1], nil, var_27_0[2] or var_27_0[1])

	var_27_1:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_28_0:isBright() then
			return
		end

		local var_28_0 = arg_27_2:getJumpToConfig()

		var_28_0.activityID = arg_27_1

		ActivityManageLayer:create(var_28_0)

		local var_28_1 = {
			enterType = "ActivityDoor",
			activityid = arg_27_1
		}

		var_28_1.jumpid = var_28_0.jumpToLayer or var_28_0.systemid

		AnalyticManager.clickActivityEntranceType(var_28_1)
	end)

	var_27_1.type = "activity"
	var_27_1.activityid = arg_27_1

	return var_27_1
end

function ActivityDoorNewSprite:createMenuIcon()
	local var_29_0 = ccui.Button:create(var_0_16, nil, var_0_16)

	if time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2026-03-29 23:59:59") then
		var_29_0:loadTextures("mainScenebg/activity/common/new_activity_entrance_replace.png")
	end

	var_29_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_29_0:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_30_0:isBright() then
			return
		end

		print("enterActivity")
		AnalyticManager.clickActivityEntranceType({
			tab = 1
		})
		LayerManager:switchShowLayer("ActivityEntranceLayer")
	end)

	var_29_0.type = "menu"

	var_29_0:setScale(0.9, 0.9)

	local var_29_1 = ccui.ImageView:create("public/button/horcrux_lock.png", var_0_11)

	var_29_1:setPosition(cc.p(100, 100))
	var_29_1:setName("image")
	var_29_0:addChild(var_29_1)

	local var_29_2 = cc.Label:createWithTTF(string.format(L_AREAN_UNLOCK_TIPS, level_manager:formatSystemUnlockLevel(UNLOCK_ACTIVITY_ENTTRANCE)):gsub(L_CHECK_TASK_DATA.tasktypeStr[1], ""), FONT_BUTTON, 16)

	var_29_2:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_29_2:setAnchorPoint(0.5, 0.5)
	self.rootLayer:addChild(var_29_2)
	var_29_2:setPosition(var_29_0:getPositionX() - 8, var_29_0:getPositionY() - var_29_0:getContentSize().height + 10)

	if level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_ENTTRANCE) then
		var_29_0:setColor(cc.c3b(255, 255, 255))
		var_29_1:setVisible(false)
		var_29_2:setVisible(false)
	else
		var_29_0:setColor(cc.c3b(117, 117, 117))
		var_29_1:setVisible(true)
		var_29_2:setVisible(true)
	end

	return var_29_0
end

function ActivityDoorNewSprite:createLinkIcon(arg_31_1)
	local var_31_0 = ccui.Button:create(var_0_17, nil, var_0_17)

	var_31_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_0:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_32_0:isBright() then
			return
		end

		print("enterLinkLayer")
		LayerManager:switchShowLayer("LinkActivityEntranceLayer")
	end)

	local var_31_1 = ccui.Text:create("", FONT_BUTTON, 16)

	var_31_1:setName("timeLabel")
	var_31_1:setColor(cc.c3b(254, 242, 242))
	var_31_1:setPosition(cc.p(50, 8))
	var_31_0:addChild(var_31_1)
	var_31_1:setString(L_ALL_TIME)

	var_31_0.type = "link"

	return var_31_0
end

function ActivityDoorNewSprite:createNewLinkIcon(arg_33_1)
	local var_33_0 = ccui.Button:create(var_0_17, nil, var_0_17)

	var_33_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_33_0:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_34_0:isBright() then
			return
		end

		print("enterNewLinkLayer")
		LayerManager:switchShowLayer("NewLinkActivityEntranceLayer")
	end)

	local var_33_1 = ccui.Text:create("", FONT_BUTTON, 16)

	var_33_1:setName("timeLabel")
	var_33_1:setColor(cc.c3b(254, 242, 242))
	var_33_1:setPosition(cc.p(50, 8))
	var_33_0:addChild(var_33_1)
	var_33_1:setString(L_ALL_TIME)

	var_33_0.type = "newLink"

	return var_33_0
end

function ActivityDoorNewSprite:createEntranceIcon(arg_35_1)
	local var_35_0 = (function(arg_36_0)
		if not arg_36_0 then
			return
		end

		return string.gsub(arg_36_0, "@", "/")
	end)(arg_35_1.door_img_path) or var_0_16
	local var_35_1 = ccui.Button:create(var_35_0, nil, var_35_0)

	if var_35_0 == var_0_16 and time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2026-03-29 23:59:59") then
		var_35_1:loadTextures("mainScenebg/activity/common/new_activity_entrance_replace.png")
	end

	var_35_1:setAnchorPoint(cc.p(0.5, 0.5))

	if arg_35_1.init_type == BRTH_ACTIVITY then
		self.btnIcon = var_35_1

		birthday_party_manager:getTodayBirthdayEntracePath(function(arg_37_0)
			print("\n birthday entrance path is ============" .. arg_37_0 .. "\n")
			self.btnIcon:loadTextures(arg_37_0, nil, arg_37_0)

			if birthday_party_manager:isNeedShowRedDot() == true then
				global_add_alert_tag(self.btnIcon, cc.p(108, 108))
			else
				global_remove_alert_tag(self.btnIcon)
			end
		end)
	end

	var_35_1:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_35_1.unlock then
			global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(arg_35_1.unlocklevel)))

			return
		end

		require("controller.goto_system_manager")

		if arg_35_1.id == 1371008 and not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_LIULI) then
			global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_ACTIVITY_LIULI)))

			return
		end

		if arg_35_1.id == 7300001 then
			LayerManager:switchShowLayer("CommonFlopLayer", {
				activityId = 730
			})
			AnalyticManager.clickActivityEntranceType({
				jumpid = 2200730,
				enterType = "ActivityDoor",
				activityid = arg_35_1.configId
			})

			return
		end

		if arg_35_1.id == 7310001 then
			LayerManager:switchShowLayer("CommonRouletteLayer", {
				activityId = 731
			})
			AnalyticManager.clickActivityEntranceType({
				jumpid = 2700731,
				enterType = "ActivityDoor",
				activityid = arg_35_1.configId
			})

			return
		end

		if arg_35_1.init_type == BRTH_ACTIVITY then
			LayerManager:switchShowLayer("BirthdayPartyLayer")
			AnalyticManager.clickActivityEntranceType({
				jumpid = 1310,
				enterType = "ActivityDoor",
				activityid = arg_35_1.configId
			})
		elseif arg_35_1.init_type == WEB_ACTIVITY then
			self:showWebActivity(arg_35_1.id)
		else
			goto_complete_system({
				jump_to_system = arg_35_1.jump
			})
			AnalyticManager.clickActivityEntranceType({
				enterType = "ActivityDoor",
				activityid = arg_35_1.configId,
				jumpid = systemID
			})
		end
	end)

	var_35_1.type = "entrance"
	var_35_1.activityid = arg_35_1.configId
	var_35_1.alert_activity_systemid = arg_35_1.alert_activity_systemid
	arg_35_1.is_show_time = true

	if arg_35_1.is_show_time then
		self:createTimeLabel(var_35_1, arg_35_1)
	end

	if arg_35_1.id == 1371008 then
		local var_35_2 = ccui.ImageView:create("public/button/fight_lock.png", var_0_11)

		var_35_2:setName("lock_icon")
		var_35_2:setVisible(not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_LIULI))
		var_35_2:setPosition(cc.p(var_35_1:getContentSize().width - 10, var_35_1:getContentSize().height - 10))

		var_35_1.notNeedAlert = not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_LIULI)

		var_35_1:addChild(var_35_2, 1000)
		var_35_1:setColor(level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_LIULI) and cc.c3b(255, 255, 255) or cc.c3b(155, 155, 155))

		local var_35_3 = cc.Label:createWithTTF(string.format(L_AREAN_UNLOCK_TIPS, level_manager:formatSystemUnlockLevel(UNLOCK_ACTIVITY_LIULI)):gsub(L_CHECK_TASK_DATA.tasktypeStr[1], ""), FONT_BUTTON, 16)

		var_35_3:setAnchorPoint(0.5, 0.5)
		var_35_3:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		self.imageBottom:addChild(var_35_3, 10)
		var_35_3:setPosition(cc.p(var_35_1:getPositionX() + var_35_1:getContentSize().width / 2 - 5, var_35_1:getPositionY() + var_35_1:getContentSize().height * 2 + 30))
		var_35_3:setVisible(not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_LIULI))
	end

	if arg_35_1.unlock then
		var_35_1.notNeedAlert = true
	end

	return var_35_1
end

local var_0_19 = false

function ActivityDoorNewSprite:showWebActivity(arg_39_1)
	activity_manager:get_activity_memory_session(arg_39_1, function(arg_40_0)
		if var_0_19 then
			return
		end

		var_0_19 = true

		local var_40_0 = ccui.Layout:create()

		var_40_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_40_0:setTouchEnabled(true)
		var_40_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_40_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_40_0:setBackGroundColorOpacity(150)
		global_basic_scene:addChild(var_40_0, 999)

		local var_40_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

		var_40_1:setAnchorPoint(cc.p(0.5, 1))
		var_40_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
		var_40_0:addChild(var_40_1)
		var_40_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			local var_41_0 = ccexp.WebView:create()

			var_41_0:setVisible(true)
			var_41_0:setScalesPageToFit(true)
			var_41_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
			var_41_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
			var_41_0:loadURL(arg_40_0)
			var_41_0:setOnDidFinishLoading(function(arg_42_0, arg_42_1)
				return
			end)
			var_40_0:addChild(var_41_0, 10)

			local var_41_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

			var_41_1:setScale(0.5)
			var_41_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
			var_40_0:addChild(var_41_1, 100)
			var_41_1:addTouchEventListener(function(arg_43_0, arg_43_1)
				if arg_43_1 ~= ccui.TouchEventType.ended then
					return
				end

				var_0_19 = false

				var_40_0:runAction(cc.RemoveSelf:create())
			end)
		end)))
	end)
end

function ActivityDoorNewSprite:createRechargeGiftIcon()
	local var_44_0 = ccui.Button:create("mainScenebg/activity/branch2/recharge_gift.png", nil, "mainScenebg/activity/branch2/recharge_gift.png")

	var_44_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_44_0:addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SupermarketLayer", {
			initSelectPage = 3
		})
		AnalyticManager.clickActivityEntranceType({
			jumpid = 103,
			enterType = "ActivityDoor"
		})
	end)

	return var_44_0
end

function ActivityDoorNewSprite:createRechargeDirectIcon()
	local var_46_0 = ccui.Button:create("mainScenebg/activity/common/recharge_dierect.png", nil, "mainScenebg/activity/common/recharge_dierect.png")

	var_46_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_46_0:addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickActivityEntranceType({
			enterType = "PopRechargePreviewLayer"
		})
		LayerManager:switchShowLayer("SupermarketLayer", {
			group = 3
		})
	end)

	return var_46_0
end

function ActivityDoorNewSprite:createActivity2SignIcon(...)
	local var_48_0 = ccui.Button:create("mainScenebg/activity/branch2/sign.png", nil, "mainScenebg/activity/branch2/sign.png")

	var_48_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_0:addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("ActivitySignBaseLayer", {
			activityUIObjName = "ActivitySignFmlLayer",
			activityid = 2
		})
		AnalyticManager.clickActivityEntranceType({
			activityid = 2,
			jumpid = 104,
			enterType = "ActivityDoor"
		})
	end)

	return var_48_0
end

function ActivityDoorNewSprite:switchListPanel()
	if #self.activityList <= self._maxnumpercol then
		return
	end

	if not self.bottomAll or not self.bottomAll.isShow then
		self:showBottomAll()
	else
		self:hideBottomAll()
	end

	self:redrawActivityAlert()
end

function ActivityDoorNewSprite:updateActivityList()
	if self.imageBottom.list_type == 1 then
		for iter_51_0, iter_51_1 in pairs(self.iconList) do
			if iter_51_0 ~= 1 then
				iter_51_1:setVisible(true)
			end
		end

		self.clipSprite:setContentSize(cc.size(self.clipSprite:getContentSize().width, self.imageBottom.limitheight))
		self.imageBottom:setContentSize(cc.size(self.imageBottom:getContentSize().width, self.imageBottom.limitheight))
		self.arrowPanel:setContentSize(cc.size(self.arrowPanel:getContentSize().width, self.imageBottom.limitheight))
	elseif self.imageBottom.list_type == -1 then
		for iter_51_2, iter_51_3 in pairs(self.iconList) do
			if iter_51_2 ~= 1 then
				iter_51_3:setVisible(false)
			end
		end

		self.clipSprite:setContentSize(cc.size(self.clipSprite:getContentSize().width, self.imageBottom.minheight))
		self.imageBottom:setContentSize(cc.size(self.imageBottom:getContentSize().width, self.imageBottom.minheight))
		self.arrowPanel:setContentSize(cc.size(self.arrowPanel:getContentSize().width, self.imageBottom.minheight))
		self.scrollView:jumpToTop()
	end
end

function ActivityDoorNewSprite:resetActivityList()
	self:resetExtraActivity()
	self:initActivityList()
end

function ActivityDoorNewSprite:resetExtraActivity()
	if not self.bottomAll then
		return
	end

	self.bottomAll:removeAllChildren()

	self.bottomAll = nil

	if self.arrowBtn:getScaleX() == -1 then
		self.arrowBtn:setScaleX(1)
	end
end

function ActivityDoorNewSprite:redrawActivityAlert()
	local var_54_0 = false
	local var_54_1 = false

	local function var_54_2(arg_55_0, arg_55_1, arg_55_2)
		local var_55_0 = activity_manager:getActivityObj(arg_55_0.activityid)
		local var_55_1 = var_55_0:getMainLayerAlertPos()

		if var_55_0._status == ACTIVITY_ACTIVING or var_55_0._status == ACTIVITY_ENDED then
			if activity_manager:getAlertAllStatus(arg_55_0.activityid, arg_55_0.alert_activity_systemid) and arg_55_0.activityid ~= 2 then
				global_add_alert_tag(arg_55_0, var_55_1 or {
					x = arg_55_0:getContentSize().width - 35,
					y = arg_55_0:getContentSize().height - 30
				})

				if arg_55_2 then
					var_54_1 = true
				end
			elseif arg_55_0.activityid == 2 then
				if not activity_manager:is_module_stat_finished(2, "wake_fund") or not activity_manager:is_module_stat_finished(406, "wake_fund") or not activity_manager:is_module_stat_finished(486, "wake_fund") or not activity_manager:is_module_stat_finished(710, "wake_fund") then
					global_add_alert_tag(arg_55_0, var_55_1 or {
						x = arg_55_0:getContentSize().width - 35,
						y = arg_55_0:getContentSize().height - 30
					})
				else
					global_remove_alert_tag(arg_55_0)
				end
			else
				global_remove_alert_tag(arg_55_0)
			end
		end
	end

	local function var_54_3(arg_56_0, arg_56_1)
		local var_56_0 = activity_manager:getActivityObj(arg_56_0.activityid)
		local var_56_1 = var_56_0:getMainLayerAlertPos()

		if activity_manager:checkMainNewActivity(arg_56_0.activityid) then
			alert_manager:add_alert_by_config(arg_56_0, true, {
				ALERT_SHOW_NEW,
				"",
				var_56_0:getMainLayerNewAlertPos() or {
					x = arg_56_0:getContentSize().width - 20,
					y = arg_56_0:getContentSize().height - 10
				}
			})

			if arg_56_1 then
				var_54_0 = true
			end
		end
	end

	local function var_54_4(arg_57_0, arg_57_1)
		if not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_ENTTRANCE) then
			return false
		end

		local var_57_0 = activity_manager:getActivityEntranceListAlertStatus()

		if var_57_0 and next(var_57_0) then
			local var_57_1 = {
				x = arg_57_0:getContentSize().width,
				y = arg_57_0:getContentSize().height
			}
			local var_57_2 = global_add_alert_tag(arg_57_0, (k == 1 or nil) and cc.p({
				x = arg_57_0:getContentSize().width - 40,
				y = arg_57_0:getContentSize().height / 2 + 30
			}))

			if var_57_2 then
				var_57_2:setScale(1.12)
			end

			return
		else
			global_remove_alert_tag(arg_57_0)
		end
	end

	local function var_54_5(arg_58_0, arg_58_1)
		for iter_58_0, iter_58_1 in pairs(linkentrance_data) do
			local var_58_0 = iter_58_1.starttime and os.time(parse_time(iter_58_1.starttime))
			local var_58_1

			if iter_58_1.day then
				var_58_1 = var_58_0 + iter_58_1.day * 24 * 60 * 60
			end

			local var_58_2 = time_check_manager:getCurTime()

			if var_58_0 and var_58_1 and var_58_0 < var_58_2 and var_58_2 < var_58_1 then
				alert_manager:add_new_mark(arg_58_0, true, {
					x = 80,
					y = 90
				})
				activity_manager:checkRedNode(arg_58_0)

				return
			else
				alert_manager:add_new_mark(arg_58_0, false)
				var_54_4(arg_58_0, iter_58_0)

				if activity_manager:checkRedNode(arg_58_0) then
					activity_manager:checkRedNode(arg_58_0):setVisible(true)
				end
			end
		end
	end

	for iter_54_0, iter_54_1 in pairs(self.iconList) do
		if not iter_54_1.notNeedAlert then
			if iter_54_1.type == "activity" or iter_54_1.type == "entrance" and iter_54_1.activityid then
				var_54_2(iter_54_1, iter_54_0)
				var_54_3(iter_54_1)
			elseif iter_54_1.type == "menu" then
				var_54_4(iter_54_1, iter_54_0)
			elseif iter_54_1.type == "newLink" then
				var_54_5(iter_54_1, iter_54_0)
			end
		end
	end

	if self.iconExtraList then
		for iter_54_2, iter_54_3 in pairs(self.iconExtraList) do
			if not iter_54_3.notNeedAlert then
				if iter_54_3.type == "activity" or iter_54_3.type == "entrance" and iter_54_3.activityid then
					var_54_2(iter_54_3, iter_54_2, true)
					var_54_3(iter_54_3, true)
				elseif iter_54_3.type == "menu" then
					var_54_4(iter_54_3, iter_54_2)
				end
			end
		end
	end

	self:updateArrowAlert(false)
	self:updateArrowReddot(false)
	self:updateRechargeProviewReddot()
end

function ActivityDoorNewSprite:updateArrowAlert(arg_59_1)
	if arg_59_1 ~= nil then
		self.arrowBtn.flag = arg_59_1
	end

	local var_59_0 = self.arrowBtn:getPositionX()

	alert_manager:add_alert_by_config(self.rootLayer, self.arrowBtn.flag or false, {
		ALERT_SHOW_NEW,
		"",
		{
			x = var_59_0 + self.arrowBtn:getContentSize().width / 2,
			y = self.arrowBtn:getPositionY() + self.arrowBtn:getContentSize().height
		}
	})

	if self.arrowBtn:getScaleX() == -1 and self.rootLayer:getChildByName("alert_new") then
		self.rootLayer:getChildByName("alert_new"):setVisible(false)
	end
end

function ActivityDoorNewSprite:updateArrowReddot(arg_60_1)
	if arg_60_1 ~= nil then
		self.arrowBtn.reddot_flag = arg_60_1
	end

	local var_60_0 = self.arrowBtn:getPositionX()

	alert_manager:add_alert_by_config(self.rootLayer, self.arrowBtn.reddot_flag or false, {
		ALERT_SHOW_REDDOT,
		"",
		{
			x = var_60_0 + self.arrowBtn:getContentSize().width / 2,
			y = self.arrowBtn:getPositionY() + self.arrowBtn:getContentSize().height
		}
	})

	if self.arrowBtn:getScaleX() == -1 and self.rootLayer:getChildByName("alert_reddot") then
		self.rootLayer:getChildByName("alert_reddot"):setVisible(false)
	end
end

function ActivityDoorNewSprite:updateRechargeProviewReddot()
	if not recharge_manager:getShopLimitAlertData() then
		-- block empty
	else
		self:drawProviewReddot()
	end
end

function ActivityDoorNewSprite:drawProviewReddot()
	if not self.rechargeDirectIcon then
		print("充值表那边有问题，icon没出来")

		return
	end

	local var_62_0 = recharge_manager:getShopLimitAlertData()
	local var_62_1

	if var_62_0[1] and next(var_62_0[1]) then
		var_62_1 = 1
	end

	if var_62_0[2] and next(var_62_0[2]) then
		var_62_1 = 2
	end

	if var_62_0[3] and next(var_62_0[3]) then
		var_62_1 = 3
	end

	local var_62_2 = {
		cc.p(self.rechargeDirectIcon:getContentSize().width + 5, self.rechargeDirectIcon:getContentSize().height + 20),
		[3] = cc.p(self.rechargeDirectIcon:getContentSize().width, 60)
	}

	if self.rechargeDirectIcon:getChildByName("reddot") then
		self.rechargeDirectIcon:removeChildByName("reddot")
	end

	if var_62_1 then
		global_add_alert_tag(self.rechargeDirectIcon, var_62_2[var_62_1], 5, var_62_1)
	end
end

function ActivityDoorNewSprite:createAwardPanel(arg_63_1)
	function arg_63_1.callback()
		if var_0_10 then
			SwitchManageLayer:switchAniUIElemen(SwitchManageLayer.activeLayerName, true)

			if not var_0_10:checkIsShowRecharge() then
				var_0_10:resetActivityList()
			end
		end
	end

	LayerManager:pushInLayer("PopNoviceAwardLayer", arg_63_1)
end

function ActivityDoorNewSprite:showBottomAll()
	if #self.activityList <= self._maxnumpercol then
		return
	end

	self.arrowCanTouch = false
	self.iconExtraList = {}

	local var_65_0 = self.imageBottom:getContentSize().width

	if not self.bottomAll then
		self.bottomAll = ccui.Layout:create()

		self.bottomAll:setContentSize(cc.size(var_65_0 * math.ceil((#self.activityList - self._maxnumpercol) / self._maxnumpercol), self.imageBottom:getContentSize().height))
		self.bottomAll:setAnchorPoint(1, 1)
		self.bottomAll:setPosition(cc.p(self.imageBottom:getPositionX() - self.imageBottom:getContentSize().width / 2, self.imageBottom:getPositionY()))
		self.bottomAll:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self.rootLayer:addChild(self.bottomAll)
		self.bottomAll:setClippingEnabled(true)

		local var_65_1 = ccui.Layout:create()

		var_65_1:setContentSize(cc.size(self.bottomAll:getContentSize().width, self.bottomAll:getContentSize().height))
		var_65_1:setAnchorPoint(0.5, 0.5)
		var_65_1:setPosition(cc.p(self.bottomAll:getContentSize().width / 2, self.bottomAll:getContentSize().height / 2))
		var_65_1:setName("iconBg")
		self.bottomAll:addChild(var_65_1)

		local var_65_2 = var_65_1:getContentSize().width - var_65_0 / 2
		local var_65_3 = var_65_1:getContentSize().height - 50
		local var_65_4 = var_65_0
		local var_65_5 = 100

		for iter_65_0 = self.imageBottom.activity_num + 1, #self.activityList do
			local var_65_6
			local var_65_7 = self.activityList[iter_65_0]

			if self.activityList[iter_65_0].type == "recharge" then
				var_65_6 = self:createRechagreIcon()
			elseif var_65_7.type == "menu" then
				var_65_6 = self:createMenuIcon()
			elseif var_65_7.type == "entrance" then
				var_65_6 = self:createEntranceIcon(var_65_7.info)
			elseif var_65_7.type == "recharge_gift" then
				var_65_6 = self:createRechargeGiftIcon()
			elseif var_65_7.type == "activity_2_sign" then
				var_65_6 = self:createActivity2SignIcon()
			elseif var_65_7.type == "recharge_direct" then
				var_65_6 = self:createrechargeDirectIcon()
			elseif var_65_7.type == "activity" then
				var_65_6 = self:createActivityIcon(var_65_7.activityid, var_65_7.activityObj)
			elseif var_65_7.type == "link" then
				var_65_6 = self:createLinkIcon()
			elseif var_65_7.type == "newLink" then
				var_65_6 = self:createNewLinkIcon()
			end

			var_65_6:setPosition(cc.p(var_65_2, var_65_3 - 20))

			var_65_3 = var_65_3 - var_65_5

			if var_65_7.info and var_65_7.info.unlock then
				var_65_6:setOpacity(122)

				var_65_6.notNeedAlert = true
			end

			if iter_65_0 % self._maxnumpercol == 0 then
				var_65_2 = var_65_2 - var_65_4
				var_65_3 = var_65_1:getContentSize().height - 50
			end

			var_65_1:addChild(var_65_6)
			table.insert(self.iconExtraList, var_65_6)
		end
	end

	local var_65_8 = self.bottomAll:getChildByName("iconBg")

	var_65_8:setPosition(cc.p(self.bottomAll:getContentSize().width + var_65_8:getContentSize().width / 2, self.bottomAll:getContentSize().height / 2))
	var_65_8:runAction(cc.Sequence:create(cc.EaseBackOut:create((cc.MoveBy:create(0.4, cc.p(-var_65_8:getContentSize().width, 0)))), cc.CallFunc:create(function()
		self.arrowCanTouch = true
		self.bottomAll.isShow = true

		self.arrowBtn:setScaleX(-self.arrowBtn:getScaleX())
	end)))
end

function ActivityDoorNewSprite:hideBottomAll()
	if not self.bottomAll.isShow then
		return
	end

	self.arrowCanTouch = false

	local var_67_0 = self.bottomAll:getChildByName("iconBg")

	var_67_0:runAction(cc.Sequence:create(cc.EaseBackOut:create((cc.MoveBy:create(0.4, cc.p(var_67_0:getContentSize().width, 0)))), cc.CallFunc:create(function()
		self.arrowCanTouch = true
		self.bottomAll.isShow = false

		self.arrowBtn:setScaleX(-self.arrowBtn:getScaleX())
	end)))
end

local function var_0_20(arg_69_0)
	if not arg_69_0 then
		return ""
	end

	if arg_69_0 > 86400 then
		return string.format(L_TIME_SINGLE.Day, math.floor(arg_69_0 / 3600 / 24))
	elseif arg_69_0 >= 3600 then
		return string.format(L_TIME_SINGLE.Hour, math.floor(arg_69_0 / 3600))
	elseif arg_69_0 >= 60 then
		return string.format(L_TIME_SINGLE.Minute, math.floor(arg_69_0 % 3600 / 60))
	else
		return string.format(L_TIME_SINGLE.Minute, 1)
	end
end

function ActivityDoorNewSprite:createTimeLabel(arg_70_1, arg_70_2)
	local var_70_0 = ccui.Text:create("", FONT_BUTTON, 16)

	var_70_0:setName("timeLabel")
	var_70_0:setColor(cc.c3b(254, 242, 242))
	var_70_0:setPosition(cc.p(50, 8))

	var_70_0.id = arg_70_2.id

	arg_70_1:addChild(var_70_0)

	local var_70_1 = arg_70_2.finishtime

	if arg_70_2.id == 7300001 then
		for iter_70_0, iter_70_1 in ipairs((require("data.common_flop_roulette_turns_conf"))) do
			if global_is_in_time(iter_70_1.starttime, iter_70_1.finishtime) and iter_70_1.moudle == "commonFlop" then
				print(iter_70_1.finishtime)

				var_70_1 = iter_70_1.finishtime
			end
		end
	end

	if arg_70_2.id == 7310001 then
		for iter_70_2, iter_70_3 in ipairs((require("data.common_flop_roulette_turns_conf"))) do
			if global_is_in_time(iter_70_3.starttime, iter_70_3.finishtime) and iter_70_3.moudle == "commonRoulette" then
				print(iter_70_3.finishtime)

				var_70_1 = iter_70_3.finishtime
			end
		end
	end

	if arg_70_2.id == 7350001 then
		for iter_70_4, iter_70_5 in ipairs((require("data.common_flop_roulette_turns_conf"))) do
			if global_is_in_time(iter_70_5.starttime, iter_70_5.finishtime) and iter_70_5.moudle == "airplane" then
				var_70_1 = iter_70_5.finishtime
			end
		end
	end

	if not var_70_1 then
		var_70_0:setString(L_ALL_TIME)

		return
	end

	if arg_70_2.configId == 4 then
		if playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) then
			local var_70_2 = os.date("*t", os.time(parse_time("2020-9-19 00:00:00")) + 1209600)

			var_70_1 = string.format("%d-%d-%d %d:%d:%d", var_70_2.year, var_70_2.month, var_70_2.day, var_70_2.hour, var_70_2.min, var_70_2.sec)
		else
			local var_70_3 = os.date("*t", playermodel.create_time + 1209600)

			var_70_1 = string.format("%d-%d-%d %d:%d:%d", var_70_3.year, var_70_3.month, var_70_3.day, var_70_3.hour, var_70_3.min, var_70_3.sec)
		end
	end

	local function var_70_4(arg_71_0)
		if var_70_0 and var_70_0.id then
			var_70_0:setString((var_0_20(arg_71_0)))

			if arg_71_0 <= 0 and var_70_0 and self.scheduler and self.scheduler[var_70_0.id] then
				time_check_manager:removeUpdatePool(self.scheduler[var_70_0.id])

				self.scheduler[var_70_0.id] = nil
			end
		end
	end

	local var_70_5 = global_get_time_by_date(var_70_1) - time_check_manager:getCurTime()

	if not var_70_5 then
		return
	end

	var_70_4(var_70_5)

	if var_70_5 < 86400 then
		var_70_0:setColor(cc.c3b(248, 99, 99))
	end

	self.scheduler = self.scheduler or {}
	self.scheduler[var_70_0.id] = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_70_5, var_70_4)))
end

function ActivityDoorNewSprite:saveEntranceList(arg_74_1)
	return
end

function ActivityDoorNewSprite:checkIsNeedShow(arg_75_1, arg_75_2)
	for iter_75_0, iter_75_1 in pairs(arg_75_1) do
		if not arg_75_2[iter_75_0] then
			self.isNeedShow = true

			break
		end
	end
end

return ActivityDoorNewSprite
