ListButtonLayer = class("ListButtonLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local model_data = require("data.model_data")
local audio_manager = require("controller.audio_manager")
local community_system_manager = require("controller.community_system_manager")
local bond_manager = require("controller.bond_manager")
local alert_manager = require("controller.alert_manager")
local level_manager = require("controller.level_manager")
local var_0_8
local var_0_9 = false

function ListButtonLayer.create(arg_2_0)
	local var_2_0 = ListButtonLayer.new()

	var_2_0:init()

	return var_2_0
end

function ListButtonLayer.getInstance()
	return var_0_8
end

local var_0_10 = 0
local var_0_11 = 1
local var_0_12 = {
	[0] = {
		{
			bntId = 3,
			layerName = "SchoolAreaLayer"
		},
		{
			bntId = 2,
			layerName = "DormitoryLayer"
		},
		{
			bntId = 4,
			layerName = "ActivityEntranceLayer"
		}
	},
	{
		{
			bntId = 3,
			layerName = "HorcruxLayer"
		},
		{
			bntId = 4,
			layerName = "AdventureLayer"
		}
	}
}

function ListButtonLayer:init()
	var_0_8 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ListButtonLayer.json" or "ListButtonLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initSwitchBtn()
	self:initShowBtnList()
	self:updateShowBtnList()
	self:updatePlotRemind()
	self:updateRedDot()
	self:fullScreen()
end

function ListButtonLayer:fullScreen()
	self.rootLayer_posY = -GameDisplay.fix_y - 1

	self.rootLayer:setPositionY(self.rootLayer_posY)
end

local var_0_13 = {}
local var_0_15 = {
	"MainLayer",
	"FightLayer"
}

setmetatable(var_0_13, {
	__index = function(arg_6_0, arg_6_1)
		if arg_6_1 == 2 then
			if level_manager:isPlayerPassLevel(UNLOCK_LIST_SWITCH) then
				return "ListButtonLayer/list_main.png"
			else
				return "ListButtonLayer/list_main_lock.png"
			end
		else
			return "ListButtonLayer/list_fight.png"
		end

		return 3
	end
})

function ListButtonLayer:initSwitchBtn()
	self.btnSwitch = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_switch")
	self.btnSwitch.tag = var_0_11

	self.btnSwitch:loadTextures(var_0_13[2], var_0_13[2], var_0_13[2], var_0_0)

	local function var_7_0()
		self.btnSwitch.tag = 1 - self.btnSwitch.tag

		LayerManager:switchShowLayer(var_0_15[self.btnSwitch.tag + 1])
		self.btnSwitch:loadTextures(var_0_13[self.btnSwitch.tag + 1], var_0_13[self.btnSwitch.tag + 1], var_0_13[self.btnSwitch.tag + 1], var_0_0)
		self:updateShowBtnList()
		self:showBtnList()
	end

	self.btnSwitch:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_9 then
			return
		end

		if self.touchLock then
			return
		end

		if var_0_15[self.btnSwitch.tag + 1] == "FightLayer" and not level_manager:isPlayerPassLevel(UNLOCK_LIST_SWITCH) then
			local var_9_0 = string.split(UNLOCK_LIST_SWITCH, "-")

			global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, tonumber(var_9_0[1] - 1) .. "-" .. var_9_0[2]))

			return
		end

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))

		var_0_9 = true

		audio_manager:playeffectMusicTest("sound/switch_listbutton")
		arg_9_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			var_0_9 = false
		end)))
		arg_9_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(var_7_0)))
		self:hideBtnList()
	end)
end

function ListButtonLayer.playShowGirlSound(arg_11_0)
	if global_canshow_live2d(playermodel.showgirl) then
		return
	end

	GlobalPlayRoleSound(playermodel.showgirl, ROLE_SOUND_TYPE.home)
end

local var_0_17 = {
	{
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "MainLayer",
				key = "layerName"
			},
			texture = {
				"ListButtonLayer/list_btn_hall.png",
				"ListButtonLayer/list_btn_hall_on.png"
			}
		},
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "DormitoryLayer",
				key = "layerName"
			},
			texture = {
				"ListButtonLayer/list_btn_dorm.png",
				"ListButtonLayer/list_btn_dorm_on.png",
				"ListButtonLayer/list_btn_dorm_lock.png"
			}
		},
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "SchoolAreaLayer",
				key = "layerName"
			},
			texture = {
				"ListButtonLayer/list_btn_main.png",
				"ListButtonLayer/list_btn_main_on.png",
				"ListButtonLayer/list_btn_main_lock.png"
			}
		},
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "ActivityEntranceLayer",
				key = "layerName"
			},
			texture = {
				"ListButtonLayer/list_btn_activity_off.png",
				"ListButtonLayer/list_btn_activity_on.png",
				"ListButtonLayer/list_btn_activity_lock.png"
			}
		}
	},
	{
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "FightLayer",
				key = "layerName"
			},
			texture = {
				"ListButtonLayer/list_btn_fight.png",
				"ListButtonLayer/list_btn_fight_on.png"
			}
		},
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "GirlSelectLayer",
				key = "layerName",
				initparam = {
					selectType = SELECT_GIRL_DATABASE
				}
			},
			texture = {
				"ListButtonLayer/list_btn_role.png",
				"ListButtonLayer/list_btn_role_on.png"
			}
		},
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "HorcruxLayer",
				key = "layerName"
			},
			texture = {
				"ListButtonLayer/list_bnt_horcrux.png",
				"ListButtonLayer/list_bnt_horcrux_on.png",
				"ListButtonLayer/list_btn_horcrux_lock.png"
			}
		},
		{
			event = "switchShowLayer",
			show = true,
			param = {
				value = "AdventureLayer",
				key = "layerName"
			},
			texture = {
				"ListButtonLayer/list_bnt_change.png",
				"ListButtonLayer/list_bnt_change_on.png",
				"ListButtonLayer/list_bnt_change_lock.png"
			}
		}
	}
}
local var_0_18 = {
	{
		bg = "ListButtonLayer/list_bg.png",
		selectbg = {
			"ListButtonLayer/bg_selected_left.png",
			"ListButtonLayer/bg_selected.png",
			"ListButtonLayer/bg_selected.png",
			"ListButtonLayer/bg_selected.png"
		}
	},
	{
		bg = "ListButtonLayer/list_bg_fight.png",
		selectbg = {
			"ListButtonLayer/bg_selected_left_fight.png",
			"ListButtonLayer/bg_selected_fight.png",
			"ListButtonLayer/bg_selected_fight.png",
			"ListButtonLayer/bg_selected_fight.png"
		}
	}
}

function ListButtonLayer:initShowBtnList()
	self.btnList = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_list")

	for iter_12_0 = 1, 4 do
		self.btnList:getChildByName("select_btn" .. iter_12_0):addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_0_9 then
				return
			end

			if self.touchLock then
				return
			end

			local var_13_0 = self.btnSwitch.tag + 1

			if not var_0_17[self.btnSwitch.tag + 1][iter_12_0].event then
				return
			end

			local var_13_1 = cc.EventCustom:new(var_0_17[var_13_0][iter_12_0].event)

			if var_0_17[var_13_0][iter_12_0].param then
				var_13_1[var_0_17[var_13_0][iter_12_0].param.key] = var_0_17[var_13_0][iter_12_0].param.value
			end

			var_13_1.initparam = var_0_17[var_13_0][iter_12_0].param.initparam

			if var_0_17[var_13_0][iter_12_0].param.value == "ActivityEntranceLayer" then
				AnalyticManager.clickActivityEntranceType({
					tab = 2
				})
			end

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_13_1)
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("updateMainLineTaskUI"))
		end)

		local var_12_0 = self.btnList:getChildByName("select_bg" .. iter_12_0)

		function var_12_0:hideAction()
			if not self:isVisible() then
				return
			end

			self:stopAllActions()
			self:setOpacity(255)
			self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.Hide:create()))
		end

		function var_12_0:showAction()
			if self:isVisible() then
				return
			end

			self:stopAllActions()
			self:setOpacity(0)
			self:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.2)))
		end
	end
end

function ListButtonLayer:updateShowBtnList()
	for iter_16_0 = 1, 4 do
		self.btnList:getChildByName("select_btn" .. iter_16_0):setVisible(var_0_17[self.btnSwitch.tag + 1][iter_16_0].show)

		if var_0_17[self.btnSwitch.tag + 1][iter_16_0].texture then
			self.btnList:getChildByName("select_btn" .. iter_16_0):loadTextures(var_0_17[self.btnSwitch.tag + 1][iter_16_0].texture[1], var_0_17[self.btnSwitch.tag + 1][iter_16_0].texture[2], var_0_17[self.btnSwitch.tag + 1][iter_16_0].texture[1], var_0_0)
		end

		self.btnList:getChildByName("select_bg" .. iter_16_0):setVisible(false)
		self.btnList:getChildByName("select_bg" .. iter_16_0):loadTexture(var_0_18[self.btnSwitch.tag + 1].selectbg[iter_16_0], var_0_0)
	end

	self.btnList:getChildByName("bg"):loadTexture(var_0_18[self.btnSwitch.tag + 1].bg, var_0_0)
	self:updateButtonsUnlockStatus()
end

function ListButtonLayer.system_alert(arg_17_0, ...)
	return
end

function ListButtonLayer:setButtonImg(arg_18_1, arg_18_2)
	if arg_18_2 and arg_18_1 == "WareHouseListBottonLayer" then
		if arg_18_2 == "FightLayer" or arg_18_2 == "GirlSelectLayer" or arg_18_2 == "AdventureLayer" then
			self:updateFightLayerBtnList(arg_18_1)
		elseif arg_18_2 == "MainLayer" or arg_18_2 == "DormitoryLayer" or arg_18_2 == "SchoolAreaLayer" then
			self:updateMainLayerBtnList(arg_18_1)
		elseif self.btnSwitch.tag == var_0_10 then
			self:updateMainLayerBtnList(arg_18_1)
		else
			self:updateFightLayerBtnList(arg_18_1)
		end
	elseif arg_18_1 == "FightLayer" or arg_18_1 == "GirlSelectLayer" or arg_18_1 == "WareHouseListBottonLayer" or arg_18_1 == "AdventureLayer" or arg_18_1 == "HorcruxLayer" then
		self:updateFightLayerBtnList(arg_18_1)
	elseif arg_18_1 == "MainLayer" or arg_18_1 == "DormitoryLayer" or arg_18_1 == "SchoolAreaLayer" or arg_18_1 == "WareHouseListBottonLayer" or arg_18_1 == "CommunityMainLayer" or arg_18_1 == "joinCommunityLayer" or arg_18_1 == "ActivityEntranceLayer" then
		self:updateMainLayerBtnList(arg_18_1)
	end

	self:updatePlotRemind(arg_18_1)
	self:updateRedDot()
	self:updateButtonsUnlockStatus()
end

function ListButtonLayer:getListButtonSwitchTag()
	return self.btnSwitch.tag
end

function ListButtonLayer:updateMainLayerBtnList(arg_20_1)
	if self.btnSwitch.tag ~= var_0_10 then
		self.btnSwitch.tag = var_0_10

		self.btnSwitch:loadTextures(var_0_13[1], var_0_13[1], var_0_13[1], var_0_0)
		self:updateShowBtnList()
	end

	for iter_20_0, iter_20_1 in pairs(var_0_17[1]) do
		if iter_20_1.param and (iter_20_1.param.value == arg_20_1 or iter_20_1.param.value1 and iter_20_1.param.value1 == arg_20_1) then
			if iter_20_1.texture then
				self.btnList:getChildByName("select_btn" .. iter_20_0):loadTextureNormal(iter_20_1.texture[2], var_0_0)
			end

			self.btnList:getChildByName("select_bg" .. iter_20_0):showAction()
			self.btnList:getChildByName("select_bg" .. iter_20_0):loadTexture(var_0_18[1].selectbg[iter_20_0], var_0_0)
		else
			if iter_20_1.texture then
				self.btnList:getChildByName("select_btn" .. iter_20_0):loadTextureNormal(iter_20_1.texture[1], var_0_0)
			end

			self.btnList:getChildByName("select_bg" .. iter_20_0):hideAction()
			self.btnList:getChildByName("select_bg" .. iter_20_0):loadTexture(var_0_18[1].selectbg[iter_20_0], var_0_0)
		end
	end

	self.btnList:getChildByName("bg"):loadTexture(var_0_18[1].bg, var_0_0)
end

function ListButtonLayer:updateFightLayerBtnList(arg_21_1)
	if self.btnSwitch.tag ~= var_0_11 then
		self.btnSwitch.tag = var_0_11

		self.btnSwitch:loadTextures(var_0_13[2], var_0_13[2], var_0_13[2], var_0_0)
		self:updateShowBtnList()
	end

	for iter_21_0, iter_21_1 in pairs(var_0_17[2]) do
		if iter_21_1.param and iter_21_1.param.value == arg_21_1 then
			if iter_21_1.texture then
				self.btnList:getChildByName("select_btn" .. iter_21_0):loadTextureNormal(iter_21_1.texture[2], var_0_0)
			end

			self.btnList:getChildByName("select_bg" .. iter_21_0):showAction()
			self.btnList:getChildByName("select_bg" .. iter_21_0):loadTexture(var_0_18[2].selectbg[iter_21_0], var_0_0)
		else
			if iter_21_1.texture then
				self.btnList:getChildByName("select_btn" .. iter_21_0):loadTextureNormal(iter_21_1.texture[1], var_0_0)
			end

			self.btnList:getChildByName("select_bg" .. iter_21_0):hideAction()
			self.btnList:getChildByName("select_bg" .. iter_21_0):loadTexture(var_0_18[2].selectbg[iter_21_0], var_0_0)
		end
	end

	self.btnList:getChildByName("bg"):loadTexture(var_0_18[2].bg, var_0_0)
end

function ListButtonLayer:getAlertNodes()
	local var_22_0 = {}

	for iter_22_0 = 1, 4 do
		var_22_0["select_btn" .. iter_22_0] = self.btnList:getChildByName("select_btn" .. iter_22_0)
	end

	return var_22_0
end

function ListButtonLayer:hideBtnList()
	self.btnList:stopAllActions()
	self.btnList:runAction(cc.MoveTo:create(0.3, cc.p(640, 18)))

	for iter_23_0 = 1, 4 do
		AlertManager:remove_all_alert(self.btnList:getChildByName("select_btn" .. iter_23_0))
	end
end

function ListButtonLayer:showBtnList()
	self.btnList:stopAllActions()
	self.btnList:runAction(cc.MoveTo:create(0.3, cc.p(0, 18)))
end

function ListButtonLayer:hideLayer(arg_25_1)
	self.touchLock = true
	self.displayState = 0

	self.rootLayer:stopAllActions()

	if arg_25_1 and next(arg_25_1) ~= nil and arg_25_1.action == false then
		self.rootLayer:setVisible(false)
	end

	self.rootLayer:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(0, -100 + self.rootLayer_posY)), cc.Hide:create()))
end

function ListButtonLayer:showLayer()
	self.touchLock = false
	self.displayState = 1

	self.rootLayer:stopAllActions()
	self.rootLayer:runAction(cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.2, cc.p(0, self.rootLayer_posY))))
end

function ListButtonLayer.setTouchLock(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or true
	arg_27_0.touchLock = arg_27_1
end

function ListButtonLayer:getListButtonLayerState()
	return self.displayState
end

function ListButtonLayer:onFirstCreate(arg_29_1)
	self.displayState = 1

	self.rootLayer:setPosition(cc.p(0, -100 + self.rootLayer_posY))
	self.rootLayer:runAction(cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.2, cc.p(0, self.rootLayer_posY))))
	self:setButtonImg(arg_29_1)
end

function ListButtonLayer:updatePlotRemind(arg_30_1)
	if self.btnSwitch:getChildByName("remindIcon") then
		self.btnSwitch:getChildByName("remindIcon"):removeFromParent()
	end

	if self.btnSwitch.tag == var_0_10 then
		for iter_30_0, iter_30_1 in pairs(PlotManager.LISTBUTTON_PLOT_REMIND_CONFIG.FightLayer) do
			if PlotManager.plot_layer_config[iter_30_1] then
				PlotManager:addRemind(self.btnSwitch, cc.p(50, 50))

				break
			end
		end
	elseif self.btnSwitch.tag == var_0_11 then
		for iter_30_2, iter_30_3 in pairs(PlotManager.LISTBUTTON_PLOT_REMIND_CONFIG.SchoolAreaLayer) do
			if PlotManager.plot_layer_config[iter_30_3] then
				break
			end
		end
	end

	local var_30_0 = self.btnSwitch.tag + 1

	for iter_30_4 = 1, 4 do
		local var_30_1 = self.btnList:getChildByName("select_btn" .. iter_30_4):getChildByName("remindIcon")

		if var_30_1 then
			var_30_1:removeFromParent()
		end

		if var_0_17[var_30_0][iter_30_4].show then
			if PlotManager.LISTBUTTON_PLOT_REMIND_CONFIG[var_0_17[var_30_0][iter_30_4].param.value] then
				for iter_30_5, iter_30_6 in pairs(PlotManager.LISTBUTTON_PLOT_REMIND_CONFIG[var_0_17[var_30_0][iter_30_4].param.value]) do
					if PlotManager.plot_layer_config[iter_30_6] then
						if arg_30_1 ~= var_0_17[var_30_0][iter_30_4].param.value then
							PlotManager:addRemind(self.btnList:getChildByName("select_btn" .. iter_30_4), cc.p(110, 50))
						end

						break
					end
				end
			end
		end
	end
end

function ListButtonLayer:updateButtonsUnlockStatus()
	for iter_31_0 = 1, 4 do
		local var_31_0 = self.btnList:getChildByName("select_btn" .. iter_31_0)
		local var_31_1 = var_31_0:getChildByName("lock_Text")

		if var_31_1 then
			var_31_0:removeChild(var_31_1, true)
		end
	end

	for iter_31_1 = 1, 4 do
		local var_31_2 = self.btnList:getChildByName("select_btn" .. iter_31_1):getChildByName("lock_Text")

		if var_31_2 then
			var_31_2:removeFromParent()
		end
	end

	for iter_31_2, iter_31_3 in ipairs(var_0_12[self.btnSwitch.tag]) do
		local var_31_3, var_31_4 = LayerManager:getLayerUnlockStat(iter_31_3.layerName)

		if not var_31_3 then
			local var_31_5 = self.btnList:getChildByName("select_btn" .. iter_31_3.bntId)

			var_31_5:loadTextures(var_0_17[1 + self.btnSwitch.tag][iter_31_3.bntId].texture[3], var_0_17[1 + self.btnSwitch.tag][iter_31_3.bntId].texture[3], var_0_17[1 + self.btnSwitch.tag][iter_31_3.bntId].texture[3], var_0_0)

			local var_31_6 = ccui.TextBMFont:create(var_31_4, "fonts/lanse.fnt")

			var_31_6:setAnchorPoint(cc.p(0.5, 1))
			var_31_6:setName("lock_Text")
			var_31_6:setPosition(cc.p(var_31_5:getContentSize().width / 2 + 12, var_31_5:getContentSize().height / 2 - 20))
			var_31_6:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
			var_31_5:addChild(var_31_6, 10)
		end
	end

	if not self.switch_tipText then
		self.switch_tipText = ccui.TextBMFont:create(string.format(L_STRING_FORMATH_UNLOCK, level_manager:formatSystemUnlockLevel("1-10")):gsub(L_CHECK_TASK_DATA.tasktypeStr[1], ""), "fonts/lanse.fnt")

		self.switch_tipText:setAnchorPoint(0.5, 0.5)
		self.switch_tipText:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
		self.btnSwitch:addChild(self.switch_tipText, 10)
		self.switch_tipText:setPosition(cc.p(self.btnSwitch:getContentSize().width / 2 + 12, self.btnSwitch:getContentSize().height / 2 - 35))
	end

	self.switch_tipText:setVisible(var_0_15[self.btnSwitch.tag + 1] == "FightLayer" and not level_manager:isPlayerPassLevel(UNLOCK_LIST_SWITCH))
	self.btnSwitch:loadTextures(var_0_13[self.btnSwitch.tag + 1], var_0_13[self.btnSwitch.tag + 1], var_0_13[self.btnSwitch.tag + 1], var_0_0)
end

function ListButtonLayer:updateRedDot()
	if not level_manager:isPlayerPassLevel(UNLOCK_LIST_SWITCH) then
		alert_manager:add_redDot(self.btnSwitch, false, cc.p(110, 75))
	elseif self.btnSwitch.tag == var_0_10 then
		if bond_manager:isShowRemind() then
			alert_manager:register_alert(ALERT_BOND)
		else
			alert_manager:unregister_alert(ALERT_BOND)
		end

		alert_manager:add_redDot(self.btnSwitch, false)
	else
		alert_manager:unregister_alert(ALERT_BOND)
		alert_manager:add_redDot(self.btnSwitch, bond_manager:isShowRemind(), cc.p(110, 75))
	end
end
