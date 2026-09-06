-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/model/YirenPozhenModel.lua

module("logic.extensions.yirenpozhen.model.YirenPozhenModel", package.seeall)

local YirenPozhenModel = class("YirenPozhenModel", BaseModel)

function YirenPozhenModel:ctor()
	return
end

function YirenPozhenModel:onInit()
	self:onReset()
end

function YirenPozhenModel:onReset()
	self.gamePrizedIds = {}
	self._diagramsId = nil
	self.passStageId = nil
	self._fmt = nil
	self.allPetList = nil
end

function YirenPozhenModel:setDiagramsId(id)
	self._diagramsId = id
end

function YirenPozhenModel:getDiagramsId()
	return self._diagramsId
end

function YirenPozhenModel:setPassStageId(id)
	self.passStageId = id
end

function YirenPozhenModel:getPassStageId()
	return self.passStageId
end

function YirenPozhenModel:setGamePrizedIds(id, torf)
	self.gamePrizedIds[id] = torf
end

function YirenPozhenModel:getGamePrizedIds(id)
	return (self.gamePrizedIds[id] or nil) and (self.gamePrizedIds[id] or false)
end

function YirenPozhenModel:getFmt()
	return self._fmt
end

function YirenPozhenModel:getAllPetList(force)
	if force or self.allPetList == nil then
		local list = {}
		local pets = BagPetsController.instance:getFightBagPet()

		for k, v in pairs(pets) do
			local mo = FightingPowerPetMo.getMaxPetMoByData(v)

			table.insert(list, mo)
		end

		self.allPetList = list
	else
		local pool = {}

		for i, v in ipairs(self.allPetList) do
			pool[v.petId] = v
		end

		local pets = BagPetsController.instance:getFightBagPet()

		for k, v in pairs(pets) do
			if pool[v.petId] == nil then
				local mo = FightingPowerPetMo.getMaxPetMoByData(v)

				table.insert(self.allPetList, mo)
			end
		end
	end

	return self.allPetList
end

function YirenPozhenModel:setcreepsMasterId(id)
	self._creepsMasterId = id
end

function YirenPozhenModel:getcreepsMasterId()
	return self._creepsMasterId
end

function YirenPozhenModel:setClientKey(id)
	self.clientKey = id
end

function YirenPozhenModel:getClientKey()
	return self.clientKey
end

function YirenPozhenModel:setServerKey(id)
	self.serverKey = id
end

function YirenPozhenModel:getServerKey()
	return self.serverKey
end

function YirenPozhenModel:setBestStepNum(num)
	self.bestStepNum = num
end

function YirenPozhenModel:getBestStepNum()
	return self.bestStepNum == 0 and "无" or self.bestStepNum
end

function YirenPozhenModel:getHasGetData()
	return self._hasGetData
end

function YirenPozhenModel:setHasGetData(torf)
	self._hasGetData = torf
end

function YirenPozhenModel:setData(msg)
	self._onlineDay = msg.onlineDay

	local cfg = OperationSignInConfig.instance:getSignInCfgList(self._activityId)

	for k, v in pairs(cfg) do
		table.insert(self._daysList, false)
	end

	for k, v in pairs(msg.hasGainPrizeDays) do
		self._daysList[v] = true
	end

	self._hasGetData = true
end

function YirenPozhenModel:setDaysList(day)
	self._daysList[day] = true
end

function YirenPozhenModel:getDaysList()
	return self._daysList
end

function YirenPozhenModel:getDaysListByDay(day)
	return self._daysList[day]
end

function YirenPozhenModel:getOnlineDay()
	return self._onlineDay
end

function YirenPozhenModel:setActivityId(activityId)
	self._activityId = activityId
end

function YirenPozhenModel:getActivityId()
	return self._activityId
end

function YirenPozhenModel:setLastTimeStamp()
	self._timeStamp = ServerTime.now()
end

function YirenPozhenModel:getLastTimeStamp()
	return self._timeStamp
end

function YirenPozhenModel:getCurActicityId()
	local cfg = self:getCurActicityCfg()

	return cfg and cfg.activityId
end

function YirenPozhenModel:getCurActicityCfg()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn)

	if cfg then
		return cfg
	else
		return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn2)
	end
end

YirenPozhenModel.instance = YirenPozhenModel.New()

return YirenPozhenModel
