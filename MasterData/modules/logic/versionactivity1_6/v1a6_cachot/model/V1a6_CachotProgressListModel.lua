-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotProgressListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotProgressListModel", package.seeall)

local V1a6_CachotProgressListModel = class("V1a6_CachotProgressListModel", MixScrollModel)

function V1a6_CachotProgressListModel:onInit()
	self._totalScore = nil
	self._weekScore = nil
	self._curStage = nil
	self._nextStageSecond = nil
	self._canReceiveRewardList = nil
	self._totalRewardCount = 0
end

function V1a6_CachotProgressListModel:reInit()
	self:onInit()
end

function V1a6_CachotProgressListModel:initDatas()
	self:onInit()
	self:buildProgressData()
	self:buildScrollList()
	self:checkDoubleStoreRefreshRed()
	self:checkRewardStageChangeRed()
end

function V1a6_CachotProgressListModel:buildProgressData()
	local rogueStateInfo = V1a6_CachotModel.instance:getRogueStateInfo()

	if rogueStateInfo then
		self._totalScore = rogueStateInfo.totalScore or 0
	end

	if rogueStateInfo then
		self._weekScore = rogueStateInfo.weekScore or 0
	end

	if rogueStateInfo then
		self._curStage = rogueStateInfo.stage or 0
	end

	self._nextStageSecond = rogueStateInfo and tonumber(rogueStateInfo.nextStageSecond) or 0
	self._rewardStateMap = self:buildRewardsStateMap(rogueStateInfo)
end

function V1a6_CachotProgressListModel:buildRewardsStateMap(rogueStateInfo)
	local rewardStateMap = {}
	local getRewards = rogueStateInfo and rogueStateInfo.getRewards

	self._canReceiveRewardList = {}
	self._totalRewardCount = 0
	self._unLockedRewardCount = 0

	local scoreConfigList = V1a6_CachotScoreConfig.instance:getConfigList()

	if scoreConfigList then
		for _, v in ipairs(scoreConfigList) do
			local state = V1a6_CachotEnum.MilestonesState.Locked

			if self._curStage >= v.stage then
				if v.score <= self._totalScore then
					local hasReceiveRewards = tabletool.indexOf(getRewards, v.id) ~= nil

					state = hasReceiveRewards and V1a6_CachotEnum.MilestonesState.HasReceived or V1a6_CachotEnum.MilestonesState.CanReceive

					if not hasReceiveRewards then
						table.insert(self._canReceiveRewardList, v.id)
					end
				else
					state = V1a6_CachotEnum.MilestonesState.UnFinish
				end

				self._unLockedRewardCount = self._unLockedRewardCount + 1
			end

			rewardStateMap[v.id] = state
			self._totalRewardCount = self._totalRewardCount + 1
		end
	end

	return rewardStateMap
end

function V1a6_CachotProgressListModel:buildScrollList()
	local configs = V1a6_CachotScoreConfig.instance:getConfigList()

	if configs then
		local list = {}

		for index, cofig in ipairs(configs) do
			local state = self:getRewardState(cofig.id)
			local isLocked = state == V1a6_CachotEnum.MilestonesState.Locked
			local mo = V1a6_CachotProgressListMO.New()

			mo:init(index, cofig.id, isLocked)
			table.insert(list, mo)

			if isLocked then
				break
			end
		end

		self:setList(list)
	end
end

local CellType = {
	Unlocked = 2,
	Locked = 1
}

function V1a6_CachotProgressListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		if mo.isLocked then
			if not CellType.Locked then
				local cellType = CellType.Unlocked
				local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(cellType, mo:getLineWidth(), i)

				table.insert(mixCellInfos, mixCellInfo)
			end
		end
	end

	return mixCellInfos
end

function V1a6_CachotProgressListModel:getCurGetTotalScore()
	return self._totalScore or 0
end

function V1a6_CachotProgressListModel:getWeekScore()
	return self._weekScore or 0
end

function V1a6_CachotProgressListModel:getCurrentStage()
	return self._curStage or 0
end

function V1a6_CachotProgressListModel:getRewardState(id)
	if self._rewardStateMap then
		return self._rewardStateMap[id] or V1a6_CachotEnum.MilestonesState.Locked
	end
end

function V1a6_CachotProgressListModel:getCurFinishRewardCount()
	local rogueInfo = V1a6_CachotModel.instance:getRogueStateInfo()

	if self._canReceiveRewardList then
		if not #self._canReceiveRewardList then
			local canReceivePartCount = 0

			return canReceivePartCount + ((rogueInfo and rogueInfo.getRewards or nil) and #rogueInfo.getRewards)
		end
	end
end

function V1a6_CachotProgressListModel:getTotalRewardCount()
	return self._totalRewardCount or 0
end

function V1a6_CachotProgressListModel:getUnLockedRewardCount()
	return self._unLockedRewardCount or 0
end

function V1a6_CachotProgressListModel:isAllRewardUnLocked()
	return self:getTotalRewardCount() <= self:getUnLockedRewardCount()
end

function V1a6_CachotProgressListModel:getHasFinishedMoList()
	local finishMoList = {}
	local allMoList = self:getList()

	if allMoList then
		for _, v in pairs(allMoList) do
			local isFinish = self:getRewardState(v.id) == V1a6_CachotEnum.MilestonesState.HasReceived

			if isFinish then
				table.insert(finishMoList, v)
			end
		end
	end

	return finishMoList
end

function V1a6_CachotProgressListModel:getCanReceivePartIdList()
	return self._canReceiveRewardList
end

function V1a6_CachotProgressListModel:getUnLockNextStageRemainTime()
	return self._nextStageSecond
end

function V1a6_CachotProgressListModel:updateUnLockNextStageRemainTime(decreaseTime)
	if self._nextStageSecond then
		decreaseTime = tonumber(decreaseTime) or 0
		self._nextStageSecond = self._nextStageSecond - decreaseTime
	end
end

function V1a6_CachotProgressListModel:checkRed(id, checkfunc, parentId)
	local redInfoList = {}
	local isRed = checkfunc(self)

	table.insert(redInfoList, {
		id = id,
		value = isRed and 1 or 0
	})

	if parentId then
		table.insert(redInfoList, {
			id = parentId,
			value = isRed and 1 or 0
		})
	end

	return redInfoList
end

function V1a6_CachotProgressListModel:checkRewardStageChangeRed()
	local redInfoList = self:checkRed(RedDotEnum.DotNode.V1a6RogueRewardStage, self.checkRewardStageChange) or {}

	RedDotRpc.instance:clientAddRedDotGroupList(redInfoList, true)
end

function V1a6_CachotProgressListModel:checkRewardStageChange()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueRewardStage
	local localstage = PlayerPrefsHelper.getNumber(key, 0)

	if self._curStage ~= nil then
		if localstage == 0 then
			PlayerPrefsHelper.setNumber(key, self._curStage)
		elseif localstage < self._curStage then
			return true
		end
	end

	return false
end

function V1a6_CachotProgressListModel:checkDoubleStoreRefreshRed()
	local redInfoList = self:checkRed(RedDotEnum.DotNode.V1a6RogueDoubleScore, self.checkDoubleStoreRefresh) or {}

	RedDotRpc.instance:clientAddRedDotGroupList(redInfoList, true)
end

function V1a6_CachotProgressListModel:checkDoubleStoreRefresh()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueDoubleScore
	local time = ServerTime.now()
	local localtime = PlayerPrefsHelper.getString(key, "")

	if self._weekScore ~= nil then
		if localtime == "" then
			PlayerPrefsHelper.setNumber(key, time)
		else
			local nextweeksecond = TimeUtil.OneDaySecond * 7 + localtime

			if self._weekScore == 0 and nextweeksecond < time then
				return true
			end
		end
	end

	return false
end

V1a6_CachotProgressListModel.instance = V1a6_CachotProgressListModel.New()

return V1a6_CachotProgressListModel
