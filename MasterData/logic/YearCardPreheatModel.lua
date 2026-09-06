-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/model/YearCardPreheatModel.lua

module("logic.extensions.preheatsale.model.YearCardPreheatModel", package.seeall)

local YearCardPreheatModel = class("YearCardPreheatModel", BaseModel)

function YearCardPreheatModel:onInit()
	self:onReset()
end

function YearCardPreheatModel:onReset()
	self.progress = 0
	self.prizeStatus = {}
	self.unlockStatus = {}
	self.dailyTime = 0
	self.totalTime = 0
	self.clientKey = 0
	self.serverKey = 0
	self.CiList = 0
end

function YearCardPreheatModel:onGetInfo(msg)
	self.progress = checkint(msg.progress)
	self.prizeStatus = {}

	for _, v in ipairs(msg.gainPrizeStatus) do
		table.insert(self.prizeStatus, v)
	end

	self.unlockStatus = {}

	for _, v in ipairs(msg.unlockStatus) do
		table.insert(self.unlockStatus, v)
	end

	self.dailyTime = checkint(msg.dailyTime)
	self.totalTime = checkint(msg.totalTime)
end

function YearCardPreheatModel:onStartGame(msg)
	self.clientKey = checkint(msg.clientKey)
	self.serverKey = checkint(msg.serverKey)
end

function YearCardPreheatModel:onGameOver(msg)
	self.progress = checkint(msg.progress)
	self.CiList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function YearCardPreheatModel:onGainPrize(msg)
	return
end

function YearCardPreheatModel:onUnlock(msg)
	return
end

function YearCardPreheatModel:setUnlockId(id)
	self.unlockStatus[id] = true
end

function YearCardPreheatModel:setGetPrize(id)
	self.prizeStatus[id] = true
end

function YearCardPreheatModel:getCurActId()
	local actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.YearCardPreheat)

	if actTimeCfg then
		return actTimeCfg.activityId, actTimeCfg
	else
		return 0, nil
	end
end

function YearCardPreheatModel:showCI()
	MaterialController.instance:showChangeSetInTemp(checknumber(self.CiList))

	self.CiList = nil
end

YearCardPreheatModel.instance = YearCardPreheatModel.New()

return YearCardPreheatModel
