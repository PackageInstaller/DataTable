-- chunkname: @modules/logic/chargepush/model/ChargePushModel.lua

module("modules.logic.chargepush.model.ChargePushModel", package.seeall)

local ChargePushModel = class("ChargePushModel", BaseModel)

function ChargePushModel:onInit()
	self:clear()
	self:clearData()
end

function ChargePushModel:reInit()
	self:clearData()
end

function ChargePushModel:clearData()
	return
end

function ChargePushModel:onReceivePushInfo(info)
	self:clear()

	for i = 1, #info.pushId do
		self:addPushInfo(info.pushId[i])
	end

	self:sort(ChargePushMO.sortFunction)
end

function ChargePushModel:addPushInfo(pushId)
	local mo = self:getById(pushId)

	if not mo then
		mo = ChargePushMO.New()

		mo:init(pushId)
		self:addAtLast(mo)
	end
end

function ChargePushModel:popNextPushInfo()
	return (self:removeFirst())
end

ChargePushModel.instance = ChargePushModel.New()

return ChargePushModel
