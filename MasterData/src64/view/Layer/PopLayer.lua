PopLayer = class("PopLayer", function()
	return cc.Layer:create()
end)

require("data.constants")
require("data.language_constants")
require("view.Sprite.ItemSprite")

local network = require("network.network")
local audio_manager = require("controller.audio_manager")
local item_manager = require("controller.item_manager")
local cook_manager = require("controller.cook_manager")
local weapon_manager = require("controller.weapon_manager")
local core_manager = require("controller.core_manager")
local model_manager = require("controller.model_manager")
local sign_manager = require("controller.sign_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local level_manager = require("controller.level_manager")
local item_data = require("data.item_data")
local var_0_11 = require("data.item_data")
local drop_data = require("data.drop_data")
local HelpGirl_level_data = require("data.HelpGirl_level_data")
local postcard_data = require("data.postcard_data")
local levelmode_data = require("data.levelmode_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local core_data = require("data.core_data")
local var_0_20 = require("data.item_data")
local component_manager = require("controller.component_manager")
local component_effect_data = require("data.component_effect_data")
local playermodel = require("model.playermodel")
local var_0_24 = 10
local var_0_25 = config._DEBUG and 0 or 1
local var_0_26 = {
	[13] = ""
}

function PopLayer.fullScreen(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:setContentSize(GameDisplay.getScreenSize())
	arg_2_2:setPositionY(arg_2_2:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
end

function PopLayer:Popup_Init(arg_3_1)
	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_normal.json" or "Popup_normal.ExportJson")

	self:addChild(self.Pop)

	self.removeFlag = true
	self.panel = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")

	local var_3_0 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")
	local var_3_1 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_3_2 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_3_3 = var_3_2:getChildByName("label")

	ccui.Helper:seekWidgetByName(self.Pop, "image_system_figure"):setVisible(false)
	self:ActionofAccess(self.panel)
	self.panel:setAnchorPoint(cc.p(0.5, 0.5))
	self.panel:setPosition(cc.p(self.panel:getContentSize().width / 2, self.panel:getContentSize().height / 2))

	local function var_3_4(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_3_1.cancelcallback then
			arg_3_1.cancelcallback()
		end

		self:removeSelf(self.panel)
	end

	ccui.Helper:seekWidgetByName(self.Pop, "button_close"):addTouchEventListener(var_3_4)
	var_3_0:addTouchEventListener(var_3_4)
	ccui.Helper:seekWidgetByName(self.Pop, "bg"):setTouchEnabled(true)

	if arg_3_1.labels and arg_3_1.labels.title then
		var_3_1:setString(arg_3_1.labels.title)
	else
		var_3_1:setString("物品详情")
	end

	if arg_3_1.labels and arg_3_1.labels.button then
		var_3_3:setString(arg_3_1.labels.button)
	end

	var_3_2:setVisible(false)

	if arg_3_1.cost then
		local var_3_5

		if config._DEBUG then
			var_3_5 = cc.Sprite:create(arg_3_1.cost.costtype) or cc.Sprite:createWithSpriteFrameName(arg_3_1.cost.costtype)
		end

		var_3_5:setAnchorPoint(0.5, 0)
		var_3_5:setPosition(cc.p(SCREEN_WIDTH / 2 - 25, 450 + 37))
		var_3_5:setName("cost_icon")

		if arg_3_1.cost.costtype == IMAGE_CLOTHESTICKET then
			var_3_5:setScale(0.3125)
		else
			var_3_5:setScale(0.6)
		end

		self.Pop:addChild(var_3_5, 10)

		local var_3_6 = cc.Label:createWithTTF(arg_3_1.cost.costnum, FONT_DES, 25)

		var_3_6:setAnchorPoint(0.5, 0)
		var_3_6:setPosition(cc.p(55, 0))
		var_3_5:addChild(var_3_6, 1)
	end

	local var_3_7 = {}

	if arg_3_1.button then
		local var_3_8 = SCREEN_WIDTH / 2 - 5
		local var_3_9 = 450
		local var_3_10 = 280
		local var_3_11 = #arg_3_1.button

		for iter_3_0, iter_3_1 in pairs(arg_3_1.button) do
			if iter_3_1.label == "锁定" or iter_3_1.label == "解锁" then
				var_3_11 = var_3_11 + 1
			end
		end

		for iter_3_2, iter_3_3 in pairs(arg_3_1.button) do
			if iter_3_3.label ~= "锁定" and iter_3_3.label ~= "解锁" then
				buttonPath = var_3_11 == 2 and "public/button/public_button_orange.png" or "public/button/public_button_orange_long.png"
				var_3_7[iter_3_2] = ccui.Button:create(buttonPath, nil, buttonPath, var_0_25)

				if iter_3_3.label == "已满级" then
					var_3_7[iter_3_2]:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_25)
				end

				if iter_3_3.label == "已满级" or iter_3_3.label == "强 化" then
					self.specialTag = true
				end

				var_3_7[iter_3_2]:setAnchorPoint(cc.p(0.5, 0.5))

				x = var_3_8 + var_3_10 * (iter_3_2 - 1 - (var_3_11 - 1) / 2)

				var_3_7[iter_3_2]:setPosition(x, var_3_9 - 140)

				local var_3_12 = cc.Label:createWithTTF(iter_3_3.label, FONT_BUTTON, 30)

				var_3_12:setColor(cc.c3b(41, 49, 58))
				var_3_12:setName("openLabel")
				var_3_12:setPosition(cc.p(var_3_7[iter_3_2]:getContentSize().width / 2, var_3_7[iter_3_2]:getContentSize().height / 2 - 5))
				var_3_7[iter_3_2]:addChild(var_3_12)
			else
				if iter_3_3.label == "锁定" then
					var_3_7[iter_3_2] = ccui.Button:create("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_25)
				elseif iter_3_3.label == "解锁" then
					var_3_7[iter_3_2] = ccui.Button:create("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_25)
				end

				var_3_7[iter_3_2]:setAnchorPoint(cc.p(0.5, 0.5))
				var_3_7[iter_3_2]:setPosition(530, 790)
				var_3_7[iter_3_2]:setName("lockbtn")
			end

			if iter_3_3.label == "替 换" then
				var_3_7[iter_3_2]:loadTextures("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_off.png", var_0_25)
			end

			var_3_7[iter_3_2].count = iter_3_3.count

			self.panel:addChild(var_3_7[iter_3_2], 10)
			var_3_7[iter_3_2]:addTouchEventListener(function(arg_5_0, arg_5_1)
				if arg_5_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_5_0:isBright() then
					return
				end

				if iter_3_3.surecallback then
					iter_3_3.surecallback(arg_5_0, arg_5_1, function(arg_6_0, arg_6_1, arg_6_2)
						if not self.removeFlag then
							return
						end

						if arg_6_0 and arg_6_0 == 0 then
							var_3_7[iter_3_2]:loadTextures("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_25)
							self.Strength_Icon:getChildByName("lock"):setVisible(false)
						elseif arg_6_0 and arg_6_0 == 1 then
							var_3_7[iter_3_2]:loadTextures("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_25)
						end

						if self.Strength_Icon then
							self.Strength_Icon:updateBigInfo(false)

							if self.Strength_Icon:getChildByName("lock") then
								self.Strength_Icon:getChildByName("lock"):setVisible(false)
							end

							if (not arg_6_0 or arg_6_0 == nil) and not component_manager:getStrengthenStatus(arg_3_1.entityid) then
								var_3_7[iter_3_2]:getChildByName("openLabel"):setString("已满级")
								var_3_7[iter_3_2]:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_25)
								var_3_7[iter_3_2]:setBright(false)
							end
						end

						if arg_6_1 and self.info_label then
							for iter_6_0 = 1, #self.info_label do
								if arg_6_1[iter_6_0] and arg_6_1[iter_6_0] ~= nil then
									self.info_label[iter_6_0]:setString(arg_6_1[iter_6_0])
								end
							end
						end

						if arg_6_2 and next(arg_6_2) and self.limit_info_label then
							for iter_6_1 = 1, #self.limit_info_label do
								if arg_6_2[iter_6_1] then
									self.limit_info_label[iter_6_1]:setVisible(true)
									self.limit_info_label[iter_6_1]:setString(arg_6_2[iter_6_1])
									self.line:setVisible(true)
								end
							end
						elseif self.limit_info_label then
							for iter_6_2 = 1, #self.limit_info_label do
								if arg_6_2 and arg_6_2[iter_6_2] then
									self.limit_info_label[iter_6_2]:setVisible(false)
									self.line:setVisible(false)
								end
							end
						end

						if self.Pop and self.Pop:getChildByName("attrLayout") then
							self.Pop:getChildByName("attrLayout"):runAction(cc.RemoveSelf:create())
						end

						if iter_3_3.label == "强 化" then
							local var_6_0 = component_manager:getUpGradeData(arg_3_1.entityid)

							if component_manager:getStrengthenStatus(arg_3_1.entityid) then
								if self.panel:getChildByName("newvalue") then
									self.panel:getChildByName("newvalue"):setString(FIGHT_ATTR_FORMAT(var_6_0.labels[2].key, var_6_0.labels[2].newvalue) .. "~" .. FIGHT_ATTR_FORMAT(var_6_0.labels[2].key, var_6_0.labels[2].max_value))
								end

								if not var_6_0.labels[3] or next(var_6_0.labels[3]) == nil then
									local var_6_1 = 1

									while self.panel:getChildByName("subLabel" .. var_6_1) do
										self.panel:getChildByName("subLabel" .. var_6_1):setVisible(false)

										var_6_1 = var_6_1 + 1
									end
								else
									for iter_6_3 = 1, #var_6_0.labels[3] do
										if self.panel:getChildByName("subLabel" .. iter_6_3) then
											self.panel:getChildByName("subLabel" .. iter_6_3):setString(var_6_0.labels[3][iter_6_3].newvalue)
											self.panel:getChildByName("subLabel" .. iter_6_3):setVisible(true)
										else
											-- block empty
										end
									end
								end

								if self.panel:getChildByName("gold_num") then
									self.panel:getChildByName("gold_num"):setString(var_6_0.gold_cost)
								end
							else
								var_3_7[iter_3_2]:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_25)
								var_3_7[iter_3_2]:getChildByName("openLabel"):setString("已满级")

								if self.panel:getChildByName("newvalue") then
									self.panel:getChildByName("newvalue"):setVisible(false)
								end

								if self.panel:getChildByName("gold_num") then
									self.panel:getChildByName("gold_num"):setVisible(false)
								end

								if self.panel:getChildByName("gold_img") then
									self.panel:getChildByName("gold_img"):setVisible(false)
								end

								if self.panel:getChildByName("arrow") then
									self.panel:getChildByName("arrow"):setVisible(false)
								end

								local var_6_4 = 1

								while self.panel:getChildByName("subLabel" .. var_6_4) do
									self.panel:getChildByName("subLabel" .. var_6_4):setVisible(false)

									var_6_4 = var_6_4 + 1
								end
							end
						end
					end)
				end

				if iter_3_3.label ~= "强 化" and iter_3_3.label ~= "已满级" and iter_3_3.label ~= "锁定" and iter_3_3.label ~= "解锁" then
					if arg_3_1.cancelcallback then
						arg_3_1.cancelcallback()
					end

					self.removeFlag = false

					self:removeSelf(self.panel)
				end
			end)
		end

		if #var_3_7 == 2 and self.panel:getChildByName("lockbtn") or #var_3_7 == 1 then
			var_3_7[#var_3_7]:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_gray_long.png", var_0_25)

			if arg_3_1.button[#var_3_7].label == "已满级" then
				var_3_7[#var_3_7]:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_25)
				var_3_7[#var_3_7]:getChildByName("openLabel"):setPosition(cc.p(var_3_7[#var_3_7]:getContentSize().width / 2, var_3_7[#var_3_7]:getContentSize().height / 2 - 5))
			else
				var_3_7[#var_3_7]:getChildByName("openLabel"):setPosition(cc.p(var_3_7[#var_3_7]:getContentSize().width / 2, var_3_7[#var_3_7]:getContentSize().height / 2 - 5))
			end

			var_3_7[#var_3_7]:setScale9Enabled(true)
			var_3_7[#var_3_7]:setCapInsets(cc.rect(88, 20, 10, 10))
			var_3_7[#var_3_7]:setContentSize(cc.size(338, 120))
			var_3_7[#var_3_7]:setPressedActionEnabled(true)

			if arg_3_1.cost then
				self.Pop:getChildByName("cost_icon"):setPosition(cc.p(320, 450))
			end
		end
	end

	if arg_3_1.nextgrade and component_manager:getStrengthenStatus(arg_3_1.entityid) then
		if self.specialTag == true then
			local var_3_13 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_25)

			var_3_13:setPosition(cc.p(290, 708))
			var_3_13:setName("arrow")
			self.panel:addChild(var_3_13)

			local var_3_14 = cc.Label:createWithTTF(FIGHT_ATTR_FORMAT(arg_3_1.nextgrade.labels[2].key, arg_3_1.nextgrade.labels[2].newvalue) .. "~" .. FIGHT_ATTR_FORMAT(arg_3_1.nextgrade.labels[2].key, arg_3_1.nextgrade.labels[2].max_value), FONT_DES, 20)

			var_3_14:setColor(cc.c3b(0, 216, 255))
			var_3_14:setPosition(cc.p(cc.p(var_3_13:getPositionX() + var_3_13:getContentSize().width / 2, var_3_13:getPositionY())))
			var_3_14:setAnchorPoint(cc.p(0, 0.5))
			var_3_14:setName("newvalue")
			self.panel:addChild(var_3_14)

			if arg_3_1.nextgrade.labels[3] and next(arg_3_1.nextgrade.labels[3]) ~= nil then
				-- block empty
			end

			if arg_3_1.nextgrade.gold_cost then
				local var_3_17 = ccui.ImageView:create(IMAGE_GOLD, var_0_25)

				var_3_17:setPosition(cc.p(150, 250))
				var_3_17:setName("gold_img")
				self.panel:addChild(var_3_17)

				local var_3_18 = cc.Label:createWithTTF(arg_3_1.nextgrade.gold_cost, FONT_DES, 20)

				var_3_18:setAnchorPoint(cc.p(0, 0.5))
				var_3_18:setPosition(cc.p(180, 250))
				var_3_18:setName("gold_num")
				self.panel:addChild(var_3_18)

				if #var_3_7 == 2 and self.panel:getChildByName("lockbtn") or #var_3_7 == 1 then
					var_3_17:setPosition(cc.p(290, 250))
					var_3_18:setPosition(cc.p(320, 250))
				end
			end
		else
			self:Upgrade_Everything_COST(arg_3_1.nextgrade)
		end
	end

	self:fullScreen(var_3_0, self.panel)

	return self.Pop
end

function PopLayer:Layer_Item_Info(arg_7_1)
	local var_7_0 = cc.Layer:create()
	local var_7_1 = arg_7_1.entityid
	local var_7_2 = tonumber(arg_7_1.itemid)
	local var_7_4 = 17
	local var_7_6 = 490
	local var_7_7 = 65
	local var_7_8 = 50
	local var_7_9 = {}
	local var_7_10
	local var_7_11 = false
	local var_7_12 = 20
	local var_7_13 = 245

	if tonumber(var_7_2) ~= nil then
		var_7_11 = true
		var_7_10 = item_data[var_7_2]
	end

	if arg_7_1.dropnum then
		arg_7_1.itemnum = arg_7_1.dropnum
	elseif arg_7_1.itemnum then
		arg_7_1.dropnum = arg_7_1.itemnum
	end

	local var_7_14 = ccui.ImageView:create("public/panelbg/intro_bottom.png", var_0_25)

	var_7_14:setScale9Enabled(true)
	var_7_14:setName("using_des_bg")
	var_7_14:setContentSize(cc.size(470, var_7_8))
	var_7_14:setAnchorPoint(cc.p(0, 1))
	var_7_14:setPosition(cc.p(53, var_7_6 - 220))
	var_7_0:addChild(var_7_14, 1)

	local var_7_15 = cc.Label:createWithTTF("", FONT_NAME, var_7_4)

	;(nil):setString(var_0_11[var_7_2].user_manual or "劈里啪啦劈里啪啦~")
	var_7_15:setPosition(cc.p(10, var_7_8 - 10))
	var_7_15:setAnchorPoint(cc.p(0, 1))
	var_7_15:setMaxLineWidth(450)
	var_7_14:addChild(var_7_15)
	var_7_15:setColor(cc.c3b(243, 249, 255))

	local var_7_17 = var_0_26[var_7_10.bag_item_type] or ""
	local var_7_18
	local var_7_19 = cc.Label:createWithTTF(var_7_17 .. "机密信息，尚未公布", FONT_DES, var_7_4)

	var_7_19:setName("info")
	var_7_19:setColor(cc.c3b(188, 206, 226))
	var_7_19:setMaxLineWidth(450)

	if var_7_10 and var_7_10.intro then
		var_7_18 = math.ceil(var_7_4 * string.len(var_7_17 .. var_7_10.intro) / 3 / 430) + 1

		var_7_19:setString(var_7_17 .. var_7_10.intro)
	end

	local var_7_20 = ccui.ImageView:create("public/panelbg/intro_bottom.png", var_0_25)

	var_7_20:setScale9Enabled(true)
	var_7_20:setName("layout")
	var_7_20:setContentSize(cc.size(470, 30))
	var_7_20:setAnchorPoint(cc.p(0, 1))
	var_7_0:addChild(var_7_20, 1)

	if var_7_1 then
		self.Strength_Icon = ItemSprite:createBigWithEntityId(var_7_1, arg_7_1.dropnum or playermodel.items[var_7_1].number)

		if self.Strength_Icon:getChildByName("use") then
			local var_7_22

			if var_0_11[var_7_2].bag_item_type == kITEM_COMPONENT then
				var_7_22 = playermodel.items[var_7_1].component_attr.use
			elseif var_0_11[var_7_2].bag_item_type == kITEM_WEAPON then
				var_7_22 = playermodel.items[var_7_1].weapon_attr.use
			end

			if var_7_22 then
				self.Strength_Icon:getChildByName("use"):setVisible(true)
			else
				self.Strength_Icon:getChildByName("use"):setVisible(false)
			end
		end

		if self.Strength_Icon:getChildByName("lock") then
			self.Strength_Icon:getChildByName("lock"):setVisible(false)
		end

		if var_0_11[var_7_2].bag_item_type == kITEM_COMPONENT then
			var_7_9 = component_manager:initComponentIntro(var_7_1, true)

			var_7_20:setPosition(cc.p(53, var_7_6 - 285))

			if var_7_4 * var_7_18 + 6 > 140 then
				var_7_20:setContentSize(cc.size(470, var_7_4 * var_7_18 + 6))
				var_7_19:setPosition(cc.p(10, var_7_4 * var_7_18 - 4))
			else
				var_7_20:setContentSize(cc.size(470, var_7_7))
				var_7_19:setPosition(cc.p(10, var_7_7 - 10))
			end

			var_7_19:setAnchorPoint(cc.p(0, 1))
		elseif var_0_11[var_7_2].bag_item_type == kITEM_WEAPON then
			var_7_9 = weapon_manager:getWeaponInfowithEntityid(var_7_1)

			var_7_20:setPosition(cc.p(53, var_7_6 - 280))
			var_7_20:setContentSize(cc.size(470, var_7_7))
			var_7_19:setAnchorPoint(cc.p(0, 1))
			var_7_19:setPosition(cc.p(10, var_7_7 - 10))
		end
	else
		self.Strength_Icon = ItemSprite:createNewWithItemId(var_7_2, nil, nil, nil, arg_7_1.item_attr)

		if var_7_11 == true then
			if var_0_11[var_7_2].bag_item_type == kITEM_COMPONENT and arg_7_1.itemattr and #arg_7_1.itemattr ~= 0 then
				var_7_9 = component_manager:initComponentIntrowithItemid(var_7_2, arg_7_1.itemattr)
			elseif var_0_11[var_7_2].bag_item_type == kITEM_WEAPON and arg_7_1.item_attr and next(arg_7_1.item_attr) then
				var_7_9 = weapon_manager:initWeaponInfowithItemid(var_7_2, arg_7_1.item_attr)
			end
		end

		var_7_20:setPosition(cc.p(53, var_7_6 - 280))
		var_7_20:setContentSize(cc.size(470, var_7_7))
		var_7_19:setAnchorPoint(cc.p(0, 1))
		var_7_19:setPosition(cc.p(10, var_7_7 - 10))
	end

	self.Strength_Icon:setPosition(cc.p(140, 410))
	self.Strength_Icon:setScale(0.62)
	self.Strength_Icon:setName("Strength_Icon")
	self:ActionofAccess(self.Strength_Icon)
	var_7_0:addChild(self.Strength_Icon, 1)

	if var_7_11 == true then
		if var_0_11[var_7_2].bag_item_type == kITEM_COMPONENT and next(var_7_9) ~= nil then
			local var_7_23, var_7_24 = string.find(var_7_9[#var_7_9], "【套装效果】")

			var_7_9[#var_7_9] = string.sub(var_7_9[#var_7_9], var_7_23, var_7_24 + 9) .. string.sub(var_7_9[#var_7_9], var_7_24 + 10)
			self.info_label = {}

			local var_7_25 = {
				L_WEAPON_MAIN_ATTR .. "：",
				L_WEAPON_SUB_ATTR .. "：",
				[#var_7_9] = ""
			}

			for iter_7_0 = 1, #var_7_9 - 1 do
				if var_7_25[iter_7_0] then
					self.info_label[iter_7_0] = cc.Label:createWithTTF(var_7_25[iter_7_0] .. "\n" .. var_7_9[iter_7_0], FONT_DES, var_7_12)

					if iter_7_0 ~= 1 then
						var_7_6 = var_7_6 - 50
					end
				else
					self.info_label[iter_7_0] = cc.Label:createWithTTF(var_7_9[iter_7_0], FONT_DES, var_7_12)
					var_7_6 = var_7_6 - self.info_label[iter_7_0 - 1]:getContentSize().height
				end

				if iter_7_0 == 1 then
					self.info_label[iter_7_0]:setColor(cc.c3b(0, 216, 255))
				else
					self.info_label[iter_7_0]:setColor(cc.c3b(203, 218, 235))
				end

				self.info_label[iter_7_0]:setAnchorPoint(cc.p(0, 1))
				self.info_label[iter_7_0]:setPosition(cc.p(var_7_13, var_7_6 - 2))
				var_7_0:addChild(self.info_label[iter_7_0])
				self:ActionofAccess(self.info_label[iter_7_0])
			end

			var_7_15:setString(var_7_25[#var_7_9] .. var_7_9[#var_7_9])

			if arg_7_1.servantid and COMPONENT_SERVANT_LIMIT and core_manager:getServantCoreRank(arg_7_1.servantid) < COMPONENT_SERVANT_LIMIT[var_0_20[playermodel.items[var_7_1].itemid].equip_quality] or playermodel.items[var_7_1].component_attr.extra < var_0_20[playermodel.items[var_7_1].itemid].equip_quality * 5 then
				var_7_6 = var_7_6 - 50

				local var_7_26 = {
					L_WEAPON_MAIN_ATTR_EFFECTIVE .. "：",
					L_WEAPON_SUB_ATTR_EFFECTIVE .. "：",
					[#var_7_9] = ""
				}

				self.line = ccui.Layout:create()

				self.line:setTouchEnabled(true)
				self.line:setContentSize(cc.size(300, 2))
				self.line:setAnchorPoint(cc.p(0, 1))
				self.line:setPosition(cc.p(230, var_7_6 + 2))
				self.line:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				self.line:setBackGroundColor(cc.c3b(113, 119, 134))
				self.line:setBackGroundColorOpacity(255)
				var_7_0:addChild(self.line)

				local var_7_27 = component_manager:initComponentIntro(var_7_1, true, nil, arg_7_1.servantid)

				self.limit_info_label = {}

				for iter_7_1 = 1, #var_7_27 - 1 do
					if var_7_27[iter_7_1] then
						self.limit_info_label[iter_7_1] = cc.Label:createWithTTF(var_7_26[iter_7_1] .. "\n" .. var_7_27[iter_7_1], FONT_DES, var_7_12)

						if iter_7_1 ~= 1 then
							var_7_6 = var_7_6 - 45
						end
					else
						self.limit_info_label[iter_7_1] = cc.Label:createWithTTF(var_7_27[iter_7_1], FONT_DES, var_7_12)
						var_7_6 = var_7_6 - self.limit_info_label[iter_7_1 - 1]:getContentSize().height
					end

					self.limit_info_label[iter_7_1]:setAnchorPoint(cc.p(0, 1))
					self.limit_info_label[iter_7_1]:setPosition(cc.p(230, var_7_6 - 2))
					var_7_0:addChild(self.limit_info_label[iter_7_1])
					self:ActionofAccess(self.limit_info_label[iter_7_1])

					if var_7_27[1] == var_7_9[1] then
						self.limit_info_label[iter_7_1]:setVisible(false)
						self.line:setVisible(false)
					end

					if iter_7_1 == 1 then
						self.info_label[iter_7_1]:setColor(cc.c3b(0, 216, 255))
					else
						self.info_label[iter_7_1]:setColor(cc.c3b(203, 218, 235))
					end
				end
			end
		elseif var_0_11[var_7_2].bag_item_type == kITEM_WEAPON and next(var_7_9) then
			self.info_label = {}

			local var_7_29 = {}

			table.insert(var_7_29, {
				key = "mainAttrDes",
				value = L_WEAPON_MAIN_ATTR .. "(满级)"
			})

			for iter_7_2, iter_7_3 in pairs(var_7_9.mainAttr) do
				table.insert(var_7_29, {
					key = iter_7_3.key,
					value = iter_7_3.value
				})
			end

			table.insert(var_7_29, {
				key = "subAttrDes",
				value = L_WEAPON_SUB_ATTR .. "(满级)"
			})

			for iter_7_4, iter_7_5 in pairs(var_7_9.subAttr) do
				table.insert(var_7_29, {
					key = iter_7_5.key,
					value = iter_7_5.value
				})
			end

			for iter_7_6, iter_7_7 in pairs(var_7_29) do
				self.info_label[iter_7_6] = cc.Label:createWithTTF(iter_7_7.value, FONT_DES, var_7_12)

				self.info_label[iter_7_6]:setAnchorPoint(cc.p(0, 1))
				self.info_label[iter_7_6]:setPosition(cc.p(var_7_13, var_7_6 - 2))

				self.info_label[iter_7_6].key = iter_7_7.key

				var_7_0:addChild(self.info_label[iter_7_6])

				var_7_6 = var_7_6 - self.info_label[iter_7_6]:getContentSize().height

				if iter_7_7.key == "mainAttrDes" or iter_7_7.key == "subAttrDes" then
					self.info_label[iter_7_6]:setColor(cc.c3b(0, 216, 255))
				else
					self.info_label[iter_7_6]:setColor(cc.c3b(203, 218, 235))
				end
			end
		end

		if var_0_11[var_7_2].bag_item_type == kITEM_WEAPON and var_7_1 then
			function var_7_0:updateShow()
				var_7_9 = weapon_manager:getWeaponInfowithEntityid(var_7_1)

				if next(var_7_9) then
					local var_8_0 = {}

					table.insert(var_8_0, {
						key = "mainAttrDes",
						value = L_WEAPON_MAIN_ATTR
					})

					for iter_8_0, iter_8_1 in pairs(var_7_9.mainAttr) do
						table.insert(var_8_0, {
							key = iter_8_1.key,
							value = iter_8_1.value
						})
					end

					table.insert(var_8_0, {
						key = "subAttrDes",
						value = L_WEAPON_SUB_ATTR
					})

					for iter_8_2, iter_8_3 in pairs(var_7_9.subAttr) do
						table.insert(var_8_0, {
							key = iter_8_3.key,
							value = iter_8_3.value
						})
					end

					for iter_8_4, iter_8_5 in pairs(var_8_0) do
						if not self.info_label[iter_8_4] then
							self.info_label[iter_8_4] = cc.Label:createWithTTF(iter_8_5.value, FONT_DES, var_7_12)

							self.info_label[iter_8_4]:setAnchorPoint(cc.p(0, 1))
							self.info_label[iter_8_4]:setPosition(cc.p(var_7_13, var_7_6 - 2))
							self:addChild(self.info_label[iter_8_4])

							var_7_6 = var_7_6 - self.info_label[iter_8_4]:getContentSize().height
							self.info_label[iter_8_4].key = iter_8_5.key
						end

						self.info_label[iter_8_4]:setString(iter_8_5.value)

						if iter_8_5.key == "mainAttrDes" or iter_8_5.key == "subAttrDes" then
							self.info_label[iter_8_4]:setColor(cc.c3b(0, 216, 255))
						else
							self.info_label[iter_8_4]:setColor(cc.c3b(203, 218, 235))
						end
					end
				end

				self.Strength_Icon:updateBigInfo(false)

				if self.Strength_Icon:getChildByName("lock") then
					self.Strength_Icon:getChildByName("lock"):setVisible(false)
				end
			end
		end

		if var_0_11[var_7_2].bag_item_type == kITEM_COMPONENT or var_0_11[var_7_2].bag_item_type == kITEM_WEAPON then
			local var_7_30 = cc.Label:createWithTTF("", FONT_DES, 22)

			var_7_30:setPosition(cc.p(210, 510))
			var_7_30:setAnchorPoint(cc.p(1, 1))
			var_7_30:setColor(cc.c3b(198, 197, 38))
			var_7_0:addChild(var_7_30, 100)

			if arg_7_1.tag_exist == false then
				var_7_30:setString("new")
			end

			if arg_7_1.tag_equip == true then
				var_7_30:setString("已自动装备")
			end
		else
			local var_7_31 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_7_31:setAnchorPoint(cc.p(0, 0.5))
			var_7_31:setPosition(cc.p(245, var_7_6 - 20))
			var_7_31:setColor(cc.c3b(0, 216, 255))
			var_7_31:setName("numberLabel")
			var_7_0:addChild(var_7_31, 1)

			if var_0_11[var_7_2].bag_item_type ~= 13 then
				var_7_31:setString("拥有数量：" .. (arg_7_1.itemnum or item_manager:getItemNumber(arg_7_1.itemid)))
			else
				var_7_31:setString(var_0_11[var_7_2].name)
			end

			var_7_20:setPosition(cc.p(53, var_7_6 - 280))

			if self.costLayer then
				var_7_20:setContentSize(cc.size(470, var_7_7))
				var_7_19:setPosition(cc.p(10, var_7_7 - 10))
			else
				var_7_20:setContentSize(cc.size(470, var_7_7))
				var_7_19:setPosition(cc.p(10, var_7_7 - 10))
			end

			var_7_19:setAnchorPoint(cc.p(0, 1))
		end
	end

	local var_7_33 = cc.Label:createWithTTF(var_0_11[var_7_2].name, FONT_DES, 32)

	var_7_33:setName("name_label")
	var_7_33:setColor(cc.c3b(188, 206, 226))
	var_7_33:setAnchorPoint(0, 0.5)
	var_7_33:setPosition(cc.p(var_7_13, 510))
	var_7_0:addChild(var_7_33, 1)
	var_7_19:setDimensions(460, 0)
	var_7_20:addChild(var_7_19, 2)
	self:ActionofAccess(var_7_20)

	if var_0_11[var_7_2].bagweight and var_0_11[var_7_2].bagweight ~= 0 then
		local var_7_34 = ccui.Helper:seekWidgetByName(arg_7_1.panel, "image_bg")
		local var_7_35 = ccui.Helper:seekWidgetByName(arg_7_1.panel, "title")

		var_7_34:setContentSize(cc.size(532, 540))
		var_7_34:setPositionY(var_7_34:getPositionY() + 17)

		local var_7_36 = cc.Label:createWithTTF("负重：" .. var_0_11[var_7_2].bagweight, FONT_DES, 20)

		var_7_36:setColor(cc.c3b(188, 206, 226))
		var_7_36:setAnchorPoint(cc.p(1, 0))
		var_7_36:setPosition(cc.p(520, 115))
		var_7_0:addChild(var_7_36)
	else
		local var_7_37 = ccui.Helper:seekWidgetByName(arg_7_1.panel, "image_bg")

		var_7_37:setContentSize(cc.size(532, 540))
		var_7_37:setPositionY(var_7_37:getPositionY() + 17)
	end

	local var_7_38 = ccui.Button:create("public/button/button_saying.png", nil, "public/button/button_saying.png", var_0_25)

	var_7_38:setPosition(cc.p(470, 295))
	var_7_38:setName("GainButton")
	var_7_0:addChild(var_7_38, 1)

	if arg_7_1.hideGainButton == true then
		var_7_38:setVisible(false)
	end

	var_7_38:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_9_0()
			self.Pop:setVisible(true)
		end

		self.Pop:setVisible(false)

		local var_9_1 = PopLayer.new()
		local var_9_2 = PopLayer:Go_Gain_Layer({
			item = var_7_2,
			surecallback = function()
				self:runAction(cc.RemoveSelf:create())

				if arg_7_1.cancelcallback then
					arg_7_1.cancelcallback()
				end

				if arg_7_1.removeParentCallback then
					arg_7_1.removeParentCallback()
				end
			end,
			returnlayer = arg_7_1.returnlayer,
			goto_back_system_id = arg_7_1.goto_back_system_id,
			goto_back_system_config = arg_7_1.goto_back_system_config,
			cancelcallback = var_9_0
		})

		if var_9_2 then
			cc.Director:getInstance():getRunningScene():addChild(var_9_2, 999)
		end
	end)

	local var_7_39 = ccui.ImageView:create("public/panelbg/title_component.png", var_0_25)

	var_7_39:setName("titleImg")
	var_7_39:setAnchorPoint(cc.p(0, 0.5))
	var_7_39:setPosition(cc.p(34, 578))
	var_7_0:addChild(var_7_39)
	print("itemid==", var_7_2)

	if var_0_11[var_7_2].bag_item_type == kITEM_WEAPON then
		var_7_39:loadTexture("public/panelbg/title_weapon.png", var_0_25)
	elseif var_0_11[var_7_2].bag_item_type == kITEM_COMPONENT then
		-- block empty
	else
		var_7_39:loadTexture("public/panelbg/title_item.png", var_0_25)
	end

	return var_7_0
end

function PopLayer.Layer_Shop_Slider(arg_12_0, arg_12_1)
	local var_12_0 = cc.Layer:create()

	if arg_12_1.itemid and arg_12_1.ShopSliderCallback then
		local var_12_1 = arg_12_1.selectNum or 1
		local var_12_2
		local var_12_3 = 1
		local var_12_4
		local var_12_5

		if arg_12_1.slidecost and arg_12_1.slidecost.costtype == "public/currency/UI_battleEnd_diamond.png" and arg_12_1.slidecost.nowHave then
			arg_12_1.slidecost.nowHave = playermodel.diamond
		end

		if arg_12_1.limitNum and arg_12_1.limitNum > 1 then
			var_12_2 = ccui.Slider:create()

			var_12_2:setName("slider")

			var_12_3 = arg_12_1.limitNum
			var_12_5 = ccui.Layout:create()

			var_12_5:setName("layout_slider")
			var_12_5:setContentSize(cc.size(240, 80))
			var_12_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_12_5:setPosition(cc.p(70, -10))
			var_12_0:addChild(var_12_5, 1)

			var_12_4 = cc.Label:createWithTTF(var_12_1 .. "/" .. var_12_3, FONT_DES, 20)

			var_12_4:setPosition(cc.p(var_12_5:getContentSize().width / 2 + 80, var_12_5:getContentSize().height / 2 + 15))
			var_12_0:addChild(var_12_4, 3)
			var_12_2:loadBarTexture("public/panelbg/blue_slider_bottom.png", var_0_25)
			var_12_2:loadProgressBarTexture("public/panelbg/blue_slider_bar.png", var_0_25)
			var_12_2:loadSlidBallTextures("public/button/blue_slider_node.png", "public/button/blue_slider_node.png", "public/button/blue_slider_node.png", var_0_25)
			var_12_2:setPercent((var_12_1 - 1) * 100 / (var_12_3 - 1))
		end

		local var_12_6
		local var_12_7 = cc.Label:createWithTTF("", "fonts/newkj.ttf", 30)

		var_12_7:setName("Label_button")

		if arg_12_1.limitNum and arg_12_1.limitNum > 1 then
			var_12_6 = ccui.Button:create("public/button/public_button_orange.png", "public/button/public_button_orange.png", "public/button/public_button_orange.png", var_0_25)

			var_12_6:setPosition(cc.p(470, 30))
		else
			var_12_6 = ccui.Button:create("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange.png", var_0_25)

			var_12_6:setPosition(cc.p(320, 30))
		end

		var_12_6:setName("callback_button")
		var_12_6:setPressedActionEnabled(true)

		var_12_6.nowNum = var_12_1

		if arg_12_1.marketType == "market_collection" then
			if item_manager:getItemNumber(arg_12_1.itemid) == 0 then
				var_12_7:setString("没东西能卖")
				var_12_6:loadTextures("public/button/public_button_gray.png", "public/button/public_button_gray.png", "public/button/public_button_gray.png", var_0_25)
				var_12_6:setTouchEnabled(false)
			else
				var_12_7:setString("卖 掉")
			end
		else
			var_12_7:setString("购 买")

			if arg_12_1.baggain then
				var_12_7:setString("使 用")
			end
		end

		if arg_12_1.slidecost and arg_12_1.slidecost.costtype and arg_12_1.slidecost.costtype == "public/currency/rmb_white.png" then
			var_12_7:setString("购 买")
			var_12_6:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_off.png", var_0_25)
		end

		var_12_7:setAnchorPoint(cc.p(0.5, 0.5))

		if arg_12_1.limitNum and arg_12_1.limitNum > 1 then
			var_12_7:setPosition(cc.p(var_12_6:getContentSize().width / 2, var_12_6:getContentSize().height / 2))
		else
			var_12_7:setPosition(cc.p(var_12_6:getContentSize().width / 2, var_12_6:getContentSize().height / 2 - 5))
		end

		var_12_7:setColor(cc.c3b(41, 49, 58))
		var_12_6:addChild(var_12_7)

		local var_12_8

		if arg_12_1.slidecost then
			local var_12_9

			if config._DEBUG then
				var_12_9 = cc.Sprite:create(arg_12_1.slidecost.costtype) or cc.Sprite:createWithSpriteFrameName(arg_12_1.slidecost.costtype)
			end

			var_12_9:setAnchorPoint(0.5, 0.5)

			if arg_12_1.limitNum and arg_12_1.limitNum > 1 then
				var_12_9:setPosition(cc.p(440, -30))
			else
				var_12_9:setPosition(cc.p(310 - 25, -30))
			end

			if arg_12_1.slidecost.costtype == "equipment/6800201.png" then
				var_12_9:setScale(0.2734375)
			end
		end

		var_12_0:addChild(var_12_9, 10)

		var_12_8 = cc.Label:createWithTTF(arg_12_1.slidecost.costnum, FONT_DES, 25)

		if utfstrlen(var_12_8:getString()) > 6 then
			var_12_8:setScale(0.6)
		elseif utfstrlen(var_12_8:getString()) > 5 then
			var_12_8:setScale(0.8)
		end

		var_12_8:setAnchorPoint(0, 0.5)
		var_12_8:setPosition(cc.p(var_12_9:getPositionX() + 30, var_12_9:getPositionY()))
		var_12_0:addChild(var_12_8, 10)
		var_12_8:setName("costLabel")

		if arg_12_1.baggain and arg_12_1.baggain.gaintype then
			local var_12_10

			if config._DEBUG then
				var_12_10 = cc.Sprite:create(arg_12_1.baggain.gaintype) or cc.Sprite:createWithSpriteFrameName(arg_12_1.baggain.gaintype)
			end

			var_12_10:setAnchorPoint(0.5, 0.5)
			var_12_10:setName("icon_bag")
			var_12_0:addChild(var_12_10, 10)

			var_12_8 = cc.Label:createWithTTF(arg_12_1.baggain.gainunit, FONT_DES, 25)

			var_12_8:setAnchorPoint(0, 0.5)
			var_12_0:addChild(var_12_8, 10)

			if arg_12_1.limitNum <= 1 or not arg_12_1.limitNum then
				var_12_10:setPosition(cc.p(320 - 30, -30))
			else
				var_12_10:setPosition(cc.p(320 + 120, -30))
			end

			var_12_8:setPosition(cc.p(var_12_10:getPositionX() + 30, var_12_10:getPositionY()))
			var_12_8:setName("costLabel")
		end

		if arg_12_1.limit_time then
			local var_12_11 = cc.Label:createWithTTF(arg_12_1.limit_time, FONT_DES, 24)

			var_12_11:setColor(cc.c3b(242, 242, 242))
			var_12_11:setPosition(cc.p(320, -60))
			var_12_0:addChild(var_12_11)
		end

		local var_12_12

		local function var_12_13(arg_13_0)
			var_12_8:setString(arg_12_1.slidecost.costnum * arg_13_0)

			if utfstrlen(var_12_8:getString()) > 6 then
				var_12_8:setScale(0.6)
			elseif utfstrlen(var_12_8:getString()) > 5 then
				var_12_8:setScale(0.8)
			else
				var_12_8:setScale(1)
			end

			var_12_6:setBright(true)

			if arg_12_1.slidecost.costnum * arg_13_0 <= (arg_12_1.slidecost.nowHave or 0) then
				var_12_6:setColor(cc.c3b(255, 255, 255))
				var_12_7:setString("购 买")
			else
				var_12_6:setColor(cc.c3b(255, 255, 255))
				var_12_7:setString("物品不足")
			end

			if arg_12_1.marketType == "market_collection" then
				if arg_13_0 > item_manager:getItemNumber(arg_12_1.itemid) then
					var_12_7:setString("物品不足")

					return
				else
					var_12_7:setString("卖 掉")

					return
				end
			end
		end

		local function var_12_14(arg_14_0)
			if arg_12_1.baggain.gainunit then
				var_12_8:setString(arg_12_1.baggain.gainunit * arg_14_0)
			end

			var_12_6:setBright(true)
			var_12_6:setColor(cc.c3b(255, 255, 255))
			var_12_7:setString("使 用")
		end

		local function var_12_15(arg_15_0, arg_15_1)
			var_12_1 = math.ceil(tonumber(var_12_2:getPercent() / 100 * var_12_3))

			if var_12_1 == 0 then
				var_12_1 = 1
			end

			if arg_12_1.marketType == "market_collection" and var_12_1 > item_manager:getItemNumber(arg_12_1.itemid) then
				global_ShowBlockWords("拥有数量不足")

				var_12_1 = item_manager:getItemNumber(arg_12_1.itemid)
			end

			var_12_6.nowNum = var_12_1

			var_12_4:setString(var_12_1 .. "/" .. var_12_3)
			var_12_2:setPercent((var_12_1 - 1) * 100 / (var_12_3 - 1))

			if arg_12_1.slidecost then
				var_12_13(var_12_1)
			elseif arg_12_1.baggain then
				var_12_14(var_12_1)
			end
		end

		local function var_12_16(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_12_1.marketType == "market_collection" and var_12_1 + 1 > item_manager:getItemNumber(arg_12_1.itemid) then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords("拥有数量不足")

				return
			end

			if arg_12_1.limitNum then
				if var_12_1 < var_12_3 then
					var_12_1 = var_12_1 + 1
					var_12_6.nowNum = var_12_1

					var_12_2:setPercent((math.ceil((var_12_1 - 1) * 100 / (var_12_3 - 1))))
					var_12_4:setString(var_12_1 .. "/" .. var_12_3)
				end
			else
				var_12_1 = var_12_1 + 1
				var_12_6.nowNum = var_12_1
			end

			if arg_12_1.slidecost then
				var_12_13(var_12_1)
			elseif arg_12_1.baggain then
				var_12_14(var_12_1)
			end
		end

		local function var_12_17(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_12_1 > 1 then
				var_12_1 = var_12_1 - 1
				var_12_6.nowNum = var_12_1

				if arg_12_1.limitNum then
					var_12_2:setPercent((math.ceil((var_12_1 - 1) * 100 / (var_12_3 - 1))))
					var_12_4:setString(var_12_1 .. "/" .. var_12_3)
				end
			end

			if arg_12_1.slidecost then
				var_12_13(var_12_1)
			elseif arg_12_1.baggain then
				var_12_14(var_12_1)
			end
		end

		if arg_12_1.limitNum and arg_12_1.limitNum > 1 then
			local var_12_18 = ccui.Layout:create()

			var_12_18:setTouchEnabled(true)
			var_12_18:setContentSize(cc.size(var_12_2:getContentSize().width, var_12_2:getContentSize().height + 40))
			var_12_18:setAnchorPoint(cc.p(0.5, 0.5))
			var_12_18:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
			var_12_18:setPosition(cc.p(var_12_2:getContentSize().width / 2, var_12_2:getContentSize().height / 2))
			var_12_2:addChild(var_12_18, 99)
			var_12_18:addTouchEventListener(function(arg_18_0, arg_18_1)
				if arg_18_1 == ccui.TouchEventType.moved then
					var_12_2:setPercent(var_12_18:convertToNodeSpace((arg_18_0:getTouchMovePosition())).x * 100 / var_12_18:getContentSize().width)
				end

				if arg_18_1 == ccui.TouchEventType.began then
					var_12_2:setPercent(var_12_18:convertToNodeSpace((arg_18_0:getTouchBeganPosition())).x * 100 / var_12_18:getContentSize().width)
				end

				var_12_15()
			end)
		end

		local var_12_21 = ccui.Button:create("public/button/add_blue_btn.png", nil, "public/button/add_blue_btn.png", var_0_25)
		local var_12_22 = ccui.Button:create("public/button/sub_blue_btn.png", nil, "public/button/sub_blue_btn.png", var_0_25)

		if arg_12_1.limitNum and arg_12_1.limitNum > 1 and var_12_3 ~= 1 and var_12_3 ~= 0 then
			var_12_2:addEventListener(var_12_15)
			var_12_5:addChild(var_12_2, 3)
			var_12_21:setPosition(cc.p(var_12_5:getContentSize().width / 2 + 125, var_12_5:getContentSize().height / 2 + 2))
			var_12_22:setPosition(cc.p(var_12_5:getContentSize().width / 2 - 100, var_12_5:getContentSize().height / 2 + 2))
			var_12_2:setPosition(cc.p(var_12_5:getContentSize().width / 2 + 12, var_12_5:getContentSize().height / 2 + 2))

			if var_12_12 then
				var_12_12:setVisible(true)
			end

			var_12_5:addChild(var_12_21, 3)
			var_12_5:addChild(var_12_22, 3)
		elseif not arg_12_1.limitNum then
			var_12_21:setPosition(cc.p(510, 380))
			var_12_22:setPosition(cc.p(310, 380))
		else
			var_12_21:setVisible(false)
			var_12_22:setVisible(false)
		end

		var_12_0:addChild(var_12_6, 3)
		var_12_21:setName("add_button")
		var_12_22:setName("sub_button")
		var_12_21:addTouchEventListener(var_12_16)
		var_12_22:addTouchEventListener(var_12_17)

		if arg_12_1.slidecost and arg_12_1.slidecost.costtype and arg_12_1.slidecost.costtype == "recharge/rmb_white.png" then
			var_12_21:setVisible(false)
			var_12_22:setVisible(false)
		end

		var_12_6:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_12_1.baggain then
				arg_12_0:removeSelf(arg_12_0.panel)
			end

			arg_19_0.num = var_12_1

			arg_12_1.ShopSliderCallback(arg_19_0, arg_19_1, arg_12_1.shopcallback)
		end)
	end

	arg_12_0.costLayer = var_12_0

	return var_12_0
end

function PopLayer.Layer_Drop_List(arg_20_0, arg_20_1)
	local var_20_0 = cc.Layer:create()
	local var_20_1 = 273
	local var_20_2 = -45
	local var_20_3 = 30

	if not arg_20_1.itemListType then
		-- block empty
	end

	local var_20_5 = {}
	local var_20_6 = {}

	if arg_20_1.gold and arg_20_1.gold ~= 0 then
		var_20_5[#var_20_5 + 1] = cc.Label:createWithTTF("", FONT_DES, 22)

		var_20_5[#var_20_5]:setString(L_GOLD .. "X" .. arg_20_1.gold)
	end

	if arg_20_1.diamond and arg_20_1.diamond ~= 0 then
		var_20_5[#var_20_5 + 1] = cc.Label:createWithTTF("", FONT_DES, 22)

		var_20_5[#var_20_5]:setString(L_DIAMOND .. "X" .. arg_20_1.diamond)
	end

	if arg_20_1.equips and #arg_20_1.equips ~= 0 then
		for iter_20_0 = 1, #arg_20_1.equips do
			var_20_5[#var_20_5 + 1] = cc.Label:createWithTTF("", FONT_DES, 22)

			var_20_5[#var_20_5]:setString(var_0_11[arg_20_1.equips[iter_20_0].dropid].name)
		end
	end

	for iter_20_1 = 1, #var_20_5 do
		if config._DEBUG then
			var_20_6[iter_20_1] = cc.Sprite:create("public/panelbg/white_point.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/white_point.png")
		end

		var_20_6[iter_20_1]:setPosition(cc.p(var_20_1 - 20, var_20_2 - (iter_20_1 - 1) * var_20_3 - 13))
		var_20_5[iter_20_1]:setAnchorPoint(cc.p(0, 1))
		var_20_5[iter_20_1]:setPosition(cc.p(var_20_1, var_20_2 - (iter_20_1 - 1) * var_20_3))
		var_20_0:addChild(var_20_6[iter_20_1])
		var_20_0:addChild(var_20_5[iter_20_1])
	end

	return var_20_0
end

function PopLayer:Go_Gain_Diamaond(arg_21_1)
	local var_21_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Cost_confirm_New.json" or "Cost_confirm_New.ExportJson")

	self:addChild(var_21_0)

	local var_21_1 = ccui.Helper:seekWidgetByName(var_21_0, "Label_des")
	local var_21_2 = ccui.Helper:seekWidgetByName(var_21_0, "Image_role")
	local var_21_3 = ccui.Helper:seekWidgetByName(var_21_0, "Panel_bottom")
	local var_21_4 = ccui.Helper:seekWidgetByName(var_21_0, "Image_bottom")
	local var_21_5 = ccui.Helper:seekWidgetByName(var_21_0, "Panel_back")

	local function var_21_6(arg_22_0)
		if arg_22_0.targetlayer ~= nil then
			self:removeSelf(var_21_3)

			if arg_22_0.targetlayer == "TopPlotListLayer" then
				LayerManager:pushInLayer("TopPlotListLayer")
			end

			local var_22_0 = cc.EventCustom:new("switchShowLayer")

			if arg_22_0.targetlayer == "CommandLayer" or arg_22_0.targetlayer == "SmeltLayer" or arg_22_0.targetlayer == "CompoundLabLayer" then
				var_22_0.layerName = "LabLayer"

				require("view.Layer.LabLayer")
				LabLayer:setSwitchLabType(arg_22_0.targetlayer)
			else
				var_22_0.layerName = arg_22_0.targetlayer
			end

			if arg_22_0.targetlayer == "HandOfMidasLayer" and not level_manager:isPlayerPassLevel(UNLOCK_MIDAS) then
				local var_22_1 = math.ceil(UNLOCK_MIDAS / 10)

				global_riseWord("通关第" .. var_22_1 .. "-" .. UNLOCK_MIDAS - 10 * (var_22_1 - 1) .. "关后开启挖矿系统！")
			elseif arg_22_0.targetlayer == "PopSupermarketLayer" then
				LayerManager:pushInLayer("PopSupermarketLayer", {
					callback = arg_22_0.callback
				})
			elseif arg_22_0.targetlayer == "HandOfMidasLayer" then
				sign_manager:createMidasLayer()
			else
				var_22_0.initparam = LayerManager:getActiveLayerName()
				var_22_0.returnLayer = TopcostLayer.runninglayer

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_22_0)
			end
		end

		if arg_22_0.releaselayer then
			arg_22_0.releaselayer:removeSelf()

			arg_22_0.releaselayer = nil
		end

		if arg_22_0.releaseCallback then
			arg_22_0.releaseCallback()
		end
	end

	var_21_5:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_21_3:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			self:removeSelf(var_21_3)
		end)))
	end)
	ccui.Helper:seekWidgetByName(var_21_0, "Button_sure"):addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_21_6(arg_21_1)
	end)
	self:fullScreen(var_21_5, var_21_3)
end

function PopLayer:Go_Init(arg_26_1)
	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Cost_confirm.json" or "Cost_confirm.ExportJson")

	self:addChild(self.Pop)

	local var_26_0 = ccui.Helper:seekWidgetByName(self.Pop, "Panel_45")
	local var_26_1 = ccui.Helper:seekWidgetByName(self.Pop, "panel_bottom")
	local var_26_2 = ccui.Helper:seekWidgetByName(self.Pop, "label_left_time")

	ccui.Helper:seekWidgetByName(self.Pop, "image_catoon"):loadTexture("roleimage/role1/100.png")
	var_26_1:setBackGroundColorOpacity(180)
	var_26_1:setBackGroundColor(cc.c3b(26, 29, 33))
	var_26_1:setAnchorPoint(cc.p(0, 0.5))

	local var_26_3 = cc.EventListenerTouchOneByOne:create()

	var_26_3:setSwallowTouches(false)
	var_26_3:registerScriptHandler(function(arg_27_0, arg_27_1)
		var_26_2:stopAction(seqre)
		self:removeSelf(var_26_1)
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_26_3, var_26_0)
	self:ActionofAccess(var_26_1)
	ccui.Helper:seekWidgetByName(self.Pop, "image_line"):setScale(1, 2)
	ccui.Helper:seekWidgetByName(self.Pop, "label_lack"):setString(arg_26_1.labels.des)
	ccui.Helper:seekWidgetByName(self.Pop, "label_name"):setString(arg_26_1.labels.title)
	ccui.Helper:seekWidgetByName(self.Pop, "label_go"):setString(arg_26_1.labels.button)

	local function var_26_4(arg_28_0)
		if arg_28_0.targetlayer ~= nil then
			self:removeSelf(var_26_1)

			if arg_28_0.targetlayer == "TopPlotListLayer" then
				LayerManager:pushInLayer("TopPlotListLayer")
			end

			if arg_28_0.targetlayer == "PopSupermarketLayer" then
				LayerManager:pushInLayer("PopSupermarketLayer")
			end

			local var_28_0 = cc.EventCustom:new("switchShowLayer")

			if arg_28_0.targetlayer == "CommandLayer" or arg_28_0.targetlayer == "SmeltLayer" or arg_28_0.targetlayer == "CompoundLabLayer" then
				var_28_0.layerName = "LabLayer"

				require("view.Layer.LabLayer")
				LabLayer:setSwitchLabType(arg_28_0.targetlayer)
			else
				var_28_0.layerName = arg_28_0.targetlayer
			end

			if arg_28_0.targetlayer == "HandOfMidasLayer" and not level_manager:isPlayerPassLevel(UNLOCK_MIDAS) then
				local var_28_1 = math.ceil(UNLOCK_MIDAS / 10)

				global_riseWord("通关第" .. var_28_1 .. "-" .. UNLOCK_MIDAS - 10 * (var_28_1 - 1) .. "关后开启挖矿系统！")
			elseif arg_28_0.targetlayer == "HandOfMidasLayer" then
				sign_manager:createMidasLayer(arg_28_0.callback)
			else
				var_28_0.initparam = LayerManager:getActiveLayerName()
				var_28_0.returnLayer = TopcostLayer.runninglayer

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_28_0)
			end
		end

		if arg_28_0.releaselayer then
			arg_28_0.releaselayer:removeFromParent()
		end

		if arg_28_0.releaseCallback then
			arg_28_0.releaseCallback()
		end
	end

	local var_26_5 = 9
	local var_26_6 = cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_26_5 = var_26_5 - 1

		var_26_2:setString("(" .. tostring(var_26_5) .. ")")

		if var_26_5 == 0 then
			var_26_2:stopAction(seqre)
			self:removeSelf(var_26_1)
		end
	end)), 9)

	var_26_2:runAction(var_26_6)
	var_26_1:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_30_0:setTouchEnabled(false)
		var_26_2:stopAction(var_26_6)
		var_26_4(arg_26_1)
	end)
	ccui.Helper:seekWidgetByName(self.Pop, "button_sure"):addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_31_0:setTouchEnabled(false)
		var_26_2:stopAction(var_26_6)
		var_26_4(arg_26_1)
	end)
	self:fullScreen(var_26_0, var_26_1)
	self.Pop:runAction(cc.FadeIn:create(0.2))

	return self.Pop
end

function PopLayer:Do_Init(arg_32_1)
	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_small.json" or "Popup_small.ExportJson")

	local var_32_0 = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")
	local var_32_1 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")
	local var_32_2 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_32_3 = ccui.Helper:seekWidgetByName(self.Pop, "Image_title")
	local var_32_4 = ccui.Helper:seekWidgetByName(self.Pop, "title_des")

	var_32_4:setTextAreaSize(cc.size(var_32_4:getParent():getContentSize().width, 0))
	var_32_4:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_32_4:setAnchorPoint(cc.p(0.5, 1))
	var_32_4:setPositionY(652)

	local var_32_5 = ccui.Helper:seekWidgetByName(self.Pop, "title_more")
	local var_32_6 = ccui.Helper:seekWidgetByName(self.Pop, "label_cost_num_gold")
	local var_32_7 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_32_8 = var_32_7:getChildByName("label")
	local var_32_9 = ccui.Helper:seekWidgetByName(self.Pop, "image_system_figure")

	var_32_7:setPressedActionEnabled(true)
	var_32_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_32_0:setPosition(cc.p(320, 568))
	self:ActionofAccess(var_32_0)
	self:addChild(self.Pop)

	local function var_32_10(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_32_1.cancelcallback then
			arg_32_1.cancelcallback()
		end

		self:removeSelf(var_32_0)
	end

	var_32_1:addTouchEventListener(var_32_10)

	if arg_32_1.labels and arg_32_1.system_figure then
		if arg_32_1.system_figure:find("role1") then
			var_32_9:loadTexture(arg_32_1.system_figure)
		else
			var_32_9:loadTexture(arg_32_1.system_figure, var_0_25)
		end
	else
		var_32_9:setVisible(false)
	end

	if arg_32_1.labels and arg_32_1.labels.titleImage then
		var_32_3:loadTexture("public/panelbg/" .. arg_32_1.labels.titleImage, var_0_25)
		var_32_3:setVisible(true)
		var_32_2:setVisible(false)
	elseif arg_32_1.labels and arg_32_1.labels.title then
		var_32_2:setString(arg_32_1.labels.title)
		var_32_3:setVisible(false)
	else
		var_32_3:setVisible(false)
		var_32_2:setVisible(false)
	end

	if arg_32_1.labels and arg_32_1.labels.des then
		var_32_4:setString(arg_32_1.labels.des)
	else
		var_32_4:setVisible(false)
	end

	if arg_32_1.labels and arg_32_1.labels.button then
		var_32_8:setString(arg_32_1.labels.button)
	end

	if arg_32_1.labels and arg_32_1.labels.more then
		var_32_5:setString(arg_32_1.labels.more)
	else
		var_32_5:setVisible(false)
	end

	if not arg_32_1.cost then
		var_32_6:setVisible(false)
		var_32_8:setFontSize(32)

		local var_32_11, var_32_12 = var_32_8:getPosition()

		var_32_8:setPosition(var_32_11, var_32_12)
	elseif arg_32_1.cost == 0 then
		var_32_6:setString("本次免费")
		var_32_6:setPosition(320, var_32_7:getPositionY() - var_32_7:getContentSize().height / 2 - var_32_6:getContentSize().height / 2)
		var_32_6:getChildByName("image_gold"):setVisible(false)
	else
		local var_32_13 = var_32_6:getChildByName("image_gold")

		if arg_32_1.costtype == "diamond" then
			var_32_13:loadTexture(IMAGE_DIAMOND, var_0_25)
			var_32_6:setString(arg_32_1.cost)
			var_32_13:setScale(1)
			var_32_13:setPosition(cc.p(-(string.len(arg_32_1.cost) * 12) - 5, 14))
		elseif arg_32_1.costtype == "gold" then
			var_32_13:loadTexture(IMAGE_GOLD, var_0_25)
			var_32_6:setString(arg_32_1.cost)
			var_32_13:setScale(1)
			var_32_13:setPosition(cc.p(-(string.len(arg_32_1.cost) * 12) - 5, 14))
		elseif type(arg_32_1.costtype) == "number" then
			var_32_13:loadTexture("public/currency/" .. arg_32_1.costtype .. ".png", var_0_25)
			var_32_13:setScale(0.3)
			var_32_6:setString(arg_32_1.own .. "/" .. arg_32_1.cost)
			var_32_13:setPosition(cc.p(-(string.len(arg_32_1.cost) * 12) - 5, 14))
		end
	end

	if arg_32_1.photo then
		local var_32_14 = ccui.Helper:seekWidgetByName(self.Pop, "bg")
		local var_32_15 = ccui.ImageView:create(arg_32_1.photo, var_0_25)

		var_32_15:setAnchorPoint(cc.p(0.5, 0.5))
		var_32_15:setPosition(cc.p(var_32_14:getContentSize().width / 2, var_32_15:getContentSize().height / 2 + 100))
		var_32_14:addChild(var_32_15)
	end

	if arg_32_1.remaintimes and arg_32_1.remaintimes <= 0 then
		var_32_7:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_25)
		var_32_6:setVisible(false)
		var_32_7:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_NO_TIMES)
		end)
	elseif arg_32_1.cost and arg_32_1.own < arg_32_1.cost and not arg_32_1.ignorecost then
		if arg_32_1.costtype == "diamond" then
			var_32_7:addTouchEventListener(function(arg_35_0, arg_35_1)
				if arg_35_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_32_1.cancelcallback then
					arg_32_1.cancelcallback()
				end

				local var_35_0 = {
					labels = {
						des = L_DIAMOND_LACK .. "，请前往氪金(*^▽^*)"
					},
					is_need_pop_layer = arg_32_1.is_need_pop_layer
				}

				self:removeSelf(var_32_0)
				cc.Director:getInstance():getRunningScene():addChild(PopLayer:Go_New(var_35_0), 999)
			end)
		elseif arg_32_1.costtype == "gold" then
			var_32_7:addTouchEventListener(function(arg_36_0, arg_36_1)
				if arg_36_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_32_1.cancelcallback then
					arg_32_1.cancelcallback()
				end

				cc.Director:getInstance():getRunningScene():addChild(PopLayer:Go_Buy_Gold({
					releaselayer = self
				}), 999)
			end)
		end
	else
		var_32_7:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_37_0:isBright() then
				return
			end

			if arg_37_1 ~= ccui.TouchEventType.ended and arg_32_1.isguide == nil then
				return
			end

			arg_37_0:setBright(false)

			if arg_32_1.surecallback then
				arg_32_1.surecallback()
			end

			self:removeSelf(var_32_0)
		end)
	end

	if arg_32_1.other_bnt then
		local var_32_16 = var_32_7:clone()

		var_32_16:loadTextures(arg_32_1.other_bnt, nil, arg_32_1.other_bnt, var_0_25)
		var_32_16:setPositionX(200)
		var_32_16:setContentSize(cc.size(200, 80))
		var_32_16:getChildByName("label"):setString("取消")
		var_32_16:getChildByName("label"):setPosition(var_32_16:getContentSize().width / 2, var_32_16:getContentSize().height / 2)
		var_32_7:getParent():addChild(var_32_16)
		var_32_16:addTouchEventListener(var_32_10)
		var_32_7:setContentSize(cc.size(200, 80))
		var_32_7:setPositionX(440)
		var_32_8:setPosition(var_32_7:getContentSize().width / 2, var_32_7:getContentSize().height / 2)
	end

	local var_32_17, var_32_18 = var_32_0:getPosition()

	var_32_0:setPosition(var_32_17, var_32_18 + var_0_24)
	self.Pop:setOpacity(0)
	self.Pop:runAction(cc.FadeTo:create(0.2, 255))
	var_32_0:runAction(cc.MoveTo:create(0.2, cc.p(var_32_17, var_32_18)))
	self:fullScreen(var_32_1, var_32_0)

	return self.Pop
end

function PopLayer:Gain_Init(arg_38_1)
	audio_manager:playeffectMusic(GET_AWARDS)

	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_Gain.json" or "Pop_Gain.ExportJson")

	local var_38_0 = ccui.Helper:seekWidgetByName(self.Pop, "Panel_Back")

	var_38_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_38_0:setPosition(cc.p(320, 568))
	self:ActionofAccess(var_38_0)
	self.Pop:setOpacity(0)
	self:addChild(self.Pop)

	local var_38_1 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")
	local var_38_2 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_38_3 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_38_4 = var_38_3:getChildByName("label")
	local var_38_5 = ccui.Helper:seekWidgetByName(self.Pop, "image_system_figure")

	var_38_0:getChildByName("Image_15"):setVisible(false)

	if arg_38_1.backcallback then
		local var_38_7 = var_38_3:clone()

		var_38_7:getChildByName("label"):setString("继续冒险")
		var_38_7:setPositionX(var_38_3:getPositionX() - var_38_3:getContentSize().width - 20)
		var_38_7:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_38_1.backcallback()
			self:removeSelf(var_38_0)
		end)
		self.Pop:addChild(var_38_7, 10)
	end

	if arg_38_1.labels and arg_38_1.labels.des then
		local var_38_8 = var_38_0:getChildByName("bg")
		local var_38_9 = cc.Label:createWithTTF(arg_38_1.labels.des, FONT_DES, 30)

		var_38_9:setAnchorPoint(cc.p(0.5, 0.5))
		var_38_9:setPosition(cc.p(var_38_8:getContentSize().width / 2, var_38_8:getContentSize().height / 2))
		var_38_8:addChild(var_38_9)
	end

	if arg_38_1.system_figure ~= nil then
		var_38_5:loadTexture(arg_38_1.system_figure, var_0_25)
	else
		var_38_5:setVisible(false)
	end

	if arg_38_1.eatable_attr then
		local var_38_10 = {
			taste = "味",
			sweet = "甜",
			hot = "辣",
			salty = "咸",
			color = "色",
			smell = "香",
			sour = "酸"
		}
		local var_38_11 = {
			taste = 7,
			sweet = 4,
			hot = 6,
			salty = 8,
			color = 3,
			smell = 5,
			sour = 2
		}
		local var_38_12 = 70
		local var_38_13 = 680
		local var_38_14 = cc.Label:createWithTTF("总分: " .. cook_manager:getEatableScore(arg_38_1.items[1].entityid), FONT_DES, 22)

		var_38_14:setAnchorPoint(cc.p(0, 0.5))
		var_38_14:setPosition(cc.p(var_38_12, var_38_13))
		self.Pop:addChild(var_38_14, 5)

		for iter_38_0, iter_38_1 in pairs(arg_38_1.eatable_attr) do
			local var_38_15 = cc.Label:createWithTTF("", FONT_DES, 22)

			if iter_38_0 == "color" or iter_38_0 == "smell" or iter_38_0 == "taste" then
				var_38_15:setString(var_38_10[iter_38_0] .. ": " .. iter_38_1 .. "/" .. var_0_11[playermodel.items[arg_38_1.items[1].entityid].itemid]["max_" .. iter_38_0])
			else
				var_38_15:setString(var_38_10[iter_38_0] .. ": " .. iter_38_1)
			end

			var_38_15:setAnchorPoint(cc.p(0, 0.5))
			var_38_15:setPosition(cc.p(var_38_12 + 450 * ((var_38_11[iter_38_0] + 1) % 2), var_38_13 - math.floor((var_38_11[iter_38_0] - 1) / 2) * (var_38_15:getContentSize().height + 20)))
			self.Pop:addChild(var_38_15, 5)
		end
	end

	if arg_38_1.labels and arg_38_1.labels.title then
		var_38_2:setString(arg_38_1.labels.title)
	end

	if arg_38_1.labels and arg_38_1.labels.button then
		var_38_4:setString(arg_38_1.labels.button)
	end

	var_38_3:addTouchEventListener(function(arg_40_0, arg_40_1)
		if not arg_40_0:isBright() then
			return
		end

		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_40_0:setBright(false)

		if arg_38_1.surecallback then
			arg_38_1.surecallback()
		end

		self:removeSelf(var_38_0)
	end)
	var_38_1:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_38_1.cancelcallback then
			arg_38_1.cancelcallback()
		end

		self:removeSelf(var_38_0)
	end)
	self.Pop:runAction(cc.FadeIn:create(0.25))
	var_38_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1), cc.ScaleTo:create(0.1, 1)))

	if arg_38_1.poptype and arg_38_1.poptype == "pass" and self then
		self:removeSelf(var_38_0)

		if arg_38_1.surecallback then
			arg_38_1.surecallback()
		end
	end

	self:fullScreen(var_38_1, var_38_0)

	return self.Pop
end

function PopLayer:Layer_Gain_List(arg_42_1)
	local var_42_0 = cc.Layer:create()
	local var_42_1 = 0
	local var_42_2 = 140
	local var_42_3 = 140
	local var_42_4 = 1
	local var_42_5 = {}

	if arg_42_1.gold then
		local var_42_6 = tonumber(arg_42_1.gold)

		if var_42_6 and var_42_6 > 0 then
			var_42_4 = var_42_4 + 1

			table.insert(var_42_5, {
				itemtype = "gold",
				entityid = "gold",
				addNumber = var_42_6,
				name = L_GOLD
			})
		end
	end

	if arg_42_1.diamond and arg_42_1.diamond > 0 then
		var_42_4 = var_42_4 + 1

		table.insert(var_42_5, {
			itemtype = "diamond",
			entityid = "diamond",
			addNumber = arg_42_1.diamond,
			name = L_DIAMOND
		})
	end

	if arg_42_1.honor and arg_42_1.honor > 0 then
		var_42_4 = var_42_4 + 1

		table.insert(var_42_5, {
			itemtype = "honor",
			name = "荣誉点",
			entityid = "honor",
			addNumber = arg_42_1.honor
		})
	end

	if arg_42_1.explorecoin and arg_42_1.explorecoin > 0 then
		var_42_4 = var_42_4 + 1

		table.insert(var_42_5, {
			itemtype = "explorecoin",
			name = "探险币",
			entityid = "explorecoin",
			addNumber = arg_42_1.explorecoin
		})
	end

	if arg_42_1.sp and arg_42_1.sp > 0 then
		var_42_4 = var_42_4 + 1

		table.insert(var_42_5, {
			itemtype = "strengthpoint",
			name = "科技点",
			entityid = "strengthpoint",
			addNumber = arg_42_1.sp
		})
	end

	if arg_42_1.energy and arg_42_1.energy > 0 then
		var_42_4 = var_42_4 + 1

		table.insert(var_42_5, {
			itemtype = "energy",
			name = "能量",
			entityid = "energy",
			addNumber = arg_42_1.energy
		})
	end

	if arg_42_1.postcard and arg_42_1.postcard ~= -1 then
		var_42_4 = var_42_4 + 1

		table.insert(var_42_5, {
			itemtype = "postcard",
			name = "明信片",
			addNumber = 1,
			entityid = arg_42_1.postcard
		})
	end

	if arg_42_1.items then
		for iter_42_0, iter_42_1 in pairs(arg_42_1.items) do
			var_42_4 = var_42_4 + 1

			local var_42_7

			if iter_42_1.itemid then
				var_42_7 = var_0_11[iter_42_1.itemid].equip_quality
			elseif iter_42_1.entityid then
				var_42_7 = var_0_11[playermodel.items[iter_42_1.entityid] and playermodel.items[iter_42_1.entityid].itemid].equip_quality
			end

			table.insert(var_42_5, {
				itemid = iter_42_1.itemid,
				itemtype = iter_42_1.dropid,
				entityid = iter_42_1.entityid,
				addNumber = iter_42_1.dropNum,
				name = iter_42_1.name,
				quality = var_42_7
			})
		end
	end

	table.sort(var_42_5, function(arg_43_0, arg_43_1)
		if not arg_43_0.quality then
			return false
		end

		if not arg_43_1.quality then
			return false
		end

		return arg_43_0.quality > arg_43_1.quality
	end)

	local var_42_9 = 600
	local var_42_10 = 320
	local var_42_11 = ccui.ScrollView:create()

	var_42_11:setContentSize(cc.size(600, 320))
	var_42_11:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_11:setPosition(cc.p(0, 0))
	var_42_11:setDirection(ccui.ScrollViewDir.horizontal)

	if var_42_4 > 4 then
		var_42_11:setInnerContainerSize(cc.size(var_42_3 * (var_42_4 - 1), var_42_10))
		var_42_11:setBounceEnabled(true)
		ccui.Helper:seekWidgetByName(self.Pop, "more_label"):setVisible(true)
	else
		var_42_11:setInnerContainerSize(cc.size(var_42_9, var_42_10))
		var_42_11:setBounceEnabled(false)
	end

	var_42_0:addChild(var_42_11)

	local var_42_12 = ccui.Layout:create()

	if var_42_4 > 4 then
		var_42_12:setPosition(cc.p(0, var_42_10 / 2))
		var_42_12:setContentSize(cc.size(var_42_3 * (var_42_4 - 1), var_42_10))

		var_42_1 = var_42_3 * (var_42_4 - 1) / 2
	else
		var_42_12:setPosition(cc.p(0, var_42_10 / 2))
		var_42_12:setContentSize(cc.size(var_42_9, var_42_10))

		var_42_1 = var_42_9 / 2
	end

	var_42_12:setAnchorPoint(cc.p(0, 0.5))
	var_42_11:addChild(var_42_12)

	for iter_42_2 = 1, var_42_4 - 1 do
		local var_42_14 = var_42_1 + var_42_3 * (iter_42_2 - var_42_4 / 2)

		if var_42_4 > 4 then
			var_42_14 = var_42_3 * (iter_42_2 - 1) + var_42_3 / 2
		end

		local var_42_15

		if var_42_5[iter_42_2].entityid then
			if var_42_5[iter_42_2].itemtype == "postcard" then
				var_42_15 = ccui.ImageView:create("mainScenebg/postcard/" .. postcard_data[var_42_5[iter_42_2].entityid].image .. ".png")
				var_42_15.postcard = true

				var_42_15:setScale(150 / var_42_15:getContentSize().height)
			else
				var_42_15 = ItemSprite:createBigWithEntityId(var_42_5[iter_42_2].entityid, var_42_5[iter_42_2].addNumber)
				var_42_15.itemid = var_42_5[iter_42_2].itemid and var_42_5[iter_42_2].itemid or playermodel.items[var_42_5[iter_42_2].entityid] and playermodel.items[var_42_5[iter_42_2].entityid].itemid
				var_42_15.entityid = var_42_5[iter_42_2].entityid

				var_42_15:setScale(0.75)
			end

			if var_42_15:getChildByName("use") then
				var_42_15:getChildByName("use"):setVisible(false)
			end
		elseif var_42_5[iter_42_2].itemid then
			if var_42_5[iter_42_2].itemtype == "postcard" then
				var_42_15 = ccui.ImageView:create("mainScenebg/postcard/" .. postcard_data[postcardId].image .. ".png")
				var_42_15.postcard = true

				var_42_15:setScale(150 / p_img:getContentSize().height)
			else
				var_42_15 = ItemSprite:createNewWithItemId(var_42_5[iter_42_2].itemid, var_42_5[iter_42_2].addNumber)
				var_42_15.itemid = var_42_5[iter_42_2].itemid

				var_42_15:setScale(0.7)
			end
		end

		var_42_15:setAnchorPoint(cc.p(0.5, 0.5))
		var_42_15:setPosition(var_42_14, var_42_2)
		var_42_12:addChild(var_42_15, 1)

		local var_42_17

		if var_42_15.itemid and var_0_11[var_42_15.itemid] then
			var_42_17 = var_0_11[var_42_15.itemid].bag_item_type
		end

		if not var_42_17 or var_42_17 ~= kITEM_HERO then
			if var_42_17 and var_42_17 == kITEM_SKIN then
				var_42_5[iter_42_2].addNumber = 1

				require("view.Layer.GetRoleAnimationLayer")
				cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_42_5[iter_42_2].itemid or var_42_5[iter_42_2].entityid), 1000)
			end
		end

		local var_42_19 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_25)

		var_42_19:setContentSize(cc.size(var_42_15:getContentSize().width, var_42_15:getContentSize().height))
		var_42_19:setPosition(cc.p(var_42_15:getContentSize().width / 2, var_42_15:getContentSize().height / 2))
		var_42_19:setAnchorPoint(cc.p(0.5, 0.5))
		var_42_19:setTouchEnabled(true)
		var_42_19:setSwallowTouches(false)
		var_42_15:addChild(var_42_19)
		var_42_19:addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_44_0:getParent():convertToWorldSpace(arg_44_0:getTouchEndPosition()).x - arg_44_0:getParent():convertToWorldSpace(arg_44_0:getTouchBeganPosition()).x) > 50 then
				return
			end

			showItemDetails(var_42_15.itemid, var_42_15.entityid)
		end)
	end

	return var_42_0, var_42_4
end

function PopLayer:Go_Gain_Init(arg_45_1)
	require("view.Sprite.ItemSprite")

	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Go_Gain.json" or "Go_Gain.ExportJson")

	local var_45_0 = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")
	local var_45_1 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")
	local var_45_2 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_45_3 = ccui.Helper:seekWidgetByName(self.Pop, "img_item")
	local var_45_4 = ccui.Helper:seekWidgetByName(self.Pop, "label_name")
	local var_45_5 = ccui.Helper:seekWidgetByName(self.Pop, "listview")
	local var_45_6 = ccui.Helper:seekWidgetByName(self.Pop, "button_go")

	var_45_6:setVisible(false)
	var_45_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_45_0:setPosition(cc.p(320, 568))
	var_45_5:setPositionX(5)
	var_45_5:setItemsMargin(18)
	self:addChild(self.Pop)
	self:ActionofAccess(var_45_0)
	var_45_1:addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_45_1.cancelcallback then
			arg_45_1.cancelcallback()
		end

		self:removeSelf(var_45_0)
	end)

	local var_45_7
	local var_45_8

	if not arg_45_1.item then
		arg_45_1.item = 1000000

		print("msg.item is nil")
	end

	if arg_45_1.item == "gold" then
		var_45_3:loadTexture("equipment/1000001.png")
		var_45_3:setScale(128 / var_45_3:getContentSize().width)
	elseif arg_45_1.item == "horcrux" then
		var_45_3:loadTexture("roleimage/role1/51305.png")
		var_45_3:setScale(220 / var_45_3:getContentSize().width)

		var_45_8 = cc.p(255, 375)

		cc.p(0.5, 0)
	elseif var_0_11[arg_45_1.item].bag_item_type == kITEM_HORCRUX then
		var_45_3:loadTexture("roleimage/role1/" .. model_data[var_0_11[arg_45_1.item].model].cute_Q .. ".png")
		var_45_3:setScale(220 / var_45_3:getContentSize().width)

		var_45_8 = cc.p(255, 375)

		cc.p(0.5, 0)
	elseif var_0_11[arg_45_1.item].bag_item_type == kITEM_SKIN then
		var_45_3:loadTexture("roleimage/role/wuji/" .. model_data[var_0_11[arg_45_1.item].model].head_image .. ".png")
		var_45_3:setScale(256 / var_45_3:getContentSize().width)
	elseif var_0_11[arg_45_1.item].bag_item_type == kITEM_HERO then
		var_45_3:loadTexture("roleimage/role/wuji/" .. model_data[servant_data[var_0_11[arg_45_1.item].servant].modelid].head_image .. ".png")
		var_45_3:setScale(256 / var_45_3:getContentSize().width)
	elseif var_0_11[arg_45_1.item].bag_item_type == kITEM_COMPONENT then
		var_45_3:setVisible(false)

		local var_45_9 = component_manager:create_component_icon(arg_45_1.item)

		var_45_9:setPosition(cc.p(var_45_3:getPositionX(), (var_45_3:getPositionY())))
		var_45_0:getChildByName("bg"):addChild(var_45_9)
	elseif var_0_11[arg_45_1.item].bag_item_type == 91 then
		local var_45_10 = ItemSprite:createNewWithItemId(arg_45_1.item, nil, "diamond")

		var_45_10:setScale(0.5)
		var_45_10:setPosition(cc.p(var_45_3:getPositionX(), var_45_3:getPositionY()))
		var_45_3:setVisible(false)
		var_45_0:getChildByName("bg"):addChild(var_45_10)
	elseif var_0_11[arg_45_1.item].bag_item_type == kITEM_WEAPON then
		print("itemData[msg.item].id =", arg_45_1.item)
		var_45_3:loadTexture("equipment/" .. var_0_11[arg_45_1.item].image_id .. ".png")
		var_45_3:setScale(156 / var_45_3:getContentSize().width)
	else
		print("itemData[msg.item].id =", arg_45_1.item)
		var_45_3:loadTexture("equipment/" .. var_0_11[arg_45_1.item].image_id .. ".png")
		var_45_3:setScale(128 / var_45_3:getContentSize().width)
	end

	var_45_4:setString(arg_45_1.itemName or var_0_11[arg_45_1.item].name)

	if arg_45_1.labels and arg_45_1.labels.title then
		var_45_2:setString(arg_45_1.labels.title)
	end

	if var_45_7 then
		var_45_3:setAnchorPoint(var_45_7)
	end

	if var_45_8 then
		var_45_3:setPosition(var_45_8)
	end

	local var_45_11 = var_45_6
	local var_45_12 = {}

	for iter_45_0, iter_45_1 in pairs(arg_45_1.methods) do
		var_45_12[iter_45_0] = var_45_11:clone()

		var_45_12[iter_45_0]:setVisible(true)
		var_45_5:pushBackCustomItem(var_45_12[iter_45_0])
		var_45_12[iter_45_0]:getChildByName("label_method"):setString(iter_45_1.des)
		var_45_12[iter_45_0]:addTouchEventListener(function(arg_47_0, arg_47_1)
			if arg_47_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_47_0:getTouchBeganPosition().y - arg_47_0:getTouchEndPosition().y) > 50 then
				return
			end

			arg_47_0:setTouchEnabled(false)
			self:removeSelf(var_45_0)

			if arg_45_1.surecallback then
				arg_45_1.surecallback(iter_45_1.targetlayer)
			end

			if iter_45_1.targetlayer == "ShareLayer" then
				global_ShowBlockWords("暂不开放分享系统~~")
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				local var_47_0 = cc.EventCustom:new("switchShowLayer")

				if iter_45_1.targetlayer == "CommandLayer" or iter_45_1.targetlayer == "SmeltLayer" or iter_45_1.targetlayer == "CompoundLabLayer" then
					var_47_0.layerName = "LabLayer"

					require("view.Layer.LabLayer")
					LabLayer:setSwitchLabType(iter_45_1.targetlayer)
				else
					var_47_0.layerName = iter_45_1.targetlayer
				end

				if iter_45_1.targettype then
					local var_47_1

					if iter_45_1.targetlayer == "MarketLayer" then
						var_47_1 = {
							shoptype = iter_45_1.targettype,
							returnLayer = iter_45_1.returnlayer
						}
					elseif iter_45_1.targetlayer == "InstanceLayer" then
						global_ShowBlockWords("暂不开放副本系统~~")
						audio_manager:playeffectMusicTest("sound/invalid")

						return
					end

					var_47_0.initparam = var_47_1
				end

				require("controller.goto_system_manager")

				systemId = tonumber(iter_45_1.systemid)

				if systemId == 130 then
					sign_manager:createSignLayer()
				elseif systemId == 111 then
					LayerManager:pushInLayer("HandOfMidasLayer", {
						callback = iter_45_1.callback
					})
				else
					local var_47_2 = {
						jump_to_system = systemId,
						cur_system_id = arg_45_1.goto_back_system_id
					}

					var_47_2.config = system_jump_config[SYSTEMID[systemId]] and system_jump_config[SYSTEMID[systemId]].config

					if var_47_0.initparam then
						var_47_2.config = var_47_0.initparam
					end

					if arg_45_1.goto_back_system_id and var_47_2.config and (not system_jump_config[SYSTEMID[arg_45_1.goto_back_system_id]] or not system_jump_config[SYSTEMID[arg_45_1.goto_back_system_id]].popLayer) then
						if var_47_2.config.exitCallbackType == "function" then
							var_47_2.config.exitCallback = createExitCallback({
								jump_to_system = arg_45_1.goto_back_system_id,
								cur_system_id = arg_45_1.goto_back_system_id,
								config = arg_45_1.goto_back_system_config
							})
						end

						if var_47_2.config.exitCallbackType == "string" then
							var_47_2.config = SYSTEMID[arg_45_1.goto_back_system_id]
						end
					end

					goto_complete_system(var_47_2)
				end
			end
		end)
	end

	self:fullScreen(var_45_1, var_45_0)

	return self.Pop
end

function PopLayer:Show_Init(arg_48_1)
	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_large.json" or "Popup_large.ExportJson")

	self:addChild(self.Pop)
	self.Pop:runAction(cc.CallFunc:create(function()
		return
	end))

	local var_48_0 = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")
	local var_48_1 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")

	var_48_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_48_1:setPosition(cc.p(320, 568))

	local function var_48_2(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_48_1.cancelcallback then
			arg_48_1.cancelcallback()
		end

		self:removeSelf(var_48_1)
	end

	var_48_0:addTouchEventListener(var_48_2)

	local var_48_3 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_48_4 = ccui.Helper:seekWidgetByName(self.Pop, "title_des")
	local var_48_5 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_48_6 = ccui.Helper:seekWidgetByName(self.Pop, "label_cost_num_gold")
	local var_48_7 = ccui.Helper:seekWidgetByName(self.Pop, "image_system_figure")
	local var_48_8 = ccui.Helper:seekWidgetByName(self.Pop, "bg")

	var_48_5:setPressedActionEnabled(true)
	ccui.Helper:seekWidgetByName(self.Pop, "button_close"):addTouchEventListener(var_48_2)

	if arg_48_1.labels and arg_48_1.labels.title then
		var_48_3:setString(arg_48_1.labels.title)
	end

	if arg_48_1.labels and arg_48_1.labels.button then
		ccui.Helper:seekWidgetByName(var_48_5, "label"):setString(arg_48_1.labels.button)
	end

	if arg_48_1.labels and arg_48_1.labels.des then
		if type(arg_48_1.labels.des) == "table" then
			local var_48_9 = 120
			local var_48_10 = 250

			if arg_48_1.intx1 then
				var_48_9 = arg_48_1.intx1
			end

			if arg_48_1.intx2 then
				var_48_10 = arg_48_1.intx2
			end

			var_48_4:setVisible(false)

			local var_48_11

			if arg_48_1.scroll == true then
				var_48_11 = ccui.ListView:create()

				var_48_11:setAnchorPoint(cc.p(0.5, 0.5))
				var_48_11:setPosition(cc.p(var_48_8:getContentSize().width / 2 + 20, var_48_8:getContentSize().height / 2 - 50))
				var_48_11:setContentSize(cc.size(var_48_8:getContentSize().width, var_48_8:getContentSize().height - 200))
				var_48_11:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
				var_48_11:setBounceEnabled(true)
				var_48_11:setItemsMargin(25)
				var_48_8:addChild(var_48_11, 10)

				local var_48_12 = var_48_4:clone()

				var_48_12:setString("滑动显示更多")
				var_48_12:setVisible(true)
				var_48_12:setColor(RISE_WORDS_WARNING)
				var_48_8:addChild(var_48_12, 10)
				var_48_12:setPosition(cc.p(var_48_8:getContentSize().width - var_48_12:getContentSize().width - 20, var_48_12:getContentSize().height / 2 + 15))
			end

			for iter_48_0, iter_48_1 in ipairs(arg_48_1.labels.des.key) do
				if arg_48_1.scroll == true then
					local var_48_13 = var_48_4:clone()

					var_48_13:setVisible(true)
					var_48_13:setPosition(cc.p(var_48_9, var_48_13:getContentSize().height / 2))
					var_48_13:setString(iter_48_1)

					local var_48_14

					if arg_48_1.labels.des.value[iter_48_0] then
						var_48_14 = var_48_4:clone()

						var_48_14:setVisible(true)
						var_48_14:setPosition(cc.p(var_48_10, var_48_14:getContentSize().height / 2))
						var_48_14:setString(arg_48_1.labels.des.value[iter_48_0])
					end

					local var_48_15 = ccui.Layout:create()

					var_48_15:setContentSize(cc.size(var_48_8:getContentSize().width, var_48_13:getContentSize().height))
					var_48_15:setAnchorPoint(cc.p(0.5, 0.5))
					var_48_15:addChild(var_48_13)
					var_48_15:addChild(var_48_14)
					var_48_11:pushBackCustomItem(var_48_15)
				else
					local var_48_16 = var_48_4:clone()

					var_48_16:setVisible(true)
					var_48_16:setPosition(cc.p(var_48_9, 800 - (iter_48_0 - 1) * 50))
					var_48_16:setString(iter_48_1)
					var_48_0:addChild(var_48_16)

					if arg_48_1.labels.des.value[iter_48_0] then
						local var_48_17 = var_48_4:clone()

						var_48_17:setVisible(true)
						var_48_17:setPosition(cc.p(var_48_10, 800 - (iter_48_0 - 1) * 50))
						var_48_17:setString(arg_48_1.labels.des.value[iter_48_0])
						var_48_0:addChild(var_48_17)
					end

					if arg_48_1.labels.des.more[L_SHOW_ROLE_INFO_1[iter_48_0]] then
						local var_48_18 = cc.Label:createWithTTF(arg_48_1.labels.des.more[L_SHOW_ROLE_INFO_1[iter_48_0]], FONT_DES, 16)

						var_48_18:setTextColor(cc.c4b(255, 188, 79, 255))
						var_48_18:setAnchorPoint(cc.p(0, 0))
						var_48_18:setPosition(cc.p(var_48_9 + var_48_16:getContentSize().width, 800 - (iter_48_0 - 1) * 50))
						var_48_0:addChild(var_48_18, 10)
					end
				end
			end

			local var_48_19 = ccui.Layout:create()

			var_48_19:setVisible(true)
			var_48_19:setPosition(cc.p(26, 620))
			var_48_19:setContentSize(550, 30)
			var_48_19:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_48_19:setCascadeOpacityEnabled(true)
			var_48_19:setBackGroundColorOpacity(180)
			var_48_19:setBackGroundColor(cc.c3b(48, 83, 163))
			var_48_8:addChild(var_48_19, 10)

			myAward_Label = cc.Label:createWithTTF("", FONT_DES, 20)

			myAward_Label:setContentSize(cc.size(600, 30))

			if arg_48_1.honor and arg_48_1.diamond then
				myAward_Label:setString("荣誉点：" .. arg_48_1.honor .. "      " .. L_DIAMOND .. "：" .. arg_48_1.diamond)
			elseif arg_48_1.honor and not arg_48_1.diamond then
				myAward_Label:setString("荣誉点：" .. arg_48_1.honor)
			elseif not arg_48_1.honor and not arg_48_1.diamond then
				myAward_Label:setString("未获奖励，继续加油")
			end

			myAward_Label:setAnchorPoint(cc.p(0, 0))
			myAward_Label:setPosition(cc.p(50, 625))
			var_48_8:addChild(myAward_Label, 15)
		else
			var_48_4:setString(arg_48_1.labels.des)
		end
	end

	if arg_48_1.labels and arg_48_1.labels.info then
		print(":::::::", arg_48_1.labels.info)

		local var_48_20 = ccui.Helper:seekWidgetByName(self.Pop, "title_more"):clone()

		var_48_20:setString(arg_48_1.labels.info)
		var_48_20:setAnchorPoint(cc.p(0.5, 0.5))
		var_48_20:setPosition(var_48_3:getPositionX(), 870)
		var_48_20:setVisible(true)
		var_48_1:addChild(var_48_20)
	end

	if arg_48_1.system_figure then
		var_48_7:loadTexture(arg_48_1.system_figure, var_0_25)
	else
		var_48_7:setVisible(false)
	end

	if arg_48_1.cost then
		var_48_6:setVisible(true)
		var_48_6:setString(arg_48_1.cost.num)
		var_48_6:getChildByName("image_gold"):loadTexture(arg_48_1.cost.type, var_0_25)
	else
		var_48_6:setVisible(false)
	end

	var_48_5:addTouchEventListener(function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_51_0:isBright() then
			return
		end

		arg_51_0:setBright(false)

		if arg_48_1.surecallback then
			arg_48_1.surecallback()
		end

		self:removeSelf(var_48_1)
	end)
	self:ActionofAccess(var_48_1)
	self:fullScreen(var_48_0, var_48_1)

	return self.Pop
end

function PopLayer.Show_roleinfo(arg_52_0, arg_52_1)
	local var_52_0 = PopLayer.new()
	local var_52_1 = {}

	if arg_52_1 then
		var_52_1 = arg_52_1
	end

	local var_52_2 = {
		1,
		1,
		1,
		0.05,
		0.1,
		0.1,
		0.1,
		0.005,
		0.02,
		0.02
	}

	var_52_1.labels = {}
	var_52_1.labels.title = "属性说明"
	var_52_1.labels.des = {}
	var_52_1.labels.des.key = {}
	var_52_1.labels.des.value = {}
	var_52_1.labels.des.more = {}

	for iter_52_0 = 1, 10 do
		if iter_52_0 < 3 then
			table.insert(var_52_1.labels.des.key, L_SHOW_ROLE_INFO_1[iter_52_0] .. ":" .. var_52_1.des_value[iter_52_0][1])
			table.insert(var_52_1.labels.des.value, global_trans_number(playermodel.basicmodel.science_point) .. "科技值×" .. var_52_1.des_value[iter_52_0][2] .. L_SHOW_ROLE_INFO_2[iter_52_0])
		elseif iter_52_0 == 3 then
			table.insert(var_52_1.labels.des.key, L_SHOW_ROLE_INFO_1[iter_52_0] .. ":" .. var_52_1.des_value[iter_52_0])
			table.insert(var_52_1.labels.des.value, L_SHOW_ROLE_INFO_2[iter_52_0] .. var_52_1.des_value[iter_52_0] .. "次")
		elseif iter_52_0 == 4 then
			table.insert(var_52_1.labels.des.key, L_SHOW_ROLE_INFO_1[iter_52_0] .. ":" .. var_52_1.des_value[iter_52_0])
			table.insert(var_52_1.labels.des.value, "-" .. var_52_1.des_value[iter_52_0] * var_52_2[iter_52_0] .. "%" .. L_SHOW_ROLE_INFO_2[iter_52_0])
		else
			table.insert(var_52_1.labels.des.key, L_SHOW_ROLE_INFO_1[iter_52_0] .. ":" .. var_52_1.des_value[iter_52_0])
			table.insert(var_52_1.labels.des.value, "+" .. var_52_1.des_value[iter_52_0] * var_52_2[iter_52_0] .. "%" .. L_SHOW_ROLE_INFO_2[iter_52_0])
		end

		local var_52_3 = L_SHOW_ROLE_INFO_1[iter_52_0]

		if L_SHOW_ROLE_INFO_3[L_SHOW_ROLE_INFO_1[iter_52_0]] then
			var_52_1.labels.des.more[var_52_3] = L_SHOW_ROLE_INFO_3[var_52_3]
		end
	end

	if var_52_1.componentEffect then
		for iter_52_1, iter_52_2 in ipairs(var_52_1.componentEffect) do
			table.insert(var_52_1.labels.des.key, iter_52_2)
		end
	end

	var_52_0:Show_Init(var_52_1)

	return var_52_0
end

function PopLayer.Show_arenaInfo(arg_53_0, arg_53_1)
	local var_53_0 = PopLayer.new()
	local var_53_1 = {}

	if arg_53_1 then
		var_53_1 = arg_53_1
	end

	var_53_1.labels.title = "奖励说明"
	var_53_1.labels.info = "竞技场奖励每周一0点根据排名结算"
	var_53_1.scroll = true

	var_53_0:Show_Init(var_53_1)

	return var_53_0
end

function PopLayer:Upgrade_COST_Init(arg_54_1)
	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Jinjie.json" or "Jinjie.ExportJson")

	self:addChild(self.Pop)

	local var_54_0 = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")
	local var_54_1 = ccui.Helper:seekWidgetByName(self.Pop, "panel_upgrade")
	local var_54_2 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_54_3 = ccui.Helper:seekWidgetByName(self.Pop, "panel_cost")
	local var_54_4 = ccui.Helper:seekWidgetByName(var_54_3, "label_cost_num_gold")
	local var_54_5 = ccui.Helper:seekWidgetByName(var_54_3, "equip_4")
	local var_54_6 = ccui.Helper:seekWidgetByName(self.Pop, "Button_25")
	local var_54_7 = ccui.Helper:seekWidgetByName(self.Pop, "label_intro")
	local var_54_8 = ccui.Helper:seekWidgetByName(self.Pop, "panel_intro")

	var_54_2:setPressedActionEnabled(true)
	var_54_2:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", var_0_25)
	var_54_2:getChildByName("Label_21"):setPositionY(var_54_2:getContentSize().height / 2 - 5)

	local var_54_9

	if arg_54_1.costDes then
		ccui.Helper:seekWidgetByName(self.Pop, "Label_costDes"):setString(arg_54_1.costDes)
	end

	if arg_54_1.surecallback2 then
		var_54_2:setContentSize(cc.size(200, 80))
		var_54_2:setPositionX(460)
		var_54_2:getChildByName("Label_21"):setPositionX(var_54_2:getContentSize().width / 2)

		var_54_9 = ccui.Button:create("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_big_blue_y.png", var_0_25)

		local var_54_10 = cc.Label:createWithTTF(arg_54_1.bnt2str or "取 消", FONT_BUTTON, 28)

		var_54_10:setPositionX(var_54_9:getContentSize().width / 2 + 2)
		var_54_10:setPositionY(var_54_9:getContentSize().height / 2 + 4)
		var_54_10:setColor(cc.c3b(55, 55, 55))
		var_54_9:setScale(0.9)
		var_54_9:setPositionX(180)
		var_54_9:setPositionY(var_54_2:getPositionY())
		var_54_9:addChild(var_54_10)
		var_54_0:addChild(var_54_9)
	end

	var_54_8:getChildByName("value_new"):setVisible(false)
	var_54_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_54_0:setPosition(cc.p(320, 568))
	var_54_4:setVisible(false)
	var_54_5:setVisible(false)
	var_54_7:setVisible(false)
	var_54_4:setPositionX(var_54_2:getPositionX() - 283)

	if arg_54_1.title then
		ccui.Helper:seekWidgetByName(self.Pop, "title"):setString(arg_54_1.title)
	end

	if arg_54_1.bntstr then
		var_54_2:getChildByName("Label_21"):setString(arg_54_1.bntstr)
	else
		var_54_2:setVisible(false)
	end

	self:ActionofAccess(var_54_0)

	local function var_54_11(arg_55_0, arg_55_1)
		if arg_55_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_54_1.cancelcallback then
			arg_54_1.cancelcallback()
		end

		self:removeSelf(var_54_0)
	end

	var_54_1:addTouchEventListener(var_54_11)
	var_54_6:addTouchEventListener(var_54_11)
	var_54_4:setPositionX(0)

	if arg_54_1.gold_cost then
		var_54_4:setVisible(true)
		var_54_4:setString(global_trans_number(arg_54_1.gold_cost))
	end

	if arg_54_1.energy_cost then
		var_54_4:setVisible(true)
		var_54_4:setString(var_54_4:getString() .. " 能量:" .. arg_54_1.energy_cost)
	end

	if arg_54_1.cost_icon_path then
		if string.find(arg_54_1.cost_icon_path, "equipment/") then
			ccui.Helper:seekWidgetByName(var_54_4, "image_gold"):loadTexture(arg_54_1.cost_icon_path)
		else
			ccui.Helper:seekWidgetByName(var_54_4, "image_gold"):loadTexture("public/currency/UI_battleEnd_diamond.png", var_0_25)
		end
	end

	local var_54_12, var_54_13 = var_54_7:getPosition()

	if arg_54_1.labels then
		for iter_54_0, iter_54_1 in ipairs(arg_54_1.labels) do
			if iter_54_1.name ~= "车间等级" then
				local var_54_14 = var_54_7:clone()
				local var_54_15 = var_54_8:getChildByName("value_new"):clone()

				var_54_15:setVisible(true)
				var_54_14:setVisible(true)
				var_54_14:setPosition(cc.p(var_54_12, var_54_13 - 30 * (iter_54_0 - 1)))
				var_54_8:addChild(var_54_14)
				var_54_14:setString(iter_54_1.name)
				var_54_15:setString(iter_54_1.newvalue)
				var_54_15:setPositionX(var_54_14:getPositionX() + var_54_14:getContentSize().width)
				var_54_15:setPositionY(var_54_14:getPositionY())
				var_54_8:addChild(var_54_15)
			end
		end
	end

	local var_54_16, var_54_17 = var_54_5:getPosition()
	local var_54_18 = 110
	local var_54_19 = true

	if arg_54_1.materials then
		for iter_54_2, iter_54_3 in ipairs(arg_54_1.materials) do
			local var_54_20 = iter_54_3.entityid and iter_54_3.entityid > 0 and ItemSprite:createBigWithEntityId(iter_54_3.entityid) or ItemSprite:createNewWithItemId(iter_54_3.id, iter_54_3.ownnum, nil, nil, nil, nil, iter_54_3.neednum)
			local var_54_21 = var_54_5:clone()

			var_54_21:setVisible(true)
			var_54_21:setPosition(cc.p(var_54_16 + var_54_18 * (iter_54_2 - (#arg_54_1.materials + 1) / 2), var_54_17))
			var_54_20:setPosition(cc.p(var_54_21:getContentSize().width / 2, var_54_21:getContentSize().height / 2))
			var_54_21:addChild(var_54_20)

			if iter_54_3.ownnum < iter_54_3.neednum or iter_54_3.neednum == 0 then
				var_54_19 = false

				var_54_20:getChildByName("layout"):getChildByName("icon"):setOpacity(180)
				var_54_20:setOpacity(180)
				var_54_20:setCascadeOpacityEnabled(false)
			end

			if iter_54_3.ownnum >= iter_54_3.neednum then
				var_54_21:setLocalZOrder(2)
				var_54_21:addTouchEventListener(function(arg_56_0, arg_56_1)
					local var_56_0

					if arg_56_1 ~= ccui.TouchEventType.ended then
						do return end

						var_56_0 = {
							itemid = iter_54_3.id,
							goto_back_system_id = arg_54_1.goto_back_system_id
						}
					end

					var_56_0.layer = cc.Layer:create()

					function var_56_0.removeParentCallback()
						self:removeSelf(var_54_0)
					end

					if iter_54_3.entityid and iter_54_3.entityid > 0 then
						var_56_0.entityid = iter_54_3.entityid
					end

					self:addChild(PopLayer:Item(var_56_0), 900)
				end)
			else
				var_54_21:setLocalZOrder(0)
				var_54_21:getChildByName("image_add"):setLocalZOrder(2)
				var_54_21:addTouchEventListener(function(arg_58_0, arg_58_1)
					if arg_58_1 ~= ccui.TouchEventType.ended then
						return
					end

					local var_58_0 = PopLayer.new()
					local var_58_1 = PopLayer:Go_Gain_Layer({
						item = iter_54_3.id,
						surecallback = function()
							self:runAction(cc.RemoveSelf:create())

							if arg_54_1.cancelcallback then
								arg_54_1.cancelcallback()
							end
						end,
						goto_back_system_id = arg_54_1.goto_back_system_id
					})

					if var_58_1 then
						cc.Director:getInstance():getRunningScene():addChild(var_58_1, 999)
					end
				end)
			end

			var_54_3:getChildByName("ListView_38"):pushBackCustomItem(var_54_21)
		end
	end

	if var_54_19 then
		var_54_2:addTouchEventListener(function(arg_60_0, arg_60_1)
			if arg_60_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_60_0:isBright() then
				return
			end

			arg_60_0:setBright(false)

			if arg_54_1.surecallback then
				arg_54_1.surecallback(function()
					if self.Pop then
						self.Pop:runAction(cc.RemoveSelf:create())
					end
				end, function(arg_62_0)
					arg_60_0:setBright(arg_62_0)
				end)
			end
		end)
	else
		var_54_2:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_25)
		var_54_2:getChildByName("Label_21"):setPositionY(var_54_2:getContentSize().height / 2 - 5)
		var_54_2:addTouchEventListener(function(arg_63_0, arg_63_1)
			if arg_63_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords("未满足条件")
			audio_manager:playeffectMusicTest("sound/invalid")
		end)
	end

	if var_54_9 then
		var_54_9:addTouchEventListener(function(arg_64_0, arg_64_1)
			if arg_64_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_64_0:isBright() then
				return
			end

			arg_64_0:setBright(false)

			if arg_54_1.surecallback2 then
				arg_54_1.surecallback2(function()
					if self.Pop then
						self.Pop:runAction(cc.RemoveSelf:create())
					end
				end, function(arg_66_0)
					arg_64_0:setBright(arg_66_0)
				end)
			end
		end)
	end

	self:fullScreen(var_54_1, var_54_0)
end

function PopLayer:Upgrade_Everything_COST(arg_67_1)
	if self.panel:getChildByName("attrLayout") then
		self.panel:getChildByName("attrLayout"):removeFromParent()
	end

	self.Pop_new = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Jinjie.json" or "Jinjie.ExportJson")

	self.Pop_new:retain()
	self.Pop_new:setVisible(false)

	local var_67_0 = ccui.Layout:create()

	var_67_0:setName("attrLayout")
	var_67_0:setPosition(cc.p(317, 440))
	var_67_0:setContentSize(cc.size(490, 60))
	var_67_0:setBackGroundColorOpacity(180)
	var_67_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_67_0:setBackGroundColor(cc.c3b(32, 35, 47))
	var_67_0:setAnchorPoint(cc.p(0.5, 0.5))
	self.panel:addChild(var_67_0)

	local var_67_1 = cc.Label:createWithTTF("下一强化等级:", FONT_DES, 20)

	var_67_1:setContentSize(cc.size(250, 25))
	var_67_1:setAnchorPoint(cc.p(0, 1))
	var_67_1:setName("attr_new_1")

	if layer == self.Pop then
		var_67_1:setPosition(15, 110)
	else
		var_67_1:setPosition(15, 41)
	end

	var_67_0:addChild(var_67_1)

	local var_67_2 = ccui.Helper:seekWidgetByName(self.Pop_new, "panel_cost")

	if arg_67_1.gold_cost then
		local var_67_3 = ccui.Helper:seekWidgetByName(var_67_2, "label_cost_num_gold")

		ccui.Helper:seekWidgetByName(var_67_3, "label_name"):setVisible(false)
		var_67_3:removeFromParent()
		var_67_3:retain()
		var_67_3:setVisible(true)
		var_67_3:setPosition(390, 27)
		var_67_3:setLocalZOrder(5)
		var_67_3:setString(arg_67_1.gold_cost)
		var_67_0:addChild(var_67_3)

		local var_67_4 = cc.Label:createWithTTF("消耗：", FONT_DES, 22)

		var_67_4:setContentSize(cc.size(50, 30))
		var_67_4:setAnchorPoint(cc.p(0, 1))
		var_67_4:setPosition(cc.p(295, 41))
		var_67_4:setColor(cc.c3b(255, 255, 255))
		var_67_0:addChild(var_67_4, 2)
	end

	if arg_67_1.labels[2] then
		local var_67_9 = cc.Label:createWithTTF("", FONT_DES, 22)

		var_67_9:setContentSize(cc.size(250, 30))
		var_67_9:setName("attr_new_2")
		var_67_9:setAnchorPoint(cc.p(0, 1))
		var_67_9:setColor(cc.c3b(255, 168, 0))
		var_67_0:addChild(var_67_9)

		local var_67_10 = cc.Label:createWithTTF("", FONT_DES, 23)

		var_67_10:setContentSize(cc.size(250, 30))
		var_67_10:setName("attr_value")
		var_67_10:setAnchorPoint(cc.p(0, 1))
		var_67_10:setColor(cc.c3b(255, 168, 0))
		var_67_0:addChild(var_67_10)
		var_67_10:setPosition(cc.p(string.len(arg_67_1.labels[1].name) * 22 / 3 + 120, 41))
		var_67_9:setPosition(cc.p(150, 41))
		var_67_9:setString(arg_67_1.labels[2].name)
		var_67_10:setString(arg_67_1.labels[2].newvalue)
	end

	if arg_67_1.materials then
		for iter_67_0, iter_67_1 in ipairs(arg_67_1.materials) do
			local var_67_11, var_67_12 = materialbg:getPosition()
			local var_67_13 = ccui.Helper:seekWidgetByName(var_67_2, "equip_4")
			local var_67_14 = ItemSprite:createNewWithItemId(iter_67_1.id, nil, "withBox", var_0_11[iter_67_1.id].name)
			local var_67_15 = var_67_13:clone()

			var_67_15:setVisible(true)
			var_67_14:setPosition(cc.p(var_67_11 + 254 * (iter_67_0 - (#arg_67_1.materials + 1) / 2), var_67_12))
			var_67_14:setPosition(cc.p(var_67_15:getContentSize().width / 2, var_67_15:getContentSize().height / 2))
			var_67_14:setOpacity(255)
			var_67_15:addChild(var_67_14)

			if iter_67_1.ownnum >= iter_67_1.neednum then
				var_67_15:setLocalZOrder(2)
			else
				var_67_15:setLocalZOrder(0)
				var_67_15:addTouchEventListener(function(arg_68_0, arg_68_1)
					if arg_68_1 ~= ccui.TouchEventType.ended then
						return
					end

					local var_68_0 = PopLayer.new()
					local var_68_1 = PopLayer:Go_Gain_Layer({
						item = iter_67_1.id,
						surecallback = function()
							self:runAction(cc.RemoveSelf:create())

							if arg_67_1.cancelcallback then
								arg_67_1.cancelcallback()
							end
						end,
						returnlayer = arg_67_1.returnlayer
					})

					if var_68_1 then
						cc.Director:getInstance():getRunningScene():addChild(var_68_1, 999)
					end
				end)
			end

			var_67_2:addChild(var_67_15)
		end
	end

	ccui.Helper:seekWidgetByName(self.Pop_new, "button_sure"):addTouchEventListener(function(arg_70_0, arg_70_1)
		if arg_70_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_70_0:isBright() then
			return
		end

		arg_70_0:setBright(false)

		if arg_67_1.surecallback then
			arg_67_1.surecallback(function()
				if self.Pop then
					self.Pop:runAction(cc.RemoveSelf:create())
				end
			end)
		end
	end)
end

function PopLayer.ActionofAccess(arg_72_0, arg_72_1)
	arg_72_1:setOpacity(0)
	arg_72_1:setScale(1, 0.001)
	arg_72_1:runAction((cc.Sequence:create(cc.Blink:create(0.15, 1), cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1, 1)))))
end

function PopLayer:removeSelf(arg_73_1)
	if arg_73_1 then
		arg_73_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.Sequence:create(cc.FadeTo:create(0.1, 20), cc.Blink:create(0.15, 1)), cc.ScaleTo:create(0.1, 1, 0.001)), cc.CallFunc:create(function()
			if self then
				self:removeFromParent()
			end

			if self.Pop then
				self.Pop:runAction(cc.RemoveSelf:create())
			end
		end)))
	else
		self.Pop:runAction(cc.RemoveSelf:create())
		self:removeFromParent()
	end
end

function PopLayer.Go(arg_75_0, arg_75_1)
	local var_75_0 = PopLayer.new()

	var_75_0:Go_Init(arg_75_1)

	return var_75_0
end

function PopLayer.Go_New(arg_76_0, arg_76_1)
	local var_76_0 = PopLayer.new()

	arg_76_1.targetlayer = arg_76_1.is_need_pop_layer and "PopSupermarketLayer" or "SupermarketLayer"

	var_76_0:Go_Gain_Diamaond(arg_76_1)

	return var_76_0
end

function PopLayer.Do(arg_77_0, arg_77_1)
	local var_77_0 = PopLayer.new()

	var_77_0:Do_Init(arg_77_1)

	return var_77_0
end

function PopLayer.Gain(arg_78_0, arg_78_1)
	local var_78_0 = PopLayer.new()
	local var_78_1 = {}

	if arg_78_1 then
		var_78_1 = arg_78_1
	end

	var_78_1.panel = ccui.Helper:seekWidgetByName(var_78_0:Gain_Init(var_78_1), "Panel_Back")

	local var_78_2 = 650
	local var_78_3, var_78_4 = var_78_0:Layer_Gain_List(var_78_1)

	if var_78_4 > 1 then
		var_78_3:setPosition(cc.p(SCREEN_WIDTH / 2, var_78_2))

		var_78_2 = var_78_2 - 100

		var_78_1.panel:addChild(var_78_3, 1)
		var_78_3:setCascadeOpacityEnabled(true)
		var_78_1.panel:getChildByName("button_sure"):setVisible(false)
		var_78_1.panel:getChildByName("button_sure"):setTouchEnabled(false)
	end

	if arg_78_1.description then
		local var_78_5 = cc.Label:createWithTTF(arg_78_1.description, FONT_DES, 25)

		var_78_5:setPosition(cc.p(SCREEN_WIDTH / 2, var_78_2))
		var_78_1.panel:addChild(var_78_5, 1)
	end

	return var_78_0
end

function PopLayer:PurchaseResult(arg_79_1)
	local var_79_0 = PopLayer.new()
	local var_79_1 = ccs.GUIReader:getInstance()
	local var_79_2 = var_79_1:widgetFromJsonFile(config._DEBUG and "purchase.json" or "purchase.ExportJson")
	local var_79_3 = ccui.Helper:seekWidgetByName(var_79_2, "image_panel")

	var_79_3.setOpacity(var_79_1, 0)
	var_79_0:addChild(var_79_2)
	self:ActionofAccess(var_79_3)
	var_79_2:addTouchEventListener(function(arg_80_0, arg_80_1)
		if arg_80_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_79_0:runAction(cc.RemoveSelf:create())
	end)

	local var_79_4 = {}

	if arg_79_1.remain then
		var_79_4[#var_79_4 + 1] = ItemSprite:createRechageItemsIcon(arg_79_1.id, 1)
	end

	if arg_79_1.diamond and arg_79_1.diamond > 0 then
		var_79_4[#var_79_4 + 1] = ItemSprite:createRechageItemsIcon(arg_79_1.id, arg_79_1.diamond, arg_79_1.item == nil)
	end

	if arg_79_1.extradiamond and arg_79_1.extradiamond > 0 then
		var_79_4[#var_79_4 + 1] = ItemSprite:createRechageItemsIcon(arg_79_1.id, arg_79_1.extradiamond, true, true)
	end

	if arg_79_1.item then
		var_79_4[#var_79_4 + 1] = ItemSprite:createNewWithItemId(arg_79_1.item.itemid)
	end

	local var_79_5 = #var_79_4

	for iter_79_0 = 1, #var_79_4 do
		var_79_4[iter_79_0]:setAnchorPoint(cc.p(0.5, 0.5))
		var_79_4[iter_79_0]:setPosition(cc.p(250 - ((var_79_5 + 1) / 2 - iter_79_0) * 200, 155))
		var_79_3:addChild(var_79_4[iter_79_0])
	end

	var_79_3:getChildByName("button_sure"):addTouchEventListener(function(arg_81_0, arg_81_1)
		if arg_81_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_79_0:runAction(cc.RemoveSelf:create())
	end)
	var_79_3:runAction(cc.FadeIn:create(0.2))
	self:fullScreen(var_79_2, var_79_3)

	return var_79_0
end

function PopLayer:PurchaseAlert()
	local var_82_0 = PopLayer.new()
	local var_82_1 = ccs.GUIReader:getInstance()
	local var_82_2 = var_82_1:widgetFromJsonFile(config._DEBUG and "Pop_Gain.json" or "Pop_Gain.ExportJson")
	local var_82_3 = ccui.Helper:seekWidgetByName(var_82_2, "Panel_Back")

	var_82_3.setOpacity(var_82_1, 0)
	var_82_0:addChild(var_82_2)
	var_82_3:getChildByName("image_system_figure"):setVisible(false)
	var_82_3:getChildByName("Image_15"):setVisible(false)

	local var_82_4 = cc.Label:createWithTTF("您有尚未领取的充值物品, 请前往邮箱查收", FONT_DES, 25)

	var_82_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_82_4:setPosition(cc.p(SCREEN_WIDTH / 2, 640))
	var_82_3:addChild(var_82_4, 10)
	var_82_3:getChildByName("button_sure"):addTouchEventListener(function(arg_83_0, arg_83_1)
		if arg_83_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_82_0:runAction(cc.RemoveSelf:create())
	end)
	var_82_3:runAction(cc.FadeIn:create(0.2))
	self:fullScreen(var_82_2, var_82_3)

	return var_82_0
end

function PopLayer.Item(arg_84_0, arg_84_1)
	LayerManager:pushInLayer(arg_84_1.pop_layer_name or "PopItemLayer", arg_84_1)
end

function PopLayer.giftPoplayer(arg_85_0, arg_85_1)
	local var_85_0 = tonumber(arg_85_1.itemid)
	local var_85_1 = 245
	local var_85_3 = 490
	local var_85_4 = 320
	local var_85_6 = arg_85_1.panel:getChildByName("layer_item_info")
	local var_85_7 = var_85_6:getChildByName("using_des_bg")
	local var_85_8 = var_85_6:getChildByName("layout")
	local var_85_9 = var_85_6:getChildByName("titleImg")
	local var_85_10 = ccui.Helper:seekWidgetByName(arg_85_1.panel, "image_bg")
	local var_85_11 = var_85_6:getChildByName("name_label")
	local var_85_12 = var_85_8:getChildByName("info")
	local var_85_13 = var_85_6:getChildByName("Strength_Icon")
	local var_85_14 = arg_85_1.panel:getChildByName("layer_slider")

	if var_0_11[var_85_0].bag_item_type == kITEM_GIFT_FOR_FRIEND and (arg_85_1.slidecost and arg_85_1.slidecost.costtype == "public/currency/UI_battleEnd_diamond.png" or arg_85_1.slidecost.costtype == "public/currency/6800211.png") then
		var_85_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_85_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_85_9:loadTexture("public/panelbg/title_buy.png", var_0_25)
		var_85_9:setPositionY(var_85_9:getPositionY() + 3)
		var_85_10:loadTexture("public/panelbg/pop_gift.png", var_0_25)
		var_85_10:setPosition(cc.p(261, 220))
		var_85_12:setColor(cc.c3b(238, 183, 240))
		var_85_11:setPosition(cc.p(var_85_1 + 10, 516))
		var_85_13:setPosition(cc.p(140, 425))

		local var_85_15 = var_85_6:getChildByName("numberLabel")

		var_85_15:setPosition(cc.p(var_85_1 + 10, var_85_3 - 20))
		var_85_15:setAnchorPoint(cc.p(0, 0.5))

		local var_85_16 = ccui.ImageView:create("public/panelbg/image_label.png", var_0_25)

		var_85_16:setPosition(cc.p(var_85_1 + 5, var_85_3 - 50))
		var_85_16:setAnchorPoint(cc.p(0, 0.5))
		var_85_6:addChild(var_85_16, 999)

		local var_85_17 = ccui.ImageView:create("public/panelbg/heart.png", var_0_25)

		var_85_17:setPosition(cc.p(var_85_16:getPositionX() + var_85_16:getContentSize().width + 15, var_85_16:getPositionY()))
		var_85_6:addChild(var_85_17, 999)

		local var_85_18 = cc.Label:createWithTTF("+" .. var_0_11[var_85_0].favor, "fonts/number.ttf", 26)

		var_85_18:setPosition(cc.p(var_85_17:getPositionX() + var_85_17:getContentSize().width, var_85_16:getPositionY()))
		var_85_6:addChild(var_85_18, 999)

		if arg_85_1.itemid and arg_85_1.ShopSliderCallback then
			local var_85_20 = var_85_14:getChildByName("layout_slider")
			local var_85_21 = var_85_20:getChildByName("slider")

			var_85_21:loadBarTexture("public/panelbg/slider_bar_bottom.png", var_0_25)
			var_85_21:loadProgressBarTexture("public/panelbg/slider_bar_gift.png", var_0_25)
			var_85_21:loadSlidBallTextures("public/button/slider_node.png", "public/button/slider_node.png", "public/button/slider_node.png", var_0_25)

			local var_85_22 = var_85_14:getChildByName("callback_button")
			local var_85_23 = var_85_22:getChildByName("Label_button")

			if arg_85_1.limitNum and arg_85_1.limitNum > 1 then
				var_85_22:setPosition(cc.p(470, 30))
				var_85_23:setVisible(false)

				if arg_85_1.limitNum ~= 1 and arg_85_1.limitNum ~= 0 then
					var_85_20:getChildByName("add_button"):loadTextures("public/button/add_btn.png", nil, "public/button/add_btn.png", var_0_25)
					var_85_20:getChildByName("sub_button"):loadTextures("public/button/dec_btn.png", nil, "public/button/dec_btn.png", var_0_25)
				end
			else
				var_85_22:setPosition(cc.p(320, 30))
				var_85_22:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray.png", var_0_25)
				var_85_23:setString("货物不足")
				var_85_23:setVisible(true)
			end

			if arg_85_1.slidecost and (not arg_85_1.slidecost.nowHave or arg_85_1.slidecost.nowHave < arg_85_1.slidecost.costnum) then
				var_85_23:setString("货币不足")
				var_85_23:setVisible(true)
				var_85_22:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray.png", var_0_25)
				var_85_22:setPosition(cc.p(320, 30))
			elseif arg_85_1.limitNum == 1 then
				var_85_22:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", var_0_25)
				var_85_23:setString("购 买")
				var_85_23:setVisible(true)
				var_85_22:setPosition(cc.p(320, 30))
			end

			if arg_85_1.baggain and arg_85_1.baggain.gaintype then
				local var_85_24 = var_85_14:getChildByName("icon_bag")

				var_85_24:setPosition(cc.p(var_85_4 + 120, 30))
				var_85_14:getChildByName("costLabel"):setPosition(cc.p(var_85_24:getPositionX() + 30, var_85_24:getPositionY()))
			end
		end
	elseif arg_85_1.ShopSliderCallback and var_0_11[var_85_0].bag_item_type == kITEM_SKIN or var_0_11[var_85_0].bag_item_type == kITEM_SKIN_GIFT then
		var_85_9:loadTexture("public/panelbg/title_buy.png", var_0_25)
		var_85_9:setPositionY(var_85_9:getPositionY() + 3)
		var_85_10:loadTexture("public/panelbg/pop_gift.png", var_0_25)
		var_85_10:setPosition(cc.p(261, 220))
		var_85_12:setColor(cc.c3b(238, 183, 240))
		var_85_11:setPosition(cc.p(var_85_1 + 10, 516))
		var_85_13:setPosition(cc.p(140, 425))
		var_85_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_85_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	end
end

function PopLayer:Weapon_Init(arg_86_1)
	local var_86_0 = playermodel.items[arg_86_1.entityid]
	local var_86_2 = weapon_manager:getWeaponConfig(playermodel.items[arg_86_1.entityid])

	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Popup_normal.json" or "Popup_normal.ExportJson")

	self:addChild(self.Pop)

	self.panel = ccui.Helper:seekWidgetByName(self.Pop, "panel_back")

	local var_86_3 = ccui.Helper:seekWidgetByName(self.Pop, "panel_all")
	local var_86_4 = ccui.Helper:seekWidgetByName(self.Pop, "title")
	local var_86_5 = ccui.Helper:seekWidgetByName(self.Pop, "button_sure")
	local var_86_6 = var_86_5:getChildByName("label")

	ccui.Helper:seekWidgetByName(self.Pop, "image_system_figure"):setVisible(false)
	self.Pop:setAnchorPoint(cc.p(0.5, 0.5))
	self:ActionofAccess(self.panel)
	self.Pop:setPosition(cc.p(self.panel:getContentSize().width / 2, self.panel:getContentSize().height / 2))
	self.panel:setAnchorPoint(cc.p(0.5, 0.5))
	self.panel:setPosition(cc.p(self.panel:getContentSize().width / 2, self.panel:getContentSize().height / 2))

	local function var_86_7(arg_87_0, arg_87_1)
		if arg_87_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_86_1.cancelcallback then
			arg_86_1.cancelcallback()
		end

		self:removeSelf(self.panel)
	end

	self:registerScriptHandler(function(arg_88_0)
		if arg_88_0 == "exit" and arg_86_1.backUpdateCallback then
			arg_86_1.backUpdateCallback()
		end
	end)

	arg_86_1.panel = self.panel

	if arg_86_1.itemid then
		self.layer_item_info = self:Layer_Item_Info(arg_86_1)

		self.layer_item_info:setPosition(cc.p(20, 280))
		self.panel:addChild(self.layer_item_info, 1)
	end

	ccui.Helper:seekWidgetByName(self.Pop, "button_close"):addTouchEventListener(var_86_7)
	var_86_3:addTouchEventListener(var_86_7)
	ccui.Helper:seekWidgetByName(self.Pop, "bg"):setTouchEnabled(true)

	self.lockBnt = var_86_0.weapon_attr.lock and ccui.Button:create("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_25) or ccui.Button:create("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_25)

	self.lockBnt:setAnchorPoint(cc.p(0.5, 0.5))
	self.lockBnt:setPosition(530, 790)
	self.lockBnt:setName("lockbtn")
	self.panel:addChild(self.lockBnt)
	self.lockBnt:addTouchEventListener(function(arg_89_0, arg_89_1)
		if arg_89_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_89_0:setTouchEnabled(false)
		network:rpc("lock_item", {
			locktype = var_86_0.weapon_attr.lock and 1 or 2,
			entityid = arg_86_1.entityid
		}, function(arg_90_0)
			arg_89_0:setTouchEnabled(true)

			if arg_90_0.result == 1 then
				var_86_0.weapon_attr.lock = arg_90_0.lock

				if var_86_0.weapon_attr.lock then
					arg_89_0:loadTextures("public/button/pop_unlock.png", nil, "public/button/pop_unlock.png", var_0_25)
				else
					arg_89_0:loadTextures("public/button/pop_lock.png", nil, "public/button/pop_lock.png", var_0_25)
				end
			else
				l2Log("lock fail")
			end
		end)
	end)

	local function var_86_8(arg_91_0)
		local var_91_0

		if arg_91_0 == "big" then
			var_91_0 = var_86_5

			var_86_5:setVisible(true)
			var_91_0:getChildByName("label"):setColor(cc.c3b(41, 49, 58))
		elseif arg_91_0 == "small" then
			var_86_5:setVisible(false)

			var_91_0 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_gray.png", var_0_25)

			var_91_0:setPosition(440, 310)
			self.panel:addChild(var_91_0)

			local var_91_1 = cc.Label:createWithTTF("强化", FONT_BUTTON, 30)

			var_91_1:setColor(cc.c3b(41, 49, 58))
			var_91_1:setName("label")
			var_91_1:setPosition(cc.p(var_91_0:getContentSize().width / 2, var_91_0:getContentSize().height / 2))
			var_91_0:addChild(var_91_1)
		end

		local var_91_2 = ccui.ImageView:create(IMAGE_GOLD, var_0_25)

		var_91_2:setName("gold_img")
		var_91_2:setPosition(cc.p(var_91_0:getContentSize().width / 2 - 30, -10))
		var_91_0:addChild(var_91_2)

		local var_91_3 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_91_3:setAnchorPoint(cc.p(0, 0.5))
		var_91_3:setName("gold_num")
		var_91_3:setPosition(cc.p(var_91_0:getContentSize().width / 2, -10))
		var_91_0:addChild(var_91_3)
		var_91_0:setPressedActionEnabled(true)
		var_91_0:addTouchEventListener(function(arg_92_0, arg_92_1)
			if arg_92_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_92_0.islock then
				return
			end

			arg_92_0.islock = true

			weapon_manager:strengthenWeapon(arg_86_1.entityid, nil, function(arg_93_0)
				arg_92_0.islock = false

				if arg_93_0 == 1 then
					audio_manager:playeffectMusicTest("sound/upgrade")
					self.panel:updateShow()
					self.layer_item_info:updateShow()

					if arg_86_1.updateCallback then
						arg_86_1.updateCallback()
					end

					local var_93_1 = weapon_manager:getWeaponConfig(playermodel.items[arg_86_1.entityid])

					fight_capacity_manager:showUpgrade({
						"显示待定5"
					})
				elseif arg_93_0 == 2 then
					global_ShowBlockWords("武器需要突破")
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_93_0 == 3 then
					global_ShowBlockWords("材料不足")
					audio_manager:playeffectMusicTest("sound/invalid")
					self.Pop:setVisible(false)

					local var_93_2 = weapon_manager:getWeaponConfig(playermodel.items[arg_86_1.entityid])
					local var_93_3 = PopLayer:Go_Gain_Layer({
						goto_back_system_id = 500,
						item = require("data.weapon_strengthen" .. var_0_11[arg_86_1.itemid].equip_quality .. "_data")[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_item1,
						surecallback = function()
							self:removeSelf(self.rootpanel)
						end,
						cancelcallback = function()
							self.Pop:setVisible(true)
						end
					})

					if var_93_3 then
						global_basic_scene:addChild(var_93_3, 999)
					end
				elseif arg_93_0 == 4 then
					global_ShowBlockWords(L_GOLD_LACK)
					audio_manager:playeffectMusicTest("sound/invalid")
					PopLayer:popGainGold(arg_86_1.goto_back_system_id)
					self:removeSelf(self.panel)
				elseif arg_93_0 == 5 then
					global_ShowBlockWords("武器已满级")
					audio_manager:playeffectMusicTest("sound/invalid")
				end
			end)
		end)

		return var_91_0
	end

	local function var_86_9()
		local var_96_0 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_gray.png", var_0_25)

		var_96_0:setPosition(200, 310)
		self.panel:addChild(var_96_0)

		local var_96_1 = cc.Label:createWithTTF("升 星", FONT_BUTTON, 30)

		var_96_1:setColor(cc.c3b(41, 49, 58))
		var_96_1:setName("label")
		var_96_1:setPosition(cc.p(var_96_0:getContentSize().width / 2, var_96_0:getContentSize().height / 2))
		var_96_0:addChild(var_96_1)

		local function var_96_2()
			if playermodel.items[arg_86_1.entityid].weapon_attr.nowStars < var_0_11[playermodel.items[arg_86_1.entityid].itemid].max_star then
				var_96_0:setVisible(true)
				var_96_0:getChildByName("label"):setString("升 星")
			elseif var_0_11[playermodel.items[arg_86_1.entityid].itemid].equip_quality > 5 then
				var_96_0:getChildByName("label"):setString("已满星")
			else
				var_96_0:getChildByName("label"):setString("升 阶")
			end

			if weapon_manager:isTipsUpWeaponQuality(arg_86_1.entityid) then
				AlertManager:add_alert_by_config(var_96_0, true, {
					ALERT_SHOW_REDDOT,
					"",
					cc.p(var_96_0:getContentSize().width - 20, var_96_0:getContentSize().height - 20)
				})
			elseif weapon_manager:checkIsCanUpgrade(arg_86_1.entityid) then
				AlertManager:add_alert_by_config(var_96_0, true, {
					ALERT_SHOW_REDDOT,
					"",
					cc.p(var_96_0:getContentSize().width - 20, var_96_0:getContentSize().height - 20)
				})
			else
				var_96_0:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", var_0_25)
			end
		end

		var_96_2()

		local function var_96_3(arg_98_0)
			audio_manager:playeffectMusic("weapon_starup")

			local var_98_0 = ccui.Layout:create()

			var_98_0:setTouchEnabled(true)
			var_98_0:setContentSize(cc.Director:getInstance():getVisibleSize())
			var_98_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_98_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
			var_98_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_98_0:setBackGroundColor(cc.c3b(0, 0, 0))
			var_98_0:setBackGroundColorOpacity(220)
			global_basic_scene:addChild(var_98_0, 999)

			local var_98_1 = playermodel.items[arg_98_0].itemid

			local function var_98_2()
				local var_99_0 = var_0_11[var_98_1].max_star
				local var_99_1 = {}

				for iter_99_0 = 1, var_0_11[var_98_1].max_star do
					local var_99_3 = ccui.ImageView:create(iter_99_0 <= playermodel.items[arg_98_0].weapon_attr.nowStars and "public/currency/weapon_star.png" or "public/currency/weapon_star_empty.png", var_0_25)

					var_99_3:setPosition(cc.p(320 + (iter_99_0 - (var_99_0 + 1) / 2) * (var_99_3:getContentSize().width - 10), 545))
					table.insert(var_99_1, var_99_3)
					var_99_3:setVisible(false)
					var_98_0:addChild(var_99_3)
				end

				for iter_99_1, iter_99_2 in pairs(var_99_1) do
					var_99_1[iter_99_1]:setScale(8)
					var_99_1[iter_99_1]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_99_1 / 30), cc.CallFunc:create(function()
						var_99_1[iter_99_1]:setVisible(true)
					end), cc.Spawn:create(cc.RotateBy:create(0.55, 72), cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 1), cc.ScaleTo:create(0.25, 2, 2), cc.ScaleTo:create(0.15, 1, 1)))))
				end
			end

			local var_98_3 = L2Skeleton:create("spine/ui/weapon_up_quality/weapon_up.json", "spine/ui/weapon_up_quality/weapon_up.atlas")

			var_98_3:refreshSkeleton()
			var_98_3:setSlotTexture("wuqi", "diergewuqi", "equipment/" .. var_0_11[playermodel.items[arg_98_0].itemid].image_id .. ".png")
			var_98_3:setSlotTexture("wuqi", "wuqishengjiewuqi", "equipment/" .. var_0_11[playermodel.items[arg_98_0].itemid].image_id .. ".png")
			var_98_3:setSlotTexture("wuqikuang", "wuqishengjiewuqikuang", ({
				"weaponIcon/weapon_bg_white.png",
				"weaponIcon/weapon_bg_green.png",
				"weaponIcon/weapon_bg_blue.png",
				"weaponIcon/weapon_bg_purple.png",
				"weaponIcon/weapon_bg_orange.png",
				"weaponIcon/weapon_bg_red.png"
			})[var_0_11[playermodel.items[arg_98_0].itemid].equip_quality])
			var_98_3.skeletonAnimation:setPosition(cc.p(320, 600))
			var_98_3:play("unique_up", false)
			var_98_0:addChild(var_98_3)
			var_98_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
				var_98_2()
			end), cc.DelayTime:create(8), cc.RemoveSelf:create(), cc.CallFunc:create(function()
				if callback then
					callback()
				end
			end)))
			var_98_0:addTouchEventListener(function(arg_103_0, arg_103_1)
				if arg_103_1 ~= ccui.TouchEventType.ended then
					return
				end

				if callback then
					callback()
				end

				var_98_0:runAction(cc.RemoveSelf:create())
			end)
		end

		var_96_0:addTouchEventListener(function(arg_104_0, arg_104_1)
			if arg_104_1 ~= ccui.TouchEventType.ended then
				return
			end

			if playermodel.items[arg_86_1.entityid].weapon_attr.nowStars < var_0_11[playermodel.items[arg_86_1.entityid].itemid].max_star then
				local var_104_0 = weapon_manager:getWeaponConfig(playermodel.items[arg_86_1.entityid])
				local var_104_1 = require("data.weapon_strengthen" .. var_0_11[arg_86_1.itemid].equip_quality .. "_data")
				local var_104_2 = var_0_11[arg_86_1.itemid]["upgrade_need_num" .. playermodel.items[arg_86_1.entityid].weapon_attr.nowStars + 1] or 1

				self.Pop:setVisible(false)

				local var_104_3 = {
					showIntro = true,
					labels = {
						{
							newvalue = FIGHT_ATTR_FORMAT(var_104_0.sub_attr.attrtype, var_104_0.sub_attr.value) .. " → " .. weapon_manager:getNextStarAttrValue(arg_86_1.entityid),
							name = FIGHT_ATTR_INFO[var_104_0.sub_attr.attrtype] .. ": "
						}
					},
					materials = {},
					cancelcallback = function()
						self.Pop:setVisible(true)
					end
				}
				local var_104_4 = item_manager:getItemByItemId(arg_86_1.itemid)

				for iter_104_0 = #var_104_4, 1, -1 do
					if var_104_4[iter_104_0] == arg_86_1.entityid or playermodel.items[var_104_4[iter_104_0]].weapon_attr.use then
						table.remove(var_104_4, iter_104_0)
					end
				end

				table.sort(var_104_4, function(arg_106_0, arg_106_1)
					local var_106_0 = playermodel.items[arg_106_0].weapon_attr
					local var_106_1 = playermodel.items[arg_106_1].weapon_attr

					if playermodel.items[arg_106_0].weapon_attr.nowStars == playermodel.items[arg_106_1].weapon_attr.nowStars then
						return var_106_0.level < var_106_1.level
					else
						return var_106_0.nowStars < var_106_1.nowStars
					end
				end)

				local function var_104_5(arg_107_0)
					if #var_104_4 < 1 then
						return -1
					elseif #var_104_4 >= 1 then
						table.remove(var_104_4, 1)

						return var_104_4[1]
					end
				end

				local var_104_6 = {}

				for iter_104_1 = 1, var_104_2 do
					local var_104_7 = var_104_5(arg_86_1.itemid)

					table.insert(var_104_3.materials, {
						neednum = 1,
						entityid = var_104_7,
						id = arg_86_1.itemid,
						ownnum = var_104_7 > 0 and 1 or 0
					})

					if var_104_7 < 0 then
						-- block empty
					end

					table.insert(var_104_6, var_104_7)
				end

				function var_104_3.surecallback(arg_108_0, arg_108_1)
					local function var_108_0()
						local var_109_0 = weapon_manager:getWeaponConfig(playermodel.items[arg_86_1.entityid]).sub_attr.value

						weapon_manager:UpgradeWeapon(arg_86_1.entityid, var_104_6, function(arg_110_0)
							if arg_110_0 == 1 then
								self.layer_item_info:updateShow()
								self.Pop:setVisible(true)

								if arg_108_0 then
									arg_108_0()
								end

								if arg_86_1.updateCallback then
									arg_86_1.updateCallback()
								end

								local var_110_1 = weapon_manager:getWeaponConfig(playermodel.items[arg_86_1.entityid])

								fight_capacity_manager:showUpgrade({
									"副:" .. FIGHT_ATTR_INFO[var_110_1.sub_attr.attrtype] .. "+" .. FIGHT_ATTR_FORMAT(var_110_1.sub_attr.attrtype, var_110_1.sub_attr.value - var_109_0)
								})

								if weapon_manager:isTipsUpWeaponQuality(arg_86_1.entityid) then
									AlertManager:add_alert_by_config(self.panel, true, {
										ALERT_SHOW_REDDOT,
										"",
										cc.p(565, 717)
									})
								elseif weapon_manager:checkIsCanUpgrade(arg_86_1.entityid) then
									AlertManager:add_alert_by_config(self.panel, true, {
										ALERT_SHOW_REDDOT,
										"",
										cc.p(565, 717)
									})
								else
									AlertManager:add_alert_by_config(self.panel, false, {
										ALERT_SHOW_REDDOT,
										"",
										cc.p(565, 717)
									})
								end

								var_96_2()
								var_96_3(arg_86_1.entityid)
							elseif arg_110_0 == 2 then
								global_ShowBlockWords("升星物品不存在")
								audio_manager:playeffectMusicTest("sound/invalid")
							elseif arg_110_0 == 3 then
								global_ShowBlockWords("升星物品不匹配")
								audio_manager:playeffectMusicTest("sound/invalid")
							elseif arg_110_0 == 4 then
								global_ShowBlockWords("消耗物品有空星")
								audio_manager:playeffectMusicTest("sound/invalid")
							elseif arg_110_0 == 5 then
								global_ShowBlockWords("已满星")
								audio_manager:playeffectMusicTest("sound/invalid")
							end
						end)
					end

					local var_108_1

					for iter_108_0, iter_108_1 in pairs(var_104_6) do
						if playermodel.items[iter_108_1].weapon_attr.lock then
							var_108_1 = 1

							break
						end

						if playermodel.items[iter_108_1].weapon_attr.level > 0 then
							var_108_1 = 2

							break
						end

						if playermodel.items[iter_108_1].weapon_attr.nowStars > 0 then
							var_108_1 = 3

							break
						end
					end

					local function var_108_2()
						arg_108_1(true)
					end

					if var_108_1 then
						require("view.Sprite.ConfirmDialogSprite")
						global_basic_scene:addChild(ConfirmDialogSprite:create("操作确认", ({
							"所选魂武包含已锁定魂武",
							"所选魂武包含已升级魂武",
							"所选魂武包含已升星魂武"
						})[var_108_1] .. "，是否执行该操作？", {
							surecallback = var_108_0,
							cancelCallback = var_108_2
						}, nil, nil, function()
							arg_108_1(true)
						end), 999)
					else
						var_108_0()
					end
				end

				global_basic_scene:addChild(self:Weapon_Upgrade(var_104_3), 999)
			else
				if var_0_11[playermodel.items[arg_86_1.entityid].itemid].equip_quality >= 6 then
					return
				end

				self.Pop:setVisible(false)

				local function var_104_9()
					self.Pop:setVisible(true)
				end

				LayerManager:pushInLayer("PopWeaponUpQuality", {
					goto_back_system_id = 500,
					entityid = arg_86_1.entityid,
					exitcallback = function(arg_114_0)
						if arg_114_0 == 1 then
							if arg_86_1.cancelcallback then
								arg_86_1.cancelcallback()
							end

							self:removeSelf(self.panel)
						elseif arg_114_0 == 0 then
							var_104_9()
						end
					end
				})
			end
		end)

		return var_96_0
	end

	local var_86_10 = ccui.ImageView:create("public/panelbg/strengen_arrow.png", var_0_25)

	var_86_10:setPosition(cc.p(435, 738))
	var_86_10:setName("arrow")
	self.panel:addChild(var_86_10)

	self.newvalue = cc.Label:createWithTTF("", FONT_DES, 20)

	self.newvalue:setColor(cc.c3b(0, 216, 255))
	self.newvalue:setPosition(cc.p(465, var_86_10:getPositionY()))
	self.newvalue:setAnchorPoint(cc.p(0, 0.5))
	self.newvalue:setName("newvalue")
	self.panel:addChild(self.newvalue)

	if arg_86_1.showType == "info" then
		var_86_4:setString("魂武详情")

		self.strengthenBtn = var_86_8("small")
		self.upgradeBnt = var_86_9()
		self.replaceBnt = (function()
			local var_115_0 = ccui.Button:create("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_off.png", var_0_25)

			var_115_0:setPosition(440, 310)
			self.panel:addChild(var_115_0)

			local var_115_1 = cc.Label:createWithTTF("替换", FONT_BUTTON, 30)

			var_115_1:setColor(cc.c3b(41, 49, 58))
			var_115_1:setName("label")
			var_115_1:setPosition(cc.p(var_115_0:getContentSize().width / 2, var_115_0:getContentSize().height / 2))
			var_115_0:addChild(var_115_1)
			var_115_0:addTouchEventListener(function(arg_116_0, arg_116_1)
				local var_116_0

				if arg_116_1 ~= ccui.TouchEventType.ended then
					do return end

					var_116_0 = {}
				end

				function var_116_0.unused(arg_117_0)
					fight_capacity_manager:saveSoulAttr(arg_86_1.servantid)
					weapon_manager:replaceRoleWeapon(arg_86_1.servantid, arg_117_0, function(arg_118_0)
						if arg_118_0 == 1 then
							fight_capacity_manager:displaySoulAttrChangeValue()

							if arg_86_1.updateEquipLayerCallback then
								arg_86_1.updateEquipLayerCallback()
							end

							self:removeSelf(self.panel)
						end
					end)
				end

				function var_116_0.used()
					fight_capacity_manager:saveSoulAttr(arg_86_1.servantid)
					weapon_manager:replaceRoleWeapon(arg_86_1.servantid, nil, function(arg_120_0)
						if arg_120_0 == 1 then
							fight_capacity_manager:displaySoulAttrChangeValue()

							if arg_86_1.updateEquipLayerCallback then
								arg_86_1.updateEquipLayerCallback()
							end

							self:removeSelf(self.panel)
						end
					end)
				end

				self:addChild(ItemsPanel:create(kITEM_WEAPON, {
					isFilterLocked = true,
					soulid = arg_86_1.servantid
				}, {
					arg_86_1.entityid
				}, var_116_0, ITEMPANEL_TYPE_ROLE_WEAPON), 99)
			end)

			return var_115_0
		end)()
	elseif arg_86_1.showType == "strengthen" then
		var_86_4:setString("魂武强化")

		self.strengthenBtn = var_86_8("small")
	elseif arg_86_1.showType == "bag" then
		var_86_4:setString("")

		self.strengthenBtn = var_86_8("small")
		self.upgradeBnt = var_86_9()
	end

	function self.panel.updateShow(arg_121_0)
		local var_121_0 = require("data.weapon_strengthen" .. var_0_11[arg_86_1.itemid].equip_quality .. "_data")
		local var_121_1 = weapon_manager:getNextLevelAttrValue(arg_86_1.entityid) or ""

		if not var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level + 1] then
			self.strengthenBtn:loadTextures("public/button/public_button_blue_new_off.png.png", "public/button/public_button_blue_new_off.png.png", "public/button/public_button_blue_new_off.png.png", var_0_25)
			self.strengthenBtn:getChildByName("label"):setString("已满级")
			self.strengthenBtn:getChildByName("gold_img"):setVisible(false)
			self.strengthenBtn:getChildByName("gold_num"):setVisible(false)

			if self.strengthenBtn:getChildByName("cost_item") then
				self.strengthenBtn:getChildByName("cost_item"):setVisible(false)
				self.strengthenBtn:getChildByName("cost_item_num"):setVisible(false)
			end

			self.newvalue:setVisible(false)
			var_86_10:setVisible(false)
		else
			self.strengthenBtn:loadTextures("public/button/public_button_blue.png", "public/button/public_button_blue.png", "public/button/public_button_gray.png", var_0_25)
			self.strengthenBtn:getChildByName("label"):setString("强化")
			self.strengthenBtn:getChildByName("gold_num"):setVisible(true)
			self.strengthenBtn:getChildByName("gold_num"):setString(var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost or 100)
			self.newvalue:setVisible(true)
			self.newvalue:setString(var_121_1)
			var_86_10:setVisible(true)

			if var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_item1 then
				if self.strengthenBtn:getChildByName("cost_item") then
					self.strengthenBtn:getChildByName("cost_item"):loadTexture("equipment/" .. var_0_11[var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_item1].image_id .. ".png")
					self.strengthenBtn:getChildByName("cost_item_num"):setString(item_manager:getItemNumber(var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_item1) .. "/" .. var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_num1)
				else
					local var_121_2 = ccui.ImageView:create("equipment/" .. var_0_11[var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_item1].image_id .. ".png")

					var_121_2:setScale(0.4)
					var_121_2:setName("cost_item")
					var_121_2:setAnchorPoint(cc.p(0.5, 1))

					local var_121_3, var_121_4 = self.strengthenBtn:getChildByName("gold_img"):getPosition()

					var_121_2:setPosition(var_121_3, var_121_4 - self.strengthenBtn:getChildByName("gold_img"):getContentSize().height / 2)
					self.strengthenBtn:addChild(var_121_2)

					local var_121_5 = cc.Label:createWithTTF(item_manager:getItemNumber(var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_item1) .. "/" .. var_121_0[playermodel.items[arg_86_1.entityid].weapon_attr.level].cost_num1, FONT_DES, 20)

					var_121_5:setName("cost_item_num")
					var_121_5:setAnchorPoint(cc.p(0, 0.5))

					local var_121_6 = self.strengthenBtn:getChildByName("gold_num")

					var_121_5:setPosition(var_121_6:getPositionX(), var_121_4 - self.strengthenBtn:getChildByName("gold_img").getContentSize(var_121_6).height / 2 - var_121_2:getBoundingBox().height / 2)
					self.strengthenBtn:addChild(var_121_5)
				end
			else
				if self.strengthenBtn:getChildByName("cost_item") then
					self.strengthenBtn:getChildByName("cost_item"):setVisible(false)
				end

				if self.strengthenBtn:getChildByName("cost_item_num") then
					self.strengthenBtn:getChildByName("cost_item_num"):setVisible(false)
				end
			end
		end
	end

	self.panel:updateShow()
	self:fullScreen(var_86_3, self.panel)

	return self.Pop
end

function PopLayer.Weapon_Info(arg_122_0, arg_122_1)
	local var_122_0 = PopLayer.new()

	var_122_0:Weapon_Init(arg_122_1)

	return var_122_0
end

function PopLayer.Core_unlocked(arg_123_0, arg_123_1)
	local var_123_0 = PopLayer.new()
	local var_123_1 = {}

	if arg_123_1 then
		var_123_1 = arg_123_1
	end

	var_123_1.title = "核心解锁"
	var_123_1.bntstr = "确认解锁"

	var_123_0:Upgrade_COST_Init(var_123_1)

	return var_123_0
end

function PopLayer.Core_upgrade(arg_124_0, arg_124_1)
	local var_124_0 = PopLayer.new()
	local var_124_1 = {}

	if arg_124_1 then
		var_124_1 = arg_124_1
	end

	var_124_1.title = "角色突破"
	var_124_1.bntstr = "确认突破"

	var_124_0:Upgrade_COST_Init(var_124_1)

	return var_124_0
end

function PopLayer.Lab_upgrade(arg_125_0, arg_125_1)
	local var_125_0 = PopLayer.new()
	local var_125_1 = {}

	if arg_125_1 then
		var_125_1 = arg_125_1
	end

	var_125_1.title = "车间升级"
	var_125_1.bntstr = "确认升级"

	var_125_0:Upgrade_COST_Init(var_125_1)

	return var_125_0
end

function PopLayer.Servant_breakLimit(arg_126_0, arg_126_1)
	local var_126_0 = PopLayer.new()
	local var_126_1 = {}

	if arg_126_1 then
		var_126_1 = arg_126_1
	end

	var_126_1.title = "角色进阶"
	var_126_1.bntstr = "确认进阶"

	var_126_0:Upgrade_COST_Init(var_126_1)

	return var_126_0
end

function PopLayer.Horcrux_upgrade(arg_127_0, arg_127_1)
	local var_127_0 = PopLayer.new()
	local var_127_1 = {}

	if arg_127_1 then
		var_127_1 = arg_127_1
	end

	var_127_1.title = "魂器进阶"
	var_127_1.bntstr = "确认进阶"

	var_127_0:Upgrade_COST_Init(var_127_1)

	return var_127_0
end

function PopLayer.Horcrux_breakLimit(arg_128_0, arg_128_1)
	local var_128_0 = PopLayer.new()
	local var_128_1 = {}

	if arg_128_1 then
		var_128_1 = arg_128_1
	end

	var_128_1.title = "魂器突破"
	var_128_1.bntstr = "确认突破"

	var_128_0:Upgrade_COST_Init(var_128_1)

	return var_128_0
end

function PopLayer.SwimCost(arg_129_0, arg_129_1)
	local var_129_0 = PopLayer.new()
	local var_129_1 = {}

	if arg_129_1 then
		var_129_1 = arg_129_1
	end

	var_129_1.title = "体能锻炼"

	var_129_0:Upgrade_COST_Init(var_129_1)

	return var_129_0
end

function PopLayer.Weapon_Upgrade(arg_130_0, arg_130_1)
	local var_130_0 = PopLayer.new()
	local var_130_1 = {}

	if arg_130_1 then
		var_130_1 = arg_130_1
	end

	var_130_1.title = "魂武升星"
	var_130_1.bntstr = "升 星"

	var_130_0:Upgrade_COST_Init(var_130_1)

	return var_130_0
end

function PopLayer.Go_Gain_Layer(arg_131_0, arg_131_1)
	if arg_131_1.item ~= "gold" and arg_131_1.item ~= "horcrux" and not var_0_11[arg_131_1.item].targetlayer1 then
		global_ShowBlockWords("暂时没有提供获得该物品的方法")
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	local var_131_0 = PopLayer.new()
	local var_131_1 = {}

	if arg_131_1 then
		var_131_1 = arg_131_1
	end

	var_131_1.methods = {}

	if arg_131_1.item == "gold" then
		var_131_1.methods = {
			{
				systemid = 111,
				des = "前往挖矿",
				callback = arg_131_1.callback
			},
			{
				systemid = 201,
				des = "前往快速搜寻"
			},
			{
				systemid = 154,
				des = "前往回收商店"
			},
			{
				systemid = 500,
				des = "前往出售物品"
			}
		}
		arg_131_1.itemName = L_GOLD
	elseif arg_131_1.item == "horcrux" then
		var_131_1.methods = {
			{
				systemid = 180,
				des = "前往扭蛋"
			},
			{
				systemid = 504,
				des = "魂器碎片合成"
			}
		}
		arg_131_1.itemName = "魂器"
	else
		local var_131_2 = 1

		while var_0_11[arg_131_1.item]["targetdes" .. var_131_2] do
			var_131_2 = var_131_2 + 1
		end

		local var_131_3 = var_0_11[arg_131_1.item].bag_item_type

		for iter_131_0 = 1, var_131_2 - 1 do
			if SYSTEMID[tonumber(var_0_11[arg_131_1.item]["targetlayer" .. iter_131_0])] == "InstanceLayer" or SYSTEMID[tonumber(var_0_11[arg_131_1.item]["targetlayer" .. iter_131_0])] == "MarketLayer" then
				table.insert(var_131_1.methods, {
					des = var_0_11[arg_131_1.item]["targetdes" .. iter_131_0],
					targetlayer = SYSTEMID[var_0_11[arg_131_1.item]["targetlayer" .. iter_131_0]],
					targettype = ITEMS_TARGETTYPE[var_131_3],
					returnlayer = arg_131_1.returnlayer,
					systemid = var_0_11[arg_131_1.item]["targetlayer" .. iter_131_0]
				})
			elseif var_0_11[arg_131_1.item]["targetdes" .. iter_131_0] and var_0_11[arg_131_1.item]["targetlayer" .. iter_131_0] then
				table.insert(var_131_1.methods, {
					des = var_0_11[arg_131_1.item]["targetdes" .. iter_131_0],
					targetlayer = SYSTEMID[tonumber(var_0_11[arg_131_1.item]["targetlayer" .. iter_131_0])],
					systemid = var_0_11[arg_131_1.item]["targetlayer" .. iter_131_0]
				})
			end
		end
	end

	if var_131_1.methods and next(var_131_1.methods) ~= nil then
		var_131_0:Go_Gain_Init(var_131_1)
	else
		global_ShowBlockWords("暂时没有提供获得该物品的方法")
		audio_manager:playeffectMusicTest("sound/invalid")
	end

	return var_131_0
end

function PopLayer.Go_Gain_Gift(arg_132_0, arg_132_1)
	local var_132_0 = PopLayer.new()
	local var_132_1 = {
		goto_back_system_id = 700
	}

	if arg_132_1 then
		var_132_1 = arg_132_1
	end

	var_132_1.item = 6700102
	var_132_1.itemName = "礼物"
	var_132_1.methods = {
		{
			systemid = 1505,
			des = "学院商城补给处购买"
		}
	}

	var_132_0:Go_Gain_Init(var_132_1)

	return var_132_0
end

function PopLayer.Go_Gain_Jinjie(arg_133_0, arg_133_1)
	local var_133_0 = PopLayer.new()
	local var_133_1 = {}

	if arg_133_1 then
		var_133_1 = arg_133_1
	end

	var_133_1.methods = {}

	table.insert(var_133_1.methods, {
		targetlayer = "FightLayer",
		des = "击杀主线各难度BOSS"
	})
	table.insert(var_133_1.methods, {
		targetlayer = "MarketLayer",
		returnlayer = "FightLayer",
		des = "火爆商品商城直接购买",
		targettype = SHOP_TYPE_TOOL
	})
	var_133_0:Go_Gain_Init(var_133_1)

	return var_133_0
end

function PopLayer.Go_Gain_Material(arg_134_0, arg_134_1)
	local var_134_0 = PopLayer.new()
	local var_134_1 = {}

	if arg_134_1 then
		var_134_1 = arg_134_1
	end

	var_134_1.methods = {}

	table.insert(var_134_1.methods, {
		targetlayer = "InstanceLayer",
		des = "挑战对应的试炼副本"
	})
	table.insert(var_134_1.methods, {
		targetlayer = "MarketLayer",
		des = "火爆商品商城直接购买"
	})
	var_134_0:Go_Gain_Init(var_134_1)

	return var_134_0
end

function PopLayer.Go_Gain_Key(arg_135_0, arg_135_1)
	local var_135_0 = PopLayer.new()
	local var_135_1 = {}

	if arg_135_1 then
		var_135_1 = arg_135_1
	end

	var_135_1.methods = {}

	table.insert(var_135_1.methods, {
		targetlayer = "MarketLayer",
		des = "喵酱商店低概率刷新出"
	})
	table.insert(var_135_1.methods, {
		targetlayer = "MarketLayer",
		des = "限时特卖商城直接购买"
	})
	var_135_0:Go_Gain_Init(var_135_1)

	return var_135_0
end

function PopLayer.Go_Gain_Tickets_AD(arg_136_0, arg_136_1)
	local var_136_0 = PopLayer.new()
	local var_136_1 = {}

	if arg_136_1 then
		var_136_1 = arg_136_1
	end

	var_136_1.methods = {}

	table.insert(var_136_1.methods, {
		targetlayer = "ChooseLayer",
		des = "通关主线高难度章节"
	})
	var_136_0:Go_Gain_Init(var_136_1)

	return var_136_0
end

function PopLayer.Go_Buy_Diamond(arg_137_0, arg_137_1)
	local var_137_0 = PopLayer.new()
	local var_137_1 = {}

	if arg_137_1 then
		var_137_1 = arg_137_1
	end

	var_137_1.labels = L_GO_BUY_DIAMOND
	var_137_1.targetlayer = var_137_1.is_need_pop_layer and "PopSupermarketLayer" or "SupermarketLayer"

	var_137_0:Go_Init(var_137_1)

	return var_137_0
end

function PopLayer.Go_Buy_Gold(arg_138_0, arg_138_1)
	local var_138_0 = PopLayer.new()
	local var_138_1 = {}

	if arg_138_1 then
		var_138_1 = arg_138_1
	end

	var_138_1.labels = L_GO_BUY_GOLD
	var_138_1.targetlayer = "HandOfMidasLayer"

	var_138_0:Go_Init(var_138_1)

	return var_138_0
end

function PopLayer.Go_Lab_Smelt(arg_139_0, arg_139_1)
	local var_139_0 = PopLayer.new()
	local var_139_1 = {}

	if arg_139_1 then
		var_139_1 = arg_139_1
	end

	var_139_1.labels = L_GO_LAB_SMELT
	var_139_1.targetlayer = "SmeltLayer"

	var_139_0:Go_Init(var_139_1)

	return var_139_0
end

function PopLayer.Go_Contract(arg_140_0, arg_140_1)
	local var_140_0 = PopLayer.new()
	local var_140_1 = {}

	if arg_140_1 then
		var_140_1 = arg_140_1
	end

	var_140_1.labels = L_GO_CONTRACT
	var_140_1.targetlayer = "EquipLayer"

	var_140_0:Go_Init(var_140_1)

	return var_140_0
end

function PopLayer.Go_Buy_Tickets_Twist(arg_141_0, arg_141_1)
	local var_141_0 = PopLayer.new()
	local var_141_1 = {}

	if arg_141_1 then
		var_141_1 = arg_141_1
	end

	var_141_1.methods = {}

	table.insert(var_141_1.methods, {
		targetlayer = "MarketLayer",
		des = "喵酱商店低概率刷新出"
	})
	table.insert(var_141_1.methods, {
		targetlayer = "MarketLayer",
		des = "限时特卖商城直接购买"
	})
	table.insert(var_141_1.methods, {
		targetlayer = "ChooseLayer",
		des = "主线部分BOSS掉落"
	})
	var_141_0:Go_Gain_Init(var_141_1)

	return var_141_0
end

function PopLayer.Go_Buy_Tickets_Twist_Diamond(arg_142_0, arg_142_1)
	local var_142_0 = PopLayer.new()
	local var_142_1 = {}

	if arg_142_1 then
		var_142_1 = arg_142_1
	end

	var_142_1.labels = {}
	var_142_1.labels.button = L_COMPONENT_TWIST.button
	var_142_1.labels.title = L_COMPONENT_TWIST.title
	var_142_1.labels.titleImage = L_COMPONENT_TWIST.titleImage
	var_142_1.labels.des = arg_142_1.des and arg_142_1.des or "消耗" .. L_DIAMOND .. "购买扭蛋券~"

	var_142_0:Do_Init(var_142_1)

	return var_142_0
end

function PopLayer.Go_Buy_Tickets_Skin_Card(arg_143_0, arg_143_1)
	local var_143_0 = PopLayer.new()
	local var_143_1 = {}

	if arg_143_1 then
		var_143_1 = arg_143_1
	end

	var_143_1.labels = {}
	var_143_1.labels.button = L_SKIN_CARD.button
	var_143_1.labels.title = L_SKIN_CARD.title
	var_143_1.labels.des = arg_143_1.des and arg_143_1.des or "消耗" .. L_DIAMOND .. "购买服装卷~"

	var_143_0:Do_Init(var_143_1)

	return var_143_0
end

function PopLayer.Go_Buy_Tickets_Gift_Card(arg_144_0, arg_144_1)
	local var_144_0 = PopLayer.new()
	local var_144_1 = {}

	if arg_144_1 then
		var_144_1 = arg_144_1
	end

	var_144_1.labels = {}
	var_144_1.labels.button = L_GIFT_CARD.button
	var_144_1.labels.title = L_GIFT_CARD.title
	var_144_1.labels.des = arg_144_1.des and arg_144_1.des or "消耗" .. L_DIAMOND .. "购买礼物卷~"

	var_144_0:Do_Init(var_144_1)

	return var_144_0
end

function PopLayer.Go_Buy_Tickets_Furniture_Card(arg_145_0, arg_145_1)
	local var_145_0 = PopLayer.new()
	local var_145_1 = {}

	if arg_145_1 then
		var_145_1 = arg_145_1
	end

	var_145_1.labels = {}
	var_145_1.labels.button = L_FURNITURE_CARD.button
	var_145_1.labels.title = L_FURNITURE_CARD.title
	var_145_1.labels.des = arg_145_1.des and arg_145_1.des or "消耗" .. L_DIAMOND .. "购买家具币~"

	var_145_0:Do_Init(var_145_1)

	return var_145_0
end

function PopLayer.Add_refresh_Times_ScoreArena(arg_146_0, arg_146_1)
	local var_146_0 = PopLayer.new()
	local var_146_1 = {}

	if arg_146_1 then
		var_146_1 = arg_146_1
	end

	var_146_1.labels = {}
	var_146_1.labels.button = L_GO_BUY_SCOREARENA_TIMES.button
	var_146_1.labels.des = L_GO_BUY_SCOREARENA_TIMES.des

	var_146_0:Do_Init(var_146_1)

	return var_146_0
end

function PopLayer.Go_Buy_Tickets_QuickFight_Diamond(arg_147_0, arg_147_1)
	local var_147_0 = PopLayer.new()
	local var_147_1 = arg_147_1 or {}

	var_147_1.labels = {
		button = L_COMPONENT_QUICKFIGHT.button,
		title = L_COMPONENT_QUICKFIGHT.title,
		des = L_COMPONENT_QUICKFIGHT.des
	}

	var_147_0:Do_Init(var_147_1)

	return var_147_0
end

function PopLayer.Go_Send_Gift_Diamond(arg_148_0, arg_148_1)
	local var_148_0 = PopLayer.new()
	local var_148_1 = arg_148_1 or {}

	var_148_1.labels = {
		button = L_MORE_GIFT.button,
		title = L_MORE_GIFT.title,
		des = L_MORE_GIFT.des,
		more = var_148_1.more
	}

	var_148_0:Do_Init(var_148_1)

	return var_148_0
end

function PopLayer.Go_Buy_Baglimit_Component(arg_149_0, arg_149_1)
	local var_149_0 = PopLayer.new()
	local var_149_1 = {}

	if arg_149_1 then
		var_149_1 = arg_149_1
	end

	var_149_1.labels = L_GO_BUY_BAGLIMIT_COMPONENT
	var_149_1.targetlayer = "BagLayer"

	var_149_0:Go_Init(var_149_1)

	return var_149_0
end

function PopLayer.Go_Buy_Baglimit_Eatable(arg_150_0, arg_150_1)
	local var_150_0 = PopLayer.new()
	local var_150_1 = {}

	if arg_150_1 then
		var_150_1 = arg_150_1
	end

	var_150_1.labels = L_GO_BUY_BAGLIMIT_EATABLE
	var_150_1.targetlayer = "BagLayer"

	var_150_0:Go_Init(var_150_1)

	return var_150_0
end

function PopLayer.Go_Buy_Baglimit_Weapon(arg_151_0, arg_151_1)
	local var_151_0 = PopLayer.new()
	local var_151_1 = {}

	if arg_151_1 then
		var_151_1 = arg_151_1
	end

	var_151_1.labels = L_GO_BUY_BAGLIMIT_WEAPON
	var_151_1.targetlayer = "BagLayer"

	var_151_0:Go_Init(var_151_1)

	return var_151_0
end

function PopLayer.Go_Buy_Baglimit_Horcrux(arg_152_0, arg_152_1)
	local var_152_0 = PopLayer.new()
	local var_152_1 = {}

	if arg_152_1 then
		var_152_1 = arg_152_1
	end

	var_152_1.labels = L_GO_BUY_BAGLIMIT_HORCRUX
	var_152_1.targetlayer = "BagLayer"

	var_152_0:Go_Init(var_152_1)

	return var_152_0
end

function PopLayer.Go_Buy_Baglimit_Element(arg_153_0, arg_153_1)
	local var_153_0 = PopLayer.new()
	local var_153_1 = {}

	if arg_153_1 then
		var_153_1 = arg_153_1
	end

	var_153_1.labels = L_GO_BUY_BAGLIMIT_ELEMENT
	var_153_1.targetlayer = "BagLayer"

	var_153_0:Go_Init(var_153_1)

	return var_153_0
end

function PopLayer.Help_Adventure_Nonetimes(arg_154_0, arg_154_1)
	local var_154_0 = PopLayer.new()

	var_154_0:Go(L_GO_BUY_DIAMOND, L_GO_BUY_DIAMOND_TITLE, L_GO_BUY_DIAMOND_DES, nil, arg_154_1)

	return var_154_0
end

function PopLayer.Quick_Fight(arg_155_0, arg_155_1)
	print("Quick_Fight remove from PopLayer, add With LayerManager!!!!")
end

function PopLayer.Refresh_Market(arg_156_0, arg_156_1)
	local var_156_0 = PopLayer.new()
	local var_156_1 = {}

	if arg_156_1 then
		var_156_1 = arg_156_1
	end

	var_156_1.labels = {}
	var_156_1.labels.button = L_REFRESH_MARKET[var_156_1.markettype].button
	var_156_1.labels.title = L_REFRESH_MARKET[var_156_1.markettype].title
	var_156_1.labels.des = L_REFRESH_MARKET[var_156_1.markettype].des
	var_156_1.labels.more = L_REFRESH_MARKET[var_156_1.markettype].more .. var_156_1.remaintimes .. "/" .. var_156_1.totaltimes

	var_156_0:Do_Init(var_156_1)

	return var_156_0
end

function PopLayer.Quick_Finish_Help_Adventure(arg_157_0, arg_157_1)
	local var_157_0 = PopLayer.new()
	local var_157_1 = {}

	if arg_157_1 then
		var_157_1 = arg_157_1
	end

	var_157_1.labels = {}
	var_157_1.labels.button = L_QUICK_FINISH_HELP_ADVENTURE.button
	var_157_1.labels.title = L_QUICK_FINISH_HELP_ADVENTURE.title
	var_157_1.labels.des = L_QUICK_FINISH_HELP_ADVENTURE.des
	var_157_1.labels.more = L_QUICK_FINISH_HELP_ADVENTURE.more .. math.floor(var_157_1.remaintime / 60) .. "min"

	var_157_0:Do_Init(var_157_1)

	return var_157_0
end

function PopLayer.Quick_Finish_Gem(arg_158_0, arg_158_1)
	local var_158_0 = PopLayer.new()
	local var_158_1 = {}

	if arg_158_1 then
		var_158_1 = arg_158_1
	end

	var_158_1.labels = {}
	var_158_1.labels.button = L_QUICK_FINISH_GEM.button
	var_158_1.labels.title = L_QUICK_FINISH_GEM.title
	var_158_1.labels.des = L_QUICK_FINISH_GEM.des
	var_158_1.labels.more = L_QUICK_FINISH_GEM.more .. math.floor(var_158_1.remaintime / 60) .. "min"

	var_158_0:Do_Init(var_158_1)

	return var_158_0
end

function PopLayer.Quick_Finish_Compound(arg_159_0, arg_159_1)
	local var_159_0 = PopLayer.new()
	local var_159_1 = {}

	if arg_159_1 then
		var_159_1 = arg_159_1
	end

	var_159_1.labels = {}
	var_159_1.labels.button = L_QUICK_FINISH_COMPOUND.button
	var_159_1.labels.title = L_QUICK_FINISH_COMPOUND.title
	var_159_1.labels.des = L_QUICK_FINISH_COMPOUND.des
	var_159_1.labels.more = L_QUICK_FINISH_COMPOUND.more .. math.floor(var_159_1.remaintime / 60) .. "min"

	var_159_0:Do_Init(var_159_1)

	return var_159_0
end

function PopLayer.Add_Baglimit_Element(arg_160_0, arg_160_1)
	local var_160_0 = PopLayer.new()
	local var_160_1 = {} and arg_160_1

	var_160_1.labels = L_ADD_BAGLIMIT_ELEMENT

	var_160_0:Do_Init(var_160_1)

	return var_160_0
end

function PopLayer.Add_Baglimit_Component(arg_161_0, arg_161_1)
	local var_161_0 = PopLayer.new()
	local var_161_1 = {} and arg_161_1

	var_161_1.labels = L_ADD_BAGLIMIT_COMPONENT

	var_161_0:Do_Init(var_161_1)

	return var_161_0
end

function PopLayer.Add_Instance_Times(arg_162_0, arg_162_1)
	local var_162_0 = PopLayer.new()
	local var_162_1 = {} and arg_162_1

	var_162_1.labels = L_ADD_INSTANCE_TIMES

	var_162_0:Do_Init(var_162_1)

	return var_162_0
end

function PopLayer.Detach_Component(arg_163_0, arg_163_1)
	local var_163_0 = PopLayer.new()

	arg_163_1.labels = L_DETACH_COMPONENT

	var_163_0:Do_Init(arg_163_1)

	return var_163_0
end

function PopLayer.Change_Component(arg_164_0, arg_164_1)
	local var_164_0 = PopLayer.new()

	arg_164_1.labels = L_CHANGE_COMPONENT

	var_164_0:Do_Init(arg_164_1)

	return var_164_0
end

function PopLayer.Compound_remind(arg_165_0, arg_165_1)
	local var_165_0 = PopLayer.new()
	local var_165_1 = {} and arg_165_1

	var_165_1.labels = {
		title = "合成晶体",
		button = "确认合成",
		des = "消耗卷轴与晶体花费" .. arg_165_1.costtime / 60 .. "min合成更高级晶体",
		more = arg_165_1.level .. "级车间,时间加速" .. arg_165_1.speed * 100 + 100 .. "%,只需" .. arg_165_1.costtime * (1 - arg_165_1.speed) / 60 .. "min"
	}

	var_165_0:Do_Init(var_165_1)

	return var_165_0
end

function PopLayer.Add_arena_times(arg_166_0, arg_166_1)
	local var_166_0 = PopLayer.new()
	local var_166_1 = {}

	if arg_166_1 then
		var_166_1 = arg_166_1
	end

	var_166_1.labels = {}
	var_166_1.labels.button = "确认购买"
	var_166_1.labels.title = "回复竞赛次数"
	var_166_1.labels.des = "花费" .. L_DIAMOND .. "回复次数"
	var_166_1.labels.more = string.format("%d" .. L_DIAMOND .. "回复1次~~~~", arg_166_1.cost)

	var_166_0:Do_Init(var_166_1)

	return var_166_0
end

function PopLayer.cb_Exit(arg_167_0, arg_167_1, arg_167_2)
	global_window_close_action(arg_167_2, function()
		arg_167_1:runAction(cc.RemoveSelf:create())
	end)
end

function PopLayer:Show_Sculture_Init(arg_169_1)
	self.Pop = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_sculture.json" or "Pop_sculture.ExportJson")

	self:addChild(self.Pop)

	local var_169_0 = ccui.Helper:seekWidgetByName(self.Pop, "bg")

	self.Pop:addTouchEventListener(function(arg_170_0, arg_170_1)
		if arg_170_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_170_0:setTouchEnabled(false)
		self.cb_Exit(self, self, var_169_0)
	end)
	global_window_open_action(ccui.Helper:seekWidgetByName(self.Pop, "bg"))

	self.callback = arg_169_1.callback
	self.confirm_button = ccui.Helper:seekWidgetByName(self.Pop, "confirm_button")

	self.confirm_button:addTouchEventListener(function(arg_171_0, arg_171_1)
		if arg_171_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_171_0:setTouchEnabled(false)
		self.Pop:setTouchEnabled(false)
		playermodel:setHeadSoul(self.scultures[self.cur_selected.key].itemid, function(arg_172_0)
			if self.callback then
				self.callback()
			end

			if arg_172_0 == 2 then
				global_ShowBlockWords("未拥有头像QAQ")
				audio_manager:playeffectMusicTest("sound/invalid")
			elseif arg_172_0 == 3 then
				global_ShowBlockWords("头像已过期")
				audio_manager:playeffectMusicTest("sound/invalid")
			end

			self.cb_Exit(self, self, var_169_0)
		end)
	end)

	self.scultures = arg_169_1.scultures

	local var_169_1 = math.ceil(#self.scultures / 3)

	self.cur_selected = nil
	self.tableView = cc.TableView:create(cc.size(488, 395))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(10, 25)
	self.tableView:setDelegate()
	self.Pop:getChildByName("bg"):addChild(self.tableView, 2)

	local var_169_2 = 488
	local var_169_3 = 180

	local function var_169_4(arg_173_0)
		local var_173_0 = ccui.Button:create()

		var_173_0:loadTextures("public/rolebg/icon_bg.png", "public/rolebg/icon_bg.png", "public/rolebg/icon_bg.png", var_0_25)
		var_173_0:setName(arg_173_0)
		var_173_0:setAnchorPoint(cc.p(0.5, 0.5))

		local var_173_1 = ccui.ImageView:create()

		var_173_1:setName("icon")
		var_173_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_173_1:setPosition(var_173_0:getContentSize().width / 2, var_173_0:getContentSize().height / 2)
		var_173_0:addChild(var_173_1)

		local var_173_2 = ccui.ImageView:create()

		var_173_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_173_2:setPosition(var_173_0:getContentSize().width / 2, 35)
		var_173_2:setName("selected")
		var_173_0:addChild(var_173_2)
		var_173_0:setContentSize(var_173_1:getContentSize().width * 0.7, var_173_1:getContentSize().height * 0.7)
		var_173_0:setTouchEnabled(true)
		var_173_0:setSwallowTouches(false)
		var_173_0:setScale(0.7)
		var_173_2:setScale(1.4285714285714286)
		var_173_0:addTouchEventListener(function(arg_174_0, arg_174_1)
			if arg_174_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_174_0:getTouchBeganPosition().x - arg_174_0:getTouchEndPosition().x) > 50 then
				return
			end

			if arg_174_0.selected then
				return
			end

			arg_174_0.selected = true
			self.scultures[arg_174_0.key].selected = true

			if self.cur_selected then
				self.cur_selected.selected = false

				self.cur_selected:getChildByName("selected"):loadTexture("Class/icon_normal.png", var_0_25)

				self.scultures[self.cur_selected.key].selected = false
			end

			self.cur_selected = arg_174_0

			self.cur_selected:getChildByName("selected"):loadTexture("Class/icon_selected.png", var_0_25)
		end)

		return var_173_0
	end

	self.tableView:registerScriptHandler(function(arg_176_0, arg_176_1)
		return var_169_2, var_169_3
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_175_0, arg_175_1)
		local var_175_0 = arg_175_0:dequeueCell()

		if var_175_0 then
			for iter_175_0 = 1, 3 do
				if self.scultures[(var_169_1 - arg_175_1 - 1) * 3 + iter_175_0] then
					var_175_0:getChildByName(iter_175_0).key = (var_169_1 - arg_175_1 - 1) * 3 + iter_175_0

					var_175_0:getChildByName(iter_175_0):setVisible(true)
					var_175_0:getChildByName(iter_175_0):getChildByName("icon"):loadTexture("roleimage/role/wuji/" .. var_0_11[self.scultures[(var_169_1 - arg_175_1 - 1) * 3 + iter_175_0].itemid].image_id .. ".png")

					if self.scultures[(var_169_1 - arg_175_1 - 1) * 3 + iter_175_0].selected then
						self.cur_selected = var_175_0:getChildByName(iter_175_0)
						var_175_0:getChildByName(iter_175_0).selected = true

						var_175_0:getChildByName(iter_175_0):getChildByName("selected"):loadTexture("Class/icon_selected.png", var_0_25)
					else
						var_175_0:getChildByName(iter_175_0).selected = false

						var_175_0:getChildByName(iter_175_0):getChildByName("selected"):loadTexture("Class/icon_normal.png", var_0_25)
					end
				else
					var_175_0:getChildByName(iter_175_0):setVisible(false)
				end
			end
		else
			var_175_0 = cc.TableViewCell:create()

			for iter_175_1 = 1, 3 do
				local var_175_1 = var_169_4(iter_175_1)

				var_175_1:setPosition((iter_175_1 - 1) * 150 - 10, var_169_3 * 0.6 / 2 - 50)
				var_175_0:addChild(var_175_1)

				if self.scultures[(var_169_1 - arg_175_1 - 1) * 3 + iter_175_1] then
					var_175_0:getChildByName(iter_175_1).key = (var_169_1 - arg_175_1 - 1) * 3 + iter_175_1

					var_175_0:getChildByName(iter_175_1):setVisible(true)
					var_175_0:getChildByName(iter_175_1):getChildByName("icon"):loadTexture("roleimage/role/wuji/" .. var_0_11[self.scultures[(var_169_1 - arg_175_1 - 1) * 3 + iter_175_1].itemid].image_id .. ".png")

					if self.scultures[(var_169_1 - arg_175_1 - 1) * 3 + iter_175_1].selected then
						self.cur_selected = var_175_0:getChildByName(iter_175_1)
						var_175_0:getChildByName(iter_175_1).selected = true

						var_175_0:getChildByName(iter_175_1):getChildByName("selected"):loadTexture("Class/icon_selected.png", var_0_25)
					else
						var_175_0:getChildByName(iter_175_1).selected = false

						var_175_0:getChildByName(iter_175_1):getChildByName("selected"):loadTexture("Class/icon_normal.png", var_0_25)
					end
				else
					var_175_0:getChildByName(iter_175_1):setVisible(false)
				end
			end
		end

		return var_175_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_177_0, arg_177_1)
		return var_169_1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
	self:fullScreen(ccui.Helper:seekWidgetByName(self.Pop, "Panel_39"), self.Pop:getChildByName("bg"))
end

function PopLayer.Pop_Sculture_Layer(arg_178_0, arg_178_1)
	local var_178_0 = PopLayer.new()

	var_178_0:Show_Sculture_Init(arg_178_1)

	return var_178_0
end

function PopLayer.Pop_Create_Settlement_ItemList(arg_179_0, arg_179_1)
	local var_179_0 = cc.Layer:create()
	local var_179_1 = 0
	local var_179_2 = 140
	local var_179_3 = 133
	local var_179_4 = #arg_179_1
	local var_179_5 = ccui.ScrollView:create()

	var_179_5:setContentSize(cc.size(425, 320))
	var_179_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_179_5:setPosition(cc.p(0, 0))
	var_179_5:setDirection(ccui.ScrollViewDir.horizontal)
	var_179_5:setInnerContainerSize(cc.size(var_179_3 * var_179_4, 320))
	var_179_5:setBounceEnabled(true)
	var_179_0:addChild(var_179_5)

	local var_179_6 = ccui.Layout:create()

	if var_179_4 > 4 then
		var_179_6:setPosition(cc.p(0, 320 / 2))
		var_179_6:setContentSize(cc.size(var_179_3 * (var_179_4 - 1), 320))

		var_179_1 = var_179_3 * (var_179_4 - 1) / 2
	else
		var_179_6:setPosition(cc.p(0, 320 / 2))
		var_179_6:setContentSize(cc.size(425, 320))

		var_179_1 = 425 / 2
	end

	var_179_6:setAnchorPoint(cc.p(0, 0.5))
	var_179_5:addChild(var_179_6)

	for iter_179_0 = 1, var_179_4 do
		local var_179_8 = var_179_3 * (iter_179_0 - 1) + var_179_3 / 2
		local var_179_9

		if arg_179_1[iter_179_0].itemtype == kITEM_HORCRUX then
			require("view.Sprite.HorcruxSprite")

			var_179_9 = HorcruxSprite:create()

			var_179_9:setScale(0.7)
			var_179_9:updateHorcruxInfos(arg_179_1[iter_179_0].entityid, false)
		else
			var_179_9 = arg_179_1[iter_179_0].itemtype == kITEM_WEAPON and ItemSprite:createNewWithItemId(arg_179_1[iter_179_0].itemid, nil, nil, var_0_11[arg_179_1[iter_179_0].itemid].name, arg_179_1[iter_179_0].weapon_attr and "maxStars=" .. arg_179_1[iter_179_0].weapon_attr.maxStars .. "&" .. "nowStars=" .. arg_179_1[iter_179_0].weapon_attr.nowStars or arg_179_1[iter_179_0].drop_extra) or arg_179_1[iter_179_0].itemtype == kITEM_COMPONENT and ItemSprite:createNewWithItemId(arg_179_1[iter_179_0].itemid, nil, nil, var_0_11[arg_179_1[iter_179_0].itemid].name, arg_179_1[iter_179_0].component_attr and "effect=" .. arg_179_1[iter_179_0].component_attr.effect or arg_179_1[iter_179_0].drop_extra) or ItemSprite:createNewWithItemId(arg_179_1[iter_179_0].itemid, arg_179_1[iter_179_0].itemcount)
		end

		var_179_9:setScale(0.7)
		var_179_9:setAnchorPoint(cc.p(0.5, 0.5))
		var_179_9:setPosition(var_179_8, var_179_2)
		var_179_6:addChild(var_179_9, 1)
	end

	return var_179_0, var_179_4
end

function PopLayer.Pop_Chapter_Settlement(arg_180_0, arg_180_1)
	print("move PopLayer:Pop_Chapter_Settlement to PopMainLineResultLayer!!!!!, Please Use it In LayerManager")
end

function PopLayer.Pop_Pvp_Settlement(arg_181_0, arg_181_1)
	print("move PopLayer:Pop_Pvp_Settlement to PvpResultLayer!!!!!, Please Use it In LayerManager")
end

function PopLayer.Pop_Adv_Settlement(arg_182_0, arg_182_1)
	print("Pop_Adv_Settlement move to LayerManager!!!!, Please Use There")
end

function PopLayer.popGainGold(arg_183_0, arg_183_1, arg_183_2)
	local var_183_0 = {
		item = "gold",
		goto_back_system_id = arg_183_1
	}

	if arg_183_2 then
		var_183_0.callback = arg_183_2.callback or nil
	end

	local var_183_1 = PopLayer:Go_Gain_Layer(var_183_0)

	print("1111111111111111111111")

	if var_183_1 then
		cc.Director:getInstance():getRunningScene():addChild(var_183_1, 999)
	end
end
