CommunityTaskShowLayer = class("CommunityTaskShowLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local chapter_data = require("data.chapter_data")
local activity_manager = require("controller.activity_manager")
local family_pt_data = require("data.family_pt_data")
local time_check_manager = require("controller.time_check_manager")
local playermodel = require("model.playermodel")
local var_0_11
local drop_data = require("data.drop_data")
local task_manager = require("controller.task_manager")
local var_0_14 = {
	[1] = "community_system/communityMainLayer/commity_task_bule.png",
	[2] = "community_system/communityMainLayer/commity_task_yellow.png"
}
local var_0_15 = {
	have = "community_system/communityMainLayer/commity_task_commplete.png",
	get = "community_system/communityMainLayer/commity_task_get.png",
	no = "community_system/communityMainLayer/commity_task_no_commplete.png"
}
local var_0_16 = config._DEBUG and 0 or 1
local var_0_17 = {
	{
		off = "community_system/communityMainLayer/commity_task_activity_off.png",
		on = "community_system/communityMainLayer/commity_task_activity_on.png"
	},
	{
		off = "community_system/communityMainLayer/commity_task_task_off.png",
		on = "community_system/communityMainLayer/commity_task_task_on.png"
	}
}
local var_0_18 = {
	nonhave = {
		u = cc.c3b(144, 171, 226),
		d = cc.c3b(93, 151, 195)
	},
	have = {
		u = cc.c3b(230, 167, 57),
		d = cc.c3b(201, 124, 73)
	},
	get = {
		u = cc.c3b(255, 248, 168),
		d = cc.c3b(166, 133, 93)
	}
}
local var_0_19 = "community_system/communityMainLayer/commity_task_time_bg.png"

function CommunityTaskShowLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = CommunityTaskShowLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function CommunityTaskShowLayer:init(arg_3_1)
	var_0_11 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "CommunityTaskShowLayer.json" or "CommunityTaskShowLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.toppenel = ccui.Helper:seekWidgetByName(self.rootLayer, "toplayer")
	self.middlelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "middlelayer")
	self.iteamtop = ccui.Helper:seekWidgetByName(self.rootLayer, "iteamtop")
	self.listitem = ccui.Helper:seekWidgetByName(self.rootLayer, "listitem")
	self.moreitem = ccui.Helper:seekWidgetByName(self.rootLayer, "moreitem")
	self.toplist = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_50")
	self.downlist = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_60")
	self.ptlable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_57")
	self.ptlableqin = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_57_0")
	self.btn_info = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_24")
	self.activity_btn = ccui.Helper:seekWidgetByName(self.middlelayer, "Button_59")
	self.task_btn = ccui.Helper:seekWidgetByName(self.middlelayer, "btn_task")
	self.downlist2 = ccui.Helper:seekWidgetByName(self.rootLayer, "listview_task")
	self.items2 = ccui.Helper:seekWidgetByName(self.rootLayer, "taskitem")
	self.fucbtns = {
		self.activity_btn,
		self.task_btn
	}
	self.backimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_57")

	self.btn_info:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_4_0:setBright(false)

		local var_4_0 = {
			callback = function()
				if communitymainlayerinstace then
					arg_4_0:setBright(true)
				end
			end
		}

		var_4_0.key = "community_rule_task"

		if not require("data.detail_data")[var_4_0.key] then
			print("error:----------------> detail_data.lua is no data for this layer  找策划填写规则表:----->按键值为：" .. var_4_0.key)
		else
			LayerManager:pushInLayer("PopActivityDetail", var_4_0)
		end
	end)

	self.awardsdata = {}

	for iter_3_0, iter_3_1 in ipairs(family_pt_data) do
		table.insert(self.awardsdata, iter_3_1)
	end

	table.sort(self.awardsdata, function(arg_6_0, arg_6_1)
		return arg_6_0.pt_num < arg_6_1.pt_num
	end)

	self.seletbtnindex = 1

	self:initBottomList()
	self:fullScreen(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	self:registerTimeCheckEvent()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_11 = nil

			activity_manager:releaseEventListenerByName("CommunityTaskShowLayer")
		end
	end)
end

function CommunityTaskShowLayer.registerActivityEventListener(arg_8_0)
	activity_manager:registerEventListener("CommunityTaskShowLayer", activity_manager.activityEventId.COMMUNITY_KICK_NOTICE, function(arg_9_0)
		if arg_9_0.familyid and arg_9_0.familyid == community_system_manager:getCurfamilyid() then
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCOMMUNITYMAINLAYER.tips7)
			LayerManager:switchShowLayer("joinCommunityLayer")
		end
	end)
	activity_manager:registerEventListener("CommunityTaskShowLayer", activity_manager.activityEventId.COMMUNITY_WISH_NEW_AWARD, function(arg_10_0)
		if arg_10_0.tp and var_0_11 and arg_8_0.seletbtnindex == 1 then
			arg_8_0:updateWishPanelRedStatus()
		end
	end)
end

function CommunityTaskShowLayer:UpdateTaskBtnRed()
	if community_system_manager:haveCommpeletAwardTask() then
		global_add_alert_tag(self.task_btn, {
			x = 250,
			y = 70
		})
	else
		global_remove_alert_tag(self.task_btn)
	end
end

function CommunityTaskShowLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self:addChild(self.bottomList, 100)
end

function CommunityTaskShowLayer:initUI()
	self.gethaveaward = community_system_manager:getAwardStatus()
	self.donationtime = community_system_manager:getDonationDaliyStatus() or {
		0,
		0,
		0
	}

	self:initTopLayer()
	self:initDownLayer()
end

function CommunityTaskShowLayer:initDownLayer()
	for iter_15_0, iter_15_1 in ipairs(self.fucbtns) do
		iter_15_1.id = iter_15_0

		iter_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.seletbtnindex = arg_16_0.id

			self:updateTaskBtnStatus()
		end)
	end

	self:updateTaskBtnStatus()

	local function var_15_0()
		self:UpdateTaskBtnRed()
	end

	task_manager:get_task_info(function()
		community_system_manager:get_family_task_info(var_15_0)
	end)
end

function CommunityTaskShowLayer:updateTaskBtnStatus()
	self:UpdateTaskBtnRed()

	for iter_19_0, iter_19_1 in pairs(self.fucbtns) do
		if iter_19_1.id == self.seletbtnindex then
			iter_19_1:loadTextures(var_0_17[iter_19_1.id].on, var_0_17[iter_19_1.id].on, var_0_17[iter_19_1.id].on, var_0_16)
			self:updateSelectLayer()
		else
			iter_19_1:loadTextures(var_0_17[iter_19_1.id].off, var_0_17[iter_19_1.id].off, var_0_17[iter_19_1.id].off, var_0_16)
		end
	end
end

function CommunityTaskShowLayer:updateSelectLayer()
	local function var_20_0(arg_21_0)
		self.downlist:removeAllChildren()
		self.downlist2:removeAllChildren()
		self.downlist:setVisible(arg_21_0)
		self.downlist2:setVisible(not arg_21_0)
	end

	if self.seletbtnindex == 1 then
		var_20_0(true)
		community_system_manager:get_family_wish_num(function()
			if self.updateDownActivityLayer then
				self:updateDownActivityLayer()
			end
		end)
	elseif self.seletbtnindex == 2 then
		var_20_0(false)

		local function var_20_1(arg_23_0)
			self.tasklistdata = community_system_manager:getTaskData()

			if self.updateDownActivityTaskLayer then
				self:updateDownActivityTaskLayer()
			end

			if self.UpdateTaskBtnRed then
				self:UpdateTaskBtnRed()
			end
		end

		task_manager:get_task_info(function()
			community_system_manager:get_family_task_info(var_20_1)
		end)
	end
end

function CommunityTaskShowLayer:updateDownActivityTaskLayer()
	self.downlist2:setClippingEnabled(true)
	self.downlist2:removeAllChildren()
	self.downlist2:setItemsMargin(10)

	for iter_25_0, iter_25_1 in ipairs(self.tasklistdata) do
		local var_25_0 = self.items2:clone()

		var_25_0.index = iter_25_0
		var_25_0.taskid = iter_25_1.taskid
		var_25_0.task_type = iter_25_1.task_type
		var_25_0.id = iter_25_1.id

		var_25_0:setName("ownlist2_" .. iter_25_0)
		self:updateTaskItemNode(var_25_0, community_system_manager:dequeueTaskInfo(iter_25_1.task_type, iter_25_1.taskid))
		self.downlist2:pushBackCustomItem(var_25_0)
	end
end

function CommunityTaskShowLayer:updateTaskItemNode(arg_26_1, arg_26_2)
	if not arg_26_1 or not arg_26_2 then
		return
	end

	local var_26_0 = arg_26_1:getChildByName("Image_22")
	local var_26_1 = arg_26_1:getChildByName("ProgressBar_29")
	local var_26_2 = arg_26_1:getChildByName("name")
	local var_26_3 = arg_26_1:getChildByName("btn_get")
	local var_26_4 = arg_26_1:getChildByName("btn_goto")
	local var_26_5 = arg_26_1:getChildByName("commplete")
	local var_26_6 = arg_26_1:getChildByName("num")
	local var_26_7 = arg_26_1:getChildByName("dec")
	local var_26_8 = arg_26_1:getChildByName("Image_16")
	local var_26_9 = self:getDropData(arg_26_2.drop).items[1]

	var_26_8:loadTexture("equipment/" .. item_data[var_26_9.itemid].image_id .. ".png")
	var_26_8:setScale(90 / var_26_8:getContentSize().height)
	var_26_2:getVirtualRenderer():setMaxLineWidth(260)
	var_26_7:getVirtualRenderer():setMaxLineWidth(260)
	arg_26_1:getChildByName("Panel_23"):getChildByName("Label_24"):setString("x" .. var_26_9.num)
	var_26_2:setString(arg_26_2.name)
	var_26_7:setString(arg_26_2.des)
	var_26_6:setString("")

	if arg_26_2.percent and arg_26_2.percent >= 0 then
		if arg_26_2.percent < 100 then
			var_26_4:setVisible(true)
			var_26_3:setVisible(false)
			var_26_5:setVisible(false)
			var_26_1:setPercent(percent)
			var_26_6:setString(arg_26_2.percent .. "%")
		else
			var_26_4:setVisible(false)
			var_26_3:setVisible(true)
			var_26_5:setVisible(false)
			var_26_1:setPercent(100)
			var_26_6:setString("100%")
		end
	else
		var_26_4:setVisible(false)
		var_26_3:setVisible(false)
		var_26_5:setVisible(true)
		var_26_1:setPercent(100)
		var_26_6:setString("100%")
	end

	var_26_3:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		community_system_manager:get_family_task_award(arg_26_1.taskid, function(arg_28_0, arg_28_1)
			if arg_28_0 == 1 then
				for iter_28_0, iter_28_1 in ipairs(arg_28_1.items) do
					if iter_28_1.itemtype and iter_28_1.itemtype == 120 and iter_28_1.itemid then
						iter_28_1.entityid = iter_28_1.itemid

						if iter_28_1.itemcount and iter_28_1.itemcount > 0 then
							community_system_manager:updaPlayerPtValue(iter_28_1.itemcount)
							self:initTopLayer()
						end
					end
				end

				if arg_28_1.gold and arg_28_1.gold > 0 or arg_28_1.diamond and arg_28_1.diamond > 0 or arg_28_1.items then
					global_gain({
						sp = arg_28_1.gold,
						gold = arg_28_1.diamond,
						items = arg_28_1.items
					})
				end

				self:UpdateTaskBtnRed()
				self:updateTaskItemNode(arg_26_1, community_system_manager:dequeueTaskInfo(arg_26_1.task_type, arg_26_1.taskid))
			end
		end)
	end)
	var_26_4:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:taskTumpTo(arg_26_2.jump)
	end)
end

function CommunityTaskShowLayer:updateDownActivityLayer()
	self.downlist:setClippingEnabled(true)
	self.downlist:removeAllChildren()
	self.downlist:setItemsMargin(10)

	local var_30_0 = self.moreitem:clone()

	self.downbtns = {
		self.listitem:clone(),
		(self.listitem:clone())
	}

	for iter_30_0, iter_30_1 in ipairs(self.downbtns) do
		iter_30_1.id = iter_30_0

		if iter_30_0 == 1 then
			iter_30_1:getChildByName("Button_75"):addTouchEventListener(function(arg_31_0, arg_31_1)
				local var_31_0

				if arg_31_1 ~= ccui.TouchEventType.ended then
					do return end

					var_31_0 = {}
				end

				function var_31_0.callback(arg_32_0)
					self.donationtime = community_system_manager:getDonationDaliyStatus()

					self:initTopLayer()
					self:updateDonationTime(iter_30_1:getChildByName("Label_74"))

					local function var_32_0()
						self:UpdateTaskBtnRed()
					end

					task_manager:get_task_info(function()
						community_system_manager:get_family_task_info(var_32_0)
					end)
				end

				LayerManager:pushInLayer("PopCommunityDonationLayer", var_31_0)
			end)
			self:updateDonationTime(iter_30_1:getChildByName("Label_74"))
		elseif iter_30_0 == 2 then
			iter_30_1:getChildByName("Button_75"):loadTextures("community_system/communityMainLayer/commity_task_wish.png", nil, "community_system/communityMainLayer/commity_task_wish.png", var_0_16)
			iter_30_1:getChildByName("Label_74"):setString("")
			iter_30_1:getChildByName("Button_75"):addTouchEventListener(function(arg_35_0, arg_35_1)
				local var_35_0

				if arg_35_1 ~= ccui.TouchEventType.ended then
					do return end

					var_35_0 = {}
				end

				function var_35_0.callback()
					self:updateWishTimeLabel()
				end

				LayerManager:switchShowLayer("CommunityWishMianLayer", var_35_0)
			end)
			self:updateWishTimeLabel()
			self:updateWishPanelRedStatus()
		else
			iter_30_1:getChildByName("Button_75"):setTouchEnabled(false)
		end

		self.downlist:pushBackCustomItem(iter_30_1)
	end
end

function CommunityTaskShowLayer:updateTaskLabel()
	if self.downbtns[1] then
		self:updateDonationTime(self.downbtns[1]:getChildByName("Label_74"))
	end
end

function CommunityTaskShowLayer:updateWishTimeLabel()
	if self.downbtns and self.downbtns[2] then
		if self.downbtns[2]:getChildByName("ac_at") then
			self.downbtns[2]:getChildByName("ac_at"):removeFromParent()
		end

		if self.downbtns[2]:getChildByName("rc_at") then
			self.downbtns[2]:getChildByName("rc_at"):removeFromParent()
		end

		if self.downbtns[2]:getChildByName("rc_bg") then
			self.downbtns[2]:getChildByName("rc_bg"):removeFromParent()
		end

		if self.downbtns[2]:getChildByName("ac_bg") then
			self.downbtns[2]:getChildByName("ac_bg"):removeFromParent()
		end

		local var_38_0 = community_system_manager:getMaxWishTimes(1, 1)
		local var_38_1 = var_38_0 - community_system_manager:getWishTimes(1, 1)

		if var_38_1 < 0 then
			var_38_1 = 0
		end

		if community_system_manager:checkIsHaveActivityWish() then
			local var_38_2 = community_system_manager:getMaxWishTimes(2, 1)
			local var_38_3 = var_38_2 - community_system_manager:getWishTimes(2, 1)

			if var_38_3 < 0 then
				var_38_3 = 0
			end

			local var_38_4 = "<p></p>"
			local var_38_5 = RichTextPro:create()

			var_38_5:setSize(22)
			var_38_5:setLineSpace(0)
			var_38_5:setText(var_38_4, nil, true)
			var_38_5:setName("ac_at")
			self.downbtns[2]:addChild(var_38_5, 10)

			local var_38_6 = RichTextPro:create()

			var_38_6:setSize(22)
			var_38_6:setLineSpace(0)
			var_38_6:setText(var_38_4, nil, true)
			var_38_6:setName("rc_at")
			self.downbtns[2]:addChild(var_38_6, 10)

			local var_38_7 = ccui.ImageView:create(var_0_19, var_0_16)

			var_38_7:setName("ac_bg")
			var_38_7:setPosition(cc.p(self.downbtns[2]:getContentSize().width - var_38_7:getContentSize().width / 2 - 20, 45))
			self.downbtns[2]:addChild(var_38_7, 5)

			local var_38_8 = ccui.ImageView:create(var_0_19, var_0_16)

			var_38_8:setName("rc_bg")
			var_38_8:setPosition(cc.p(self.downbtns[2]:getContentSize().width - var_38_8:getContentSize().width / 2 - 20, 14))
			self.downbtns[2]:addChild(var_38_8, 5)
			self.downbtns[2]:getChildByName("ac_at"):setText(string.format("<p><span style=color: rgb(255,255,255);>%s</span><span style=color: rgb(255,210,0);>%d</span><span style=color: rgb(255,255,255);>/%d</span></p>", COMMUNITY_WISH_SYSTEM.tips1, var_38_3, var_38_2))
			self.downbtns[2]:getChildByName("rc_at"):setText(string.format("<p><span style=color: rgb(255,255,255);>%s</span><span style=color: rgb(255,210,0);>%d</span><span style=color: rgb(255,255,255);>/%d</span></p>", COMMUNITY_WISH_SYSTEM.tips2, var_38_1, var_38_0))
			self.downbtns[2]:getChildByName("ac_at"):setPosition(cc.p(430, 55))
			self.downbtns[2]:getChildByName("rc_at"):setPosition(cc.p(430, 26))
		else
			local var_38_9 = ccui.ImageView:create(var_0_19, var_0_16)

			var_38_9:setName("rc_bg")
			var_38_9:setPosition(cc.p(self.downbtns[2]:getContentSize().width - var_38_9:getContentSize().width / 2 - 20, 14))
			self.downbtns[2]:addChild(var_38_9, 5)

			local var_38_10 = RichTextPro:create()

			var_38_10:setSize(22)
			var_38_10:setLineSpace(0)
			var_38_10:setText("<p></p>", nil, true)
			var_38_10:setName("rc_at")
			self.downbtns[2]:addChild(var_38_10, 10)
			self.downbtns[2]:getChildByName("rc_at"):setText(string.format("<p><span style=color: rgb(255,255,255);>%s</span><span style=color: rgb(255,210,0);>%d</span><span style=color: rgb(255,255,255);>/%d</span></p>", COMMUNITY_WISH_SYSTEM.tips2, var_38_1, var_38_0))
			self.downbtns[2]:getChildByName("rc_at"):setPosition(cc.p(430, 26))
		end
	end
end

function CommunityTaskShowLayer:updateWishPanelRedStatus()
	if self.downbtns and self.downbtns[2] then
		if community_system_manager:getRecordRedStatus() then
			if self.downbtns[2]:getChildByName("red") then
				self.downbtns[2]:getChildByName("red"):setVisible(true)
			end
		elseif self.downbtns[2]:getChildByName("red") then
			self.downbtns[2]:getChildByName("red"):setVisible(false)
		end
	end
end

function CommunityTaskShowLayer:updateDonationTime(arg_40_1)
	if not arg_40_1 then
		return
	end

	local var_40_0 = 0
	local var_40_1 = 0

	for iter_40_0 = 1, 3 do
		var_40_0 = community_system_manager:getDonationMaxNum(iter_40_0) + var_40_0
	end

	self.donationtime = community_system_manager:getDonationDaliyStatus() or {
		0,
		0,
		0
	}

	for iter_40_1, iter_40_2 in ipairs(self.donationtime) do
		var_40_1 = var_40_1 + iter_40_2
	end

	arg_40_1:setString("")

	if self.downbtns[1]:getChildByName("jz_at") then
		self.downbtns[1]:getChildByName("jz_at"):removeFromParent()
	end

	if self.downbtns[1]:getChildByName("rc_bg") then
		self.downbtns[1]:getChildByName("rc_bg"):removeFromParent()
	end

	local var_40_2 = ccui.ImageView:create(var_0_19, var_0_16)

	var_40_2:setName("rc_bg")
	var_40_2:setPosition(cc.p(self.downbtns[1]:getContentSize().width - var_40_2:getContentSize().width / 2 - 20, 14))
	self.downbtns[1]:addChild(var_40_2, 5)

	local var_40_3 = RichTextPro:create()

	var_40_3:setSize(22)
	var_40_3:setLineSpace(0)
	var_40_3:setText(string.format("<p><span style=color: rgb(255,255,255);>%s</span><span style=color: rgb(255,210,0);>%d</span><span style=color: rgb(255,255,255);>/%d</span></p>", COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips4, var_40_0 - var_40_1, var_40_0), nil, true)
	var_40_3:setName("jz_at")
	var_40_3:setPosition(cc.p(466, 26))
	self.downbtns[1]:addChild(var_40_3, 10)
end

function CommunityTaskShowLayer:initTopLayer()
	self.totalscore = community_system_manager:getPlayerPtValue()

	self.ptlable:setString("" .. self.totalscore)
	self.ptlableqin:setString("" .. self.totalscore)
	self:initAwardPanel()
end

function CommunityTaskShowLayer:initAwardPanel()
	self.toplist:setClippingEnabled(true)
	self.toplist:removeAllChildren()
	self.toplist:setItemsMargin(0)

	self.awards = {}

	if not self.awardsdata or not next(self.awardsdata) then
		return
	end

	for iter_42_0, iter_42_1 in ipairs(self.awardsdata) do
		local var_42_0 = self.iteamtop:clone()

		var_42_0.id = iter_42_0

		self:updateAwardNode(var_42_0, iter_42_0, iter_42_1)
		self.toplist:pushBackCustomItem(var_42_0)
		table.insert(self.awards, var_42_0)

		var_42_0.step = iter_42_0
	end

	self:updateBtnStatus()

	local var_42_1 = self:getCurScoreIndex()

	if var_42_1 <= 3 then
		-- block empty
	else
		local var_42_2 = (var_42_1 - 1) * (100 / (#self.awardsdata - self.toplist:getContentSize().width / 99))

		if var_42_2 < 0 then
			var_42_2 = 0
		elseif var_42_2 > 100 then
			var_42_2 = 100
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self.toplist:scrollToPercentHorizontal(var_42_2, 0.5, false)
		end)))
	end
end

function CommunityTaskShowLayer.updateBtnStatus(arg_44_0)
	return
end

function CommunityTaskShowLayer:getCurScoreIndex()
	if not self.awardsdata or not next(self.awardsdata) then
		return 1
	end

	local var_45_0

	for iter_45_0, iter_45_1 in ipairs(self.awardsdata) do
		if self.totalscore <= iter_45_1.pt_num then
			var_45_0 = iter_45_0

			break
		else
			var_45_0 = #self.awardsdata
		end
	end

	return var_45_0
end

function CommunityTaskShowLayer:updateAwardNode(arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = ccui.Helper:seekWidgetByName(arg_46_1, "ProgressBar_84")
	local var_46_1 = ccui.Helper:seekWidgetByName(arg_46_1, "row")
	local var_46_2 = ccui.Helper:seekWidgetByName(arg_46_1, "Label_85_0")
	local var_46_3 = ccui.Helper:seekWidgetByName(arg_46_1, "mask")
	local var_46_4 = ccui.Helper:seekWidgetByName(arg_46_1, "Label_85")
	local var_46_5 = ccui.Helper:seekWidgetByName(arg_46_1, "Image_52")
	local var_46_6 = ccui.Helper:seekWidgetByName(arg_46_1, "Image_26")

	var_46_1:setVisible(false)
	var_46_3:setLocalZOrder(66)
	var_46_6:setVisible(false)

	local var_46_7 = 0
	local var_46_8 = self:getCurScoreIndex()

	if arg_46_2 < var_46_8 then
		var_46_7 = 100
	elseif arg_46_2 == var_46_8 then
		if arg_46_3.pt_num ~= 0 then
			var_46_7 = 100 * (self.totalscore / arg_46_3.pt_num)

			if 100 * (self.totalscore / arg_46_3.pt_num) > 100 then
				var_46_7 = 100
			end
		else
			var_46_7 = 100
		end
	elseif var_46_8 < arg_46_2 then
		var_46_7 = 0
	end

	var_46_0:setPercent(var_46_7)

	if var_46_7 == 100 then
		var_46_1:loadTexture(var_0_14[2], var_0_16)
		var_46_5:loadTextures(var_0_15.have, var_0_15.have, var_0_15.have, var_0_16)
		var_46_2:setColor(var_0_18.have.u)
		var_46_4:setColor(var_0_18.have.d)
		var_46_2:setString("" .. arg_46_3.pt_num)
		var_46_6:setVisible(true)

		if self:isAwardHaveGet(arg_46_2) then
			var_46_2:setString("" .. arg_46_3.pt_num)
			var_46_5:loadTextures(var_0_15.get, var_0_15.get, var_0_15.get, var_0_16)
			var_46_3:setVisible(true)
			var_46_2:setColor(var_0_18.get.u)
			var_46_4:setColor(var_0_18.get.d)
			var_46_6:setVisible(false)
		else
			var_46_3:setVisible(false)
		end
	else
		var_46_1:loadTexture(var_0_14[1], var_0_16)
		var_46_5:loadTextures(var_0_15.no, var_0_15.no, var_0_15.no, var_0_16)
		var_46_2:setString("" .. arg_46_3.pt_num)
		var_46_3:setVisible(false)
		var_46_2:setColor(var_0_18.nonhave.u)
		var_46_4:setColor(var_0_18.nonhave.d)
		var_46_6:setVisible(false)
	end

	local var_46_9 = self:getDropData(arg_46_3.drop_id)
	local var_46_10
	local var_46_11 = 0

	if var_46_9.items and next(var_46_9.items) then
		var_46_10 = var_46_9.items[1].itemid
		var_46_11 = var_46_9.items[1].num
	elseif var_46_9.diamond and var_46_9.diamond > 0 then
		var_46_10 = "diamond"
		var_46_11 = var_46_9.diamond
	elseif var_46_9.gold then
		var_46_10 = "gold"
		var_46_11 = var_46_9.gold
	end

	local var_46_13

	if var_46_10 and var_46_11 then
		var_46_13 = type(var_46_10) == "string" and ccui.Button:create("public/box/" .. "1" .. ".png", "public/box/" .. "1" .. ".png", nil, var_0_16) or ccui.Button:create("public/box/" .. item_data[var_46_10].equip_quality .. ".png", "public/box/" .. item_data[var_46_10].equip_quality .. ".png", nil, var_0_16)

		var_46_13:setAnchorPoint(cc.p(0.5, 0.5))
		var_46_13:setPosition(cc.p(0, 0))
		var_46_13:setTouchEnabled(false)
		var_46_13:setSwallowTouches(false)
		var_46_13:setPosition(cc.p(arg_46_1:getContentSize().width / 2, arg_46_1:getContentSize().height / 2 + 8))
		var_46_13:setName("awarditem")
		arg_46_1:addChild(var_46_13, 2)
		var_46_13:setOpacity(0)
		var_46_13:setScale9Enabled(true)
		var_46_13:setContentSize(cc.size(80, 100))

		local var_46_14
		local var_46_15

		if var_46_10 == "gold" then
			var_46_14 = "equipment/1000001.png"
		elseif var_46_10 == "diamond" then
			var_46_14 = "equipment/1000000.png"
		elseif item_data[var_46_10].bag_item_type == kITEM_MEDAL then
			var_46_15 = ItemSprite:create_medal_icon(var_46_10)
		elseif item_data[var_46_10].bag_item_type == kITEM_COMPONENT then
			var_46_15 = componentManager:create_component_icon(var_46_10, nil, nil)
		elseif item_data[var_46_10].image_id then
			var_46_14 = "equipment/" .. item_data[var_46_10].image_id .. ".png"
		end

		var_46_15 = var_46_15 or ccui.ImageView:create(var_46_14)

		var_46_15:setPosition(cc.p(var_46_13:getContentSize().width / 2, var_46_13:getContentSize().height / 2 + 3))
		var_46_15:setName("ItemSprite")
		var_46_15:setScale(80 / math.min(var_46_15:getContentSize().width, var_46_15:getContentSize().height))
		arg_46_1:addChild(var_46_15)

		var_46_5.step = arg_46_2
		var_46_5.itemid = var_46_10

		var_46_4:setString("x" .. var_46_11)
		var_46_15:setPosition(cc.p(arg_46_1:getContentSize().width / 2, arg_46_1:getContentSize().height / 2 + 8))
		var_46_5:addTouchEventListener(function(arg_47_0, arg_47_1)
			if arg_47_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectindex = arg_47_0.step

			self:updateBtnStatus()

			if self.totalscore and self.totalscore >= arg_46_3.pt_num and not self:isAwardHaveGet(arg_47_0.step) then
				self:dealGetAward(arg_47_0.step)
			else
				self:showItemDeatil(arg_47_0)
			end
		end)
	end
end

function CommunityTaskShowLayer:showItemDeatil(arg_48_1)
	if type(arg_48_1.itemid) == "string" then
		return
	end

	local var_48_0 = item_data[arg_48_1.itemid].bag_item_type

	if item_data[arg_48_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_48_1 = -1
		local var_48_2 = require("data.item_data")[arg_48_1.itemid].horcruxtype

		for iter_48_0, iter_48_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_48_1.itemid == iter_48_1.item_id then
				var_48_1 = iter_48_0

				break
			end
		end

		if var_48_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_48_1,
			itemid = arg_48_1.itemid
		})
	elseif var_48_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_48_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_48_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_48_1.itemid
		})
	end
end

function CommunityTaskShowLayer:isAwardHaveGet(arg_49_1)
	if not arg_49_1 or not self.gethaveaward or not next(self.gethaveaward) then
		return false
	end

	local var_49_0 = false

	for iter_49_0, iter_49_1 in pairs(self.gethaveaward) do
		if iter_49_0 == arg_49_1 and iter_49_1 == 1 then
			var_49_0 = true

			break
		end
	end

	return var_49_0
end

function CommunityTaskShowLayer:updatefamilyPtData(arg_50_1)
	if not arg_50_1 or not self.gethaveaward then
		return
	end

	self.gethaveaward[arg_50_1] = 1
end

function CommunityTaskShowLayer.dealGetAward(arg_51_0, arg_51_1)
	print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPP", arg_51_1)
	community_system_manager:get_family_pt_reward(arg_51_1, function(arg_52_0)
		if arg_52_0.result == 1 then
			if var_0_11 then
				arg_51_0:updatefamilyPtData(arg_51_1)
				arg_51_0:updateAwardNode(arg_51_0.awards[arg_51_1], arg_51_1, arg_51_0.awardsdata[arg_51_1])
			end
		elseif arg_52_0.result == 9999 then
			global_ShowBlockWords("社团系统已关闭~")
			LayerManager:switchShowLayer("MainLayer")
		else
			global_ShowBlockWords(L_AVAON_VISUAL.no_award)
		end
	end)
end

function CommunityTaskShowLayer:fullScreen(arg_53_1)
	local var_53_0 = GameDisplay.getScreenSize()

	arg_53_1:setContentSize(var_53_0)
	arg_53_1:setPositionY(arg_53_1:getPositionY() - GameDisplay.fix_y)
	self.toppenel:setPositionY(var_53_0.height - self.toppenel:getContentSize().height / 2)
	self.middlelayer:setPositionY(self.toppenel:getPositionY() - 694)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.downlist:setContentSize(cc.size(640, 660 + 2 * GameDisplay.fix_y))
	self.downlist2:setContentSize(cc.size(640, 660 + 2 * GameDisplay.fix_y))
	self.downlist:setPositionY(342 - 2 * GameDisplay.fix_y)
	self.downlist2:setPositionY(342 - 2 * GameDisplay.fix_y)
end

function CommunityTaskShowLayer.getDropData(arg_54_0, arg_54_1)
	local var_54_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_54_1 = drop_data[arg_54_1] or {}

	if var_54_1.gold then
		var_54_0.gold = var_54_0.gold + var_54_1.gold
	end

	if var_54_1.diamond then
		var_54_0.diamond = var_54_0.diamond + var_54_1.diamond
	end

	local var_54_2 = 1

	if var_54_1["drop_id" .. 1] then
		local var_54_3 = 1

		while var_54_1["drop_id" .. var_54_3] do
			var_54_0.items[var_54_2] = {
				itemid = var_54_1["drop_id" .. var_54_3],
				num = var_54_1["drop_num" .. var_54_3],
				rate = var_54_1["drop_rate" .. var_54_3]
			}
			var_54_3 = var_54_3 + 1
			var_54_2 = var_54_2 + 1
		end
	end

	if var_54_1["dropmodel_id" .. 1] then
		local var_54_4 = 1

		while var_54_1["dropmodel_id" .. var_54_4] do
			if drop_data[var_54_1["dropmodel_id" .. var_54_4]].gold then
				var_54_0.gold = var_54_0.gold + drop_data[var_54_1["dropmodel_id" .. var_54_4]].gold
			end

			if drop_data[var_54_1["dropmodel_id" .. var_54_4]].diamond then
				var_54_0.diamond = var_54_0.diamond + drop_data[var_54_1["dropmodel_id" .. var_54_4]].diamond
			end

			if drop_data[var_54_1["dropmodel_id" .. var_54_4]]["drop_id" .. 1] then
				local var_54_5 = 1

				while drop_data[var_54_1["dropmodel_id" .. var_54_4]]["drop_id" .. var_54_5] do
					var_54_0.items[var_54_2] = {
						itemid = drop_data[var_54_1["dropmodel_id" .. var_54_4]]["drop_id" .. var_54_5],
						num = drop_data[var_54_1["dropmodel_id" .. var_54_4]]["drop_num" .. var_54_5]
					}
					var_54_5 = var_54_5 + 1
					var_54_2 = var_54_2 + 1
				end
			end

			if drop_data[var_54_1["dropmodel_id" .. var_54_4]]["rd_drop_id" .. 1] then
				local var_54_6 = 1

				while drop_data[var_54_1["dropmodel_id" .. var_54_4]]["rd_drop_id" .. var_54_6] do
					var_54_0.items[var_54_2] = {
						itemid = drop_data[var_54_1["dropmodel_id" .. var_54_4]]["rd_drop_id" .. var_54_6],
						num = drop_data[var_54_1["dropmodel_id" .. var_54_4]]["rd_drop_num" .. var_54_6]
					}
					var_54_6 = var_54_6 + 1
					var_54_2 = var_54_2 + 1
				end
			end

			var_54_4 = var_54_4 + 1
		end
	end

	if var_54_1["rd_drop_id" .. 1] then
		local var_54_7 = 1

		while var_54_1["rd_drop_id" .. var_54_7] do
			var_54_0.items[var_54_2] = {
				itemid = var_54_1["rd_drop_id" .. var_54_7],
				num = var_54_1["rd_drop_num" .. var_54_7]
			}
			var_54_7 = var_54_7 + 1
			var_54_2 = var_54_2 + 1
		end
	end

	if var_54_1["rd_dropmodel_id" .. 1] then
		local var_54_8 = 1

		while var_54_1["rd_dropmodel_id" .. var_54_8] do
			if drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]].gold then
				var_54_0.gold = var_54_0.gold + drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]].gold
			end

			if drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]].diamond then
				var_54_0.diamond = var_54_0.diamond + drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]].diamond
			end

			if drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["drop_id" .. 1] then
				local var_54_9 = 1

				while drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["drop_id" .. var_54_9] do
					var_54_0.items[var_54_2] = {
						itemid = drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["drop_id" .. var_54_9],
						num = drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["drop_num" .. var_54_9]
					}
					var_54_9 = var_54_9 + 1
					var_54_2 = var_54_2 + 1
				end
			end

			if drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["rd_drop_id" .. 1] then
				local var_54_10 = 1

				while drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["rd_drop_id" .. var_54_10] do
					var_54_0.items[var_54_2] = {
						itemid = drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["rd_drop_id" .. var_54_10],
						num = drop_data[var_54_1["rd_dropmodel_id" .. var_54_8]]["rd_drop_num" .. var_54_10]
					}
					var_54_10 = var_54_10 + 1
					var_54_2 = var_54_2 + 1
				end
			end

			var_54_8 = var_54_8 + 1
		end
	end

	return var_54_0
end

function CommunityTaskShowLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_56_0)
		if arg_56_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				community_system_manager:get_family_base_info(function(arg_58_0)
					if var_0_11 and arg_58_0.result and arg_58_0.result == 1 then
						self:updateTaskLabel()
					end
				end)
			end)
		end
	end), self)
end

function CommunityTaskShowLayer.taskTumpTo(arg_59_0, arg_59_1)
	if arg_59_1 then
		if arg_59_1 == 3054 then
			LayerManager:pushInLayer("PopCommunityDonationLayer", {
				surecallback = function()
					if var_0_11 and arg_59_0.seletbtnindex == 2 then
						arg_59_0:updateSelectLayer()
					end
				end
			})
		else
			require("controller.goto_system_manager")

			local var_59_0 = {
				jump_to_system = arg_59_1
			}

			var_59_0.config = system_jump_config[SYSTEMID[arg_59_1]] and system_jump_config[SYSTEMID[arg_59_1]].config

			if var_59_0.config then
				if var_59_0.config.exitCallbackType == "function" then
					var_59_0.config.exitCallback = nil
				elseif var_59_0.config.exitCallbackType == "string" then
					var_59_0.config = "MainLayer"
				end
			end

			goto_complete_system(var_59_0)
		end
	end
end
