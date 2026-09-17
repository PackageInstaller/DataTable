ActivityRechargeByJson = class("ActivityRechargeByJson", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local var_0_7 = config._DEBUG and 0 or 1
local time_check_manager = require("controller.time_check_manager")
local var_0_9
local activity_recharge_uiconfig_data = require("data.activity_template_ui_conf.activity_recharge_uiconfig_data")
local var_0_11 = {
	total_recharge = "condition_recharge_on",
	total_twist = "condition_twist_on"
}

setmetatable(var_0_11, {
	__index = function(arg_2_0, arg_2_1)
		return "condition_" .. arg_2_1 .. "_on"
	end
})

local var_0_12 = {
	total_recharge = "condition_recharge_off",
	total_twist = "condition_twist_off"
}

setmetatable(var_0_12, {
	__index = function(arg_3_0, arg_3_1)
		return "condition_" .. arg_3_1 .. "_off"
	end
})

local var_0_13 = {
	total_recharge = L_ACTIVITY_TOTAL_RECHARGE,
	total_twist = L_ACTIVITY_TOTAL_TWIST,
	reset_recharge_1 = L_ACTIVITY_TOTAL_RECHARGE
}

setmetatable(var_0_13, {
	__index = function(arg_4_0, arg_4_1)
		if arg_4_1:find("total_recharge") then
			return L_ACTIVITY_TOTAL_RECHARGE
		elseif arg_4_1:find("total_twist") then
			return L_ACTIVITY_TOTAL_TWIST
		elseif arg_4_1:find("consume_diamond") then
			return L_ACTIVITY_TOTAL_CONSUME_DIAMOND
		elseif arg_4_1:find("recharge_count") then
			return "累計チャージ日数"
		elseif arg_4_1:find("have_skin") then
			return L_ACTIVITY_TOTAL_HAVE_SKIN
		elseif arg_4_1:find("consume_giftcard") then
			return L_ACTIVITY_TOTAL_CONSUME_GIFTCARD
		elseif arg_4_1:find("nmsl") then
			return L_ACTIVITY_TOTAL_OPEN_BAG
		elseif arg_4_1:find("reset_recharge") then
			return L_ACTIVITY_TOTAL_RECHARGE
		end

		return ""
	end
})

local var_0_14 = {
	total_twist = "sure_btn_total_twist",
	reset_recharge = "sure_btn_reset_recharge",
	total_recharge = "sure_btn_total_recharge"
}

setmetatable(var_0_14, {
	__index = function(arg_5_0, arg_5_1)
		if arg_5_1:find("twist") then
			return "sure_btn_total_twist"
		end

		if arg_5_1:find("total_recharge") then
			return "sure_btn_total_recharge"
		end

		return "sure_btn_" .. arg_5_1
	end
})

local var_0_15 = {
	total_twist = "bg_total_twist",
	reset_recharge = "bg_reset_recharge",
	total_recharge = "bg_total_recharge"
}

setmetatable(var_0_15, {
	__index = function(arg_6_0, arg_6_1)
		return "bg_" .. arg_6_1
	end
})

local var_0_16 = {}
local var_0_17 = {
	width = 87,
	height = 100
}
local var_0_18 = 100

function ActivityRechargeByJson:getPath(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0
	local var_7_1 = self.activityPath .. arg_7_1 .. ((arg_7_2 or nil) and ("_" .. arg_7_2 or "")) .. ".png"

	var_0_16[self.activityid] = var_0_16[self.activityid] or {}

	if not var_0_16[self.activityid][var_7_1] then
		if cc.FileUtils:getInstance():isFileExist(var_7_1) then
			var_7_0 = var_7_1
		else
			if arg_7_3 then
				if arg_7_2 then
					if cc.FileUtils:getInstance():isFileExist(self.activityPath .. arg_7_3 .. ("_" .. arg_7_2 or "") .. ".png") then
						var_7_0 = self.activityPath .. arg_7_3 .. ((arg_7_2 or nil) and ("_" .. arg_7_2 or "")) .. ".png"

						goto label_7_0
					end
				end
			end

			var_7_0 = self.activityPath .. arg_7_1 .. ".png"
		end

		::label_7_0::

		var_0_16[self.activityid][var_7_1] = var_7_0
	else
		var_7_0 = var_0_16[self.activityid][var_7_1]
	end

	return var_7_0
end

function ActivityRechargeByJson:getBgPath(arg_8_1)
	local var_8_0
	local var_8_2

	if cc.FileUtils:getInstance():isFileExist("mainScenebg/activity/branch" .. self.activityid .. "/activityRecharge/" .. arg_8_1 .. ".png") then
		var_8_0 = "mainScenebg/activity/branch" .. self.activityid .. "/activityRecharge/" .. arg_8_1 .. ".png"
		var_8_2 = 0
	else
		var_8_0 = self.activityPath .. arg_8_1 .. ".png"
		var_8_2 = var_0_7
	end

	return var_8_0, var_8_2
end

local function var_0_19(arg_9_0)
	local var_9_5 = global_get_time_by_date(arg_9_0) - time_check_manager:getCurTime()
	local var_9_6 = math.floor(var_9_5 / 24 / 3600)
	local var_9_7 = math.floor((var_9_5 - var_9_6 * 24 * 3600) / 3600)
	local var_9_8 = math.floor((var_9_5 - var_9_6 * 24 * 3600 - var_9_7 * 3600) / 60)

	return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_9_6, var_9_7) or var_9_7 ~= 0 and string.format(L_TIME_TEXT[2], var_9_7, var_9_8) or string.format(L_TIME_TEXT[3], var_9_8)
end

function ActivityRechargeByJson:getConfValue(arg_10_1, arg_10_2)
	local var_10_0 = {
		reddotimg_posy_838 = 665,
		time_bg_posy_813 = 600,
		reddotimg_posy_888 = 650,
		reddotimg_posx_838 = 38,
		time_bg_posx = 410,
		time_bg_posy = 625,
		time_bg_posy_838 = 720,
		time_bg_posy_855 = 605,
		time_bg_posy_865 = 720,
		reddotimg_posx_888 = 38,
		time_bg_posx_838 = 220,
		reddotimg_posy_813 = 660,
		reddotimg_posy = 575,
		reddotimg_posy_865 = 660,
		time_bg_posy_888 = 700,
		reddotimg_posx = 55,
		reddotimg_posy_855 = 660,
		Label_score = {
			color_got = {
				g = 245,
				b = 114,
				r = 171
			},
			color_get = {
				g = 245,
				b = 114,
				r = 255
			},
			color = {
				g = 245,
				b = 114,
				r = 255
			}
		},
		Label_scoredes = {
			color_got = {
				g = 255,
				b = 255,
				r = 255
			},
			color_get = {
				g = 255,
				b = 255,
				r = 255
			},
			color = {
				g = 255,
				b = 255,
				r = 255
			}
		},
		Label_score_805 = {
			color_got = {
				g = 111,
				b = 127,
				r = 228
			},
			color_get = {
				g = 111,
				b = 127,
				r = 228
			},
			color = {
				g = 111,
				b = 127,
				r = 228
			}
		},
		Label_scoredes_805 = {
			color_got = {
				g = 111,
				b = 127,
				r = 228
			},
			color_get = {
				g = 111,
				b = 127,
				r = 228
			},
			color = {
				g = 111,
				b = 127,
				r = 228
			}
		},
		Label_score_813 = {
			color_got = {
				g = 0,
				b = 102,
				r = 0
			},
			color_get = {
				g = 0,
				b = 102,
				r = 0
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_scoredes_813 = {
			color_got = {
				g = 0,
				b = 102,
				r = 0
			},
			color_get = {
				g = 0,
				b = 102,
				r = 0
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_score_830 = {
			color_got = {
				g = 147,
				b = 255,
				r = 118
			},
			color_get = {
				g = 147,
				b = 255,
				r = 118
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_scoredes_830 = {
			color_got = {
				g = 147,
				b = 255,
				r = 118
			},
			color_get = {
				g = 147,
				b = 255,
				r = 118
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_score_855 = {
			color_got = {
				g = 107,
				b = 147,
				r = 104
			},
			color_get = {
				g = 107,
				b = 147,
				r = 104
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_scoredes_855 = {
			color_got = {
				g = 107,
				b = 147,
				r = 104
			},
			color_get = {
				g = 107,
				b = 147,
				r = 104
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_score_861 = {
			color_got = {
				g = 65,
				b = 65,
				r = 65
			},
			color_get = {
				g = 65,
				b = 65,
				r = 65
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_scoredes_861 = {
			color_got = {
				g = 65,
				b = 65,
				r = 65
			},
			color_get = {
				g = 65,
				b = 65,
				r = 65
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_score_863 = {
			color_got = {
				g = 65,
				b = 65,
				r = 65
			},
			color_get = {
				g = 65,
				b = 65,
				r = 65
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_scoredes_863 = {
			color_got = {
				g = 65,
				b = 65,
				r = 65
			},
			color_get = {
				g = 65,
				b = 65,
				r = 65
			},
			color = {
				g = 64,
				b = 64,
				r = 64
			}
		},
		Label_score_865 = {
			color_got = {
				g = 255,
				b = 255,
				r = 255
			},
			color_get = {
				g = 0,
				b = 0,
				r = 0
			},
			color = {
				g = 0,
				b = 0,
				r = 0
			}
		},
		Label_scoredes_865 = {
			color_got = {
				g = 255,
				b = 255,
				r = 255
			},
			color_get = {
				g = 0,
				b = 0,
				r = 0
			},
			color = {
				g = 0,
				b = 0,
				r = 0
			}
		},
		Label_score_872 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 0,
				b = 0,
				r = 0
			},
			color = {
				g = 0,
				b = 0,
				r = 0
			}
		},
		Label_scoredes_872 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 0,
				b = 0,
				r = 0
			},
			color = {
				g = 0,
				b = 0,
				r = 0
			}
		},
		Label_score_874 = {
			color_got = {
				g = 255,
				b = 255,
				r = 255
			},
			color_get = {
				g = 255,
				b = 255,
				r = 255
			},
			color = {
				g = 255,
				b = 255,
				r = 255
			}
		},
		Label_scoredes_874 = {
			color_got = {
				g = 255,
				b = 255,
				r = 255
			},
			color_get = {
				g = 255,
				b = 255,
				r = 255
			},
			color = {
				g = 255,
				b = 255,
				r = 255
			}
		},
		Label_score_881 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 0,
				b = 0,
				r = 0
			},
			color = {
				g = 0,
				b = 0,
				r = 0
			}
		},
		Label_scoredes_881 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 0,
				b = 0,
				r = 0
			},
			color = {
				g = 0,
				b = 0,
				r = 0
			}
		},
		Label_score_888 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 233,
				b = 86,
				r = 255
			},
			color = {
				g = 233,
				b = 86,
				r = 255
			}
		},
		Label_scoredes_888 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 233,
				b = 86,
				r = 255
			},
			color = {
				g = 233,
				b = 86,
				r = 255
			}
		},
		Label_scoredes_891 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 156,
				b = 62,
				r = 105
			},
			color = {
				g = 156,
				b = 62,
				r = 105
			}
		},
		Label_score_891 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 156,
				b = 62,
				r = 105
			},
			color = {
				g = 156,
				b = 62,
				r = 105
			}
		},
		Label_scoredes_892 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 65,
				b = 65,
				r = 255
			},
			color = {
				g = 65,
				b = 65,
				r = 255
			}
		},
		Label_score_892 = {
			color_got = {
				g = 0,
				b = 0,
				r = 0
			},
			color_get = {
				g = 65,
				b = 65,
				r = 255
			},
			color = {
				g = 65,
				b = 65,
				r = 255
			}
		}
	}

	return var_10_0[arg_10_1 .. "_" .. self.activityid] or var_10_0[arg_10_1]
end

function ActivityRechargeByJson.create(arg_11_0, arg_11_1)
	local var_11_0 = ActivityRechargeByJson.new()

	var_11_0:init(arg_11_1)

	return var_11_0
end

function ActivityRechargeByJson:init(arg_12_1)
	var_0_9 = self
	self.activityid = arg_12_1.activityID

	assert(activity_task_conf[self.activityid], "data.activity_modules.activity_task_conf not find activityid:" .. self.activityid)

	self.activityPath = "Activities/activity" .. self.activityid .. "/activitytask/"
	self.templatePath = "mainScenebg/activity/recharge/128/"
	self.showmodule = arg_12_1.showmodule

	TextureManager:loadLayerTextures({
		"Activities_activity" .. self.activityid .. "_activitytask"
	})
	;(function(...)
		self.modulegroupconf = {}

		while activity_task_conf[self.activityid]["module" .. 1] do
			table.insert(self.modulegroupconf, {
				key = activity_task_conf[self.activityid]["module" .. 1],
				previewitemid = activity_task_conf[self.activityid]["previewitemid" .. 1]
			})
		end

		self.usemodule = self.modulegroupconf[1].key
	end)()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile("Activity_recharge_" .. self.activityid .. (config._DEBUG and ".json" or ".ExportJson"))
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setTouchEnabled(true)
	self:addChild(self.rootLayer, 1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_mask"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			LayerManager:removePopLayer()
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_mask"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_mask"):setPositionY(-GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):setScaleY(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.1, 1, 1)))
	self:registerScriptHandler(function(arg_16_0)
		if arg_16_0 == "exit" then
			if arg_12_1 and arg_12_1.exit_set_bright_callback then
				arg_12_1.exit_set_bright_callback()
			end

			self.activity = false
			var_0_9 = nil

			TextureManager:removeLayerTextures({
				"Activities_activity" .. self.activityid .. "_activitytask"
			})
		end
	end)
	self:initUI()
	self:initData(function(...)
		self:updateUI()
		self:scrollTableView()
	end)
	self:registerRechargeEvent()
end

function ActivityRechargeByJson:initData(arg_18_1)
	self.finishtime = activity_conf_data[self.activityid].finishtime
	self.des = activity_conf_data[self.activityid].proceed_des1
	self.tasklist = nil
	self.resttime = activity_manager:get_module_resettime(self.activityid, "reset_recharge")
	self.starttime = activity_manager:get_module_starttime(self.activityid, "reset_recharge_1")

	if self.resttime then
		self.stages = {}

		for iter_18_0 in string.gmatch(self.resttime, "[^,]+") do
			table.insert(self.stages, iter_18_0)
		end
	end

	if self.starttime then
		table.insert(self.stages, 1, self.starttime)
	end

	self:updateData(arg_18_1)
end

function ActivityRechargeByJson:scrollTableView()
	local var_19_0 = 1

	for iter_19_0, iter_19_1 in pairs(self.tasklist) do
		if iter_19_1.status == 0 and iter_19_1.percent == 100 then
			var_19_0 = iter_19_0

			break
		end
	end

	for iter_19_2, iter_19_3 in pairs(self.tasklist) do
		if iter_19_3.status == 0 then
			var_19_0 = var_19_0 ~= 1 and var_19_0 or iter_19_2

			break
		end
	end

	if not self.tableView then
		return
	end

	self.tableView:scrollToPercent(var_19_0 / #self.tasklist * 100, nil, false)
end

function ActivityRechargeByJson:updateData(arg_20_1)
	activity_manager:getActivityTaskList(self.activityid, nil, function(arg_22_0, arg_22_1)
		if tolua.isnull(self) then
			return
		end

		if #arg_22_1.list == 0 then
			hx_print("服务器拖了吗")
		end

		self.tasklist = arg_22_1.list
		self.statvalue = arg_22_1.statvalue
		self.score = arg_22_1.statvalue or -1

		table.sort(self.tasklist, function(arg_23_0, arg_23_1)
			return task_data[arg_23_0.taskid].order < task_data[arg_23_1.taskid].order
		end)

		if self.usemodule == "have_skin" then
			if not task_data[self.tasklist[1].taskid].need_target_string or not task_data[self.tasklist[1].taskid].need_target_string:find(",") then
				hx_print(string.format("taksid %d 没填 need_target_string, 应该为皮肤id组成的字符串使用【,】分隔", self.tasklist[1].taskid))

				return
			end

			local var_22_0 = {}

			for iter_22_0, iter_22_1 in pairs(task_data[self.tasklist[1].taskid].need_target_string:split(",")) do
				table.insert(var_22_0, tonumber(iter_22_1))
			end

			self.score = 0

			for iter_22_2, iter_22_3 in pairs(var_22_0) do
				if item_manager:getItemNumber(iter_22_3) > 0 then
					self.score = self.score + 1
				end
			end
		end

		self:updateAlert()

		if arg_20_1 then
			arg_20_1()
		end
	end, false, (function(arg_21_0)
		if string.find(arg_21_0, "total_recharge") then
			return "total_recharge"
		elseif string.find(arg_21_0, "reset_recharge") then
			return "total_recharge_can_reset"
		elseif string.find(arg_21_0, "total_twist") then
			for iter_21_0, iter_21_1 in pairs((self:getActivityTaskIndexData())) do
				if iter_21_1.usemodule == self.usemodule and (task_data[iter_21_1.taskid].needs_type == E_TWIST_COUNT_ACTIVITY or task_data[iter_21_1.taskid].needs_type == E_MONTHLY_TWIST_COUNT_ACTIVITY) then
					return "twist_count_activity" .. task_data[iter_21_1.taskid].needs_target
				end
			end
		elseif string.find(arg_21_0, "total_consume_diamond") then
			return "cost_diamond"
		elseif string.find(arg_21_0, "consume_giftcard") then
			return "use_giftcard"
		elseif string.find(arg_21_0, "nmsl") then
			return "open_activity_bag"
		end

		return arg_21_0
	end)(self.usemodule), self.usemodule)
end

function ActivityRechargeByJson:updateAlert()
	activity_manager:update_alert(self.activityid, self.usemodule, self.tasklist)
end

function ActivityRechargeByJson.getModuleBtnHandler(arg_25_0)
	return function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_26_0.islocked then
			global_ShowBlockWords("该系列任务暂未开启~")

			return
		end

		arg_25_0.usemodule = arg_26_0.key

		arg_25_0:updateData(function(...)
			arg_25_0.tableView:reloadData()
			arg_25_0:scrollTableView()
			arg_25_0:updateUI()
		end)
	end
end

function ActivityRechargeByJson:initUI(...)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(self.showmodule or {}) do
		self.usemodule = self.showmodule[1]
	end

	;(function(...)
		if not self.modulegroupconf then
			return
		end

		local var_29_0 = {}

		for iter_29_0, iter_29_1 in pairs(self.modulegroupconf) do
			if var_28_0 and next(var_28_0) and not var_28_0[iter_29_1.key] then
				var_29_0[iter_29_1.key] = true
			end

			local var_29_1

			if iter_29_1.starttime then
				var_29_1 = iter_29_1.starttime
			elseif iter_29_1.key:find("twist") then
				for iter_29_2, iter_29_3 in pairs((require(string.format("data.activity_%d.%s", self.activityid, activity_conf_data[self.activityid].taskindexfile)))) do
					if iter_29_1.key == iter_29_3.usemodule then
						var_29_1 = require("data.twist_config_data")[task_data[iter_29_3.taskid].jump % 100000].starttime

						break
					end
				end
			end

			if var_29_1 and time_check_manager:getCurTime() < global_get_time_by_date(var_29_1) then
				print("与该任务模块相关的跳转未生效, 锁定该任务模块", iter_29_1.key)

				var_29_0[iter_29_1.key] = true
				iter_29_1.islocked = true
			end
		end
	end)()

	if self.modulegroupconf and next(self.modulegroupconf) and #self.modulegroupconf > 1 then
		print_lua_table(self.modulegroupconf)

		for iter_28_2, iter_28_3 in pairs(self.modulegroupconf) do
			print("Button_module_group_" .. iter_28_2)

			local var_28_1 = ccui.Helper:seekWidgetByName(self.rootpanel, "Button_module_group_" .. iter_28_2)

			var_28_1:loadTextures(self:getPath("page_btn_" .. iter_28_3.key .. "_on"), nil, self:getPath("page_btn_" .. iter_28_3.key .. "_on"), var_0_7)

			var_28_1.key = iter_28_3.key
			var_28_1.alertkey = iter_28_3.key
			var_28_1.islocked = iter_28_3.islocked

			var_28_1:addTouchEventListener(self:getModuleBtnHandler())
			hx_print("btn.position_" .. iter_28_2)
			print("positionx:", var_28_1:getPositionX(), "positiony:", var_28_1:getPositionY())

			local var_28_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_7)

			var_28_2:setName("Button_module_group_" .. iter_28_2 .. "_reddot")
			var_28_2:setVisible(false)
			self.rootpanel:addChild(var_28_2, var_28_1:getLocalZOrder() + 1)
			var_28_2:setPosition(var_28_1:getPositionX() + self:getConfValue("reddotimg_posx"), self:getConfValue("reddotimg_posy"))
		end
	end

	self.Label_des_list = {}

	local var_28_3 = 1

	while ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des_" .. var_28_3) do
		table.insert(self.Label_des_list, ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des_" .. var_28_3))

		var_28_3 = var_28_3 + 1
	end

	self:replaceUI()
	self:runIntoAction()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.usemodule == "have_skin" then
			self:pushSkinCollectLayer()
		else
			goto_complete_system({
				jump_to_system = task_data[self.tasklist[1].taskid].jump
			})
		end
	end)
	self:updateBaseUI()
end

function ActivityRechargeByJson:replaceUI(...)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):setVisible(false)

	self.cloneCell = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell")

	local var_31_0 = self:getPath("ornament")

	if var_31_0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_ornament"):loadTexture(var_31_0, var_0_7)
	end

	local var_31_1 = self:getPath("progress_bg")

	if var_31_1 and (not self.stages or not string.find(self.usemodule, "reset_recharge")) then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_progress_bg"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_progress_bg"):loadTexture(var_31_1, var_0_7)
	end

	local var_31_2 = self:getPath("progress")

	if var_31_2 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_progress"):loadTexture(var_31_2, var_0_7)
	end

	self.cloneCell:getChildByName("Panel_item1"):setName("Panel_item1111")
	self.cloneCell:getChildByName("Panel_item2"):setName("Panel_item2222")
	self.cloneCell:getChildByName("Panel_item1111"):setVisible(false)
	self.cloneCell:getChildByName("Panel_item2222"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cell_mask"):setVisible(false)

	local var_31_3 = ccui.Helper:seekWidgetByName(self.cloneCell, "Item_scrollarena"):getPosition()

	ccui.Helper:seekWidgetByName(self.cloneCell, "Item_scrollarena"):setVisible(false)

	local var_31_4 = ccui.ScrollView:create()

	var_31_4:setBounceEnabled(true)
	var_31_4:setInnerContainerSize({
		width = 300,
		height = 100
	})
	var_31_4:setDirection(ccui.ScrollViewDir.horizontal)
	var_31_4:setName("cellscrollview")
	var_31_4:setTouchEnabled(false)
	self.cloneCell:addChild(var_31_4)
	var_31_4:setPositionY(15)
	var_31_4:setContentSize((ccui.Helper:seekWidgetByName(self.cloneCell, "Item_scrollarena"):getContentSize()))

	local var_31_5 = 1

	while var_31_5 <= 5 do
		local var_31_6 = ccui.Layout:create()

		var_31_6:setName("Panel_item" .. var_31_5)
		var_31_4:addChild(var_31_6)

		var_31_5 = var_31_5 + 1

		var_31_6:setContentSize(var_0_17)
		var_31_6:setPositionX(var_31_5 * var_0_18 - 200)
	end

	local var_31_7 = ccui.Layout:create()

	var_31_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_31_7:setName("item_touch_panel")
	var_31_7:setTouchEnabled(true)
	var_31_7:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_32_0

		if self.modulegroupconf and next(self.modulegroupconf) then
			for iter_32_0, iter_32_1 in pairs(self.modulegroupconf) do
				if iter_32_1.key == self.usemodule then
					var_32_0 = iter_32_1.previewitemid
				end
			end

			if var_32_0 then
				LayerManager:pushInLayer("PopShowGilrPreviewLayer", {
					itemid = var_32_0
				})
			end
		end
	end)
	self.rootpanel:addChild(var_31_7, 100)
end

function ActivityRechargeByJson:updateTitle()
	if not self.closeBtn then
		local var_33_0 = ccui.Button:create(self.activityPath .. "btn_close.png", nil, self.activityPath .. "btn_close.png", var_0_7)

		self.rootpanel:addChild(var_33_0)
		var_33_0:setPosition(600, 940)
		var_33_0:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
				LayerManager:removePopLayer()
			end)))
		end)

		self.closeBtn = var_33_0
	end

	if self.stages and string.find(self.usemodule, "reset_recharge") then
		if not self.time_bg then
			local var_33_1 = ccui.ImageView:create(self.activityPath .. "title.png", var_0_7)

			self.rootpanel:addChild(var_33_1)

			self.title = var_33_1

			var_33_1:setPosition(410, 820)

			local var_33_2 = ccui.ImageView:create(self.activityPath .. "time_bg.png", var_0_7)

			self.rootpanel:addChild(var_33_2)

			self.time_bg = var_33_2

			var_33_2:setPosition(self:getConfValue("time_bg_posx"), self:getConfValue("time_bg_posy"))

			local var_33_3 = 0
			local var_33_4 = ""

			for iter_33_0, iter_33_1 in pairs(self.stages) do
				if global_get_time_by_date(iter_33_1) < time_check_manager:getCurTime() and global_get_time_by_date(self.stages[iter_33_0 + 1]) > time_check_manager:getCurTime() then
					var_33_4 = var_0_19(self.stages[iter_33_0 + 1])
					var_33_3 = iter_33_0

					break
				end
			end

			local var_33_5 = cc.Label:createWithTTF(string.format(L_ACTRECHARGETP[1], var_33_3, #self.stages - 1), FONT_NAME, 22)

			var_33_2:addChild(var_33_5)
			var_33_5:setPosition(70, 20)

			local var_33_6 = cc.Label:createWithTTF(var_33_4 .. L_ACTRECHARGETP[2], FONT_NAME, 22)

			var_33_2:addChild(var_33_6)
			var_33_6:setPosition(250, 20)
		end

		self.time_bg:setVisible(true)
		self.title:setVisible(true)
	else
		if self.title then
			self.title:setVisible(false)
		end

		if self.time_bg then
			self.time_bg:setVisible(false)
		end

		if self.tableView then
			-- block empty
		end
	end
end

function ActivityRechargeByJson:updateBaseUI(...)
	if not self.stages or not string.find(self.usemodule, "reset_recharge") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setString(L_TIME_REST2 .. L_TIME .. var_0_19(self.finishtime))
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setVisible(false)
	end

	local var_36_0 = 1

	while activity_task_conf[self.activityid]["module" .. 1] do
		if activity_task_conf[self.activityid]["module" .. 1] == self.usemodule then
			var_36_0 = 1
		end
	end

	self.index = var_36_0
	self.Label_des = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_des_" .. self.index)

	for iter_36_0, iter_36_1 in ipairs(self.Label_des_list) do
		iter_36_1:setVisible(iter_36_0 == self.index)
	end

	if not activity_task_conf[self.activityid] then
		self.Label_des:setString(activity_conf_data[self.activityid]["proceed_des" .. var_36_0])

		if not activity_conf_data[self.activityid]["proceed_des" .. var_36_0] and config._DEBUG then
			self.Label_des:setString("谁来填下activity_conf_data[" .. self.activityid .. "].proceed_des" .. var_36_0)
		end
	elseif not self.stages or not string.find(self.usemodule, "reset_recharge") then
		self.Label_des:setVisible(true)
		self.Label_des:setString(activity_task_conf[self.activityid]["des" .. var_36_0])

		if not activity_task_conf[self.activityid]["des" .. var_36_0] and config._DEBUG then
			self.Label_des:setString("谁来填下activity_conf_data[" .. self.activityid .. "].des" .. var_36_0)
		end
	else
		self.Label_des:setVisible(false)
	end

	local var_36_2 = 1

	while var_36_2 <= #self.modulegroupconf and #self.modulegroupconf ~= 1 do
		local var_36_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_36_2)

		if var_36_3.key == self.usemodule then
			var_36_3:loadTextures(self:getPath("page_btn_" .. var_36_3.key .. "_on"), nil, self:getPath("page_btn_" .. var_36_3.key .. "_on"), var_0_7)
		else
			var_36_3:loadTextures(self:getPath("page_btn_" .. var_36_3.key .. "_off"), nil, self:getPath("page_btn_" .. var_36_3.key .. "_off"), var_0_7)
		end

		if activity_manager:getAlertStatus(self.activityid, var_36_3.alertkey) then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_36_2 .. "_reddot"):setVisible(true)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. var_36_2 .. "_reddot"):setVisible(false)
		end

		var_36_2 = var_36_2 + 1
	end

	local var_36_4 = self:getPath(var_0_14[self.usemodule])

	if var_36_4 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):loadTextures(var_36_4, var_36_4, var_36_4, var_0_7)
	end

	local var_36_5, var_36_6 = self:getBgPath(var_0_15[self.usemodule])

	if var_36_5 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):loadTexture(var_36_5, var_36_6)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString("")
	self:devmode_bugfix()
end

function ActivityRechargeByJson:updateUI(...)
	self:updateTitle()
	self:updateBaseUI()
	self:updateShowingCells()

	local var_37_0

	for iter_37_0, iter_37_1 in pairs(self.tasklist) do
		if not var_37_0 and iter_37_1.status == 0 then
			var_37_0 = iter_37_1.need
		end
	end

	if var_37_0 then
		if var_37_0 <= self.score then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString(L_ACTIVITY_TOTAL_AWARD)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString(string.format(var_0_13[self.usemodule], var_37_0 - self.score))

			if self.activityid == 861 and self.usemodule == "total_recharge_1" then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString(string.format(L_ACTIVITY_TOTAL_CONSUME_ROULETTE_KEYITEM, var_37_0 - self.score))
			end
		end
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setString("")
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setVisible(self.usemodule ~= "pass_level")

	if ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure") then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_totalrecharge"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):getPositionY() - 50)
	end

	if activity_task_conf[self.activityid].button_hide and activity_task_conf[self.activityid].button_hide == LayerManager:getActiveLayerName() then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setVisible(false)
	end
end

function ActivityRechargeByJson:updateShowingCells(...)
	if not self.tableView then
		self:createTableview()
	end

	local var_38_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):getContentSize()

	var_38_0.height = var_38_0.height

	local var_38_1, var_38_2 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = var_38_0,
		maxcount = #self.tasklist
	})

	for iter_38_0 = var_38_1, var_38_2 do
		self.tableView:updateCellAtIndex(iter_38_0)
	end

	self.tableView:reloadData()
end

function ActivityRechargeByJson:createTableview(...)
	self.tableView = cc.TableView:create((ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getContentSize()))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_41_0, arg_41_1)
		return 620, ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_cell"):getContentSize().height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_40_0, arg_40_1)
		local var_40_0 = arg_40_0:dequeueCell() or cc.TableViewCell:create()

		if not var_40_0:getChildByName("sp") then
			local var_40_1 = self:createSp()

			var_40_1:setName("sp")
			var_40_1:setAnchorPoint(cc.p(0, 0))
			var_40_1:setPosition(cc.p(0, 0))

			if self.activityid == 573 then
				var_40_1:setPosition(cc.p(-50, 0))
			end

			var_40_0:addChild(var_40_1)
		end

		var_40_0:getChildByName("sp"):update(arg_40_1 + 1)

		return var_40_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_42_0, arg_42_1)
		return #self.tasklist
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()

	local var_39_0 = ccui.Layout:create()

	var_39_0:setPosition(cc.p(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getPositionX(), (ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getPositionY())))
	var_39_0:setContentSize(cc.size(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getContentSize().width, 200))
	var_39_0:setAnchorPoint(cc.p(0, 1))
	var_39_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_39_0:setTouchEnabled(true)
	var_39_0:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			LayerManager:removePopLayer()
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getParent():addChild(var_39_0, ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_scrollarena"):getLocalZOrder() + 1)
end

function ActivityRechargeByJson:createSp(...)
	local var_45_0 = self.cloneCell:clone()

	var_45_0:setVisible(true)

	while ccui.Helper:seekWidgetByName(var_45_0, "Panel_item" .. 1) do
		local var_45_1 = ccui.Helper:seekWidgetByName(var_45_0, "Panel_item" .. 1)
		local var_45_2 = ItemSpriteActivityRecharge:createSignItem()

		var_45_2:setName("sp")
		var_45_2:setPositionX(var_45_1:getContentSize().width / 2)
		var_45_2:setPositionY(var_45_1:getContentSize().height / 2)
		var_45_1:addChild(var_45_2)
		var_45_2:setInfoTouchEvent(true)
		var_45_2:setSwallowTouches(false)
	end

	ccui.Helper:seekWidgetByName(var_45_0, "Button_award"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(var_45_0, "Button_award"):addTouchEventListener(function(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_46_0:isBright() then
			return
		end

		if math.abs(arg_46_0:getTouchBeganPosition().y - arg_46_0:getTouchEndPosition().y) > 50 then
			return
		end

		arg_46_0:setBright(false)
		self:getAward(arg_46_0.id, function(...)
			arg_46_0:setBright(true)
		end)
	end)

	function var_45_0:update(arg_48_1)
		local var_48_9000
		local var_48_0 = self:getPath("cell_bg")

		var_45_0:setContentSize(620, 120)
		ccui.Helper:seekWidgetByName(var_45_0, "Button_cell"):loadTextures(self:getPath("cell_bg", self.usemodule), self:getPath("cell_bg", self.usemodule), self:getPath("cell_bg", self.usemodule), var_0_7)
		ccui.Helper:seekWidgetByName(var_45_0, "Button_cell"):loadTextures(var_48_0, var_48_0, var_48_0, var_0_7)
		ccui.Helper:seekWidgetByName(var_45_0, "Button_award"):setPositionX(510)
		var_45_0:getChildByName("cellscrollview"):setPositionX(190)

		self.id = arg_48_1
		ccui.Helper:seekWidgetByName(var_45_0, "Button_award").id = arg_48_1

		local var_48_1 = self.tasklist[arg_48_1]
		local var_48_2 = self.tasklist[arg_48_1].taskid
		local var_48_4 = self.tasklist[arg_48_1].status
		local var_48_5 = drop_manager:getDropMsg(task_data[self.tasklist[arg_48_1].taskid].drop)

		table.sort(var_48_5.equips, function(arg_49_0, arg_49_1)
			return arg_49_0._index < arg_49_1._index
		end)

		local var_48_6 = {}

		if var_48_5.diamond > 0 then
			table.insert(var_48_6, {
				itemid = "diamond",
				num = var_48_5.diamond,
				name = L_DIAMOND
			})
		end

		if var_48_5.gold > 0 then
			table.insert(var_48_6, {
				itemid = "gold",
				num = var_48_5.gold,
				name = L_GOLD
			})
		end

		local var_48_7 = {}

		for iter_48_0, iter_48_1 in pairs(var_48_5.equips) do
			table.insert(var_48_7, {
				itemid = iter_48_1.dropid,
				num = iter_48_1.dropNum,
				name = item_data[iter_48_1.dropid].name,
				item_attr = iter_48_1.item_attr
			})
		end

		for iter_48_2, iter_48_3 in pairs(var_48_7) do
			table.insert(var_48_6, iter_48_3)
		end

		while ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1) do
			ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):setVisible(false)

			if var_48_6[1] then
				ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):setVisible(true)
				ccui.Helper:seekWidgetByName(self, "Panel_item" .. 1):getChildByName("sp"):updateSignItemByItemid(var_48_6[1].itemid, var_48_6[1].num, nil, nil, nil, "public/box/box_activity_recharge_", var_48_6[1].item_attr)
			end
		end

		local var_48_9
		local var_48_10

		if self.activityid >= 151 then
			var_48_9 = task_data[self.tasklist[arg_48_1].taskid].name
			var_48_10 = task_data[self.tasklist[arg_48_1].taskid].task_des
		else
			var_48_9 = string.match(task_data[self.tasklist[arg_48_1].taskid].name, "%d+")
			var_48_10 = string.match(task_data[self.tasklist[arg_48_1].taskid].name, "%D+")
		end

		ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("get_award", self.usemodule), self:getPath("get_award", self.usemodule), self:getPath("get_award", self.usemodule), var_0_7)
		self:getChildByName("Label_score"):setString(var_48_9)
		self:getChildByName("Label_scoredes"):setString(var_48_10)

		local var_48_11 = self:getChildByName("Label_score")
		local var_48_12 = var_48_11:getContentSize().width + var_48_9000
		local var_48_13 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

		self:getChildByName("Label_score").setPositionX(self:getChildByName("Label_scoredes").getContentSize(var_48_11).width, var_48_13:getPositionX() - self:getChildByName("Label_scoredes").getContentSize(var_48_13).width / 2)

		local var_48_14 = ccui.Helper:seekWidgetByName(self.cloneCell, "Label_score")

		self:getChildByName("Label_scoredes"):setPositionX(var_48_14:getPositionX() + self:getChildByName("Label_score").getContentSize(var_48_14).width / 2)
		self:getChildByName("Label_score"):setPositionY(ccui.Helper:seekWidgetByName(self.cloneCell, "Label_scoredes"):getPositionY())

		local var_48_15 = self:getPath(var_0_12[self.usemodule])

		if var_48_15 then
			ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(var_48_15, var_0_7)
		end

		local var_48_16 = self:getConfValue("Label_scoredes")

		if var_48_16 and var_48_16.color then
			self:getChildByName("Label_scoredes"):setColor(var_48_16.color)
		end

		ccui.Helper:seekWidgetByName(self, "Image_cell_mask"):setVisible(false)
		self:getChildByName("Label_scoredes"):setColor(self:getConfValue("Label_scoredes").color)
		self:getChildByName("Label_score"):setColor(self:getConfValue("Label_score").color)

		if var_48_1 and var_48_1.percent and var_48_1.percent < 100 then
			ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("get_late", self.usemodule), self:getPath("get_late", self.usemodule), self:getPath("get_late", self.usemodule), var_0_7)

			local var_48_17 = self:getPath("cell_bg_late", self.usemodule, "cell_bg")

			ccui.Helper:seekWidgetByName(var_45_0, "Button_cell"):loadTextures(var_48_17, var_48_17, var_48_17, var_0_7)

			local var_48_18 = self:getConfValue("Label_scoredes")

			if var_48_18 and var_48_18.color_late then
				self:getChildByName("Label_scoredes"):setColor(var_48_18.color_late)
			end

			local var_48_19 = self:getConfValue("Label_score")

			if var_48_19 and var_48_19.color_late then
				self:getChildByName("Label_score"):setColor(var_48_19.color_late)
			end
		end

		if var_48_1 and var_48_1.percent and var_48_1.percent == 100 then
			local var_48_20 = self:getPath(var_0_11[self.usemodule])

			if var_48_20 then
				ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(var_48_20, var_0_7)
			end

			local var_48_21 = self:getPath("cell_bg", self.usemodule, "cell_bg")

			ccui.Helper:seekWidgetByName(var_45_0, "Button_cell"):loadTextures(var_48_21, var_48_21, var_48_21, var_0_7)

			local var_48_22 = self:getConfValue("Label_scoredes")

			if var_48_22 and var_48_22.color_get then
				self:getChildByName("Label_scoredes"):setColor(var_48_22.color_get)
			end

			local var_48_23 = self:getConfValue("Label_score")

			if var_48_23 and var_48_23.color_get then
				self:getChildByName("Label_score"):setColor(var_48_23.color_get)
			end
		end

		if var_48_4 == 1 then
			ccui.Helper:seekWidgetByName(self, "Image_condition"):loadTexture(self:getPath(var_0_11[self.usemodule]), var_0_7)
			ccui.Helper:seekWidgetByName(self, "Button_award"):loadTextures(self:getPath("got_btn", self.usemodule), self:getPath("got_btn", self.usemodule), self:getPath("got_btn", self.usemodule), var_0_7)

			local var_48_24 = self:getPath("cell_bg_got", self.usemodule, "cell_bg")

			ccui.Helper:seekWidgetByName(var_45_0, "Button_cell"):loadTextures(var_48_24, var_48_24, var_48_24, var_0_7)

			local var_48_25 = self:getConfValue("Label_scoredes")

			if var_48_25 and var_48_25.color_got then
				self:getChildByName("Label_scoredes"):setColor(var_48_25.color_got)
			end

			local var_48_26 = self:getConfValue("Label_score")

			if var_48_26 and var_48_26.color_got then
				self:getChildByName("Label_score"):setColor(var_48_26.color_got)
			end
		end

		local function var_48_27(...)
			ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setVisible(self.usemodule ~= "pass_level")
			ccui.Helper:seekWidgetByName(self, "Image_progress"):setVisible(self.usemodule ~= "pass_level")

			if ccui.Helper:seekWidgetByName(self, "Image_mark") then
				ccui.Helper:seekWidgetByName(self, "Image_mark"):setVisible(self.usemodule ~= "pass_level")
			end

			if self.usemodule == "pass_level" then
				return
			end

			ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height / 2)

			if self.id == 1 then
				ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height / 2)
			elseif self.id == #self.tasklist then
				ccui.Helper:seekWidgetByName(self, "Image_progress_bg"):setPositionY(self:getContentSize().height)
			end

			if self.tasklist[arg_48_1 - 1] then
				local var_50_1 = self.tasklist[arg_48_1 - 1].taskid or nil
				local var_50_2

				if self.tasklist[arg_48_1 + 1] then
					var_50_2 = self.tasklist[arg_48_1 + 1].taskid or nil

					local var_50_3

					if task_data[var_50_1] then
						var_50_3 = task_data[var_50_1].needs_num or nil
					end
				end
			end

			local var_50_4 = task_data[var_48_2].needs_num
			local var_50_5

			if task_data[var_50_2] then
				var_50_5 = task_data[var_50_2].needs_num or nil
			end

			local var_50_6 = var_50_4
			local var_50_7 = var_50_4

			var_50_6 = var_50_3 and (var_50_3 + var_50_4) / 2 or 0

			if var_50_5 then
				var_50_7 = (var_50_5 + var_50_4) / 2
			end

			local var_50_8 = 0

			var_50_8 = var_50_7 <= self.score and var_50_7 == var_50_4 and 0 or var_50_4 > self.score and (1 - (self.score - var_50_6) / (var_50_4 - var_50_6)) / 2 + 0.5 + 1 or 1 - (self.score - var_50_4) / (var_50_7 - var_50_4) / 2 - 0.5 + 1

			ccui.Helper:seekWidgetByName(self, "Image_progress"):setScaleY(1)

			if var_50_8 < 1 then
				if self.id == #self.tasklist then
					ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(1.5 * self:getContentSize().height)
				else
					ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(1 * self:getContentSize().height)
				end
			else
				ccui.Helper:seekWidgetByName(self, "Image_progress"):setPositionY(var_50_8 * self:getContentSize().height)
			end
		end

		if not self.stages or not string.find(self.usemodule, "reset_recharge") then
			var_48_27()
		else
			var_48_27()
		end
	end

	return var_45_0
end

function ActivityRechargeByJson:getAward(arg_51_1, arg_51_2)
	if self.tasklist[arg_51_1].status == 1 then
		global_ShowBlockWords(L_BUTTON_TEXT.Got)

		if arg_51_2 then
			arg_51_2()
		end

		return
	end

	activity_manager:getTaskReward(self.activityid, self.tasklist[arg_51_1].taskid, function(arg_52_0, arg_52_1)
		if arg_52_0 == 1 then
			global_gain(arg_52_1)
			self:updateData(function(...)
				self:updateUI()

				if arg_51_2 then
					arg_51_2()
				end
			end)
		elseif arg_52_0 == 3 then
			if self.usemodule:find("have_skin") then
				self:pushSkinCollectLayer()
			else
				goto_complete_system({
					jump_to_system = task_data[self.tasklist[arg_51_1].taskid].jump
				})
			end

			if arg_51_2 then
				arg_51_2()
			end
		end
	end)
end

function ActivityRechargeByJson:runIntoAction()
	while 1 <= #self.modulegroupconf and #self.modulegroupconf ~= 1 do
		local var_54_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_module_group_" .. 1)

		var_54_0:runAction(cc.Sequence:create(cc.MoveTo:create(0, cc.p(var_54_0:getPositionX(), var_54_0:getPositionY() + 400)), cc.DelayTime:create(1 * 0.1), cc.MoveTo:create(0.1, cc.p(var_54_0:getPositionX(), var_54_0:getPositionY()))))
	end
end

function ActivityRechargeByJson:pushSkinCollectLayer(...)
	if not task_data[self.tasklist[1].taskid].need_target_string or not task_data[self.tasklist[1].taskid].need_target_string:find(",") then
		hx_print(string.format("taksid %d 没填 need_target_string, 应该为皮肤id组成的字符串使用【,】分隔", self.tasklist[1].taskid))

		return
	end

	local var_55_0 = {}

	for iter_55_0, iter_55_1 in pairs(task_data[self.tasklist[1].taskid].need_target_string:split(",")) do
		table.insert(var_55_0, tonumber(iter_55_1))
	end

	LayerManager:pushInLayer("SkinCollectLayer", {
		skinList = var_55_0
	})
end

function ActivityRechargeByJson:registerRechargeEvent(...)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_57_0)
		self:updateData(function(...)
			self:updateUI()
		end)
	end), self)
end

function ActivityRechargeByJson:getActivityTaskIndexData(...)
	if not activity_task_conf[self.activityid] then
		return require("data." .. activity_conf_data[self.activityid].taskindexfile)
	else
		return require(string.format("data.activity_%d.%s", self.activityid, activity_conf_data[self.activityid].taskindexfile))
	end
end

function ActivityRechargeByJson:devmode_bugfix(...)
	if config._DEBUG and not activity_task_conf[self.activityid] and self.activityid >= 170 then
		self.activityPath = "activitiesRes/activity" .. self.activityid .. "/activitytask/"

		if not self.modulegroupconf then
			if not cc.FileUtils:getInstance():isFileExist(not activity_task_conf[self.activityid] and "data." .. activity_conf_data[self.activityid].taskindexfile or string.format("data.activity_%d.%s", self.activityid, activity_conf_data[self.activityid].taskindexfile)) then
				function self.getActivityTaskIndexData(arg_61_0, ...)
					return require("data.activity_taskindex.activity_154_task_index_data")
				end
			end

			hx_print(string.format("activity_task_conf[%d] is nil", self.activityid))

			self.modulegroupconf = {
				"total_recharge"
			}
		end
	end
end
