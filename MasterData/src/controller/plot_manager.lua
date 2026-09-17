local var_0_0 = {}
local var_0_3 = 1
local var_0_4 = 2
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = config._DEBUG and 0 or 1
local network = require("network.network")
local playermodel = require("model.playermodel")
local task_manager = require("controller.task_manager")
local achieve_manager = require("controller.achieve_manager")
local plot_data = require("data.plot_data")
local plot_class_data = require("data.plot_class_data")
local task_data = require("data.task_data")
local weekly_task_index_data = require("data.weekly_task_index_data")
local career_task_index_data = require("data.career_task_index_data")

var_0_0.plot_layer_config = {}
var_0_0.topPlotList = {}

local var_0_18 = {
	LEVELMODE = 4,
	ITEM = 3,
	EXPLORE = 2,
	TALK = 1
}

PLOT_CLASS = {
	CHALLENGE = 10,
	ACHIEVE = 3,
	RESOURCES = 9,
	DAILY_WEEKLY = 13,
	CAREER = 4,
	NORMAL = 1,
	WEEKLY = 12,
	ACTIVITY = 5,
	GROWTH = 11,
	ITEM = 7,
	ROLE = 6,
	DAILY = 2,
	MOVE = 8
}

local var_0_19 = {
	EXPLORE = 2,
	ACTIVITY = 4,
	RANDOM = 6,
	MAIN = 1,
	FAVOR = 3,
	TRAVEL = 5,
	SHOWGIRL = 7
}

var_0_0.PLOT_REMIND_CONFIG = {
	SchoolCinemaLayer = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			SchoolAreaLayer = {
				"btn_memoryRoomTips",
				cc.p(180, 60)
			}
		}
	},
	NewSchoolDeanOfficeLayer = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			SchoolAreaLayer = {
				"btn_deanOffice",
				cc.p(180, 60)
			}
		}
	},
	SchoolFileLayer = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			SchoolAreaLayer = {
				"btn_fileRoomTips",
				cc.p(180, 60)
			}
		}
	},
	SchoolSwimLayer = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			SchoolAreaLayer = {
				"Button_swimmingRoom",
				cc.p(180, 60)
			}
		}
	},
	SchoolTrainLayer = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			SchoolAreaLayer = {
				"btn_trainRoomTips",
				cc.p(180, 60)
			}
		}
	},
	LabMenuLayer = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			SchoolAreaLayer = {
				"btn_labRoomTips",
				cc.p(180, 60)
			}
		}
	},
	LabMakeNewLayer = {
		systemlayer = "SchoolAreaLayer",
		showlayer = "SchoolAreaLayer",
		showconfig = {
			SchoolAreaLayer = {
				"btn_laboratoryRoom",
				cc.p(180, 60)
			}
		}
	},
	LevelMapLayer = {
		systemlayer = "LevelMapLayer",
		showlayer = "FightLayer",
		showconfig = {
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	},
	LevelMapLayer2 = {
		systemlayer = "LevelMapLayer",
		showlayer = "LevelMapLayer",
		showconfig = {
			LevelMapLayer = {
				"city2",
				cc.p(170, 83)
			},
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	},
	LevelMapLayer3 = {
		systemlayer = "LevelMapLayer",
		showlayer = "LevelMapLayer",
		showconfig = {
			LevelMapLayer = {
				"city3",
				cc.p(170, 83)
			},
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	},
	LevelMapLayer4 = {
		systemlayer = "LevelMapLayer",
		showlayer = "LevelMapLayer",
		showconfig = {
			LevelMapLayer = {
				"city4",
				cc.p(170, 83)
			},
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	},
	LevelMapLayer5 = {
		systemlayer = "LevelMapLayer",
		showlayer = "LevelMapLayer",
		showconfig = {
			LevelMapLayer = {
				"city5",
				cc.p(170, 83)
			},
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	},
	LevelMapLayer6 = {
		systemlayer = "LevelMapLayer",
		showlayer = "LevelMapLayer",
		showconfig = {
			LevelMapLayer = {
				"city6",
				cc.p(170, 83)
			},
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	},
	LevelMapLayer7 = {
		systemlayer = "LevelMapLayer",
		showlayer = "LevelMapLayer",
		showconfig = {
			LevelMapLayer = {
				"city7",
				cc.p(170, 83)
			},
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	},
	LevelMapLayer8 = {
		systemlayer = "LevelMapLayer",
		showlayer = "LevelMapLayer",
		showconfig = {
			LevelMapLayer = {
				"city8",
				cc.p(170, 83)
			},
			FightLayer = {
				"btn_map",
				cc.p(50, 40)
			}
		}
	}
}
var_0_0.LAYER_PLOT_REMIND_CONFIG = {
	LevelMapLayer = {
		"LevelMapLayer1",
		"LevelMapLayer2",
		"LevelMapLayer3",
		"LevelMapLayer4",
		"LevelMapLayer5",
		"LevelMapLayer6",
		"LevelMapLayer7",
		"LevelMapLayer8"
	},
	SchoolAreaLayer = {
		"SchoolCinemaLayer",
		"NewSchoolDeanOfficeLayer",
		"SchoolFileLayer",
		"SchoolSwimLayer",
		"SchoolTrainLayer",
		"LabMenuLayer",
		"LabMakeNewLayer"
	},
	FightLayer = {
		"LevelMapLayer",
		"LevelMapLayer1",
		"LevelMapLayer2",
		"LevelMapLayer3",
		"LevelMapLayer4",
		"LevelMapLayer5",
		"LevelMapLayer6",
		"LevelMapLayer7",
		"LevelMapLayer8"
	}
}
var_0_0.LISTBUTTON_PLOT_REMIND_CONFIG = {
	SchoolAreaLayer = {
		"SchoolAreaLayer",
		"SchoolCinemaLayer",
		"NewSchoolDeanOfficeLayer",
		"SchoolFileLayer",
		"SchoolSwimLayer",
		"SchoolTrainLayer",
		"LabMenuLayer",
		"LabMakeNewLayer"
	},
	DormitoryLayer = {
		"DormitoryLayer"
	},
	FightLayer = {
		"LevelMapLayer",
		"LevelMapLayer1",
		"LevelMapLayer2",
		"LevelMapLayer3",
		"LevelMapLayer4",
		"LevelMapLayer5",
		"LevelMapLayer6",
		"LevelMapLayer7",
		"LevelMapLayer8"
	}
}

local function var_0_20(arg_1_0, arg_1_1)
	print("{{{")

	local function var_1_0(arg_2_0)
		if type(arg_2_0) == "table" then
			for iter_2_0, iter_2_1 in pairs(arg_2_0) do
				local var_2_0 = var_1_0(iter_2_1)

				if var_2_0 then
					return var_2_0
				end
			end

			return nil
		elseif arg_2_0:getName() == arg_1_1 then
			return arg_2_0
		else
			return var_1_0(arg_2_0:getChildren())
		end
	end

	return var_1_0(arg_1_0)
end

function var_0_0.resetPlotData(arg_3_0)
	arg_3_0.topPlotList = {}
	arg_3_0.topActivityPlotList = {}
	arg_3_0.plot_layer_config = {}
end

function var_0_0:trigger_plot_by_server(arg_4_1)
	print("trigger_plot_by_server", dump(arg_4_1))

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if iter_4_1.plotState == var_0_6 then
			playermodel.readyPlots[iter_4_1.plotClassId] = true
		elseif iter_4_1.plotState == var_0_7 then
			local var_4_0 = {
				iter_4_1.plotClassId
			}

			var_4_0[2] = iter_4_1.step or 0
			playermodel.runningPlots[iter_4_1.plotClassId] = var_4_0

			self:checkIsUnlockMapLevel(iter_4_1.plotClassId)
		end
	end

	self:update_plot_layer_config()
	LayerManager:getUIElement("ListButton"):updatePlotRemind(LayerManager:getActiveLayerName())

	if LayerManager:getActiveLayerName() == "FightLayer" then
		LayerManager:getPlotObj():fightlayerUpdatePlotRemind()
	end
end

function var_0_0.get_top_task_list(arg_5_0, arg_5_1)
	network:rpc("get_top_task_list", nil, function(arg_6_0)
		if arg_6_0.running_plots then
			playermodel.runningPlots = {}
			arg_5_0.topPlotList = {}
			arg_5_0.topActivityPlotList = {}

			for iter_6_0, iter_6_1 in pairs(arg_6_0.running_plots) do
				if plot_class_data[iter_6_1.plotClassId] then
					playermodel.runningPlots[iter_6_1.plotClassId] = {
						iter_6_1.plotClassId,
						iter_6_1.step
					}

					if plot_class_data[iter_6_1.plotClassId].plot_class == var_0_19.ACTIVITY then
						table.insert(arg_5_0.topActivityPlotList, playermodel.runningPlots[iter_6_1.plotClassId])
					else
						table.insert(arg_5_0.topPlotList, playermodel.runningPlots[iter_6_1.plotClassId])
					end
				end
			end

			arg_5_0:update_plot_layer_config()
			table.sort(arg_5_0.topPlotList, function(arg_7_0, arg_7_1)
				if arg_5_0:check_plot_is_finished(arg_7_0) == arg_5_0:check_plot_is_finished(arg_7_1) then
					return plot_class_data[arg_7_0[1]].order < plot_class_data[arg_7_1[1]].order
				else
					return arg_5_0:check_plot_is_finished(arg_7_0) and not arg_5_0:check_plot_is_finished(arg_7_1)
				end
			end)
			table.sort(arg_5_0.topActivityPlotList, function(arg_8_0, arg_8_1)
				if arg_5_0:check_plot_is_finished(arg_8_0) == arg_5_0:check_plot_is_finished(arg_8_1) then
					return plot_class_data[arg_8_0[1]].order < plot_class_data[arg_8_1[1]].order
				else
					return arg_5_0:check_plot_is_finished(arg_8_0) and not arg_5_0:check_plot_is_finished(arg_8_1)
				end
			end)
		end

		if arg_6_0.taskinfo then
			task_manager:generate_task_params(arg_6_0.taskinfo)
			task_manager:generate_task_info()
			achieve_manager:generate_task_info()
		end

		if arg_5_1 then
			arg_5_1()
		end
	end)
end

function var_0_0:dequeueTaskInfo(arg_9_1, arg_9_2)
	if arg_9_1 == PLOT_CLASS.NORMAL then
		local var_9_0 = plot_class_data[self.topPlotList[arg_9_2][var_0_3]]

		if self:check_plot_is_finished(self.topPlotList[arg_9_2]) then
			local var_9_1 = {
				taskid = self.topPlotList[arg_9_2][var_0_3],
				name = var_9_0.plot_name,
				des = L_PLOT_EVENT_FINISH,
				percent = math.floor(self.topPlotList[arg_9_2][var_0_4] / var_9_0.total_steps * 100),
				drop = var_9_0.drop
			}

			if var_9_0.plot_type == 1 then
				var_9_1.order = L_PLOT_MAIN or L_PLOT_BRANCH
			end

			var_9_1.img = var_9_0.image or 1

			return var_9_1
		else
			local var_9_2 = {
				taskid = self.topPlotList[arg_9_2][var_0_3],
				name = var_9_0.plot_name,
				des = plot_data[plot_class_data[self.topPlotList[arg_9_2][var_0_3]]["step" .. self.topPlotList[arg_9_2][var_0_4] + 1]].des,
				percent = math.floor(self.topPlotList[arg_9_2][var_0_4] / var_9_0.total_steps * 100),
				jump = plot_data[plot_class_data[self.topPlotList[arg_9_2][var_0_3]]["step" .. self.topPlotList[arg_9_2][var_0_4] + 1]].jump,
				drop = var_9_0.drop
			}

			if var_9_0.plot_type == 1 then
				var_9_2.order = L_PLOT_MAIN or L_PLOT_BRANCH
			end

			var_9_2.img = var_9_0.image or 1

			return var_9_2
		end
	elseif arg_9_1 == PLOT_CLASS.ACTIVITY then
		local var_9_3 = plot_class_data[self.topActivityPlotList[arg_9_2][var_0_3]]

		if self:check_plot_is_finished(self.topActivityPlotList[arg_9_2]) then
			local var_9_4 = {
				taskid = self.topActivityPlotList[arg_9_2][var_0_3],
				name = var_9_3.plot_name,
				des = L_PLOT_EVENT_FINISH,
				percent = math.floor(self.topActivityPlotList[arg_9_2][var_0_4] / var_9_3.total_steps * 100),
				drop = var_9_3.drop
			}

			if var_9_3.plot_type == 1 then
				var_9_4.order = L_PLOT_MAIN or L_PLOT_BRANCH
			end

			var_9_4.img = var_9_3.image or 1

			return var_9_4
		else
			local var_9_5 = {
				taskid = self.topActivityPlotList[arg_9_2][var_0_3],
				name = var_9_3.plot_name,
				des = plot_data[plot_class_data[self.topActivityPlotList[arg_9_2][var_0_3]]["step" .. self.topActivityPlotList[arg_9_2][var_0_4] + 1]].des,
				percent = math.floor(self.topActivityPlotList[arg_9_2][var_0_4] / var_9_3.total_steps * 100),
				jump = plot_data[plot_class_data[self.topActivityPlotList[arg_9_2][var_0_3]]["step" .. self.topActivityPlotList[arg_9_2][var_0_4] + 1]].jump,
				drop = var_9_3.drop
			}

			if var_9_3.plot_type == 1 then
				var_9_5.order = L_PLOT_MAIN or L_PLOT_BRANCH
			end

			var_9_5.img = var_9_3.image or 1

			return var_9_5
		end
	end
end

function var_0_0:update_plot_layer_config()
	self.plot_layer_config = {}

	for iter_10_0, iter_10_1 in pairs(playermodel.readyPlots) do
		local var_10_1 = {
			plotType = var_0_6,
			plotClassId = iter_10_0,
			targetLayer = plot_class_data[iter_10_0].targer_layer,
			npc = plot_class_data[iter_10_0].npc,
			conditionType = var_0_18.TALK,
			finishParam1 = plot_class_data[iter_10_0].talk,
			triggerLayer = plot_class_data[iter_10_0].target_layer
		}

		if self.plot_layer_config[plot_class_data[iter_10_0].target_layer] then
			self.plot_layer_config[plot_class_data[iter_10_0].target_layer][iter_10_0] = var_10_1
		else
			self.plot_layer_config[plot_class_data[iter_10_0].target_layer] = {
				[iter_10_0] = var_10_1
			}
		end
	end

	for iter_10_2, iter_10_3 in pairs(playermodel.runningPlots) do
		if not self:check_plot_is_finished(iter_10_3) then
			if plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].target_layer then
				local var_10_2 = {
					plotType = var_0_7,
					plotId = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].id,
					plotClassId = iter_10_3[var_0_3],
					targetLayer = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].target_layer,
					npc = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].npc,
					ui = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].target_ui,
					conditionType = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].finish_condition,
					finishParam1 = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].finish_param1,
					finishParam2 = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].finish_param2,
					finishParam3 = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].finish_param3,
					finishParam4 = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].finish_param4,
					triggerLayer = plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].target_layer
				}

				if self.plot_layer_config[plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].target_layer] then
					self.plot_layer_config[plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].target_layer][iter_10_3[var_0_3]] = var_10_2
				else
					self.plot_layer_config[plot_data[plot_class_data[iter_10_3[var_0_3]]["step" .. iter_10_3[var_0_4] + 1]].target_layer] = {
						[iter_10_3[var_0_3]] = var_10_2
					}
				end
			end
		end
	end
end

function var_0_0.getCurPLotInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_2 = arg_11_2 or var_0_7

	local var_11_0
	local var_11_1 = plot_class_data[arg_11_1]

	if arg_11_2 == var_0_6 then
		var_11_0 = {
			plotType = var_0_6,
			plotClassId = arg_11_1,
			targetLayer = var_11_1.targer_layer,
			npc = var_11_1.npc,
			conditionType = var_0_18.TALK,
			finishParam1 = var_11_1.talk
		}
	elseif arg_11_2 == var_0_7 then
		local var_11_2

		if arg_11_3 then
			var_11_2 = arg_11_3 + 1

			local var_11_3

			if not (arg_11_3 + 1) then
				var_11_2 = playermodel.runningPlots[arg_11_1][var_0_4] + 1
				var_11_3 = {
					plotType = var_0_7,
					plotId = plot_data[var_11_1["step" .. var_11_2]].id,
					plotClassId = arg_11_1,
					targetLayer = plot_data[var_11_1["step" .. var_11_2]].target_layer,
					npc = plot_data[var_11_1["step" .. var_11_2]].npc,
					ui = plot_data[var_11_1["step" .. var_11_2]].target_ui,
					conditionType = plot_data[var_11_1["step" .. var_11_2]].finish_condition,
					finishParam1 = plot_data[var_11_1["step" .. var_11_2]].finish_param1,
					finishParam2 = plot_data[var_11_1["step" .. var_11_2]].finish_param2,
					finishParam3 = plot_data[var_11_1["step" .. var_11_2]].finish_param3
				}
			end
		end

		var_11_3.finishParam4 = plot_data[var_11_1["step" .. var_11_2]].finish_param4
		var_11_0 = var_11_3
	end

	return var_11_0
end

function var_0_0.check_plot_is_finished(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[var_0_3]
	local var_12_1 = arg_12_1[var_0_4]

	assert(plot_class_data[arg_12_1[var_0_3]], arg_12_1[var_0_3] .. dump(arg_12_1))

	return var_12_1 == plot_class_data[var_12_0].total_steps
end

function var_0_0.addRemind(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_3 = arg_13_3 or 1

	if not arg_13_1 then
		return
	end

	if arg_13_1:getChildByName("remindIcon") then
		return
	end

	local var_13_0 = ccui.ImageView:create("public/reddot/plot_remind.png", var_0_8)

	var_13_0:setPosition(arg_13_2)
	var_13_0:setName("remindIcon")
	var_13_0:setAnchorPoint(cc.p(0.5, 0))
	arg_13_1:addChild(var_13_0, 99)
	var_13_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.1, 0.95 * arg_13_3, 0.85 * arg_13_3), cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 10)), cc.ScaleTo:create(0.2, 1.05 * arg_13_3, 1.15 * arg_13_3)), cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, -10)), cc.ScaleTo:create(0.2, 0.95 * arg_13_3, 0.8 * arg_13_3)), cc.ScaleTo:create(0.08, 1 * arg_13_3, 1 * arg_13_3), cc.DelayTime:create(0.6))))
end

function var_0_0.removeRemind(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getChildByName("remindIcon")

	if var_14_0 then
		var_14_0:removeFromParent()
	end
end

function var_0_0:createUI(arg_15_1)
	if arg_15_1.targetLayer:find("LevelMapLayer") then
		self:createLevelMapUI(arg_15_1)
	end
end

function var_0_0.createLevelMapUI(arg_16_0, arg_16_1)
	local var_16_0 = LayerManager:getUIElement("LevelMapLayer") or LevelMapLayer.getInstance()

	if not var_16_0 then
		return
	end

	local var_16_1 = var_0_20(var_16_0, arg_16_1.ui)

	if not var_16_1 then
		return
	end

	local var_16_2 = var_16_1:getParent():convertToWorldSpace(cc.p(var_16_1:getPositionX(), var_16_1:getPositionY()))
	local var_16_3 = var_16_1:getContentSize()
	local var_16_4

	if var_16_1:getChildByName("plotCloneUI") then
		var_16_4 = var_16_1:getChildByName("plotCloneUI")

		var_16_4:setVisible(true)
	else
		var_16_4 = ccui.Layout:create()

		var_16_4:setName("plotCloneUI")
		var_16_4:setTouchEnabled(true)
		PlotManager:addRemind(var_16_4, cc.p(var_16_3.width - 10, var_16_3.height - 26))
		var_16_1:addChild(var_16_4)
	end

	var_16_4:setContentSize(var_16_3)
	var_16_4:setPosition(0, 0)

	var_16_4.lock = false

	print("@@@@@@@@", var_16_1:isVisible(), var_16_1.mark_bg:isVisible())

	if not var_16_1:isVisible() or not var_16_1.mark_bg:isVisible() then
		var_16_1:setVisible(true)
		var_16_1.mark_bg:setVisible(true)

		var_16_4.is_hide_parent = true
	end

	var_16_4:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_0.lock then
			return
		end

		arg_17_0.lock = true

		require("controller.explore_manager"):begin_explore({
			returnLayer = "LevelMapLayer",
			type = "plot",
			plotClassId = arg_16_1.plotClassId,
			canCelcallback = function()
				arg_17_0.lock = false
			end
		})
	end)
end

function var_0_0.removeUI(arg_19_0, arg_19_1)
	local var_19_0 = var_0_20(obj, arg_19_1.ui)

	if not var_19_0 then
		print("@#@#@#@#@#@#@#@#", obj:getName(), arg_19_1.ui)

		return
	end

	if not var_19_0:getChildByName("plotCloneUI") then
		return
	end

	if var_19_0:getChildByName("plotCloneUI").is_hide_parent then
		var_19_0:setVisible(false)
	end

	var_19_0:getChildByName("plotCloneUI"):removeFromParent()
end

function var_0_0.removeInvalidPlotRemind(arg_20_0, arg_20_1)
	if PlotManager.PLOT_REMIND_CONFIG[arg_20_1.targetLayer] then
		if LayerManager:getActiveLayerName() == PlotManager.PLOT_REMIND_CONFIG[arg_20_1.targetLayer].showlayer and not PlotManager.plot_layer_config[arg_20_1.targetLayer] then
			PlotManager:removeRemind((var_0_20(LayerManager:getActiveLayerObj(), PlotManager.PLOT_REMIND_CONFIG[arg_20_1.targetLayer].showconfig[PlotManager.PLOT_REMIND_CONFIG[arg_20_1.targetLayer].showlayer][1])))
		end
	end
end

function var_0_0.pushPlot(arg_21_0, arg_21_1, arg_21_2)
	network:rpc("push_plot", {
		plotClassId = arg_21_1
	}, function(arg_22_0)
		if arg_22_0.result == 1 then
			local var_22_0 = plot_data[arg_21_0:getRunningPlotId(arg_21_1)]

			if var_22_0.finish_condition == var_0_18.ITEM then
				require("controller.item_manager"):deleteItem(var_22_0.finish_param1, var_22_0.finish_param2)
			end

			playermodel.runningPlots[arg_21_1][var_0_4] = arg_22_0.plotinfo.step

			arg_21_0:checkIsUnlockMapLevel(arg_21_1)
			arg_21_0:update_plot_layer_config()

			if arg_21_0:check_plot_is_finished(playermodel.runningPlots[arg_21_1]) then
				AlertManager:register_alert(ALERT_TOP_PLOT)

				arg_22_0.isFinish = true
			end
		elseif arg_22_0.result == 2 then
			cclog("任务不在进行队列中")
		elseif arg_22_0.result == 3 then
			cclog("任务已经完成")
		elseif arg_22_0.result == 4 then
			cclog("未满足限制条件")
		end

		if arg_21_2 then
			arg_21_2(arg_22_0)
		end
	end)
end

function var_0_0.receivePlot(arg_23_0, arg_23_1, arg_23_2)
	network:rpc("receive_plot", {
		plotClassId = arg_23_1
	}, function(arg_24_0)
		if arg_24_0.result == 1 then
			local var_24_0 = {
				arg_23_1,
				arg_24_0.result.plotinfo.step
			}

			if arg_24_0.plotinfo.step / plot_class_data[arg_23_1].total_steps < 1 then
				table.insert(arg_23_0.topPlotList[arg_23_1], var_24_0)

				playermodel.runningPlots[arg_23_1] = var_24_0
			else
				table.insert(arg_23_0.topPlotList[arg_23_1], 1, var_24_0)

				playermodel.runningPlots[arg_23_1] = var_24_0
			end

			arg_23_0:update_plot_layer_config()
		elseif arg_24_0.result == 2 then
			cclog("任务不在触发队列中")
		elseif arg_24_0.result == 3 then
			cclog("任务已经触发")
		end

		if arg_23_2 then
			arg_23_2(arg_24_0)
		end
	end)
end

function var_0_0.finishPlot(arg_25_0, arg_25_1, arg_25_2)
	network:rpc("finish_plot", {
		plotClassId = arg_25_1
	}, function(arg_26_0)
		if arg_26_0.result == 1 then
			playermodel.runningPlots[arg_25_1] = nil

			if plot_class_data[arg_25_1].plot_class == var_0_19.ACTIVITY then
				for iter_26_0, iter_26_1 in pairs(arg_25_0.topActivityPlotList) do
					if iter_26_1[var_0_3] == arg_25_1 then
						table.remove(arg_25_0.topActivityPlotList, iter_26_0)
					end
				end
			else
				for iter_26_2, iter_26_3 in pairs(arg_25_0.topPlotList) do
					if iter_26_3[var_0_3] == arg_25_1 then
						table.remove(arg_25_0.topPlotList, iter_26_2)
					end
				end
			end

			if arg_26_0.plotinfos then
				arg_25_0:trigger_plot_by_server(arg_26_0.plotinfos)

				arg_25_0.topPlotList = {}

				for iter_26_4, iter_26_5 in pairs(playermodel.runningPlots) do
					if plot_class_data[iter_26_4].plot_class == var_0_19.ACTIVITY then
						table.insert(arg_25_0.topActivityPlotList, iter_26_5)
					else
						table.insert(arg_25_0.topPlotList, iter_26_5)
					end
				end

				table.sort(arg_25_0.topPlotList, function(arg_27_0, arg_27_1)
					if arg_25_0:check_plot_is_finished(arg_27_0) == arg_25_0:check_plot_is_finished(arg_27_1) then
						return plot_class_data[arg_27_0[1]].order < plot_class_data[arg_27_1[1]].order
					else
						return arg_25_0:check_plot_is_finished(arg_27_0) and not arg_25_0:check_plot_is_finished(arg_27_1)
					end
				end)
				table.sort(arg_25_0.topActivityPlotList, function(arg_28_0, arg_28_1)
					if arg_25_0:check_plot_is_finished(arg_28_0) == arg_25_0:check_plot_is_finished(arg_28_1) then
						return plot_class_data[arg_28_0[1]].order < plot_class_data[arg_28_1[1]].order
					else
						return arg_25_0:check_plot_is_finished(arg_28_0) and not arg_25_0:check_plot_is_finished(arg_28_1)
					end
				end)
			end
		elseif arg_26_0.result == 2 then
			cclog("任务不在进行队列中")
		elseif arg_26_0.result == 3 then
			cclog("任务还未完成")
		end

		if arg_25_2 then
			arg_25_2(arg_26_0.result, arg_26_0)
		end
	end)
end

function var_0_0.finishPlotOneKey(arg_29_0, arg_29_1)
	network:rpc("finish_plot_onekey", nil, function(arg_30_0)
		if arg_30_0.result == 1 then
			for iter_30_0, iter_30_1 in pairs(arg_30_0.finish_ids) do
				playermodel.runningPlots[iter_30_1] = nil

				if plot_class_data[iter_30_1].plot_class == var_0_19.ACTIVITY then
					for iter_30_2, iter_30_3 in pairs(arg_29_0.topActivityPlotList) do
						if iter_30_3[var_0_3] == iter_30_1 then
							table.remove(arg_29_0.topActivityPlotList, iter_30_2)
						end
					end
				else
					for iter_30_4, iter_30_5 in pairs(arg_29_0.topPlotList) do
						if iter_30_5[var_0_3] == iter_30_1 then
							table.remove(arg_29_0.topPlotList, iter_30_4)
						end
					end
				end
			end

			if arg_30_0.plotinfos then
				arg_29_0:trigger_plot_by_server(arg_30_0.plotinfos)

				arg_29_0.topPlotList = {}

				for iter_30_6, iter_30_7 in pairs(playermodel.runningPlots) do
					if plot_class_data[iter_30_6].plot_class == var_0_19.ACTIVITY then
						table.insert(arg_29_0.topActivityPlotList, iter_30_7)
					else
						table.insert(arg_29_0.topPlotList, iter_30_7)
					end
				end

				table.sort(arg_29_0.topPlotList, function(arg_31_0, arg_31_1)
					if arg_29_0:check_plot_is_finished(arg_31_0) == arg_29_0:check_plot_is_finished(arg_31_1) then
						return plot_class_data[arg_31_0[1]].order < plot_class_data[arg_31_1[1]].order
					else
						return arg_29_0:check_plot_is_finished(arg_31_0) and not arg_29_0:check_plot_is_finished(arg_31_1)
					end
				end)
				table.sort(arg_29_0.topActivityPlotList, function(arg_32_0, arg_32_1)
					if arg_29_0:check_plot_is_finished(arg_32_0) == arg_29_0:check_plot_is_finished(arg_32_1) then
						return plot_class_data[arg_32_0[1]].order < plot_class_data[arg_32_1[1]].order
					else
						return arg_29_0:check_plot_is_finished(arg_32_0) and not arg_29_0:check_plot_is_finished(arg_32_1)
					end
				end)
			end
		elseif arg_30_0.result == 2 then
			global_ShowBlockWords(TASK_REWARD_ONEKEY_WARN)
		end

		if arg_29_1 then
			arg_29_1(arg_30_0.result, arg_30_0)
		end
	end)
end

function var_0_0.getRunningPlotId(arg_33_0, arg_33_1)
	if not playermodel.runningPlots[arg_33_1] then
		return
	end

	local var_33_0 = playermodel.runningPlots[arg_33_1][var_0_4] + 1

	if playermodel.runningPlots[arg_33_1][var_0_4] + 1 > plot_class_data[arg_33_1].total_steps then
		return
	end

	return plot_class_data[arg_33_1]["step" .. var_33_0]
end

function var_0_0.getDailyPlots(arg_34_0)
	arg_34_0.dailyPlots = {}

	network:rpc("get_daily_plots", nil, function(arg_35_0)
		for iter_35_0, iter_35_1 in pairs(arg_35_0.dailyPlots) do
			arg_34_0.dailyPlots[iter_35_1] = true
		end
	end)
end

function var_0_0.receiveDailyPlot(arg_36_0, arg_36_1, arg_36_2)
	network:rpc("receive_daily_plot", {
		plotClassId = arg_36_1
	}, function(arg_37_0)
		if arg_37_0.result == 1 then
			arg_36_0.dailyPlots[arg_36_1] = nil

			local var_37_0 = {
				arg_37_0.plotinfo.plotClassId
			}

			var_37_0[2] = arg_37_0.plotinfo.step or 0
			playermodel.runningPlots[arg_37_0.plotinfo.plotClassId] = var_37_0

			table.insert(arg_36_0.topPlotList[arg_36_1], var_37_0)
			arg_36_0:update_plot_layer_config()
		elseif arg_37_0.result == 2 then
			cclog("任务不在每日任务队列中")
		elseif arg_37_0.result == 3 then
			cclog("任务已经触发")
		end
	end)
end

function var_0_0.checkIsUnlockMapLevel(arg_38_0, arg_38_1)
	if not playermodel.runningPlots[arg_38_1] then
		return
	end

	local var_38_0 = plot_data[plot_class_data[arg_38_1]["step" .. playermodel.runningPlots[arg_38_1][var_0_4] + 1]]

	if not plot_data[plot_class_data[arg_38_1]["step" .. playermodel.runningPlots[arg_38_1][var_0_4] + 1]] then
		return
	end

	if var_38_0.finish_condition == var_0_18.EXPLORE and var_38_0.finish_param4 then
		require("controller.explore_manager"):unlockMapLevel(var_38_0.finish_param1, var_38_0.finish_param4)
	end
end

function var_0_0:get_running_favor_plot_souls()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(playermodel.runningPlots) do
		if plot_class_data[iter_39_0].plot_class and (plot_class_data[iter_39_0].plot_class == var_0_19.FAVOR or plot_class_data[iter_39_0].plot_class == var_0_19.TRAVEL) and not self:check_plot_is_finished(iter_39_1) and plot_class_data[iter_39_0].major then
			var_39_0[plot_class_data[iter_39_0].major] = true
		end
	end

	return var_39_0
end

function var_0_0:remove_invalid_activity_plot()
	for iter_40_0, iter_40_1 in pairs(playermodel.runningPlots) do
		if plot_class_data[iter_40_0].plot_class == var_0_19.ACTIVITY and plot_class_data[iter_40_0].endtime and os.time() >= os.time(parse_time(plot_class_data[iter_40_0].endtime)) then
			playermodel.runningPlots[iter_40_0] = nil
		end
	end

	self:update_plot_layer_config()
end

function var_0_0.get_finished_plots(arg_41_0, arg_41_1)
	network:rpc("get_finished_plots", nil, function(arg_42_0)
		print(dump(arg_42_0))

		if arg_42_0.plots then
			local var_42_0 = {}

			for iter_42_0, iter_42_1 in pairs(arg_42_0.plots) do
				var_42_0[iter_42_1] = true
			end

			if arg_41_1 then
				arg_41_1(var_42_0)
			end
		end
	end)
end

function var_0_0:isHaveReward(arg_43_1)
	if arg_43_1 == PLOT_CLASS.NORMAL then
		if not self.topPlotList then
			return false
		end

		if next(self.topPlotList) == nil then
			return false
		end

		for iter_43_0, iter_43_1 in pairs(self.topPlotList) do
			if self:check_plot_is_finished(iter_43_1) then
				return true
			end
		end

		return false
	elseif arg_43_1 == PLOT_CLASS.ACTIVITY then
		if self.topActivityPlotList then
			return false
		end

		if next(self.topActivityPlotList) == nil then
			return false
		end

		for iter_43_2, iter_43_3 in pairs(self.topActivityPlotList) do
			if not self:check_plot_is_finished(iter_43_3) then
				return true
			end
		end

		return false
	end
end

function var_0_0.check_plot_is_finished_by_plotclassid(arg_44_0, arg_44_1)
	return not playermodel.runningPlots[arg_44_1]
end

return var_0_0
