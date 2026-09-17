SmeltLayer = class("SmeltLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemsPanel")
require("view.Layer.PopLayer")

local playermodel = require("model.playermodel")
local lab_manager = require("controller.lab_manager")
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local shop_manager = require("controller.shop_manager")
local item_data = require("data.item_data")
local var_0_7 = require("data.item_data")
local diamond_update_data = require("data.diamond_update_data")
local lab_levelup_data = require("data.lab_levelup_data")
local lab_smelt_data = require("data.lab_smelt_data")
local var_0_11
local var_0_18 = 6
local var_0_19 = config._DEBUG and 0 or 1

function SmeltLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = SmeltLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function SmeltLayer.getInstance()
	return var_0_11
end

function SmeltLayer:init(arg_4_1, arg_4_2, arg_4_3)
	var_0_11 = self
	self.callback = arg_4_2
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Smelt.json" or "Smelt.ExportJson")

	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_return"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_select"):addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_ShowBlockWords(L_SMELT_NO_OPEN, RISE_WORDS_WARNING)
	end)

	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "title_bg")

	self.title:getChildByName("lv"):getChildByName("num"):setString(lab_manager:getSmeltLabInfo().level)

	self.levelupButton = ccui.Helper:seekWidgetByName(self.rootLayer, "button_upgrade")
	self.smeltnumLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "label_num")
	self.smeltPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "framepanel")

	self:updateSmeltnumLabel()
	self:initSmeltPanel(arg_4_3)
	self:initLabLevelup(arg_4_1)
	self:initBottomPanel()
	self:initTitleInfo()
	self:switchPanel()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.buildItem then
				self.buildItem:release()
			end

			if self.levelupSchedule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

				self.levelupSchedule = nil
			end

			var_0_11 = nil
		end
	end)
end

function SmeltLayer:initSmeltPanel(arg_7_1)
	self.smeltPos = {}
	self.sortComponentList = {}

	for iter_7_0 = 1, 6 do
		self.smeltPos[iter_7_0] = self.smeltPanel:getChildByName("image_smelt"):getChildByName("button_" .. iter_7_0)
	end

	self:sortComponent(arg_7_1)
	self.smeltPanel:getChildByName("image_smelt"):getChildByName("button_sure"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_8_0:setTouchEnabled(false)
		self:runSmeltComponent()
	end)
end

function SmeltLayer:sortComponent(arg_9_1)
	self.sortComponentList = {}

	for iter_9_0, iter_9_1 in pairs((item_manager:filterItem(kITEM_COMPONENT))) do
		if not playermodel.items[iter_9_1].component_attr.lock and not playermodel.items[iter_9_1].component_attr.use then
			table.insert(self.sortComponentList, {
				entityid = iter_9_1,
				itemid = playermodel.items[iter_9_1].itemid,
				attr = playermodel.items[iter_9_1].component_attr,
				quality = var_0_7[playermodel.items[iter_9_1].itemid].equip_quality,
				effect = playermodel.items[iter_9_1].component_attr.effect,
				extra = playermodel.items[iter_9_1].component_attr.extra
			})
		end
	end

	table.sort(self.sortComponentList, function(arg_10_0, arg_10_1)
		if arg_10_0.quality == arg_10_1.quality then
			if arg_10_0.extra == arg_10_1.extra then
				if arg_10_0.itemid == arg_10_1.itemid then
					return arg_10_0.entityid < arg_10_1.entityid
				else
					return arg_10_0.itemid < arg_10_1.itemid
				end
			else
				return arg_10_0.extra < arg_10_1.extra
			end
		else
			return arg_10_0.quality < arg_10_1.quality
		end
	end)

	local var_9_1 = #self.sortComponentList > 6 and 6 or #self.sortComponentList

	if arg_9_1 then
		for iter_9_2, iter_9_3 in pairs(self.sortComponentList) do
			if arg_9_1 == iter_9_3.entityid then
				self.sortComponentList[var_9_1], self.sortComponentList[iter_9_2] = self.sortComponentList[iter_9_2], self.sortComponentList[var_9_1]
			end
		end
	end
end

function SmeltLayer:initLabLevelup(arg_11_1)
	if arg_11_1 then
		self.levelupButton:getChildByName("label"):setString(L_COMPOUNDLAB_LEVEL_UP.Level_Uping)
		self.levelupButton:getChildByName("time_left"):setVisible(true)
		self.levelupButton:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_COMPOUNDLAB_LEVEL_UP.Lab_Level_Uping)

			local var_12_0, var_12_1, var_12_2 = lab_manager:getLabLevelupInfo()

			self:addChild(PopLayer:Quick_Finish_Gem({
				costtype = "diamond",
				surecallback = function()
					lab_manager:quickcompleteLabLevelup(LAB_TYPE_SMELT, function(arg_14_0)
						if arg_14_0 == 0 then
							global_ShowBlockWords(L_LAB_LEVELUP.Quick_Complete_Msg[0])
						elseif arg_14_0 == 1 then
							global_ShowBlockWords(L_LAB_LEVELUP.Quick_Complete_Msg[1], RISE_WORDS_SUCCESS)
							self.title:getChildByName("lv"):getChildByName("num"):setString(lab_manager:getSmeltLabInfo().level)
							self:initLabLevelup(false)
						elseif arg_14_0 == 3 then
							LayerManager:pushInLayer("PopGoBuyDiamond", {
								is_need_pop_layer = 0
							})
						elseif arg_14_0 == 2 then
							global_ShowBlockWords(L_LAB_LEVELUP.Quick_Complete_Msg[2])
						elseif arg_14_0 == 4 then
							global_ShowBlockWords(L_LAB_LEVELUP.Quick_Complete_Msg[4])
						end
					end)
				end,
				cost = math.ceil(var_12_2 / 360 * LAB_QUICK_HARVEST_COST_PER_SIXMIN),
				own = playermodel.diamond,
				remaintime = var_12_2
			}), 999)
		end)

		local var_11_0, var_11_1, var_11_2 = lab_manager:getLabLevelupInfo()

		self.levelupButton:getChildByName("time_left"):getChildByName("label"):setString(string.format("%02d:%02d:%02d", math.floor(var_11_2 / 3600), math.floor(var_11_2 % 3600 / 60), math.floor(var_11_2 % 3600 % 60)))

		self.levelupSchedule = self.levelupSchedule or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
			self:updateLabLevelup(lab_manager:getLabLevelupInfo())
		end, 1, false)
	else
		if self.levelupSchedule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

			self.levelupSchedule = nil
		end

		self.levelupButton:getChildByName("label"):setString(L_COMPOUNDLAB_LEVEL_UP.Lab_Level_Up)

		local var_11_3 = lab_manager:getSmeltLabInfo()

		if not lab_smelt_data[var_11_3.level + 1] then
			self.levelupButton:getChildByName("label"):setString(L_LEVEL_MAX)
		end

		self.levelupButton:getChildByName("time_left"):setVisible(false)
		self.levelupButton:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_16_0:isBright() then
				return
			end

			local var_16_1

			if not lab_smelt_data[var_11_3.level + 1] then
				arg_16_0:getChildByName("label"):setString(L_LEVEL_MAX)
				global_ShowBlockWords(L_LAB_LEVELUP.Lab_Lv_Max)

				do return end

				local var_16_0 = lab_manager:getSmeltLabInfo()

				var_16_1 = {
					gold_cost = lab_levelup_data[LAB_TYPE_SMELT * 1000 + var_16_0.level].gold,
					energy_cost = lab_levelup_data[LAB_TYPE_SMELT * 1000 + var_16_0.level].energy,
					labels = {
						[2] = {
							name = L_LAB_LEVELUP.Up_Info_Name[2],
							value = tostring(lab_smelt_data[var_16_0.level].description),
							newvalue = tostring(lab_smelt_data[var_16_0.level + 1].description)
						},
						{
							name = L_LAB_LEVELUP.Up_Info_Name[1],
							value = var_16_0.level,
							newvalue = var_16_0.level + 1
						}
					},
					title = L_LAB_UPGRADE.title,
					bntstr = L_LAB_UPGRADE.bntstr,
					materials = consume_items
				}
			end

			function var_16_1.surecallback(arg_17_0)
				lab_manager:startLabLevelup(LAB_TYPE_SMELT, function(arg_18_0, arg_18_1)
					arg_16_0:setBright(true)

					if arg_18_0 == 1 then
						self:initLabLevelup(true)
						LabLayer.getInstance():updateLabInfos(arg_18_1)
					elseif arg_18_0 == 2 then
						global_ShowBlockWords(L_LAB_LEVELUP.Level_Up_Operate_Warning[2])
					elseif arg_18_0 == 3 then
						global_ShowBlockWords(L_LAB_LEVELUP.Level_Up_Operate_Warning[3])
					elseif arg_18_0 == 4 then
						LayerManager:pushInLayer("PopGoLayer", {
							targetlayer = "HandOfMidasLayer",
							labels = L_GO_BUY_GOLD
						})
					elseif arg_18_0 == 5 then
						global_ShowBlockWords(L_LAB_LEVELUP.Level_Up_Operate_Warning[5])
					elseif arg_18_0 == 6 then
						global_ShowBlockWords(L_LAB_LEVELUP.Level_Up_Operate_Warning[6])
					elseif arg_18_0 == 7 then
						global_ShowBlockWords(L_LAB_LEVELUP.Level_Up_Operate_Warning[7])
					end
				end)

				if arg_17_0 then
					arg_17_0()
				end
			end

			function var_16_1.cancelcallback()
				arg_16_0:setBright(true)
			end

			arg_16_0:setBright(false)
			LayerManager:pushInLayer("PopUpgradeCostlayer", var_16_1)
		end)
	end
end

function SmeltLayer:updateLabLevelup(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 == LAB_STATUS_FREE then
		if self.levelupSchedule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

			self.levelupSchedule = nil
		end

		self.title:getChildByName("lv"):getChildByName("num"):setString(lab_manager:getSmeltLabInfo().level)
		self:initLabLevelup(false)
	elseif arg_20_2 ~= LAB_TYPE_SMELT then
		if self.levelupSchedule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.levelupSchedule)

			self.levelupSchedule = nil
		end

		self.title:getChildByName("lv"):getChildByName("num"):setString(lab_manager:getSmeltLabInfo().level)
		self:initLabLevelup(false)
	else
		self.levelupButton:getChildByName("time_left"):getChildByName("label"):setString(string.format("%02d:%02d:%02d", math.floor(arg_20_3 / 3600), math.floor(arg_20_3 % 3600 / 60), math.floor(arg_20_3 % 3600 % 60)))
	end
end

function SmeltLayer:updateSmeltnumLabel()
	self.smeltnumLabel:getChildByName("image_bg"):getChildByName("label_num"):setString(playermodel.component_smeltnum)
end

function SmeltLayer:switchPanel()
	self.smeltPanel:setVisible(true)
	self:updateSmeltPanel()
end

function SmeltLayer:updateSmeltPanel()
	local var_23_0 = {}

	while 1 <= var_0_18 and 1 <= #self.sortComponentList do
		var_23_0[1] = {
			entityid = self.sortComponentList[1].entityid,
			itemid = self.sortComponentList[1].itemid,
			pos = 1
		}
	end

	for iter_23_0 = 1, var_0_18 do
		if self.smeltPos[iter_23_0].sp then
			self.smeltPos[iter_23_0].sp:removeFromParent()

			self.smeltPos[iter_23_0].sp = nil
		end

		if var_23_0[iter_23_0] then
			local var_23_2 = ItemSprite:create(var_23_0[iter_23_0].entityid, 1)

			var_23_2:setPosition(cc.p(self.smeltPos[iter_23_0]:getContentSize().width / 2, self.smeltPos[iter_23_0]:getContentSize().height / 2))
			self.smeltPos[iter_23_0]:addChild(var_23_2, 1)

			self.smeltPos[iter_23_0].sp = var_23_2
			self.smeltPos[iter_23_0].entityid = var_23_0[iter_23_0].entityid
			self.smeltPos[iter_23_0].itemid = var_23_0[iter_23_0].itemid
		else
			self.smeltPos[iter_23_0].entityid = nil
			self.smeltPos[iter_23_0].itemid = nil
		end

		self.smeltPos[iter_23_0]:setTouchEnabled(true)
		self.smeltPos[iter_23_0]:addTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_24_0 = self.sortComponentList

			if var_23_0[iter_23_0] then
				for iter_24_0 = 1, #var_24_0 do
					if var_24_0[iter_24_0].entityid == var_23_0[iter_23_0].entityid then
						var_24_0[1], var_24_0[iter_24_0] = var_24_0[iter_24_0], var_24_0[1]
					end
				end
			end

			local var_24_1 = {
				pos = iter_23_0,
				components = var_23_0
			}
			local var_24_2
			local var_24_3 = {
				itemList = {}
			}

			for iter_24_1, iter_24_2 in pairs(var_24_0) do
				table.insert(var_24_3.itemList, iter_24_2.entityid)
			end

			var_24_2 = ItemsPanel:create(kITEM_COMPONENT, var_24_3, var_24_1, {
				used = function(arg_25_0)
					var_24_2:exit()

					if arg_24_0.sp then
						arg_24_0.sp:removeFromParent()

						arg_24_0.sp = nil
					end

					arg_24_0.entityid = nil
					arg_24_0.itemid = nil
					var_23_0[iter_23_0] = nil

					local var_25_0 = 0

					for iter_25_0, iter_25_1 in pairs(var_23_0) do
						var_25_0 = var_25_0 + 1
					end

					for iter_25_2, iter_25_3 in pairs(self.sortComponentList) do
						if arg_25_0 == iter_25_3.entityid then
							self.sortComponentList[var_25_0 + 1], self.sortComponentList[iter_25_2] = self.sortComponentList[iter_25_2], self.sortComponentList[var_25_0 + 1]
						end
					end
				end,
				unused = function(arg_26_0)
					var_24_2:exit()

					if arg_24_0.sp then
						arg_24_0.sp:removeFromParent()

						arg_24_0.sp = nil
					end

					local var_26_0 = ItemSprite:create(arg_26_0, 1)

					var_26_0:setPosition(cc.p(arg_24_0:getContentSize().width / 2, arg_24_0:getContentSize().height / 2))
					arg_24_0:addChild(var_26_0, 1)

					arg_24_0.sp = var_26_0
					arg_24_0.entityid = arg_26_0
					arg_24_0.itemid = playermodel.items[arg_26_0].itemid

					local var_26_1 = 0

					for iter_26_0, iter_26_1 in pairs(var_23_0) do
						var_26_1 = var_26_1 + 1
					end

					var_23_0[iter_23_0] = {
						entityid = arg_26_0,
						itemid = itemid,
						pos = iter_23_0
					}

					for iter_26_2, iter_26_3 in pairs(self.sortComponentList) do
						if var_26_1 == 6 then
							if iter_26_3.entityid == arg_26_0 then
								self.sortComponentList[1], self.sortComponentList[iter_26_2] = self.sortComponentList[iter_26_2], self.sortComponentList[1]

								break
							end
						elseif var_26_1 < 6 and iter_26_3.entityid == arg_26_0 then
							self.sortComponentList[var_26_1 + 1], self.sortComponentList[iter_26_2] = self.sortComponentList[iter_26_2], self.sortComponentList[var_26_1 + 1]

							break
						end
					end
				end
			}, ITEMPANEL_TYPE_SMELT_COMPONENT)

			self:addChild(var_24_2, 10)
		end)
	end
end

function SmeltLayer:runSmeltComponent()
	local var_27_0 = {}

	for iter_27_0 = 1, var_0_18 do
		if self.smeltPos[iter_27_0].itemid then
			var_27_0[#var_27_0 + 1] = {
				pos = iter_27_0,
				id = self.smeltPos[iter_27_0].entityid
			}
		end
	end

	component_manager:smeltComponent(var_27_0, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == 1 then
			self:showSmeltResult(arg_28_1, arg_28_2)
		elseif arg_28_0 == 2 then
			global_ShowBlockWords(L_SMELT_RUN_MSG[2])
			self.smeltPanel:getChildByName("image_smelt"):getChildByName("button_sure"):setTouchEnabled(true)
		elseif arg_28_0 == 0 then
			global_ShowBlockWords(L_SMELT_RUN_MSG[0])
			self:updateSmeltnumLabel()
			self:sortComponent()
			self:updateSmeltPanel()
			self.smeltPanel:getChildByName("image_smelt"):getChildByName("button_sure"):setTouchEnabled(true)
		end
	end)
end

function SmeltLayer.showSmeltResult(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = 0
	local var_29_1 = 0.2
	local var_29_2 = {}
	local var_29_3 = {}
	local var_29_4 = {}

	local function var_29_5(arg_30_0)
		local var_30_0 = coroutine.running()

		arg_29_0.smeltPanel:runAction(cc.Sequence:create(cc.DelayTime:create(var_29_1), cc.CallFunc:create(function()
			var_29_1 = 0.2

			arg_29_0:playSmeltAnimation(var_29_2[arg_30_0], var_30_0)
		end)))
		coroutine.yield()
	end

	coroutine.resume((coroutine.create(function()
		for iter_32_0 = 1, 6 do
			if arg_29_0.smeltPos[iter_32_0].sp then
				arg_29_0.smeltPos[iter_32_0].sp:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))

				arg_29_0.smeltPos[iter_32_0].sp = nil
				arg_29_0.smeltPos[iter_32_0].entityid = nil
				arg_29_0.smeltPos[iter_32_0].itemid = nil
			end
		end

		for iter_32_1 = 1, #arg_29_1 do
			var_29_0 = var_29_0 + arg_29_1[iter_32_1].smeltnum

			if arg_29_1[iter_32_1].id then
				var_29_2[#var_29_2 + 1] = arg_29_1[iter_32_1].id
			end
		end

		table.insert(var_29_3, L_SMELT_SHOW_RESULT.Num .. var_29_0)
		table.insert(var_29_4, EQUIP_COLOR_TBL[6])

		if arg_29_2 then
			for iter_32_2, iter_32_3 in pairs(arg_29_2) do
				table.insert(var_29_3, L_SMELT_SHOW_RESULT.Return .. item_data[iter_32_3.dropid].name .. " * " .. iter_32_3.dropNum)
				table.insert(var_29_4, EQUIP_COLOR_TBL[item_data[iter_32_3.dropid].equip_quality])
			end
		end

		audio_manager:playeffectMusic(SMELT_EFFECT)
		arg_29_0.smeltPanel:getChildByName("image_smelt"):getChildByName("image_bg2"):runAction(cc.Repeat:create(cc.RotateBy:create(0.5, 360), (#var_29_3 + 1) * 0.5))
		global_riseWords3(var_29_3, var_29_4, cc.p(SCREEN_WIDTH / 2 - 120, SCREEN_HEIGHT / 2 + 80), 1.5, 0.5, 2)

		for iter_32_4 = 1, #var_29_2 do
			var_29_5(iter_32_4)
		end

		arg_29_0.smeltPanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			arg_29_0:updateSmeltnumLabel()
			arg_29_0:sortComponent()
			arg_29_0:updateSmeltPanel()
			arg_29_0.smeltPanel:getChildByName("image_smelt"):getChildByName("button_sure"):setTouchEnabled(true)
		end)))
	end)))
end

function SmeltLayer:playSmeltAnimation(arg_34_1, arg_34_2)
	local var_34_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_new")

	var_34_0:setTouchEnabled(true)
	var_34_0:addTouchEventListener(function(arg_35_0, arg_35_1)
		return
	end)

	local var_34_1 = ccui.Helper:seekWidgetByName(var_34_0, "button_new")
	local var_34_2 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_19)

	var_34_2:setPosition(var_34_1:getPosition())
	var_34_2:setName("newItem")
	var_34_0:addChild(var_34_2, 10)
	var_34_1:setVisible(false)
	var_34_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.Show:create(), cc.CallFunc:create(function()
		local var_36_0 = ItemSprite:create(arg_34_1, 1)

		var_36_0:setPosition(cc.p(var_34_2:getContentSize().width / 2, var_34_2:getContentSize().height / 2))
		var_34_2:addChild(var_36_0)
		var_34_2:setScale(2)
		var_34_2:runAction(cc.ScaleTo:create(0.2, 1))
		ccui.Helper:seekWidgetByName(var_34_0, "label_name"):setString(var_0_7[playermodel.items[arg_34_1].itemid].name)
		ccui.Helper:seekWidgetByName(var_34_0, "label_des"):setString((component_manager:initComponentIntro(arg_34_1)))
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		var_34_0:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_34_0:stopAllActions()
			var_34_0:setVisible(false)

			if var_34_0:getChildByName("newItem") then
				var_34_2:removeFromParent()
			end

			if arg_34_2 then
				coroutine.resume(arg_34_2)
			end
		end)
	end), cc.DelayTime:create(2), cc.Spawn:create(cc.Hide:create(), cc.CallFunc:create(function()
		if var_34_0:getChildByName("newItem") then
			var_34_2:removeFromParent()
		end

		if arg_34_2 then
			coroutine.resume(arg_34_2)
		end
	end))))
end

function SmeltLayer.updateBuildPanel(arg_40_0)
	shop_manager:get_market_data(MARKET_TYPE_COMPONENT, function(arg_41_0)
		for iter_41_0 = 1, #arg_41_0 do
			arg_40_0:updateBuildProduct(arg_40_0.buildProducts[iter_41_0], arg_41_0[iter_41_0])
		end

		arg_40_0:updateRefreshButton()
	end)
end

function SmeltLayer.updateRefreshButton(arg_42_0)
	shop_manager:get_market_refresh_time(MARKET_TYPE_COMPONENT, function(arg_43_0)
		arg_42_0.refreshButton:setVisible(true)
		arg_42_0.refreshButton:setBright(true)

		if arg_43_0 >= MARKET_MAX_REFRESH_TIME[MARKET_TYPE_COMPONENT] then
			arg_42_0.refreshCost:setVisible(false)
			arg_42_0.refreshButton:addTouchEventListener(function(arg_44_0, arg_44_1)
				if arg_44_1 ~= ccui.TouchEventType.ended then
					return
				end

				global_ShowBlockWords(L_SMELT_REFRESH_TIME_MAX)
			end)
		else
			arg_42_0.refreshCost:setVisible(true)
			arg_42_0.refreshCost:getChildByName("cost"):setString(diamond_update_data[MARKET_REFRESH_DIAMOND_ID[MARKET_TYPE_COMPONENT] + arg_43_0 + 1].costdiamond)
			arg_42_0.refreshButton:addTouchEventListener(function(arg_45_0, arg_45_1)
				if arg_45_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_45_0:isBright() then
					return
				end

				arg_45_0:setBright(false)
				arg_42_0:showRefreshDialog(arg_43_0)
			end)
		end
	end)
end

function SmeltLayer:showRefreshDialog(arg_46_1)
	self:addChild(PopLayer:Refresh_Market({
		costtype = "diamond",
		remaintimes = MARKET_MAX_REFRESH_TIME[MARKET_TYPE_COMPONENT] - arg_46_1,
		totaltimes = MARKET_MAX_REFRESH_TIME[MARKET_TYPE_COMPONENT],
		own = playermodel.diamond,
		cost = diamond_update_data[MARKET_REFRESH_DIAMOND_ID[MARKET_TYPE_COMPONENT] + arg_46_1 + 1].costdiamond,
		surecallback = function()
			shop_manager:refresh_market(MARKET_TYPE_COMPONENT, function(arg_48_0)
				if arg_48_0 == 1 then
					self:updateBuildPanel()
				end
			end)
		end,
		cancelcallback = function()
			self.refreshButton:setBright(true)
		end,
		markettype = MARKET_TYPE_COMPONENT
	}), 20)
end

function SmeltLayer.updateBuildProduct(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = ccui.Helper:seekWidgetByName(arg_50_1, "equip")
	local var_50_1 = ItemSprite:createWithItemId(arg_50_2.itemtype, arg_50_2.item_number)

	var_50_1:setPosition(cc.p(var_50_0:getContentSize().width / 2, var_50_0:getContentSize().height / 2))
	var_50_0:addChild(var_50_1)
	ccui.Helper:seekWidgetByName(arg_50_1, "label_name"):setString(var_0_7[arg_50_2.itemtype].name)
	ccui.Helper:seekWidgetByName(arg_50_1, "descri"):setString(var_0_7[arg_50_2.itemtype].intro)

	local var_50_2 = ccui.Helper:seekWidgetByName(arg_50_1, "button_qianghua")

	ccui.Helper:seekWidgetByName(var_50_2, "label_cost_num_jinbi"):setString(global_trans_number(arg_50_2.item_number * var_0_7[arg_50_2.itemtype].price_smeltsnum))
	var_50_2:setBright(arg_50_2.have_bought < 1)
	var_50_2:addTouchEventListener(function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:is_full() then
			global_ShowBlockWords(L_BAG_MAX)

			return
		end

		shop_manager:market_buy(MARKET_TYPE_COMPONENT, arg_50_2.pos, function(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:updateSmeltnumLabel()

				arg_50_2.have_bought = arg_50_2.have_bought + 1

				arg_50_0:updateBuildProduct(arg_50_1, arg_50_2)
			end
		end)
	end)
end

function SmeltLayer:initBottomPanel()
	local var_53_0 = ccui.ImageView:create("public/public/bottom_bg.png", var_0_19)

	var_53_0:setPosition(SCREEN_WIDTH / 2, 32)
	self:addChild(var_53_0, 9)

	self.returnBnt = ccui.Button:create("public/public/bottom_bntBg2.png", nil, "public/public/bottom_bntBg2.png", var_0_19)

	self.returnBnt:setPosition(self.returnBnt:getContentSize().width / 2, var_53_0:getContentSize().height / 2)
	var_53_0:addChild(self.returnBnt)

	local var_53_1 = ccui.ImageView:create("public/public/return_bntWord.png", var_0_19)

	var_53_1:setPosition(self.returnBnt:getContentSize().width / 2, self.returnBnt:getContentSize().height / 2)
	self.returnBnt:addChild(var_53_1)
	self.returnBnt:addTouchEventListener(function(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.callback then
			self.callback()
		end

		LayerManager:switchShowLayer("BagLayer", {
			bagType = 1
		})
	end)
end

function SmeltLayer:initTitleInfo()
	local var_55_0 = TitleSprite:create(L_SMELT)

	var_55_0:setPosition(cc.p(0, 1080))
	self:addChild(var_55_0, 5)
end
