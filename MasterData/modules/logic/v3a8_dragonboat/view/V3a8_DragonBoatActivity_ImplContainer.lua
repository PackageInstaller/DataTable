-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_ImplContainer.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_ImplContainer", package.seeall)

local V3a8_DragonBoatActivity_ImplContainer = class("V3a8_DragonBoatActivity_ImplContainer", BaseViewContainer)

function V3a8_DragonBoatActivity_ImplContainer:onContainerInit()
	V3a8_DragonBoatActivity_ImplContainer.super.onContainerInit(self)
end

function V3a8_DragonBoatActivity_ImplContainer:onContainerOpen()
	V3a8_DragonBoatActivity_ImplContainer.super.onContainerOpen(self)

	if not self._isInited then
		self:sendAct241GetInfo()
	end
end

function V3a8_DragonBoatActivity_ImplContainer:onContainerDestroy()
	self._isInited = false

	V3a8_DragonBoatActivity_ImplContainer.super.onContainerDestroy(self)
end

function V3a8_DragonBoatActivity_ImplContainer:actId()
	if self.viewParam then
		return self.viewParam.actId
	end

	return V3a8_DragonBoatController.instance:actId()
end

function V3a8_DragonBoatActivity_ImplContainer:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

local StateDay = {
	Done = 1999,
	None = 0
}

function V3a8_DragonBoatActivity_ImplContainer:_getPrefsKey(day)
	return self:getPrefsKeyPrefix() .. tostring(day)
end

function V3a8_DragonBoatActivity_ImplContainer:saveState(day, value)
	local key = self:_getPrefsKey(day)

	self:saveInt(key, value or StateDay.None)
end

function V3a8_DragonBoatActivity_ImplContainer:getState(day, defaultValue)
	local key = self:_getPrefsKey(day)

	return self:getInt(key, defaultValue or StateDay.None)
end

function V3a8_DragonBoatActivity_ImplContainer:_getPfsKeyFinalSnapshot()
	return self:getPrefsKeyPrefix() .. "FinalSnapshot"
end

function V3a8_DragonBoatActivity_ImplContainer:savePlayedFinalSnapshot(value)
	local key = self:_getPfsKeyFinalSnapshot()

	self:saveInt(key, value or 0)
end

function V3a8_DragonBoatActivity_ImplContainer:hasPlayedFinalSnapshot(defaultValue)
	local key = self:_getPfsKeyFinalSnapshot()

	return self:getInt(key, defaultValue or 0)
end

function V3a8_DragonBoatActivity_ImplContainer:saveStateDone(day, isDone)
	self:saveState(day, (isDone or nil) and (StateDay.Done or StateDay.None))
end

function V3a8_DragonBoatActivity_ImplContainer:isStateDone(day)
	return self:getState(day) == StateDay.Done
end

function V3a8_DragonBoatActivity_ImplContainer:isPlayAnimAvaliable(day)
	if self:isType101RewardCouldGet(day) then
		return not self:isStateDone(day)
	end

	return false
end

local kPrefix = "V3a8_DragonBoat|"

function V3a8_DragonBoatActivity_ImplContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function V3a8_DragonBoatActivity_ImplContainer:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function V3a8_DragonBoatActivity_ImplContainer:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function V3a8_DragonBoatActivity_ImplContainer:getSignMaxDay(...)
	return V3a8_DragonBoatConfig.instance:getSignMaxDay(...)
end

function V3a8_DragonBoatActivity_ImplContainer:getBonusList(...)
	return V3a8_DragonBoatConfig.instance:getBonusList(...)
end

function V3a8_DragonBoatActivity_ImplContainer:getOptionList(...)
	return V3a8_DragonBoatConfig.instance:getOptionList(...)
end

function V3a8_DragonBoatActivity_ImplContainer:getBubbleDesc(...)
	return V3a8_DragonBoatConfig.instance:getBubbleDesc(...)
end

function V3a8_DragonBoatActivity_ImplContainer:getVoteFinalRewardItemCO(...)
	return V3a8_DragonBoatConfig.instance:getVoteFinalRewardItemCO(...)
end

function V3a8_DragonBoatActivity_ImplContainer:sendGlobalVoteGetInfo(...)
	return V3a8_DragonBoatController.instance:sendGlobalVoteGetInfo(...)
end

function V3a8_DragonBoatActivity_ImplContainer:sendAct241GetInfo(...)
	return V3a8_DragonBoatController.instance:sendAct241GetInfo(...)
end

function V3a8_DragonBoatActivity_ImplContainer:sendAct241Vote(...)
	return V3a8_DragonBoatController.instance:sendAct241Vote(...)
end

function V3a8_DragonBoatActivity_ImplContainer:sendAct241GetBonus(...)
	return V3a8_DragonBoatController.instance:sendAct241GetBonus(...)
end

function V3a8_DragonBoatActivity_ImplContainer:sendGetFinalBonusReq(...)
	return V3a8_DragonBoatController.instance:sendGetFinalBonusReq(...)
end

function V3a8_DragonBoatActivity_ImplContainer:isDayOpen(...)
	return V3a8_DragonBoatModel.instance:isDayOpen(...)
end

function V3a8_DragonBoatActivity_ImplContainer:isClaimable(...)
	return V3a8_DragonBoatModel.instance:isClaimable(...)
end

function V3a8_DragonBoatActivity_ImplContainer:isClaimed(...)
	return V3a8_DragonBoatModel.instance:isClaimed(...)
end

function V3a8_DragonBoatActivity_ImplContainer:isExpired(...)
	return V3a8_DragonBoatModel.instance:isExpired(...)
end

function V3a8_DragonBoatActivity_ImplContainer:displayMaxTicketNum(...)
	return V3a8_DragonBoatModel.instance:displayMaxTicketNum(...)
end

function V3a8_DragonBoatActivity_ImplContainer:getVoteSimpleInfo(...)
	return V3a8_DragonBoatModel.instance:getVoteSimpleInfo(...)
end

function V3a8_DragonBoatActivity_ImplContainer:votedCount(...)
	return V3a8_DragonBoatModel.instance:votedCount(...)
end

function V3a8_DragonBoatActivity_ImplContainer:loginCount(...)
	return V3a8_DragonBoatModel.instance:loginCount(...)
end

function V3a8_DragonBoatActivity_ImplContainer:getBonusVotes(...)
	return V3a8_DragonBoatModel.instance:getBonusVotes(...)
end

function V3a8_DragonBoatActivity_ImplContainer:bluePercent01()
	local info = self:getVoteSimpleInfo()

	if info.totVotedCnt <= 0 then
		return 0.5
	end

	if not info.opId2VoteCnt[V3a8_DragonBoatEnum.Op.Blue] then
		local blueCnt = 0

		return blueCnt / info.totVotedCnt
	end
end

function V3a8_DragonBoatActivity_ImplContainer:bBlueWin(...)
	return V3a8_DragonBoatModel.instance:bBlueWin(...)
end

function V3a8_DragonBoatActivity_ImplContainer:bRedWin(...)
	return V3a8_DragonBoatModel.instance:bRedWin(...)
end

function V3a8_DragonBoatActivity_ImplContainer:isOpenedVoteFinal(...)
	return V3a8_DragonBoatModel.instance:isOpenedVoteFinal(...)
end

function V3a8_DragonBoatActivity_ImplContainer:bFinalBonusClaimable(...)
	return V3a8_DragonBoatModel.instance:bFinalBonusClaimable(...)
end

function V3a8_DragonBoatActivity_ImplContainer:bFinalBonusClaimed(...)
	return V3a8_DragonBoatModel.instance:bFinalBonusClaimed(...)
end

function V3a8_DragonBoatActivity_ImplContainer:create_V3a8_DragonBoatActivity_ScrollLine(viewObj, srcGo)
	local ctroParams = {
		parent = viewObj,
		baseViewContainer = viewObj.viewContainer
	}
	local item = V3a8_DragonBoatActivity_ScrollLine.New(ctroParams)

	item:init(srcGo)

	return item
end

function V3a8_DragonBoatActivity_ImplContainer:doOnDailyRefresh()
	self.sendAct241GetInfo(self, self._sendAct241GetInfoFromDailyRefeshCb, self)
end

function V3a8_DragonBoatActivity_ImplContainer:_sendAct241GetInfoFromDailyRefeshCb()
	self.sendGlobalVoteGetInfo(self, self._sendGlobalVoteGetInfoFromDailyRefeshCb, self)
end

function V3a8_DragonBoatActivity_ImplContainer:_sendGlobalVoteGetInfoFromDailyRefeshCb()
	if self._mainView then
		self._mainView:OnDoneDailyRefresh()
	end
end

function V3a8_DragonBoatActivity_ImplContainer:play_ui_shiji_vote_open()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shiji_vote_open or 380001)
end

function V3a8_DragonBoatActivity_ImplContainer:play_ui_shiji_vote_success()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shiji_vote_success or 380002)
end

return V3a8_DragonBoatActivity_ImplContainer
