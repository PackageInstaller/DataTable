NewLinkActivityEntranceLayer = class("NewLinkActivityEntranceLayer", function()
	return ccui.Layout:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local linkentrance_data = require("data.linkentrance_data")
local activity_entrance_data = require("data.activity_entrance_data")
local event_notice_data = require("data.event_notice_data")
local network = require("network.network")

require("view.Sprite.MovingView")

local var_0_7 = config._DEBUG and 0 or 1

function NewLinkActivityEntranceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = NewLinkActivityEntranceLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function NewLinkActivityEntranceLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LinkActivityEntrance.json" or "LinkActivityEntrance.ExportJson")

	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	self.copyUnit = ccui.Helper:seekWidgetByName(self.rootLayer, "copy_unit")

	self.copyUnit:removeFromParent()
	self.copyUnit:retain()
	self:getActivityInfo(1)
	self:initPreviewList()
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			self.copyUnit:release()
			activity_manager:releaseEventListenerByName("NewLinkActivityEntranceLayer")
		end
	end)
end

function NewLinkActivityEntranceLayer:initUI()
	self:drawEntranceList()
end

function NewLinkActivityEntranceLayer:initTitle()
	local var_6_0 = ccui.Button:create("LinkActivityEntrance/btn_link_off.png", nil, "LinkActivityEntrance/btn_link_on.png", var_0_7)

	var_6_0:setPosition(35, 1020 + GameDisplay.fix_y * 2)
	self.rootLayer:addChild(var_6_0, 999)
	var_6_0:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickActivityEntranceType({
			tab = 1,
			enterType = "LeftList"
		})
		self.tableView:setVisible(true)
		self.previewTableView:setVisible(false)
		arg_7_0:setBright(false)
		self.previewBtn:setBright(true)
	end)
	var_6_0:setBright(false)

	self.linkBtn = var_6_0

	if self.haveRed then
		global_add_alert_tag(self.linkBtn, {
			x = 70,
			y = 190
		})
	else
		global_remove_alert_tag(self.linkBtn)
	end

	local var_6_1 = ccui.Button:create("LinkActivityEntrance/btn_preview_off.png", nil, "LinkActivityEntrance/btn_preview_on.png", var_0_7)

	var_6_1:setPosition(35, 830 + GameDisplay.fix_y * 2)
	var_6_1:setTouchEnabled(true)
	var_6_1:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickActivityEntranceType({
			tab = 2,
			enterType = "LeftList"
		})
		self.tableView:setVisible(false)
		self.previewTableView:setVisible(true)
		arg_8_0:setBright(false)
		self.linkBtn:setBright(true)
	end)
	self.rootLayer:addChild(var_6_1, 999)

	self.previewBtn = var_6_1
end

function NewLinkActivityEntranceLayer:initBottom()
	local var_9_0 = ccui.Button:create("public/button/bottom_return_btn_archives.png", nil, "public/button/bottom_return_btn_archives.png", var_0_7)

	var_9_0:setPosition(cc.p(50, 40))
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.rootLayer:addChild(var_9_0, 9999999)
end

function NewLinkActivityEntranceLayer:initPreviewList()
	local var_11_0 = event_notice_data
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(event_notice_data) do
		var_11_1[#var_11_1 + 1] = {
			size = {
				width = 510,
				height = 210
			}
		}
	end

	local var_11_2 = {}

	var_11_2.width = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):getContentSize().width
	var_11_2.height = 940 + GameDisplay.fix_y * 2 + 20
	var_11_2.direction = cc.SCROLLVIEW_DIRECTION_VERTICAL
	var_11_2.cellConfs = var_11_1

	function var_11_2:registerCellFunc()
		if not self:getChildByTag(100) then
			local var_12_0 = ccui.ImageView:create("mainScenebg/activity_entrance/" .. var_11_0[self.index].image .. ".png", nil, "mainScenebg/activity_entrance/" .. var_11_0[self.index].image .. ".png", var_0_7)

			var_12_0:setTag(100)
			var_12_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_12_0:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
			var_12_0:setScale(0.9, 0.9)
			self:addChild(var_12_0)
		end
	end

	if not self.cellConfs then
		return
	end

	local var_11_3 = MovingView:create(var_11_2)

	var_11_3:updateCells()
	var_11_3:setPosition(75, 0)
	var_11_3:setVisible(false)

	self.previewTableView = var_11_3

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(var_11_3)
end

function NewLinkActivityEntranceLayer:drawEntranceList()
	if self.tableView then
		self.tableView:removeFromParent()
	end

	local function var_13_0(arg_14_0)
		local var_14_0 = self.entranceActivityList[arg_14_0.index - 1 + 1]
		local var_14_1 = arg_14_0:getChildByTag(100)

		if not var_14_1 then
			var_14_1 = self:createEntrance(self.entranceActivityList[arg_14_0.index - 1 + 1])
			var_14_1.status = self.entranceActivityList[arg_14_0.index - 1 + 1].status
			var_14_1.id = self.entranceActivityList[arg_14_0.index - 1 + 1].activityid

			var_14_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_14_1:setPosition(cc.p(arg_14_0:getContentSize().width / 2, arg_14_0:getContentSize().height / 2))
			self:drawEntranceAlert(var_14_1, arg_14_0.index - 1)
			arg_14_0:addChild(var_14_1)
			var_14_1:setScale(0.95, 0.95)
		end

		local function var_14_2(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_15_0:getTouchBeganPosition().y - arg_15_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_15_0.status == 1 or arg_15_0.status == 2 then
				require("controller.goto_system_manager")
				goto_complete_system({
					jump_to_system = var_14_0.jump
				})
				AnalyticManager.clickActivityEntranceType({
					enterType = "NewLinkActivityEntranceLayer",
					activityid = var_14_0.configId,
					jumpid = var_14_0.jump,
					id = var_14_0.id
				})
			else
				global_ShowBlockWords(L_LINKLAYER[8])
			end
		end

		var_14_1:setSwallowTouches(false)
		var_14_1:addTouchEventListener(var_14_2)
	end

	local var_13_1 = {}

	var_13_1.width = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):getContentSize().width
	var_13_1.height = 940 + GameDisplay.fix_y * 2 + 40
	var_13_1.direction = cc.SCROLLVIEW_DIRECTION_VERTICAL
	var_13_1.cellConfs = self.cellConfs
	var_13_1.registerCellFunc = var_13_0

	if not self.cellConfs then
		return
	end

	self.tableView = MovingView:create(var_13_1)

	self.tableView:updateCells()
	self.tableView:setPosition(75, 0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(self.tableView)
end

function NewLinkActivityEntranceLayer:createEntrance(arg_16_1)
	local var_16_0 = self.copyUnit:clone()

	if arg_16_1.isbigBanner then
		var_16_0:setContentSize(cc.size(600, 350))
	else
		var_16_0:setContentSize(cc.size(600, 230))
	end

	var_16_0:loadTextures("mainScenebg/activity_entrance/" .. arg_16_1.image .. ".png", nil, "mainScenebg/activity_entrance/" .. arg_16_1.image .. ".png")
	var_16_0:setTag(100)
	var_16_0:setName(tostring(arg_16_1.image))

	local var_16_1 = var_16_0:getChildByName("panel_time_bg")

	var_16_1:setAnchorPoint(cc.p(1, 1))
	var_16_1:setPosition(var_16_0:getContentSize().width, 40)

	local var_16_2 = var_16_0:getChildByName("panel_time_bg"):getChildByName("left_label")
	local var_16_3

	if arg_16_1.status == 1 then
		var_16_3 = arg_16_1.finishtime and os.time(parse_time(arg_16_1.finishtime))
	end

	if var_16_3 and var_16_3 > time_check_manager:getCurTime() and var_16_3 - time_check_manager:getCurTime() < 31536000 then
		local var_16_4 = var_16_3 - time_check_manager:getCurTime()

		var_16_2:setString((Global_format_time_str(var_16_4)))
		var_16_2:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_16_4 = var_16_4 - 1

			if var_16_4 >= 0 then
				var_16_2:setString((Global_format_time_str(var_16_4)))
			else
				var_16_2:stopAction(seqre)
				self:drawEntranceList()
			end
		end))))))

		if var_16_4 < 86400 then
			var_16_1:setBackGroundImage("PopActivityEntrance/time_bg.png", var_0_7)
			var_16_2:setColor(cc.c3b(255, 255, 255))
		else
			var_16_1:setBackGroundImage("PopActivityEntrance/time_gary_bg.png", var_0_7)
			var_16_2:setColor(cc.c3b(255, 229, 158))
		end
	else
		var_16_1:setVisible(false)
	end

	local var_16_5 = ccui.ImageView:create("public/button/fight_lock.png", var_0_7)

	var_16_5:setName("lock_icon")
	var_16_5:setVisible(false)
	var_16_5:setPosition(cc.p(var_16_0:getContentSize().width - 28, var_16_0:getContentSize().height - 30))
	var_16_0:addChild(var_16_5, 1000)

	local var_16_6 = arg_16_1.starttime and os.time(parse_time(arg_16_1.starttime))

	if var_16_6 and arg_16_1.status == 0 then
		var_16_2:setString((Global_format_time_str(var_16_6 - time_check_manager:getCurTime())))
		var_16_1:setVisible(true)
		var_16_1:setBackGroundImage("PopActivityEntrance/opensoon.png", var_0_7)
		var_16_0:setOpacity(120)
		var_16_0:getChildByName("lock_icon"):setVisible(true)
	end

	return var_16_0
end

function NewLinkActivityEntranceLayer:drawEntranceAlert(arg_18_1, arg_18_2)
	local var_18_0

	if arg_18_1.status == 0 then
		do return end

		var_18_0 = {
			x = arg_18_1:getContentSize().width - 10,
			y = arg_18_1:getContentSize().height - 10
		}
	end

	if activity_manager:getAlertAllStatus(self.entranceActivityList[arg_18_2 + 1].activityid) then
		global_add_alert_tag(arg_18_1, var_18_0)

		self.haveRed = true
	else
		global_remove_alert_tag(arg_18_1)
	end

	if activity_manager:isNewActivity(self.entranceActivityList[arg_18_2 + 1].image) then
		alert_manager:add_new_mark(arg_18_1, true, {
			x = arg_18_1:getContentSize().width - 40,
			y = arg_18_1:getContentSize().height - 10
		})
		activity_manager:checkRedNode(arg_18_1)
	else
		alert_manager:add_new_mark(arg_18_1, false)

		if activity_manager:checkRedNode(arg_18_1) then
			activity_manager:checkRedNode(arg_18_1):setVisible(true)
		end
	end

	local var_18_1 = ({
		["1000003"] = {
			ALERT_SIGN
		},
		["1000005"] = {
			ALERT_TWISTEGG,
			ALERT_ACTIVTIYNEWLOG_TWISTEGG
		},
		["1000008"] = {
			ALERT_MIDAS
		}
	})[arg_18_1:getName()]

	if var_18_1 then
		for iter_18_0, iter_18_1 in pairs(var_18_1) do
			if alert_manager.alertsys[iter_18_1] then
				alert_manager:add_redDot(arg_18_1, true, var_18_0)
			end
		end
	end
end

function NewLinkActivityEntranceLayer:getActivityInfo(arg_19_1)
	arg_19_1 = arg_19_1 or 1

	local var_19_0 = time_check_manager:getCurTime()
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(linkentrance_data) do
		local var_19_3 = activity_entrance_data[iter_19_1.id * 10000 + 1]

		var_19_3.order = iter_19_1.order
		var_19_3.activityid = iter_19_1.id

		if not iter_19_1.starttime then
			var_19_3.status = 2

			table.insert(var_19_1, var_19_3)
		else
			local var_19_4 = activity_manager:getActivityObj(iter_19_1.id)

			if var_19_4 then
				local var_19_5 = iter_19_1.starttime and os.time(parse_time(iter_19_1.starttime))
				local var_19_6

				if var_19_4 then
					::label_19_0::

					var_19_6 = var_19_4.finishtime and os.time(parse_time(var_19_4.finishtime))
				end

				if var_19_5 and var_19_0 < var_19_5 then
					var_19_3.status = 0
				elseif var_19_6 and var_19_0 < var_19_6 then
					var_19_3.status = 1
					var_19_3.finishtime = var_19_4.finishtime
				elseif var_19_5 and var_19_5 < var_19_0 then
					if var_19_3.door_finishtime then
						var_19_3.finishtime = var_19_3.door_finishtime or nil
					end

					var_19_3.status = 1
				else
					var_19_3.status = 0
				end

				var_19_3.starttime = iter_19_1.starttime

				if var_19_3.finishtime and var_19_0 < os.time(parse_time(var_19_3.finishtime)) then
					table.insert(var_19_1, var_19_3)
				elseif var_19_0 < var_19_5 then
					table.insert(var_19_1, var_19_3)
				end
			end
		end
	end

	self:insertList(var_19_1)
end

function NewLinkActivityEntranceLayer:insertList(arg_20_1)
	if not arg_20_1 then
		return
	end

	self.entranceActivityList = {}

	local function var_20_1(arg_21_0)
		if arg_21_0 == 286 then
			return DeviceManager.getChannelID() == "270048"
		end

		return false
	end

	local var_20_2 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		if not var_20_1(iter_20_1.activityid) then
			table.insert(var_20_2, iter_20_1)
		end
	end

	table.sort(var_20_2, function(arg_22_0, arg_22_1)
		if arg_22_0.status ~= arg_22_1.status then
			return arg_22_0.status > arg_22_1.status
		elseif arg_22_0.status == arg_22_1.status then
			return arg_22_0.order < arg_22_1.order
		end
	end)

	self.entranceActivityList = var_20_2
	self.cellConfs = {}

	for iter_20_2, iter_20_3 in pairs(self.entranceActivityList) do
		self.cellConfs[#self.cellConfs + 1] = {
			size = {
				width = 520,
				height = iter_20_3.isbigBanner and 320 or 220
			}
		}
	end
end

return NewLinkActivityEntranceLayer
