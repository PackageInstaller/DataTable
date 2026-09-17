local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:collectWordCollectItems(arg_1_1, arg_1_2, arg_1_3)
	return self.activities[arg_1_1]:collectActivityItems(arg_1_2, arg_1_3)
end

function activity_base_manager:collectRanDomActivityItems(arg_2_1, arg_2_2)
	return self.activities[arg_2_1]:collectRanDomActivityItems(arg_2_2)
end

function activity_base_manager:getWordCollectStatus(arg_3_1)
	return self.activities[arg_3_1]:getActivityCollectStatus()
end

function activity_base_manager:getCollectLayerName(arg_4_1)
	return self.activities[arg_4_1]:getCollectLayerName()
end

function activity_base_manager:getCollectBoxDataList(arg_5_1)
	return self.activities[arg_5_1]:getCollectBoxDataList()
end

function activity_base_manager:getAllWordCollectItem(arg_6_1)
	return self.activities[arg_6_1]:getAllWordCollectItem()
end

function activity_base_manager:getRandomCollectNeedCount(arg_7_1)
	return self.activities[arg_7_1]:getRandomCollectNeedCount()
end

function activity_base_manager:getWordCollectDataByIndex(arg_8_1, arg_8_2)
	return self.activities[arg_8_1]:getWordCollectDataByIndex(arg_8_2)
end

function activity_base_manager:getUniversalItemId(arg_9_1)
	return self.activities[arg_9_1]:getUniversalItemId()
end

function activity_base_manager:getCollectRandomStartTime(arg_10_1)
	return self.activities[arg_10_1]:getCollectRandomStartTime()
end

function activity_base_manager:collectItemsOneKey(arg_11_1)
	return self.activities[arg_11_1]:collectItemsOneKey()
end
