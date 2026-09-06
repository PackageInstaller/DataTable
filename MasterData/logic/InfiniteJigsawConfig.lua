-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitejigsaw/config/InfiniteJigsawConfig.lua

module("logic.extensions.infinitejigsaw.config.InfiniteJigsawConfig", package.seeall)

local InfiniteJigsawConfig = class("InfiniteJigsawConfig", BaseConfig)

function InfiniteJigsawConfig:onInit()
	InfiniteJigsawConfig.super.onInit(self)

	self.jigsaw_exchange = nil
	self.jigsaw_exchange_task = nil
	self.jigsaw_exchange_picture = nil
	self.jigsaw_exchange_jigsaw = nil
	self.jigsaw_exchange_group_prize = nil
	self.jigsaw_exchange_const = nil
end

function InfiniteJigsawConfig:getNames()
	return {
		"jigsaw_exchange",
		"jigsaw_exchange_task",
		"jigsaw_exchange_picture",
		"jigsaw_exchange_jigsaw",
		"jigsaw_exchange_group_prize",
		"jigsaw_exchange_const"
	}
end

function InfiniteJigsawConfig:handleConfig(name, content)
	if name == "jigsaw_exchange" then
		self.jigsaw_exchange = content
	elseif name == "jigsaw_exchange_task" then
		self.jigsaw_exchange_task = content
	elseif name == "jigsaw_exchange_picture" then
		self.jigsaw_exchange_picture = content
	elseif name == "jigsaw_exchange_jigsaw" then
		self.jigsaw_exchange_jigsaw = content
	elseif name == "jigsaw_exchange_group_prize" then
		self.jigsaw_exchange_group_prize = content
	elseif name == "jigsaw_exchange_const" then
		self.jigsaw_exchange_const = content
	end
end

function InfiniteJigsawConfig:getActivityCfg(activityId)
	return self.jigsaw_exchange[activityId]
end

function InfiniteJigsawConfig:getTaskList(taskPlanId)
	return self.jigsaw_exchange_task[taskPlanId]
end

function InfiniteJigsawConfig:getTaskCfg(taskPlanId, taskId)
	if self.jigsaw_exchange_task[taskPlanId] then
		return self.jigsaw_exchange_task[taskPlanId][taskId]
	end
end

function InfiniteJigsawConfig:getTaskTypeList(taskPlanId)
	local dataList = self:getTaskList(taskPlanId) or {}
	local list = {}

	for i, v in ipairs(dataList) do
		list[v.showType] = list[v.showType] or {}

		table.insert(list[v.showType], v)
	end

	return list
end

function InfiniteJigsawConfig:getPictureList(picturePlanId)
	return self.jigsaw_exchange_picture[picturePlanId]
end

function InfiniteJigsawConfig:getPictureCfg(picturePlanId, pictureId)
	if self.jigsaw_exchange_picture[picturePlanId] then
		return self.jigsaw_exchange_picture[picturePlanId][pictureId]
	end
end

function InfiniteJigsawConfig:getJigsawList(jigsawPlanId)
	return self.jigsaw_exchange_jigsaw[jigsawPlanId]
end

function InfiniteJigsawConfig:getJigsawCfg(jigsawPlanId, jigsawId)
	if self.jigsaw_exchange_jigsaw[jigsawPlanId] then
		return self.jigsaw_exchange_jigsaw[jigsawPlanId][jigsawId]
	end
end

function InfiniteJigsawConfig:getGroupPrizeList(groupPrizePlanId)
	return self.jigsaw_exchange_group_prize[groupPrizePlanId]
end

function InfiniteJigsawConfig:getGroupPrizeCfg(groupPrizePlanId, groupPrizeId)
	if self.jigsaw_exchange_group_prize[groupPrizePlanId] then
		return self.jigsaw_exchange_group_prize[groupPrizePlanId][groupPrizeId]
	end
end

function InfiniteJigsawConfig:getConstValue(key)
	if self.jigsaw_exchange_const[key] then
		return self.jigsaw_exchange_const[key].value
	end

	return ""
end

InfiniteJigsawConfig.instance = InfiniteJigsawConfig.New()

return InfiniteJigsawConfig
