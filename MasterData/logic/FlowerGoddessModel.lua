-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/model/FlowerGoddessModel.lua

module("logic.extensions.flowergoddess.model.FlowerGoddessModel", package.seeall)

local FlowerGoddessModel = class("FlowerGoddessModel", BaseModel)

function FlowerGoddessModel:ctor()
	return
end

function FlowerGoddessModel:onInit()
	self:onReset()
end

function FlowerGoddessModel:onReset()
	self._activityId = 0
	self._curInitimacy = 0
	self._hasGainedPrizeIds = {}
end

function FlowerGoddessModel:onHandlePM_SendGoddessFlowerGetInfoRes(msg)
	self._activityId = checknumber(msg.activityId)
	self._curInitimacy = checknumber(msg.curInitimacy)
	self._hasGainedPrizeIds = {}

	for _, id in ipairs(msg.hasGainedPrizeIds) do
		table.insert(self._hasGainedPrizeIds, checknumber(id))
	end
end

function FlowerGoddessModel:onHandlePM_SendGoddessFlowerRes(msg)
	self._curInitimacy = checknumber(msg.curInitimacy)
end

function FlowerGoddessModel:onHandlePM_SendGoddessFlowerGainProgressPrizeRes(msg)
	table.insert(self._hasGainedPrizeIds, checknumber(msg.prizeId))
end

function FlowerGoddessModel:getActivityId()
	return self._activityId
end

function FlowerGoddessModel:getCurInitimacy()
	return self._curInitimacy
end

function FlowerGoddessModel:getHasGainedPrizeIds()
	return self._hasGainedPrizeIds
end

FlowerGoddessModel.instance = FlowerGoddessModel.New()

return FlowerGoddessModel
