PvpResultLayer = class("PvpResultLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local monsterdata = require("data.monsterdata")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")
local var_0_5 = 0.0125
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local activity_return_manager = require("controller.activity_return_manager")

function PvpResultLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PvpResultLayer.new()

	var_2_0:initBg(arg_2_1, initInfo)

	return var_2_0
end

function PvpResultLayer.fullScreen(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:setContentSize(GameDisplay.getScreenSize())
	arg_3_1:setPositionY(arg_3_1:getPositionY() - GameDisplay.fix_y)
	arg_3_2:setPositionY(arg_3_2:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
end

function PvpResultLayer:init(arg_4_1)
	self.msg = arg_4_1

	;(function(...)
		if self.msg.rankChange and self.msg.rankChange.enemyArray and self.msg.fightData.enemies then
			for iter_5_0, iter_5_1 in pairs(self.msg.rankChange.enemyArray) do
				local var_5_0 = iter_5_1.model

				for iter_5_2, iter_5_3 in pairs(servant_data) do
					if iter_5_3.classtype == 1 then
						if iter_5_3.modelid == var_5_0 then
							-- block empty
						else
							local var_5_1 = 1

							while iter_5_3["modelid" .. var_5_1] do
								if iter_5_3["modelid" .. var_5_1] == var_5_0 then
									self.msg.rankChange.enemyArray[iter_5_0].model = iter_5_3.modelid
								end

								var_5_1 = var_5_1 + 1
							end
						end

						if iter_5_3.model_oc == var_5_0 then
							self.msg.rankChange.enemyArray[iter_5_0].model = iter_5_3.modelid
						end
					end
				end
			end

			local function var_5_2(arg_6_0)
				for iter_6_0, iter_6_1 in pairs(servant_data) do
					if iter_6_1.classtype == 1 then
						if iter_6_1.modelid == arg_6_0 then
							return arg_6_0
						else
							local var_6_0 = 1

							while iter_6_1["modelid" .. var_6_0] do
								if iter_6_1["modelid" .. var_6_0] == arg_6_0 then
									return iter_6_1.modelid
								end

								var_6_0 = var_6_0 + 1
							end
						end

						if iter_6_1.model_oc == arg_6_0 then
							return iter_6_1.modelid
						end
					end
				end

				return arg_6_0
			end

			for iter_5_4, iter_5_5 in pairs({
				"heal",
				"suffer",
				"damage",
				"effective_heal"
			}) do
				local var_5_3 = {}

				for iter_5_6, iter_5_7 in pairs(self.msg.fightData.enemies[iter_5_5]) do
					var_5_3[var_5_2(iter_5_6)] = iter_5_7
				end

				for iter_5_8, iter_5_9 in pairs(var_5_3) do
					self.msg.fightData.enemies[iter_5_5][iter_5_8] = iter_5_9
				end
			end
		end
	end)()

	local var_4_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_pvp_settlement_New.json" or "Pop_pvp_settlement_New.ExportJson")

	var_4_0:setBackGroundColorOpacity(0)
	self:addChild(var_4_0)

	self.panelresult = ccui.Helper:seekWidgetByName(var_4_0, "Panel_Result")
	self.resultimg = ccui.Helper:seekWidgetByName(var_4_0, "result_img")
	self.timelabel = ccui.Helper:seekWidgetByName(var_4_0, "Label_fight_time")
	self.honorimg = ccui.Helper:seekWidgetByName(var_4_0, "horor_img")
	self.honorlabel = ccui.Helper:seekWidgetByName(var_4_0, "Label_horor")
	self.items = ccui.Helper:seekWidgetByName(var_4_0, "infoitems")
	self.mypanel = ccui.Helper:seekWidgetByName(var_4_0, "Panel_my")
	self.enemypanel = ccui.Helper:seekWidgetByName(var_4_0, "Panel_enemy")
	self.imgCatchUp = ccui.ImageView:create("public/panelbg/img_getup.png", var_0_0)

	self.imgCatchUp:setPosition(self.honorlabel:getPositionX() + 100, self.honorlabel:getPositionY())
	self.honorlabel:getParent():addChild(self.imgCatchUp)
	var_4_0:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.panelresult:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.1), cc.CallFunc:create(function()
			if self.__queueindex then
				LayerManager:removePopLayer(self.__queueindex)
			else
				self:runAction(cc.RemoveSelf:create())
			end

			if arg_4_1.cancelCallback then
				arg_4_1.cancelCallback()
			end

			if arg_4_1.exitcallback then
				arg_4_1.exitcallback()
			end
		end)))
	end)
	self.panelresult:setScaleY(0)
	self.panelresult:setAnchorPoint(cc.p(0.5, 0.5))
	self.panelresult:setPosition(cc.p(320, 568))
	self.panelresult:runAction(cc.Sequence:create(cc.Sequence:create(cc.ScaleTo:create(0.2, 1))))

	local var_4_1 = arg_4_1.fighttime or math.floor(FightManager.getFightTimeStatistics())

	self.timelabel:setString(L_PVP_RESULT_TIME .. string.format("%02d:%02d", math.fmod(math.floor(var_4_1 / 60), 60), math.fmod(var_4_1, 60)))
	self.timelabel:setVisible(arg_4_1.isTimeVisible ~= false)

	if arg_4_1.fightResult == "fail" then
		self.resultimg:loadTexture("PvpSettlement/font.png", var_0_0)
	else
		self.resultimg:loadTexture("PvpSettlement/pvp_title.png", var_0_0)
	end

	local var_4_2 = {
		heal = 0,
		effective_heal = 0,
		damage = 0,
		suffer = 0
	}
	local var_4_6 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_2) do
		for iter_4_2, iter_4_3 in pairs(arg_4_1.fightData.players[iter_4_0]) do
			if not var_4_6[iter_4_2] then
				var_4_6[iter_4_2] = {}
				var_4_6[iter_4_2].modelid = iter_4_2
			end

			var_4_6[iter_4_2][iter_4_0] = iter_4_3
		end
	end

	local var_4_7 = {}

	for iter_4_4, iter_4_5 in pairs(var_4_2) do
		for iter_4_6, iter_4_7 in pairs(arg_4_1.fightData.enemies[iter_4_4]) do
			if not var_4_7[iter_4_6] then
				var_4_7[iter_4_6] = {}
				var_4_7[iter_4_6].modelid = iter_4_6
			end

			var_4_7[iter_4_6][iter_4_4] = iter_4_7
		end
	end

	local var_4_8 = 1
	local var_4_9 = {
		heal = 1,
		damage = 1,
		suffer = 1
	}

	for iter_4_8, iter_4_9 in pairs(var_4_6) do
		for iter_4_10, iter_4_11 in pairs(iter_4_9) do
			if var_4_9[iter_4_10] and var_4_8 < iter_4_11 then
				var_4_8 = iter_4_11
			end
		end
	end

	for iter_4_12, iter_4_13 in pairs(var_4_9) do
		var_4_9[iter_4_12] = var_4_8
	end

	local var_4_10 = 1
	local var_4_11 = {
		heal = 1,
		damage = 1,
		suffer = 1
	}

	for iter_4_14, iter_4_15 in pairs(var_4_7) do
		for iter_4_16, iter_4_17 in pairs(iter_4_15) do
			if var_4_9[iter_4_16] and var_4_10 < iter_4_17 then
				var_4_10 = iter_4_17
			end
		end
	end

	for iter_4_18, iter_4_19 in pairs(var_4_11) do
		var_4_11[iter_4_18] = var_4_10
	end

	for iter_4_20, iter_4_21 in pairs(var_4_6) do
		if not iter_4_21.suffer then
			var_4_6[iter_4_20].suffer = 0
		end

		if not iter_4_21.damage then
			var_4_6[iter_4_20].damage = 0
		end

		if not iter_4_21.heal then
			var_4_6[iter_4_20].heal = 0
		end

		if not iter_4_21.effective_heal then
			var_4_6[iter_4_20].effective_heal = 0
		end
	end

	for iter_4_22, iter_4_23 in pairs(var_4_7) do
		if not iter_4_23.suffer then
			var_4_7[iter_4_22].suffer = 0
		end

		if not iter_4_23.damage then
			var_4_7[iter_4_22].damage = 0
		end

		if not iter_4_23.heal then
			var_4_7[iter_4_22].heal = 0
		end

		if not iter_4_23.effective_heal then
			var_4_7[iter_4_22].effective_heal = 0
		end
	end

	if arg_4_1.arenatype == "scorearena" then
		(function()
			local var_10_0 = arg_4_1.enemydata or {}
			local var_10_1 = self.mypanel

			ccui.Helper:seekWidgetByName(self.mypanel, "Label_name"):setString(playermodel.nickname)

			for iter_10_0, iter_10_1 in pairs(arg_4_1.fightData.players.damage) do
				-- block empty
			end

			for iter_10_2, iter_10_3 in pairs(arg_4_1.fightData.players.suffer) do
				-- block empty
			end

			for iter_10_4, iter_10_5 in pairs(arg_4_1.fightData.players.heal) do
				-- block empty
			end

			for iter_10_6, iter_10_7 in pairs(arg_4_1.fightData.players.effective_heal) do
				-- block empty
			end

			local var_10_2 = var_10_1:getChildByName("rank"):getPositionX()
			local var_10_3 = var_10_1:getChildByName("rank"):getContentSize().width

			if arg_4_1.fightResult == "win" then
				var_10_1:getChildByName("jieguo"):loadTexture("PvpSettlement/win.png", var_0_0)

				if arg_4_1.addHonor and arg_4_1.addHonor > 0 then
					self.honorlabel:setString("+" .. arg_4_1.addHonor)
					self.imgCatchUp:setVisible(activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_SCORE_ARENA_POINT))
				else
					self.imgCatchUp:setVisible(false)
					self.honorlabel:setVisible(false)
					self.honorimg:setVisible(false)
				end

				if arg_4_1.rank then
					ccui.Helper:seekWidgetByName(var_10_1, "rank"):setString(L_PVP_RESULT_RANK .. arg_4_1.rank)
				end

				ccui.Helper:seekWidgetByName(var_10_1, "Label_up"):setString("" .. arg_4_1.score)
				ccui.Helper:seekWidgetByName(var_10_1, "up"):loadTexture("PvpSettlement/up.png", var_0_0)
				ccui.Helper:seekWidgetByName(var_10_1, "up"):setVisible(false)
			else
				if arg_4_1.rank and arg_4_1.rank > 0 then
					ccui.Helper:seekWidgetByName(var_10_1, "rank"):setString(L_PVP_RESULT_RANK .. arg_4_1.rank)
				else
					ccui.Helper:seekWidgetByName(var_10_1, "rank"):setVisible(false)
				end

				var_10_1:getChildByName("jieguo"):loadTexture("PvpSettlement/fail.png", var_0_0)
				self.honorimg:setVisible(false)
				ccui.Helper:seekWidgetByName(var_10_1, "up"):setVisible(false)
			end

			local var_10_6 = ccui.Helper:seekWidgetByName(self.mypanel, "ListView_my")

			var_10_6:setDirection(ccui.ListViewDirection.vertical)
			var_10_6:removeAllChildren()

			for iter_10_8 = 1, FORMATION_SHOW_GIRL_NUM do
				local var_10_7 = self.items:clone()

				if var_10_0.playerarray[iter_10_8] and var_10_0.playerarray[iter_10_8].servantid and var_10_0.playerarray[iter_10_8].servantid ~= -1 then
					local var_10_8 = global_get_servant_skin(var_10_0.playerarray[iter_10_8].servantid)

					var_10_7:getChildByName("Panel_clip"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[var_10_8].head_image .. ".png")

					local var_10_9

					if var_4_6[var_10_8] then
						var_10_9 = var_4_6[var_10_8].damage or 0
					end

					local var_10_10 = var_10_9 / var_4_9.damage

					if var_10_9 / var_4_9.damage == 0 or var_10_10 < var_0_5 then
						var_10_10 = var_0_5 + var_10_10 * 2
					end

					var_10_7:getChildByName("Panel_damage"):getChildByName("Image_value"):setScale(var_10_10, 1)
					ccui.Helper:seekWidgetByName(var_10_7:getChildByName("Panel_damage"), "value"):setString(global_trans_number(var_10_9))
					ccui.Helper:seekWidgetByName(var_10_7:getChildByName("Panel_damage"), "value"):setPositionX(var_10_7:getChildByName("Panel_damage"):getContentSize().width * var_10_10 + 5)

					local var_10_12 = var_4_6[var_10_8] and var_4_6[var_10_8].suffer or 0
					local var_10_13 = (var_4_6[var_10_8] and var_4_6[var_10_8].suffer or 0) / var_4_9.suffer

					if (var_4_6[var_10_8] and var_4_6[var_10_8].suffer or 0) / var_4_9.suffer == 0 or var_10_13 < var_0_5 then
						var_10_13 = var_0_5 + var_10_13 * 2
					end

					var_10_7:getChildByName("Panel_suffer"):getChildByName("Image_value"):setScale(var_10_13, 1)
					ccui.Helper:seekWidgetByName(var_10_7:getChildByName("Panel_suffer"), "value"):setString(global_trans_number(var_10_12))
					ccui.Helper:seekWidgetByName(var_10_7:getChildByName("Panel_suffer"), "value"):setPositionX(var_10_7:getChildByName("Panel_suffer"):getContentSize().width * var_10_13 + 5)

					local var_10_15 = var_4_6[var_10_8] and var_4_6[var_10_8].heal or 0
					local var_10_16

					if var_4_6[var_10_8] then
						var_10_16 = var_4_6[var_10_8].effective_heal or 0
					end

					local var_10_17 = var_10_16 / var_4_9.heal

					if var_10_16 / var_4_9.heal == 0 or var_10_17 < var_0_5 then
						var_10_17 = var_0_5 + var_10_17 * 2
					end

					var_10_7:getChildByName("Panel_heal"):getChildByName("Image_value"):setScale(var_10_17, 1)
					ccui.Helper:seekWidgetByName(var_10_7:getChildByName("Panel_heal"), "value"):setString(global_trans_number(var_10_15))

					local var_10_18 = ccui.ImageView:create("PvpSettlement/invalid_green.png", var_0_0)

					var_10_18:setAnchorPoint(cc.p(0, 0.5))
					var_10_18:setScale((var_10_15 - var_10_16) / var_4_9.heal, 1)

					local var_10_19 = var_10_7:getChildByName("Panel_heal")

					var_10_18:setPositionX(var_10_19:getChildByName("Image_value"):getPositionX() + var_10_7:getChildByName("Panel_heal"):getChildByName("Image_value").getContentSize(var_10_19).width * var_10_17)
					ccui.Helper:seekWidgetByName(var_10_7:getChildByName("Panel_heal"), "value"):setPositionX(var_10_18:getPositionX() + var_10_18:getContentSize().width * var_10_18:getScaleX() + 5)
					var_10_18:setPositionY(var_10_7:getChildByName("Panel_heal"):getChildByName("Image_value"):getPositionY())
					var_10_7:getChildByName("Panel_heal"):addChild(var_10_18)
				else
					var_10_7:getChildByName("Panel_clip"):setVisible(false)
					var_10_7:getChildByName("Panel_damage"):setVisible(false)
					var_10_7:getChildByName("Panel_suffer"):setVisible(false)
					var_10_7:getChildByName("Panel_heal"):setVisible(false)
					var_10_7:getChildByName("No_label"):setVisible(true)
				end

				var_10_6:pushBackCustomItem(var_10_7)
			end

			local var_10_21 = self.enemypanel

			ccui.Helper:seekWidgetByName(self.enemypanel, "Label_name"):setString(var_10_0.name or "")

			for iter_10_9, iter_10_10 in pairs(arg_4_1.fightData.enemies.damage) do
				-- block empty
			end

			for iter_10_11, iter_10_12 in pairs(arg_4_1.fightData.enemies.suffer) do
				-- block empty
			end

			local var_10_22 = 0

			for iter_10_13, iter_10_14 in pairs(arg_4_1.fightData.enemies.heal) do
				var_10_22 = var_10_22 + iter_10_14
			end

			for iter_10_15, iter_10_16 in pairs(arg_4_1.fightData.enemies.effective_heal) do
				-- block empty
			end

			local var_10_23 = var_10_21:getChildByName("rank"):getPositionX()
			local var_10_24 = var_10_21:getChildByName("rank"):getContentSize().width

			if arg_4_1.fightResult == "fail" then
				ccui.Helper:seekWidgetByName(var_10_21, "rank"):setVisible(false)
				var_10_21:getChildByName("jieguo"):loadTexture("PvpSettlement/win.png", var_0_0)
				var_10_21:getChildByName("up"):setVisible(false)
			else
				ccui.Helper:seekWidgetByName(var_10_21, "rank"):setVisible(false)
				var_10_21:getChildByName("jieguo"):loadTexture("PvpSettlement/fail.png", var_0_0)
				var_10_21:getChildByName("up"):setVisible(false)
			end

			local var_10_27 = var_10_21:getChildByName("ListView_enemy")

			var_10_27:setDirection(ccui.ListViewDirection.vertical)
			var_10_27:removeAllChildren()

			for iter_10_17 = 1, FORMATION_SHOW_GIRL_NUM do
				local var_10_28 = self.items:clone()

				if var_10_0.enemyarray[iter_10_17] and var_10_0.enemyarray[iter_10_17].servantid and var_10_0.enemyarray[iter_10_17].servantid ~= -1 and var_10_0.enemyarray[iter_10_17].servantid ~= "-1" and var_10_0.enemyarray[iter_10_17].servantid ~= "nil" then
					local var_10_29 = servant_data[var_10_0.enemyarray[iter_10_17].servantid].modelid

					var_10_28:getChildByName("Panel_clip"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[servant_data[var_10_0.enemyarray[iter_10_17].servantid].modelid].head_image .. ".png")

					local var_10_30

					if var_4_7[var_10_29] then
						var_10_30 = var_4_7[var_10_29].damage or 0
					end

					local var_10_31 = var_10_30 / var_4_11.damage

					if var_10_30 / var_4_11.damage == 0 or var_10_31 < var_0_5 then
						var_10_31 = var_0_5 + var_10_31 * 2
					end

					var_10_28:getChildByName("Panel_damage"):getChildByName("Image_value"):setScale(var_10_31, 1)
					ccui.Helper:seekWidgetByName(var_10_28:getChildByName("Panel_damage"), "value"):setString(global_trans_number(var_10_30))
					ccui.Helper:seekWidgetByName(var_10_28:getChildByName("Panel_damage"), "value"):setPositionX(var_10_28:getChildByName("Panel_damage"):getContentSize().width * var_10_31 + 5)

					local var_10_33 = var_4_7[var_10_29] and var_4_7[var_10_29].suffer or 0
					local var_10_34 = (var_4_7[var_10_29] and var_4_7[var_10_29].suffer or 0) / var_4_11.suffer

					if (var_4_7[var_10_29] and var_4_7[var_10_29].suffer or 0) / var_4_11.suffer == 0 or var_10_34 < var_0_5 then
						var_10_34 = var_0_5 + var_10_34 * 2
					end

					var_10_28:getChildByName("Panel_suffer"):getChildByName("Image_value"):setScale(var_10_34, 1)
					ccui.Helper:seekWidgetByName(var_10_28:getChildByName("Panel_suffer"), "value"):setString(global_trans_number(var_10_33))
					ccui.Helper:seekWidgetByName(var_10_28:getChildByName("Panel_suffer"), "value"):setPositionX(var_10_28:getChildByName("Panel_suffer"):getContentSize().width * var_10_34 + 5)

					local var_10_36 = var_4_7[var_10_29] and var_4_7[var_10_29].heal or 0
					local var_10_37

					if var_4_7[var_10_29] then
						var_10_37 = var_4_7[var_10_29].effective_heal or 0
					end

					local var_10_38 = var_10_37 / var_4_9.heal

					if var_10_37 / var_4_9.heal == 0 or var_10_38 < var_0_5 then
						var_10_38 = var_0_5 + var_10_38 * 2
					end

					var_10_28:getChildByName("Panel_heal"):getChildByName("Image_value"):setScale(var_10_38, 1)
					ccui.Helper:seekWidgetByName(var_10_28:getChildByName("Panel_heal"), "value"):setString(global_trans_number(var_10_36))

					local var_10_39 = ccui.ImageView:create("PvpSettlement/invalid_green.png", var_0_0)

					var_10_39:setAnchorPoint(cc.p(0, 0.5))
					var_10_39:setScale((var_10_36 - var_10_37) / var_4_9.heal, 1)

					local var_10_40 = var_10_28:getChildByName("Panel_heal")

					var_10_39:setPositionX(var_10_40:getChildByName("Image_value"):getPositionX() + var_10_28:getChildByName("Panel_heal"):getChildByName("Image_value").getContentSize(var_10_40).width * var_10_38)
					ccui.Helper:seekWidgetByName(var_10_28:getChildByName("Panel_heal"), "value"):setPositionX(var_10_39:getPositionX() + var_10_39:getContentSize().width * var_10_39:getScaleX() + 5)
					var_10_39:setPositionY(var_10_28:getChildByName("Panel_heal"):getChildByName("Image_value"):getPositionY())
					var_10_28:getChildByName("Panel_heal"):addChild(var_10_39)
				else
					var_10_28:getChildByName("Panel_clip"):setVisible(false)
					var_10_28:getChildByName("Panel_damage"):setVisible(false)
					var_10_28:getChildByName("Panel_suffer"):setVisible(false)
					var_10_28:getChildByName("Panel_heal"):setVisible(false)
					var_10_28:getChildByName("No_label"):setVisible(true)
				end

				var_10_27:pushBackCustomItem(var_10_28)
			end
		end)()

		local var_4_14 = 0
		local var_4_15 = 0
		local var_4_16 = {}

		var_4_16.score_sucessnum = RoleDefault:getInstance():getIntegerForKey("ScoreArenaLayerLeijiShengChang", 0)

		local var_4_17 = {}

		if arg_4_1.fightResult == "fail" then
			for iter_4_24, iter_4_25 in pairs(self.msg.enemydata.enemyarray) do
				if type(iter_4_25) == "table" and iter_4_25.servantid then
					var_4_17["score_role" .. iter_4_24 .. "_id_fail"] = iter_4_25.servantid
					var_4_14 = var_4_14 + 1

					if iter_4_25.horcrux and iter_4_25.horcrux.itemid then
						var_4_17["score_subrole" .. iter_4_24 .. "_id_fail"] = iter_4_25.horcrux.itemid
						var_4_15 = var_4_15 + 1
					end
				end
			end

			var_4_17.score_rolenum_fail = var_4_14
			var_4_17.score_subrolenum_fail = var_4_15

			AnalyticManager.score_tzfail(var_4_17)
		else
			for iter_4_26, iter_4_27 in pairs(self.msg.enemydata.playerarray) do
				if type(iter_4_27) == "table" and iter_4_27.servantid then
					var_4_16["score_role" .. iter_4_26 .. "_id"] = iter_4_27.servantid
					var_4_14 = var_4_14 + 1

					if iter_4_27.horcrux and iter_4_27.horcrux.itemid then
						var_4_16["score_subrole" .. iter_4_26 .. "_id"] = iter_4_27.horcrux.itemid
						var_4_15 = var_4_15 + 1
					end
				end
			end

			var_4_16.score_rolenum = var_4_14
			var_4_16.score_subrolenum = var_4_15

			AnalyticManager.score_tzsuccess(var_4_16)
		end
	elseif arg_4_1.arenatype == "friendfight" then
		(function()
			local var_11_0

			if arg_4_1.enemydata then
				var_11_0 = arg_4_1.enemydata.playerArray or {}
			end

			ccui.Helper:seekWidgetByName(var_4_0, "horor_img"):setVisible(false)
			ccui.Helper:seekWidgetByName(self.mypanel, "rank"):setVisible(false)
			ccui.Helper:seekWidgetByName(self.mypanel, "up"):setVisible(false)
			ccui.Helper:seekWidgetByName(self.mypanel, "Label_up"):setVisible(false)
			ccui.Helper:seekWidgetByName(self.mypanel, "Label_name"):setString(var_11_0.playerName or "")

			for iter_11_0, iter_11_1 in pairs(arg_4_1.fightData.players.damage) do
				-- block empty
			end

			for iter_11_2, iter_11_3 in pairs(arg_4_1.fightData.players.suffer) do
				-- block empty
			end

			local var_11_1 = 0

			for iter_11_4, iter_11_5 in pairs(arg_4_1.fightData.players.heal) do
				var_11_1 = var_11_1 + iter_11_5
			end

			if arg_4_1.fightResult == "win" then
				self.mypanel:getChildByName("jieguo"):loadTexture("PvpSettlement/win.png", var_0_0)
			else
				self.mypanel:getChildByName("jieguo"):loadTexture("PvpSettlement/fail.png", var_0_0)
			end

			local function var_11_2(arg_12_0)
				for iter_12_0, iter_12_1 in pairs(var_4_6) do
					if model_data[iter_12_0].major == model_data[arg_12_0].major then
						return iter_12_0
					end
				end
			end

			local var_11_7 = ccui.Helper:seekWidgetByName(self.mypanel, "ListView_my")

			var_11_7:setDirection(ccui.ListViewDirection.vertical)
			var_11_7:removeAllChildren()

			for iter_11_6 = 1, FORMATION_SHOW_GIRL_NUM do
				local var_11_8 = self.items:clone()

				if var_11_0[iter_11_6] and var_11_0[iter_11_6].fight_girl and var_11_0[iter_11_6].fight_girl ~= -1 then
					local var_11_9 = global_get_servant_skin(var_11_0[iter_11_6].fight_girl)

					var_11_9 = not var_4_6[var_11_9] and var_11_2(var_11_9) or var_11_9

					var_11_8:getChildByName("Panel_clip"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[var_11_9].head_image .. ".png")

					local var_11_10

					if var_4_6[var_11_9] then
						var_11_10 = var_4_6[var_11_9].damage or 0
					end

					local var_11_11 = var_11_10 / var_4_9.damage

					if var_11_10 / var_4_9.damage == 0 or var_11_11 < var_0_5 then
						var_11_11 = var_0_5 + var_11_11 * 2
					end

					var_11_8:getChildByName("Panel_damage"):getChildByName("Image_value"):setScale(var_11_11, 1)
					ccui.Helper:seekWidgetByName(var_11_8:getChildByName("Panel_damage"), "value"):setString(global_trans_number(var_11_10))
					ccui.Helper:seekWidgetByName(var_11_8:getChildByName("Panel_damage"), "value"):setPositionX(var_11_8:getChildByName("Panel_damage"):getContentSize().width * var_11_11 + 5)

					local var_11_13 = var_4_6[var_11_9] and var_4_6[var_11_9].suffer or 0
					local var_11_14 = (var_4_6[var_11_9] and var_4_6[var_11_9].suffer or 0) / var_4_9.suffer

					if (var_4_6[var_11_9] and var_4_6[var_11_9].suffer or 0) / var_4_9.suffer == 0 or var_11_14 < var_0_5 then
						var_11_14 = var_0_5 + var_11_14 * 2
					end

					var_11_8:getChildByName("Panel_suffer"):getChildByName("Image_value"):setScale(var_11_14, 1)
					ccui.Helper:seekWidgetByName(var_11_8:getChildByName("Panel_suffer"), "value"):setString(global_trans_number(var_11_13))
					ccui.Helper:seekWidgetByName(var_11_8:getChildByName("Panel_suffer"), "value"):setPositionX(var_11_8:getChildByName("Panel_suffer"):getContentSize().width * var_11_14 + 5)

					local var_11_16 = var_4_6[var_11_9] and var_4_6[var_11_9].heal or 0
					local var_11_17 = (var_4_6[var_11_9] and var_4_6[var_11_9].heal or 0) / var_4_9.heal

					if (var_4_6[var_11_9] and var_4_6[var_11_9].heal or 0) / var_4_9.heal == 0 or var_11_17 < var_0_5 then
						var_11_17 = var_0_5 + var_11_17 * 2
					end

					var_11_8:getChildByName("Panel_heal"):getChildByName("Image_value"):setScale(var_11_17, 1)
					ccui.Helper:seekWidgetByName(var_11_8:getChildByName("Panel_heal"), "value"):setString(global_trans_number(var_11_16))
					ccui.Helper:seekWidgetByName(var_11_8:getChildByName("Panel_heal"), "value"):setPositionX(var_11_8:getChildByName("Panel_heal"):getContentSize().width * var_11_17 + 5)
				else
					var_11_8:getChildByName("Panel_clip"):setVisible(false)
					var_11_8:getChildByName("Panel_damage"):setVisible(false)
					var_11_8:getChildByName("Panel_suffer"):setVisible(false)
					var_11_8:getChildByName("Panel_heal"):setVisible(false)
					var_11_8:getChildByName("No_label"):setVisible(true)
				end

				var_11_7:pushBackCustomItem(var_11_8)
			end

			local var_11_19 = self.enemypanel

			ccui.Helper:seekWidgetByName(self.enemypanel, "rank"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_11_19, "Label_up"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_11_19, "up"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_11_19, "Label_name"):setString(var_11_0.playerName or "")

			for iter_11_7, iter_11_8 in pairs(arg_4_1.fightData.enemies.damage) do
				-- block empty
			end

			for iter_11_9, iter_11_10 in pairs(arg_4_1.fightData.enemies.suffer) do
				-- block empty
			end

			local var_11_20 = 0

			for iter_11_11, iter_11_12 in pairs(arg_4_1.fightData.enemies.heal) do
				var_11_20 = var_11_20 + iter_11_12
			end

			if arg_4_1.fightResult == "fail" then
				var_11_19:getChildByName("jieguo"):loadTexture("PvpSettlement/win.png", var_0_0)
			else
				var_11_19:getChildByName("jieguo"):loadTexture("PvpSettlement/fail.png", var_0_0)
			end

			local var_11_24 = var_11_19:getChildByName("ListView_enemy")

			var_11_24:setDirection(ccui.ListViewDirection.vertical)
			var_11_24:removeAllChildren()

			for iter_11_13, iter_11_14 in pairs(var_4_7) do
				for iter_11_15, iter_11_16 in pairs(servant_data) do
					local var_11_25 = 1

					while iter_11_16["modelid" .. var_11_25] do
						if iter_11_16["modelid" .. var_11_25] == iter_11_13 and not var_4_7[iter_11_16.modelid] then
							var_4_7[iter_11_16.modelid] = iter_11_14
						end

						var_11_25 = var_11_25 + 1
					end

					if iter_11_16.model_oc == iter_11_13 and not var_4_7[iter_11_16.modelid] then
						var_4_7[iter_11_16.modelid] = iter_11_14
					end
				end
			end

			for iter_11_17 = 1, FORMATION_SHOW_GIRL_NUM do
				local var_11_26 = self.items:clone()

				if arg_4_1.enemydata.enemyArray[iter_11_17] and arg_4_1.enemydata.enemyArray[iter_11_17].servantid and arg_4_1.enemydata.enemyArray[iter_11_17].servantid ~= -1 and arg_4_1.enemydata.enemyArray[iter_11_17].servantid ~= "-1" and arg_4_1.enemydata.enemyArray[iter_11_17].servantid ~= "nil" then
					local var_11_27 = not servant_data[arg_4_1.enemydata.enemyArray[iter_11_17].servantid] and npc_fightconfig_data[arg_4_1.enemydata.enemyArray[iter_11_17].servantid].modelid or servant_data[arg_4_1.enemydata.enemyArray[iter_11_17].servantid].modelid

					var_11_26:getChildByName("Panel_clip"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[var_11_27].head_image .. ".png")

					local var_11_28

					if var_4_7[var_11_27] then
						var_11_28 = var_4_7[var_11_27].damage or 0
					end

					local var_11_29 = var_11_28 / var_4_11.damage

					if var_11_28 / var_4_11.damage == 0 or var_11_29 < var_0_5 then
						var_11_29 = var_0_5 + var_11_29 * 2
					end

					var_11_26:getChildByName("Panel_damage"):getChildByName("Image_value"):setScale(var_11_29, 1)
					ccui.Helper:seekWidgetByName(var_11_26:getChildByName("Panel_damage"), "value"):setString(global_trans_number(var_11_28))
					ccui.Helper:seekWidgetByName(var_11_26:getChildByName("Panel_damage"), "value"):setPositionX(var_11_26:getChildByName("Panel_damage"):getContentSize().width * var_11_29 + 5)

					local var_11_31 = var_4_7[var_11_27] and var_4_7[var_11_27].suffer or 0
					local var_11_32 = (var_4_7[var_11_27] and var_4_7[var_11_27].suffer or 0) / var_4_11.suffer

					if (var_4_7[var_11_27] and var_4_7[var_11_27].suffer or 0) / var_4_11.suffer == 0 or var_11_32 < var_0_5 then
						var_11_32 = var_0_5 + var_11_32 * 2
					end

					var_11_26:getChildByName("Panel_suffer"):getChildByName("Image_value"):setScale(var_11_32, 1)
					ccui.Helper:seekWidgetByName(var_11_26:getChildByName("Panel_suffer"), "value"):setString(global_trans_number(var_11_31))
					ccui.Helper:seekWidgetByName(var_11_26:getChildByName("Panel_suffer"), "value"):setPositionX(var_11_26:getChildByName("Panel_suffer"):getContentSize().width * var_11_32 + 5)

					local var_11_34 = var_4_7[var_11_27] and var_4_7[var_11_27].heal or 0
					local var_11_35 = (var_4_7[var_11_27] and var_4_7[var_11_27].heal or 0) / var_4_11.heal

					if (var_4_7[var_11_27] and var_4_7[var_11_27].heal or 0) / var_4_11.heal == 0 or var_11_35 < var_0_5 then
						var_11_35 = var_0_5 + var_11_35 * 2
					end

					var_11_26:getChildByName("Panel_heal"):getChildByName("Image_value"):setScale(var_11_35, 1)
					ccui.Helper:seekWidgetByName(var_11_26:getChildByName("Panel_heal"), "value"):setString(global_trans_number(var_11_34))
					ccui.Helper:seekWidgetByName(var_11_26:getChildByName("Panel_heal"), "value"):setPositionX(var_11_26:getChildByName("Panel_heal"):getContentSize().width * var_11_35 + 5)
				else
					var_11_26:getChildByName("Panel_clip"):setVisible(false)
					var_11_26:getChildByName("Panel_damage"):setVisible(false)
					var_11_26:getChildByName("Panel_suffer"):setVisible(false)
					var_11_26:getChildByName("Panel_heal"):setVisible(false)
					var_11_26:getChildByName("No_label"):setVisible(true)
				end

				var_11_24:pushBackCustomItem(var_11_26)
			end
		end)()
	else
		(function()
			local var_9_0 = arg_4_1.rankChange

			if arg_4_1.rankChange.RankIsVisable then
				ccui.Helper:seekWidgetByName(self.mypanel, "rank"):setVisible(false)
				ccui.Helper:seekWidgetByName(self.mypanel, "up"):setVisible(false)
				ccui.Helper:seekWidgetByName(self.mypanel, "Label_up"):setVisible(false)
			end

			ccui.Helper:seekWidgetByName(self.mypanel, "Label_name"):setString(var_9_0.playerName)

			for iter_9_0, iter_9_1 in pairs(arg_4_1.fightData.players.damage) do
				-- block empty
			end

			for iter_9_2, iter_9_3 in pairs(arg_4_1.fightData.players.suffer) do
				-- block empty
			end

			for iter_9_4, iter_9_5 in pairs(arg_4_1.fightData.players.heal) do
				-- block empty
			end

			for iter_9_6, iter_9_7 in pairs(arg_4_1.fightData.players.effective_heal) do
				-- block empty
			end

			local var_9_1 = self.mypanel:getChildByName("rank"):getPositionX()
			local var_9_2 = self.mypanel:getChildByName("rank"):getContentSize().width

			if arg_4_1.fightResult == "win" then
				self.mypanel:getChildByName("jieguo"):loadTexture("PvpSettlement/win.png", var_0_0)

				if arg_4_1.addHonor and arg_4_1.addHonor > 0 then
					self.honorlabel:setString("+" .. arg_4_1.addHonor)
					self.imgCatchUp:setVisible(activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_ARENA_DROP))
				else
					self.imgCatchUp:setVisible(false)
					self.honorlabel:setVisible(false)
					self.honorimg:setVisible(false)
				end

				local var_9_3 = 0

				if var_9_0.oldRank then
					var_9_3 = var_9_0.enemyRank - var_9_0.oldRank
				end

				if var_9_3 > 0 then
					var_9_3 = 0

					if var_9_0.oldRank then
						ccui.Helper:seekWidgetByName(self.mypanel, "rank"):setString(L_PVP_RESULT_RANK .. var_9_0.oldRank)
					end
				else
					var_9_3 = "" .. math.abs(var_9_3)

					if var_9_0.enemyRank then
						ccui.Helper:seekWidgetByName(self.mypanel, "rank"):setString(L_PVP_RESULT_RANK .. var_9_0.enemyRank)
					end
				end

				self.mypanel:getChildByName("up"):loadTexture("PvpSettlement/up.png", var_0_0)
				ccui.Helper:seekWidgetByName(self.mypanel, "Label_up"):setColor(cc.c3b(67, 221, 57))
				ccui.Helper:seekWidgetByName(self.mypanel, "Label_up"):setString("" .. var_9_3)
				ccui.Helper:seekWidgetByName(self.mypanel, "Label_up")
				self.mypanel:getChildByName("up"):setPositionX(var_9_1 + var_9_2 + 25)
			else
				if var_9_0.oldRank then
					ccui.Helper:seekWidgetByName(self.mypanel, "rank"):setString(L_PVP_RESULT_RANK .. var_9_0.oldRank)
				end

				self.mypanel:getChildByName("jieguo"):loadTexture("PvpSettlement/fail.png", var_0_0)
				self.mypanel:getChildByName("up"):setVisible(false)

				if arg_4_1.addHonor and arg_4_1.addHonor > 0 then
					self.honorlabel:setString("+" .. arg_4_1.addHonor)
					self.imgCatchUp:setVisible(false)
				else
					self.imgCatchUp:setVisible(false)
					self.honorlabel:setVisible(false)
					self.honorimg:setVisible(false)
				end

				self.mypanel:getChildByName("up"):setPositionX(var_9_1 + var_9_2 + 25)
			end

			if var_9_0.oldRank and var_9_0.oldRank < 0 then
				self.mypanel:getChildByName("up"):setVisible(false)
				ccui.Helper:seekWidgetByName(self.mypanel, "rank"):setString(L_PVP_RESULT_NO_RANK)
			end

			local var_9_8 = ccui.Helper:seekWidgetByName(self.mypanel, "ListView_my")

			var_9_8:setDirection(ccui.ListViewDirection.vertical)
			var_9_8:removeAllChildren()

			for iter_9_8 = 1, FORMATION_SHOW_GIRL_NUM do
				local var_9_9 = var_9_0.playerArray[iter_9_8]
				local var_9_10 = self.items:clone()

				if var_9_0.playerArray[iter_9_8] and var_9_9.model ~= -1 then
					var_9_10:getChildByName("Panel_clip"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[var_9_9.model].head_image .. ".png")

					local var_9_11

					if var_4_6[var_9_9.model] then
						var_9_11 = var_4_6[var_9_9.model].damage or 0
					end

					local var_9_12 = var_9_11 / var_4_9.damage

					if var_9_11 / var_4_9.damage == 0 or var_9_12 < var_0_5 then
						var_9_12 = var_0_5 + var_9_12 * 2
					end

					var_9_10:getChildByName("Panel_damage"):getChildByName("Image_value"):setScale(var_9_12, 1)
					ccui.Helper:seekWidgetByName(var_9_10:getChildByName("Panel_damage"), "value"):setString(global_trans_number(var_9_11))
					ccui.Helper:seekWidgetByName(var_9_10:getChildByName("Panel_damage"), "value"):setPositionX(var_9_10:getChildByName("Panel_damage"):getContentSize().width * var_9_12 + 5)

					local var_9_14 = var_4_6[var_9_9.model] and var_4_6[var_9_9.model].suffer or 0
					local var_9_15 = (var_4_6[var_9_9.model] and var_4_6[var_9_9.model].suffer or 0) / var_4_9.suffer

					if (var_4_6[var_9_9.model] and var_4_6[var_9_9.model].suffer or 0) / var_4_9.suffer == 0 or var_9_15 < var_0_5 then
						var_9_15 = var_0_5 + var_9_15 * 2
					end

					var_9_10:getChildByName("Panel_suffer"):getChildByName("Image_value"):setScale(var_9_15, 1)
					ccui.Helper:seekWidgetByName(var_9_10:getChildByName("Panel_suffer"), "value"):setString(global_trans_number(var_9_14))
					ccui.Helper:seekWidgetByName(var_9_10:getChildByName("Panel_suffer"), "value"):setPositionX(var_9_10:getChildByName("Panel_suffer"):getContentSize().width * var_9_15 + 5)

					local var_9_17 = var_4_6[var_9_9.model] and var_4_6[var_9_9.model].heal or 0
					local var_9_19

					if var_4_6[var_9_9.model] then
						var_9_19 = var_4_6[var_9_9.model].effective_heal or 0
					end

					local var_9_20 = var_9_19 / var_4_9.heal

					if var_9_19 / var_4_9.heal == 0 or var_9_20 < var_0_5 then
						var_9_20 = var_0_5 + var_9_20 * 2
					end

					var_9_10:getChildByName("Panel_heal"):getChildByName("Image_value"):setScale(var_9_20, 1)
					ccui.Helper:seekWidgetByName(var_9_10:getChildByName("Panel_heal"), "value"):setString(global_trans_number(var_9_17))

					local var_9_21 = ccui.ImageView:create("PvpSettlement/invalid_green.png", var_0_0)

					var_9_21:setAnchorPoint(cc.p(0, 0.5))
					var_9_21:setScale((var_9_17 - var_9_19) / var_4_9.heal, 1)

					local var_9_22 = var_9_10:getChildByName("Panel_heal")

					var_9_21:setPositionX(var_9_22:getChildByName("Image_value"):getPositionX() + var_9_10:getChildByName("Panel_heal"):getChildByName("Image_value").getContentSize(var_9_22).width * var_9_20)
					ccui.Helper:seekWidgetByName(var_9_10:getChildByName("Panel_heal"), "value"):setPositionX(var_9_21:getPositionX() + var_9_21:getContentSize().width * var_9_21:getScaleX() + 5)
					var_9_21:setPositionY(var_9_10:getChildByName("Panel_heal"):getChildByName("Image_value"):getPositionY())
					var_9_10:getChildByName("Panel_heal"):addChild(var_9_21)
				else
					var_9_10:getChildByName("Panel_clip"):setVisible(false)
					var_9_10:getChildByName("Panel_damage"):setVisible(false)
					var_9_10:getChildByName("Panel_suffer"):setVisible(false)
					var_9_10:getChildByName("Panel_heal"):setVisible(false)
					var_9_10:getChildByName("No_label"):setVisible(true)
				end

				var_9_8:pushBackCustomItem(var_9_10)
			end

			local var_9_24 = self.enemypanel

			if var_9_0.RankIsVisable then
				ccui.Helper:seekWidgetByName(var_9_24, "rank"):setVisible(false)
				ccui.Helper:seekWidgetByName(var_9_24, "Label_up"):setVisible(false)
				ccui.Helper:seekWidgetByName(var_9_24, "up"):setVisible(false)
			end

			ccui.Helper:seekWidgetByName(var_9_24, "Label_name"):setString(var_9_0.enemyName)

			for iter_9_9, iter_9_10 in pairs(arg_4_1.fightData.enemies.damage) do
				-- block empty
			end

			for iter_9_11, iter_9_12 in pairs(arg_4_1.fightData.enemies.suffer) do
				-- block empty
			end

			local var_9_25 = 0

			for iter_9_13, iter_9_14 in pairs(arg_4_1.fightData.enemies.heal) do
				var_9_25 = var_9_25 + iter_9_14
			end

			local var_9_26 = 0

			for iter_9_15, iter_9_16 in pairs(arg_4_1.fightData.enemies.effective_heal) do
				var_9_26 = var_9_26 + iter_9_16
			end

			local var_9_27 = var_9_24:getChildByName("rank"):getPositionX()
			local var_9_28 = var_9_24:getChildByName("rank"):getContentSize().width

			if arg_4_1.fightResult == "fail" then
				if var_9_0.enemyRank then
					ccui.Helper:seekWidgetByName(var_9_24, "rank"):setString(L_PVP_RESULT_RANK .. var_9_0.enemyRank)
				end

				var_9_24:getChildByName("jieguo"):loadTexture("PvpSettlement/win.png", var_0_0)
				var_9_24:getChildByName("up"):setVisible(false)
				ccui.Helper:seekWidgetByName(var_9_24, "Label_up"):setColor(cc.c3b(221, 57, 75))
				ccui.Helper:seekWidgetByName(var_9_24, "Label_up"):setPositionX(var_9_27 + var_9_28 + 5)
				var_9_24:getChildByName("up"):setPositionX(var_9_27 + var_9_28 + 35)
			else
				local var_9_29 = 0

				var_9_24:getChildByName("jieguo"):loadTexture("PvpSettlement/fail.png", var_0_0)

				if var_9_0.oldRank and var_9_0.oldRank > var_9_0.enemyRank then
					ccui.Helper:seekWidgetByName(var_9_24, "rank"):setString(L_PVP_RESULT_RANK .. var_9_0.oldRank)

					var_9_29 = var_9_0.enemyRank - var_9_0.oldRank

					var_9_24:getChildByName("up"):loadTexture("PvpSettlement/down.png", var_0_0)
				else
					var_9_24:getChildByName("up"):loadTexture("PvpSettlement/down.png", var_0_0)

					if var_9_0.enemyRank then
						ccui.Helper:seekWidgetByName(var_9_24, "rank"):setString(L_PVP_RESULT_RANK .. var_9_0.enemyRank)
					end
				end

				ccui.Helper:seekWidgetByName(var_9_24, "Label_up"):setString("" .. var_9_29)
				ccui.Helper:seekWidgetByName(var_9_24, "Label_up"):setPositionX(var_9_27 + var_9_28 + 5)
				var_9_24:getChildByName("up"):setPositionX(var_9_27 + var_9_28 + 35)
			end

			local var_9_33 = var_9_24:getChildByName("ListView_enemy")

			var_9_33:setDirection(ccui.ListViewDirection.vertical)
			var_9_33:removeAllChildren()

			for iter_9_17 = 1, #var_9_0.enemyArray do
				local var_9_34 = var_9_0.enemyArray[iter_9_17]
				local var_9_35 = self.items:clone()

				if var_9_0.enemyArray[iter_9_17] and var_9_34.model ~= -1 and var_9_34.model ~= "-1" and var_9_34.model ~= "nil" then
					var_9_35:getChildByName("Panel_clip"):getChildByName("Image_head"):loadTexture("roleimage/role/wuji/" .. model_data[var_9_34.model].head_image .. ".png")

					local var_9_36

					if var_4_7[var_9_34.model] then
						var_9_36 = var_4_7[var_9_34.model].damage or 0
					end

					local var_9_37 = var_9_36 / var_4_11.damage

					if var_9_36 / var_4_11.damage == 0 or var_9_37 < var_0_5 then
						var_9_37 = var_0_5 + var_9_37 * 2
					end

					var_9_35:getChildByName("Panel_damage"):getChildByName("Image_value"):setScale(var_9_37, 1)
					ccui.Helper:seekWidgetByName(var_9_35:getChildByName("Panel_damage"), "value"):setString(global_trans_number(var_9_36))
					ccui.Helper:seekWidgetByName(var_9_35:getChildByName("Panel_damage"), "value"):setPositionX(var_9_35:getChildByName("Panel_damage"):getContentSize().width * var_9_37 + 5)

					local var_9_39 = var_4_7[var_9_34.model] and var_4_7[var_9_34.model].suffer or 0
					local var_9_40 = (var_4_7[var_9_34.model] and var_4_7[var_9_34.model].suffer or 0) / var_4_11.suffer

					if (var_4_7[var_9_34.model] and var_4_7[var_9_34.model].suffer or 0) / var_4_11.suffer == 0 or var_9_40 < var_0_5 then
						var_9_40 = var_0_5 + var_9_40 * 2
					end

					var_9_35:getChildByName("Panel_suffer"):getChildByName("Image_value"):setScale(var_9_40, 1)
					ccui.Helper:seekWidgetByName(var_9_35:getChildByName("Panel_suffer"), "value"):setString(global_trans_number(var_9_39))
					ccui.Helper:seekWidgetByName(var_9_35:getChildByName("Panel_suffer"), "value"):setPositionX(var_9_35:getChildByName("Panel_suffer"):getContentSize().width * var_9_40 + 5)

					local var_9_42 = var_4_7[var_9_34.model] and var_4_7[var_9_34.model].heal or 0
					local var_9_44

					if var_4_7[var_9_34.model] then
						var_9_44 = var_4_7[var_9_34.model].effective_heal or 0
					end

					local var_9_45 = var_9_44 / var_4_9.heal

					if var_9_44 / var_4_9.heal == 0 or var_9_45 < var_0_5 then
						var_9_45 = var_0_5 + var_9_45 * 2
					end

					var_9_35:getChildByName("Panel_heal"):getChildByName("Image_value"):setScale(var_9_45, 1)
					ccui.Helper:seekWidgetByName(var_9_35:getChildByName("Panel_heal"), "value"):setString(global_trans_number(var_9_42))

					local var_9_46 = ccui.ImageView:create("PvpSettlement/invalid_green.png", var_0_0)

					var_9_46:setAnchorPoint(cc.p(0, 0.5))
					var_9_46:setScale((var_9_42 - var_9_44) / var_4_9.heal, 1)

					local var_9_47 = var_9_35:getChildByName("Panel_heal")

					var_9_46:setPositionX(var_9_47:getChildByName("Image_value"):getPositionX() + var_9_35:getChildByName("Panel_heal"):getChildByName("Image_value").getContentSize(var_9_47).width * var_9_45)
					ccui.Helper:seekWidgetByName(var_9_35:getChildByName("Panel_heal"), "value"):setPositionX(var_9_46:getPositionX() + var_9_46:getContentSize().width * var_9_46:getScaleX() + 5)
					var_9_46:setPositionY(var_9_35:getChildByName("Panel_heal"):getChildByName("Image_value"):getPositionY())
					var_9_35:getChildByName("Panel_heal"):addChild(var_9_46)
				else
					var_9_35:getChildByName("Panel_clip"):setVisible(false)
					var_9_35:getChildByName("Panel_damage"):setVisible(false)
					var_9_35:getChildByName("Panel_suffer"):setVisible(false)
					var_9_35:getChildByName("Panel_heal"):setVisible(false)
					var_9_35:getChildByName("No_label"):setVisible(true)
				end

				var_9_33:pushBackCustomItem(var_9_35)
			end
		end)()
	end

	self:fullScreen(var_4_0, self.panelresult)
	self:checkAutoFight(arg_4_1)

	return self
end

function PvpResultLayer:initBg(arg_13_1)
	local var_13_0 = ccui.Layout:create()

	var_13_0:setTouchEnabled(true)
	var_13_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_13_0:setAnchorPoint(cc.p(0, 0))
	var_13_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_13_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_13_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_13_0:setOpacity(0)
	var_13_0:setCascadeOpacityEnabled(false)
	self:addChild(var_13_0, -1)

	local var_13_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_13_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_1:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_1:setPositionY(var_13_0:getContentSize().height / 2)
	var_13_0:addChild(var_13_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_14_0)
		self:addChild(arg_14_0, -2)
		arg_14_0:setPositionY(arg_14_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_13_1)
		var_13_0:setOpacity(102)
		var_13_0:setTouchEnabled(false)
	end)
end

function PvpResultLayer.checkAutoFight(arg_15_0, arg_15_1)
	if arg_15_1.fightResult == "fail" then
		return
	end

	if arg_15_1.arenatype ~= "scorearena" then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("ScoreAutoFight", false) then
		global_count_down_layer(4, function()
			arg_15_0:exit(true)
		end, function()
			RoleDefault:getInstance():setBoolForKey("ScoreAutoFight", false)
		end)
	end
end

function PvpResultLayer:exit(arg_18_1)
	self.panelresult:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.1), cc.CallFunc:create(function()
		if self.__queueindex then
			LayerManager:removePopLayer(self.__queueindex)
		else
			self:runAction(cc.RemoveSelf:create())
		end

		if self.msg.cancelCallback then
			self.msg.cancelCallback()
		end

		if self.msg.exitcallback then
			self.msg.exitcallback(arg_18_1)
		end
	end)))
end
