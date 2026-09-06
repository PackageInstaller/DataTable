-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/model/DDragonKModel.lua

module("logic.extensions.darkdragonknife.model.DDragonKModel", package.seeall)

local DDragonKModel = class("DDragonKModel", BaseModel)

DDragonKModel.ACTOR_TYPE_SELF = 1
DDragonKModel.ACTOR_TYPE_TOWER = 2
DDragonKModel.ACTOR_TYPE_MELEE = 3
DDragonKModel.ACTOR_TYPE_DISTANT = 4

function DDragonKModel:ctor()
	return
end

function DDragonKModel:onInit()
	self:onReset()
end

function DDragonKModel:onReset()
	self.hasProp = {}
	self.hasGainPrize = {}
	self.buyTimes = 0
	self.useTimes = 0
	self.totalScore = 0
	self.propPlanId = 1
	self.propId = 1
	self.hasLoadData = false
end

function DDragonKModel:setHasLoadData(torf)
	self.hasLoadData = torf
end

function DDragonKModel:getHasLoadData()
	return self.hasLoadData
end

function DDragonKModel:setActId(id)
	self.actId = id
end

function DDragonKModel:getActId()
	return self.actId
end

function DDragonKModel:setPropId(id)
	self.propId = id
end

function DDragonKModel:getPropId()
	return self.propId
end

function DDragonKModel:setTotalScore(score)
	self.totalScore = score
end

function DDragonKModel:getTotalScore()
	return self.totalScore
end

function DDragonKModel:setPropPlanId(id)
	self.propPlanId = id

	printInfo("test setPropPlanId", self.propPlanId, id)
end

function DDragonKModel:getPropPlanId()
	printInfo("test getPropPlanId", self.propPlanId)

	return self.propPlanId
end

function DDragonKModel:setGameTime(gameTime)
	self.GameTime = gameTime
end

function DDragonKModel:getGameTime()
	return self.GameTime
end

function DDragonKModel:setHasGainPrize(arrr)
	self.hasGainPrize = arrr
end

function DDragonKModel:setGainPrize(id, torf)
	self.hasGainPrize[id] = torf
end

function DDragonKModel:getHasGainPrize(id)
	return (self.hasGainPrize[id] or nil) and (self.hasGainPrize[id] or false)
end

function DDragonKModel:setBuyTimes(times)
	self.buyTimes = times
end

function DDragonKModel:getBuyTimes()
	return self.buyTimes
end

function DDragonKModel:setUseTimes(times)
	self.useTimes = times
end

function DDragonKModel:getUseTimes()
	return self.useTimes
end

function DDragonKModel:setHasProp(arrr)
	self.hasProp = arrr
end

function DDragonKModel:setHasPropItem(id)
	self.hasProp[id] = true
end

function DDragonKModel:getHasProp(id)
	return (self.hasProp[id] or nil) and (self.hasProp[id] or false)
end

function DDragonKModel:setClientKey(id)
	self.clientKey = id
end

function DDragonKModel:getClientKey()
	return self.clientKey
end

function DDragonKModel:setServerKey(id)
	self.serverKey = id
end

function DDragonKModel:getServerKey()
	return self.serverKey
end

DDragonKModel.instance = DDragonKModel.New()

return DDragonKModel
