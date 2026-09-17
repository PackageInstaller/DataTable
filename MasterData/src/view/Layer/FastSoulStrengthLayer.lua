FastSoulStrengthLayer = class("FastSoulStrengthLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local core_manager = require("controller.core_manager")
local var_0_3 = require("controller.core_manager")
local model_manager = require("controller.model_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local item_manager = require("controller.item_manager")
local array_manager = require("controller.array_manager")
local armature_manager = require("controller.armature_manager")
local component_manager = require("controller.component_manager")
local weapon_manager = require("controller.weapon_manager")
local var_0_12 = require("controller.fast_soulstrength_setting_manager"):getInstance()
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local core_data = require("data.core_data")
local item_data = require("data.item_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_19 = 1
local var_0_20 = 2
local var_0_21 = 610
local var_0_22 = 120
local var_0_23 = 660
local var_0_24 = 700
local var_0_25 = 650
local var_0_26 = 750
local var_0_27 = ""
local var_0_28

function FastSoulStrengthLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = FastSoulStrengthLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local function var_0_29(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0 then
		return
	end

	local var_3_0 = arg_3_0:getChildByName("alert_reddot")

	if arg_3_1 then
		if not var_3_0 then
			var_3_0 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_3_0:setName("alert_reddot")
			var_3_0:setPosition(arg_3_2)
			arg_3_0:addChild(var_3_0)
		end
	elseif var_3_0 then
		var_3_0:removeFromParent()
	end
end

function FastSoulStrengthLayer:init(arg_5_1)
	var_0_28 = self
	self.levelUpCallback = arg_5_1.levelUpCallback
	self.msg = arg_5_1
	self.resetCallback = arg_5_1.resetCallback
	self.curMode = var_0_19

	;(function()
		local var_6_0 = {}
		local var_6_1 = {}

		for iter_6_0 = FORMATION_SHOW_GIRL_NUM, 1, -1 do
			if playermodel.arrays[playermodel.curArray]["pos_" .. iter_6_0].fight_girl then
				var_6_0[#var_6_0 + 1] = playermodel.arrays[playermodel.curArray]["pos_" .. iter_6_0].fight_girl
				var_6_1[playermodel.arrays[playermodel.curArray]["pos_" .. iter_6_0].fight_girl] = true
			end
		end

		self.soulidList = {}

		for iter_6_1, iter_6_2 in pairs(servant_data) do
			if iter_6_2.classtype == 1 and playermodel.haveServant[iter_6_2.id] and not var_6_1[iter_6_2.id] then
				self.soulidList[#self.soulidList + 1] = iter_6_2.id
			end
		end

		;(function()
			local var_7_1 = {
				{
					weight = 5,
					func = function(arg_8_0, arg_8_1)
						local var_8_0 = core_manager:getCoreLv(arg_8_0)
						local var_8_1 = core_manager:getCoreLv(arg_8_1)

						if var_8_0 == 320 then
							var_8_0 = -1
						end

						if var_8_1 == 320 then
							var_8_1 = -1
						end

						if var_8_0 == var_8_1 then
							return "=="
						else
							return var_8_1 < var_8_0
						end
					end
				},
				{
					weight = 3,
					func = function(arg_9_0, arg_9_1)
						return servant_data[arg_9_0].major > servant_data[arg_9_1].major
					end
				},
				{
					weight = 8,
					func = function(arg_10_0, arg_10_1)
						local var_10_0 = array_manager:getArrayByServantID(arg_10_0) or 100
						local var_10_1 = array_manager:getArrayByServantID(arg_10_1) or 100

						if var_10_0 == var_10_1 then
							return "=="
						end

						return var_10_0 < var_10_1
					end
				},
				{
					weight = 6,
					func = function(arg_11_0, arg_11_1)
						local var_11_0 = servant_data[arg_11_0].roll_rarity == 5 and 4 or servant_data[arg_11_0].roll_rarity or 1
						local var_11_1 = servant_data[arg_11_1].roll_rarity == 5 and 4 or servant_data[arg_11_1].roll_rarity or 1

						if var_11_0 == var_11_1 then
							return "=="
						end

						return var_11_1 < var_11_0
					end
				},
				{
					weight = 9,
					func = function(arg_12_0, arg_12_1)
						local var_12_0 = playermodel.haveServant[arg_12_0] and 1 or 0
						local var_12_1 = playermodel.haveServant[arg_12_1] and 1 or 0

						if (playermodel.haveServant[arg_12_0] and 1 or 0) == (playermodel.haveServant[arg_12_1] and 1 or 0) then
							return "=="
						else
							return var_12_1 < var_12_0
						end
					end
				},
				{
					weight = 0,
					func = function(arg_13_0, arg_13_1)
						local var_13_0 = servant_data[arg_13_0].order
						local var_13_1 = servant_data[arg_13_1].order

						if servant_data[arg_13_0].order == servant_data[arg_13_1].order then
							return "=="
						end

						return var_13_0 < var_13_1
					end
				},
				{
					weight = 0,
					func = function(arg_14_0, arg_14_1)
						local var_14_0 = fight_capacity_manager:getSoulFightCapacity(arg_14_0, "number")
						local var_14_1 = fight_capacity_manager:getSoulFightCapacity(arg_14_1, "number")

						if var_14_0 == var_14_1 then
							return "=="
						end

						return var_14_1 < var_14_0
					end
				},
				{
					weight = 7,
					func = function(arg_15_0, arg_15_1)
						local var_15_0 = array_manager:getServantPos(arg_15_0) or 100
						local var_15_1 = array_manager:getServantPos(arg_15_1) or 100

						if var_15_0 == var_15_1 then
							return "=="
						else
							return var_15_0 < var_15_1
						end
					end
				},
				{
					weight = 0,
					func = function(arg_17_0, arg_17_1)
						local var_17_0 = playermodel.soulOverClock[arg_17_0] > 0 and 6 or playermodel.soulContract[arg_17_0] or 0
						local var_17_1 = playermodel.soulOverClock[arg_17_1] > 0 and 6 or playermodel.soulContract[arg_17_1] or 0

						if var_17_0 == var_17_1 then
							return "=="
						else
							return var_17_1 < var_17_0
						end
					end
				}
			}

			table.sort(var_7_1, function(arg_18_0, arg_18_1)
				return arg_18_0.weight > arg_18_1.weight
			end)
			table.sort(self.soulidList, function(arg_19_0, arg_19_1)
				for iter_19_0 = 1, #var_7_1 do
					if var_7_1[iter_19_0].func(arg_19_0, arg_19_1) ~= "==" then
						return var_7_1[iter_19_0].func(arg_19_0, arg_19_1)
					end
				end
			end)
		end)()

		for iter_6_3, iter_6_4 in pairs(var_6_0) do
			table.insert(self.soulidList, 1, iter_6_4)
		end

		if self.msg.topServants and next(self.msg.topServants) then
			for iter_6_5, iter_6_6 in pairs(self.msg.topServants) do
				while self.soulidList[1] do
					if self.soulidList[1] == iter_6_6 then
						table.remove(self.soulidList, 1)
					end
				end

				table.insert(self.soulidList, iter_6_5, iter_6_6)
			end
		end

		if self.msg.servantid then
			while self.soulidList[1] do
				if self.soulidList[1] == self.msg.servantid then
					table.remove(self.soulidList, 1)

					break
				end
			end

			table.insert(self.soulidList, 1, self.msg.servantid)
		end
	end)()
	LayerManager:createFullScreenMask(self, nil, function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end, ccui.LayoutBackGroundColorType.none)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_soulStreng.json" or "Pop_soulStreng.ExportJson")
	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")
	self.activeFlag = true

	self:addChild(self.rootLayer)
	self.panel:setScaleY(0)
	self.panel:setScaleX(0.9)
	self.panel:runAction(cc.ScaleTo:create(0.2, 0.9, 0.9))
	self.panel:setContentSize(cc.size(self.panel:getContentSize().width, self.panel:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))
	self.panel:setPositionY(GameDisplay.getUiScreenSize().height / 2 - GameDisplay.fix_y)

	local var_5_0 = TempWidget:CreateTempLayout(self.rootLayer)

	var_5_0:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
	var_5_0:align(cc.p(0.5, 1), self.rootLayer:getContentSize().width / 2, self.panel:getPositionY() - self.panel:getAnchorPoint().y * self.panel:getContentSize().height + 60)
	var_5_0:_addEvent(function()
		self:exit()
	end)

	local var_5_1 = TempWidget:CreateTempBtn("SoulStrengthLayer/setting_btn.png", self.panel)

	var_5_1:setName("settingBtn")
	var_5_1:align(cc.p(1, 0.5), self.panel:getContentSize().width - 20, self.panel:getContentSize().height - 55)
	var_5_1:_addEvent(function()
		LayerManager:pushInLayer("FastSoulStrengthSettingLayer")
	end)

	local var_5_2
	local var_5_3 = TempWidget:CreateTempLayout(self.rootLayer)

	var_5_3:setContentSize(cc.size(180, 30))
	var_5_3:setScale(1.3)
	var_5_3:align(cc.p(1, 0), self.rootLayer:getContentSize().width - 30, 0)
	var_5_3:_addEvent(function()
		local var_23_0 = var_0_12:getConfigure(var_0_12.Setting_Type.SecondConfirmation)

		var_0_12:setConfigure(var_0_12.Setting_Type.SecondConfirmation, not var_23_0)
		var_5_2:setVisible(not var_23_0)
	end)

	local var_5_4 = TempWidget:CreateTempImg("SoulStrengthLayer/second_confirm_bg.png", var_5_3)

	var_5_4:align(cc.p(0, 0.5), 10, var_5_3:size().h / 2)

	var_5_2 = TempWidget:CreateTempImg("SoulStrengthLayer/second_confirm_show.png", var_5_4)

	var_5_2:center()
	var_5_2:setVisible(var_0_12:getConfigure(var_0_12.Setting_Type.SecondConfirmation))
	TempWidget:CreateTempLabel("开启二次确认", FONT_NAME, 20, var_5_3):align(cc.p(1, 0.5), var_5_3:size().w - 10, var_5_3:size().h / 2)

	self.sp = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_strength_point")

	local var_5_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_up_money_bottom")

	var_5_5:setPositionX(var_5_5:getPositionX() + var_5_5:getContentSize().width / 2)
	;(function()
		local var_24_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

		for iter_24_0, iter_24_1 in pairs({
			"Button_strengState10",
			"Button_strengState1",
			"Button_strengthMode",
			"Button_holidayMode",
			"Image_up_money_bottom"
		}) do
			local var_24_1 = ccui.Helper:seekWidgetByName(self.rootLayer, iter_24_1)

			var_24_1:setPositionY(var_24_1:getPositionY() + var_24_0)
		end
	end)()

	local var_5_6 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengthMode")
	local var_5_7 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_holidayMode")

	var_5_6:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curMode == var_0_19 then
			return
		end

		var_5_7:getChildByName("Label_sleep"):setColor(cc.c3b(151, 168, 186))
		var_5_6:getChildByName("Label_strength"):setColor(cc.c3b(255, 255, 255))

		self.curMode = var_0_19

		self:updateMode()
	end)
	var_5_7:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curMode == var_0_20 then
			return
		end

		var_5_7:getChildByName("Label_sleep"):setColor(cc.c3b(255, 255, 255))
		var_5_6:getChildByName("Label_strength"):setColor(cc.c3b(151, 168, 186))

		self.curMode = var_0_20

		self:updateMode()

		self.uplevelServant = nil
	end)
	var_5_6:getChildByName("Label_strength"):setColor(cc.c3b(255, 255, 255))
	core_manager:getCoreMaxClass(function()
		if not var_0_28 then
			return
		end

		self:updateStrengPoint()
		self:updateMode()
	end)
end

function FastSoulStrengthLayer:fastStrengthen(arg_28_1, arg_28_2, arg_28_3)
	print("FastSoulStrengthLayer fastStrengthen")

	self.isover = nil
	self.uplevelServant = arg_28_1.soulid

	if self.levelUpCallback then
		self.levelUpCallback()
	end

	audio_manager:playeffectMusicTest("sound/upgrade")

	if arg_28_1.clickCount < 7 then
		arg_28_1.clickCount = arg_28_1.clickCount + 1
	end

	local var_28_1 = fight_capacity_manager:getSoulFightCapacity(arg_28_1.soulid, "number")

	if arg_28_1.fightCapacityValue ~= var_28_1 then
		self:createUpLevelAni(arg_28_1.fightCapacityValue, var_28_1)
	end

	if self.curMode == var_0_19 then
		if not self.listPanel then
			self:updateStrengPanel()
		end

		self:updateShowingCells(self.listPanel)
	end

	local var_28_2 = core_manager:getCoreLv(arg_28_2)

	if self.msg.servantid then
		AnalyticManager.servant_strengthen_by_equiplayer({
			servantid = arg_28_2,
			strengthen_before_level = arg_28_3,
			strengthen_after_level = var_28_2
		})
	else
		AnalyticManager.servant_strengthen({
			servantid = arg_28_2,
			strengthen_before_level = arg_28_3,
			strengthen_after_level = var_28_2
		})
	end
end

function FastSoulStrengthLayer:exit()
	self.activeFlag = false

	self.panel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.9, 0), cc.CallFunc:create(function()
		if self.msg.exitCallback then
			self.msg.exitCallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
		AlertManager:check_servant_strenghth()
	end)))
end

function FastSoulStrengthLayer:updateMode()
	if self.curMode == var_0_19 then
		if not self.listPanel then
			self:updateStrengPanel()
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengthMode"):loadTextures("SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_holidayMode"):loadTextures("SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", var_0_0)
		self:updateShowingCells(self.listPanel)
	end

	if self.curMode == var_0_20 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengthMode"):loadTextures("SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_holidayMode"):loadTextures("SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", var_0_0)

		if not self.holidayListPanel then
			self:updateHoildayPanel()
		end

		self:updateShowingCells(self.holidayListPanel)
	end

	if self.imgTip then
		self.imgTip:setVisible(self.curMode == var_0_20)
	end

	if self.listPanel then
		self.listPanel:setVisible(self.curMode == var_0_19)
	end

	if self.holidayListPanel then
		self.holidayListPanel:setVisible(self.curMode == var_0_20)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState1"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState10"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_up_money_bottom"):setVisible(self.curMode == var_0_19)
end

function FastSoulStrengthLayer:updateStrengPoint()
	self.sp:setString(global_trans_number(playermodel.strengthpoint))

	if playermodel.strengthpoint < 0 then
		self.sp:setString("0")
	end
end

function FastSoulStrengthLayer:updateStrengPanel()
	local core_manager = require("controller.core_manager")
	local var_33_1 = {
		function(arg_34_0, arg_34_1)
			local var_34_0, var_34_1, var_34_2 = core_manager:StrengthenJudge(arg_34_1, arg_34_0)

			return var_34_1
		end,
		function(arg_35_0, arg_35_1)
			return global_trans_number((var_0_3:getBreakOutCostGold(arg_35_1, core_data[playermodel.cores[arg_35_1].coreid].rank + 1)))
		end,
		function()
			return L_SOUL_STRENGTH_PANEL_BTN_TITLE[3]
		end,
		function()
			return L_SOUL_STRENGTH_PANEL_BTN_TITLE[4]
		end,
		function(arg_38_0, arg_38_1)
			return global_trans_number(var_0_3:getBreakOutCostGold(arg_38_1, core_data[playermodel.cores[arg_38_1].coreid].rank + 1) or "100")
		end,
		function()
			return "升学"
		end
	}

	local function var_33_2(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
		if arg_40_2 ~= 0 and arg_40_0.index <= 8 then
			arg_40_0:setOpacity(0)
			arg_40_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_40_2), cc.FadeIn:create(0.1)))
		end

		arg_40_0.soulid = arg_40_1
		arg_40_0.buttonIndex = arg_40_3
		arg_40_0.clickCount = 0

		arg_40_0:setContentSize(cc.size(526, 126))

		local var_40_0 = arg_40_0:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv")
		local var_40_1 = arg_40_0:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv_0")

		arg_40_0:getChildByName("Image_cell"):getChildByName("Image_head").childZOrder = 10000

		arg_40_0:getChildByName("Image_cell"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[arg_40_1].modelid].head_image .. ".png")

		if self:findKeyofValue(self.curFightArray, arg_40_0.soulid) then
			arg_40_0:getChildByName("Image_cell"):getChildByName("Image_fighting_state"):setVisible(true)
		else
			arg_40_0:getChildByName("Image_cell"):getChildByName("Image_fighting_state"):setVisible(false)
		end

		arg_40_0:getChildByName("Image_cell"):getChildByName("Label_name"):setString(servant_data[arg_40_0.soulid].name)

		function arg_40_0.check()
			if arg_40_0.clickCount > 0 then
				arg_40_0.clickCount = arg_40_0.clickCount - 0.1

				if arg_40_0.clickCount > 5 then
					arg_40_0.showStrengthen10Flag = true
				end
			end
		end

		function arg_40_0:resetLevelUpAni(arg_42_1)
			if self.uplevelServant then
				if self.soulidList[arg_42_1 + 1] ~= self.uplevelServant then
					local var_42_0 = core_manager:getServantCoreRank(self.soulid)
					local var_42_1 = self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv")
					local var_42_2 = self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv_0")

					var_42_1:stopAllActions()
					var_42_2:stopAllActions()
					var_42_1:setPosition(cc.p(14, 14))
					var_42_2:setPosition(cc.p(14, -14))
					var_42_1:setString(var_0_3:getCoreLv(self.soulid))
					self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setVisible(true)
					self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setString(global_trans_number((fight_capacity_manager:getSoulFightCapacity(self.soulid, "number"))))

					local var_42_3 = self:getChildByName("Image_cell"):getChildByName("levelUpPowerAnim")
					local var_42_4 = self:getChildByName("Image_cell"):getChildByName("levelUpAnim")

					if var_42_3 then
						var_42_3:setVisible(false)
					end

					if var_42_4 then
						var_42_4:setVisible(false)
					end

					var_42_1:setPosition(cc.p(14, 14))
					var_42_2:setPosition(cc.p(14, -14))
				else
					local var_42_5 = fight_capacity_manager:getSoulFightCapacity(self.soulid, "number")

					if self.isover == true then
						self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setVisible(true)
					else
						self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setVisible(true)
					end

					self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setString(global_trans_number(var_42_5))
				end
			else
				self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setVisible(true)
			end

			if self.changeStrengthenType then
				local var_42_6 = self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv")
				local var_42_7 = self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv_0")

				var_42_6:stopAllActions()
				var_42_7:stopAllActions()
				var_42_6:setPosition(cc.p(14, 14))
				var_42_7:setPosition(cc.p(14, -14))
			end
		end

		function arg_40_0:runLevelUpAni(arg_43_1)
			if self.isover then
				return
			end

			if tonumber(self.level) == var_0_3:getCoreLv(self.soulid) then
				return
			end

			if self.uplevelServant and self.soulidList[arg_43_1 + 1] == self.uplevelServant then
				local var_43_0 = self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv")
				local var_43_1 = self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv_0")
				local var_43_2 = self:getChildByName("Image_cell"):getChildByName("Image_40"):getChildByName("ProgressBar_expBar")

				var_43_0:stopAllActions()
				var_43_1:stopAllActions()

				local var_43_3 = self:getChildByName("Image_cell"):getChildByName("levelUpAnim")

				if not var_43_3 then
					local var_43_4 = armature_manager:createAndPlayArmature("levelUpAnim")

					var_43_4:setName("levelUpAnim")
					self:getChildByName("Image_cell"):addChild(var_43_4, 999)
					var_43_4:setPosition(cc.p(60, 15))
				else
					var_43_3:setVisible(true)
					armature_manager:reStartAnim(var_43_3, "levelUpAnim")
				end

				var_43_0:setString(self.level)
				self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setString(self.fightCapacityValue)

				if self.strengBtnState == 1 then
					local var_43_5 = 1

					var_43_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
						var_43_2:setPercent(var_43_5)

						var_43_5 = var_43_5 + 5

						if var_43_5 >= 105 then
							var_43_2:setPercent(core_manager:getCoreExp(self.soulid) / core_manager:getCoreMaxExp(self.soulid) * 100)
							var_43_2:stopAllActions()
							var_43_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(14, 44)), cc.CallFunc:create(function()
								var_43_0:setString(var_0_3:getCoreLv(self.soulid))

								self.isover = true
							end), cc.MoveTo:create(0, cc.p(14, 14)), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
								local var_46_0 = self:getChildByName("Image_cell"):getChildByName("levelUpPowerAnim")

								if not var_46_0 then
									local var_46_1 = armature_manager:createAndPlayArmature("levelUpPowerAnim")

									var_46_1:setName("levelUpPowerAnim")
									self:getChildByName("Image_cell"):addChild(var_46_1, 999)
									var_46_1:setPosition(cc.p(390, 71))
								else
									var_46_0:setVisible(true)
									armature_manager:reStartAnim(var_46_0, "levelUpPowerAnim")
								end

								local var_46_2 = fight_capacity_manager:getSoulFightCapacity(self.soulid, "number")

								self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setVisible(true)
								self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setString(global_trans_number(var_46_2))
							end)))
							var_43_1:setString(var_0_3:getCoreLv(self.soulid))
							var_43_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(14, 14)), cc.MoveTo:create(0, cc.p(14, -14))))
						end
					end))))
				elseif self.strengBtnState == 10 then
					var_43_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
						local var_47_0 = tonumber(var_43_0:getString()) + 1

						var_43_0:setString(var_47_0)
						ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):setPercent(50)

						if var_47_0 == var_0_3:getCoreLv(self.soulid) then
							var_43_0:stopAllActions()
							self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setVisible(true)
							ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):setPercent(core_manager:getCoreExp(self.soulid) / core_manager:getCoreMaxExp(self.soulid) * 100 / 2)

							self.isover = true

							local var_47_1 = self:getChildByName("Image_cell"):getChildByName("levelUpPowerAnim")

							if not var_47_1 then
								local var_47_2 = armature_manager:createAndPlayArmature("levelUpPowerAnim")

								var_47_2:setName("levelUpPowerAnim")
								self:getChildByName("Image_cell"):addChild(var_47_2, 999)
								var_47_2:setPosition(cc.p(390, 71))
							else
								var_47_1:setVisible(true)
								armature_manager:reStartAnim(var_47_1, "levelUpPowerAnim")
							end

							self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setString(global_trans_number((fight_capacity_manager:getSoulFightCapacity(self.soulid, "number"))))
						end
					end), cc.DelayTime:create(0.016666666666666666), cc.CallFunc:create(function()
						ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):setPercent(75)
					end), cc.DelayTime:create(0.016666666666666666), cc.CallFunc:create(function()
						ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):setPercent(100)
					end), cc.DelayTime:create(0.016666666666666666))))
				end
			end
		end

		arg_40_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(arg_40_0.check), cc.DelayTime:create(0.1))))

		function arg_40_0:update()
			local var_50_0 = core_manager:getServantCoreRank(self.soulid)

			self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv"):setString(var_0_3:getCoreLv(self.soulid))

			local var_50_1 = global_trans_number(0)
			local var_50_2 = global_trans_number(0)
			local var_50_3 = self:getChildByName("Image_cell"):getChildByName("Button_streng1_" .. self.buttonIndex)

			var_50_3:setBright(true)

			local var_50_4 = fight_capacity_manager:getSoulFightCapacity(self.soulid, "number")

			self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setString(global_trans_number(var_50_4))

			self.fightCapacityValue = var_50_4
			self.level = var_0_3:getCoreLv(self.soulid)

			local var_50_6 = core_manager:StrengthenJudge(self.soulid)

			self.res = var_50_6

			if self.strengBtnState == 1 then
				self.strengValue = 1

				var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/upgrade_on.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)
			else
				self.strengValue = core_manager:check_strengthen_point(self.soulid, 10)

				var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)
			end

			self:getChildByName("Image_cell"):getChildByName("Image_breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_50_0 .. ".png", var_0_0)
			self:getChildByName("Image_cell"):getChildByName("Image_breakoutIcon"):setVisible(var_50_0 ~= 0)
			self:getChildByName("Image_cell"):getChildByName("Image_attr"):loadTexture("public/career_icon/" .. global_get_model_attr(servant_data[self.soulid].modelid) .. ".png", var_0_0)

			if core_manager:getCoreMaxExp(self.soulid) == -1 or core_manager:isCoreMax(self.soulid) then
				ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):loadTexture("SoulStrengthLayer/progress_exp_max.png", var_0_0)
				ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):setPercent(0)
				ccui.Helper:seekWidgetByName(self, "Label_exp"):setVisible(false)
			else
				ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):loadTexture("SoulStrengthLayer/progress_exp1.png", var_0_0)
				ccui.Helper:seekWidgetByName(self, "Label_exp"):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "ProgressBar_expBar"):setPercent(core_manager:getCoreExp(self.soulid) / core_manager:getCoreMaxExp(self.soulid) * 100)
				ccui.Helper:seekWidgetByName(self, "Label_exp"):setString(core_manager:getCoreExp(self.soulid) .. "/" .. core_manager:getCoreMaxExp(self.soulid))
			end

			if var_50_6 == 0 then
				var_50_3:getChildByName("Label_text"):setString("LOCKED")
				var_50_3:loadTextures("SoulStrengthLayer/upgrade_off.png", "SoulStrengthLayer/upgrade_off.png", "SoulStrengthLayer/upgrade_off.png", var_0_0)
				var_50_3:getChildByName("Label_cost_value"):setVisible(false)
			else
				if var_50_6 == 1 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)

					if self.strengBtnState == 1 then
						var_50_3:getChildByName("Label_text"):setString(var_0_27)
					else
						var_50_3:getChildByName("Label_text"):setString(var_0_27)
					end

					if self:canFastStrength(self) then
						var_0_29(var_50_3, true, cc.p(var_50_3:getContentSize().width - 15, var_50_3:getContentSize().height - 10))
					else
						var_0_29(var_50_3, false)
					end

					if core_manager:getCoreLv(self.soulid) < playermodel.grade then
						if self.strengBtnState == 1 then
							var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/upgrade_on.png", "", var_0_0)
						else
							var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "", var_0_0)
						end
					elseif self.strengBtnState == 1 then
						var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "", var_0_0)
					else
						var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "", var_0_0)
					end
				elseif var_50_6 == 2 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)
					var_50_3:getChildByName("Label_text"):setString("")

					if self:canFastStrength(self) then
						var_0_29(var_50_3, true, cc.p(var_50_3:getContentSize().width - 0, var_50_3:getContentSize().height - 10))
					else
						var_0_29(var_50_3, false)
					end

					if core_manager:check_upgrade_conditions(self.soulid) then
						var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)
					else
						var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)
					end
				elseif var_50_6 == 3 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)
					var_50_3:getChildByName("Label_text"):setString(var_0_27)

					if component_manager:isAllMaxLevelByServantid(self.soulid) and weapon_manager:isLargeMaxLevelByServantid(self.soulid) then
						var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength_max.png", "SoulStrengthLayer/fast_soulstrength_max.png", "SoulStrengthLayer/fast_soulstrength_max.png", var_0_0)
					else
						var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)
					end

					var_0_29(var_50_3, false)
				elseif var_50_6 == 4 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)

					if self.strengBtnState == 1 then
						var_50_3:getChildByName("Label_text"):setString(var_0_27)
					else
						var_50_3:getChildByName("Label_text"):setString(var_0_27)
					end

					var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)
					var_0_29(var_50_3, false)
				elseif var_50_6 == 5 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)
					var_50_3:getChildByName("Label_text"):setString("")

					local var_50_7 = component_manager:isMaxLevelByServantid(self.soulid)
					local var_50_8 = weapon_manager:isActiveWeaponByServantid(self.soulid)
					local var_50_9 = weapon_manager:isMaxLevelByServantid(self.soulid)

					if not component_manager:isMaxLevelByServantid(self.soulid) or weapon_manager:isActiveWeaponByServantid(self.soulid) and not weapon_manager:isMaxLevelByServantid(self.soulid) then
						var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)
					else
						if self:canFastStrength(self) then
							var_0_29(var_50_3, true, cc.p(var_50_3:getContentSize().width - 0, var_50_3:getContentSize().height - 10))
						else
							var_0_29(var_50_3, false)
						end

						if core_manager:check_upgrade_conditions(self.soulid) then
							var_50_3:loadTextures("SoulStrengthLayer/advance.png", "SoulStrengthLayer/advance.png", "SoulStrengthLayer/advance.png", var_0_0)
						else
							var_50_3:loadTextures("SoulStrengthLayer/advance_off.png", "SoulStrengthLayer/advance_off.png", "SoulStrengthLayer/advance_off.png", var_0_0)
						end
					end
				elseif var_50_6 == 6 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)
					var_50_3:getChildByName("Label_text"):setString("")
					var_50_3:loadTextures("SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", "SoulStrengthLayer/fast_soulstrength.png", var_0_0)

					if self:canFastStrength(self) then
						var_0_29(var_50_3, true, cc.p(var_50_3:getContentSize().width - 0, var_50_3:getContentSize().height - 10))
					else
						var_0_29(var_50_3, false)
					end
				end

				var_50_3:getChildByName("Label_cost_value"):setString(global_trans_number(var_33_1[var_50_6](self.strengValue, self.soulid)))
			end
		end

		local function var_40_2(arg_51_0)
			return 1136 - self.panel:getPositionY() - self.panel:getContentSize().height / 2 * self.panel:getScaleY() + 10 > arg_51_0.y or 1136 - self.panel:getPositionY() + self.panel:getContentSize().height / 2 * self.panel:getScaleY() + 10 < arg_51_0.y
		end

		local var_40_3 = arg_40_0:getChildByName("Image_cell"):getChildByName("Button_streng1")

		var_40_3:getChildByName("Image_22"):loadTexture("public/currency/UI_strength_point.png", var_0_0)
		var_40_3:setSwallowTouches(false)
		var_40_3:setName("Button_streng1_" .. arg_40_0.buttonIndex)
		var_40_3:addTouchEventListener(function(arg_52_0, arg_52_1)
			local var_52_0

			if arg_52_1 ~= ccui.TouchEventType.ended then
				do return end

				var_52_0 = arg_52_0:getTouchEndPosition()
			end

			if math.abs(arg_52_0:getTouchBeganPosition().y - var_52_0.y) > 50 then
				return
			end

			if var_40_2(var_52_0) then
				self:exit()

				return
			end

			local var_52_1 = arg_40_0.soulid

			self.curServantid = arg_40_0.soulid

			if not arg_52_0:isBright() then
				return
			end

			if arg_40_0.res == 1 then
				self.level = var_0_3:getCoreLv(var_52_1)
				self.fightCapacity = fight_capacity_manager:getSoulFightCapacity(arg_40_0.soulid, "number")

				local var_52_2 = core_manager:getCoreLv(var_52_1)

				var_0_3:requestFastStrengthen(arg_40_0.soulid, function(arg_53_0, arg_53_1)
					if self.activeFlag and var_0_28 then
						if arg_53_0 == 1 then
							self:fastStrengthen(arg_40_0, var_52_1, var_52_2)
						elseif arg_53_0 == 11 then
							LayerManager:pushInLayer("FastSoulStrengthSettingLayer")
						else
							if arg_53_1 then
								if arg_53_0 == 4 then
									self:showConfirmPop(arg_40_0.soulid, arg_53_1, L_SOUL_STRENGTH_LEVEL_LACK)
								else
									global_ShowBlockWords(arg_53_1)
								end
							end

							audio_manager:playeffectMusicTest("sound/invalid")
						end
					end
				end)
			end

			if arg_40_0.res ~= 2 then
				if arg_40_0.res == 3 then
					if component_manager:isAllMaxLevelByServantid(var_52_1) and weapon_manager:isLargeMaxLevelByServantid(var_52_1) then
						return
					end

					self.level = var_0_3:getCoreLv(var_52_1)
					self.fightCapacity = fight_capacity_manager:getSoulFightCapacity(arg_40_0.soulid, "number")

					local var_52_3 = core_manager:getCoreLv(var_52_1)

					var_0_3:requestFastStrengthen(arg_40_0.soulid, function(arg_57_0, arg_57_1)
						if self.activeFlag and var_0_28 then
							if arg_57_0 == 1 then
								self:fastStrengthen(arg_40_0, var_52_1, var_52_3)
							elseif arg_57_0 == 11 then
								LayerManager:pushInLayer("FastSoulStrengthSettingLayer")
							else
								if arg_57_1 then
									if arg_57_0 == 4 then
										self:showConfirmPop(arg_40_0.soulid, arg_57_1, L_SOUL_STRENGTH_LEVEL_LACK)
									else
										global_ShowBlockWords(arg_57_1)
									end
								end

								audio_manager:playeffectMusicTest("sound/invalid")
							end
						end
					end)
				elseif arg_40_0.res == 4 then
					self.level = var_0_3:getCoreLv(var_52_1)
					self.fightCapacity = fight_capacity_manager:getSoulFightCapacity(arg_40_0.soulid, "number")

					local var_52_4 = core_manager:getCoreLv(var_52_1)

					var_0_3:requestFastStrengthen(arg_40_0.soulid, function(arg_58_0, arg_58_1)
						if self.activeFlag and var_0_28 then
							if arg_58_0 == 1 then
								self:fastStrengthen(arg_40_0, var_52_1, var_52_4)
							elseif arg_58_0 == 11 then
								LayerManager:pushInLayer("FastSoulStrengthSettingLayer")
							else
								if arg_58_1 then
									if arg_58_0 == 4 then
										self:showConfirmPop(arg_40_0.soulid, arg_58_1, L_SOUL_STRENGTH_LEVEL_LACK)
									else
										global_ShowBlockWords(arg_58_1)
									end
								end

								audio_manager:playeffectMusicTest("sound/invalid")
							end
						end
					end)
				elseif arg_40_0.res == 5 then
					if not component_manager:isMaxLevelByServantid(arg_40_0.soulid) or weapon_manager:isActiveWeaponByServantid(arg_40_0.soulid) and not weapon_manager:isMaxLevelByServantid(arg_40_0.soulid) then
						self.level = var_0_3:getCoreLv(var_52_1)
						self.fightCapacity = fight_capacity_manager:getSoulFightCapacity(arg_40_0.soulid, "number")

						local var_52_5 = core_manager:getCoreLv(var_52_1)

						var_0_3:requestFastStrengthen(arg_40_0.soulid, function(arg_59_0, arg_59_1)
							if self.activeFlag and var_0_28 then
								if arg_59_0 == 1 then
									self:fastStrengthen(arg_40_0, var_52_1, var_52_5)
								elseif arg_59_0 == 11 then
									LayerManager:pushInLayer("FastSoulStrengthSettingLayer")
								else
									if arg_59_1 then
										if arg_59_0 == 4 then
											self:showConfirmPop(arg_40_0.soulid, arg_59_1, L_SOUL_STRENGTH_LEVEL_LACK)
										else
											global_ShowBlockWords(arg_59_1)
										end
									end

									audio_manager:playeffectMusicTest("sound/invalid")
								end
							end
						end)
					else
						(function(arg_54_0, arg_54_1)
							arg_54_1 = arg_54_1 or 1

							local var_54_0 = playermodel.cores[arg_54_0].coreid
							local var_54_1 = core_data[playermodel.cores[arg_54_0].coreid].upgrade

							if not core_data[core_data[playermodel.cores[arg_54_0].coreid].upgrade] then
								var_54_1 = var_54_0
							end

							local servant_level_data = require("data.servant_level_data")
							local var_54_3 = core_manager:getCoreLv(arg_54_0)
							local var_54_4 = var_0_3:getStrengthenValue(arg_54_0, var_54_0, var_54_3)
							local var_54_6 = var_0_3:getStrengthenValue(arg_54_0, var_54_1, var_54_3)
							local var_54_7 = "+" .. model_data[servant_data[arg_54_0].modelid].hpFactor * var_54_6 - model_data[servant_data[arg_54_0].modelid].hpFactor * var_54_4
							local var_54_8 = "+" .. model_data[servant_data[arg_54_0].modelid].damageFactor * var_54_6 - model_data[servant_data[arg_54_0].modelid].damageFactor * var_54_4
							local var_54_9 = "+" .. var_54_6 - var_54_4
							local var_54_10 = core_manager:getServantCoreRank(arg_54_0)

							if core_manager:isCoreMax(arg_54_0) then
								LayerManager:pushInLayer("PopServantMaxBreakoutLayer", {
									servantid = arg_54_0
								})
							else
								local var_54_12 = core_manager:getCoreTotalLv(core_data[var_54_0].rank)

								if not servant_data[arg_54_0].role_type then
									-- block empty
								end

								local var_54_14 = core_data[playermodel.cores[arg_54_0].coreid].rank
								local var_54_15 = {
									showIntro = true
								}
								local var_54_16 = {}
								local var_54_17 = {
									newvalue = var_54_12
								}

								if var_54_12 ~= "" then
									var_54_17.name = L_BREAKOUT_HANDEL.Name[1] or L_BREAKOUT_HANDEL.Name[5]
								end

								var_54_16[1] = var_54_17

								local var_54_18 = {
									newvalue = var_54_12 ~= "" and var_54_9 or ""
								}

								if var_54_12 ~= "" then
									var_54_18.name = L_BREAKOUT_HANDEL.Name[2] or ""
								end

								var_54_16[2] = var_54_18

								local var_54_19 = {
									newvalue = var_54_12 ~= "" and var_54_8 or ""
								}

								if var_54_12 ~= "" then
									var_54_19.name = L_BREAKOUT_HANDEL.Name[3] or ""
								end

								var_54_16[3] = var_54_19

								local var_54_20 = {
									newvalue = var_54_12 ~= "" and var_54_7 or ""
								}

								if var_54_12 ~= "" then
									var_54_20.name = L_BREAKOUT_HANDEL.Name[4] or ""
								end

								var_54_16[4] = var_54_20
								var_54_15.labels = var_54_16
								var_54_15.materials = {}
								var_54_15.gold_cost = var_0_3:getBreakOutCostGold(arg_54_0, core_data[playermodel.cores[arg_54_0].coreid].rank + 1)
								var_54_15.goto_back_system_id = self.msg.goto_back_system_id or 200
								var_54_15.servantid = arg_54_0
								var_54_15.up_type = arg_54_1

								local var_54_21 = true
								local var_54_22 = var_0_3:getBreakOutCostMaterial(arg_54_0, var_54_14 + 1)

								for iter_54_0, iter_54_1 in pairs(var_54_22) do
									local var_54_23 = item_manager:getItemNumber(iter_54_1.itemid)

									var_54_15.materials[#var_54_15.materials + 1] = {}
									var_54_15.materials[#var_54_15.materials].ownnum = var_54_23
									var_54_15.materials[#var_54_15.materials].neednum = iter_54_1.num
									var_54_15.materials[#var_54_15.materials].id = iter_54_1.itemid

									if var_54_23 < iter_54_1.num then
										var_54_21 = false
									end
								end

								function var_54_15.surecallback(arg_55_0)
									local var_55_0 = {}

									for iter_55_0 = 1, #var_54_15.materials do
										var_55_0[iter_55_0] = var_54_15.materials[iter_55_0].id
									end

									var_54_21 = true

									for iter_55_1, iter_55_2 in pairs(var_54_22) do
										if iter_55_2.num > item_manager:getItemNumber(iter_55_2.itemid) then
											var_54_21 = false

											break
										end
									end

									if var_54_21 then
										local var_55_1 = core_data[playermodel.cores[arg_54_0].coreid].rank

										core_manager:upgradeCoreToServer(arg_54_0, function(arg_56_0, arg_56_1)
											if arg_56_0 == 1 then
												({})[1] = L_SOULS_CENTRE_LV .. "  " .. var_55_1 .. " → " .. core_data[playermodel.cores[arg_54_0].coreid].rank

												local var_56_0 = {
													cc.c3b(255, 150, 0)
												}

												arg_40_0:update()
												audio_manager:playeffectMusicTest("sound/jinjie")
												arg_55_0(1)
												self:breakAnimation(arg_54_0, var_55_0, arg_54_1)
												self:updateShowingCells(self.listPanel)

												if self.msg.servantid then
													AnalyticManager.servant_upgrade_core_by_equiplayer({
														servantid = arg_54_0,
														grade = core_manager:getServantCoreRank(arg_54_0)
													})
												else
													AnalyticManager.servant_upgrade_core({
														servantid = arg_54_0,
														grade = core_manager:getServantCoreRank(arg_54_0)
													})
												end
											else
												if arg_56_0 == 4 then
													LayerManager:pushInLayer("PopGoLayer", {
														targetlayer = "TopPlotListLayer",
														goto_back_system_id = 201,
														labels = L_BREAKOUT_HANDEL.Button_Msg
													})
												else
													if arg_56_1 then
														global_ShowBlockWords(arg_56_1)
													end

													audio_manager:playeffectMusicTest("sound/invalid")
												end

												arg_55_0()
											end
										end)
									else
										global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
										audio_manager:playeffectMusicTest("sound/invalid")
									end
								end

								LayerManager:pushInLayer("PopServantBreakout", var_54_15)
							end
						end)(arg_40_0.soulid, 2)
					end
				elseif arg_40_0.res == 6 then
					self.level = var_0_3:getCoreLv(var_52_1)
					self.fightCapacity = fight_capacity_manager:getSoulFightCapacity(arg_40_0.soulid, "number")

					local var_52_6 = core_manager:getCoreLv(var_52_1)

					var_0_3:requestFastStrengthen(arg_40_0.soulid, function(arg_60_0, arg_60_1)
						if self.activeFlag and var_0_28 then
							if arg_60_0 == 1 then
								self:fastStrengthen(arg_40_0, var_52_1, var_52_6)
							elseif arg_60_0 == 11 then
								LayerManager:pushInLayer("FastSoulStrengthSettingLayer")
							else
								if arg_60_1 then
									if arg_60_0 == 4 then
										self:showConfirmPop(arg_40_0.soulid, arg_60_1, L_SOUL_STRENGTH_LEVEL_LACK)
									else
										global_ShowBlockWords(arg_60_1)
									end
								end

								audio_manager:playeffectMusicTest("sound/invalid")
							end
						end
					end)
				end
			end
		end)
		arg_40_0:update()

		return arg_40_0
	end

	local function var_33_3(arg_61_0, arg_61_1)
		arg_61_0.clickCount = 0
		arg_61_0.soulid = arg_61_1

		arg_61_0:setOpacity(255)
		arg_61_0:getChildByName("Image_cell"):getChildByName("Image_head"):removeAllChildren()

		arg_61_0:getChildByName("Image_cell"):getChildByName("Image_head").childZOrder = 10000

		arg_61_0:getChildByName("Image_cell"):getChildByName("Image_head"):setTouchEnabled(true)
		arg_61_0:getChildByName("Image_cell"):getChildByName("Image_head"):addTouchEventListener(function(arg_62_0, arg_62_1)
			if arg_62_1 == ccui.TouchEventType.ended then
				if math.abs(arg_62_0:getTouchBeganPosition().x - arg_62_0:getTouchEndPosition().x) >= 25 then
					return
				end

				if math.abs(arg_62_0:getTouchBeganPosition().y - arg_62_0:getTouchEndPosition().y) >= 25 then
					return
				end

				LayerManager:pushInLayer("SoulsLayer", {
					showtype = 6,
					cursoul = arg_61_1,
					exitCallback = function()
						if self.listPanel then
							self:updateShowingCells(self.listPanel)
						end
					end
				})
			end
		end)
		arg_61_0:update()
		arg_61_0:getChildByName("Image_cell"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[arg_61_1].modelid].head_image .. ".png")

		if self:findKeyofValue(self.curFightArray, arg_61_0.soulid) then
			arg_61_0:getChildByName("Image_cell"):getChildByName("Image_fighting_state"):setVisible(true)
		else
			arg_61_0:getChildByName("Image_cell"):getChildByName("Image_fighting_state"):setVisible(false)
		end

		arg_61_0:getChildByName("Image_cell"):getChildByName("Label_name"):setString(servant_data[arg_61_0.soulid].name)
		arg_61_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(arg_61_0.check), cc.DelayTime:create(0.1))))
	end

	if not self.listPanel then
		self.strengBtnState = RoleDefault:getInstance():getIntegerForKey("onceStrengLv", 10)

		;(function()
			self.listPanel = cc.TableView:create(cc.size(var_0_23, var_0_24 + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))

			self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
			self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
			self.listPanel:setPosition(cc.p(-40, 15))
			self.listPanel:setDelegate()
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):addChild(self.listPanel)
			self.listPanel:registerScriptHandler(function(arg_66_0, arg_66_1)
				return var_0_21, var_0_22
			end, cc.TABLECELL_SIZE_FOR_INDEX)
			self.listPanel:registerScriptHandler(function(arg_65_0, arg_65_1, arg_65_2)
				local var_65_0 = arg_65_0:dequeueCell()

				if not var_65_0 then
					var_65_0 = cc.TableViewCell:create()

					var_65_0:setName("cell_" .. arg_65_1)

					local var_65_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):clone()
					local var_65_3 = arg_65_1 < math.ceil(var_0_24 / var_0_22) and (arg_65_1 + 1) * 0.1 or 0

					var_65_2.index = arg_65_1

					var_65_2:getChildByName("Image_cell"):getChildByName("Button_streng1")
					var_65_2:getChildByName("Image_cell"):getChildByName("Panel_47"):setContentSize(cc.size(70, 30))
					var_33_2(var_65_2, self.soulidList[arg_65_1 + 1], var_65_3, arg_65_1)
					var_33_3(var_65_2, self.soulidList[arg_65_1 + 1])
					var_65_2:setPosition(cc.p(85, 0))
					var_65_2:setName("soulCell")
					var_65_2:runLevelUpAni(arg_65_1)
					var_65_0:addChild(var_65_2)
				else
					local var_65_4 = var_65_0:getChildByName("soulCell")

					var_33_3(var_65_4, self.soulidList[arg_65_1 + 1])
					var_65_4:runLevelUpAni(arg_65_1)
					var_65_4:resetLevelUpAni(arg_65_1)
				end

				self:updateStrengPoint()

				return var_65_0
			end, cc.TABLECELL_SIZE_AT_INDEX)
			self.listPanel:registerScriptHandler(function(arg_67_0, arg_67_1)
				return #self.soulidList
			end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
			self.listPanel:reloadData()
		end)()
		;(function()
			local var_68_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState10")
			local var_68_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState1")

			function var_68_0.update()
				self.uplevelServant = nil

				if self.strengBtnState == 1 then
					var_68_1:loadTextures("SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", var_0_0)
					var_68_0:loadTextures("SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", var_0_0)
					var_68_1:getChildByName("Label_streng1"):setColor(cc.c3b(255, 255, 255))
					var_68_0:getChildByName("Label_streng10"):setColor(cc.c3b(163, 180, 223))
				else
					var_68_1:loadTextures("SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", var_0_0)
					var_68_0:loadTextures("SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", var_0_0)
					var_68_1:getChildByName("Label_streng1"):setColor(cc.c3b(163, 180, 223))
					var_68_0:getChildByName("Label_streng10"):setColor(cc.c3b(255, 255, 255))
				end
			end

			var_68_0.update()
			var_68_0:addTouchEventListener(function(arg_70_0, arg_70_1)
				if arg_70_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.strengBtnState == 10 then
					return
				end

				self.strengBtnState = 10

				RoleDefault:getInstance():setIntegerForKey("onceStrengLv", self.strengBtnState)
				var_68_0.update()

				self.changeStrengthenType = true

				self:updateShowingCells(self.listPanel)

				self.changeStrengthenType = nil
			end)
			var_68_1:addTouchEventListener(function(arg_71_0, arg_71_1)
				if arg_71_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.strengBtnState == 1 then
					return
				end

				self.strengBtnState = 1

				RoleDefault:getInstance():setIntegerForKey("onceStrengLv", self.strengBtnState)
				var_68_0.update()

				self.changeStrengthenType = true

				self:updateShowingCells(self.listPanel)

				self.changeStrengthenType = nil
			end)
		end)()
	end
end

function FastSoulStrengthLayer:updateHoildayPanel()
	local function var_72_0(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
		if arg_73_2 ~= 0 and arg_73_0.index <= 8 then
			arg_73_0:setOpacity(0)
			arg_73_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_73_2), cc.FadeIn:create(0.1)))
		end

		arg_73_0.soulid = arg_73_1
		arg_73_0.buttonIndex = arg_73_3
		arg_73_0.clickCount = 0

		arg_73_0:setContentSize(cc.size(526, 126))

		local var_73_0 = arg_73_0:getChildByName("Image_cell"):getChildByName("Button_useHoliday")

		var_73_0:setName("Button_useHoliday_" .. arg_73_0.buttonIndex)

		arg_73_0:getChildByName("Image_cell"):getChildByName("Image_head").childZOrder = 10000

		arg_73_0:getChildByName("Image_cell"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[arg_73_1].modelid].head_image .. ".png")
		arg_73_0:getChildByName("Image_cell"):getChildByName("Label_name"):setString(servant_data[arg_73_0.soulid].name)

		function arg_73_0.update()
			local var_74_0 = core_data[playermodel.cores[arg_73_0.soulid].coreid].rank
			local var_74_1

			if playermodel.weaponId[arg_73_0.soulid] then
				var_74_1 = playermodel.items[playermodel.weaponId[arg_73_0.soulid]].weapon_attr.level
			end

			arg_73_0.level = var_0_3:getCoreLv(arg_73_0.soulid)

			arg_73_0:getChildByName("Image_cell"):getChildByName("Label_lv"):setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
			arg_73_0:getChildByName("Image_cell"):getChildByName("Label_lv"):setString(arg_73_0.level)

			local var_74_2 = global_trans_number(0)
			local var_74_3 = global_trans_number(0)
			local var_74_4 = arg_73_0:getChildByName("Image_cell"):getChildByName("Button_useHoliday_" .. arg_73_0.buttonIndex)

			var_74_4:setBright(true)

			if arg_73_0.level == 0 and var_74_0 == 0 and (not var_74_1 or var_74_1 == 0) then
				var_74_4:loadTextures("SoulStrengthLayer/hoilday_off.png", "SoulStrengthLayer/hoilday_off.png", "SoulStrengthLayer/hoilday_off.png", var_0_0)
			else
				var_74_4:loadTextures("SoulStrengthLayer/hoilday_normal.png", "SoulStrengthLayer/hoilday_on.png", "SoulStrengthLayer/hoilday_off.png", var_0_0)
			end

			arg_73_0:getChildByName("Image_cell"):getChildByName("Label_breakLimitCount"):setString(var_74_0)

			local var_74_5 = core_manager:getServantCoreRank(arg_73_0.soulid)

			arg_73_0:getChildByName("Image_cell"):getChildByName("Image_breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_74_5 .. ".png", var_0_0)
			arg_73_0:getChildByName("Image_cell"):getChildByName("Image_breakoutIcon"):setVisible(var_74_5 ~= 0)
			arg_73_0:getChildByName("Image_cell"):getChildByName("Label_weapon"):setString(0)

			if playermodel.weaponId[arg_73_0.soulid] then
				arg_73_0:getChildByName("Image_cell"):getChildByName("Label_weapon"):setString(playermodel.items[playermodel.weaponId[arg_73_0.soulid]].weapon_attr.level)
			end
		end

		var_73_0:addTouchEventListener(function(arg_75_0, arg_75_1)
			if arg_75_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_75_0

			if playermodel.weaponId[arg_73_0.soulid] then
				var_75_0 = playermodel.items[playermodel.weaponId[arg_73_0.soulid]].weapon_attr.level
			end

			if core_manager:getServantCoreRank(arg_73_0.soulid) == 0 and arg_73_0.level == 0 and (not var_75_0 or var_75_0 == 0) then
				global_ShowBlockWords(L_SOUL_STRENGTH_HOLIDAY_FORBID)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				self:showHoildayPop(arg_73_0.soulid, function()
					self:updateShowingCells(self.holidayListPanel)
					self:updateStrengPoint()
				end)
			end
		end)
	end

	local function var_72_1(arg_77_0, arg_77_1)
		arg_77_0.clickCount = 0
		arg_77_0.soulid = arg_77_1

		arg_77_0:setOpacity(255)
		arg_77_0:getChildByName("Image_cell"):getChildByName("Image_head"):removeAllChildren()

		arg_77_0:getChildByName("Image_cell"):getChildByName("Image_head").childZOrder = 10000

		arg_77_0:getChildByName("Image_cell"):getChildByName("Image_head"):setTouchEnabled(true)
		arg_77_0:getChildByName("Image_cell"):getChildByName("Image_head"):addTouchEventListener(function(arg_78_0, arg_78_1)
			if arg_78_1 == ccui.TouchEventType.ended then
				if math.abs(arg_78_0:getTouchBeganPosition().x - arg_78_0:getTouchEndPosition().x) >= 25 then
					return
				end

				if math.abs(arg_78_0:getTouchBeganPosition().y - arg_78_0:getTouchEndPosition().y) >= 25 then
					return
				end

				LayerManager:pushInLayer("SoulsLayer", {
					showtype = 6,
					cursoul = arg_77_1
				})
			end
		end)

		self.index = nil

		arg_77_0:update()
		arg_77_0:getChildByName("Image_cell"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[arg_77_1].modelid].head_image .. ".png")
		arg_77_0:getChildByName("Image_cell"):getChildByName("Label_name"):setString(servant_data[arg_77_0.soulid].name)
	end

	if not self.holidayListPanel then
		(function()
			self.imgTip = ccui.ImageView:create("SoulStrengthLayer/img_tip_holiday.png", var_0_0)

			local var_83_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

			self.imgTip:setPosition(var_83_0:getContentSize().width / 2, var_83_0:getContentSize().height - self.imgTip:getContentSize().height / 2 - 85)
			var_83_0:addChild(self.imgTip)
		end)()
		;(function()
			self.holidayListPanel = cc.TableView:create(cc.size(var_0_25, var_0_26 + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT - self.imgTip:getContentSize().height))

			self.holidayListPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
			self.holidayListPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
			self.holidayListPanel:setPosition(cc.p(12, 26))
			self.holidayListPanel:setDelegate()
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):addChild(self.holidayListPanel)
			self.holidayListPanel:registerScriptHandler(function(arg_81_0, arg_81_1)
				return var_0_21, var_0_22
			end, cc.TABLECELL_SIZE_FOR_INDEX)
			self.holidayListPanel:registerScriptHandler(function(arg_80_0, arg_80_1)
				local var_80_0 = arg_80_0:dequeueCell()

				if not var_80_0 then
					var_80_0 = cc.TableViewCell:create()

					local var_80_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_HolidayCell"):clone()

					var_80_1.index = arg_80_1

					var_72_0(var_80_1, self.soulidList[arg_80_1 + 1], arg_80_1 < math.ceil(var_0_24 / var_0_22) and (arg_80_1 + 1) * 0.1 or 0, arg_80_1)
					var_72_1(var_80_1, self.soulidList[arg_80_1 + 1])
					var_80_1:setPosition(cc.p(5, 0))
					var_80_1:setName("soulCell")
					var_80_0:addChild(var_80_1)
				else
					var_72_1(var_80_0:getChildByName("soulCell"), self.soulidList[arg_80_1 + 1])
				end

				return var_80_0
			end, cc.TABLECELL_SIZE_AT_INDEX)
			self.holidayListPanel:registerScriptHandler(function(arg_82_0, arg_82_1)
				return #self.soulidList
			end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
			self.holidayListPanel:reloadData()
		end)()
	end
end

function FastSoulStrengthLayer:showHoildayPop(arg_84_1, arg_84_2)
	LayerManager:pushInLayer("PopHolidayConfirmLayer", {
		servantid = arg_84_1,
		sureCallback = arg_84_2,
		goto_back_system_id = self.msg.goto_back_system_id,
		resetCallback = self.resetCallback
	})
end

function FastSoulStrengthLayer.findKeyofValue(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0

	if arg_85_1 then
		for iter_85_0, iter_85_1 in pairs(arg_85_1) do
			if iter_85_1 == arg_85_2 then
				var_85_0 = iter_85_0

				return iter_85_0
			end
		end
	end

	return var_85_0
end

function FastSoulStrengthLayer.breakAnimation(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
	local var_86_0 = ccui.Layout:create()

	var_86_0:setTouchEnabled(true)
	var_86_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_86_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_86_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_86_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_86_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_86_0:setBackGroundColorOpacity(180)
	global_basic_scene:addChild(var_86_0, 999)

	local var_86_1 = ccui.ImageView:create("roleimage/role1/" .. model_data[global_get_servant_skin(arg_86_1)].cute_role .. ".png")

	var_86_1:setPosition(cc.p(var_86_0:getContentSize().width / 2, var_86_0:getContentSize().height / 2))
	var_86_0:addChild(var_86_1, 999)

	local var_86_2 = ccui.ImageView:create("SoulStrengthLayer/role_bottom.png", var_0_0)

	var_86_2:setPosition(cc.p(var_86_1:getContentSize().width / 2, 0))
	var_86_1:addChild(var_86_2, 100)
	var_86_1:setScale(0.7)

	local var_86_3 = {}

	for iter_86_0 = 1, #arg_86_2 do
		var_86_3[iter_86_0] = ccui.Layout:create()

		var_86_3[iter_86_0]:setTouchEnabled(false)
		var_86_3[iter_86_0]:setContentSize(cc.p(1, 1))
		var_86_3[iter_86_0]:setAnchorPoint(cc.p(0.5, 0.5))
		var_86_3[iter_86_0]:setPosition(cc.p(var_86_1:getContentSize().width / 2, var_86_1:getContentSize().height / 2 - 20))
		var_86_3[iter_86_0]:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		var_86_3[iter_86_0]:setBackGroundColorOpacity(255)
		var_86_1:addChild(var_86_3[iter_86_0], 999)
	end

	local var_86_4 = cc.SpriteFrameCache:getInstance()

	var_86_4:addSpriteFrames("effect/up_grade/shengjie.plist")

	local var_86_5 = {}

	for iter_86_1 = 1, #arg_86_2 do
		var_86_5[iter_86_1] = cc.Sprite:createWithSpriteFrameName("shengjie01.png")

		local var_86_6 = ccui.ImageView:create("equipment/" .. item_data[arg_86_2[iter_86_1]].image_id .. ".png")

		var_86_6:setPosition(cc.p(var_86_5[iter_86_1]:getContentSize().width / 2, var_86_5[iter_86_1]:getContentSize().height / 2))
		var_86_6:setScale(0.5)
		var_86_5[iter_86_1]:addChild(var_86_6, 999)
		var_86_5[iter_86_1]:setScale(1.5)
		var_86_5[iter_86_1]:setAnchorPoint(cc.p(0.5, 0.5))
		var_86_5[iter_86_1]:setPosition(var_86_1:getContentSize().width / 2 - 30, var_86_1:getContentSize().height / 2)
		var_86_3[iter_86_1]:addChild(var_86_5[iter_86_1], 100000)
	end

	local var_86_7 = false

	var_86_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		var_86_7 = true
	end), cc.CallFunc:create(function()
		audio_manager:playeffectMusicTest("sound/upgrade_rank")

		local var_90_0 = cc.Animation:create()

		for iter_90_0 = 1, 14 do
			var_90_0:addSpriteFrame((var_86_4:getSpriteFrame(string.format("shengjie%02d.png", iter_90_0))))
		end

		var_90_0:setDelayPerUnit(0.125)
		var_90_0:setRestoreOriginalFrame(false)

		local var_90_1 = cc.Animate:create(var_90_0)
		local var_90_2 = cc.RemoveSelf:create()

		for iter_90_1 = 1, #arg_86_2 do
			var_86_5[iter_90_1]:runAction(cc.Sequence:create(cc.Spawn:create(var_90_1, cc.MoveTo:create(0.5, cc.p(0, 0)), cc.ScaleTo:create(0.5, 0.3), (cc.RotateTo:create(0.5, 360))), var_90_2))
			var_86_3[iter_90_1]:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.5, 360 / #arg_86_2)))
		end
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		local var_87_0 = ccui.ImageView:create("SoulStrengthLayer/light.png", var_0_0)

		var_87_0:setPosition(cc.p(var_86_0:getContentSize().width / 2, var_86_0:getContentSize().height / 2))
		var_87_0:setScale(0.1)
		var_86_0:addChild(var_87_0, 999)
		var_87_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 100), cc.RemoveSelf:create()))
		var_86_1:setVisible(false)
	end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local var_88_0 = ccui.ImageView:create("SoulStrengthLayer/yellowBg.png", var_0_0)

		var_88_0:setPosition(cc.p(var_86_0:getContentSize().width / 2, var_86_0:getContentSize().height / 2))
		var_88_0:setScale(0, 1)
		var_88_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
			local var_89_0 = cc.Label:createWithTTF((arg_86_3 == 2 or nil) and (L_BREAKOUT_HANDEL.advance_success or L_BREAKOUT_HANDEL.Success), FONT_NAME, 30)

			var_89_0:setColor(cc.c3b(0, 0, 0))
			var_89_0:setPosition(cc.p(var_88_0:getContentSize().width / 2, var_88_0:getContentSize().height / 2))
			var_88_0:addChild(var_89_0, 999)
		end)))
		var_86_0:addChild(var_88_0, 999)
	end), cc.DelayTime:create(3), cc.RemoveSelf:create()))
	var_86_0:addTouchEventListener(function(arg_92_0, arg_92_1)
		if arg_92_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_86_7 then
			return
		end

		var_86_0:runAction(cc.RemoveSelf:create())
	end)
end

function FastSoulStrengthLayer:showBreakLimitAni(arg_93_1, arg_93_2, arg_93_3)
	audio_manager:playeffectMusicTest("sound/upgrade_rank")

	local var_93_0 = ccui.Layout:create()

	var_93_0:setTouchEnabled(true)
	var_93_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_93_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_93_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_93_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_93_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_93_0:setBackGroundColorOpacity(180)
	global_basic_scene:addChild(var_93_0, 999)

	local var_93_1 = L2Skeleton:create("spine/ui/servant_break_limit/e_level_break_limit.json", "spine/ui/servant_break_limit/e_level_break_limit.atlas")

	var_93_1:refreshSkeleton()
	var_93_1.skeletonAnimation:setPosition(cc.p(320, 600))
	var_93_1:play("e_tupo", false)
	var_93_0:addChild(var_93_1)
	self:breakAnimation(arg_93_3, var_93_0)

	local var_93_3 = ccui.Text:create(arg_93_2.text .. arg_93_2.oldBreakNum, FONT_BUTTON, 30)

	var_93_3:setColor(cc.c3b(255, 150, 0))
	var_93_3:setOpacity(0)
	var_93_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0), cc.DelayTime:create(0.38), cc.FadeOut:create(0), cc.DelayTime:create(0.06), cc.FadeIn:create(0), cc.CallFunc:create(function()
		var_93_3:setString(arg_93_2.text .. arg_93_2.curBreakNum)
	end), cc.ScaleTo:create(0.2, 1.2), cc.DelayTime:create(0.2), cc.FadeOut:create(0.1), cc.RemoveSelf:create()))
	var_93_3:setPositionX(320)
	var_93_3:setPositionY(630)
	var_93_0:addChild(var_93_3, 2)

	local var_93_4 = false

	var_93_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_93_4 = true
	end), cc.CallFunc:create(function()
		local var_95_0 = {}
		local var_95_1 = {}
		local var_95_2 = {}

		while #arg_93_1[1] > 0 do
			var_95_0[#var_95_0 + 1] = arg_93_1[1][#arg_93_1[1]]
			var_95_2[#var_95_2 + 1] = arg_93_1[2][#arg_93_1[1]]
			var_95_1[#var_95_1 + 1] = arg_93_1[3][#arg_93_1[1]]
		end

		local var_95_4 = 850

		;(function()
			local var_96_0 = ccui.Text:create(arg_93_2.text .. ":", FONT_DES, 26)

			var_96_0:setColor(cc.c3b(255, 150, 0))
			var_96_0:setPositionX(150)
			var_96_0:setPositionY(var_95_4 - 80)
			var_96_0:setOpacity(0)
			var_96_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_93_0:addChild(var_96_0, 2)

			local var_96_1 = ccui.Text:create(arg_93_2.oldBreakNum, FONT_DES, 26)

			var_96_1:setColor(cc.c3b(255, 150, 0))
			var_96_1:setPositionX(350)
			var_96_1:setPositionY(var_95_4 - 80)
			var_96_1:setOpacity(0)
			var_96_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_93_0:addChild(var_96_1, 2)

			local var_96_2 = ccui.Text:create(arg_93_2.curBreakNum, FONT_DES, 26)

			var_96_2:setColor(cc.c3b(255, 150, 0))
			var_96_2:setPositionX(500)
			var_96_2:setPositionY(var_95_4 - 80)
			var_96_2:setOpacity(0)
			var_96_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_93_0:addChild(var_96_2, 2)
		end)()

		for iter_95_0, iter_95_1 in pairs(var_95_0) do
			local var_95_5 = ccui.Text:create(iter_95_1 .. ":", FONT_DES, 26)

			var_95_5:setColor(var_95_1[iter_95_0])
			var_95_5:setPositionX(150)
			var_95_5:setPositionY(var_95_4 - iter_95_0 * 70)
			var_95_5:setOpacity(0)
			var_95_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.3 * iter_95_0 + 1), cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveTo:create(0.2, cc.p(150, var_95_4 - (iter_95_0 + 1) * 70)))))
			var_93_0:addChild(var_95_5, 2)

			local var_95_6 = ccui.Text:create(var_95_2[iter_95_0], FONT_DES, 26)

			var_95_6:setColor(var_95_1[iter_95_0])
			var_95_6:setPositionX(400)
			var_95_6:setPositionY(var_95_4 - iter_95_0 * 70)
			var_95_6:setOpacity(0)
			var_95_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.3 * iter_95_0 + 1), cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveTo:create(0.2, cc.p(400, var_95_4 - (iter_95_0 + 1) * 70)))))
			var_93_0:addChild(var_95_6, 2)
		end
	end), cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_93_0:addTouchEventListener(function(arg_98_0, arg_98_1)
		if arg_98_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_93_4 then
			return
		end

		var_93_0:runAction(cc.RemoveSelf:create())
	end)
end

function FastSoulStrengthLayer.showConfirmPop(arg_99_0, arg_99_1, arg_99_2, arg_99_3)
	local var_99_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_Chapter_require.json" or "Pop_Chapter_require.ExportJson")

	global_basic_scene:addChild(var_99_0)

	local var_99_1 = string.len(arg_99_2) * 8 + 10 > 320 and 320 or string.len(arg_99_2) * 8 + 10

	ccui.Helper:seekWidgetByName(var_99_0, "Panel"):setContentSize(GameDisplay.getUiScreenSize())
	ccui.Helper:seekWidgetByName(var_99_0, "description"):setContentSize(var_99_1, 60)
	ccui.Helper:seekWidgetByName(var_99_0, "title"):setString(arg_99_3)
	ccui.Helper:seekWidgetByName(var_99_0, "description"):setString(arg_99_2)

	local var_99_3 = ccui.Helper:seekWidgetByName(var_99_0, "box")

	var_99_3:setPositionY(var_99_3:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_99_4 = ccui.Helper:seekWidgetByName(var_99_0, "button")
	local var_99_5 = ccui.Helper:seekWidgetByName(var_99_0, "image_Q")

	var_99_5:setPositionY(var_99_5:getPositionY() - 60)
	var_99_5:loadTexture("roleimage/role/wuji/" .. model_data[global_get_servant_skin(arg_99_1)].head_image .. ".png")
	ccui.Helper:seekWidgetByName(var_99_0, "Panel"):addTouchEventListener(function(arg_100_0, arg_100_1)
		if arg_100_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_99_0:runAction(cc.RemoveSelf:create())
	end)
	var_99_4:getChildByName("button_label"):setString(L_BUTTON_TEXT.goto_quick_fight)
	var_99_4:addTouchEventListener(function(arg_101_0, arg_101_1)
		if arg_101_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_99_0:runAction(cc.RemoveSelf:create())
		LayerManager:pushInLayer("PopQuickGuaJiSure", {
			exitcallback = function(...)
				arg_99_0:updateShowingCells(arg_99_0.listPanel)
			end
		})
	end)
end

function FastSoulStrengthLayer.createUpLevelAni(arg_103_0, arg_103_1, arg_103_2)
	global_ShowBlockWords(L_FIGHT_CAPACITY .. ":+" .. arg_103_2 - arg_103_1, cc.c3b(1, 181, 253))
end

function FastSoulStrengthLayer:updateShowingCells(arg_104_1)
	local var_104_0, var_104_1 = GetTableViewShowCellIdx(arg_104_1, {
		maxcount = #self.soulidList,
		cellsize = cc.size(var_0_21, var_0_22)
	})

	for iter_104_0 = var_104_0, var_104_1 do
		arg_104_1:updateCellAtIndex(iter_104_0)
	end
end

function FastSoulStrengthLayer:initBg(arg_105_1)
	local var_105_0 = ccui.Layout:create()

	var_105_0:setTouchEnabled(true)
	var_105_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_105_0:setAnchorPoint(cc.p(0, 0))
	var_105_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_105_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_105_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_105_0:setOpacity(0)
	self:addChild(var_105_0, -1)
	self:registerScriptHandler(function(arg_106_0)
		if arg_106_0 == "enter" then
			-- block empty
		elseif arg_106_0 == "exit" then
			var_0_28 = nil
		end
	end)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_107_0)
		self:addChild(arg_107_0, -2)
		arg_107_0:setPositionY(arg_107_0:getPositionY() - GameDisplay.fix_y)

		local var_107_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_107_0:setAnchorPoint(cc.p(0, 0))
		var_107_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_107_0, -1)
		self:init(arg_105_1, initInfo)
		var_105_0:setOpacity(102)
		var_105_0:setTouchEnabled(false)
	end)
end

function FastSoulStrengthLayer.canFastStrength(arg_108_0, arg_108_1)
	if not array_manager:isServantInHangup(arg_108_1.soulid) then
		return false
	end

	return core_manager:getCoreLv(arg_108_1.soulid) < playermodel.grade and core_manager:check_strengthen_point_by_grade(arg_108_1.soulid, 1) > 0 or weapon_manager:canFastStrengthen(arg_108_1.soulid) or component_manager:canFastStrengthen(arg_108_1.soulid)
end
