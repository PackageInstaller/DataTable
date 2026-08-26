-- chunkname: @modules/logic/tower/model/TowerPermanentDeepModel.lua

module("modules.logic.tower.model.TowerPermanentDeepModel", package.seeall)

local TowerPermanentDeepModel = class("TowerPermanentDeepModel", BaseModel)

function TowerPermanentDeepModel:onInit()
	self:reInit()
end

function TowerPermanentDeepModel:reInit()
	self:initData()

	self.curDeepGroupMo = nil
	self.saveDeepGroupMoMap = {}
	self.isOpenEndless = false
	self.maxHighDeep = 0
	self.fightResult = nil
	self.isNewRecord = false
	self.lastMaxHigDeep = 0
	self.isFailFightNotEnd = false
end

function TowerPermanentDeepModel:initData()
	self.isInDeepLayerState = false
	self.isSelectDeepLayerCategory = false
end

function TowerPermanentDeepModel:onReceiveTowerDeepGetInfoReply(info)
	self:updateCurGroupMo(info.group)

	self.saveDeepGroupMoMap = {}

	for index, deepArchiveData in ipairs(info.archives) do
		self:updateSaveGroupMo(deepArchiveData)
	end

	self.isOpenEndless = info.endless
	self.maxHighDeep = info.highDeep
end

function TowerPermanentDeepModel:updateCurGroupMo(groupData)
	self.curDeepGroupMo = self.curDeepGroupMo or TowerDeepGroupMo.New()

	self.curDeepGroupMo:updateGroupData(groupData)
end

function TowerPermanentDeepModel:updateSaveGroupMo(deepArchiveData)
	local deepGroupMo = self.saveDeepGroupMoMap[deepArchiveData.archiveNo]

	if not deepGroupMo then
		deepGroupMo = TowerDeepGroupMo.New()
		self.saveDeepGroupMoMap[deepArchiveData.archiveNo] = deepGroupMo
	end

	deepGroupMo:updateArchiveData(deepArchiveData)
end

function TowerPermanentDeepModel:updateFightResult(info)
	self:updateCurGroupMo(info.group)

	self.fightResult = info.result
	self.isNewRecord = info.newRecord
	self.lastMaxHigDeep = self.maxHighDeep
	self.maxHighDeep = info.highDeep
end

function TowerPermanentDeepModel:getCurMaxDeepHigh()
	local defaultHigh = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	return Mathf.Max(self.maxHighDeep, defaultHigh)
end

function TowerPermanentDeepModel:getLastMaxDeepHigh()
	return self.lastMaxHigDeep == 0 and self:getCurMaxDeepHigh() or self.lastMaxHigDeep
end

function TowerPermanentDeepModel:setLastMaxDeepHigh()
	self.lastMaxHigDeep = self.maxHighDeep
end

function TowerPermanentDeepModel:getCurDeepHigh()
	local defaultHigh = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	return (self.curDeepGroupMo and self.curDeepGroupMo.curDeep > 0 or nil) and (self.curDeepGroupMo.curDeep or defaultHigh)
end

function TowerPermanentDeepModel:getCurDeepGroupMo()
	return self.curDeepGroupMo
end

function TowerPermanentDeepModel:getSaveDeepGroupMoMap()
	return self.saveDeepGroupMoMap
end

function TowerPermanentDeepModel:checkDeepLayerUnlock()
	local unlockLayer = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.UnlockLayer)
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()

	if curPermanentMo then
		if not curPermanentMo.passLayerId then
			local curPassLayer = 0

			return unlockLayer <= curPassLayer
		end
	end
end

function TowerPermanentDeepModel:setInDeepLayerState(state)
	self.isInDeepLayerState = state
end

function TowerPermanentDeepModel:getIsInDeepLayerState()
	return self.isInDeepLayerState
end

function TowerPermanentDeepModel:setIsSelectDeepCategory(state)
	self.isSelectDeepLayerCategory = state
end

function TowerPermanentDeepModel:getIsSelectDeepCategory()
	return self.isSelectDeepLayerCategory
end

function TowerPermanentDeepModel:checkEnterDeepLayerGuideFinish()
	local guideId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.FirstEnterDeepGuideId)
	local forbidGuides = GuideController.instance:isForbidGuides()

	return GuideModel.instance:isGuideFinish(guideId) or forbidGuides
end

function TowerPermanentDeepModel:checkIsDeepEpisode(episodeId)
	local normalEpisodeId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.NormalDeepEpisodeId)
	local endlessEpisodeId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.EndlessDeepEpisodeId)

	return episodeId == normalEpisodeId or episodeId == endlessEpisodeId
end

function TowerPermanentDeepModel:getCurDeepGroupWave()
	local maxTeamRoundNum = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.HeroGroupTeamNum)
	local curTeamDataList = self.curDeepGroupMo and self.curDeepGroupMo:getTeamDataList() or {}

	return Mathf.Min(#curTeamDataList + 1, maxTeamRoundNum)
end

function TowerPermanentDeepModel:isHeroBan(heroId)
	local allUsedHeroIdList = self.curDeepGroupMo:getAllUsedHeroId()

	for index, userdHeroId in ipairs(allUsedHeroIdList) do
		if heroId == userdHeroId then
			return true
		end
	end

	return false
end

function TowerPermanentDeepModel:getFightResult()
	return self.fightResult
end

function TowerPermanentDeepModel:checkCanShowResultView()
	return self.fightResult and (self.fightResult == TowerDeepEnum.FightResult.Fail or self.fightResult == TowerDeepEnum.FightResult.Succ), self.fightResult
end

function TowerPermanentDeepModel:getDeepRare(deepHigh)
	local defaultHigh = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	return (Mathf.Clamp(Mathf.Ceil((deepHigh - defaultHigh) / 100), TowerDeepEnum.DefaultDeepRare, TowerDeepEnum.MaxDeepRare))
end

function TowerPermanentDeepModel:setIsFightFailNotEndState(state)
	self.isFailFightNotEnd = state
end

function TowerPermanentDeepModel:getIsFightFailNotEndState()
	return self.isFailFightNotEnd
end

function TowerPermanentDeepModel:getCurDeepMonsterId()
	local curDeepHigh = self:getCurDeepHigh()

	return TowerDeepConfig.instance:getDeepMonsterId(curDeepHigh)
end

TowerPermanentDeepModel.instance = TowerPermanentDeepModel.New()

return TowerPermanentDeepModel
