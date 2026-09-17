local SkinShowManager = class("SkinShowManager", (require("controller.base_manager")))

SkinShowManager.MULTITON_MSG = "SkinShowManager instancealready constructed!"

local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")

local function var_0_4(arg_1_0, arg_1_1)
	return not global_is_hide_skin_by_itemid(arg_1_0, arg_1_1)
end

function SkinShowManager:ctor()
	SkinShowManager.super.ctor(self)

	self._data = {}
	self._defaultInfo = {}
end

function SkinShowManager:requestInfo(arg_3_1)
	self.skinshops = {}

	require("controller.shop_manager"):get_shop_clothes_data(function(arg_4_0)
		self.skinshops = arg_4_0
	end)
end

function SkinShowManager:handlerInfo(arg_5_1)
	return
end

function SkinShowManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function SkinShowManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function SkinShowManager:setDefaultInfo(arg_8_1)
	self._defaultInfo = arg_8_1
end

function SkinShowManager:getDefaultInfo()
	return self._defaultInfo
end

function SkinShowManager:getSoulDresses(arg_10_1, arg_10_2)
	local item_manager = require("controller.item_manager")
	local model_data = require("data.model_data")
	local item_data = require("data.item_data")
	local playermodel = require("model.playermodel")
	local dormitory_manager = require("controller.dormitory_manager")
	local hexie_manager = require("controller.hexie_manager")
	local var_10_6 = {}
	local var_10_7 = {}
	local var_10_8 = 1

	while major_factor_data[arg_10_1]["item" .. var_10_8] do
		if var_0_4(major_factor_data[arg_10_1]["item" .. var_10_8], major_factor_data[arg_10_1]["item" .. var_10_8 .. "_hide"]) then
			table.insert(var_10_7, {
				modelid = item_data[major_factor_data[arg_10_1]["item" .. var_10_8]].model,
				order = var_10_8,
				count = item_manager:getItemNumber(major_factor_data[arg_10_1]["item" .. var_10_8])
			})
		end

		var_10_8 = var_10_8 + 1
	end

	if major_factor_data[arg_10_1].item_oc then
		if hexie_manager:canShowOverClock() and hexie_manager:canPreviewSkin(major_factor_data[arg_10_1].item_oc) then
			table.insert(var_10_7, {
				isOc = true,
				modelid = item_data[major_factor_data[arg_10_1].item_oc].model,
				order = var_10_8,
				count = item_manager:getItemNumber(major_factor_data[arg_10_1].item_oc)
			})
		end
	end

	table.insert(var_10_7, 1, {
		modelid = servant_data[arg_10_2].modelid
	})

	local var_10_10 = {}

	for iter_10_0 = 1, #var_10_7 do
		local var_10_11
		local var_10_12 = model_data[var_10_7[iter_10_0].modelid].itemid

		if var_10_7[iter_10_0].isOc then
			var_10_12 = major_factor_data[arg_10_1].item_oc
		end

		if var_10_12 then
			var_10_11 = item_data[var_10_12].logo_str
		end

		local var_10_13 = ""
		local var_10_14 = "43210B"
		local var_10_15 = "SkinShowPopLayer/sure_btn.png"
		local var_10_16 = false
		local var_10_17 = false

		if iter_10_0 == 1 then
			var_10_16 = playermodel.haveServant[arg_10_2]

			if playermodel.haveServant[arg_10_2] then
				var_10_13 = "已拥有"
				var_10_14 = "50495C"
				var_10_15 = "SkinShowPopLayer/sure_btn_off.png"
			else
				var_10_13 = "前往获取"
			end
		else
			var_10_16 = var_10_7[iter_10_0].count > 0

			if var_10_16 then
				if var_10_12 then
					if playermodel.dress[arg_10_1] == var_10_12 then
						var_10_17 = true
						var_10_13 = "当前装扮"
						var_10_14 = "50495C"
						var_10_15 = "SkinShowPopLayer/sure_btn_off.png"
					else
						var_10_13 = "穿戴"
					end
				end
			else
				var_10_13 = "购买"
			end
		end

		local var_10_18 = model_data[var_10_7[iter_10_0].modelid].main_name

		if model_data[var_10_7[iter_10_0].modelid].uncolor_clothes then
			var_10_10[tostring(model_data[var_10_7[iter_10_0].modelid].uncolor_clothes)] = true
		end

		local function var_10_19(arg_11_0, arg_11_1)
			if iter_10_0 == 1 then
				local Utility = require("common.Utility")
				local var_11_1 = major_factor_data[model_data[var_10_7[iter_10_0].modelid].major].servant

				for iter_11_0, iter_11_1 in ipairs((Utility:parseDataByElement(item_data[servant_data[major_factor_data[model_data[var_10_7[iter_10_0].modelid].major].servant].itemid], {
					{
						index = "targetlayer",
						name = "roleJump"
					},
					{
						index = "targetlayer_starttime",
						name = "startTime",
						hyphen = "_"
					},
					{
						index = "targetlayer_finishtime",
						name = "endTime",
						hyphen = "_"
					}
				}))) do
					if tonumber(iter_11_1.roleJump) and Utility:isTimeRangeValid(iter_11_1.startTime, iter_11_1.endTime) or tonumber(iter_11_1.roleJump) and not iter_11_1.startTime and not iter_11_1.endTime then
						if not playermodel.haveServant[var_11_1] then
							Utility:executeLayerJump({
								systemid = tonumber(iter_11_1.roleJump)
							})
						else
							global_ShowBlockWords("已拥有该学员")
						end

						return
					end
				end

				global_ShowBlockWords("暂时没有获取该学员的途径")
			elseif var_10_16 then
				local var_11_2

				if (dormitory_manager:getSoulDressModelid(arg_10_1) or major_factor_data[arg_10_1].model) == var_10_7[iter_10_0].modelid then
					return
				end

				var_11_2 = model_data[var_10_7[iter_10_0].modelid].itemid and model_data[var_10_7[iter_10_0].modelid].itemid or -1

				dormitory_manager:changeSoulDress(arg_10_1, (var_10_7[iter_10_0].isOc or nil) and major_factor_data[arg_10_1].item_oc, function(arg_12_0, arg_12_1)
					if arg_12_0 == 1 then
						if self.layer then
							self.layer:changeSoulDressSuccess()
						end
					elseif arg_12_0 == 2 then
						global_ShowBlockWords("学员未解锁")
					elseif arg_12_0 == 4 then
						global_ShowBlockWords("服装不存在")
					end
				end)
			else
				local var_11_5 = var_10_7[iter_10_0].modelid
				local var_11_6
				local var_11_7
				local var_11_8
				local var_11_9

				if arg_11_0 then
					var_11_6 = arg_11_0
					var_11_7 = tonumber(split(arg_11_1, "-")[2])
				else
					var_11_6, var_11_7 = self:findShopid(arg_10_1, var_11_5)
					var_11_8, var_11_9 = self:findPackageid(arg_10_1, var_11_5)
				end

				if var_11_6 then
					self:shopPop(var_11_6, var_11_7, "shopitem")
				elseif var_11_8 then
					self:shopPop(var_11_8, var_11_9, "giftitem")
				elseif item_data[model_data[var_11_5].itemid].skin_type == "marry" then
					LayerManager:pushInLayer("MarryPopLayer", {
						majorid = arg_10_1,
						exitCallback = function()
							if self.layer then
								self.layer:exitMarryPopLayer()
							end
						end
					})
				elseif item_data[model_data[var_11_5].itemid].targetlayer1 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = model_data[var_11_5].itemid
					})
				elseif var_10_7[iter_10_0].isOc then
					global_ShowBlockWords("超频后获得")
				else
					global_ShowBlockWords(L_CURRENT_SKIN_UNBLE_TO_BUY)
				end
			end
		end

		local var_10_20 = string.len(model_data[var_10_7[iter_10_0].modelid].English_name)
		local var_10_21 = {}

		for iter_10_1 = 1, var_10_20 do
			table.insert(var_10_21, string.sub(model_data[var_10_7[iter_10_0].modelid].English_name, iter_10_1, iter_10_1))

			if iter_10_1 ~= var_10_20 then
				table.insert(var_10_21, " ")
			end
		end

		for iter_10_2 = 1, #var_10_21 do
			-- block empty
		end

		table.insert(var_10_6, {
			englishName = "F i t t i n g  R o o m",
			modelId = var_10_7[iter_10_0].modelid,
			groupName = var_10_11,
			mainName = var_10_18,
			bHave = var_10_16,
			btnStr = var_10_13,
			btnStrColor = var_10_14,
			btnPath = var_10_15,
			sureCallBack = var_10_19,
			roleName = major_factor_data[arg_10_1].easy_name,
			live2d = (model_data[var_10_7[iter_10_0].modelid].live2d and not model_data[var_10_7[iter_10_0].modelid].origin or nil) and model_data[var_10_7[iter_10_0].modelid].live2d,
			roleSpine = (model_data[var_10_7[iter_10_0].modelid].rolespine or nil) and model_data[var_10_7[iter_10_0].modelid].rolespine,
			bDress = var_10_17
		})
	end

	for iter_10_3 = 1, #var_10_6 do
		if var_10_10[var_10_6[iter_10_3].modelId] then
			var_10_6[iter_10_3].uncolorClothes = true
		end
	end

	return var_10_6
end

function SkinShowManager:cleanData()
	self.skinshops = {}
end

function SkinShowManager:shopPop(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local network = require("network.network")
	local item_manager = require("controller.item_manager")
	local lua = require("controller.audio_manager.lua")
	local shop_manager = require("controller.shop_manager")
	local discount_manager = require("controller.discount_manager")
	local var_15_6 = {
		function()
			return playerModel.gold
		end,
		[0] = function()
			return playerModel.diamond
		end,
		function()
			return playerModel.honor
		end,
		function()
			return playerModel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_15_6, {
		__index = function(arg_21_0, arg_21_1)
			return function()
				return item_manager:getItemNumber(arg_21_1)
			end
		end
	})

	local var_15_7 = {
		"public/currency/UI_battleEnd_gold.png",
		[0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_15_7, {
		__index = function(arg_23_0, arg_23_1)
			return "public/currency/" .. item_data[arg_23_1].image_id .. ".png"
		end
	})

	local var_15_8 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[6800601] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer"
			})
		end
	}

	setmetatable(var_15_8, {
		__index = function(arg_29_0, arg_29_1)
			return function(arg_30_0)
				if not item_data[arg_30_0].targetlayer1 then
					global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_29_1].name))

					return
				end

				if arg_30_0 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_30_0
					})
				end

				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_15_9 = {}

	local function var_15_10(arg_31_0)
		local var_31_0 = var_15_9

		if arg_31_0.result == 1 then
			if not arg_31_0.selectCoupon then
				shop_manager:shop_buy(var_15_9.shoptype, var_15_9.shopitem.shopid, function(arg_32_0)
					if arg_32_0 == 1 then
						arg_15_1.have_bought = arg_15_1.have_bought + var_31_0.curbuyTime
						arg_15_1.sell_out = arg_15_1.buy_limit and arg_15_1.buy_limit <= arg_15_1.have_bought

						if var_31_0.shopitem.bag_item_type == kITEM_SKIN or var_31_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							AnalyticManager.dorm_buy_dress_success({
								soulid = soulId,
								itemid = var_31_0.shopitem.itemid
							})
						end

						if self.layer then
							self.layer:buySuccess()
						end

						if item_data[var_31_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_31_0.itemid), 1000)
						end

						if var_31_0.callback then
							var_31_0.callback()
						end
					elseif arg_32_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						lua:playeffectMusicTest("sound/invalid")
					elseif arg_32_0 == 3 then
						var_15_8[var_31_0.shopitem.currency](var_31_0.shopitem.currency)
					end
				end, var_15_9.curbuyTime, function()
					LayerManager:removePopLayer()
				end)
			else
				shop_manager:shop_buy_with_ticket(var_15_9.shoptype, var_15_9.shopitem.shopid, function(arg_34_0)
					if arg_34_0 == 1 then
						arg_15_1.have_bought = arg_15_1.have_bought + var_31_0.curbuyTime
						arg_15_1.sell_out = arg_15_1.buy_limit and arg_15_1.buy_limit <= arg_15_1.have_bought

						if var_31_0.shopitem.bag_item_type == kITEM_SKIN or var_31_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							AnalyticManager.dorm_buy_dress_success({
								soulid = soulId,
								itemid = var_31_0.shopitem.itemid
							})
						end

						if self.layer then
							self.layer:buySuccess()
						end

						if item_data[var_31_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_31_0.itemid), 1000)
						end

						if var_31_0.callback then
							var_31_0.callback()
						end
					elseif arg_34_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						lua:playeffectMusicTest("sound/invalid")
					elseif arg_34_0 == 3 then
						var_15_8[var_31_0.shopitem.currency](var_31_0.shopitem.currency)
					end
				end, var_15_9.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_31_0.selectCoupon, 1)
			end
		end
	end

	local function var_15_11(arg_36_0)
		if not arg_36_0.currency2 or discount_manager:getLastPriceByItem(arg_36_0.itemid, arg_36_0.currency2, arg_36_0.discount2) < arg_36_0.discount2 then
			return true
		end

		return false
	end

	local function var_15_12(arg_43_0)
		local var_43_0 = {}

		if arg_43_0.currency2 then
			var_43_0.currency2 = arg_43_0.currency2
			var_43_0.costIcon2 = var_15_7[arg_43_0.currency2]
			var_43_0.cost2 = arg_43_0.discount2 or arg_43_0.price2
			var_43_0.cost_old2 = arg_43_0.price2
			var_43_0.discount2 = arg_43_0.discount2
		end

		local var_43_1 = arg_43_0.itemtype or arg_43_0.itemid

		var_43_0.name = item_data[var_43_1].name
		var_43_0.itemid = var_43_1
		var_43_0.shopid = arg_43_0.shopid
		var_43_0.costIcon = var_15_7[arg_43_0.currency]
		var_43_0.currency = arg_43_0.currency
		var_43_0.isnewitem = arg_43_0.isnewitem
		var_43_0.discountfinish = arg_43_0.discountfinish
		var_43_0.cost = arg_43_0.discount or arg_43_0.price or arg_43_0.cost_old
		var_43_0.quality = item_data[var_43_1].equip_quality or 1
		var_43_0.cost_old = arg_43_0.price or var_43_0.cost_old
		var_43_0.bag_item_type = item_data[var_43_1].bag_item_type
		var_43_0.item_attr = arg_43_0.item_attr
		var_43_0.finish_time = arg_43_0.finish_time
		var_43_0.discount = arg_43_0.discount
		var_43_0.buy_limit = arg_43_0.buy_limit or 1000000
		var_43_0.have_bought = arg_43_0.have_bought or 0
		var_43_0.sell_out = arg_43_0.buy_limit and arg_43_0.buy_limit <= arg_43_0.have_bought
		var_43_0.tag = arg_43_0.tag or 0
		var_43_0.pos = arg_43_0.pos
		var_43_0.purchaseid = arg_43_0.productid or arg_43_0.purchaseid

		return var_43_0
	end

	if arg_15_1.currency == 100 then
		(function(arg_39_0)
			local var_39_0 = {
				itemid = arg_39_0.itemid,
				item_attr = arg_39_0.item_attr
			}
			local var_39_1 = {
				costtype = arg_39_0.costIcon
			}

			var_39_1.costnum = arg_39_0.discount or arg_39_0.cost
			var_39_0.slidecost = var_39_1

			function var_39_0:ShopSliderCallback(arg_40_1, arg_40_2)
				if arg_40_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_39_0.have_bought >= arg_39_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					lua:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_39_0.shopid, arg_39_0.purchaseid, function(arg_41_0)
					if arg_41_0 == 1 then
						arg_15_1.have_bought = arg_15_1.have_bought + curbuyTime
						arg_15_1.sell_out = arg_15_1.buy_limit and arg_15_1.buy_limit <= arg_15_1.have_bought

						if arg_39_0.bag_item_type ~= kITEM_SKIN and arg_39_0.bag_item_type == kITEM_SKIN_GIFT then
							-- block empty
						end

						if self.layer then
							self.layer:buySuccess()
						end

						LayerManager:removePopLayer(self.__queueindex)

						if item_data[var_39_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_39_0.itemid), 1000)
						end

						if arg_15_2 == 6 then
							for iter_41_0, iter_41_1 in pairs({
								{
									entityid = var_39_0.itemid
								}
							}) do
								network:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_41_1.entityid
								}, function(arg_42_0)
									if arg_42_0.result == 1 then
										global_gain(arg_42_0)
										item_manager:deleteItem(iter_41_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								items = {
									{
										dropNum = 1,
										dropid = var_39_0.itemid,
										entityid = var_39_0.itemid
									}
								}
							})
						end
					elseif arg_41_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						lua:playeffectMusicTest("sound/invalid")
					end

					if arg_40_2 then
						arg_40_2(arg_41_0)
					end
				end)
			end

			if arg_15_2 == 4 or arg_15_2 == 6 then
				self:showBuyPop(var_39_0, nil, arg_15_3)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_39_0.isnewitem = false
		end)(var_15_12(arg_15_1))
	else
		(function(arg_37_0)
			local var_37_0 = {
				itemid = arg_37_0.itemid,
				item_attr = arg_37_0.item_attr
			}

			var_37_0.limitNum = arg_37_0.buy_limit and (arg_37_0.buy_limit - arg_37_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_37_0.buy_limit - arg_37_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

			local var_37_1

			if var_15_11(arg_37_0) then
				var_37_1 = math.floor(var_15_6[arg_37_0.currency]() / arg_37_0.cost)
				var_37_0.currency = arg_37_0.currency
			else
				var_37_1 = math.floor(var_15_6[arg_37_0.currency2]() / arg_37_0.cost2)
				var_37_0.currency = arg_37_0.currency2
			end

			if var_37_1 > var_37_0.limitNum then
				var_37_0.limitNum = var_37_0.limitNum or var_37_1
			end

			local var_37_2 = self:getResidueTime(arg_37_0.finish_time)

			if var_37_2 ~= "-1" then
				var_37_0.limit_time = L_MARKET_MSG.Rest_Time .. var_37_2
			end

			var_37_0.slidecost = {}

			if var_15_11(arg_37_0) then
				var_37_0.slidecost.costtype = arg_37_0.costIcon
				var_37_0.slidecost.costnum = arg_37_0.discount or arg_37_0.cost
				var_37_0.slidecost.nowHave = var_15_6[arg_37_0.currency]()
				var_37_0.slidecost.cost_old = arg_37_0.cost_old or var_37_0.slidecost.costnum
			else
				var_37_0.slidecost.costtype = arg_37_0.costIcon2
				var_37_0.slidecost.costnum = arg_37_0.discount2 or arg_37_0.cost2
				var_37_0.slidecost.nowHave = var_15_6[arg_37_0.currency2]()
				var_37_0.slidecost.cost_old = arg_37_0.cost_old2 or var_37_0.slidecost.costnum
			end

			function var_37_0:ShopSliderCallback(arg_38_1, arg_38_2, arg_38_3)
				if arg_38_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_38_0 = self.nowNum or 1

				var_15_9 = {
					curbuyTime = var_38_0,
					shoptype = arg_15_2,
					itemid = var_37_0.itemid,
					callback = arg_38_2,
					shopitem = arg_37_0
				}

				if not arg_38_3 and var_15_11(arg_37_0) and arg_37_0.cost > var_15_6[arg_37_0.currency]() then
					LayerManager:removePopLayer()
					var_15_8[arg_37_0.currency](arg_37_0.currency)

					return
				end

				self:setTouchEnabled(false)
				var_15_10({
					result = 1,
					selectCoupon = arg_38_3
				})
			end

			var_37_0.hideGainButton = true

			if arg_37_0.have_bought and arg_37_0.buy_limit then
				var_37_0.limit_buy_num = arg_37_0.buy_limit - arg_37_0.have_bought
				var_37_0.have_bought_num = arg_37_0.have_bought
			end

			self:showBuyPop(var_37_0, arg_15_2, arg_15_3)

			arg_37_0.isnewitem = false
		end)(var_15_12(arg_15_1))
	end
end

function SkinShowManager:showBuyPop(arg_44_1, arg_44_2, arg_44_3)
	arg_44_1.couponList = require("controller.discount_manager"):getCanUseCoupin(arg_44_1.itemid, arg_44_1.currency, arg_44_1.costnum or arg_44_1.slidecost.costnum, arg_44_2)

	if not arg_44_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_44_1)
	elseif arg_44_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_44_1)
	elseif arg_44_3 == "giftitem" then
		if arg_44_1.couponList and next(arg_44_1.couponList) then
			LayerManager:pushInLayer("PopGoodsLayer", arg_44_1)
		else
			LayerManager:pushInLayer("PopSkinPackage", arg_44_1)
		end
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_44_1)
	end
end

function SkinShowManager:getResidueTime(arg_45_1)
	if not arg_45_1 then
		return "-1"
	end

	local var_45_5 = global_get_time_by_date(arg_45_1) - require("model.playermodel").onlineTime
	local var_45_6 = math.floor(var_45_5 / 24 / 3600)
	local var_45_7 = math.floor((var_45_5 - var_45_6 * 24 * 3600) / 3600)
	local var_45_8 = math.floor((var_45_5 - var_45_6 * 24 * 3600 - var_45_7 * 3600) / 60)

	return var_45_6 ~= 0 and string.format(L_TIME_TEXT[1], var_45_6, var_45_7) or var_45_7 ~= 0 and string.format(L_TIME_TEXT[2], var_45_7, var_45_8) or string.format(L_TIME_TEXT[3], var_45_8)
end

function SkinShowManager:findShopid(arg_46_1, arg_46_2)
	if not self.skinshops then
		return false
	end

	if not self.skinshops.skin then
		return false
	end

	if not self.skinshops.skin[arg_46_1] then
		return false
	end

	for iter_46_0, iter_46_1 in pairs(self.skinshops.skin[arg_46_1]) do
		if item_data[iter_46_1.shopinfo.itemtype].model == arg_46_2 then
			return iter_46_1.shopinfo, iter_46_1.shoptype
		end
	end

	return false
end

function SkinShowManager:findPackageid(arg_47_1, arg_47_2)
	local drop_manager = require("controller.drop_manager")

	if not self.skinshops then
		return false
	end

	if not self.skinshops.skin_package then
		return false
	end

	if not self.skinshops.skin_package[arg_47_1] then
		return false
	end

	for iter_47_0, iter_47_1 in pairs(self.skinshops.skin_package[arg_47_1]) do
		if item_data[iter_47_1.shopinfo.itemtype].mode_id then
			for iter_47_2, iter_47_3 in pairs((drop_manager:getEquipDrops(item_data[iter_47_1.shopinfo.itemtype].mode_id))) do
				if item_data[iter_47_3.dropid].model and item_data[iter_47_3.dropid].model == arg_47_2 then
					return iter_47_1.shopinfo, iter_47_1.shoptype
				end
			end
		elseif item_data[iter_47_1.shopinfo.itemtype].model == arg_47_2 then
			return iter_47_1.shopinfo, iter_47_1.shoptype
		end
	end

	return false
end

return SkinShowManager
