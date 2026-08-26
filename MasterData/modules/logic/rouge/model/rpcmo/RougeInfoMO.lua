-- chunkname: @modules/logic/rouge/model/rpcmo/RougeInfoMO.lua

module("modules.logic.rouge.model.rpcmo.RougeInfoMO", package.seeall)

local RougeInfoMO = pureTable("RougeInfoMO")

function RougeInfoMO:init(info)
	self.season = info:HasField("season") and info.season or nil
	self.version = {}

	for i, v in ipairs(info.version) do
		table.insert(self.version, v)
	end

	self.state = info.state
	self.difficulty = info.difficulty
	self.lastReward = info.lastReward
	self.selectRewardNum = info.selectRewardNum
	self.selectRewardId = info.selectRewardId
	self.style = info.style
	self.teamLevel = info.teamLevel
	self.teamExp = info.teamExp
	self.teamSize = info.teamSize
	self.coin = info.coin
	self.talentPoint = info.talentPoint
	self.power = info.power
	self.powerLimit = info.powerLimit
	self.endId = info.endId
	self.endId = info.endId
	self.retryNum = info.retryNum
	self.gameNum = info.gameNum

	self:updateTeamInfo(info.teamInfo)

	if info.talentTree then
		self:updateTalentInfo(info.talentTree.rougeTalent)
	end

	RougeCollectionModel.instance:init()
	RougeCollectionModel.instance:onReceiveNewInfo2Slot(info.bag.layouts)
	RougeCollectionModel.instance:onReceiveNewInfo2Bag(info.warehouse.items)
	self:updateEffect(info.effectInfo)
	self:updateGameLimiterInfo(info)
end

function RougeInfoMO:updateTeamInfo(teamInfo)
	self.teamInfo = RougeTeamInfoMO.New()

	self.teamInfo:init(teamInfo)
end

function RougeInfoMO:updateTeamLife(heroLifeList)
	if not self.teamInfo then
		return
	end

	self.teamInfo:updateTeamLife(heroLifeList)
end

function RougeInfoMO:updateTeamLifeAndDispatchEvent(heroLifeList)
	if not self.teamInfo then
		return
	end

	self.teamInfo:updateTeamLifeAndDispatchEvent(heroLifeList)
end

function RougeInfoMO:updateExtraHeroInfo(heroInfoList)
	if not self.teamInfo then
		return
	end

	self.teamInfo:updateExtraHeroInfo(heroInfoList)
end

function RougeInfoMO:updateTalentInfo(talentInfo)
	self.talentInfo = GameUtil.rpcInfosToList(talentInfo, RougeTalentMO)
end

function RougeInfoMO:isContinueLast()
	return self.state ~= RougeEnum.State.Empty and self.state ~= RougeEnum.State.isEnd
end

function RougeInfoMO:isCanSelectRewards()
	return #self.lastReward > 0
end

function RougeInfoMO:updateEffect(effectList)
	self.effectDict = self.effectDict or {}

	for _, effect in ipairs(effectList) do
		local effectIdList = effect.effectId

		for _, effectId in ipairs(effectIdList) do
			self.effectDict[effectId] = self.effectDict[effectId] or RougeMapConfig.instance:getRougeEffect(effectId)
		end
	end
end

function RougeInfoMO:getEffectDict()
	return self.effectDict
end

function RougeInfoMO:getDeadHeroNum()
	return self.teamInfo and self.teamInfo:getDeadHeroNum() or 0
end

function RougeInfoMO:updateGameLimiterInfo(rougeInfo)
	self._gameLimiterMo = nil

	if rougeInfo:HasField("limiterInfo") then
		self._gameLimiterMo = RougeGameLimiterMO.New()

		self._gameLimiterMo:init(rougeInfo.limiterInfo)
	end
end

function RougeInfoMO:getGameLimiterMo()
	return self._gameLimiterMo
end

function RougeInfoMO:checkMountDlc()
	return self.version and #self.version > 0
end

return RougeInfoMO
