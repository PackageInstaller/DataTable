-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gashapon/model/GashaponModel.lua

module("logic.extensions.gashapon.model.GashaponModel", package.seeall)

local GashaponModel = class("GashaponModel", BaseModel)

GashaponModel.DAYCOSTHINT = "Gashapon_DayCostHint"

function GashaponModel:ctor()
	return
end

function GashaponModel:onInit()
	self.lastReqTime = 0
end

function GashaponModel:onReset()
	self.lastReqTime = 0
end

function GashaponModel:getOpenActivityId()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.Gashapon)
	local id

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end

		id = item.activityId
	end

	return id
end

function GashaponModel:getBestQuality(poolId, prizeInfos)
	local quaBig = 1

	for i = 1, #prizeInfos do
		local qua = GashaponConfig.instance:getPrizeById(poolId, prizeInfos[i].prizeId).quality

		quaBig = quaBig < qua and qua or quaBig
	end

	return quaBig
end

function GashaponModel:showItemInfos(msg)
	MaterialController.instance:getTempItemsByChangeSetId(msg.changeSetId)

	local items = {}

	for i = 1, #msg.prizeInfos do
		local mp = msg.prizeInfos[i].mp
		local tab = MaterialMgr.changeItemStrArr(mp)

		for k, v in pairs(tab) do
			local data = string.split(v, ":")
			local tem = MaterialModel.instance:createMo(checknumber(data[1]), checknumber(data[2]), checknumber(data[3]))

			table.insert(items, tem)
		end
	end

	MaterialController.instance:showChangeSetItemMo(items, checknumber(msg.changeSetId))
end

function GashaponModel:setLastTime(value)
	self.lastReqTime = value
end

function GashaponModel:getLastTime()
	return self.lastReqTime
end

GashaponModel.instance = GashaponModel.New()

return GashaponModel
