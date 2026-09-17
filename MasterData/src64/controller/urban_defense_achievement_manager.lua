local UrbanDefenseAchievementManager = class("UrbanDefenseAchievementManager", (require("controller.base_manager")))

UrbanDefenseAchievementManager.MULTITON_MSG = "UrbanDefenseAchievementManager instancealready constructed!"

function UrbanDefenseAchievementManager:ctor()
	UrbanDefenseAchievementManager.super.ctor(self)

	self._data = {}
	self._activityId = nil
end

function UrbanDefenseAchievementManager:setActivityId(arg_2_1)
	self._activityId = arg_2_1
end

function UrbanDefenseAchievementManager:getActivityId()
	return self._activityId
end

function UrbanDefenseAchievementManager:haveData()
	return next(self._data)
end

function UrbanDefenseAchievementManager:getData()
	return self._data
end

function UrbanDefenseAchievementManager:requestInfo(arg_6_1)
	local var_6_0 = require("controller.activity_manager"):getActivityObj(self._activityId)

	if var_6_0 then
		var_6_0:getActivityTaskList(nil, function(arg_7_0, arg_7_1)
			if arg_7_0 == 1 then
				dumpEx_3_10(arg_7_1)

				local task_data = require("data.task_data")

				self._data = arg_7_1.list

				table.sort(self._data, function(arg_8_0, arg_8_1)
					local var_8_0 = arg_8_0.finished
					local var_8_1 = arg_8_1.finished

					if arg_8_0.status ~= arg_8_1.status then
						return arg_8_0.status < arg_8_1.status
					else
						return var_8_1 < var_8_0
					end
				end)

				for iter_7_0 = 1, #self._data do
					self._data[iter_7_0].taskDes = task_data[self._data[iter_7_0].taskid].task_des
					self._data[iter_7_0].jump = task_data[self._data[iter_7_0].taskid].jump
				end
			end
		end, false, nil, "urban_defense")
	end
end

function UrbanDefenseAchievementManager:getTaskReward(arg_9_1)
	local var_9_0 = self._data[arg_9_1]
	local var_9_1 = self._data[arg_9_1].taskid
	local var_9_2 = require("controller.activity_manager"):getActivityObj(self._activityId)

	if var_9_2 then
		var_9_2:getTaskReward(self._data[arg_9_1].taskid, function(arg_10_0, arg_10_1)
			if arg_10_0 == 1 then
				global_gain(arg_10_1)

				var_9_0.status = 1

				sendNotification("UrbanDefenseAchievementRewardGet", {
					activityId = self._activityId,
					taskId = var_9_1
				})
			end
		end)
	end
end

function UrbanDefenseAchievementManager:handlerInfo(arg_11_1)
	return
end

function UrbanDefenseAchievementManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function UrbanDefenseAchievementManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

return UrbanDefenseAchievementManager
