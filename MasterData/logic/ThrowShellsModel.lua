-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/model/ThrowShellsModel.lua

module("logic.extensions.throwshells.model.ThrowShellsModel", package.seeall)

local ThrowShellsModel = class("ThrowShellsModel", BaseModel)

ThrowShellsModel.ACTOR_TYPE_SELF = 1
ThrowShellsModel.ACTOR_TYPE_TOWER = 2
ThrowShellsModel.ACTOR_TYPE_MELEE = 3
ThrowShellsModel.ACTOR_TYPE_DISTANT = 4

function ThrowShellsModel:ctor()
	return
end

function ThrowShellsModel:onInit()
	self:onReset()
end

function ThrowShellsModel:onReset()
	self.BarrierId = 0
	self.buyTimes = 0
	self.useTimes = 0
	self.hasLoadData = false
end

function ThrowShellsModel:setHasLoadData(torf)
	self.hasLoadData = torf
end

function ThrowShellsModel:getHasLoadData()
	return self.hasLoadData
end

function ThrowShellsModel:setActId(id)
	self.actId = id
end

function ThrowShellsModel:getActId()
	return self.actId
end

function ThrowShellsModel:setBuyTimes(times)
	self.buyTimes = times
end

function ThrowShellsModel:getBuyTimes()
	return self.buyTimes
end

function ThrowShellsModel:setUseTimes(times)
	self.useTimes = times
end

function ThrowShellsModel:getUseTimes()
	return self.useTimes
end

function ThrowShellsModel:setBarrierId(id)
	self.BarrierId = id
end

function ThrowShellsModel:getBarrierId()
	return self.BarrierId
end

function ThrowShellsModel:setClientKey(id)
	self.clientKey = id
end

function ThrowShellsModel:getClientKey()
	return self.clientKey
end

function ThrowShellsModel:setServerKey(id)
	self.serverKey = id
end

function ThrowShellsModel:getServerKey()
	return self.serverKey
end

ThrowShellsModel.instance = ThrowShellsModel.New()

return ThrowShellsModel
