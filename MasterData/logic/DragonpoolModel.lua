-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/model/DragonpoolModel.lua

module("logic.extensions.dragonpool.view.DragonpoolModel", package.seeall)

local DragonpoolModel = class("DragonpoolModel", BaseModel)

function DragonpoolModel:ctor()
	return
end

function DragonpoolModel:onInit()
	self:onReset()
end

function DragonpoolModel:onReset()
	self._info = nil
	self._gainPrizeIds = {}
	self._activityId = 0
end

function DragonpoolModel:setInfo(msg)
	self._info = msg
	self._gainPrizeIds = {}

	for i, v in ipairs(msg.gainPrizeIds) do
		self._gainPrizeIds[v] = true
	end
end

function DragonpoolModel:getInfo()
	return self._info
end

function DragonpoolModel:setActivityId(actId)
	self._activityId = actId
end

function DragonpoolModel:getActivityId()
	return self._activityId
end

function DragonpoolModel:onChatRes(msg)
	self._info.todayChatTimes = msg.todayChatTimes
	self._info.nextCanChatTime = msg.nextCanChatTime
	self._info.textId = msg.textId
	self._info.mood = msg.mood
end

function DragonpoolModel:onTouchRes(msg)
	self._info.todayTouchTimes = msg.todayTouchTimes
	self._info.nextCanTouchTime = msg.nextCanTouchTime
	self._info.mood = msg.mood
end

function DragonpoolModel:onDragonPoolWeed(msg)
	self._info.mood = msg.mood

	for i, v in ipairs(self._info.grassList) do
		if v.grassId == msg.grass.grassId then
			v.nextCanWeedTime = msg.grass.nextCanWeedTime

			break
		end
	end
end

function DragonpoolModel:isGainPrize(prizeId)
	return self._gainPrizeIds[prizeId]
end

function DragonpoolModel:onGainPrize(prizeId)
	self._gainPrizeIds[prizeId] = true
end

function DragonpoolModel:onDragonPoolNextEgg(msg)
	self._info.eggId = msg.eggId
	self._info.mood = msg.mood
	self._info.growth = msg.growth
end

function DragonpoolModel:getEggProgress()
	if not self._info then
		return 0
	end

	local cfg = DragonpoolConfig.instance:getEggCfg(self._info.actId, self._info.eggId)

	if self._info.growth < cfg.maxGrowth then
		return self._info.eggId - 1
	end

	return self._info.eggId
end

DragonpoolModel.instance = DragonpoolModel.New()

return DragonpoolModel
