-- chunkname: @modules/logic/dungeon/model/RoleStoryModel.lua

module("modules.logic.dungeon.model.RoleStoryModel", package.seeall)

local RoleStoryModel = class("RoleStoryModel", BaseModel)

function RoleStoryModel:onInit()
	self:reInit()
end

function RoleStoryModel:reInit()
	self._newDict = {}
	self._unlockingStory = {}
	self.roleStoryFinishDict = nil
	self._leftNum = 0
	self._curActStoryId = 0
	self._todayExchange = 0
	self._isResident = false
	self._weekProgress = 0
	self._weekHasGet = false
	self._lastLeftNum = 0
	self.curStoryId = nil

	TaskDispatcher.cancelTask(self.checkActivityTime, self)
end

function RoleStoryModel:onGetHeroStoryReply(msg)
	local count = #msg.storyInfos

	for i = 1, count do
		self:updateStoryInfo(msg.storyInfos[i])
	end

	count = #msg.newStoryList

	for i = 1, #msg.newStoryList do
		self:setStoryNewTag(msg.newStoryList[i], true)
	end

	count = #msg.times

	for i = 1, #msg.times do
		self:updateStoryTime(msg.times[i])
	end

	self._leftNum = msg.leftNum
	self._lastLeftNum = self._leftNum
	self._todayExchange = msg.todayExchange
	self._weekProgress = msg.weekProgress
	self._weekHasGet = msg.weekHasGet

	TaskDispatcher.cancelTask(self.checkActivityTime, self)
	TaskDispatcher.runRepeat(self.checkActivityTime, self, 1)
end

function RoleStoryModel:onUnlocHeroStoryReply(msg)
	self._unlockingStory[msg.info.storyId] = true

	self:updateStoryInfo(msg.info)
end

function RoleStoryModel:onGetHeroStoryBonusReply(msg)
	self:updateStoryInfo(msg.info)
end

function RoleStoryModel:onHeroStoryUpdatePush(msg)
	local count = #msg.unlockInfos

	for i = 1, count do
		self:updateStoryInfo(msg.unlockInfos[i])
	end
end

function RoleStoryModel:updateStoryInfo(info)
	if info then
		local mo = self:getMoById(info.storyId)

		mo:updateInfo(info)
	end
end

function RoleStoryModel:updateStoryTime(info)
	if info then
		local mo = self:getMoById(info.storyId)

		mo:updateTime(info)
	end
end

function RoleStoryModel:setCurStoryId(storyId)
	self.curStoryId = storyId
end

function RoleStoryModel:getCurStoryId()
	return self.curStoryId
end

function RoleStoryModel:isNewStory(storyId)
	if self._newDict[storyId] then
		return true
	end

	return false
end

function RoleStoryModel:setStoryNewTag(storyId, new)
	local isNew = self:isNewStory(storyId)

	if isNew == new then
		return
	end

	self._newDict[storyId] = new

	if not new then
		HeroStoryRpc.instance:sendUpdateHeroStoryStatusRequest(storyId)
	end
end

function RoleStoryModel:initFinishTweenDict()
	if not self.roleStoryFinishDict then
		self.roleStoryFinishDict = {}

		local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RoleStoryFinishKey), "")
		local list = string.splitToNumber(value, "#")

		for i, v in ipairs(list) do
			self.roleStoryFinishDict[v] = true
		end
	end
end

function RoleStoryModel:isFinishTweenUnplay(storyId)
	self:initFinishTweenDict()

	local isFinishTween = self.roleStoryFinishDict[storyId]

	if not isFinishTween then
		self:markFinishTween(storyId)
	end

	return not isFinishTween
end

function RoleStoryModel:markFinishTween(storyId)
	self:initFinishTweenDict()

	self.roleStoryFinishDict[storyId] = true

	local list = {}

	for k, v in pairs(self.roleStoryFinishDict) do
		table.insert(list, k)
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RoleStoryFinishKey), table.concat(list, "#"))
end

function RoleStoryModel:isUnlockingStory(storyId)
	local isunlocking = self._unlockingStory[storyId]

	if isunlocking then
		self._unlockingStory[storyId] = nil
	end

	return isunlocking
end

function RoleStoryModel:onUpdateHeroStoryStatusReply(msg)
	return
end

function RoleStoryModel:onExchangeTicketReply(msg)
	self.lastExchangeTime = Time.time
	self._leftNum = msg.leftNum
	self._lastLeftNum = self._leftNum
	self._todayExchange = msg.todayExchange
end

function RoleStoryModel:getLeftNum()
	return self._leftNum, self._lastLeftNum
end

function RoleStoryModel:setLastLeftNum(val)
	self._lastLeftNum = val
end

function RoleStoryModel:getMoById(id)
	local mo = self:getById(id)

	if not mo then
		mo = RoleStoryMO.New()

		mo:init(id)
		self:addAtLast(mo)
	end

	return mo
end

function RoleStoryModel:getCurActStoryId()
	return self._curActStoryId
end

function RoleStoryModel:checkActStoryOpen()
	return self._curActStoryId and self._curActStoryId > 0
end

function RoleStoryModel:isInResident(storyId)
	if not storyId then
		return self._isResident
	end

	local mo = self:getById(storyId)

	if not mo then
		return self._isResident
	end

	return mo:isResidentTime()
end

function RoleStoryModel:checkActivityTime()
	local curActStory = self:getCurActStoryId()
	local newActStory = 0
	local isResident = self._isResident
	local newIsResident = false
	local list = self:getList()

	if list then
		for i, v in ipairs(list) do
			if v:isActTime() then
				newActStory = v.id
			end

			if v:isResidentTime() then
				newIsResident = true
			end
		end
	end

	if newActStory ~= curActStory then
		self._curActStoryId = newActStory

		if newActStory == 0 and ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) then
			MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
		end

		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ActStoryChange)
	end

	if newIsResident ~= isResident then
		self._isResident = newIsResident

		if not newIsResident then
			-- block empty
		end

		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ResidentStoryChange)
	end

	local curStoryMo = self:getById(self._curActStoryId)

	if curStoryMo and curStoryMo:hasNewDispatchFinish() then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoleStoryDispatch
		})
	end
end

function RoleStoryModel:onGetScoreBonusReply(info)
	local curActStory = self:getCurActStoryId()
	local mo = self:getById(curActStory)

	if mo then
		mo:addScoreBonus(info.getScoreBonus)
	end
end

function RoleStoryModel:onHeroStoryScorePush(info)
	local mo = self:getById(info.storyId)

	if mo then
		mo:updateScore(info)
	end
end

function RoleStoryModel:checkTodayCanExchange()
	local max = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)

	return max > self._todayExchange
end

function RoleStoryModel:getRewardState(storyId, rewardId, rewardScore)
	local mo = self:getById(storyId)

	if not mo then
		return 0
	end

	if mo:isBonusHasGet(rewardId) then
		return 2
	end

	if rewardScore <= mo:getScore() then
		return 1
	end

	return 0
end

function RoleStoryModel:onGetChallengeBonusReply()
	local curActStory = self:getCurActStoryId()
	local mo = self:getById(curActStory)

	if mo then
		mo.getChallengeReward = true
	end
end

function RoleStoryModel:onHeroStoryTicketPush(info)
	self._leftNum = info.leftNum
	self._todayExchange = info.todayExchange
end

function RoleStoryModel:onHeroStoryWeekTaskPush(info)
	self._weekProgress = info.weekProgress
	self._weekHasGet = info.weekHasGet
end

function RoleStoryModel:getWeekProgress()
	return self._weekProgress
end

function RoleStoryModel:getWeekHasGet()
	return self._weekHasGet
end

function RoleStoryModel:onHeroStoryWeekTaskGetReply()
	self._weekHasGet = true
end

function RoleStoryModel:onHeroStoryDispatchReply(info)
	local mo = self:getById(info.storyId)

	if mo then
		mo:updateDispatchTime(info)
	end
end

function RoleStoryModel:onHeroStoryDispatchResetReply(info)
	local mo = self:getById(info.storyId)

	if mo then
		mo:resetDispatch(info)
	end
end

function RoleStoryModel:onHeroStoryDispatchCompleteReply(info)
	local mo = self:getById(info.storyId)

	if mo then
		mo:completeDispatch(info)
	end
end

function RoleStoryModel:isShowReplayStoryBtn()
	local curStoryId = self:getCurStoryId()

	if not curStoryId or curStoryId == 0 or curStoryId == self:getCurActStoryId() then
		return false
	end

	local list = RoleStoryConfig.instance:getDispatchList(curStoryId, RoleStoryEnum.DispatchType.Story)

	return list and #list > 0
end

function RoleStoryModel:isHeroDispatching(heroId, storyId)
	local mo = self:getById(storyId)

	return mo and mo:isHeroDispatching(heroId)
end

function RoleStoryModel:canPlayDungeonUnlockAnim(storyId)
	local key = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDungeonUnlockAnim, storyId)
	local flag = PlayerPrefsHelper.getNumber(key, 0)

	return flag == 0
end

function RoleStoryModel:setPlayDungeonUnlockAnimFlag(storyId)
	local key = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDungeonUnlockAnim, storyId)

	PlayerPrefsHelper.setNumber(key, 1)
end

function RoleStoryModel:isCGUnlock(storyId)
	local storyCo = RoleStoryConfig.instance:getStoryById(storyId)
	local unlockEpisodeId = storyCo.cgUnlockEpisodeId
	local cgUnlockStoryId = storyCo.cgUnlockStoryId

	if unlockEpisodeId == 0 and cgUnlockStoryId == 0 then
		return true
	end

	if unlockEpisodeId ~= 0 then
		return DungeonModel.instance:hasPassLevel(unlockEpisodeId)
	end

	local gameMo = NecrologistStoryModel.instance:getGameMO(storyId)

	return gameMo:isStoryFinish(cgUnlockStoryId)
end

RoleStoryModel.instance = RoleStoryModel.New()

return RoleStoryModel
