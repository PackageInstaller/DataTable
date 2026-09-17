FastStrengthConfirmLayer = class("FastStrengthConfirmLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "FastStrengthConfirmLayer/"
local servant_data = require("data.servant_data")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local component_effect_data = require("data.component_effect_data")
local TableViewEx = require("view.Sprite.TableViewEx")

require("view.Sprite.ItemSprite")

function FastStrengthConfirmLayer:ctor()
	FastStrengthConfirmLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.fast_strength_confirm_manager"):getInstance():getInstance()
end

function FastStrengthConfirmLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = FastStrengthConfirmLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function FastStrengthConfirmLayer:onEnter()
	FastStrengthConfirmLayer.super.onEnter(self)
	self.bg:setScaleY(0.01)
	self.bg:show()
	self.bg:runAction(cc.ScaleTo:create(0.2, 1))
end

function FastStrengthConfirmLayer.onExit(arg_4_0)
	FastStrengthConfirmLayer.super.onExit(arg_4_0)
end

function FastStrengthConfirmLayer:init(arg_5_1)
	self:initData(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function FastStrengthConfirmLayer:initData(arg_6_1)
	local var_6_0 = arg_6_1.servantid

	self.servantid = arg_6_1.servantid
	self.callBack = arg_6_1.callBack
	arg_6_1 = arg_6_1.costData
	self.costData = arg_6_1

	local core_manager = require("controller.core_manager")
	local var_6_2 = {
		curWeaponLv = 0,
		costGold = 0,
		lastWeaponLv = 0,
		curBreakOutLv = core_manager:getServantCoreRank(var_6_0),
		lastBreakOutLv = core_manager:getServantCoreRank(var_6_0),
		bActivateWeapon = require("controller.weapon_manager"):isActiveWeaponByServantid(var_6_0),
		curCoreLv = core_manager:getCoreLv(var_6_0),
		lastCoreLv = core_manager:getCoreLv(var_6_0),
		maxCoreLv = core_manager:getCoreMaxLevelByGrade(),
		componentInfo = {}
	}

	var_6_2.costStrengthpoint = arg_6_1.costStrengthpoint or 0
	var_6_2.costMeterial = {}
	self._data = var_6_2

	if arg_6_1.curBreakOutRank then
		self._data.curBreakOutLv = arg_6_1.curBreakOutRank
	end

	if arg_6_1.lastBreakOutRank then
		self._data.lastBreakOutLv = arg_6_1.lastBreakOutRank
	end

	if arg_6_1.curWeaponLv then
		self._data.curWeaponLv = arg_6_1.curWeaponLv
	end

	if arg_6_1.lastWeaponLv then
		self._data.lastWeaponLv = arg_6_1.lastWeaponLv
	end

	if arg_6_1.curCoreLv then
		self._data.curCoreLv = arg_6_1.curCoreLv
	end

	if arg_6_1.lastCoreLv then
		self._data.lastCoreLv = arg_6_1.lastCoreLv
	end

	if arg_6_1.weaponItemid then
		self._data.weaponItemid = arg_6_1.weaponItemid
	end

	if arg_6_1.componentInfo and arg_6_1.componentInfo.posInfo then
		for iter_6_0, iter_6_1 in pairs(arg_6_1.componentInfo.posInfo) do
			self._data.componentInfo[iter_6_1.pos] = iter_6_1
			self._data.costGold = self._data.costGold + iter_6_1.costGold

			if iter_6_1.selectComponentList then
				for iter_6_2 = 1, #iter_6_1.selectComponentList do
					self._data.costMeterial[iter_6_1.selectComponentList[iter_6_2]] = self._data.costMeterial[iter_6_1.selectComponentList[iter_6_2]] or {
						count = 0,
						type = "entityid"
					}
					self._data.costMeterial[iter_6_1.selectComponentList[iter_6_2]].count = self._data.costMeterial[iter_6_1.selectComponentList[iter_6_2]].count + 1
				end
			end
		end
	end

	if arg_6_1.breakOutCost then
		self._data.costGold = self._data.costGold + arg_6_1.breakOutCost.costGold

		if arg_6_1.breakOutCost.material then
			for iter_6_3, iter_6_4 in pairs(arg_6_1.breakOutCost.material) do
				self._data.costMeterial[iter_6_3] = self._data.costMeterial[iter_6_3] or {
					count = 0,
					type = "itemid"
				}
				self._data.costMeterial[iter_6_3].count = self._data.costMeterial[iter_6_3].count + iter_6_4.num
			end
		end
	end

	if arg_6_1.weaponCost then
		self._data.costGold = self._data.costGold + arg_6_1.weaponCost.costGold

		if arg_6_1.weaponCost.material then
			for iter_6_5, iter_6_6 in pairs(arg_6_1.weaponCost.material) do
				self._data.costMeterial[iter_6_5] = self._data.costMeterial[iter_6_5] or {
					count = 0,
					type = "itemid"
				}
				self._data.costMeterial[iter_6_5].count = self._data.costMeterial[iter_6_5].count + iter_6_6.num
			end
		end
	end

	self._data.costMeterial = {}

	for iter_6_7, iter_6_8 in pairs((clone(self._data.costMeterial))) do
		self._data.costMeterial[#self._data.costMeterial + 1] = iter_6_8
		self._data.costMeterial[#self._data.costMeterial + 1].id = iter_6_7
	end

	local var_6_3 = {
		type = "gold",
		count = self._data.costGold
	}

	if var_6_3.count > 0 then
		table.insert(self._data.costMeterial, 1, var_6_3)
	end

	local var_6_4 = {
		type = "strengthpoint",
		count = self._data.costStrengthpoint
	}

	if var_6_4.count > 0 then
		table.insert(self._data.costMeterial, 1, var_6_4)
	end
end

function FastStrengthConfirmLayer:initLayer()
	local var_7_0 = TempWidget:CreateTempLayout(self)

	var_7_0:_setBack()
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(100)
	var_7_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_7_0

	local var_7_1 = TempWidget:CreateTempImg("public/talk/new_yourenkuang.png", var_7_0)

	var_7_1:_addEvent(function()
		return
	end)
	var_7_1:setScale9Enabled(true)
	var_7_1:setCapInsets(cc.rect(0, 0, var_7_1:size().w, var_7_1:size().h))
	var_7_1:setContentSize(cc.size(var_7_0:size().w - 140, 500))
	var_7_1:center()
	var_7_1:hide()

	self.bg = var_7_1

	local var_7_2 = TempWidget:CreateTempBtn(var_0_2 .. "ok_btn.png", var_7_1)

	var_7_2:setName("sureBtn")
	var_7_2:align(cc.p(0.5, 1), var_7_1:size().width / 2 - 140, 0)

	self.okBtn = var_7_2

	local var_7_3 = TempWidget:CreateTempLabel("确认强化", FONT_NAME, 30, var_7_2:getVirtualRenderer())

	var_7_3:_setColor("002200")
	var_7_3:center()

	local var_7_4 = TempWidget:CreateTempBtn(var_0_2 .. "cancel_btn.png", var_7_1)

	var_7_4:align(cc.p(0.5, 1), var_7_1:size().width / 2 + 140, 0)

	self.cancelBtn = var_7_4

	local var_7_5 = TempWidget:CreateTempLabel("取消", FONT_NAME, 30, var_7_4:getVirtualRenderer())

	var_7_5:_setColor("002200")
	var_7_5:center()
	TempWidget:CreateTempImg("public/title/strength_confirm.png", var_7_1):align(cc.p(0, 0), -5, var_7_1:size().h - 5)

	local var_7_6 = TempWidget:CreateTempImg(var_0_2 .. "name_left_img.png", var_7_1)

	var_7_6:align(cc.p(0, 0.5), 20, var_7_1:size().h - 30)
	TempWidget:CreateTempLabel(self:getEasyName(), FONT_NAME, 25, var_7_1):align(cc.p(0, 0.5), var_7_6:pos().x + var_7_6:size().w + 5, var_7_6:pos().y)

	local var_7_7 = TempWidget:CreateTempImg(var_0_2 .. "head_bg.png", var_7_1)

	var_7_7:align(cc.p(0, 0.5), var_7_6:pos().x + 10, var_7_6:pos().y - 100)

	local var_7_8 = TempWidget:CreateTempImg("roleimage/role/wuji/" .. model_data[servant_data[self.servantid].modelid].head_image .. ".png", var_7_7, 0)

	var_7_8:setScale(0.65)
	var_7_8:center()

	local var_7_9 = TempWidget:CreateTempLabel("学员等级", FONT_NAME, 20, var_7_1)

	var_7_9:_setColor("a9a9b2")
	var_7_9:align(cc.p(0.5, 0.5), var_7_1:size().w / 2 + 80, var_7_7:pos().y + 60)

	local var_7_10 = TempWidget:CreateTempLabel(self._data.curCoreLv, FONT_NAME, 30, var_7_1)

	var_7_10:align(cc.p(0, 0), var_7_9:pos().x - 130, var_7_9:pos().y - 50)

	local var_7_11 = TempWidget:CreateTempLabel("/" .. self._data.maxCoreLv, FONT_NAME, 15, var_7_1)

	var_7_11:_setColor("a9a9b2")
	var_7_11:align(cc.p(0, 0), var_7_10:pos().x + var_7_10:size().w, var_7_10:pos().y + 2)
	TempWidget:CreateTempImg(var_0_2 .. "to.png", var_7_1):align(cc.p(0.5, 0.5), var_7_9:pos().x, var_7_10:pos().y + var_7_10:size().h / 2)

	local var_7_12 = TempWidget:CreateTempLabel(self._data.lastCoreLv, FONT_NAME, 30, var_7_1)

	var_7_12:_setColor("ffcc00")
	var_7_12:align(cc.p(0, 0), var_7_9:pos().x + 40, var_7_10:pos().y)

	local var_7_13 = TempWidget:CreateTempLabel("/" .. self._data.maxCoreLv, FONT_NAME, 15, var_7_1)

	var_7_13:_setColor("a9a9b2")
	var_7_13:align(cc.p(0, 0), var_7_12:pos().x + var_7_12:size().w, var_7_12:pos().y + 2)

	local var_7_14 = TempWidget:CreateTempLabel("学员突破", FONT_NAME, 20, var_7_1)

	var_7_14:_setColor("a9a9b2")
	var_7_14:align(cc.p(0.5, 0.5), var_7_9:pos().x, var_7_9:pos().y - 70)

	local var_7_15 = TempWidget:CreateTempImg(string.format("public/rolebg/breakout_%d.png", self._data.curBreakOutLv), var_7_1)

	var_7_15:align(cc.p(0.5, 0.5), var_7_14:pos().x - 85, var_7_14:pos().y - 40)
	TempWidget:CreateTempImg(var_0_2 .. "to.png", var_7_1):align(cc.p(0.5, 0.5), var_7_9:pos().x, var_7_15:pos().y)

	local var_7_16 = TempWidget:CreateTempImg(string.format("public/rolebg/breakout_%d.png", self._data.lastBreakOutLv), var_7_1)

	var_7_16:align(cc.p(0.5, 0.5), var_7_14:pos().x + 85, var_7_15:pos().y)

	self.lastBreakOutImg = var_7_16

	self:initWeaponAndComponentLayout()
	self:initCostLayout()
end

function FastStrengthConfirmLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.okBtn:_addEvent(function()
		print("确定")
		require("controller.core_manager"):requestFastStrengthen(self.servantid, function(arg_12_0, arg_12_1)
			if self.callBack then
				self.callBack(arg_12_0, arg_12_1)
			end

			if arg_12_0 == 1 then
				LayerManager:removePopLayer()
			end
		end, false, self.costData)
	end)
	self.cancelBtn:_addEvent(function()
		LayerManager:removePopLayer()
	end)
end

function FastStrengthConfirmLayer:getEasyName()
	return major_factor_data[servant_data[self.servantid].major].easy_name or ""
end

function FastStrengthConfirmLayer:initWeaponAndComponentLayout()
	local var_15_0 = TempWidget:CreateTempLayout(self.bg)

	var_15_0:setContentSize(cc.size(self.bg:size().w - 0, 140))
	var_15_0:align(cc.p(0.5, 1), self.bg:size().w / 2, self.lastBreakOutImg:pos().y - self.lastBreakOutImg:size().h / 2 - 5)

	self.weaponAndComponentLayout = var_15_0

	local var_15_1 = {
		cc.p(0, var_15_0:size().h / 2),
		cc.p(var_15_0:size().w / 2, var_15_0:size().h / 2),
		cc.p(0, 0),
		cc.p(var_15_0:size().w / 2, 0)
	}

	for iter_15_0 = 1, 4 do
		local var_15_2 = self:createWeaponOrComponentLayout(iter_15_0)

		var_15_2:move(var_15_1[iter_15_0])
		var_15_0:addChild(var_15_2)
	end

	return var_15_0
end

function FastStrengthConfirmLayer:createWeaponOrComponentLayout(arg_16_1)
	local var_16_0 = require("controller.fast_soulstrength_setting_manager"):getInstance()
	local playermodel = require("model.playermodel")
	local var_16_2 = TempWidget:CreateTempLayout()

	var_16_2:setContentSize(cc.size(self.weaponAndComponentLayout:size().w / 2, self.weaponAndComponentLayout:size().h / 2))

	local var_16_3 = TempWidget:CreateTempImg(var_0_2 .. "layout_bg.png", var_16_2)

	var_16_3:center()

	local function var_16_4(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = TempWidget:CreateTempLabel(arg_17_0, FONT_NAME, 20, var_16_3)

		var_17_0:_setColor("a9a9b2")
		var_17_0:align(cc.p(1, 1), var_16_3:size().w - 10, var_16_3:size().h - 10)

		local var_17_1 = TempWidget:CreateTempLabel(arg_17_1, FONT_NAME, 20, var_16_3)

		var_17_1:align(cc.p(0, 0.5), var_16_3:size().w - 90, 20)
		TempWidget:CreateTempImg(var_0_2 .. "to.png", var_16_3):align(cc.p(0.5, 0.5), var_16_3:size().w - 50, var_17_1:pos().y)

		local var_17_2 = TempWidget:CreateTempLabel(arg_17_2, FONT_NAME, 20, var_16_3)

		var_17_2:_setColor("ffcc00")
		var_17_2:align(cc.p(1, 0.5), var_16_3:size().w - 10, var_17_1:pos().y)
	end

	if arg_16_1 == 1 then
		if self._data.bActivateWeapon then
			if var_16_0:getConfigure(var_16_0.Setting_Type.Weapon) then
				local var_16_5 = TempWidget:CreateTempImg("weaponIcon/" .. item_data[self._data.weaponItemid].image_id .. ".png", var_16_3, 0)

				var_16_5:align(cc.p(0, 0.5), -10, var_16_3:size().h / 2)
				var_16_5:setScale(0.2)
				var_16_4("魂武等级", self._data.curWeaponLv, self._data.lastWeaponLv)
			else
				local var_16_6 = playermodel.items[playermodel.weaponId[self.servantid]]

				if playermodel.items[playermodel.weaponId[self.servantid]] then
					local var_16_7 = TempWidget:CreateTempImg("weaponIcon/" .. item_data[var_16_6.itemid].image_id .. ".png", var_16_3, 0)

					var_16_7:align(cc.p(0, 0.5), -10, var_16_3:size().h / 2)
					var_16_7:setScale(0.2)
					var_16_4("魂武等级", var_16_6.weapon_attr.level, var_16_6.weapon_attr.level)
				end
			end
		else
			TempWidget:CreateTempLabel("未激活魂武", FONT_NAME, 20, var_16_3):center()
		end
	else
		local var_16_8 = arg_16_1 - 1
		local var_16_9 = self._data.componentInfo[arg_16_1 - 1]

		if self._data.componentInfo[arg_16_1 - 1] then
			local var_16_10 = item_data[playermodel.items[var_16_9.entityid].itemid].main_attr and TempWidget:CreateTempImg("equipment/component/shine_component/component" .. component_effect_data[playermodel.items[var_16_9.entityid].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[var_16_9.entityid].itemid].main_attr .. "_" .. var_16_8 .. ".png", var_16_3, 0) or TempWidget:CreateTempImg("equipment/component/shine_component/component" .. component_effect_data[playermodel.items[var_16_9.entityid].component_attr.effect].image_id .. "_" .. playermodel.items[var_16_9.entityid].component_attr.attr1 .. "_" .. var_16_8 .. ".png", var_16_3, 0)
			local var_16_11 = -5
			local var_16_12 = var_16_3:size().h / 2
			local var_16_13 = ""

			if var_16_8 == 1 then
				var_16_12 = var_16_3:size().h / 2 - 25
				var_16_13 = "上"
			elseif var_16_8 == 2 then
				var_16_13 = "中"
			elseif var_16_8 == 3 then
				var_16_12 = var_16_3:size().h / 2 + 25
				var_16_13 = "下"
			end

			var_16_10:align(cc.p(0, 0.5), var_16_11, var_16_12)
			var_16_4("芯片·" .. var_16_13, var_16_9.curLv, var_16_9.lastLv)
		else
			local var_16_14 = {}

			if playermodel.component[self.servantid] then
				for iter_16_0, iter_16_1 in pairs(playermodel.component[self.servantid]) do
					var_16_14[iter_16_1.pos] = var_16_14[iter_16_1.pos] or {
						id = iter_16_1.id,
						curLv = playermodel.items[iter_16_1.id].component_attr.extra,
						pos = iter_16_1.pos
					}
				end
			end

			if var_16_14[var_16_8] then
				local var_16_15 = item_data[playermodel.items[var_16_14[var_16_8].id].itemid].main_attr and TempWidget:CreateTempImg("equipment/component/shine_component/component" .. component_effect_data[playermodel.items[var_16_14[var_16_8].id].component_attr.effect].image_id .. "_" .. item_data[playermodel.items[var_16_14[var_16_8].id].itemid].main_attr .. "_" .. var_16_8 .. ".png", var_16_3, 0) or TempWidget:CreateTempImg("equipment/component/shine_component/component" .. component_effect_data[playermodel.items[var_16_14[var_16_8].id].component_attr.effect].image_id .. "_" .. playermodel.items[var_16_14[var_16_8].id].component_attr.attr1 .. "_" .. var_16_8 .. ".png", var_16_3, 0)
				local var_16_16 = -5
				local var_16_17 = var_16_3:size().h / 2
				local var_16_18 = ""

				if var_16_8 == 1 then
					var_16_17 = var_16_3:size().h / 2 - 25
					var_16_18 = "上"
				elseif var_16_8 == 2 then
					var_16_18 = "中"
				elseif var_16_8 == 3 then
					var_16_17 = var_16_3:size().h / 2 + 25
					var_16_18 = "下"
				end

				var_16_15:align(cc.p(0, 0.5), var_16_16, var_16_17)
				var_16_4("芯片·" .. var_16_18, var_16_14[var_16_8].curLv, var_16_14[var_16_8].curLv)
			else
				TempWidget:CreateTempLabel("未装备芯片", FONT_NAME, 20, var_16_3):center()
			end
		end
	end

	return var_16_2
end

function FastStrengthConfirmLayer:initCostLayout()
	local var_18_0 = TempWidget:CreateTempLayout(self.bg)

	var_18_0:setContentSize(cc.size(self.bg:size().w - 20, 120))
	var_18_0:align(cc.p(0.5, 0), self.bg:size().w / 2, 10)

	self.costLayout = var_18_0

	local var_18_1 = TempWidget:CreateTempImg(var_0_2 .. "img.png", var_18_0)

	var_18_1:align(cc.p(0, 0.5), 0, var_18_0:size().h / 2)

	local var_18_3 = TableViewEx:create({
		size = cc.size(var_18_0:size().w - var_18_1:size().w - 20, var_18_0:size().h),
		cellSizeForTable = function()
			return 95, var_18_0:size().h
		end,
		tableCellAtIndex = function(self, arg_20_1)
			local var_20_0 = self:dequeueCell()

			if not var_20_0 then
				var_20_0 = cc.TableViewCell:new()
			else
				var_20_0:removeAllChildren()
			end

			var_20_0:addChild((self:createCell(arg_20_1 + 1)))

			return var_20_0
		end,
		numberOfCellsInTableView = function(arg_21_0)
			return #self._data.costMeterial
		end,
		direction = cc.SCROLLVIEW_DIRECTION_HORIZONTAL
	})

	var_18_0:addChild(var_18_3)
	var_18_3:setPositionX(var_18_1:pos().x + var_18_1:size().w + 10)
end

function FastStrengthConfirmLayer:createCell(arg_22_1)
	local var_22_0 = TempWidget:CreateTempLayout()

	var_22_0:setContentSize(cc.size(95, self.costLayout:size().h))

	local var_22_1

	if self._data.costMeterial[arg_22_1].type == "entityid" then
		var_22_1 = ItemSprite:createBigWithEntityId(self._data.costMeterial[arg_22_1].id, 1)
	elseif self._data.costMeterial[arg_22_1].type == "itemid" then
		var_22_1 = ItemSprite:createNewWithItemId(self._data.costMeterial[arg_22_1].id, self._data.costMeterial[arg_22_1].count)
	elseif self._data.costMeterial[arg_22_1].type == "gold" then
		var_22_1 = ItemSprite:createBigWithEntityId("gold", self._data.costMeterial[arg_22_1].count)
	elseif self._data.costMeterial[arg_22_1].type == "strengthpoint" then
		var_22_1 = ItemSprite:createBigWithEntityId("strengthpoint", self._data.costMeterial[arg_22_1].count)
	end

	var_22_1:setScale(0.5)
	var_22_0:addChild(var_22_1)
	var_22_1:setPosition(cc.p(var_22_0:size().w / 2, var_22_0:size().h / 2))

	return var_22_0
end

function FastStrengthConfirmLayer.updateLayer(arg_23_0)
	return
end

function FastStrengthConfirmLayer.updateRed(arg_24_0)
	return
end

return FastStrengthConfirmLayer
