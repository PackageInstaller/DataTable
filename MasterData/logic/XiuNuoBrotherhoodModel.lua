-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/model/XiuNuoBrotherhoodModel.lua

module("logic.extensions.xiunuobrotherhood.model.XiuNuoBrotherhoodModel", package.seeall)

local XiuNuoBrotherhoodModel = class("XiuNuoBrotherhoodModel", BaseModel)

XiuNuoBrotherhoodModel.ReadFlag = "XiuNuoBrotherhoodModel.ReadFlag"

function XiuNuoBrotherhoodModel:ctor()
	return
end

function XiuNuoBrotherhoodModel:onInit()
	self:onReset()
end

function XiuNuoBrotherhoodModel:onReset()
	self._data = nil
	self._curActivityId = 0
	self._curStageId = 0
	self._passStageIds = nil
	self._bossInfo = nil
	self._buffInfo = nil
	self._buffInfoMap = {}
	self._msgInfos = {}

	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_XIUNUOBROTHERHOOD_RED)
end

function XiuNuoBrotherhoodModel:setData(msg)
	self._data = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId] = self._data
	self._curActivityId = self._data.activityId
	self._passStageIds = self._data.passStageIds or {}
	self._maxPassStage = 0

	if #self._passStageIds > 0 then
		for i, v in ipairs(self._passStageIds) do
			if v > self._maxPassStage then
				self._maxPassStage = v
			end
		end
	end

	if self._data.info then
		self._curStageId = self._data.info.stageInfo.stageId
		self._bossInfo = self._data.info.bossInfo
		self._buffInfo = self._data.info.buffInfo
		self._buffInfoMap = {}

		for i, v in ipairs(self._buffInfo) do
			self._buffInfoMap[v.buffType] = v
		end
	else
		self._curStageId = 0
		self._bossInfo = nil
		self._buffInfo = nil
		self._buffInfoMap = {}
	end
end

function XiuNuoBrotherhoodModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function XiuNuoBrotherhoodModel:setMoveEndData(msg)
	local data = GameUtil.pbToTable(msg)

	self._bossInfo = data.bossInfo
	self._buffInfo = data.buffInfo
	self._buffInfoMap = {}

	if self._buffInfo then
		for i, v in ipairs(self._buffInfo) do
			self._buffInfoMap[v.buffType] = v
		end
	end
end

function XiuNuoBrotherhoodModel:randomClientKey()
	self._clientKey = math.random(1, 100000)

	return self._clientKey
end

function XiuNuoBrotherhoodModel:getClientKey()
	return self._clientKey
end

function XiuNuoBrotherhoodModel:setServerKey(key)
	self._severKey = key
end

function XiuNuoBrotherhoodModel:getServerKey()
	return self._severKey
end

function XiuNuoBrotherhoodModel:setCurrActivityAndStage(activityId, stageId)
	self._curActivityId = activityId
	self._curStageId = stageId
end

function XiuNuoBrotherhoodModel:isSameActivityAndStage(activityId, stageId)
	return self._curActivityId == activityId and stageId
end

function XiuNuoBrotherhoodModel:getPassStageIds()
	return self._passStageIds or {}
end

function XiuNuoBrotherhoodModel:getMaxPassStage()
	return checknumber(self._maxPassStage)
end

function XiuNuoBrotherhoodModel:getEnemyList(planId)
	if self._bossInfo then
		return self._bossInfo
	else
		self._bossInfo = {}

		local bossCfg = XiuNuoBrotherhoodConfig.instance:getBossPlanCfgs(planId)

		for i, v in pairs(bossCfg) do
			table.insert(self._bossInfo, {
				state = 0,
				bossId = v.bossId,
				step = v.startPos
			})
		end

		return self._bossInfo
	end
end

function XiuNuoBrotherhoodModel:getBuffInfo()
	return self._buffInfo or {}
end

function XiuNuoBrotherhoodModel:getBuffInfoByType(type)
	return self._buffInfoMap[type] or {}
end

function XiuNuoBrotherhoodModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = XiuNuoBrotherhoodFmtMo.New()
	end

	return self._customFmtMo
end

function XiuNuoBrotherhoodModel:saveTempBuff(activityId, stageId, buffs)
	self._buffs = self._buffs or {}
	self._buffs[activityId] = self._buffs[activityId] or {}
	self._buffs[activityId][stageId] = buffs
end

function XiuNuoBrotherhoodModel:getTempBuff(activityId, stageId)
	if not self._buffs or not self._buffs[activityId] then
		return {}
	end

	return self._buffs[activityId][stageId] or {}
end

function XiuNuoBrotherhoodModel:getDailyGameStart()
	return GameUtil.getUserDayData(XiuNuoBrotherhoodModel.ReadFlag .. "#Enter")
end

function XiuNuoBrotherhoodModel:setDailyGameStart()
	GameUtil.saveUserDayData(XiuNuoBrotherhoodModel.ReadFlag .. "#Enter", true)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_XIUNUOBROTHERHOOD_RED)
end

function XiuNuoBrotherhoodModel:setStageOpen(activityId)
	if not self._curActivityId or self._curActivityId ~= activityId or not self._openTime then
		self._curActivityId = activityId
		self._openTime = {}

		local timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.XiuNuoBrotherhood, activityId)
		local startTime = GameUtil.string2time(timeCfg.startTime)
		local activityCfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(self._curActivityId)
		local stageCfgs = XiuNuoBrotherhoodConfig.instance:getStageCfgs(self._curActivityId)

		for i, v in ipairs(stageCfgs) do
			local sxGameStageCfg = ThreeMatchesGameConfig.instance:getStageCfg(activityCfg.gameId, v.stageId)
			local stageOpenTime

			_, stageOpenTime = GameUtil.getTimestampOnStartAndEnd(startTime, 0, sxGameStageCfg.openDay)
			self._openTime[v.stageId] = stageOpenTime
		end
	end
end

function XiuNuoBrotherhoodModel:getStageOpen(stageId)
	if not self._openTime then
		return false
	elseif self._openTime[stageId] then
		return ServerTime.now() >= self._openTime[stageId]
	end

	return false
end

function XiuNuoBrotherhoodModel:getStageOpenTime(stageId)
	if not self._openTime then
		return 0
	elseif self._openTime[stageId] then
		return self._openTime[stageId]
	end

	return 0
end

function XiuNuoBrotherhoodModel:getTotalScore()
	if self._data.info then
		return checknumber(self._data.info.stageInfo.score)
	end

	return 0
end

function XiuNuoBrotherhoodModel:getInBattle()
	return self._inBattle or false
end

function XiuNuoBrotherhoodModel:setInBattle(status)
	self._inBattle = status
end

function XiuNuoBrotherhoodModel:getAutoShowTip()
	return GameUtil.getUserData(XiuNuoBrotherhoodModel.ReadFlag .. "#AutoTip")
end

function XiuNuoBrotherhoodModel:saveAutoShowTip()
	GameUtil.saveUserData(XiuNuoBrotherhoodModel.ReadFlag .. "#AutoTip", true)
end

function XiuNuoBrotherhoodModel:getCurrActId(openTag)
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.XiuNuoBrotherhood)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.XiuNuoBrotherhood)

		return false
	end

	for i, v in pairs(cfgs) do
		local cfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(v.activityId)

		if cfg and cfg.openTag == openTag and ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.XiuNuoBrotherhood, v.activityId) then
			actId = cfg.activityId

			break
		end
	end

	return actId
end

function XiuNuoBrotherhoodModel:setJumpViewNames(mainViewName, selectViewName, gameViewName)
	self._mainViewName = mainViewName
	self._selectViewName = selectViewName
	self._gameViewName = gameViewName
end

function XiuNuoBrotherhoodModel:getJumpViewNames()
	return self._mainViewName, self._selectViewName, self._gameViewName
end

function XiuNuoBrotherhoodModel:upgradeBuffRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		info.signInBuffLv = msg.signInBuffLv
		info.todayCheckIn = msg.todayCheckIn
	end
end

XiuNuoBrotherhoodModel.instance = XiuNuoBrotherhoodModel.New()

return XiuNuoBrotherhoodModel
