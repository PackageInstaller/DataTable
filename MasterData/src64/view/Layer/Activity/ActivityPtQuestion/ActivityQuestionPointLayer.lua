ActivityQuestionPointLayer = class("ActivityQuestionPointLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local activity_proceed_data = require("data.activity_proceed_data")
local drop_data = require("data.drop_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_img_data = require("data.activity_img_data")
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")

require("view.Sprite.ItemSprite")

local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = "Activity_PointActivityLayer/complete_button.png"
local var_0_10 = "Activity_PointActivityLayer/uncomplete_button.png"
local var_0_11 = "Activity_PointActivityLayer/completed_arrow.png"
local var_0_12 = "Activity_PointActivityLayer/uncompleted_arrow.png"
local var_0_13 = "Activity_PointActivityLayer/completed_box.png"
local var_0_14 = "Activity_PointActivityLayer/uncompleted_box.png"
local var_0_15 = 1
local var_0_16 = 0
local var_0_17 = 2
local var_0_18 = 18

function ActivityQuestionPointLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityQuestionPointLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityQuestionPointLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityPoint.json" or "ActivityPoint.ExportJson")

	self:addChild(self.rootLayer)

	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "scroll_view")
	self.panelTop = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_top")
	self.panelDown = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_down")
	self.toptile = ccui.Helper:seekWidgetByName(self.rootLayer, "titletop")
	self.medium = ccui.Helper:seekWidgetByName(self.rootLayer, "midelimg")
	self.dibu = ccui.Helper:seekWidgetByName(self.rootLayer, "diitem")

	self.panelTop:retain()
	self.panelTop:removeFromParent()
	self.panelDown:retain()
	self.panelDown:removeFromParent()

	self.topend = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_top_end")

	self.topend:retain()
	self.topend:removeFromParent()

	arg_3_1 = arg_3_1 or {
		activity_type = "proceed_id1",
		id = "13-1",
		activityID = var_0_18
	}
	self.activityinfo = self:getActivityAllInfo(arg_3_1.activityID, arg_3_1.activity_type)
	self.activity = activity_manager:getActivityObj(arg_3_1.activityID)

	self:showActivity()
	self:initBottomList()
	self:initChangeUI()
	self:fullScreen(self.rootLayer)
	self:insertUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.panelTop then
				self.panelTop:release()
			end

			if self.panelDown then
				self.panelDown:release()
			end

			if self.topend then
				self.topend:release()
			end

			activity_manager:updateActivityAlert("proceed", var_0_18, false)
		end
	end)
end

function ActivityQuestionPointLayer:insertUI()
	local var_5_0 = ccui.ImageView:create("Activity_PointActivityLayer/title_18.png", var_0_8)

	var_5_0:setPosition(cc.p(320, self.toptile:getPositionY() - 130))
	self.rootLayer:addChild(var_5_0)

	local var_5_1 = ccui.ImageView:create("Activity_PointActivityLayer/soul_18.png", var_0_8)

	var_5_1:setPosition(cc.p(450, (GameDisplay:getScreenSize().height - GameDisplay.fix_y) / 2))
	self.rootLayer:addChild(var_5_1)
	self.medium:setPosition(cc.p(self.medium:getPositionX() - 26, var_5_0:getPositionY() - 173))
end

function ActivityQuestionPointLayer:initChangeUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "midelimg"):loadTexture("Activity_PointActivityLayer/item_activity_18.png", var_0_8)
	ccui.Helper:seekWidgetByName(self.rootLayer, "diitem"):loadTexture("Activity_PointActivityLayer/item_activity_xuefen.png", var_0_8)
	self.toptile:loadTexture("Activity_PointActivityLayer/top_activity.png", var_0_8)
end

function ActivityQuestionPointLayer:showActivity()
	self:showIntro()
	self:showSelfPoint()
	self:showBasicAwards()
end

local function var_0_19(arg_8_0)
	error(arg_8_0 .. "is Null")
end

function ActivityQuestionPointLayer.getActivityAllInfo(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		awards = {},
		limitpoint = {},
		intro = {},
		targetLayer,
		selfpoint = 0
	}
	local var_9_1 = 1

	while activity_proceed_data[arg_9_1 .. "-" .. var_9_1] and activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop do
		if drop_data[activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop].drop_id1 then
			local var_9_2 = {
				itemid = drop_data[activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop].drop_id1
			}

			var_9_2.number = drop_data[activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop].drop_num1 or 0

			table.insert(var_9_0.awards, var_9_2)
		elseif drop_data[activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop].diamond then
			table.insert(var_9_0.awards, {
				diamond = drop_data[activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop].diamond
			})
		elseif drop_data[activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop].gold then
			table.insert(var_9_0.awards, {
				gold = drop_data[activity_proceed_data[arg_9_1 .. "-" .. var_9_1].drop].gold
			})
		end

		table.insert(var_9_0.limitpoint, activity_proceed_data[arg_9_1 .. "-" .. var_9_1].num1)

		var_9_1 = var_9_1 + 1
	end

	local var_9_3 = {
		img = "mainScenebg/activity/branch18/activity_point.jpg"
	}

	var_9_3.intro = activity_conf_data[tonumber(arg_9_1)]["proceed_des" .. string.match(arg_9_2, "proceed_id(%d+)")] or "暂无简介"
	var_9_0.intro = var_9_3
	var_9_0.selfpoint = item_manager:getItemNumber(9000006)
	var_9_0.starttime = activity_conf_data[arg_9_1].starttime
	var_9_0.finishtime = activity_conf_data[arg_9_1].finishtime

	if var_9_0 and next(var_9_0) ~= nil then
		return var_9_0
	else
		var_0_19("activityinfo")
	end
end

function ActivityQuestionPointLayer:getActivityIntro()
	if self.activityinfo.intro and self.activityinfo.intro ~= "" then
		return self.activityinfo.intro
	else
		var_0_19("intro")
	end
end

function ActivityQuestionPointLayer:getActivityTime()
	if self.activityinfo.starttime and self.activityinfo.finishtime then
		local var_11_0, var_11_1, var_11_2, var_11_3 = string.match(self.activityinfo.starttime, "(%d+)-(%d+) (%d+):(%d+)")
		local var_11_4, var_11_5, var_11_6, var_11_7 = string.match(self.activityinfo.finishtime, "(%d+)-(%d+) (%d+):(%d+)")

		return var_11_0 .. "/" .. var_11_1 .. " " .. var_11_2 .. ":" .. var_11_3, var_11_4 .. "/" .. var_11_5 .. " " .. var_11_6 .. ":" .. var_11_7
	else
		var_0_19("time")
	end
end

function ActivityQuestionPointLayer:getActivityawards()
	if self.activityinfo.awards and next(self.activityinfo.awards) ~= nil then
		return self.activityinfo.awards
	else
		var_0_19("awards")
	end
end

function ActivityQuestionPointLayer:getLimitPoint(arg_13_1)
	if self.activityinfo.limitpoint[arg_13_1] and self.activityinfo.limitpoint[arg_13_1] > 0 then
		return self.activityinfo.limitpoint[arg_13_1]
	else
		var_0_19(arg_13_1 .. "th " .. "limitpoint")
	end
end

function ActivityQuestionPointLayer:getAlreadyGainTag(arg_14_1)
	if self.activityinfo.alreadygaintag[arg_14_1] then
		return self.activityinfo.alreadygaintag[arg_14_1]
	else
		var_0_19(arg_14_1 .. "th " .. "alreadygaintag")
	end
end

function ActivityQuestionPointLayer:showIntro()
	local var_15_0 = self:getActivityIntro()

	self.rootLayer:setBackGroundImage(var_15_0.img)

	local var_15_1 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_15_1:setMaxLineWidth(250)
	var_15_1:setAnchorPoint(cc.p(0, 1))
	var_15_1:setPosition(cc.p(50, 940))
	var_15_1:setString(var_15_0.intro)
	var_15_1:setName("activity_label")
	var_15_1:setColor(cc.c4b(255, 255, 255, 1))
	self.rootLayer:addChild(var_15_1, 100)
end

function ActivityQuestionPointLayer:getSelfPoint()
	if self.activityinfo.selfpoint and self.activityinfo.selfpoint >= 0 then
		return self.activityinfo.selfpoint
	else
		var_0_19("selfpoint")
	end
end

function ActivityQuestionPointLayer:showSelfPoint()
	local var_17_0 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_17_0:setColor(cc.c3b(255, 204, 0))
	var_17_0:setString((self:getSelfPoint()))
	var_17_0:setAnchorPoint(0, 0.5)
	var_17_0:setPosition(cc.p(550, 506))
	self.rootLayer:addChild(var_17_0, 5)
end

local var_0_20 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_21 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 84, 0, 150)
}

function ActivityQuestionPointLayer.create_medal_icon(arg_18_0, arg_18_1)
	local var_18_0 = item_data[arg_18_1]
	local var_18_1 = cc.Sprite:create((item_data[arg_18_1].bg or nil) and ("equipment/" .. item_data[arg_18_1].bg .. ".png" or var_0_20[var_18_0.equip_quality]))
	local var_18_2 = cc.Label:createWithTTF(var_18_0.name, FONT_DES, 54)

	var_18_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_2:setPosition(cc.p(var_18_1:getContentSize().width / 2 + 5, var_18_1:getContentSize().height / 2 - 5))
	var_18_2:enableOutline(var_0_21[var_18_0.equip_quality], 1)
	var_18_2:enableShadow(var_0_21[var_18_0.equip_quality], cc.size(0, 0))
	var_18_2:setVisible(var_18_0.only_bg ~= 1)
	var_18_1:addChild(var_18_2)

	return var_18_1
end

function ActivityQuestionPointLayer:showBasicAwards()
	local var_19_0 = 1
	local var_19_1 = 2

	local function var_19_2(arg_20_0, arg_20_1)
		local var_20_0 = ccui.Layout:create()

		var_20_0:setContentSize(arg_20_0:getContentSize())
		var_20_0:setTouchEnabled(false)
		var_20_0:setClippingEnabled(true)
		var_20_0:setName("cut_panel")
		arg_20_0:addChild(var_20_0)
		arg_20_0:setTouchEnabled(true)

		local var_20_1 = arg_20_1.itemid and ccui.ImageView:create("public/box/" .. item_data[arg_20_1.itemid].equip_quality .. ".png", var_0_8) or ccui.ImageView:create("public/box/" .. "1" .. ".png", var_0_8)
		local var_20_2 = var_20_0:getContentSize().width / var_20_1:getContentSize().width

		var_20_1:setPosition(cc.p(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2))
		var_20_1:setScale((math.max(var_20_2, var_20_0:getContentSize().height / var_20_1:getContentSize().height)))
		var_20_0:addChild(var_20_1, 0)
		var_20_1:setTouchEnabled(false)

		local var_20_3

		if arg_20_1.itemid then
			if item_data[arg_20_1.itemid].bag_item_type == kITEM_HORCRUX then
				var_20_3 = CUTE_ROLE_IMAGE_PATH .. horcruxManager:getHorcruxRoleImage(arg_20_1.itemid) .. ".png"
			elseif item_data[arg_20_1.itemid].bag_item_type == kITEM_MEDAL then
				var_20_3 = nil
			else
				var_20_3 = "equipment/" .. item_data[arg_20_1.itemid].image_id .. ".png"
			end
		elseif arg_20_1.diamond then
			var_20_3 = "equipment/1000000.png"
		elseif arg_20_1.gold then
			var_20_3 = "equipment/1000001.png"
		end

		if var_20_3 then
			local var_20_6 = ccui.ImageView:create(var_20_3)

			var_20_6:setScale(100 / var_20_6:getContentSize().width)

			if self.posTag == var_19_0 then
				var_20_6:setPosition(arg_20_0:getContentSize().width / 2, arg_20_0:getContentSize().height / 2 + 20)
			else
				var_20_6:setPosition(arg_20_0:getContentSize().width / 2, arg_20_0:getContentSize().height / 2 - 20)
			end

			var_20_6:setName("itemSp")
			var_20_0:addChild(var_20_6)
		elseif not var_20_3 and item_data[arg_20_1.itemid].bag_item_type == kITEM_MEDAL then
			local var_20_7 = self:create_medal_icon(arg_20_1.itemid)

			var_20_7:setAnchorPoint(cc.p(0.5, 0.5))

			if self.posTag == var_19_0 then
				var_20_7:setPosition(arg_20_0:getContentSize().width / 2, arg_20_0:getContentSize().height / 2 + 20)
			else
				var_20_7:setPosition(arg_20_0:getContentSize().width / 2, arg_20_0:getContentSize().height / 2 - 20)
			end

			var_20_0:addChild(var_20_7)
		end

		local var_20_8 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_20_8:setAnchorPoint(cc.p(1, 0))

		if self.posTag == var_19_0 then
			var_20_8:setPosition(cc.p(130, 30))
		else
			var_20_8:setPosition(cc.p(130, 112))
		end

		local var_20_9

		if arg_20_1.itemid then
			var_20_9 = arg_20_1.number or 1
		elseif arg_20_1.diamond then
			var_20_9 = arg_20_1.diamond
		elseif arg_20_1.gold then
			var_20_9 = arg_20_1.gold
		end

		var_20_8:setString(var_20_9)
		var_20_8:setName("award_number")
		var_20_0:addChild(var_20_8, 9)
	end

	local function var_19_3(arg_21_0)
		local var_21_0 = {}
		local var_21_1 = self:getSelfPoint()

		if arg_21_0 and next(arg_21_0) ~= nil then
			for iter_21_0 = 1, #arg_21_0 do
				local var_21_2 = self:getLimitPoint(iter_21_0)

				if var_21_1 < var_21_2 then
					self.button[iter_21_0].status = var_0_17
				else
					if arg_21_0[iter_21_0].status == 0 and var_21_2 <= var_21_1 then
						table.insert(var_21_0, iter_21_0)
						self.button[iter_21_0]:setTouchEnabled(true)
						self.button[iter_21_0]:getChildByName("button_label"):setString("领取")

						self.button[iter_21_0].status = var_0_15
					elseif arg_21_0[iter_21_0].status == 1 then
						self.button[iter_21_0]:setTouchEnabled(false)
						self.button[iter_21_0]:getChildByName("button_label"):setString("已领取")

						self.button[iter_21_0].status = var_0_16

						self.button[iter_21_0].completeTag:setVisible(true)

						local var_21_3

						if config._DEBUG then
							var_21_3 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
						end

						var_21_3:setAnchorPoint(cc.p(0.5, 0.5))
						var_21_3:setPosition(cc.p(96, 21))
						var_21_3:setScale(0.8)
						self.button[iter_21_0].completeTag:addChild(var_21_3, 10)
					end

					self.button[iter_21_0]:addTouchEventListener(function(arg_22_0, arg_22_1)
						if arg_22_1 ~= ccui.TouchEventType.ended then
							return
						end

						self:updateGainAward(arg_22_0, iter_21_0)
					end)
				end

				self.button[iter_21_0].bg:addTouchEventListener(function(arg_23_0, arg_23_1)
					if arg_23_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_23_0:getTouchEndPosition().x - arg_23_0:getTouchBeganPosition().x) > 50 then
						return
					end

					if self.button[iter_21_0].status == var_0_16 or self.button[iter_21_0].status == var_0_17 then
						self:showAwardsDetails(arg_23_0.itemid, arg_23_0.item_type)
					elseif self.button[iter_21_0].status == var_0_15 then
						self:updateGainAward(self.button[iter_21_0], iter_21_0)
					end
				end)
			end
		end
	end

	self.button = {}

	local var_19_4 = self:getActivityawards()
	local var_19_5 = 100
	local var_19_7 = 145

	for iter_19_0 = 1, #var_19_4 do
		local var_19_8
		local var_19_9 = self:getSelfPoint()
		local var_19_10 = self:getLimitPoint(iter_19_0)
		local var_19_11 = iter_19_0 - 1 ~= 0 and self:getLimitPoint(iter_19_0 - 1) or 0
		local var_19_12

		if iter_19_0 % 2 == 1 then
			var_19_8 = self.panelTop:clone()
			self.posTag = 1
			var_19_12 = 314
		else
			var_19_8 = self.panelDown:clone()
			self.posTag = var_19_1
			var_19_12 = 100
		end

		if iter_19_0 == #var_19_4 then
			var_19_8 = self.topend:clone()
			self.posTag = 1
			var_19_12 = 314
		end

		var_19_8:setAnchorPoint(cc.p(0, 0.5))

		local var_19_13 = ccui.Helper:seekWidgetByName(var_19_8, "button_complete")
		local var_19_14 = var_19_13:getChildByName("button_label")
		local var_19_15 = ccui.Helper:seekWidgetByName(var_19_8, "progress_bar")
		local var_19_16 = ccui.Helper:seekWidgetByName(var_19_8, "arrow")
		local var_19_17 = ccui.Helper:seekWidgetByName(var_19_8, "img_bg")
		local var_19_18 = ccui.Helper:seekWidgetByName(var_19_8, "complete_tag")

		var_19_18:setVisible(false)

		self.button[iter_19_0] = var_19_13
		self.button[iter_19_0].completeTag = var_19_18
		self.button[iter_19_0].bg = var_19_17

		var_19_2(var_19_17, var_19_4[iter_19_0])
		var_19_14:setString("未领取")
		var_19_15:setPercent(0)

		if var_19_10 <= var_19_9 then
			var_19_14:setString("loading...")
			var_19_16:loadTexture(var_0_11, var_0_8)

			if iter_19_0 ~= #var_19_4 then
				var_19_17:loadTexture(var_0_13, var_0_8)
				var_19_13:loadTextures(var_0_9, var_0_9, var_0_9, var_0_8)
			else
				var_19_17:loadTexture("Activity_PointActivityLayer/new_endaward.png", var_0_8)
				var_19_13:loadTextures("Activity_PointActivityLayer/new_kelingqu.png", "Activity_PointActivityLayer/new_kelingqu.png", "Activity_PointActivityLayer/new_kelingqu.png", var_0_8)
			end

			var_19_13:setTouchEnabled(false)
			var_19_15:setPercent(100)
		else
			var_19_14:setString(var_19_10 .. "分解锁")
			var_19_16:loadTexture(var_0_12, var_0_8)

			if iter_19_0 ~= #var_19_4 then
				var_19_17:loadTexture(var_0_14, var_0_8)
				var_19_13:loadTextures(var_0_10, nil, var_0_10, var_0_8)
			else
				var_19_17:loadTexture("Activity_PointActivityLayer/new_endaward.png", var_0_8)
				var_19_13:loadTextures("Activity_PointActivityLayer/new_weilingqu.png", nil, "Activity_PointActivityLayer/new_weilingqu.png", var_0_8)
			end

			var_19_13:setTouchEnabled(false)
			var_19_15:setPercent((var_19_9 - var_19_11) * 100 / (var_19_10 - var_19_11))
		end

		if iter_19_0 < #var_19_4 then
			var_19_8:setPosition(cc.p(var_19_5 + var_19_7 * (iter_19_0 - 1), var_19_12))
			self.scrollView:addChild(var_19_8)
		else
			var_19_8:setPosition(cc.p(125, 612))
			var_19_8:setName("lastone")
			ccui.Helper:seekWidgetByName(var_19_8, "progress_bg"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_19_8, "arrow"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_19_8, "cut_panel"):getChildByName("award_number"):setPosition(cc.p(150, 20))
			ccui.Helper:seekWidgetByName(var_19_8, "cut_panel"):getChildByName("itemSp"):setPositionY(ccui.Helper:seekWidgetByName(var_19_8, "cut_panel"):getChildByName("itemSp"):getPositionY() - 10)
			var_19_13:setPositionY(var_19_13:getPositionY() - 20)
			self.rootLayer:addChild(var_19_8, 100)
		end

		var_19_17.itemid = var_19_4[iter_19_0].itemid

		if var_19_4[iter_19_0].itemid then
			var_19_17.item_type = "item"
		end

		var_19_17:setTouchEnabled(true)
	end

	self.scrollView:setInnerContainerSize(cc.size(var_19_5 + (#var_19_4 - 2) * var_19_7 + 67, 400))
	self.scrollView:setPosition(cc.p(self.scrollView:getPositionX() + 2, self.scrollView:getPositionY() - 30))
	self.activity:getActivityProceed(function(arg_24_0, arg_24_1)
		if arg_24_0 == 0 then
			global_ShowBlockWords("活动无积分兑换")
		elseif arg_24_0 == 1 then
			var_19_3(arg_24_1)
		elseif arg_24_0 == 2 then
			global_ShowBlockWords("活动已结束")
		end
	end)
end

function ActivityQuestionPointLayer:updateGainAward(arg_25_1, arg_25_2)
	self.activity:getActivityProceedAward(arg_25_2, function(arg_26_0, arg_26_1)
		if arg_26_0 == 0 then
			global_ShowBlockWords("活动无积分兑换")
		elseif arg_26_0 == 1 then
			arg_25_1.status = var_0_16

			arg_25_1:getChildByName("button_label"):setString("已领取")
			arg_25_1.completeTag:setVisible(true)

			local var_26_0

			if config._DEBUG then
				var_26_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
			end

			var_26_0:setScale(4)
			var_26_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_0:setPosition(cc.p(96, 21))
			arg_25_1.completeTag:addChild(var_26_0, 10)
			var_26_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.4, 0.8), cc.CallFunc:create(function()
				global_gain(arg_26_1)
			end)))
		elseif arg_26_0 == 2 then
			global_ShowBlockWords("活动已结束")
		elseif arg_26_0 == 3 then
			global_ShowBlockWords("当前奖励已全部领取")
		elseif arg_26_0 == 4 then
			-- block empty
		end
	end)
end

function ActivityQuestionPointLayer:showAwardsDetails(arg_28_1, arg_28_2)
	local function var_28_0()
		self.rootLayer:setVisible(true)
	end

	if arg_28_2 == "item" then
		if item_data[arg_28_1].bag_item_type == kITEM_HORCRUX then
			local var_28_1 = -1
			local var_28_2 = require("data.HelpGirl_data")[arg_28_1].horcruxtype

			for iter_28_0, iter_28_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_28_1 == iter_28_1.item_id then
					var_28_1 = iter_28_0

					break
				end
			end

			if var_28_1 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_28_1,
				itemid = arg_28_1,
				callback = var_28_0
			})
			self.rootLayer:setVisible(false)
		elseif item_data[arg_28_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_28_1].major,
				exitCallback = var_28_0
			})
			self.rootLayer:setVisible(false)
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_28_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_28_1
			})
		end
	elseif arg_28_2 == "gold" then
		-- block empty
	elseif arg_28_2 == "diamond" then
		-- block empty
	end
end

function ActivityQuestionPointLayer:initBottomList()
	self.buttonList = BottomBtnList:create(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc(global_basic_scene)
	end, {
		{
			texture = "public/button/public_button_big_blue_y.png",
			name = "goTarget",
			word = "前往任务",
			handler = function(arg_32_0, arg_32_1)
				if arg_32_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:switchShowLayer("ActivityQuestionPtTaskLayer", {})
			end
		}
	})

	self:addChild(self.buttonList, 999)
end

function ActivityQuestionPointLayer:fullScreen(arg_33_1)
	arg_33_1:setContentSize((GameDisplay.getScreenSize()))
	arg_33_1:setPositionY(arg_33_1:getPositionY() - GameDisplay.fix_y)
	self.buttonList:setPositionY(self.buttonList:getPositionY() - GameDisplay.fix_y)
	self.toptile:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height - 25))
	self.scrollView:setPositionY(self.scrollView:getPositionY() + 32)
	self.medium:setScale9Enabled(true)
	self.medium:setCapInsets(cc.rect(100, 100, 130, 130))
	self.medium:setContentSize(cc.size(300, 250))
	self.medium:setPositionY(self.toptile:getPositionY() - 4 - self.medium:getContentSize().height / 2 - self.toptile:getContentSize().height / 2)
	arg_33_1:getChildByName("activity_label"):setPositionY(self.toptile:getPositionY() - 230 - self.toptile:getContentSize().height / 2)
	arg_33_1:getChildByName("lastone"):setPositionY(self.dibu:getPositionY() + self.dibu:getContentSize().height / 2 + 85)
end
