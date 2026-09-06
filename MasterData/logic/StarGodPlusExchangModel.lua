-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/StarGodPlusExchange/model/StarGodPlusExchangModel.lua

module("logic.extensions.stargodplusexchange.model.StarGodPlusExchangModel", package.seeall)

local StarGodPlusExchangModel = class("StarGodPlusExchangModel", BaseModel)

function StarGodPlusExchangModel:ctor()
	return
end

function StarGodPlusExchangModel:onInit()
	return
end

function StarGodPlusExchangModel:onReset()
	self.cd = 0
	self.times = 0
end

function StarGodPlusExchangModel:setCD(cd)
	self.cd = cd
end

function StarGodPlusExchangModel:getCD()
	return self.cd
end

function StarGodPlusExchangModel:setTimes(times)
	self.times = times
end

function StarGodPlusExchangModel:getTimes()
	return self.times
end

StarGodPlusExchangModel.instance = StarGodPlusExchangModel.New()

return StarGodPlusExchangModel
