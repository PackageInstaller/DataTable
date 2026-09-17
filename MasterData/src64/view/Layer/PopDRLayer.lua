PopDRLayer = class("PopDRLayer", function()
	return cc.Layer:create()
end)

local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local cook_manager = require("controller.cook_manager")
local dormitory_manager = require("controller.dormitory_manager")
local item_data = require("data.item_data")

require("view.Sprite.ItemSprite")

local var_0_6 = config._DEBUG and 0 or 1
local var_0_7

function PopDRLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopDRLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopDRLayer.getInstance()
	return var_0_7
end

function PopDRLayer:init(arg_4_1)
	var_0_7 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "dorm_DR_pop.json" or "dorm_DR_pop.ExportJson")

	self:addChild(self.rootLayer)

	self.Bg = self.rootLayer:getChildByName("Bg")
	self.sureButton = self.rootLayer:getChildByName("Button_feed")
	self.cancelButton = self.rootLayer:getChildByName("Button_drive_away")
	self.cancelCallback = arg_4_1.cancelcallback
	self.sureCallback = arg_4_1.surecallback
	self.hostSoul = arg_4_1.hostSoul
	self.menuid = playermodel.soulsDRstatus[arg_4_1.hostSoul]
	self.menuInfo = require("data.food_production.menu.menu" .. arg_4_1.hostSoul .. "_data")[playermodel.soulsDRstatus[arg_4_1.hostSoul]]
	self.foodid = self.menuInfo.eatables

	print("::::menuid:::", self.menuid)
	print(":::::HOST::::", self.hostSoul)
	print(":::::guest::::", self.menuInfo.guest)

	if item_data[self.foodid].bag_item_type == kITEM_FOOD then
		self.showType = "food"
	elseif item_data[self.foodid].bag_item_type == kITEM_EATABLES then
		self.showType = "eatable"
		self.baseFoods = cook_manager:getBaseFoods(self.foodid)
	end

	self:registerTouchEvent()
	self:initUI()

	if ListButtonLayer.getInstance() then
		ListButtonLayer.getInstance():hideLayer()
	end

	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_7 = nil
		end

		if ListButtonLayer.getInstance() then
			ListButtonLayer.getInstance():showLayer()
		end
	end)
end

function PopDRLayer:registerTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)
	self.cancelButton:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_8_0:setTouchEnabled(false)
		dormitory_manager:driveSoulAwayFromDR(function(arg_9_0)
			self:runAction(cc.RemoveSelf:create())

			if arg_9_0.result == 1 then
				if self.cancelCallback then
					self.cancelCallback(self.menuInfo.DR_script_out3, require("data.food_production.menu.menu" .. arg_9_0.host .. "_data")[arg_9_0.menuid].DR_script_in)
				end
			elseif (arg_9_0.result == 2 or arg_9_0.result == 3) and self.cancelCallback then
				self.cancelCallback(self.menuInfo.DR_script_out3)
			end
		end)
	end)
	self.sureButton:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showType == "food" then
			if self.foodImg.status == "no" then
				global_ShowBlockWords(L_FOOD_LACK)
			elseif self.foodImg.status == "have" then
				cook_manager:feedFood(self.foodid, self.menuid, self.hostSoul, function(arg_11_0, arg_11_1)
					self:runAction(cc.RemoveSelf:create())
					self.sureCallback("food", arg_11_0, arg_11_1)
				end)
			end
		elseif self.showType == "eatable" then
			local var_10_0 = cook_manager:isReadyCook(self.foodid)

			if var_10_0 == 1 then
				LayerManager:pushInLayer("CookLayer", self.foodid, self.menuid, self.hostSoul, function(arg_12_0, arg_12_1, arg_12_2)
					self:runAction(cc.RemoveSelf:create())
					self.sureCallback("eatable", arg_12_0, arg_12_1, arg_12_2)
				end)
			elseif var_10_0 == 2 then
				global_ShowBlockWords(L_COOK_WARNING[2])
			elseif var_10_0 == 3 then
				global_ShowBlockWords(L_COOK_WARNING[3])
			end
		end
	end)
end

local var_0_8 = 650
local var_0_9 = 780
local var_0_10 = 900

function PopDRLayer:initUI()
	({
		food = function()
			local var_14_0 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_6)

			var_14_0:setPosition(self.Bg:getContentSize().width / 2, self.Bg:getContentSize().height / 2)
			self.Bg:addChild(var_14_0)

			self.foodImg = ItemSprite:createNewWithItemId(self.foodid)

			self.foodImg:setPosition(var_14_0:getContentSize().width / 2, var_14_0:getContentSize().height / 2)
			var_14_0:addChild(self.foodImg)
			self.sureButton:setTitleText(L_EAT)

			if item_manager:haveItem(self.foodid) then
				self.foodImg.status = "have"
			else
				self.foodImg:setOpacity(120)

				self.foodImg.status = "no"

				if config._DEBUG then
					var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
						if arg_15_1 ~= ccui.TouchEventType.ended then
							return
						end

						arg_15_0:setTouchEnabled(false)
						network:rpc("get_items", {
							num = 1,
							itemtype = self.foodid
						}, function(arg_16_0)
							if arg_16_0.result == 1 then
								global_riseWord(L_ROLE_WEAPON_SUCCESS)
								print_lua_table(arg_16_0.items)
								item_manager:setItemByServerItem(arg_16_0.items[1])
								arg_15_0:setTouchEnabled(true)
								self.foodImg:setOpacity(255)

								self.foodImg.status = "have"
							end
						end)
					end)
				else
					var_14_0:addTouchEventListener(function(arg_17_0, arg_17_1)
						if arg_17_1 ~= ccui.TouchEventType.ended then
							return
						end

						popmsg = {
							item = self.foodid
						}

						local var_17_0 = PopLayer:Go_Gain_Layer(popmsg)

						if var_17_0 then
							cc.Director:getInstance():getRunningScene():addChild(var_17_0, 999)
						end
					end)
				end
			end
		end,
		eatable = function()
			local var_18_0 = ccui.Layout:create()

			self:addChild(var_18_0, 1)

			local var_18_1 = cc.DrawNode:create()

			var_18_0:addChild(var_18_1, 10)

			local function var_18_2(arg_19_0, arg_19_1)
				var_18_1:drawSegment(arg_19_0, arg_19_1, 1, cc.c4f(0.4745098039215686, 0.5176470588235295, 0.6313725490196078, 1))
			end

			self.foodImg = ItemSprite:createNewWithItemId(self.foodid, 1)

			self.foodImg:setPosition(cc.p(SCREEN_WIDTH / 2, var_0_10))
			self.foodImg:setScale(0.6)
			var_18_0:addChild(self.foodImg, 11)
			var_18_2(cc.p(SCREEN_WIDTH / 2, var_0_10 - self.foodImg:getBoundingBox().height / 2 - 5), cc.p(SCREEN_WIDTH / 2, var_0_9))
			print("!!!!!!!!!!!!!!!!!!", self.foodImg:getBoundingBox().height / 2)

			local var_18_3 = #self.baseFoods
			local var_18_4 = #self.baseFoods - 1 == 0 and 0 or 360 / (#self.baseFoods - 1)
			local var_18_5 = item_data[self.foodid].pot_id
			local var_18_6 = ccui.ImageView:create("public/box/new_item_bg_touming.png", var_0_6)

			var_18_6:setScale(0.6)
			var_18_6:setPosition(SCREEN_WIDTH / 2, var_0_10 - 420)
			var_18_0:addChild(var_18_6)

			local var_18_7 = ItemSprite:createNewWithItemId(var_18_5)

			var_18_7:setPosition(var_18_6:getContentSize().width / 2, var_18_6:getContentSize().height / 2)
			var_18_6:addChild(var_18_7)

			if not item_manager:isHaveEnoughItem(var_18_5) then
				var_18_7:setOpacity(120)

				if config._DEBUG then
					var_18_6:setTouchEnabled(true)
					var_18_6:addTouchEventListener(function(arg_20_0, arg_20_1)
						if arg_20_1 ~= ccui.TouchEventType.ended then
							return
						end

						arg_20_0:setTouchEnabled(false)
						network:rpc("get_items", {
							num = 1,
							itemtype = var_18_5
						}, function(arg_21_0)
							if arg_21_0.result == 1 then
								global_riseWord(L_ROLE_WEAPON_SUCCESS)
								print_lua_table(arg_21_0.items)
								item_manager:setItemByServerItem(arg_21_0.items[1])
								arg_20_0:setTouchEnabled(true)
								var_18_7:setOpacity(255)

								if cook_manager:isReadyCook(self.foodid) == 1 then
									self.foodImg:setOpacity(255)
								end
							end
						end)
					end)
				else
					var_18_6:setTouchEnabled(true)
					var_18_6:addTouchEventListener(function(arg_22_0, arg_22_1)
						if arg_22_1 ~= ccui.TouchEventType.ended then
							return
						end

						popmsg = {
							item = var_18_5
						}

						local var_22_0 = PopLayer:Go_Gain_Layer(popmsg)

						if var_22_0 then
							cc.Director:getInstance():getRunningScene():addChild(var_22_0, 999)
						end
					end)
				end
			end

			for iter_18_0, iter_18_1 in ipairs(self.baseFoods) do
				local var_18_8 = ccui.ImageView:create("public/box/new_item_bg_touming.png", var_0_6)

				var_18_8:setName("basefood" .. iter_18_0)
				var_18_8:setPosition(cc.p(320 + (iter_18_0 - (var_18_3 + 1) / 2) * var_18_4, var_0_8))
				var_18_8:setScale(0.6)

				local var_18_9 = ItemSprite:createNewWithItemId(iter_18_1.itemid, iter_18_1.num)

				var_18_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_18_9:setPosition(cc.p(var_18_8:getContentSize().width / 2, var_18_8:getContentSize().height / 2))
				var_18_9:setName(iter_18_0)
				var_18_8:addChild(var_18_9)
				var_18_0:addChild(var_18_8, 11)
				var_18_2(cc.p(320 + (iter_18_0 - (var_18_3 + 1) / 2) * var_18_4, var_0_8 + var_18_8:getBoundingBox().height / 2 + 5), cc.p(320 + (iter_18_0 - (var_18_3 + 1) / 2) * var_18_4, var_0_9))

				if iter_18_0 == 1 then
					var_18_2(cc.p(320 + (iter_18_0 - (var_18_3 + 1) / 2) * var_18_4, var_0_9), cc.p(320 + (var_18_3 - (var_18_3 + 1) / 2) * var_18_4, var_0_9))
				end

				if item_manager:isHaveEnoughItem(iter_18_1.itemid, iter_18_1.num) then
					var_18_9:setOpacity(255)
				else
					var_18_9:setOpacity(100)

					if config._DEBUG then
						var_18_8:setTouchEnabled(true)
						var_18_8:addTouchEventListener(function(arg_23_0, arg_23_1)
							if arg_23_1 ~= ccui.TouchEventType.ended then
								return
							end

							arg_23_0:setTouchEnabled(false)
							network:rpc("get_items", {
								itemtype = iter_18_1.itemid,
								num = iter_18_1.num
							}, function(arg_24_0)
								if arg_24_0.result == 1 then
									global_riseWord(L_ROLE_WEAPON_SUCCESS)
									print_lua_table(arg_24_0.items)
									item_manager:setItemByServerItem(arg_24_0.items[1])
									arg_23_0:setTouchEnabled(true)
									var_18_9:setOpacity(255)

									if cook_manager:isReadyCook(self.foodid) == 1 then
										self.foodImg:setOpacity(255)
									end
								end
							end)
						end)
					else
						var_18_8:setTouchEnabled(true)
						var_18_8:addTouchEventListener(function(arg_25_0, arg_25_1)
							if arg_25_1 ~= ccui.TouchEventType.ended then
								return
							end

							popmsg = {
								item = iter_18_1.itemid
							}

							local var_25_0 = PopLayer:Go_Gain_Layer(popmsg)

							if var_25_0 then
								cc.Director:getInstance():getRunningScene():addChild(var_25_0, 999)
							end
						end)
					end
				end
			end

			if cook_manager:isReadyCook(self.foodid) == 1 then
				self.foodImg:setOpacity(255)
			else
				self.foodImg:setOpacity(100)
			end
		end
	})[self.showType]()
end
