SoulStrengthLayer = class("SoulStrengthLayer", function()
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
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local core_data = require("data.core_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_17 = 1
local var_0_18 = 2
local var_0_19 = 610
local var_0_20 = 120
local var_0_21 = 660
local var_0_22 = 700
local var_0_23 = 650
local var_0_24 = 750
local var_0_25

function SoulStrengthLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SoulStrengthLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local function var_0_26(arg_3_0, arg_3_1, arg_3_2)
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

function SoulStrengthLayer:init(arg_5_1)
	var_0_25 = self
	self.levelUpCallback = arg_5_1.levelUpCallback
	self.msg = arg_5_1
	self.resetCallback = arg_5_1.resetCallback
	self.curMode = var_0_17

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

	self.sp = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_strength_point")

	local var_5_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_up_money_bottom")

	var_5_1:setPositionX(var_5_1:getPositionX() + var_5_1:getContentSize().width / 2)
	;(function()
		local var_22_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

		for iter_22_0, iter_22_1 in pairs({
			"Button_strengState10",
			"Button_strengState1",
			"Button_strengthMode",
			"Button_holidayMode",
			"Image_up_money_bottom"
		}) do
			local var_22_1 = ccui.Helper:seekWidgetByName(self.rootLayer, iter_22_1)

			var_22_1:setPositionY(var_22_1:getPositionY() + var_22_0)
		end
	end)()

	local var_5_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengthMode")
	local var_5_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_holidayMode")

	var_5_2:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curMode == var_0_17 then
			return
		end

		var_5_3:getChildByName("Label_sleep"):setColor(cc.c3b(151, 168, 186))
		var_5_2:getChildByName("Label_strength"):setColor(cc.c3b(255, 255, 255))

		self.curMode = var_0_17

		self:updateMode()
	end)
	var_5_3:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curMode == var_0_18 then
			return
		end

		var_5_3:getChildByName("Label_sleep"):setColor(cc.c3b(255, 255, 255))
		var_5_2:getChildByName("Label_strength"):setColor(cc.c3b(151, 168, 186))

		self.curMode = var_0_18

		self:updateMode()

		self.uplevelServant = nil
	end)
	var_5_2:getChildByName("Label_strength"):setColor(cc.c3b(255, 255, 255))
	core_manager:getCoreMaxClass(function()
		if not var_0_25 then
			return
		end

		self:updateStrengPoint()
		self:updateMode()
	end)

	self.afkLVBtn = ccui.ImageView:create("SoulStrengthLayer/AfkLevel_btn.png", var_0_0)

	self.afkLVBtn:setAnchorPoint(cc.p(0.5, 0.5))
	self.afkLVBtn:setPosition(520, 800 + GameDisplay.fix_y * 2)
	self.panel:addChild(self.afkLVBtn, 5)

	local var_5_4 = cc.Label:createWithTTF(L_AFKLEVEL_LAYER.xietiao, FONT_NAME, 18)

	var_5_4:setPosition(44, 23)
	self.afkLVBtn:addChild(var_5_4)

	local var_5_5 = cc.Label:createWithTTF(require("controller.role_false_level_manager"):getCurAfkLevel(), FONT_NAME, 20)

	var_5_5:setPosition(cc.p(120, 21))
	var_5_5:setColor(cc.c3b(247, 152, 6))
	self.afkLVBtn:addChild(var_5_5)
	self.afkLVBtn:setTouchEnabled(true)
	self.afkLVBtn:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AfkLevelLayer")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_strength"):setString(L_SOULSTRENGTHLAYER[1])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_13"):setString(L_SOULSTRENGTHLAYER[6])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_39"):setString(L_SOULSTRENGTHLAYER[7])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_streng10"):setString(L_SOULSTRENGTHLAYER[8])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_streng1"):setString(L_SOULSTRENGTHLAYER[9])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_14"):setString(L_SOULSTRENGTHLAYER[10])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_15"):setString(L_SOULSTRENGTHLAYER[11])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_15"):setString(L_SOULSTRENGTHLAYER[11])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_sleep"):setString(L_SOULSTRENGTHLAYER[12])
end

function SoulStrengthLayer:fastStrengthen(arg_27_1, arg_27_2, arg_27_3)
	print("SoulStrengthLayer fastStrengthen")

	self.isover = nil
	self.uplevelServant = arg_27_1.soulid

	if self.levelUpCallback then
		self.levelUpCallback()
	end

	audio_manager:playeffectMusicTest("sound/upgrade")

	if arg_27_1.clickCount < 7 then
		arg_27_1.clickCount = arg_27_1.clickCount + 1
	end

	local var_27_1 = fight_capacity_manager:getSoulFightCapacity(arg_27_1.soulid, "number")

	if arg_27_1.fightCapacityValue ~= var_27_1 then
		self:createUpLevelAni(arg_27_1.fightCapacityValue, var_27_1)
	end

	if self.curMode == var_0_17 then
		if not self.listPanel then
			self:updateStrengPanel()
		end

		self:updateShowingCells(self.listPanel)
	end

	local var_27_2 = core_manager:getCoreLv(arg_27_2)

	if self.msg.servantid then
		AnalyticManager.servant_strengthen_by_equiplayer({
			servantid = arg_27_2,
			strengthen_before_level = arg_27_3,
			strengthen_after_level = var_27_2
		})
	else
		AnalyticManager.servant_strengthen({
			servantid = arg_27_2,
			strengthen_before_level = arg_27_3,
			strengthen_after_level = var_27_2
		})
	end
end

function SoulStrengthLayer:exit()
	self.activeFlag = false

	self.panel:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.9, 0), cc.CallFunc:create(function()
		if self.msg.exitCallback then
			self.msg.exitCallback()
		end

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
		LayerManager:removePopLayer(self.__queueindex)
		AlertManager:check_servant_strenghth()
	end)))
end

function SoulStrengthLayer:updateMode()
	if self.curMode == var_0_17 then
		if not self.listPanel then
			self:updateStrengPanel()
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengthMode"):loadTextures("SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_holidayMode"):loadTextures("SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", var_0_0)
		self:updateShowingCells(self.listPanel)
	end

	if self.curMode == var_0_18 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengthMode"):loadTextures("SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", var_0_0)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_holidayMode"):loadTextures("SoulStrengthLayer/selected_on.png", "SoulStrengthLayer/selected_off.png", "SoulStrengthLayer/selected_on.png", var_0_0)

		if not self.holidayListPanel then
			self:updateHoildayPanel()
		end

		self:updateShowingCells(self.holidayListPanel)
	end

	if self.imgTip then
		self.imgTip:setVisible(self.curMode == var_0_18)
	end

	if self.listPanel then
		self.listPanel:setVisible(self.curMode == var_0_17)
	end

	if self.holidayListPanel then
		self.holidayListPanel:setVisible(self.curMode == var_0_18)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState1"):setVisible(self.curMode == var_0_17)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState10"):setVisible(self.curMode == var_0_17)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_up_money_bottom"):setVisible(self.curMode == var_0_17)
end

function SoulStrengthLayer:updateStrengPoint()
	self.sp:setString(global_trans_number(playermodel.strengthpoint))

	if playermodel.strengthpoint < 0 then
		self.sp:setString("0")
	end
end

function SoulStrengthLayer:updateStrengPanel()
	local core_manager = require("controller.core_manager")
	local var_32_1 = {
		function(arg_33_0, arg_33_1)
			local var_33_0, var_33_1, var_33_2 = core_manager:StrengthenJudge(arg_33_1, arg_33_0)

			return var_33_1
		end,
		function(arg_34_0, arg_34_1)
			return global_trans_number((var_0_3:getBreakOutCostGold(arg_34_1, core_data[playermodel.cores[arg_34_1].coreid].rank + 1)))
		end,
		function()
			return L_SOUL_STRENGTH_PANEL_BTN_TITLE[3]
		end,
		function()
			return L_SOUL_STRENGTH_PANEL_BTN_TITLE[4]
		end,
		function(arg_37_0, arg_37_1)
			return global_trans_number(var_0_3:getBreakOutCostGold(arg_37_1, core_data[playermodel.cores[arg_37_1].coreid].rank + 1) or "100")
		end,
		function()
			return L_SOULSTRENGTHLAYER[4]
		end,
		function()
			return L_SOULSTRENGTHLAYER[5]
		end
	}

	local function var_32_2(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
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
						self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setVisible(false)
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

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
			end
		end

		arg_40_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(arg_40_0.check), cc.DelayTime:create(0.1))))

		function arg_40_0:update()
			local var_50_0 = core_manager:getServantCoreRank(self.soulid)

			self:getChildByName("Image_cell"):getChildByName("Panel_47"):getChildByName("Label_lv"):setString(playermodel.cores[self.soulid].afk_lv or var_0_3:getCoreLv(self.soulid))

			local var_50_1 = global_trans_number(0)
			local var_50_2 = global_trans_number(0)
			local var_50_3 = self:getChildByName("Image_cell"):getChildByName("Button_streng1_" .. self.buttonIndex)

			var_50_3:setBright(true)

			local var_50_4 = fight_capacity_manager:getSoulFightCapacity(self.soulid, "number")

			self:getChildByName("Image_cell"):getChildByName("Label_fightCapacity"):setString(global_trans_number(var_50_4))

			self.fightCapacityValue = var_50_4
			self.level = var_0_3:getCoreLv(self.soulid)

			local var_50_5
			local var_50_6, var_50_7 = core_manager:StrengthenJudge(self.soulid)

			self.res = var_50_6
			self.msg = var_50_7

			if self.strengBtnState == 1 then
				self.strengValue = 1

				var_50_3:loadTextures("SoulStrengthLayer/upgrade.png", "SoulStrengthLayer/upgrade_on.png", "SoulStrengthLayer/upgrade.png", var_0_0)
			else
				var_50_5 = core_manager:check_strengthen_point(self.soulid, 10)
				self.strengValue = var_50_5

				var_50_3:loadTextures("SoulStrengthLayer/upgrade10new.png", "SoulStrengthLayer/upgrade10new_on.png", "SoulStrengthLayer/upgrade10new.png", var_0_0)
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
					var_50_3:getChildByName("Label_cost_value"):setVisible(true)
					var_50_3:getChildByName("Image_22"):setVisible(true)

					if self.strengBtnState == 1 then
						var_50_3:getChildByName("Label_text"):setString(L_SOULSTRENGTHLAYER[2])
					else
						var_50_3:getChildByName("Label_text"):setString(L_SOULSTRENGTHLAYER[3] .. self.strengValue)
					end

					if array_manager:isServantInHangup(self.soulid) and core_manager:getCoreLv(self.soulid) < playermodel.grade and core_manager:check_strengthen_point_by_grade(self.soulid, 1) > 0 then
						var_0_26(var_50_3, true, cc.p(var_50_3:getContentSize().width - 15, var_50_3:getContentSize().height - 10))
					else
						var_0_26(var_50_3, false)
					end

					if core_manager:getCoreLv(self.soulid) < playermodel.grade then
						if self.strengBtnState == 1 then
							var_50_3:loadTextures("SoulStrengthLayer/upgrade.png", "SoulStrengthLayer/upgrade_on.png", "", var_0_0)
						else
							var_50_3:loadTextures("SoulStrengthLayer/upgrade10new.png", "SoulStrengthLayer/upgrade10new_on.png", "", var_0_0)
						end
					elseif self.strengBtnState == 1 then
						var_50_3:loadTextures("SoulStrengthLayer/upgrade_off.png", "SoulStrengthLayer/upgrade_off_on.png", "", var_0_0)
					else
						var_50_3:loadTextures("SoulStrengthLayer/upgrade_off.png", "SoulStrengthLayer/upgrade_off_on.png", "", var_0_0)
					end
				elseif var_50_6 == 2 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)
					var_50_3:getChildByName("Label_text"):setString("")

					if core_manager:check_upgrade_conditions(self.soulid) then
						var_0_26(var_50_3, true, cc.p(var_50_3:getContentSize().width - 15, var_50_3:getContentSize().height - 10))
					else
						var_0_26(var_50_3, false)
					end

					if core_manager:check_upgrade_conditions(self.soulid) then
						var_50_3:loadTextures("SoulStrengthLayer/upclass.png", "SoulStrengthLayer/upclass_on.png", "SoulStrengthLayer/upclass.png", var_0_0)
					else
						var_50_3:loadTextures("SoulStrengthLayer/upclass_off.png", "SoulStrengthLayer/upclass_off_on.png", "SoulStrengthLayer/upclass_off.png", var_0_0)
					end
				elseif var_50_6 == 3 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(true)
					var_50_3:getChildByName("Image_22"):setVisible(true)
					var_50_3:getChildByName("Label_text"):setString(L_SOUL_STRENGTH_PANEL_BTN_TITLE[5])
					var_50_3:loadTextures("SoulStrengthLayer/upgrade_on.png", "SoulStrengthLayer/upgrade_on.png", "SoulStrengthLayer/upgrade_on.png", var_0_0)
					var_0_26(var_50_3, false)
				elseif var_50_6 == 4 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(true)
					var_50_3:getChildByName("Image_22"):setVisible(true)

					if self.strengBtnState == 1 then
						var_50_3:getChildByName("Label_text"):setString(L_SOULSTRENGTHLAYER[2])
					else
						var_50_3:getChildByName("Label_text"):setString(L_SOULSTRENGTHLAYER[3] .. var_50_5)
					end

					var_50_3:loadTextures("SoulStrengthLayer/upgrade_off.png", "SoulStrengthLayer/upgrade_off_on.png", "SoulStrengthLayer/upgrade_off.png", var_0_0)
					var_0_26(var_50_3, false)
				elseif var_50_6 == 5 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)
					var_50_3:getChildByName("Label_text"):setString("")

					if core_manager:check_upgrade_conditions(self.soulid) then
						var_0_26(var_50_3, true, cc.p(var_50_3:getContentSize().width - 15, var_50_3:getContentSize().height - 10))
					else
						var_0_26(var_50_3, false)
					end

					if core_manager:check_upgrade_conditions(self.soulid) then
						var_50_3:loadTextures("SoulStrengthLayer/advance.png", "SoulStrengthLayer/advance.png", "SoulStrengthLayer/advance.png", var_0_0)
					else
						var_50_3:loadTextures("SoulStrengthLayer/advance_off.png", "SoulStrengthLayer/advance_off.png", "SoulStrengthLayer/advance_off.png", var_0_0)
					end
				elseif var_50_6 == 6 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(false)
					var_50_3:getChildByName("Image_22"):setVisible(false)
					var_50_3:getChildByName("Label_text"):setString("")
					var_50_3:loadTextures("SoulStrengthLayer/uplevel_on.png", "SoulStrengthLayer/uplevel_on.png", "SoulStrengthLayer/uplevel_on.png", var_0_0)
					var_0_26(var_50_3, true, cc.p(var_50_3:getContentSize().width - 15, var_50_3:getContentSize().height - 10))
				elseif var_50_6 == 7 then
					var_50_3:getChildByName("Label_cost_value"):setVisible(true)
					var_50_3:getChildByName("Image_22"):setVisible(true)
					var_50_3:getChildByName("Label_text"):setString(global_trans_number(var_32_1[var_50_6](self.strengValue, self.soulid)))
					var_50_3:loadTextures("SoulStrengthLayer/upgrade_off.png", "SoulStrengthLayer/upgrade_off.png", "SoulStrengthLayer/upgrade_off.png", var_0_0)
					var_0_26(var_50_3, false)
				end

				var_50_3:getChildByName("Label_cost_value"):setString(global_trans_number(var_32_1[var_50_6](self.strengValue, self.soulid)))
			end
		end

		local function var_40_2(arg_51_0)
			return 1136 - self.panel:getPositionY() - self.panel:getContentSize().height / 2 * self.panel:getScaleY() + 10 > arg_51_0.y or 1136 - self.panel:getPositionY() + self.panel:getContentSize().height / 2 * self.panel:getScaleY() + 10 < arg_51_0.y
		end

		local var_40_3 = true
		local var_40_4 = arg_40_0:getChildByName("Image_cell"):getChildByName("Button_streng1")

		var_40_4:getChildByName("Image_22"):loadTexture("public/currency/UI_strength_point.png", var_0_0)
		var_40_4:setSwallowTouches(false)
		var_40_4:setName("Button_streng1_" .. arg_40_0.buttonIndex)
		var_40_4:addTouchEventListener(function(arg_52_0, arg_52_1)
			if arg_52_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not var_40_3 then
				return
			end

			var_40_3 = false

			local var_52_0

			var_52_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
				var_40_3 = true

				if var_52_0 then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_52_0)
				end
			end, 0.5, false)

			local var_52_1 = arg_40_0.soulid

			self.curServantid = arg_40_0.soulid

			local var_52_2 = arg_52_0:getTouchEndPosition()

			if math.abs(arg_52_0:getTouchBeganPosition().y - var_52_2.y) > 50 then
				return
			end

			if var_40_2(var_52_2) then
				self:exit()

				return
			end

			if not arg_52_0:isBright() then
				return
			end

			if arg_40_0.res == 1 then
				arg_52_0:setBright(false)

				self.level = var_0_3:getCoreLv(arg_40_0.soulid)
				self.fightCapacity = fight_capacity_manager:getSoulFightCapacity(arg_40_0.soulid, "number")

				local var_52_3 = core_manager:getCoreLv(arg_40_0.soulid)

				core_manager:strengthenCoreToServer(arg_40_0.soulid, arg_40_0.strengValue, function(arg_54_0, arg_54_1)
					if self.activeFlag then
						arg_52_0:setBright(true)

						if arg_54_0 == 1 then
							self:fastStrengthen(arg_40_0, var_52_1, var_52_3)
						else
							if arg_54_1 then
								if arg_54_0 == 4 then
									self:showConfirmPop(arg_40_0.soulid, arg_54_1, L_SOUL_STRENGTH_LEVEL_LACK)
								else
									global_ShowBlockWords(arg_54_1)
								end
							end

							audio_manager:playeffectMusicTest("sound/invalid")
						end
					end
				end)
			end

			local function var_52_4(arg_55_0, arg_55_1)
				arg_55_1 = arg_55_1 or 1

				local var_55_0 = playermodel.cores[arg_55_0].coreid
				local var_55_1 = core_data[playermodel.cores[arg_55_0].coreid].upgrade

				if not core_data[core_data[playermodel.cores[arg_55_0].coreid].upgrade] then
					var_55_1 = var_55_0
				end

				local servant_level_data = require("data.servant_level_data")
				local var_55_3 = core_manager:getCoreLv(arg_55_0)
				local var_55_4 = var_0_3:getStrengthenValue(arg_55_0, var_55_0, var_55_3)
				local var_55_6 = var_0_3:getStrengthenValue(arg_55_0, var_55_1, var_55_3)
				local var_55_7 = "+" .. model_data[servant_data[arg_55_0].modelid].hpFactor * var_55_6 - model_data[servant_data[arg_55_0].modelid].hpFactor * var_55_4
				local var_55_8 = "+" .. model_data[servant_data[arg_55_0].modelid].damageFactor * var_55_6 - model_data[servant_data[arg_55_0].modelid].damageFactor * var_55_4
				local var_55_9 = "+" .. var_55_6 - var_55_4
				local var_55_10 = core_manager:getServantCoreRank(arg_55_0)

				if core_manager:isCoreMax(arg_55_0) then
					LayerManager:pushInLayer("PopServantMaxBreakoutLayer", {
						servantid = arg_55_0
					})
				else
					local var_55_12 = core_manager:getCoreTotalLv(core_data[var_55_0].rank)

					if not servant_data[arg_55_0].role_type then
						-- block empty
					end

					local var_55_14 = core_data[playermodel.cores[arg_55_0].coreid].rank
					local var_55_15 = {
						showIntro = true
					}
					local var_55_16 = {}
					local var_55_17 = {
						newvalue = var_55_12
					}

					if var_55_12 ~= "" then
						var_55_17.name = L_BREAKOUT_HANDEL.Name[1] or L_BREAKOUT_HANDEL.Name[5]
					end

					var_55_16[1] = var_55_17

					local var_55_18 = {
						newvalue = var_55_12 ~= "" and var_55_9 or ""
					}

					if var_55_12 ~= "" then
						var_55_18.name = L_BREAKOUT_HANDEL.Name[2] or ""
					end

					var_55_16[2] = var_55_18

					local var_55_19 = {
						newvalue = var_55_12 ~= "" and var_55_8 or ""
					}

					if var_55_12 ~= "" then
						var_55_19.name = L_BREAKOUT_HANDEL.Name[3] or ""
					end

					var_55_16[3] = var_55_19

					local var_55_20 = {
						newvalue = var_55_12 ~= "" and var_55_7 or ""
					}

					if var_55_12 ~= "" then
						var_55_20.name = L_BREAKOUT_HANDEL.Name[4] or ""
					end

					var_55_16[4] = var_55_20
					var_55_15.labels = var_55_16
					var_55_15.materials = {}
					var_55_15.gold_cost = var_0_3:getBreakOutCostGold(arg_55_0, core_data[playermodel.cores[arg_55_0].coreid].rank + 1)
					var_55_15.goto_back_system_id = self.msg.goto_back_system_id or 200
					var_55_15.servantid = arg_55_0
					var_55_15.up_type = arg_55_1

					local var_55_21 = true
					local var_55_22 = var_0_3:getBreakOutCostMaterial(arg_55_0, var_55_14 + 1)

					for iter_55_0, iter_55_1 in pairs(var_55_22) do
						local var_55_23 = item_manager:getItemNumber(iter_55_1.itemid)

						var_55_15.materials[#var_55_15.materials + 1] = {}
						var_55_15.materials[#var_55_15.materials].ownnum = var_55_23
						var_55_15.materials[#var_55_15.materials].neednum = iter_55_1.num
						var_55_15.materials[#var_55_15.materials].id = iter_55_1.itemid

						if var_55_23 < iter_55_1.num then
							var_55_21 = false
						end
					end

					function var_55_15.surecallback(arg_56_0)
						local var_56_0 = {}

						for iter_56_0 = 1, #var_55_15.materials do
							var_56_0[iter_56_0] = var_55_15.materials[iter_56_0].id
						end

						var_55_21 = true

						for iter_56_1, iter_56_2 in pairs(var_55_22) do
							if iter_56_2.num > item_manager:getItemNumber(iter_56_2.itemid) then
								var_55_21 = false

								break
							end
						end

						if var_55_21 then
							local var_56_1 = core_data[playermodel.cores[arg_55_0].coreid].rank

							core_manager:upgradeCoreToServer(arg_55_0, function(arg_57_0, arg_57_1)
								if arg_57_0 == 1 then
									({})[1] = L_SOULS_CENTRE_LV .. "  " .. var_56_1 .. " → " .. core_data[playermodel.cores[arg_55_0].coreid].rank

									local var_57_0 = {
										cc.c3b(255, 150, 0)
									}

									arg_40_0:update()
									audio_manager:playeffectMusicTest("sound/jinjie")
									arg_56_0(1)
									self:breakAnimation(arg_55_0, var_56_0, arg_55_1)
									self:updateShowingCells(self.listPanel)

									if self.msg.servantid then
										AnalyticManager.servant_upgrade_core_by_equiplayer({
											servantid = arg_55_0,
											grade = core_manager:getServantCoreRank(arg_55_0)
										})
									else
										AnalyticManager.servant_upgrade_core({
											servantid = arg_55_0,
											grade = core_manager:getServantCoreRank(arg_55_0)
										})
									end
								else
									if arg_57_0 == 4 then
										LayerManager:pushInLayer("PopGoLayer", {
											targetlayer = "TopPlotListLayer",
											goto_back_system_id = 201,
											labels = L_BREAKOUT_HANDEL.Button_Msg
										})
									else
										if arg_57_1 then
											global_ShowBlockWords(arg_57_1)
										end

										audio_manager:playeffectMusicTest("sound/invalid")
									end

									arg_56_0()
								end
							end)
						else
							global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
							audio_manager:playeffectMusicTest("sound/invalid")
						end
					end

					LayerManager:pushInLayer("PopServantBreakout", var_55_15)
				end
			end

			if arg_40_0.res == 2 then
				var_52_4(arg_40_0.soulid)
			end

			if arg_40_0.res == 3 then
				LayerManager:switchShowLayer("AfkLevelLayer")
			elseif arg_40_0.res == 4 then
				self:showConfirmPop(arg_40_0.soulid, L_STRENGTHEN_ERR_MSG[8], L_SOUL_STRENGTH_TECH_LACK)
			elseif arg_40_0.res == 5 then
				var_52_4(arg_40_0.soulid, 2)
			elseif arg_40_0.res == 6 then
				LayerManager:pushInLayer("TopPlotListLayer", {
					taskType = TASK_TYPE_CAREER
				})
				arg_52_0:setBright(true)
			elseif arg_40_0.res == 7 then
				global_ShowBlockWords(string.format(L_STRENGTHEN_ERR_MSG[6], arg_40_0.msg))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end)
		arg_40_0:update()

		return arg_40_0
	end

	local function var_32_3(arg_58_0, arg_58_1)
		arg_58_0.clickCount = 0
		arg_58_0.soulid = arg_58_1

		arg_58_0:setOpacity(255)
		arg_58_0:getChildByName("Image_cell"):getChildByName("Image_head"):removeAllChildren()

		arg_58_0:getChildByName("Image_cell"):getChildByName("Image_head").childZOrder = 10000

		arg_58_0:getChildByName("Image_cell"):getChildByName("Image_head"):setTouchEnabled(true)
		arg_58_0:getChildByName("Image_cell"):getChildByName("Image_head"):addTouchEventListener(function(arg_59_0, arg_59_1)
			if arg_59_1 == ccui.TouchEventType.ended then
				if math.abs(arg_59_0:getTouchBeganPosition().x - arg_59_0:getTouchEndPosition().x) >= 25 then
					return
				end

				if math.abs(arg_59_0:getTouchBeganPosition().y - arg_59_0:getTouchEndPosition().y) >= 25 then
					return
				end

				LayerManager:pushInLayer("SoulsLayer", {
					showtype = 6,
					cursoul = arg_58_1,
					exitCallback = function()
						if self.listPanel then
							self:updateShowingCells(self.listPanel)
						end
					end
				})
			end
		end)
		arg_58_0:update()
		arg_58_0:getChildByName("Image_cell"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[arg_58_1].modelid].head_image .. ".png")

		if self:findKeyofValue(self.curFightArray, arg_58_0.soulid) then
			arg_58_0:getChildByName("Image_cell"):getChildByName("Image_fighting_state"):setVisible(true)
		else
			arg_58_0:getChildByName("Image_cell"):getChildByName("Image_fighting_state"):setVisible(false)
		end

		arg_58_0:getChildByName("Image_cell"):getChildByName("Label_name"):setString(servant_data[arg_58_0.soulid].name)
		arg_58_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(arg_58_0.check), cc.DelayTime:create(0.1))))
	end

	if not self.listPanel then
		self.strengBtnState = RoleDefault:getInstance():getIntegerForKey("onceStrengLv", 10)

		;(function()
			self.listPanel = cc.TableView:create(cc.size(var_0_21, var_0_22 + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))

			self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
			self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
			self.listPanel:setPosition(cc.p(-40, 15))
			self.listPanel:setDelegate()
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):addChild(self.listPanel)
			self.listPanel:registerScriptHandler(function(arg_63_0, arg_63_1)
				return var_0_19, var_0_20
			end, cc.TABLECELL_SIZE_FOR_INDEX)
			self.listPanel:registerScriptHandler(function(arg_62_0, arg_62_1, arg_62_2)
				local var_62_0 = arg_62_0:dequeueCell()

				if not var_62_0 then
					var_62_0 = cc.TableViewCell:create()

					var_62_0:setName("cell_" .. arg_62_1)

					local var_62_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):clone()
					local var_62_3 = arg_62_1 < math.ceil(var_0_22 / var_0_20) and (arg_62_1 + 1) * 0.1 or 0

					var_62_2.index = arg_62_1

					var_62_2:getChildByName("Image_cell"):getChildByName("Button_streng1")
					var_62_2:getChildByName("Image_cell"):getChildByName("Panel_47"):setContentSize(cc.size(70, 30))
					var_32_2(var_62_2, self.soulidList[arg_62_1 + 1], var_62_3, arg_62_1)
					var_32_3(var_62_2, self.soulidList[arg_62_1 + 1])
					var_62_2:setPosition(cc.p(85, 0))
					var_62_2:setName("soulCell")
					var_62_2:runLevelUpAni(arg_62_1)
					var_62_0:addChild(var_62_2)
				else
					local var_62_4 = var_62_0:getChildByName("soulCell")

					var_32_3(var_62_4, self.soulidList[arg_62_1 + 1])
					var_62_4:runLevelUpAni(arg_62_1)
					var_62_4:resetLevelUpAni(arg_62_1)
				end

				self:updateStrengPoint()

				return var_62_0
			end, cc.TABLECELL_SIZE_AT_INDEX)
			self.listPanel:registerScriptHandler(function(arg_64_0, arg_64_1)
				return #self.soulidList
			end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
			self.listPanel:reloadData()
		end)()
		;(function()
			local var_65_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState10")
			local var_65_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_strengState1")

			function var_65_0.update()
				self.uplevelServant = nil

				if self.strengBtnState == 1 then
					var_65_1:loadTextures("SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", var_0_0)
					var_65_0:loadTextures("SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", var_0_0)
					var_65_1:getChildByName("Label_streng1"):setColor(cc.c3b(255, 255, 255))
					var_65_0:getChildByName("Label_streng10"):setColor(cc.c3b(163, 180, 223))
				else
					var_65_1:loadTextures("SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", "SoulStrengthLayer/selected_tab_across_off.png", var_0_0)
					var_65_0:loadTextures("SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", "SoulStrengthLayer/selected_tab_across_on.png", var_0_0)
					var_65_1:getChildByName("Label_streng1"):setColor(cc.c3b(163, 180, 223))
					var_65_0:getChildByName("Label_streng10"):setColor(cc.c3b(255, 255, 255))
				end
			end

			var_65_0.update()
			var_65_0:addTouchEventListener(function(arg_67_0, arg_67_1)
				if arg_67_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.strengBtnState == 10 then
					return
				end

				self.strengBtnState = 10

				RoleDefault:getInstance():setIntegerForKey("onceStrengLv", self.strengBtnState)
				var_65_0.update()

				self.changeStrengthenType = true

				self:updateShowingCells(self.listPanel)

				self.changeStrengthenType = nil
			end)
			var_65_1:addTouchEventListener(function(arg_68_0, arg_68_1)
				if arg_68_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.strengBtnState == 1 then
					return
				end

				self.strengBtnState = 1

				RoleDefault:getInstance():setIntegerForKey("onceStrengLv", self.strengBtnState)
				var_65_0.update()

				self.changeStrengthenType = true

				self:updateShowingCells(self.listPanel)

				self.changeStrengthenType = nil
			end)
		end)()
	end
end

function SoulStrengthLayer:updateHoildayPanel()
	local function var_69_0(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
		if arg_70_2 ~= 0 and arg_70_0.index <= 8 then
			arg_70_0:setOpacity(0)
			arg_70_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_70_2), cc.FadeIn:create(0.1)))
		end

		arg_70_0.soulid = arg_70_1
		arg_70_0.buttonIndex = arg_70_3
		arg_70_0.clickCount = 0

		arg_70_0:setContentSize(cc.size(526, 126))

		local var_70_0 = arg_70_0:getChildByName("Image_cell"):getChildByName("Button_useHoliday")

		var_70_0:setName("Button_useHoliday_" .. arg_70_0.buttonIndex)

		arg_70_0:getChildByName("Image_cell"):getChildByName("Image_head").childZOrder = 10000

		arg_70_0:getChildByName("Image_cell"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[arg_70_1].modelid].head_image .. ".png")
		arg_70_0:getChildByName("Image_cell"):getChildByName("Label_name"):setString(servant_data[arg_70_0.soulid].name)

		function arg_70_0.update()
			local var_71_0 = core_data[playermodel.cores[arg_70_0.soulid].coreid].rank
			local var_71_1

			if playermodel.weaponId[arg_70_0.soulid] then
				var_71_1 = playermodel.items[playermodel.weaponId[arg_70_0.soulid]].weapon_attr.level
			end

			arg_70_0.level = var_0_3:getCoreLv(arg_70_0.soulid)

			arg_70_0:getChildByName("Image_cell"):getChildByName("Label_lv"):setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
			arg_70_0:getChildByName("Image_cell"):getChildByName("Label_lv"):setString(arg_70_0.level)

			local var_71_2 = global_trans_number(0)
			local var_71_3 = global_trans_number(0)
			local var_71_4 = arg_70_0:getChildByName("Image_cell"):getChildByName("Button_useHoliday_" .. arg_70_0.buttonIndex)

			var_71_4:setBright(true)

			if arg_70_0.level == 0 and var_71_0 == 0 and (not var_71_1 or var_71_1 == 0) then
				var_71_4:loadTextures("SoulStrengthLayer/hoilday_off.png", "SoulStrengthLayer/hoilday_off.png", "SoulStrengthLayer/hoilday_off.png", var_0_0)
			else
				var_71_4:loadTextures("SoulStrengthLayer/hoilday_normal.png", "SoulStrengthLayer/hoilday_on.png", "SoulStrengthLayer/hoilday_off.png", var_0_0)
			end

			arg_70_0:getChildByName("Image_cell"):getChildByName("Label_breakLimitCount"):setString(var_71_0)

			local var_71_5 = core_manager:getServantCoreRank(arg_70_0.soulid)

			arg_70_0:getChildByName("Image_cell"):getChildByName("Image_breakoutIcon"):loadTexture("public/rolebg/breakout_" .. var_71_5 .. ".png", var_0_0)
			arg_70_0:getChildByName("Image_cell"):getChildByName("Image_breakoutIcon"):setVisible(var_71_5 ~= 0)
			arg_70_0:getChildByName("Image_cell"):getChildByName("Label_weapon"):setString(0)

			if playermodel.weaponId[arg_70_0.soulid] then
				arg_70_0:getChildByName("Image_cell"):getChildByName("Label_weapon"):setString(playermodel.items[playermodel.weaponId[arg_70_0.soulid]].weapon_attr.level)
			end
		end

		var_70_0:addTouchEventListener(function(arg_72_0, arg_72_1)
			if arg_72_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_72_0

			if playermodel.weaponId[arg_70_0.soulid] then
				var_72_0 = playermodel.items[playermodel.weaponId[arg_70_0.soulid]].weapon_attr.level
			end

			if core_manager:getServantCoreRank(arg_70_0.soulid) == 0 and arg_70_0.level == 0 and (not var_72_0 or var_72_0 == 0) then
				global_ShowBlockWords(L_SOUL_STRENGTH_HOLIDAY_FORBID)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				self:showHoildayPop(arg_70_0.soulid, function()
					self:updateShowingCells(self.holidayListPanel)
					self:updateStrengPoint()
				end)
			end
		end)
	end

	local function var_69_1(arg_74_0, arg_74_1)
		arg_74_0.clickCount = 0
		arg_74_0.soulid = arg_74_1

		arg_74_0:setOpacity(255)
		arg_74_0:getChildByName("Image_cell"):getChildByName("Image_head"):removeAllChildren()

		arg_74_0:getChildByName("Image_cell"):getChildByName("Image_head").childZOrder = 10000

		arg_74_0:getChildByName("Image_cell"):getChildByName("Image_head"):setTouchEnabled(true)
		arg_74_0:getChildByName("Image_cell"):getChildByName("Image_head"):addTouchEventListener(function(arg_75_0, arg_75_1)
			if arg_75_1 == ccui.TouchEventType.ended then
				if math.abs(arg_75_0:getTouchBeganPosition().x - arg_75_0:getTouchEndPosition().x) >= 25 then
					return
				end

				if math.abs(arg_75_0:getTouchBeganPosition().y - arg_75_0:getTouchEndPosition().y) >= 25 then
					return
				end

				LayerManager:pushInLayer("SoulsLayer", {
					showtype = 6,
					cursoul = arg_74_1
				})
			end
		end)

		self.index = nil

		arg_74_0:update()
		arg_74_0:getChildByName("Image_cell"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[arg_74_1].modelid].head_image .. ".png")
		arg_74_0:getChildByName("Image_cell"):getChildByName("Label_name"):setString(servant_data[arg_74_0.soulid].name)
	end

	if not self.holidayListPanel then
		(function()
			self.imgTip = ccui.ImageView:create("SoulStrengthLayer/img_tip_holiday.png", var_0_0)

			local var_80_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

			self.imgTip:setPosition(var_80_0:getContentSize().width / 2, var_80_0:getContentSize().height - self.imgTip:getContentSize().height / 2 - 85)
			var_80_0:addChild(self.imgTip)
		end)()
		;(function()
			self.holidayListPanel = cc.TableView:create(cc.size(var_0_23, var_0_24 + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT - self.imgTip:getContentSize().height))

			self.holidayListPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
			self.holidayListPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
			self.holidayListPanel:setPosition(cc.p(12, 26))
			self.holidayListPanel:setDelegate()
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):addChild(self.holidayListPanel)
			self.holidayListPanel:registerScriptHandler(function(arg_78_0, arg_78_1)
				return var_0_19, var_0_20
			end, cc.TABLECELL_SIZE_FOR_INDEX)
			self.holidayListPanel:registerScriptHandler(function(arg_77_0, arg_77_1)
				local var_77_0 = arg_77_0:dequeueCell()

				if not var_77_0 then
					var_77_0 = cc.TableViewCell:create()

					local var_77_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_HolidayCell"):clone()

					var_77_1.index = arg_77_1

					var_69_0(var_77_1, self.soulidList[arg_77_1 + 1], arg_77_1 < math.ceil(var_0_22 / var_0_20) and (arg_77_1 + 1) * 0.1 or 0, arg_77_1)
					var_69_1(var_77_1, self.soulidList[arg_77_1 + 1])
					var_77_1:setPosition(cc.p(5, 0))
					var_77_1:setName("soulCell")
					var_77_0:addChild(var_77_1)
				else
					var_69_1(var_77_0:getChildByName("soulCell"), self.soulidList[arg_77_1 + 1])
				end

				return var_77_0
			end, cc.TABLECELL_SIZE_AT_INDEX)
			self.holidayListPanel:registerScriptHandler(function(arg_79_0, arg_79_1)
				return #self.soulidList
			end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
			self.holidayListPanel:reloadData()
		end)()
	end
end

function SoulStrengthLayer:showHoildayPop(arg_81_1, arg_81_2)
	LayerManager:pushInLayer("PopHolidayConfirmLayer", {
		servantid = arg_81_1,
		sureCallback = arg_81_2,
		goto_back_system_id = self.msg.goto_back_system_id,
		resetCallback = self.resetCallback
	})
end

function SoulStrengthLayer.findKeyofValue(arg_82_0, arg_82_1, arg_82_2)
	local var_82_0

	if arg_82_1 then
		for iter_82_0, iter_82_1 in pairs(arg_82_1) do
			if iter_82_1 == arg_82_2 then
				var_82_0 = iter_82_0

				return iter_82_0
			end
		end
	end

	return var_82_0
end

local function var_0_28(arg_83_0, arg_83_1)
	local var_83_0 = ccui.ImageView:create("public/panelbg/servant_break_out_bg.png", var_0_0)
	local var_83_1 = ccui.ImageView:create("public/panelbg/servant_break_lvl_bg.png", var_0_0)

	var_83_1:setPosition(cc.p(320, 228))
	var_83_0:addChild(var_83_1)

	local var_83_2 = ccui.ImageView:create("public/panelbg/servant_break_skl_bg.png", var_0_0)

	var_83_2:setAnchorPoint(cc.p(0, 0))
	var_83_2:setPosition(cc.p(8, 12))
	var_83_0:addChild(var_83_2)

	local var_83_3 = cc.Label:createWithTTF(L_SHOW_ROLE_INFO_1[1], FONT_NAME, 20)

	var_83_3:setPosition(cc.p(106, 69))
	var_83_1:addChild(var_83_3)

	local var_83_4 = cc.Label:createWithTTF(L_SHOW_ROLE_INFO_1[2], FONT_NAME, 20)

	var_83_4:setPosition(cc.p(106, 19))
	var_83_1:addChild(var_83_4)

	local var_83_5 = var_0_3:getCoreLv(arg_83_0)

	print()

	local var_83_6 = var_0_3:getStrengthenValue(arg_83_0, playermodel.cores[arg_83_0].coreid, var_83_5)
	local var_83_7 = cc.Label:createWithTTF(model_data[servant_data[arg_83_0].modelid].hpFactor * var_83_6, FONT_NAME, 20)

	var_83_7:setPosition(cc.p(205, 69))
	var_83_1:addChild(var_83_7)

	local var_83_8 = cc.Label:createWithTTF(model_data[servant_data[arg_83_0].modelid].damageFactor * var_83_6, FONT_NAME, 20)

	var_83_8:setPosition(cc.p(205, 19))
	var_83_1:addChild(var_83_8)

	local var_83_10 = var_0_3:getStrengthenValue(arg_83_0, (not core_data[core_data[playermodel.cores[arg_83_0].coreid].upgrade] or nil) and playermodel.cores[arg_83_0].coreid, var_83_5)
	local var_83_11 = cc.Label:createWithTTF(model_data[servant_data[arg_83_0].modelid].hpFactor * var_83_10, FONT_NAME, 20)

	var_83_11:setPosition(cc.p(445, 69))
	var_83_11:setColor(cc.c3b(255, 201, 13))
	var_83_1:addChild(var_83_11)

	local var_83_12 = cc.Label:createWithTTF(model_data[servant_data[arg_83_0].modelid].damageFactor * var_83_10, FONT_NAME, 20)

	var_83_12:setPosition(cc.p(445, 19))
	var_83_12:setColor(cc.c3b(255, 201, 13))
	var_83_1:addChild(var_83_12)

	local var_83_13 = cc.Label:createWithTTF("+" .. model_data[servant_data[arg_83_0].modelid].hpFactor * var_83_10 - model_data[servant_data[arg_83_0].modelid].hpFactor * var_83_6, FONT_NAME, 15)

	var_83_13:setPosition(cc.p(325, 75))
	var_83_13:setColor(cc.c3b(255, 201, 13))
	var_83_1:addChild(var_83_13)

	local var_83_14 = cc.Label:createWithTTF("+" .. model_data[servant_data[arg_83_0].modelid].damageFactor * var_83_10 - model_data[servant_data[arg_83_0].modelid].damageFactor * var_83_6, FONT_NAME, 15)

	var_83_14:setPosition(cc.p(325, 25))
	var_83_14:setColor(cc.c3b(255, 201, 13))
	var_83_1:addChild(var_83_14)

	if arg_83_1 == 1 then
		local var_83_15 = var_0_3:getServantCoreRank(arg_83_0) + 1

		if not model_data[servant_data[arg_83_0].modelid]["ex_" .. var_83_15] then
			var_83_15 = var_83_15 - 1
		end

		local var_83_16 = model_data[servant_data[arg_83_0].modelid]["ex_" .. var_83_15]
		local var_83_17 = ccui.ImageView:create("skill_new/skill/ex" .. var_83_15 .. ".png", var_0_0)

		var_83_17:setPosition(cc.p(70, 46))
		var_83_17:setScale(0.8)
		var_83_2:addChild(var_83_17)

		local var_83_19 = ccui.ImageView:create((var_83_15 == 1 or nil) and "public/button/get_skill.png", var_0_0)

		var_83_19:setPosition(cc.p(10, 108))
		var_83_19:setScale(1.25)
		var_83_17:addChild(var_83_19)

		if var_83_16 then
			local var_83_20 = cc.Label:createWithTTF(total_skill_data[var_83_16].name, FONT_DES, 20)

			var_83_20:setAnchorPoint(cc.p(0, 0.5))
			var_83_20:setColor(cc.c3b(255, 201, 13))
			var_83_20:setPosition(cc.p(125, 88))
			var_83_2:addChild(var_83_20)

			local var_83_21 = RichTextPro:create()

			var_83_21:setMaxWidth(350)
			var_83_21:setSize(20)
			var_83_21:setLineSpace(0)
			var_83_21:setText((transSkillDesToRichText(total_skill_data[var_83_16].description)))
			var_83_21:setName("richText")
			var_83_21:setPosition(cc.p(125, 67))
			var_83_2:addChild(var_83_21)
		else
			var_83_2:setVisible(false)
		end
	else
		var_83_2:setVisible(false)
		var_83_1:setPositionY(var_83_1:getPositionY() - 120)
	end

	return var_83_0
end

function SoulStrengthLayer.breakAnimation(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	local var_84_0 = ccui.Layout:create()

	var_84_0:setTouchEnabled(true)
	var_84_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_84_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_84_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_84_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_84_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_84_0:setBackGroundColorOpacity(180)
	global_basic_scene:addChild(var_84_0, 999)

	local var_84_1 = ccui.ImageView:create("roleimage/role1/" .. model_data[global_get_servant_skin(arg_84_1)].cute_role .. ".png")

	var_84_1:setPosition(cc.p(var_84_0:getContentSize().width / 2 + 15, var_84_0:getContentSize().height / 2 + 50))
	var_84_0:addChild(var_84_1, 100)
	var_84_1:setScale(0.7)

	local var_84_2 = false

	var_84_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		var_84_2 = true
	end), cc.CallFunc:create(function()
		local var_86_0 = L2Skeleton:create("spine/ui/upgrade/up.json", "spine/ui/upgrade/up.atlas")

		var_86_0:refreshSkeleton()
		var_86_0.skeletonAnimation:setPositionX(var_84_0:getContentSize().width / 2 + 20)
		var_86_0.skeletonAnimation:setPositionY(var_84_0:getContentSize().height / 2)
		var_86_0:setName("upSpine")
		var_86_0:setScale(2)
		var_86_0:play("tupo", false)
		var_84_0:addChild(var_86_0, 150)

		local var_86_1 = L2Skeleton:create("spine/ui/upgrade/down.json", "spine/ui/upgrade/down.atlas")

		var_86_1:refreshSkeleton()
		var_86_1.skeletonAnimation:setPositionX(var_84_0:getContentSize().width / 2 + 20)
		var_86_1.skeletonAnimation:setPositionY(var_84_0:getContentSize().height / 2 - 80)
		var_86_1:setName("downSpine")
		var_86_1:setScale(1.5)
		var_86_1:play("tupo", false)
		var_84_0:addChild(var_86_1, 50)
	end), cc.DelayTime:create(2.3), cc.CallFunc:create(function()
		local var_85_0 = ccui.ImageView:create("SoulStrengthLayer/light.png", var_0_0)

		var_85_0:setPosition(cc.p(var_84_0:getContentSize().width / 2, var_84_0:getContentSize().height / 2))
		var_85_0:setScale(0.1)
		var_84_0:addChild(var_85_0, 999)
		var_85_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 100), cc.RemoveSelf:create()))
		var_84_1:setVisible(false)
	end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		local var_87_0 = var_84_0:getChildByName("upSpine")
		local var_87_1 = var_84_0:getChildByName("downSpine")

		if var_87_0 then
			var_87_0:setVisible(false)
		end

		if var_87_1 then
			var_87_1:setVisible(false)
		end

		local var_87_2 = ccui.ImageView:create("AchievementPop/achievement_bg.png", var_0_0)

		var_87_2:setPosition(cc.p(var_84_0:getContentSize().width / 2, var_84_0:getContentSize().height / 2 + 100))
		var_87_2:setScale(0, 1)
		var_87_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1), cc.CallFunc:create(function()
			local var_88_0 = cc.Label:createWithTTF((arg_84_3 == 1 or nil) and (L_BREAKOUT_HANDEL.Success or L_BREAKOUT_HANDEL.advance_success), FONT_NAME, 30)

			var_88_0:setColor(cc.c3b(0, 0, 0))
			var_88_0:setPosition(cc.p(var_87_2:getContentSize().width / 2, var_87_2:getContentSize().height / 2))
			var_87_2:addChild(var_88_0, 999)

			local var_88_1 = var_0_28(arg_84_1, arg_84_3)

			var_88_1:setPosition(cc.p(var_84_0:getContentSize().width / 2, var_84_0:getContentSize().height / 2 + (arg_84_3 ~= 1 and -40 or -120)))
			var_84_0:addChild(var_88_1)
		end)))
		var_84_0:addChild(var_87_2, 999)
	end), cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_84_0:addTouchEventListener(function(arg_90_0, arg_90_1)
		if arg_90_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_84_2 then
			return
		end

		var_84_0:runAction(cc.RemoveSelf:create())
	end)
end

function SoulStrengthLayer:showBreakLimitAni(arg_91_1, arg_91_2, arg_91_3)
	audio_manager:playeffectMusicTest("sound/upgrade_rank")

	local var_91_0 = ccui.Layout:create()

	var_91_0:setTouchEnabled(true)
	var_91_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_91_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_91_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_91_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_91_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_91_0:setBackGroundColorOpacity(180)
	global_basic_scene:addChild(var_91_0, 999)

	local var_91_1 = L2Skeleton:create("spine/ui/servant_break_limit/e_level_break_limit.json", "spine/ui/servant_break_limit/e_level_break_limit.atlas")

	var_91_1:refreshSkeleton()
	var_91_1.skeletonAnimation:setPosition(cc.p(320, 600))
	var_91_1:play("e_tupo", false)
	var_91_0:addChild(var_91_1)
	self:breakAnimation(arg_91_3, var_91_0)

	local var_91_3 = ccui.Text:create(arg_91_2.text .. arg_91_2.oldBreakNum, FONT_BUTTON, 30)

	var_91_3:setColor(cc.c3b(255, 150, 0))
	var_91_3:setOpacity(0)
	var_91_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.FadeIn:create(0), cc.DelayTime:create(0.38), cc.FadeOut:create(0), cc.DelayTime:create(0.06), cc.FadeIn:create(0), cc.CallFunc:create(function()
		var_91_3:setString(arg_91_2.text .. arg_91_2.curBreakNum)
	end), cc.ScaleTo:create(0.2, 1.2), cc.DelayTime:create(0.2), cc.FadeOut:create(0.1), cc.RemoveSelf:create()))
	var_91_3:setPositionX(320)
	var_91_3:setPositionY(630)
	var_91_0:addChild(var_91_3, 2)

	local var_91_4 = false

	var_91_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_91_4 = true
	end), cc.CallFunc:create(function()
		local var_93_0 = {}
		local var_93_1 = {}
		local var_93_2 = {}

		while #arg_91_1[1] > 0 do
			var_93_0[#var_93_0 + 1] = arg_91_1[1][#arg_91_1[1]]
			var_93_2[#var_93_2 + 1] = arg_91_1[2][#arg_91_1[1]]
			var_93_1[#var_93_1 + 1] = arg_91_1[3][#arg_91_1[1]]
		end

		local var_93_4 = 850

		;(function()
			local var_94_0 = ccui.Text:create(arg_91_2.text .. ":", FONT_DES, 26)

			var_94_0:setColor(cc.c3b(255, 150, 0))
			var_94_0:setPositionX(150)
			var_94_0:setPositionY(var_93_4 - 80)
			var_94_0:setOpacity(0)
			var_94_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_91_0:addChild(var_94_0, 2)

			local var_94_1 = ccui.Text:create(arg_91_2.oldBreakNum, FONT_DES, 26)

			var_94_1:setColor(cc.c3b(255, 150, 0))
			var_94_1:setPositionX(350)
			var_94_1:setPositionY(var_93_4 - 80)
			var_94_1:setOpacity(0)
			var_94_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_91_0:addChild(var_94_1, 2)

			local var_94_2 = ccui.Text:create(arg_91_2.curBreakNum, FONT_DES, 26)

			var_94_2:setColor(cc.c3b(255, 150, 0))
			var_94_2:setPositionX(500)
			var_94_2:setPositionY(var_93_4 - 80)
			var_94_2:setOpacity(0)
			var_94_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
			var_91_0:addChild(var_94_2, 2)
		end)()

		for iter_93_0, iter_93_1 in pairs(var_93_0) do
			local var_93_5 = ccui.Text:create(iter_93_1 .. ":", FONT_DES, 26)

			var_93_5:setColor(var_93_1[iter_93_0])
			var_93_5:setPositionX(150)
			var_93_5:setPositionY(var_93_4 - iter_93_0 * 70)
			var_93_5:setOpacity(0)
			var_93_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.3 * iter_93_0 + 1), cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveTo:create(0.2, cc.p(150, var_93_4 - (iter_93_0 + 1) * 70)))))
			var_91_0:addChild(var_93_5, 2)

			local var_93_6 = ccui.Text:create(var_93_2[iter_93_0], FONT_DES, 26)

			var_93_6:setColor(var_93_1[iter_93_0])
			var_93_6:setPositionX(400)
			var_93_6:setPositionY(var_93_4 - iter_93_0 * 70)
			var_93_6:setOpacity(0)
			var_93_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.3 * iter_93_0 + 1), cc.Spawn:create(cc.FadeIn:create(0.3), cc.MoveTo:create(0.2, cc.p(400, var_93_4 - (iter_93_0 + 1) * 70)))))
			var_91_0:addChild(var_93_6, 2)
		end
	end), cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_91_0:addTouchEventListener(function(arg_96_0, arg_96_1)
		if arg_96_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_91_4 then
			return
		end

		var_91_0:runAction(cc.RemoveSelf:create())
	end)
end

function SoulStrengthLayer.showConfirmPop(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	local var_97_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_Chapter_require.json" or "Pop_Chapter_require.ExportJson")

	global_basic_scene:addChild(var_97_0)

	local var_97_2 = string.len(arg_97_2) * 8 + 10 > 320 and 320 or string.len(arg_97_2) * 8 + 10

	ccui.Helper:seekWidgetByName(var_97_0, "Panel"):setContentSize(GameDisplay.getUiScreenSize())
	ccui.Helper:seekWidgetByName(var_97_0, "description"):setContentSize(400, 200)
	ccui.Helper:seekWidgetByName(var_97_0, "description"):setPosition(360, 0)
	ccui.Helper:seekWidgetByName(var_97_0, "title"):setString(arg_97_3)
	ccui.Helper:seekWidgetByName(var_97_0, "description"):setString(arg_97_2)

	local var_97_3 = ccui.Helper:seekWidgetByName(var_97_0, "box")

	var_97_3:setPositionY(var_97_3:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_97_4 = ccui.Helper:seekWidgetByName(var_97_0, "button")
	local var_97_5 = ccui.Helper:seekWidgetByName(var_97_0, "image_Q")

	var_97_5:setPositionY(var_97_5:getPositionY() - 60)
	var_97_5:loadTexture("roleimage/role/wuji/" .. model_data[global_get_servant_skin(arg_97_1)].head_image .. ".png")
	ccui.Helper:seekWidgetByName(var_97_0, "Panel"):addTouchEventListener(function(arg_98_0, arg_98_1)
		if arg_98_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_97_0:runAction(cc.RemoveSelf:create())
	end)
	var_97_4:getChildByName("button_label"):setString(L_BUTTON_TEXT.goto_quick_fight)
	var_97_4:addTouchEventListener(function(arg_99_0, arg_99_1)
		if arg_99_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_97_0:runAction(cc.RemoveSelf:create())
		LayerManager:pushInLayer("PopQuickGuaJiSure", {
			exitcallback = function(...)
				arg_97_0:updateShowingCells(arg_97_0.listPanel)
			end
		})
	end)
end

function SoulStrengthLayer.createUpLevelAni(arg_101_0, arg_101_1, arg_101_2)
	global_ShowBlockWords(L_FIGHT_CAPACITY .. ":+" .. arg_101_2 - arg_101_1, cc.c3b(1, 181, 253))
end

function SoulStrengthLayer:updateShowingCells(arg_102_1)
	local var_102_0, var_102_1 = GetTableViewShowCellIdx(arg_102_1, {
		maxcount = #self.soulidList,
		cellsize = cc.size(var_0_19, var_0_20)
	})

	for iter_102_0 = var_102_0, var_102_1 do
		arg_102_1:updateCellAtIndex(iter_102_0)
	end
end

function SoulStrengthLayer:initBg(arg_103_1)
	local var_103_0 = ccui.Layout:create()

	var_103_0:setTouchEnabled(true)
	var_103_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_103_0:setAnchorPoint(cc.p(0, 0))
	var_103_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_103_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_103_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_103_0:setOpacity(0)
	self:addChild(var_103_0, -1)
	self:registerScriptHandler(function(arg_104_0)
		if arg_104_0 == "enter" then
			-- block empty
		elseif arg_104_0 == "exit" then
			var_0_25 = nil
		end
	end)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_105_0)
		self:addChild(arg_105_0, -2)
		arg_105_0:setPositionY(arg_105_0:getPositionY() - GameDisplay.fix_y)

		local var_105_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_105_0:setAnchorPoint(cc.p(0, 0))
		var_105_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_105_0, -1)
		self:init(arg_103_1, initInfo)
		var_103_0:setOpacity(102)
		var_103_0:setTouchEnabled(false)
	end)
end
