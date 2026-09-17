local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager.initActivityArtObj(arg_1_0, arg_1_1)
	return
end

function activity_base_manager:getArtInfo(arg_2_1)
	return self.activities[arg_2_1]:getArtInfo()
end

function activity_base_manager:activityArtDraw(arg_3_1)
	return self.activities[arg_3_1]:activityArtDraw()
end

function activity_base_manager:getArtEndTime(arg_4_1)
	return self.activities[arg_4_1]:getArtEndTime()
end

function activity_base_manager:getArtItemNumber(arg_5_1)
	return self.activities[arg_5_1]:getArtItemNumber()
end

function activity_base_manager:isArtNeedAlert(arg_6_1)
	return self.activities[arg_6_1]:isArtNeedAlert()
end

function activity_base_manager:getArtTaskList(arg_7_1)
	return self.activities[arg_7_1]:getArtTaskList()
end

function activity_base_manager:getArtTaskReward(arg_8_1, arg_8_2)
	return self.activities[arg_8_1]:getArtTaskReward(arg_8_2)
end

function activity_base_manager:isArtFinished(arg_9_1, arg_9_2)
	return self.activities[arg_9_1]:isArtFinished(arg_9_2)
end
