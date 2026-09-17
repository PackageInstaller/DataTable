PopReturnBuffLayer = class("PopReturnBuffLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local gamebuff_data = require("data.gamebuff_data")
local chapter_data = require("data.chapter_data")
local school_afkbonus_data = require("data.school_afkbonus_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_return_manager = require("controller.activity_return_manager")
local TempWidget = require("view.Sprite.TempWidget")
local item_data = require("data.item_data")

function PopReturnBuffLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopReturnBuffLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopReturnBuffLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopReturnBuffLayer.json" or "PopReturnBuffLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.initParam = arg_3_1
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_img")

	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setScaleY(0)
	self.rootpanel:setTouchEnabled(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26"):setString(L_POPCARDBUFFLAYER.title)

	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_3")
	self.no_label = ccui.Helper:seekWidgetByName(self.rootLayer, "no_data")

	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback({
					type = self.atrr
				})
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)

	self.class = playermodel.class

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopReturnBuffLayer")
		end
	end)
	activity_return_manager:get_game_buffs(function(arg_7_0)
		if arg_7_0 and arg_7_0.result == 1 then
			self.cardData = activity_return_manager:get_buffs()
		end

		self:initUI()
	end)
end

local function var_0_11(arg_8_0)
	if arg_8_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_8_0 / 86400), math.floor(arg_8_0 % 86400 / 3600))
	elseif arg_8_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_8_0 / 3600), math.floor(arg_8_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[4], math.floor(arg_8_0 / 60), math.floor(arg_8_0 % 60))
	end
end

function PopReturnBuffLayer:initUI()
	self.Listview:setItemsMargin(10)

	local var_9_0 = time_check_manager:getCurTime()
	local var_9_1 = {}

	if self.initParam.hangupbuffs.base_exp then
		local var_9_2 = L_PLAYER_DATA_TYPE.Exp .. string.format(" +%d/分钟", math.floor(self.initParam.hangupbuffs.base_exp))
		local var_9_4 = ""
		local var_9_6 = 1

		if self.cardData and next(self.cardData) then
			for iter_9_0, iter_9_1 in pairs(self.cardData) do
				if gamebuff_data[iter_9_1.id].type == 1 then
					var_9_6 = var_9_6 + gamebuff_data[iter_9_1.id].rate
					var_9_4 = var_9_4 .. L_POPCARDBUFFLAYER["tips_" .. gamebuff_data[iter_9_1.id].type] .. gamebuff_data[iter_9_1.id].rate * 100 .. "%" .. "(" .. var_0_11(iter_9_1.time - var_9_0) .. ")" .. "\n"
				end
			end
		end

		local var_9_7

		if var_9_6 > 1 then
			var_9_2 = L_PLAYER_DATA_TYPE.Exp .. string.format(" +%d/分钟", math.floor(self.initParam.hangupbuffs.base_exp * var_9_6))
			var_9_7 = {
				des = var_9_2,
				des1 = var_9_4,
				path = "equipment/exp.png",
				des2 = ""
			}
		end

		var_9_7.des3 = L_POPCARDBUFFLAYER.tips_1 .. school_afkbonus_data[self.class].exp_buff * 100 .. L_POPCARDBUFFLAYER.class

		table.insert(var_9_1, var_9_7)
	end

	if self.initParam.hangupbuffs.base_sp then
		local var_9_9 = "equipment/1000004.png"
		local var_9_11 = ""
		local var_9_12 = ""
		local var_9_13 = ""
		local var_9_14 = 1

		if self.cardData and next(self.cardData) then
			for iter_9_2, iter_9_3 in pairs(self.cardData) do
				if gamebuff_data[iter_9_3.id].type == 2 then
					var_9_14 = var_9_14 + gamebuff_data[iter_9_3.id].rate
					var_9_11 = L_POPCARDBUFFLAYER["tips_" .. gamebuff_data[iter_9_3.id].type] .. gamebuff_data[iter_9_3.id].rate * 100 .. "%" .. "(" .. var_0_11(iter_9_3.time - var_9_0) .. ")"
				end
			end
		end

		if IsOpenPrivilege() then
			local var_9_15 = GetPrivilegeSpDropMarkup()

			var_9_14 = var_9_14 + var_9_15 / 100
			var_9_12 = L_POPCARDBUFFLAYER.tips_privilege_2 .. var_9_15 .. "%" .. "(" .. GetPrivilegeRemainDay() .. "天)"
		end

		local var_9_16 = L_PLAYER_DATA_TYPE.Tech .. string.format(" +%d/分钟", math.floor(self.initParam.hangupbuffs.base_sp * var_9_14))

		if var_9_12 == "" then
			var_9_12 = L_POPCARDBUFFLAYER.tips_1 .. school_afkbonus_data[self.class].sci_buff * 100 .. L_POPCARDBUFFLAYER.class
		else
			var_9_13 = L_POPCARDBUFFLAYER.tips_1 .. school_afkbonus_data[self.class].sci_buff * 100 .. L_POPCARDBUFFLAYER.class
		end

		table.insert(var_9_1, {
			des = var_9_16,
			des1 = var_9_11,
			path = var_9_9,
			des2 = var_9_12,
			des3 = var_9_13
		})
	end

	if self.initParam.hangupbuffs.base_gold then
		local var_9_18 = "equipment/1000001.png"
		local var_9_20 = ""
		local var_9_21 = ""
		local var_9_22 = ""
		local var_9_23 = 1

		if self.cardData and next(self.cardData) then
			for iter_9_4, iter_9_5 in pairs(self.cardData) do
				if gamebuff_data[iter_9_5.id].type == 3 then
					var_9_23 = var_9_23 + gamebuff_data[iter_9_5.id].rate
					var_9_20 = L_POPCARDBUFFLAYER["tips_" .. gamebuff_data[iter_9_5.id].type] .. gamebuff_data[iter_9_5.id].rate * 100 .. "%" .. "(" .. var_0_11(iter_9_5.time - var_9_0) .. ")"
				end
			end
		end

		if IsOpenPrivilege() then
			local var_9_24 = GetPrivilegeGoldDropMarkup()

			var_9_23 = var_9_23 + var_9_24 / 100
			var_9_21 = L_POPCARDBUFFLAYER.tips_privilege_3 .. var_9_24 .. "%" .. "(" .. GetPrivilegeRemainDay() .. "天)"
		end

		local var_9_25 = L_GOLD .. string.format(" +%d/分钟", math.floor(self.initParam.hangupbuffs.base_gold * var_9_23))

		if var_9_21 == "" then
			var_9_21 = L_POPCARDBUFFLAYER.tips_1 .. school_afkbonus_data[self.class].money_buff * 100 .. L_POPCARDBUFFLAYER.class
		else
			var_9_22 = L_POPCARDBUFFLAYER.tips_1 .. school_afkbonus_data[self.class].money_buff * 100 .. L_POPCARDBUFFLAYER.class
		end

		table.insert(var_9_1, {
			des = var_9_25,
			des1 = var_9_20,
			path = var_9_18,
			des2 = var_9_21,
			des3 = var_9_22
		})
	end

	local var_9_26 = playermodel.curMode .. "-" .. string.split(playermodel.curLevel, "-")[1]

	if chapter_data[var_9_26].increase_text then
		local var_9_27 = {
			des = chapter_data[var_9_26].increase_text
		}

		var_9_27.path = "equipment/component_up.png"

		table.insert(var_9_1, var_9_27)
	end

	for iter_9_6, iter_9_7 in pairs(self.initParam.hangupbuffs.hangup_info) do
		if iter_9_7 and iter_9_7.equips and iter_9_7.equips[1] and iter_9_7.equips[1].dropid then
			local var_9_29 = {}

			var_9_29.des = item_data[iter_9_7.equips[1].dropid].name .. (iter_9_7.des or "@在对应的表里des")
			var_9_29.path = "equipment/" .. item_data[iter_9_7.equips[1].dropid].image_id .. ".png"
			var_9_29.time = os.time(parse_time(iter_9_7.finishtime))

			table.insert(var_9_1, var_9_29)
		end

		if iter_9_7 and iter_9_7.up_items_path then
			for iter_9_8, iter_9_9 in pairs(iter_9_7.up_items_path) do
				local var_9_31 = {}

				var_9_31.des = iter_9_7.up_items_des[iter_9_8] or "@在对应的表里up_items_des"
				var_9_31.path = iter_9_9
				var_9_31.time = os.time(parse_time(iter_9_7.finishtime))

				table.insert(var_9_1, var_9_31)
			end
		end

		if iter_9_7 and iter_9_7.gold and iter_9_7.gold > 100 then
			local var_9_33 = {}

			var_9_33.des = "" .. (iter_9_7.gold_des or "在对应的表里up_items_des")
			var_9_33.path = "equipment/1000001.png"
			var_9_33.time = os.time(parse_time(iter_9_7.finishtime))

			table.insert(var_9_1, var_9_33)
		end

		if iter_9_7 and iter_9_7.exp and iter_9_7.exp > 100 then
			local var_9_35 = {}

			var_9_35.des = "" .. (iter_9_7.exp_des or "@在对应的表里exp_des")
			var_9_35.path = "equipment/1000007.png"
			var_9_35.time = os.time(parse_time(iter_9_7.finishtime))

			table.insert(var_9_1, var_9_35)
		end

		if iter_9_7 and iter_9_7.sp and iter_9_7.sp > 100 then
			local var_9_37 = {}

			var_9_37.des = "" .. (iter_9_7.sp_des or "@在对应的表里sp_des")
			var_9_37.path = "equipment/1000004.png"
			var_9_37.time = os.time(parse_time(iter_9_7.finishtime))

			table.insert(var_9_1, var_9_37)
		end
	end

	for iter_9_10, iter_9_11 in pairs(var_9_1) do
		local var_9_38 = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

		if iter_9_11.time then
			var_9_38:getChildByName("Label_dec_time"):setString(L_TIME_REST .. var_0_11(iter_9_11.time - time_check_manager:getCurTime()))
			var_9_38:getChildByName("Label_dec_time"):setVisible(true)
		else
			var_9_38:getChildByName("Label_dec_time"):setVisible(false)
		end

		var_9_38:getChildByName("Label_dec_time"):setFontSize(20)
		var_9_38:getChildByName("Label_dec"):setFontSize(22)
		var_9_38:getChildByName("Label_dec"):setString(iter_9_11.des)
		var_9_38:getChildByName("Label_dec_1"):setString(iter_9_11.des1)
		var_9_38:getChildByName("Label_dec_1"):setColor(cc.c3b(0, 208, 255))

		if not var_9_38:getChildByName("Label_dec_2") then
			local var_9_39 = var_9_38:getChildByName("Label_dec_1")
			local var_9_40 = var_9_39:clone()

			var_9_40:setName("Label_dec_2")
			var_9_38:addChild(var_9_40)

			local var_9_41 = var_9_39:getAnchorPoint()

			var_9_40:setAnchorPoint(cc.p(var_9_41.x, var_9_41.y))
			var_9_40:setPosition(cc.p(var_9_39:getPositionX(), var_9_39:getPositionY() - var_9_39:getContentSize().height + 60))
		end

		var_9_38:getChildByName("Label_dec_2"):setString(iter_9_11.des2)
		var_9_38:getChildByName("Label_dec_2"):setColor(cc.c3b(0, 208, 255))

		if not var_9_38:getChildByName("Label_dec_3") then
			local var_9_42 = var_9_38:getChildByName("Label_dec_2")
			local var_9_43 = var_9_42:clone()

			var_9_43:setName("Label_dec_3")
			var_9_38:addChild(var_9_43)

			local var_9_44 = var_9_42:getAnchorPoint()

			var_9_43:setAnchorPoint(cc.p(var_9_44.x, var_9_44.y))
			var_9_43:setPosition(cc.p(var_9_42:getPositionX(), var_9_42:getPositionY() - var_9_42:getContentSize().height + 60))
		end

		var_9_38:getChildByName("Label_dec_3"):setString(iter_9_11.des3)
		var_9_38:getChildByName("Label_dec_3"):setColor(cc.c3b(0, 208, 255))

		if iter_9_11.path:find("equipment") then
			var_9_38:getChildByName("mage"):loadTexture(iter_9_11.path)
		else
			var_9_38:getChildByName("mage"):loadTexture(iter_9_11.path, var_0_0)
		end

		var_9_38:getChildByName("mage"):setScale(80 / var_9_38:getChildByName("mage"):getContentSize().width)
		self.Listview:pushBackCustomItem(var_9_38)
	end
end

function PopReturnBuffLayer:exit(arg_10_1)
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback({
				type = self.atrr
			})
		end

		if arg_10_1 then
			arg_10_1()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopReturnBuffLayer:initBg(arg_12_1)
	local var_12_0 = ccui.Layout:create()

	var_12_0:setTouchEnabled(true)
	var_12_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_0:setAnchorPoint(cc.p(0, 0))
	var_12_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_12_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_12_0:setOpacity(0)
	var_12_0:setCascadeOpacityEnabled(false)
	self:addChild(var_12_0, -1)

	local var_12_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_12_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_12_1:setPositionX(var_12_0:getContentSize().width / 2)
	var_12_1:setPositionY(var_12_0:getContentSize().height / 2)
	var_12_0:addChild(var_12_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_13_0)
		self:addChild(arg_13_0, -2)
		arg_13_0:setPositionY(arg_13_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_12_1)
		var_12_0:setOpacity(102)
		var_12_0:setTouchEnabled(false)
	end)
end
