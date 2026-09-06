-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/config/HuanXinQingConfig.lua

module("logic.extensions.huanxinqing.config.HuanXinQingConfig", package.seeall)

local HuanXinQingConfig = class("HuanXinQingConfig", BaseConfig)

function HuanXinQingConfig:onInit()
	HuanXinQingConfig.super.onInit(self)
end

function HuanXinQingConfig:getNames()
	return {
		"pet_active_get_activity",
		"pet_active_get_common",
		"pet_active_get_prop",
		"operation_check_in"
	}
end

function HuanXinQingConfig:handleConfig(name, content)
	if name == "pet_active_get_activity" then
		self.pet_active_get_activity = content
	elseif name == "pet_active_get_common" then
		self.pet_active_get_common = content
	elseif name == "pet_active_get_prop" then
		self.pet_active_get_prop = content
	elseif name == "operation_check_in" then
		self.operation_check_in = content
	end
end

function HuanXinQingConfig:GetFakeScrollerData()
	self._scrollerData = {}

	for i = 1, 3 do
		local curCell = {}

		curCell.txtTitle = "累计签到第" .. i .. "天"
		curCell.taskTitle = "这是一个任务标题"
		curCell.taskDetail = "你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗你充Q币吗"
		curCell.prize = "2:171:1:2#13:293:1:3"

		table.insert(self._scrollerData, curCell)
	end

	return self._scrollerData
end

function HuanXinQingConfig:getActData(activityId)
	return self.pet_active_get_activity[activityId]
end

function HuanXinQingConfig:getCommonData(activityId)
	return self.pet_active_get_common[activityId]
end

function HuanXinQingConfig:getCheckInData(activityId)
	return self.operation_check_in[activityId]
end

function HuanXinQingConfig:getPropDatas(activityId)
	local actData = self:getActData(activityId)

	if actData then
		if not actData.exchangePlanId then
			local exchangePlanId = 0

			return self.pet_active_get_prop[exchangePlanId]
		end
	end
end

function HuanXinQingConfig:getPropData(activityId, propId)
	local datas = self:getPropDatas(activityId)

	return datas and datas[propId]
end

HuanXinQingConfig.instance = HuanXinQingConfig.New()

return HuanXinQingConfig
