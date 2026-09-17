require("view.Layer.TwisteggLayer")

SkinTwisteggLayer = class(SkinTwisteggLayer, function()
	return TwisteggLayer:createRoot()
end)

local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local horcrux_manager = require("controller.horcrux_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local twist_manager = require("controller.twist_manager")
local weapon_manager = require("controller.weapon_manager")
local level_manager = require("controller.level_manager")
local autopop_manager = require("controller.autopop_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local activity_manager = require("controller.activity_manager")
local bond_manager = require("controller.bond_manager")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local drop_data = require("data.drop_data")
local drop_words_data = require("data.drop_words_data")
local var_0_23
local TwistList = require("view.Sprite.TwistList")
local var_0_25 = 1
local var_0_26 = 2
local var_0_38 = {
	["90"] = {
		idx = 1,
		name = "春节服装"
	},
	["80"] = {
		idx = 2,
		name = "圣诞服装"
	},
	["75"] = {
		idx = 3,
		name = "感恩节服装"
	},
	["70"] = {
		idx = 4,
		name = "万圣服装"
	},
	["60"] = {
		idx = 5,
		name = "夏日服装"
	},
	["55"] = {
		idx = 6,
		name = "周年庆服装"
	},
	["50"] = {
		idx = 7,
		name = "生日服装"
	},
	["40"] = {
		idx = 8,
		name = "训练皮肤"
	},
	["20"] = {
		idx = 10,
		name = "常服"
	},
	["15"] = {
		idx = 1,
		name = "情人节服装"
	},
	["10"] = {
		idx = 12,
		name = "誓约服装"
	},
	["00"] = {
		idx = 13,
		name = "校服"
	}
}
local var_0_39 = "mainScenebg/bg.jpg"
local var_0_40 = "mainScenebg/resultbg.jpg"
local var_0_42 = "spine/ui/twist/fangkuai"
local var_0_44 = cc.size(514, 815)
local var_0_52 = {
	"public/box/new_item_bg1.png",
	"public/box/new_item_bg2.png",
	"public/box/new_item_bg3.png",
	"public/box/new_item_bg4.png",
	"public/box/new_item_bg5.png",
	"public/box/new_item_bg6.png"
}
local var_0_53 = config._DEBUG and 0 or 1

local function var_0_54(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {
		type_tbl = {}
	}

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		local var_2_1, var_2_2 = string.match(iter_2_0, arg_2_1)
		local var_2_3 = tonumber(var_2_1)
		local var_2_4 = tonumber(var_2_2)
		local var_2_5

		if var_2_3 and var_2_4 then
			if true == true then
				var_2_0[var_2_3] = {}
				var_2_0[var_2_3].attribute = var_2_3
				var_2_0[var_2_3].content = {}
				var_2_0[var_2_3].content[var_2_4] = {
					itemid = iter_2_1
				}
				var_2_5 = false
			else
				local var_2_7 = false

				for iter_2_2, iter_2_3 in pairs(var_2_0) do
					if iter_2_3.attribute and iter_2_3.attribute == var_2_3 then
						if iter_2_3.content[var_2_4] then
							iter_2_3.content[var_2_4].itemid = iter_2_1
						else
							iter_2_3.content[var_2_4] = {
								itemid = iter_2_1
							}
						end

						var_2_7 = true

						break
					end
				end

				if var_2_7 == false then
					var_2_0[var_2_3] = {}
					var_2_0[var_2_3].attribute = var_2_3
					var_2_0[var_2_3].content = {}
					var_2_0[var_2_3].content[var_2_4] = {
						itemid = iter_2_1
					}
				end
			end
		else
			local var_2_8 = string.match(iter_2_0, arg_2_2)

			if var_2_8 then
				var_2_0.type_tbl[tonumber(var_2_8)] = iter_2_1
			end
		end
	end

	return var_2_0
end

local function var_0_55(arg_3_0)
	local var_3_0 = {}
	local var_3_2 = {}
	local var_3_3 = {}
	local var_3_4 = {}

	for iter_3_0, iter_3_1 in pairs(var_0_38) do
		var_3_2[iter_3_0] = {}
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0) do
		if item_data[iter_3_3].bag_item_type == kITEM_SKIN then
			local var_3_5 = tostring(iter_3_3):sub(-2, -1)

			if var_3_5 == "30" then
				table.insert(var_3_2["20"], iter_3_3)
			elseif var_3_2[var_3_5] then
				table.insert(var_3_2[var_3_5], iter_3_3)
			else
				table.insert(var_3_3, iter_3_3)
			end
		elseif item_data[iter_3_3].bag_item_type == kITEM_FURNITURE then
			table.insert(var_3_4, iter_3_3)
		end
	end

	local function var_3_6(arg_4_0)
		if model_data[item_data[arg_4_0].model].live2d and not model_data[item_data[arg_4_0].model].origin then
			return item_data[arg_4_0].equip_quality + 20
		elseif model_data[item_data[arg_4_0].model].rolespine then
			return item_data[arg_4_0].equip_quality + 10
		else
			return 10
		end
	end

	for iter_3_4, iter_3_5 in pairs(var_3_2) do
		if next(iter_3_5) ~= nil then
			table.sort(iter_3_5, function(arg_5_0, arg_5_1)
				return var_3_6(arg_5_0) > var_3_6(arg_5_1)
			end)
			table.insert(var_3_0, {
				name = var_0_38[iter_3_4].name,
				content = iter_3_5,
				idx = var_0_38[iter_3_4].idx
			})
		end
	end

	table.sort(var_3_0, function(arg_6_0, arg_6_1)
		return arg_6_0.idx < arg_6_1.idx
	end)

	if next(var_3_3) ~= nil then
		table.sort(var_3_3, function(arg_7_0, arg_7_1)
			return var_3_6(arg_7_0) > var_3_6(arg_7_1)
		end)
		table.insert(var_3_0, {
			name = "其他皮肤",
			content = var_3_3
		})
	end

	if next(var_3_4) ~= nil then
		table.sort(var_3_4, function(arg_8_0, arg_8_1)
			return item_data[arg_8_0].equip_quality > item_data[arg_8_1].equip_quality
		end)
		table.insert(var_3_0, {
			name = "家具",
			content = var_3_4
		})
	end

	return var_3_0
end

local function var_0_57(arg_11_0, arg_11_1)
	return function(arg_12_0)
		local var_12_0 = item_data[arg_12_0.dropid].equip_quality
		local var_12_1 = ccui.ImageView:create(var_0_52[item_data[arg_12_0.dropid].equip_quality], var_0_53)
		local var_12_2 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		if arg_12_0.dropnum > 1 then
			var_12_2:setString(item_data[arg_12_0.dropid].name .. " X" .. arg_12_0.dropnum)
		else
			var_12_2:setString(item_data[arg_12_0.dropid].name)
		end

		var_12_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_12_2:setPosition(cc.p(var_12_1:getContentSize().width / 2, var_12_1:getContentSize().height / 2 - 90))
		var_12_1:addChild(var_12_2, 1)

		local var_12_3 = ccui.Layout:create()

		var_12_3:setClippingEnabled(true)
		var_12_3:setContentSize(cc.size(170, 170))
		var_12_3:setPosition(cc.p(var_12_1:getContentSize().width / 2 - 85, var_12_1:getContentSize().height / 2 - 56))
		var_12_3:setCascadeOpacityEnabled(true)
		var_12_3:setName("clip")
		var_12_1:addChild(var_12_3)

		local var_12_4 = cc.Sprite:create("equipment/" .. item_data[arg_12_0.dropid].image_id .. ".png")

		var_12_4:setPosition(cc.p(84, 84))
		var_12_4:setName("icon")
		var_12_3:addChild(var_12_4)

		if var_12_0 >= 5 and item_data[arg_12_0.dropid].bag_item_type == kITEM_SKIN then
			local var_12_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_12_5:setScale(1.25)
			var_12_5:setName("eggEffect")
			var_12_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_12_5:setPosition(var_12_1:getContentSize().width / 2, var_12_1:getContentSize().height / 2)

			local var_12_6 = cc.Animation:create()

			for iter_12_0 = 1, 8 do
				var_12_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_12_0 .. ".png")))
			end

			var_12_6:setDelayPerUnit(0.1)
			var_12_6:setRestoreOriginalFrame(true)
			var_12_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_12_6)))
			var_12_1:addChild(var_12_5)
		end

		if item_data[arg_12_0.dropid].bag_item_type == kITEM_WEAPON then
			var_12_4:setScale(0.65)
		end

		return var_12_1
	end
end

function SkinTwisteggLayer.create(arg_13_0, arg_13_1)
	local var_13_0 = SkinTwisteggLayer.new()

	var_13_0:set_create_normal_item_icon_func(var_0_57)
	var_13_0:init(arg_13_1)

	return var_13_0
end

function SkinTwisteggLayer:initUI()
	self.curtwistData = {}
	self.twist_type_to_index = {}
	self.isCanChangeTwist = true
	self._canAnim = true

	self.rootLayer:setVisible(false)
	twist_manager:get_skin_twist_status(function(arg_15_0, arg_15_1)
		self.rootLayer:setVisible(true)
		table.sort(arg_15_0, function(arg_16_0, arg_16_1)
			return arg_16_0.pos < arg_16_1.pos
		end)

		for iter_15_0, iter_15_1 in pairs(arg_15_0) do
			self.curtwistData[iter_15_0] = {
				pos = iter_15_0,
				upitems = iter_15_1.items,
				guaranteeitems = iter_15_1.guarantee_items,
				twistType = iter_15_1.twisttype,
				img = iter_15_1.img,
				time = iter_15_1.time,
				twistcount = iter_15_1.twistcount,
				upid = iter_15_1.upid,
				upcount = iter_15_1.upcount,
				updes = iter_15_1.updes,
				upcount2 = iter_15_1.upcount2,
				uppos2 = iter_15_1.uppos2,
				costtype = iter_15_1.costtype,
				costone = iter_15_1.costone,
				costten = iter_15_1.costten,
				dailyfreeforone = iter_15_1.dailyfreeforone,
				totalfreeforone = iter_15_1.totalfreeforone,
				dailyfreeforten = iter_15_1.dailyfreeforten,
				totalfreeforten = iter_15_1.totalfreeforten,
				naivemark = iter_15_1.naivemark,
				blackcard_type = iter_15_1.blackcard_type,
				twist_remain_count = iter_15_1.twist_remain_count,
				once_twist_ticket = iter_15_1.once_twist_ticket,
				once_twist_ticket_1 = iter_15_1.once_twist_ticket_1,
				extratip = iter_15_1.extratip,
				extratip = iter_15_1.extratip,
				return_itemid = iter_15_1.return_itemid
			}
			self.twist_type_to_index[iter_15_1.twisttype] = iter_15_0

			if self.initTwisType and self.initTwisType == iter_15_1.twisttype then
				self.curTwistIndex = iter_15_0
			end

			self.twistConfig = {}

			for iter_15_2, iter_15_3 in pairs(arg_15_1) do
				local var_15_0 = json.decode(iter_15_3)

				self.twistConfig[var_15_0.id] = var_15_0
			end
		end

		print("$$$$$$$$$$$$$$$$$$$$$$$$", #self.curtwistData)
		self:initCachePanelPosList()
		self:updateTwistMain()
		self:updateTwistCache()
		self:registBtnTimesEvent()
		self:initTwistList()
		self:setAnimController()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			self:updateGuidesOnLayer()
		end)))
	end)
	self:initCachePanel()

	local var_14_0 = ccui.ImageView:create("TwistEgg/num10.png", var_0_53)

	var_14_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_0:setPosition(cc.p(105, 38))
	var_14_0:setName("num_label")
	self.tenBtn:addChild(var_14_0)
end

local var_0_58 = {
	[1] = "equipment/1000001.png"
}

setmetatable(var_0_58, {
	__index = function(arg_18_0, arg_18_1)
		return "equipment/" .. item_data[arg_18_1].image_id .. ".png"
	end
})

local var_0_59 = {
	playermodel.gold
}

setmetatable(var_0_59, {
	__index = function(arg_19_0, arg_19_1)
		return item_manager:getItemNumber(arg_19_1)
	end
})

local var_0_60 = setmetatable({
	[1] = false,
	[4] = false
}, {
	__index = function(arg_20_0, arg_20_1)
		return true
	end
})

function SkinTwisteggLayer:updateTimePanel()
	local var_21_0 = {}

	table.insert(var_21_0, self.curtwistData[self.curTwistIndex].costtype)

	if self.curtwistData[self.curTwistIndex].once_twist_ticket then
		table.insert(var_21_0, self.curtwistData[self.curTwistIndex].once_twist_ticket)
	end

	if self.curtwistData[self.curTwistIndex].once_twist_ticket_1 then
		table.insert(var_21_0, self.curtwistData[self.curTwistIndex].once_twist_ticket_1)
	end

	if self.curtwistData[self.curTwistIndex].return_itemid then
		table.insert(var_21_0, self.curtwistData[self.curTwistIndex].return_itemid)
	end

	for iter_21_0 = 1, 3 do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_currency_" .. iter_21_0):setVisible(false)
	end

	while 1 <= 3 and var_21_0[1] do
		local var_21_1 = var_21_0[1]

		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_currency_" .. 1):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency_img_" .. 1):loadTexture(var_0_58[var_21_0[1]])
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_currency_num_" .. 1):setString(var_0_59[var_21_0[1]])
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_currency_" .. 1):addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not var_21_1 then
				return
			end

			if not item_data[var_21_1] then
				return
			end

			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_21_1
			})
		end)
	end
end

function SkinTwisteggLayer.showTwistEggDrops(arg_23_0, arg_23_1, arg_23_2)
	twist_manager:set_twist_status(function(arg_24_0)
		local var_24_0 = {}
		local var_24_1 = {}
		local var_24_2 = {}

		while drop_data[arg_23_0.twistConfig[arg_23_1].dropid]["rd_dropmodel_id" .. 1] do
			if drop_data[arg_23_0.twistConfig[arg_23_1].dropid]["rd_dropmodel_rate" .. 1] ~= 0 then
				var_24_2[#var_24_2 + 1] = drop_data[arg_23_0.twistConfig[arg_23_1].dropid]["rd_dropmodel_id" .. 1]
			end
		end

		local var_24_4 = {}
		local var_24_5 = {}

		for iter_24_0 = 1, #var_24_2 do
			local var_24_6 = 1

			while drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6] do
				if arg_23_0.twistConfig[arg_23_1] and arg_23_0.twistConfig[arg_23_1].is_horcrux_show_in_dropdetails and arg_23_0.twistConfig[arg_23_1].is_horcrux_show_in_dropdetails == 1 and drop_data[var_24_2[iter_24_0]]["rd_drop_weight" .. var_24_6] ~= 0 then
					if not var_24_5[drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6]] then
						var_24_4[#var_24_4 + 1] = drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6]
						var_24_5[drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6]] = true
					end
				elseif drop_data[var_24_2[iter_24_0]]["rd_drop_weight" .. var_24_6] ~= 0 and not horcrux_data[drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6]] and not var_24_5[drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6]] then
					var_24_4[#var_24_4 + 1] = drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6]
					var_24_5[drop_data[var_24_2[iter_24_0]]["rd_drop_id" .. var_24_6]] = true
				end

				var_24_6 = var_24_6 + 1
			end
		end

		local twist_probability_data = require("data.twist_probability_data")

		for iter_24_1, iter_24_2 in pairs(arg_24_0) do
			if iter_24_2.twisttype == arg_23_1 then
				var_24_0 = var_0_55(var_24_4)
				var_24_1 = var_0_54(drop_words_data[iter_24_2.twisttype], "type(%d+)_words(%d+)", "words_type(%d+)")
			end
		end

		local var_24_8, var_24_9, var_24_10 = (function(arg_26_0, arg_26_1)
			local var_26_0 = {}
			local var_26_1 = {}
			local var_26_2 = {
				startTime,
				finishTime
			}

			for iter_26_0 = 1, #arg_26_1 do
				if arg_26_1[iter_26_0].twisttype == arg_26_0 then
					var_26_0 = arg_26_1[iter_26_0].items
					var_26_1 = arg_26_1[iter_26_0].weights
					var_26_2.startTime = arg_26_1[iter_26_0].upstarttime
					var_26_2.finishTime = arg_26_1[iter_26_0].upfinishtime
				end
			end

			return var_26_0, var_26_1, var_26_2
		end)(arg_23_1, arg_24_0)

		if var_24_8 and next(var_24_8) ~= nil then
			local var_24_11 = {
				attribute = 999,
				content = {}
			}

			for iter_24_3 = 1, #var_24_8 do
				table.insert(var_24_11.content, {
					itemid = var_24_8[iter_24_3]
				})
			end

			table.insert(var_24_0, var_24_11)

			if var_24_0.type_tbl then
				var_24_0.type_tbl[999] = L_TWISTEGG_PROBILITY_UP
			end

			local var_24_12 = #var_24_0

			for iter_24_4 = #var_24_0, 1, -1 do
				var_24_0[iter_24_4 + 1] = var_24_0[iter_24_4]
			end

			var_24_0[1] = var_24_0[var_24_12 + 1]

			table.remove(var_24_0)
		end

		if next(var_24_0) == nil then
			if next(var_24_1) ~= nil then
				local var_24_13 = {
					callback = function()
						if not var_0_23 then
							return
						end

						arg_23_2:setBright(true)
					end
				}

				var_24_13.category = {
					type = 2,
					egg_pool_type = arg_23_1,
					Items_Up = var_24_8,
					Items_Weights = var_24_9,
					Items_Uptime = var_24_10
				}
				var_24_13.items_tbl = var_24_0
				var_24_13.words_tbl = var_24_1

				print("????????", dump(var_24_13))
				LayerManager:pushInLayer("DropDetailsLayer", var_24_13)
			end
		end
	end)
end

function SkinTwisteggLayer.twist_one_result(arg_27_0, arg_27_1, arg_27_2)
	autopop_manager:pauseAchievementPop()

	arg_27_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items_skin", {
		twisttype = arg_27_1
	}, function(arg_28_0)
		print("??????add_twistegg_items", dump(arg_28_0))

		if arg_28_0.result == 1 then
			arg_27_0.lastTwistBlackCard = arg_27_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})
			arg_27_0:twistcost(var_0_25, arg_27_1, arg_28_0.twist_remain_count, arg_28_0.upcount)

			if arg_28_0.item.itemtype == kITEM_HERO then
				if not playermodel.haveServant[item_data[arg_28_0.item.itemid].servant] then
					local var_28_0 = {
						servantid = item_data[arg_28_0.item.itemid].servant
					}

					var_28_0.rarity = servant_data[item_data[arg_28_0.item.itemid].servant].roll_rarity or 1

					AnalyticManager.gain_new_servant_by_twist(var_28_0)
				end
			end

			arg_27_0.totalAward = {}

			if arg_28_0.item.itemid == 1380001001 then
				arg_27_0.totalAward[arg_28_0.item.itemid] = item_manager:setItemByServerItem(arg_28_0.item)
			end

			local var_28_1 = {}

			if arg_28_0.item_extra then
				for iter_28_0, iter_28_1 in pairs(arg_28_0.item_extra) do
					local var_28_2 = {}
					local var_28_3 = item_manager:setItemByServerItem(iter_28_1)
					local var_28_4 = {}
					local var_28_5 = {}

					if iter_28_0 == "servantcard" then
						var_28_4.itemid = iter_28_1.itemid
						var_28_4.itemcount = var_28_3
						var_28_2.servantcard = var_28_4
					end

					if iter_28_0 == "elementcard" then
						var_28_5.itemid = iter_28_1.itemid
						var_28_5.itemcount = var_28_3
						var_28_2.elementcard = var_28_5
					end

					arg_27_0.totalAward[iter_28_1.entityid] = not arg_27_0.totalAward[iter_28_1.entityid] and var_28_3 or var_28_3 + arg_27_0.totalAward[iter_28_1.entityid]

					table.insert(var_28_1, var_28_2)
				end
			end

			if arg_28_0.item_other then
				for iter_28_2, iter_28_3 in pairs(arg_28_0.item_other) do
					local var_28_6 = item_manager:setItemByServerItem(iter_28_3)

					if var_28_6 > 0 then
						arg_27_0.totalAward[iter_28_3.entityid] = not arg_27_0.totalAward[iter_28_3.entityid] and var_28_6 or var_28_6 + arg_27_0.totalAward[iter_28_3.entityid]
					end
				end
			end

			if arg_28_0.itemformat then
				arg_27_0.liujin_itemnum = {}

				for iter_28_4, iter_28_5 in pairs(arg_28_0.itemformat) do
					arg_27_0.liujin_itemnum[iter_28_5.origina_itemid] = iter_28_5.final_itemNum
				end
			end

			arg_27_0:show_twist_result(arg_27_1, {
				{
					dropid = arg_28_0.dropitem.dropid,
					dropnum = arg_28_0.dropitem.dropNum,
					itemid = arg_28_0.item.itemid,
					entityid = arg_28_0.item.entityid,
					iteminfo = arg_28_0.item
				}
			}, nil, blackcardcount, var_28_1)
			arg_27_0:updateByBlackCard(arg_27_1)
			arg_27_0:updateTwistMain()
			arg_27_0.twistList:removeReddot(arg_27_0:checkIsHaveFreeTimes(arg_27_1))

			if arg_27_0.twistConfig[arg_27_1].stat == 3 then
				arg_27_0:updateNaiveTwist(arg_27_1, "one")
			elseif arg_27_0.twistConfig[arg_27_1].stat == 4 then
				arg_27_0:updateFiniteTwist(arg_27_1, "one")
			elseif arg_27_0.twistConfig[arg_27_1].is_limit_twist_pool then
				arg_27_0:updateLimitTwist(arg_27_1, "one")
			end
		elseif arg_28_0.result == 2 then
			arg_27_0:lackofcost(var_0_25, arg_27_1)
		elseif arg_28_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_28_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_28_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		end

		if arg_27_2 then
			arg_27_2()
		end

		arg_27_0.isAlowOtherTouch = true
	end)
end

local function var_0_61(arg_29_0)
	if arg_29_0.resultPanel:getChildByName("icon") then
		arg_29_0.resultPanel:getChildByName("icon"):stopAllActions()
		l2utils:removeNodeShake(arg_29_0.resultPanel:getChildByName("icon"))
		arg_29_0.resultPanel:getChildByName("icon"):setVisible(false)
	end

	arg_29_0.resultPanel:getChildByName("blackcardinfo"):setVisible(false)

	for iter_29_0, iter_29_1 in pairs(arg_29_0.resultInfosPanel:getChildren()) do
		iter_29_1:stopAllActions()
		iter_29_1:setVisible(false)
	end
end

local function var_0_62()
	local var_30_0 = {}
	local var_30_1 = -1

	for iter_30_0 = 1, 10 do
		var_30_0[iter_30_0] = cc.p(320 + var_30_1 * 200, 950 - 0 * 250 + GameDisplay.fix_y)
		var_30_1 = var_30_1 + 1

		if var_30_1 > 1 then
			var_30_1 = -1
		end
	end

	return var_30_0
end

function SkinTwisteggLayer.twist_ten_result(arg_31_0, arg_31_1, arg_31_2)
	autopop_manager:pauseAchievementPop()

	arg_31_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items_for_ten_skin", {
		twisttype = arg_31_1
	}, function(arg_32_0)
		print("add_twistegg_items_for_ten", dump(arg_32_0))

		if arg_32_0.result == 1 then
			arg_31_0.lastTwistBlackCard = arg_31_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})
			arg_31_0:twistcost(var_0_26, arg_31_1, arg_32_0.twist_remain_count, arg_32_0.upcount)

			arg_31_0.totalAward = {}
			arg_31_0.liujin_itemnum = {}

			for iter_32_0, iter_32_1 in pairs(arg_32_0.items) do
				if iter_32_1.itemtype == kITEM_HERO then
					if not playermodel.haveServant[item_data[iter_32_1.itemid].servant] then
						local var_32_0 = {
							servantid = item_data[iter_32_1.itemid].servant
						}

						var_32_0.rarity = servant_data[item_data[iter_32_1.itemid].servant].roll_rarity or 1

						AnalyticManager.gain_new_servant_by_twist(var_32_0)
					end
				end

				local var_32_1 = item_manager:setItemByServerItem(iter_32_1)

				if iter_32_1.itemid == 1380001001 then
					arg_31_0.totalAward[iter_32_1.itemid] = not arg_31_0.totalAward[iter_32_1.itemid] and var_32_1 or arg_31_0.totalAward[iter_32_1.itemid] + var_32_1
				end
			end

			local var_32_2 = {}

			if arg_32_0.item_extra then
				for iter_32_2, iter_32_3 in pairs(arg_32_0.item_extra) do
					local var_32_3 = {}

					for iter_32_4, iter_32_5 in pairs(iter_32_3) do
						local var_32_4 = item_manager:setItemByServerItem(iter_32_5)
						local var_32_5 = {}
						local var_32_6 = {}

						if iter_32_4 == "servantcard" then
							var_32_5.itemid = iter_32_5.itemid
							var_32_5.itemcount = var_32_4
							var_32_3.servantcard = var_32_5
						end

						if iter_32_4 == "elementcard" then
							var_32_6.itemid = iter_32_5.itemid
							var_32_6.itemcount = var_32_4
							var_32_3.elementcard = var_32_6
						end

						arg_31_0.totalAward[iter_32_5.entityid] = not arg_31_0.totalAward[iter_32_5.entityid] and var_32_4 or var_32_4 + arg_31_0.totalAward[iter_32_5.entityid]
					end

					table.insert(var_32_2, var_32_3)
				end
			end

			if arg_32_0.icon then
				local var_32_7 = item_manager:setItemByServerItem(arg_32_0.icon)

				if var_32_7 ~= 0 then
					arg_31_0.totalAward[arg_32_0.icon.entityid] = var_32_7
				end
			end

			if arg_32_0.item_other then
				for iter_32_6, iter_32_7 in pairs(arg_32_0.item_other) do
					local var_32_8 = item_manager:setItemByServerItem(iter_32_7)

					if var_32_8 > 0 then
						arg_31_0.totalAward[iter_32_7.entityid] = not arg_31_0.totalAward[iter_32_7.entityid] and var_32_8 or var_32_8 + arg_31_0.totalAward[iter_32_7.entityid]
					end
				end
			end

			if arg_32_0.itemformat then
				arg_31_0.liujin_itemnum = {}

				for iter_32_8, iter_32_9 in pairs(arg_32_0.itemformat) do
					arg_31_0.liujin_itemnum[iter_32_9.origina_itemid] = iter_32_9.final_itemNum
				end
			end

			local var_32_9 = {}

			for iter_32_10, iter_32_11 in ipairs(arg_32_0.dropitems) do
				table.insert(var_32_9, {
					dropid = iter_32_11.dropid,
					dropnum = iter_32_11.dropNum,
					itemid = arg_32_0.items[iter_32_10].itemid,
					entityid = arg_32_0.items[iter_32_10].entityid,
					iteminfo = arg_32_0.items[iter_32_10]
				})
			end

			arg_31_0:show_twist_result(arg_31_1, var_32_9, arg_32_0.icon, blackcardcount, var_32_2)
			arg_31_0:updateByBlackCard(arg_31_1)
			arg_31_0:updateTwistMain()
			arg_31_0.twistList:removeReddot(arg_31_0:checkIsHaveFreeTimes(arg_31_1))

			if arg_31_0.twistConfig[arg_31_1].stat == 3 then
				arg_31_0:updateNaiveTwist(arg_31_1, "ten")
			elseif arg_31_0.twistConfig[arg_31_1].stat == 4 then
				arg_31_0:updateFiniteTwist(arg_31_1, "ten")
			elseif arg_31_0.twistConfig[arg_31_1].is_limit_twist_pool then
				arg_31_0:updateLimitTwist(arg_31_1, "ten")
			end

			AnalyticManager.twistSuccess(arg_31_1, "ten")
		elseif arg_32_0.result == 2 then
			arg_31_0:lackofcost(var_0_26, arg_31_1)
		elseif arg_32_0.result == 3 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[3])
		elseif arg_32_0.result == 4 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[4])
		elseif arg_32_0.result == 5 then
			global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])
		end

		if arg_31_2 then
			arg_31_2()
		end

		arg_31_0.isAlowOtherTouch = true

		if arg_32_0.result ~= 1 then
			arg_31_0.tenBtnOtherLock = false
		end
	end)
end

function SkinTwisteggLayer:showTwistItemsInfoAni(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	self.resultBg:setTexture(var_0_39)
	self.resultPanel:setVisible(true)
	self.resultInfosPanel:setVisible(true)
	self.skipBnt:setVisible(true)
	var_0_61(self)

	local var_33_0

	var_33_0 = (function()
		return coroutine.create(function()
			local var_35_0 = {}

			for iter_35_0, iter_35_1 in pairs(arg_33_2) do
				if item_data[iter_35_1.dropid].bag_item_type == kITEM_SKIN then
					table.insert(var_35_0, {
						dropid = iter_35_1.dropid,
						formatData = (iter_35_1.entityid == 1380001001 or nil) and {
							itemid = iter_35_1.entityid,
							itemNum = self.liujin_itemnum[iter_35_1.dropid]
						}
					})
				end
			end

			table.sort(var_35_0, function(arg_36_0, arg_36_1)
				return item_data[arg_36_0.dropid].equip_quality > item_data[arg_36_1.dropid].equip_quality
			end)

			for iter_35_2 = 1, #var_35_0 do
				require("view.Layer.GetSkinTwistAniLayer")
				global_basic_scene:addChild(GetSkinTwistAniLayer:create(var_35_0[iter_35_2].dropid, function()
					local var_37_0, var_37_1 = coroutine.resume(var_33_0)

					assert(var_37_0, var_37_1)

					if var_37_1 == "end" then
						var_33_0 = nil

						self.resultAni:setVisible(false)
						self.resultPanel:setVisible(false)
						self.resultInfosPanel:setVisible(false)
						var_0_61(self)
						self:showTwistFinalResult(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
					end
				end, nil, nil, var_35_0[iter_35_2].formatData), 999)
				audio_manager:stopAllEffects()
				audio_manager:playeffectMusic(TWIST_CHANGE_EFFECT)
				coroutine.yield(iter_35_2)
			end

			audio_manager:stopAllEffects()

			return "end"
		end)
	end)()

	local var_33_1, var_33_2 = coroutine.resume(nil)

	assert(var_33_1, var_33_2)

	if var_33_2 == "end" then
		var_33_0 = nil

		self.resultAni:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		var_0_61(self)
		self:showTwistFinalResult(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	end

	self.showPanel:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		if not var_33_0 then
			return
		end

		self.resultTouchEnabled = false

		local var_38_0, var_38_1 = coroutine.resume(var_33_0)

		assert(var_38_0, var_38_1)

		if var_38_1 == "end" then
			var_33_0 = nil

			self.resultAni:setVisible(false)
			self.resultPanel:setVisible(false)
			self.resultInfosPanel:setVisible(false)
			var_0_61(self)
			self:showTwistFinalResult(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
		end
	end)
	self.skipBnt:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		self.resultTouchEnabled = false
		var_33_0 = nil

		self.resultAni:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		var_0_61(self)
		audio_manager:stopAllEffects()
		self:showTwistFinalResult(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	end)
end

function SkinTwisteggLayer:startTwistResultAni(arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	self:cleanTwistRectPanel()
	self.resultBg:setTexture(var_0_40)
	self.twistingRectPanel:setVisible(true)
	self.skipBnt:setVisible(false)

	local var_40_0 = #arg_40_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_62()

	local function var_40_1(arg_41_0)
		local var_41_0 = self.twistingRectPanel:getChildByName("rect" .. arg_41_0)

		if not var_41_0 then
			var_41_0 = L2Skeleton:create(var_0_42 .. ".json", var_0_42 .. ".atlas", nil, true)

			var_41_0:refreshSkeleton()
			var_41_0:setName("rect" .. arg_41_0)
			self.twistingRectPanel:addChild(var_41_0)
		end

		return var_41_0
	end

	local function var_40_2(arg_42_0)
		return (item_data[arg_42_0].bag_item_type == kITEM_HERO and "role_" or item_data[arg_42_0].bag_item_type == kITEM_SKIN and "new_role_" or "") .. (item_data[arg_42_0].equip_quality == 6 and "red" or item_data[arg_42_0].equip_quality == 5 and "orange" or item_data[arg_42_0].equip_quality == 4 and "purple" or "blue")
	end

	local function var_40_3()
		return coroutine.create(function()
			for iter_44_0 = 1, #arg_40_2 do
				local var_44_0 = var_40_1(iter_44_0)

				var_44_0:setPosition(var_40_0[iter_44_0])
				var_44_0:setVisible(true)

				local var_44_2 = var_40_2(arg_40_2[iter_44_0].itemid ~= arg_40_2[iter_44_0].dropid and arg_40_2[iter_44_0].dropid or arg_40_2[iter_44_0].itemid)

				var_44_0:play(var_44_2, false)
				var_44_0:addAnimation(var_44_2 .. "2")
				audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				coroutine.yield(iter_44_0)
			end

			for iter_44_1 = 1, 3 do
				coroutine.yield("wait")
			end

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
	end

	local var_40_4 = var_40_3()

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_45_0)
		if not var_40_4 then
			var_40_4 = var_40_3()

			return
		end

		local var_45_0, var_45_1 = coroutine.resume(var_40_4)

		assert(var_45_0, var_45_1)

		if var_45_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_40_4 = nil

			self.twistingRectPanel:setVisible(false)

			if var_0_60[arg_40_1] then
				self:showTwistItemsInfoAni(arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
			else
				self:showTwistFinalResult(arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
			end
		end
	end, 0.2, false)
end

local var_0_63 = {}

setmetatable(var_0_63, {
	__index = function(arg_46_0, arg_46_1)
		return function(arg_47_0)
			local var_47_0 = item_data[arg_47_0.dropid].equip_quality
			local var_47_1 = ccui.ImageView:create(var_0_52[item_data[arg_47_0.dropid].equip_quality], var_0_53)
			local var_47_2 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

			if arg_47_0.dropnum > 1 then
				var_47_2:setString(item_data[arg_47_0.dropid].name .. " X" .. arg_47_0.dropnum)
			else
				var_47_2:setString(item_data[arg_47_0.dropid].name)
			end

			var_47_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_47_2:setPosition(cc.p(var_47_1:getContentSize().width / 2, var_47_1:getContentSize().height / 2 - 90))
			var_47_1:addChild(var_47_2, 1)

			local var_47_3 = ccui.Layout:create()

			var_47_3:setClippingEnabled(true)
			var_47_3:setContentSize(cc.size(170, 170))
			var_47_3:setPosition(cc.p(var_47_1:getContentSize().width / 2 - 85, var_47_1:getContentSize().height / 2 - 56))
			var_47_3:setCascadeOpacityEnabled(true)
			var_47_3:setName("clip")
			var_47_1:addChild(var_47_3)

			local var_47_4 = cc.Sprite:create("equipment/" .. item_data[arg_47_0.dropid].image_id .. ".png")

			var_47_4:setPosition(cc.p(84, 84))
			var_47_4:setName("icon")
			var_47_3:addChild(var_47_4)

			if var_47_0 >= 5 then
				local var_47_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

				var_47_5:setScale(1.25)
				var_47_5:setName("eggEffect")
				var_47_5:setAnchorPoint(cc.p(0.5, 0.5))
				var_47_5:setPosition(var_47_1:getContentSize().width / 2, var_47_1:getContentSize().height / 2)

				local var_47_6 = cc.Animation:create()

				for iter_47_0 = 1, 8 do
					var_47_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_47_0 .. ".png")))
				end

				var_47_6:setDelayPerUnit(0.1)
				var_47_6:setRestoreOriginalFrame(true)
				var_47_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_47_6)))
				var_47_1:addChild(var_47_5)
			end

			if item_data[arg_47_0.dropid].bag_item_type == kITEM_WEAPON then
				var_47_4:setScale(0.65)
			end

			return var_47_1
		end
	end,
	__call = function(self, arg_48_1, ...)
		return self[arg_48_1](...)
	end
})

function SkinTwisteggLayer:showTwistFinalResult(arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	self.skipBnt:setVisible(false)
	self.twistSureBtn:setVisible(false)
	self.twistAgainBtn:setVisible(false)
	self.twistLeftTimesLabel:setVisible(false)
	self.twistingRectPanel:setVisible(true)
	self.resultBg:setTexture(var_0_40)
	self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(false)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/twist_animation/eggegg.plist")

	self.resultTouchEnabled = false

	local var_49_0 = #arg_49_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_62()

	local function var_49_1(arg_50_0)
		local var_50_0 = self.twistingRectPanel:getChildByName("rect" .. arg_50_0)

		if not var_50_0 then
			var_50_0 = L2Skeleton:create(var_0_42 .. ".json", var_0_42 .. ".atlas", nil, true)

			var_50_0:refreshSkeleton()
			var_50_0:setName("rect" .. arg_50_0)
			self.twistingRectPanel:addChild(var_50_0)
		end

		return var_50_0
	end

	local function var_49_2()
		return coroutine.create(function()
			for iter_52_0 = 1, #arg_49_2 do
				local var_52_0 = var_49_1(iter_52_0)

				var_52_0:setPosition(var_49_0[iter_52_0])
				var_52_0:setVisible(true)
				var_52_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_53_0)
					if arg_53_0.animation == "blue-out" or arg_53_0.animation == "orange-out" or arg_53_0.animation == "red-out" or arg_53_0.animation == "purple-out" then
						var_52_0:setVisible(false)
					end
				end)

				local var_52_1 = arg_49_2[iter_52_0].dropid
				local var_52_2 = arg_49_2[iter_52_0].entityid
				local var_52_3, var_52_4 = var_52_0:getPosition()
				local var_52_5 = item_data[var_52_1].bag_item_type
				local var_52_6 = var_0_63(item_data[var_52_1].bag_item_type, arg_49_2[iter_52_0], self.twistBlackCard)

				var_52_6:setName("item" .. iter_52_0)
				var_52_6:setPosition(cc.p(var_52_3, var_52_4))
				var_52_6:setOpacity(0)

				local var_52_7 = var_52_6:getChildByName("clip"):getChildByName("icon")

				var_52_7:setOpacity(0)
				self.twistingRectPanel:addChild(var_52_6)
				var_52_6:setTouchEnabled(true)
				var_52_6:addTouchEventListener(function(arg_54_0, arg_54_1)
					if arg_54_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not self.resultTouchEnabled then
						return
					end

					if var_52_5 == kITEM_HORCRUX then
						if self.twistConfig[arg_49_1].stat == 3 then
							local var_54_0 = -1

							for iter_54_0, iter_54_1 in pairs((require("data.photofile_HelpGirl_data"))) do
								if var_52_1 == iter_54_1.item_id then
									var_54_0 = iter_54_0

									break
								end
							end

							if var_54_0 == -1 then
								print("did not find id")

								return
							end

							require("view.Layer.DetailsofHelpGirlLayer")
							LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
								id = var_54_0,
								itemid = var_52_1,
								callback = callback
							})
						else
							LayerManager:pushInLayer("HorcruxInfoLayer", var_52_2, "twist_preview")
						end

						return
					end

					if var_52_5 == kITEM_HERO then
						if arg_49_2[iter_52_0].itemid == 1500001 then
							if not global_basic_scene:getChildByName("OTHER_LAYER") then
								local var_54_2 = PopLayer:Item({
									hideGainButton = true,
									itemid = arg_49_2[iter_52_0].itemid
								})
							end
						else
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = SHOW_TYPE_TWISTEGG_PREVIEW,
								cursoul = item_data[var_52_1].servant
							})
						end

						return
					end

					if not global_basic_scene:getChildByName("OTHER_LAYER") then
						local var_54_3 = PopLayer:Item({
							hideGainButton = true,
							itemid = var_52_1
						})
					end
				end)

				if item_data[var_52_1].equip_quality == 6 then
					var_52_0:play("red-out", false)
				elseif item_data[var_52_1].equip_quality == 5 then
					var_52_0:play("orange-out", false)
				elseif item_data[var_52_1].equip_quality == 4 then
					var_52_0:play("purple-out", false)
				else
					var_52_0:play("blue-out", false)
				end

				var_52_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_52_7:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_52_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.CallFunc:create(function()
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT_AFTER)
				end)))

				if not var_0_60[arg_49_1] then
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				end

				coroutine.yield(iter_52_0)
			end

			if arg_49_4 and arg_49_4 > 0 then
				self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(true)

				if self.lastTwistBlackCard == BLACK_CARD then
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_bg1.png", var_0_53)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format(L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_49_4))
				else
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_sp_bg1.png", var_0_53)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format("SP" .. L_PLAYER_DATA_TYPE.Horcrux_Card .. "x%d", arg_49_4))
				end
			end

			self.twistSureBtn:setOpacity(0)
			self.twistSureBtn:setVisible(true)
			self.twistSureBtn:runAction(cc.FadeIn:create(0.2))

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
	end

	local var_49_3 = var_49_2()
	local var_49_4, var_49_5 = coroutine.resume(var_49_3)

	assert(var_49_4, var_49_5)

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_56_0)
		if not var_49_3 then
			var_49_3 = var_49_2()

			return
		end

		local var_56_0, var_56_1 = coroutine.resume(var_49_3)

		assert(var_56_0, var_56_1)

		if var_56_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_49_3 = nil
			self.resultTouchEnabled = true
		end
	end, 0.2, false)

	self:registerFinalResultBntEvent(arg_49_1, arg_49_3)
end
