-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/model/FanRuiChallengeModel.lua

module("logic.extensions.fanruichallenge.model.FanRuiChallengeModel", package.seeall)

local FanRuiChallengeModel = class("FanRuiChallengeModel", BaseModel)

FanRuiChallengeModel.StageLife = 1
FanRuiChallengeModel.StageDestiny = 2
FanRuiChallengeModel.StageControl = 3

function FanRuiChallengeModel:onInit()
	self:onReset()
end

function FanRuiChallengeModel:onReset()
	self._activityId = 0
	self._lifeClgProgress = 0
	self._destinyClgProgress = 0
	self._controlClgProgress = 0
	self._controlClgStagePass = {}
	self._controlClgStageBanPetId = {}
	self._winLife = false
	self._curProgressLife = nil
	self._changeSetIdLife = nil
	self._projectedRes = {}
	self._winDestiny = false
	self._curProgressDestiny = nil
	self._changeSetIdDestiny = nil
	self._monsterId = 0
	self._winControl = false
	self._passStage = nil
	self._curProgressControl = nil
	self._changeSetIdControl = nil
	self._lifeCustomFmtMo = nil
	self._destinyCustomFmtMo = nil
	self._controlCustomFmtMo = nil
	self._fightResPb = nil
	self._msgPool = {}
end

function FanRuiChallengeModel:getLifeCustomFmtMo()
	if self._lifeCustomFmtMo == nil then
		self._lifeCustomFmtMo = FanRuiLifeCustomFmtMo.New()
	end

	return self._lifeCustomFmtMo
end

function FanRuiChallengeModel:getDestinyCustomFmtMo()
	if self._destinyCustomFmtMo == nil then
		self._destinyCustomFmtMo = FanRuiDestinyCustomFmtMo.New()
	end

	return self._destinyCustomFmtMo
end

function FanRuiChallengeModel:getControlCustomFmtMo()
	if self._controlCustomFmtMo == nil then
		self._controlCustomFmtMo = FanRuiControlCustomFmtMo.New()
	end

	return self._controlCustomFmtMo
end

function FanRuiChallengeModel:onGetInfoRes(msg)
	self._lifeClgProgress = msg.lifeClgProgress
	self._destinyClgProgress = msg.destinyClgProgress
	self._controlClgProgress = msg.controlClgProgress
	self._controlClgStagePass = GameUtil.pbToTable(msg.controlClgStagePass) or {}
	self._controlClgStageBanPetId = {}

	local petIds = GameUtil.pbToTable(msg.controlClgStageBanPetId) or {}

	for i, petId in ipairs(petIds) do
		self._controlClgStageBanPetId[petId] = true
	end

	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function FanRuiChallengeModel:onFightThemeLifeRes(msg)
	return
end

function FanRuiChallengeModel:onNotifyThemeLifeFightResultRes(msg)
	self._fightResPb = GameUtil.pbToTable(msg)
	self._winLife = msg.win

	if msg.win then
		if msg:HasField("curProgress") then
			self._lifeClgProgress = msg.curProgress
		end

		if msg:HasField("changeSetId") then
			self._changeSetIdLife = msg.changeSetId
		end
	end

	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info and msg.win then
		info.lifeClgProgress = self._fightResPb.curProgress
	end
end

function FanRuiChallengeModel:onFightThemeDestinyRes(msg)
	return
end

function FanRuiChallengeModel:onNotifyThemeDestinyFightResultRes(msg)
	self._fightResPb = GameUtil.pbToTable(msg)
	self._projectedRes[msg.activityId] = GameUtil.pbToTable(msg.projectedRes) or {}
	self._winDestiny = msg.win

	if msg.win then
		if msg:HasField("curProgress") then
			self._destinyClgProgress = msg.curProgress
		end

		if msg:HasField("changeSetId") then
			self._changeSetIdDestiny = msg.changeSetId
		end
	end

	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info and msg.win then
		info.destinyClgProgress = self._fightResPb.curProgress
	end
end

function FanRuiChallengeModel:onProjectedRes(msg)
	return
end

function FanRuiChallengeModel:onFightThemeControlRes(msg)
	return
end

function FanRuiChallengeModel:onNotifyThemeControlFightResultRes(msg)
	self._fightResPb = GameUtil.pbToTable(msg)
	self._monsterId = msg.monsterId
	self._winControl = msg.win

	if msg.win then
		if msg:HasField("passStage") and msg.passStage then
			self._controlClgStagePass = {}
			self._controlClgStageBanPetId = {}
		else
			self._controlClgStagePass[self._monsterId] = true
			self._controlClgStageBanPetId = {}

			local petIds = GameUtil.pbToTable(msg.banPetId) or {}

			for i, petId in ipairs(petIds) do
				self._controlClgStageBanPetId[petId] = true
			end
		end

		if msg:HasField("curProgress") then
			self._controlClgProgress = msg.curProgress
		end

		if msg:HasField("changeSetId") then
			self._changeSetIdControl = msg.changeSetId
		end
	end

	local activityId = msg.activityId
	local info = self._msgPool[activityId]

	if info and msg.win then
		if self._fightResPb.passStage then
			info.controlClgStagePass = {}
			info.controlClgStageBanPetId = {}
		else
			info.controlClgStagePass[self._fightResPb.monsterId] = true
			info.controlClgStageBanPetId = self._fightResPb.banPetId or {}
		end

		if self._fightResPb.curProgress then
			info.controlClgProgress = self._fightResPb.curProgress
		end
	end
end

function FanRuiChallengeModel:onResetThemeControlStageRes(msg)
	self._controlClgStagePass = {}
	self._controlClgStageBanPetId = {}

	local info = self._msgPool[msg.activityId]

	if info then
		info.controlClgStagePass = {}
		info.controlClgStageBanPetId = {}
	end
end

function FanRuiChallengeModel:getActivityId()
	return 293001
end

function FanRuiChallengeModel:getActivityType()
	return GameEnum.ActivityType.FanRuiChallenge
end

function FanRuiChallengeModel:isBigLevelUnlock(activityId, bigLevelIndex)
	if bigLevelIndex == FanRuiChallengeModel.StageLife then
		return true
	else
		local cfg = FanRuiChallengeConfig.instance:getActivityCfg(activityId)

		if bigLevelIndex == FanRuiChallengeModel.StageDestiny then
			if cfg and not string.nilorempty(cfg.themeDestinyOpenTime) then
				local startTimestamp = GameUtil.string2time(cfg.themeDestinyOpenTime)

				return startTimestamp <= ServerTime.now()
			else
				return true
			end
		elseif bigLevelIndex == FanRuiChallengeModel.StageControl then
			if cfg and not string.nilorempty(cfg.themeControlOpenTime) then
				local startTimestamp = GameUtil.string2time(cfg.themeControlOpenTime)

				return startTimestamp <= ServerTime.now()
			else
				return true
			end
		else
			return false
		end
	end
end

function FanRuiChallengeModel:isPassBigLevel(activityId, index)
	if not self._msgPool[activityId] then
		local maxLevels = 0
		local curLevels = 0

		if index == FanRuiChallengeModel.StageLife then
			local cfgs = FanRuiChallengeConfig.instance:getLifeClgStageCfgList(activityId)

			maxLevels = #cfgs
			curLevels = checknumber(self._msgPool[activityId].lifeClgProgress)
		elseif index == FanRuiChallengeModel.StageDestiny then
			local cfgs = FanRuiChallengeConfig.instance:getDestinyClgStageCfgList(activityId)

			maxLevels = #cfgs
			curLevels = checknumber(self._msgPool[activityId].destinyClgProgress)
		elseif index == FanRuiChallengeModel.StageControl then
			local cfgs = FanRuiChallengeConfig.instance:getControlClgStageCfgList(activityId)

			maxLevels = #cfgs
			curLevels = checknumber(self._msgPool[activityId].controlClgProgress)
		end

		return curLevels > 0 and maxLevels <= curLevels
	end
end

function FanRuiChallengeModel:getLifePassProgress(activityId)
	if not self._msgPool[activityId] then
		return checknumber(self._msgPool[activityId].lifeClgProgress)
	end
end

function FanRuiChallengeModel:getDestinyPassProgress(activityId)
	if not self._msgPool[activityId] then
		return checknumber(self._msgPool[activityId].destinyClgProgress)
	end
end

function FanRuiChallengeModel:getControlPassProgress(activityId)
	if not self._msgPool[activityId] then
		return checknumber(self._msgPool[activityId].controlClgProgress)
	end
end

function FanRuiChallengeModel:isControlPassProgress(activityId, stageIndex)
	return stageIndex <= self:getControlPassProgress(activityId)
end

function FanRuiChallengeModel:isCurControlPassAnyOne()
	if self._controlClgStagePass then
		for i, v in pairs(self._controlClgStagePass) do
			if v then
				return true
			end
		end
	end

	return false
end

function FanRuiChallengeModel:getControlChildProgress(activityId)
	if not self._msgPool[activityId] then
		if not self._msgPool[activityId].controlClgStagePass then
			local controlClgStagePass = {}
			local count = 0

			for i, v in pairs(controlClgStagePass) do
				if v then
					count = count + 1
				end
			end

			return count
		end
	end
end

function FanRuiChallengeModel:isControlChildStagePass(activityId, childStageIndex)
	if not self._msgPool[activityId] then
		if not self._msgPool[activityId].controlClgStagePass then
			local controlClgStagePass = {}

			return controlClgStagePass[childStageIndex]
		end
	end
end

function FanRuiChallengeModel:isBanRaceId(activityId, petId)
	if not self._msgPool[activityId] then
		if not self._msgPool[activityId].controlClgStageBanPetId then
			local controlClgStageBanPetId = {}

			return table.indexof(controlClgStageBanPetId, petId) ~= false
		end
	end
end

function FanRuiChallengeModel:getProjectedRes(activityId)
	return self._projectedRes[activityId]
end

FanRuiChallengeModel.instance = FanRuiChallengeModel.New()

return FanRuiChallengeModel
