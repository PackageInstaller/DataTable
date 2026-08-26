-- chunkname: @modules/logic/abyss/model/AbyssModel.lua

module("modules.logic.abyss.model.AbyssModel", package.seeall)

local AbyssModel = class("AbyssModel", BaseModel)

function AbyssModel:onInit()
	self:reInit()
end

function AbyssModel:reInit()
	self._infoMoDic = {}
	self._curActId = nil
	self._curStage = nil
	self._isFirstGetInfo = false
end

function AbyssModel:isFirstGetInfo()
	return self._isFirstGetInfo
end

function AbyssModel:setCurActId(actId)
	self._curActId = actId
end

function AbyssModel:getCurActId()
	return self._curActId
end

function AbyssModel:setCurStageId(stageId)
	self._curStage = stageId
end

function AbyssModel:getCurStageId()
	return self._curStage
end

function AbyssModel:getCurInfoMo()
	return self:getInfoMo(self._curActId)
end

function AbyssModel:getCurStageMo()
	return self:getStageInfoMo(self._curActId, self._curStage)
end

function AbyssModel:updateInfo(actId, stageInfoList)
	self._isFirstGetInfo = true

	local infoMo

	if not self._infoMoDic[actId] then
		infoMo = AbyssInfoMo.New(actId)
		self._infoMoDic[actId] = infoMo
	else
		infoMo = self._infoMoDic[actId]
	end

	infoMo:updateInfo(actId, stageInfoList)
	AbyssController.instance:dispatchEvent(AbyssEvent.OnGetActInfo, actId)
end

function AbyssModel:onResetStage(actId, stageId)
	local infoMo = self:getInfoMo(actId)

	infoMo:resetStage(stageId)
	AbyssController.instance:dispatchEvent(AbyssEvent.OnResetStage, actId, stageId)
end

function AbyssModel:getInfoMo(actId)
	if not self._infoMoDic then
		return nil
	end

	return self._infoMoDic[actId]
end

function AbyssModel:getUnlockId()
	return OpenEnum.UnlockFunc.VersionActivity
end

function AbyssModel:isFunctionUnlock()
	return OpenModel.instance:isFunctionUnlock(self:getUnlockId())
end

function AbyssModel:getStageInfoMo(actId, stageId)
	local infoMo = self:getInfoMo(actId)

	if infoMo == nil then
		return nil
	end

	return infoMo:getStageInfo(stageId)
end

function AbyssModel:isHeroLocked(actId, heroId)
	local infoMo = self:getInfoMo(actId)

	if not infoMo then
		return false
	end

	return infoMo:isHeroLocked(heroId)
end

function AbyssModel:isCurHeroLocked(heroId)
	local infoMo = self:getCurInfoMo()

	if not infoMo then
		return false
	end

	return infoMo:isHeroLocked(heroId)
end

function AbyssModel:isCurActOpen(showToast)
	if not self._curActId or not ActivityModel.instance:isActOnLine(self._curActId) then
		if showToast then
			GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
		end

		return false
	end

	return true
end

function AbyssModel:onBattleFinishPush(activityId, stageId, round, star, minRound)
	local param = {}

	param.activityId = activityId
	param.stageId = stageId
	param.round = round
	param.star = star
	param.minRound = minRound

	self:setCurActId(activityId)
	self:setCurStageId(stageId)

	self.curFightResultParam = param
end

function AbyssModel:getCurFightResultParam()
	return self.curFightResultParam
end

function AbyssModel:clearFightResultParam()
	self.curFightResultParam = nil
end

function AbyssModel:isInAbyssBattle()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCO = episodeId and lua_episode.configDict[episodeId]
	local episodeType = episodeCO and episodeCO.type

	return episodeType == DungeonEnum.EpisodeType.Abyss
end

function AbyssModel:onUpdateTimePush(actId, stageNOs)
	local actInfoMo = self:getInfoMo(actId)

	if actInfoMo and stageNOs and next(stageNOs) then
		for _, stageNO in ipairs(stageNOs) do
			actInfoMo:updateStageInfo(stageNO)
		end

		actInfoMo:updateHeroUseInfo()
	end

	AbyssController.instance:dispatchEvent(AbyssEvent.OnAbyssLastUpdateTimeChange)
end

AbyssModel.instance = AbyssModel.New()

return AbyssModel
