local CostumeRoomManager = class("CostumeRoomManager", (require("controller.base_manager")))
local var_0_1 = tonumber
local var_0_2 = global_get_time_by_date

CostumeRoomManager.MULTITON_MSG = "CostumeRoomManager instancealready constructed!"
CostumeRoomManager.CustomSkinTypeStr = "SkinTypeFilter"
CostumeRoomManager.CustomSavePrefix = "CostumeRoomManager_FilterRule_"
CostumeRoomManager.CostIconPath = {
	[0] = "public/currency/UI_battleEnd_diamond.png",
	"public/currency/UI_battleEnd_gold.png",
	"public/currency/arenascene_dot_1.png",
	"public/currency/explorecoin.png",
	[1500001] = "public/currency/1500001_1.png",
	[100] = "public/currency/rmb_white.png"
}

setmetatable(CostumeRoomManager.CostIconPath, {
	__index = function(arg_1_0, arg_1_1)
		return "public/currency/" .. require("data.item_data")[arg_1_1].image_id .. ".png"
	end
})

CostumeRoomManager.SpecialHeader = {
	"CostumeRoomLayer/specialHeader1.png"
}
CostumeRoomManager.FilterRule = {
	Live2D = CostumeRoomManager.CustomSavePrefix .. "Live2D",
	UncolorClothes = CostumeRoomManager.CustomSavePrefix .. "UncolorClothes",
	MemberState = CostumeRoomManager.CustomSavePrefix .. "MemberState",
	SkinState = CostumeRoomManager.CustomSavePrefix .. "SkinState"
}
CostumeRoomManager.FilterState = {
	On = 1,
	Off = 0
}
CostumeRoomManager.MemberState = {
	Have = 1,
	All = 0,
	Not_Have = 2
}
CostumeRoomManager.SkinState = {
	Have = 1,
	All = 0,
	Not_Have = 2
}
CostumeRoomManager.HexieGroup = {}

function CostumeRoomManager:ctor()
	self.super.ctor(self)

	self._data = {}
	self.itemData = require("data.item_data")
	self.majorFactorData = require("data.major_factor_data")
	self.modelData = require("data.model_data")
	self.favorfileData = require("data.favorfile_data")
	self.servantData = require("data/servant_data")
	self.roleDefault = RoleDefault:getInstance()

	self:initFilterData()

	self._typeFilter = self:getTypeFilter()
end

function CostumeRoomManager:initFilterData()
	self.filterData = {
		[self.FilterRule.Live2D] = self:getFilterState(self.FilterRule.Live2D),
		[self.FilterRule.UncolorClothes] = self:getFilterState(self.FilterRule.UncolorClothes),
		[self.FilterRule.MemberState] = self:getMemberState(self.FilterRule.MemberState),
		[self.FilterRule.SkinState] = self:getSkinState(self.FilterRule.SkinState)
	}

	local var_3_0 = self:getTypeFilter()

	for iter_3_0 = 1, #var_3_0 do
		self.filterData[self.FilterRule[self.CustomSkinTypeStr .. var_3_0[iter_3_0].group]] = self:getFilterState(self.FilterRule[self.CustomSkinTypeStr .. var_3_0[iter_3_0].group])
	end
end

function CostumeRoomManager:getShopClothesData_uniqueItem()
	if not self.shopClothesData_uniqueItem then
		self.shopClothesData_uniqueItem = {}
		self.shopClothesData = require("data.shop.shop_clothes_data")

		local var_4_0 = require("controller.time_check_manager"):getCurTime()

		for iter_4_0, iter_4_1 in pairs(self.shopClothesData) do
			local var_4_1 = iter_4_1.unique_item
			local var_4_2 = true

			if iter_4_1.start_time and iter_4_1.finish_time then
				if var_4_0 >= var_0_2(iter_4_1.start_time) and var_4_0 < var_0_2(iter_4_1.finish_time) then
					var_4_2 = false
				end
			elseif iter_4_1.start_time and not iter_4_1.finish_time then
				if var_4_0 >= var_0_2(iter_4_1.start_time) then
					var_4_2 = false
				end
			elseif not iter_4_1.start_time and iter_4_1.finish_time then
				if var_4_0 < var_0_2(iter_4_1.finish_time) then
					var_4_2 = false
				end
			elseif not iter_4_1.start_time and not iter_4_1.finish_time then
				var_4_2 = false
			end

			if not var_4_2 and var_4_1 then
				self.shopClothesData_uniqueItem[var_4_1] = iter_4_1
			end
		end
	end

	return self.shopClothesData_uniqueItem
end

function CostumeRoomManager:getPriceTable(arg_5_1)
	arg_5_1 = var_0_1(arg_5_1)

	local time_check_manager = require("controller.time_check_manager")
	local var_5_1 = {}
	local var_5_2 = self:getShopClothesData_uniqueItem()

	local function var_5_3(arg_6_0)
		local var_6_0 = arg_6_0 - time_check_manager:getCurTime()
		local var_6_1 = math.floor(var_6_0 / 86400)
		local var_6_2 = math.floor((var_6_0 - var_6_1 * 86400) / 3600)

		return "商品剩余时间：" .. (var_6_1 > 0 and var_6_1 .. "天" .. var_6_2 .. "小时" or var_6_2 .. "小时" .. math.floor((var_6_0 - var_6_1 * 86400 - var_6_2 * 3600) / 60) .. "分")
	end

	if arg_5_1 and var_5_2[arg_5_1] and var_5_2[arg_5_1].price then
		local var_5_4 = {}

		var_5_4.discountedPrice = var_5_2[arg_5_1].discount
		var_5_4.currency = var_5_2[arg_5_1].currencytype
		var_5_4.costIconPath = CostumeRoomManager.CostIconPath[var_5_4.currency]
		var_5_4.originalPrice = var_5_2[arg_5_1].price
		var_5_4.currentPrice = var_5_2[arg_5_1].price
		var_5_4.bBuy = false
		var_5_4.bDiscount = false
		var_5_4.startTime = var_5_2[arg_5_1].start_time
		var_5_4.finishTime = var_5_2[arg_5_1].finish_time

		local var_5_5 = var_5_2[arg_5_1].discountstart
		local var_5_6 = var_5_2[arg_5_1].discountfinish
		local var_5_7 = time_check_manager:getCurTime()

		if var_5_2[arg_5_1].start_time and var_5_2[arg_5_1].finish_time then
			local var_5_8 = var_0_2(var_5_2[arg_5_1].finish_time)

			if var_0_2(var_5_2[arg_5_1].start_time) <= var_5_7 and var_5_7 < var_5_8 then
				var_5_4.bBuy = true
				var_5_4.limitTimeStr = var_5_3(var_5_8)
			end
		elseif var_5_2[arg_5_1].start_time and not var_5_2[arg_5_1].finish_time then
			if var_5_7 >= var_0_2(var_5_2[arg_5_1].start_time) then
				var_5_4.bBuy = true
			end
		elseif not var_5_2[arg_5_1].start_time and var_5_2[arg_5_1].finish_time then
			local var_5_9 = var_0_2(var_5_2[arg_5_1].finish_time)

			if var_5_7 < var_5_9 then
				var_5_4.bBuy = true
				var_5_4.limitTimeStr = var_5_3(var_5_9)
			end
		elseif not var_5_2[arg_5_1].start_time and not var_5_2[arg_5_1].finish_time then
			var_5_4.bBuy = true
		end

		if var_5_5 and var_5_6 then
			if var_0_2(var_5_5) <= var_5_7 and var_5_7 < var_0_2(var_5_6) then
				var_5_4.currentPrice = var_5_4.discountedPrice
				var_5_4.bDiscount = true
			end
		end

		table.insert(var_5_1, var_5_4)
	end

	if arg_5_1 and var_5_2[arg_5_1] and var_5_2[arg_5_1].price2 then
		local var_5_10 = {}

		var_5_10.discountedPrice = var_5_2[arg_5_1].discount2
		var_5_10.currency = var_5_2[arg_5_1].currencytype2
		var_5_10.costIconPath = CostumeRoomManager.CostIconPath[var_5_10.currency]
		var_5_10.originalPrice = var_5_2[arg_5_1].price2
		var_5_10.currentPrice = var_5_2[arg_5_1].price2
		var_5_10.bBuy = false
		var_5_10.bDiscount = false

		local var_5_11 = var_5_2[arg_5_1].discountstart
		local var_5_12 = var_5_2[arg_5_1].discountfinish
		local var_5_13 = time_check_manager:getCurTime()

		if var_5_2[arg_5_1].start_time and var_5_2[arg_5_1].finish_time then
			local var_5_14 = var_0_2(var_5_2[arg_5_1].finish_time)

			if var_0_2(var_5_2[arg_5_1].start_time) <= var_5_13 and var_5_13 < var_5_14 then
				var_5_10.bBuy = true
				var_5_10.limitTimeStr = var_5_3(var_5_14)
			end
		elseif var_5_2[arg_5_1].start_time and not var_5_2[arg_5_1].finish_time then
			if var_5_13 >= var_0_2(var_5_2[arg_5_1].start_time) then
				var_5_10.bBuy = true
			end
		elseif not var_5_2[arg_5_1].start_time and var_5_2[arg_5_1].finish_time then
			local var_5_15 = var_0_2(var_5_2[arg_5_1].finish_time)

			if var_5_13 < var_5_15 then
				var_5_10.bBuy = true
				var_5_10.limitTimeStr = var_5_3(var_5_15)
			end
		elseif not var_5_2[arg_5_1].start_time and not var_5_2[arg_5_1].finish_time then
			var_5_10.bBuy = true
		end

		if var_5_11 and var_5_12 then
			if var_0_2(var_5_11) <= var_5_13 and var_5_13 < var_0_2(var_5_12) then
				var_5_10.currentPrice = var_5_10.discountedPrice
				var_5_10.bDiscount = true
			end
		end

		table.insert(var_5_1, var_5_10)
	end

	return var_5_1
end

function CostumeRoomManager:setFilterState(arg_7_1, arg_7_2)
	self.roleDefault:setIntegerForKey(arg_7_1 .. require("model.playermodel").playerid, arg_7_2)

	self.filterData[arg_7_1] = arg_7_2
end

function CostumeRoomManager:getFilterState(arg_8_1)
	return self.roleDefault:getIntegerForKey(arg_8_1 .. require("model.playermodel").playerid, self.FilterState.Off)
end

function CostumeRoomManager:setMemberState(arg_9_1, arg_9_2)
	self.roleDefault:setIntegerForKey(arg_9_1 .. require("model.playermodel").playerid, arg_9_2)

	self.filterData[arg_9_1] = arg_9_2
end

function CostumeRoomManager:getMemberState(arg_10_1)
	return self.roleDefault:getIntegerForKey(arg_10_1 .. require("model.playermodel").playerid, self.MemberState.All)
end

function CostumeRoomManager:setSkinState(arg_11_1, arg_11_2)
	self.roleDefault:setIntegerForKey(arg_11_1 .. require("model.playermodel").playerid, arg_11_2)

	self.filterData[arg_11_1] = arg_11_2
end

function CostumeRoomManager:getSkinState(arg_12_1)
	return self.roleDefault:getIntegerForKey(arg_12_1 .. require("model.playermodel").playerid, self.SkinState.All)
end

function CostumeRoomManager:setFilterStateReverse(arg_13_1)
	if self:getFilterState(arg_13_1) == self.FilterState.On then
		self:setFilterState(arg_13_1, self.FilterState.Off)
	else
		self:setFilterState(arg_13_1, self.FilterState.On)
	end
end

function CostumeRoomManager:getCurFilterState()
	local var_14_0 = {
		self:getMemberState(self.FilterRule.MemberState),
		{}
	}
	local var_14_1 = self:getTypeFilter()

	for iter_14_0 = 1, #var_14_1 do
		var_14_0[2][self.CustomSkinTypeStr .. var_14_1[iter_14_0].group] = self:getFilterState(self.FilterRule[self.CustomSkinTypeStr .. var_14_1[iter_14_0].group])
	end

	var_14_0[3] = self:getFilterState(self.FilterRule.Live2D)
	var_14_0[4] = self:getSkinState(self.FilterRule.SkinState)
	var_14_0[5] = self:getFilterState(self.FilterRule.UncolorClothes)

	return var_14_0
end

function CostumeRoomManager:checkFilterStateIsSame(arg_15_1)
	local var_15_0 = self:getCurFilterState()

	for iter_15_0 = 1, #arg_15_1 do
		if iter_15_0 == 2 then
			for iter_15_1, iter_15_2 in pairs(var_15_0[iter_15_0]) do
				if iter_15_2 ~= arg_15_1[iter_15_0][iter_15_1] then
					return false
				end
			end
		elseif var_15_0[iter_15_0] ~= arg_15_1[iter_15_0] then
			return false
		end
	end

	return true
end

function CostumeRoomManager:setFilterStateTable(arg_16_1)
	local var_16_0 = self:getCurFilterState()

	if var_16_0[1] ~= arg_16_1[1] then
		self:setMemberState(self.FilterRule.MemberState, arg_16_1[1])
	end

	if var_16_0[3] ~= arg_16_1[3] then
		self:setFilterState(self.FilterRule.Live2D, arg_16_1[3])
	end

	if var_16_0[4] ~= arg_16_1[4] then
		self:setSkinState(self.FilterRule.SkinState, arg_16_1[4])
	end

	if var_16_0[5] ~= arg_16_1[5] then
		self:setFilterState(self.FilterRule.UncolorClothes, arg_16_1[5])
	end

	for iter_16_0, iter_16_1 in pairs(var_16_0[2]) do
		if iter_16_1 ~= arg_16_1[2][iter_16_0] then
			self:setFilterState(self.FilterRule[iter_16_0], arg_16_1[2][iter_16_0])
		end
	end
end

function CostumeRoomManager:getTypeFilter()
	if self._typeFilter and next(self._typeFilter) then
		return self._typeFilter
	end

	local var_17_0 = require("controller.GlobalConstantsManager"):getInstance()

	self._typeFilter = {}

	local var_17_2 = self:getAllShowSkin()
	local var_17_3 = {}

	for iter_17_0 = 1, #var_17_2 do
		local var_17_4 = {
			groupName = var_17_2[iter_17_0].groupName,
			group = var_17_2[iter_17_0].group
		}

		self.FilterRule[self.CustomSkinTypeStr .. var_17_4.group] = self.FilterRule[self.CustomSkinTypeStr .. var_17_4.group] or "CostumeRoomManager_FilterRule_" .. self.CustomSkinTypeStr .. var_17_4.group

		if not var_17_3[var_17_4.group] then
			var_17_3[var_17_4.group] = 1

			table.insert(self._typeFilter, var_17_4)
		end
	end

	local var_17_5

	if self:checkExtendGroupIsInTime() then
		var_17_5 = var_17_0:getValueById(3)

		if var_17_5 then
			var_17_5 = string.split(var_17_5, "#")

			if #var_17_5 > 3 then
				local var_17_6 = var_0_1(var_17_5[2])
				local var_17_7 = {
					groupName = var_17_5[1],
					group = var_17_6
				}

				self.FilterRule[self.CustomSkinTypeStr .. var_17_7.group] = self.FilterRule[self.CustomSkinTypeStr .. var_17_7.group] or "CostumeRoomManager_FilterRule_" .. self.CustomSkinTypeStr .. var_17_7.group

				if not var_17_3[var_17_6] then
					var_17_3[var_17_6] = 1

					table.insert(self._typeFilter, var_17_7)
				end
			end
		end
	end

	local var_17_8 = string.split(var_17_0:getValueById(1), "#")

	table.sort(self._typeFilter, function(arg_18_0, arg_18_1)
		local var_18_0 = var_0_1(var_17_8[arg_18_0.group]) or 0
		local var_18_1 = var_0_1(var_17_8[arg_18_1.group]) or 1

		return ((var_17_5 and #var_17_5 > 3 and arg_18_0.group == var_0_1(var_17_5[2]) or nil) and var_0_1(var_17_5[3])) < ((var_17_5 and #var_17_5 > 3 and arg_18_1.group == var_0_1(var_17_5[2]) or nil) and var_0_1(var_17_5[3]))
	end)

	return self._typeFilter
end

function CostumeRoomManager:checkFilter()
	for iter_19_0, iter_19_1 in pairs(self.filterData) do
		if iter_19_0 == CostumeRoomManager.FilterRule.MemberState then
			if iter_19_1 ~= CostumeRoomManager.MemberState.All then
				return true
			end
		elseif iter_19_0 == CostumeRoomManager.FilterRule.SkinState then
			if iter_19_1 ~= CostumeRoomManager.SkinState.All then
				return true
			end
		elseif iter_19_1 == CostumeRoomManager.FilterState.On then
			return true
		end
	end

	return false
end

function CostumeRoomManager:getAllShowSkin()
	local item_manager = require("controller.item_manager")
	local hexie_manager = require("controller.hexie_manager")
	local var_20_2 = {}
	local socket = require("socket")
	local var_20_4 = socket.gettime()

	for iter_20_0, iter_20_1 in pairs(self.itemData) do
		if iter_20_1.bag_item_type == kITEM_SKIN and iter_20_1.group then
			local var_20_5 = true
			local var_20_6 = self:checkChannelVisible(iter_20_1)

			if not var_20_6 then
				var_20_5 = var_20_6
			end

			if iter_20_1.id == 64101620 then
				var_20_5 = false
			end

			if self.HexieGroup[iter_20_1.group] then
				var_20_5 = false
			end

			if (not hexie_manager:canPreviewSkin(iter_20_1.id) or nil) and false then
				table.insert(var_20_2, (self:getSkinInfo(iter_20_1)))
			end
		end
	end

	local var_20_7 = socket.gettime()

	return var_20_2
end

function CostumeRoomManager:getSkinInfo(arg_21_1)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local var_21_2 = self.modelData
	local var_21_3 = self.majorFactorData
	local var_21_4 = self:getShopClothesData_uniqueItem()
	local var_21_6 = tostring
	local var_21_7 = arg_21_1
	local var_21_8 = {
		itemId = arg_21_1.id,
		group = arg_21_1.group
	}

	var_21_8.groupName = arg_21_1.logo_str or ""
	var_21_8.name = var_21_7.name or "error"
	var_21_8.labelStr = var_21_7.label
	var_21_8.bLive2d = nil
	var_21_8.bRoleSpine = nil
	var_21_8.sort = var_21_7.sort
	var_21_8.haveNum = 0
	var_21_8.uncolorClothes = var_21_7.uncolor_clothes
	var_21_8.uncolorClothesHaveNum = 0
	var_21_8.priceTable = self:getPriceTable(var_21_7.id)

	if next(var_21_8.priceTable) then
		var_21_8.limitTimeStr = var_21_8.priceTable[1].limitTimeStr
	end

	if var_21_4[var_21_7.id] then
		var_21_8.shopType = var_21_4[var_21_7.id].shop_type
		var_21_8.shopId = var_21_4[var_21_7.id].id
	else
		var_21_8.targetlayer1 = var_21_7.targetlayer1
		var_21_8.targetactivity1 = var_21_7.targetactivity1
		var_21_8.targetdes1 = var_21_7.targetdes1 or ""
		var_21_8.targetlayer_starttime_1 = var_21_7.targetlayer_starttime_1
		var_21_8.targetlayer_finishtime_1 = var_21_7.targetlayer_finishtime_1
	end

	var_21_8.bgPath = nil

	if var_21_7.bg then
		if var_21_7.bg == "bg1" then
			var_21_8.bgPath = "mainScenebg/costume_room_show_Layer_bg1.png"
		elseif var_21_7.bg == "bg2" then
			var_21_8.bgPath = "mainScenebg/costume_room_show_Layer_bg2.png"
		elseif var_21_7.bg == "bg3" then
			var_21_8.bgPath = "mainScenebg/costume_room_show_Layer_bg3.png"
		end
	end

	local var_21_9 = var_21_7.model

	if var_21_7.model and var_21_2[var_21_9] then
		if var_21_2[var_21_9].role_image then
			var_21_8.iconPath = "roleimage/role/shop_image/" .. var_21_2[var_21_9].role_image .. ".png"
			var_21_8.modelId = var_21_9
		end

		if var_21_2[var_21_9].live2d and not var_21_2[var_21_9].origin then
			var_21_8.bLive2d = var_21_2[var_21_9].live2d
		end

		if var_21_2[var_21_9].rolespine then
			var_21_8.bRoleSpine = var_21_2[var_21_9].rolespine
		end

		if var_21_8.uncolorClothes and var_21_2[var_21_6(var_21_8.uncolorClothes)] and var_21_2[var_21_6(var_21_8.uncolorClothes)].itemid then
			var_21_8.uncolorClothes_ItemId = var_21_2[var_21_6(var_21_8.uncolorClothes)].itemid
			var_21_8.uncolorClothesHaveNum = item_manager:getItemNumber(var_21_8.uncolorClothes_ItemId)
		end

		if var_21_2[var_21_9].spine_model then
			var_21_8.spineModel = var_21_2[var_21_9].spine_model
		end

		if var_21_2[var_21_9].clothes_model then
			var_21_8.clothesModel = var_21_2[var_21_9].clothes_model
		end

		var_21_8.spineScale = 1

		if var_21_2[var_21_9].modelscale then
			var_21_8.spineScale = var_21_2[var_21_9].modelscale
		end
	end

	if var_21_7.id then
		var_21_8.haveNum = item_manager:getItemNumber(var_21_7.id)
	end

	var_21_8.buyLimitNum = 1
	var_21_8.haveBoughtNum = var_21_8.haveNum
	var_21_8.bHaveMajor = false

	if var_21_7.major and playermodel.haveSuit[var_21_7.major] then
		var_21_8.bHaveMajor = true
	end

	if var_21_3[var_21_7.major] then
		var_21_8.roleName = var_21_3[var_21_7.major].name
		var_21_8.roleEasyName = var_21_3[var_21_7.major].easy_name
	end

	if var_21_3[var_21_7.major] and var_21_3[var_21_7.major].model then
		local var_21_10 = var_21_6(var_21_3[var_21_7.major].model)

		var_21_8.fightModelId = self.servantData[var_21_3[var_21_7.major].servant].modelid
		var_21_8.fightModelInfo = {
			name = self.servantData[var_21_3[var_21_7.major].servant].name,
			servant = var_21_3[var_21_7.major].servant
		}

		if var_21_2[var_21_10] and var_21_2[var_21_10].photofile_model then
			if self.favorfileData[3][var_21_2[var_21_10].photofile_model] then
				var_21_8.cvName = "声优：" .. self.favorfileData[3][var_21_2[var_21_10].photofile_model]
			else
				print("no cv：" .. var_21_2[var_21_10].photofile_model .. "  itemId: " .. var_21_7.id)
			end
		end
	end

	return var_21_8
end

function CostumeRoomManager:getParamByItemId(arg_22_1)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")

	return (arg_22_1 and self.itemData[arg_22_1] or nil) and self:getSkinInfo(self.itemData[arg_22_1])
end

function CostumeRoomManager:getFilterShowSkin()
	local item_manager = require("controller.item_manager")
	local var_23_1 = require("controller.GlobalConstantsManager"):getInstance()
	local var_23_2 = self:getAllShowSkin()
	local var_23_3 = self:getTypeFilter()
	local var_23_4 = {}
	local var_23_5 = {}
	local var_23_6 = {}

	for iter_23_0 = 1, #var_23_3 do
		if self.filterData[self.FilterRule[self.CustomSkinTypeStr .. var_23_3[iter_23_0].group]] == self.FilterState.On then
			var_23_6[var_23_3[iter_23_0].group] = 1
		end
	end

	for iter_23_1 = 1, #var_23_2 do
		local var_23_7 = not (self.filterData[self.FilterRule.Live2D] == self.FilterState.On and not var_23_2[iter_23_1].bLive2d and not var_23_2[iter_23_1].bRoleSpine)

		if self.filterData[self.FilterRule.UncolorClothes] == self.FilterState.On and not var_23_2[iter_23_1].uncolorClothes then
			var_23_7 = false
		end

		if self.filterData[self.FilterRule.MemberState] == self.MemberState.Have and not var_23_2[iter_23_1].bHaveMajor then
			var_23_7 = false
		end

		if self.filterData[self.FilterRule.MemberState] == self.MemberState.Not_Have and var_23_2[iter_23_1].bHaveMajor then
			var_23_7 = false
		end

		if self.filterData[self.FilterRule.SkinState] == self.SkinState.Have and var_23_2[iter_23_1].haveNum < 1 and var_23_2[iter_23_1].uncolorClothesHaveNum < 1 then
			var_23_7 = false
		end

		if self.filterData[self.FilterRule.SkinState] == self.SkinState.Not_Have and var_23_2[iter_23_1].haveNum >= 1 then
			var_23_7 = false
		end

		if (next(var_23_6) and not var_23_6[var_23_2[iter_23_1].group] or nil) and false then
			var_23_4[var_23_2[iter_23_1].group] = var_23_4[var_23_2[iter_23_1].group] or {}

			table.insert(var_23_4[var_23_2[iter_23_1].group], var_23_2[iter_23_1])

			var_23_5[var_23_2[iter_23_1].group] = var_23_2[iter_23_1].group
		end
	end

	local var_23_8

	if self:checkExtendGroupIsInTime() then
		var_23_8 = var_23_1:getValueById(3)

		if var_23_8 then
			var_23_8 = string.split(var_23_8, "#")

			if #var_23_8 > 3 then
				local var_23_9 = var_0_1(var_23_8[2])

				for iter_23_2 = 4, #var_23_8 do
					local var_23_11 = var_0_1(var_23_8[iter_23_2])

					if self.itemData[var_23_11] then
						local var_23_12 = self:getSkinInfo(self.itemData[var_23_11])
						local var_23_13 = not (self.filterData[self.FilterRule.Live2D] == self.FilterState.On and not var_23_12.bLive2d and not var_23_12.bRoleSpine)

						if self.filterData[self.FilterRule.UncolorClothes] == self.FilterState.On and not var_23_2[iter_23_2].uncolorClothes then
							var_23_13 = false
						end

						if self.filterData[self.FilterRule.MemberState] == self.MemberState.Have and not var_23_12.bHaveMajor then
							var_23_13 = false
						end

						if self.filterData[self.FilterRule.MemberState] == self.MemberState.Not_Have and var_23_12.bHaveMajor then
							var_23_13 = false
						end

						if self.filterData[self.FilterRule.SkinState] == self.SkinState.Have and var_23_2[iter_23_2].haveNum < 1 and var_23_2[iter_23_2].uncolorClothesHaveNum < 1 then
							var_23_13 = false
						end

						if self.filterData[self.FilterRule.SkinState] == self.SkinState.Not_Have and var_23_2[iter_23_2].haveNum >= 1 then
							var_23_13 = false
						end

						if next(var_23_6) and not var_23_6[var_23_9] then
							var_23_13 = false
						end

						local var_23_14 = self:checkChannelVisible(self.itemData[var_23_11])

						if (not var_23_14 or nil) and var_23_14 then
							var_23_4[var_23_9] = var_23_4[var_23_9] or {}
							var_23_4[var_23_9].specialHeader = self.SpecialHeader[1]

							table.insert(var_23_4[var_23_9], var_23_12)

							var_23_5[var_23_9] = var_23_9
						end
					end
				end
			end
		end
	end

	local var_23_15 = {}

	for iter_23_3, iter_23_4 in pairs(var_23_5) do
		table.insert(var_23_15, iter_23_4)
	end

	local var_23_16 = string.split(var_23_1:getValueById(1), "#")

	table.sort(var_23_15, function(arg_24_0, arg_24_1)
		local var_24_0 = var_0_1(var_23_16[arg_24_0]) or arg_24_0
		local var_24_1 = var_0_1(var_23_16[arg_24_1]) or arg_24_1

		return ((var_23_8 and #var_23_8 > 3 and arg_24_0 == var_0_1(var_23_8[2]) or nil) and var_0_1(var_23_8[3])) < ((var_23_8 and #var_23_8 > 3 and arg_24_1 == var_0_1(var_23_8[2]) or nil) and var_0_1(var_23_8[3]))
	end)

	local var_23_17 = {}

	for iter_23_5 = 1, #var_23_15 do
		var_23_17[iter_23_5] = var_23_4[var_23_15[iter_23_5]]

		if var_23_8 and #var_23_8 > 3 and var_0_1(var_23_8[2]) == var_23_15[iter_23_5] then
			-- block empty
		else
			local var_23_18 = {
				function(arg_25_0, arg_25_1)
					if arg_25_0.bLive2d and not arg_25_1.bLive2d then
						return 2 > 1
					elseif not arg_25_0.bLive2d and arg_25_1.bLive2d then
						return 1 > 2
					else
						return "=="
					end
				end,
				function(arg_26_0, arg_26_1)
					if arg_26_0.bRoleSpine and not arg_26_1.bRoleSpine then
						return 2 > 1
					elseif not arg_26_0.bRoleSpine and arg_26_1.bRoleSpine then
						return 1 > 2
					else
						return "=="
					end
				end,
				function(arg_27_0, arg_27_1)
					local var_27_0 = arg_27_0.sort
					local var_27_1 = arg_27_1.sort

					if arg_27_0.sort and var_27_1 then
						return var_27_0 < var_27_1
					elseif var_27_0 and not var_27_1 then
						var_27_1 = var_27_0 + 1

						return var_27_0 < var_27_0 + 1
					elseif not var_27_0 and var_27_1 then
						var_27_0 = var_27_1 + 1

						return var_27_1 + 1 < var_27_1
					elseif not var_27_0 and not var_27_1 then
						return false
					end
				end
			}

			table.sort(var_23_17[iter_23_5], function(arg_28_0, arg_28_1)
				for iter_28_0 = 1, #var_23_18 do
					if var_23_18[iter_28_0](arg_28_0, arg_28_1) ~= "==" then
						return var_23_18[iter_28_0](arg_28_0, arg_28_1)
					end
				end

				return false
			end)
		end
	end

	return var_23_17
end

function CostumeRoomManager:getAdaptiveFilterShowSkin()
	local var_29_0 = self:getFilterShowSkin()
	local var_29_1 = {}

	for iter_29_0 = 1, #var_29_0 do
		local var_29_2 = 0

		for iter_29_1 = 1, #var_29_0[iter_29_0] do
			if (var_29_0[iter_29_0][iter_29_1].haveNum or 0) > 0 then
				var_29_2 = var_29_2 + 1
			end
		end

		local var_29_4 = {
			bTitle = true,
			titleName = var_29_0[iter_29_0][1].groupName,
			haveSkinNum = var_29_2,
			allSkinNum = #var_29_0[iter_29_0]
		}

		if var_29_0[iter_29_0].specialHeader then
			var_29_4.specialHeader = var_29_0[iter_29_0].specialHeader
		end

		table.insert(var_29_1, var_29_4)

		for iter_29_2 = 1, math.ceil(#var_29_0[iter_29_0] / 4) do
			local var_29_5 = {}

			for iter_29_3 = 1, 4 do
				if var_29_0[iter_29_0][iter_29_3 + (iter_29_2 - 1) * 4] then
					table.insert(var_29_5, var_29_0[iter_29_0][iter_29_3 + (iter_29_2 - 1) * 4])
				else
					break
				end
			end

			table.insert(var_29_1, var_29_5)
		end
	end

	return var_29_1
end

function CostumeRoomManager:checkExtendGroupIsInTime()
	local var_30_0 = false
	local var_30_1 = require("controller.GlobalConstantsManager"):getInstance():getConfigById(3)

	if not var_30_1 then
		return false
	end

	local var_30_2 = var_30_1.starttime
	local var_30_3 = require("controller.time_check_manager"):getCurTime()

	if var_30_1.starttime then
		if var_30_1.finishtime then
			if var_30_3 >= var_0_2(var_30_2) and var_30_3 < var_0_2(var_30_1.finishtime) then
				var_30_0 = true
			end
		elseif var_30_3 >= var_0_2(var_30_2) then
			var_30_0 = true
		end
	else
		var_30_0 = true
	end

	return var_30_0
end

function CostumeRoomManager:checkChannelVisible(arg_31_1)
	local var_31_0 = require("controller.device_manager").getChannelID()
	local var_31_1 = true

	if arg_31_1.major and self.majorFactorData[arg_31_1.major] then
		local var_31_2 = 1
		local var_31_3 = string.format("item%d", 1)

		while self.majorFactorData[arg_31_1.major][var_31_3] and var_31_2 < 100 do
			if self.majorFactorData[arg_31_1.major][var_31_3] == arg_31_1.id then
				local var_31_4 = string.format("show%d_channel", var_31_2)
				local var_31_5 = string.format("hide%d_channel", var_31_2)

				if self.majorFactorData[arg_31_1.major][string.format("item%d_hide", var_31_2)] then
					var_31_1 = false

					break
				end

				if self.majorFactorData[arg_31_1.major][var_31_4] then
					local var_31_6 = string.split(self.majorFactorData[arg_31_1.major][var_31_4], ",")
					local var_31_7 = false

					for iter_31_0 = 1, #var_31_6 do
						if var_31_0 == var_31_6[iter_31_0] then
							var_31_7 = true

							break
						end
					end

					if not var_31_7 then
						var_31_1 = false
					end

					break
				end

				if self.majorFactorData[arg_31_1.major]["hide%d_channel"] then
					local var_31_8 = string.split(self.majorFactorData[arg_31_1.major][var_31_5], ",")
					local var_31_9 = false

					for iter_31_1 = 1, #var_31_8 do
						if var_31_0 == var_31_8[iter_31_1] then
							var_31_9 = true

							break
						end
					end

					if var_31_9 then
						var_31_1 = false
					end
				end

				break
			end

			var_31_2 = var_31_2 + 1
			var_31_3 = string.format("item%d", var_31_2)
		end
	end

	return var_31_1
end

function CostumeRoomManager:requestInfo(arg_32_1)
	return
end

function CostumeRoomManager:handlerInfo(arg_33_1)
	return
end

function CostumeRoomManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function CostumeRoomManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return CostumeRoomManager
