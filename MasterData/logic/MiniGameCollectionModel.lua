-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minigamecollection/model/MiniGameCollectionModel.lua

module("logic.extensions.minigamecollection.model.MiniGameCollectionModel", package.seeall)

local MiniGameCollectionModel = class("MiniGameCollectionModel", BaseModel)

function MiniGameCollectionModel:ctor()
	self:onReset()
end

function MiniGameCollectionModel:onReset()
	self._hasPlayTimes = 0
	self._hasBuyTimes = 0
end

function MiniGameCollectionModel:updateInfo(msg)
	self._hasPlayTimes = checknumber(msg.hasPlayTimes)
	self._hasBuyTimes = checknumber(msg.hasBuyTimes)
end

function MiniGameCollectionModel:updateBuyPlayTimeSuc(msg)
	self._hasBuyTimes = self._hasBuyTimes + 1
end

function MiniGameCollectionModel:getResiduePlayTimes()
	local times = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("DAILY_MAX_PLAY_TIMES"))

	return times + self._hasBuyTimes - self._hasPlayTimes
end

function MiniGameCollectionModel:getHasBuyTimes()
	return self._hasBuyTimes
end

MiniGameCollectionModel.instance = MiniGameCollectionModel.New()

return MiniGameCollectionModel
