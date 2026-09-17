require("view.Layer.ActivityEntranceLayer")

ActivitySpecialEntranceLayer = class("ActivitySpecialEntranceLayer", ActivityEntranceLayer)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivitySpecialEntranceLayer.create(arg_1_0, arg_1_1)
	local var_1_0 = ActivitySpecialEntranceLayer.new()

	var_1_0:initBg(arg_1_1)

	return var_1_0
end

function ActivitySpecialEntranceLayer:init(arg_2_1)
	self._showtype = arg_2_1.showtype

	self.super.init(self)
end

function ActivitySpecialEntranceLayer:updateEntranceListData()
	local var_3_0 = {}
	local var_3_1 = 1

	for iter_3_0, iter_3_1 in pairs(activity_manager:getActivityEntranceListByType(self._showtype)) do
		if iter_3_1.image ~= 3000001 then
			if iter_3_0 == 8061 then
				if not activity_manager:is_module_stat_finished(2, "sign") then
					var_3_0[var_3_1] = iter_3_1
					var_3_1 = var_3_1 + 1
				end
			else
				var_3_0[var_3_1] = iter_3_1

				if iter_3_1.finishtime then
					var_3_0[var_3_1].left_time = global_get_time_by_date(iter_3_1.finishtime) - time_check_manager:getCurTime()
				end

				var_3_1 = var_3_1 + 1
			end
		end
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		if arg_4_0.isbigBanner == arg_4_1.isbigBanner then
			return arg_4_0.order < arg_4_1.order
		else
			return arg_4_0.isbigBanner and not arg_4_1.isbigBanner
		end
	end)
	print(dump(var_3_0))

	self.listLen = var_3_1 - 1
	self.entranceActivityList = var_3_0
	self.entranceActivityList[1].isbigBanner = 1
	self.cellConfs = {}

	for iter_3_2, iter_3_3 in ipairs(self.entranceActivityList) do
		self.cellConfs[iter_3_2] = {
			size = {
				width = 640,
				height = iter_3_3.isbigBanner and 350 or 252
			}
		}
	end
end
