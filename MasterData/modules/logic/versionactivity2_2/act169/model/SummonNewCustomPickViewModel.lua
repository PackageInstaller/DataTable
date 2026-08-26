-- chunkname: @modules/logic/versionactivity2_2/act169/model/SummonNewCustomPickViewModel.lua

module("modules.logic.versionactivity2_2.act169.model.SummonNewCustomPickViewModel", package.seeall)

local SummonNewCustomPickViewModel = class("SummonNewCustomPickViewModel", BaseModel)

SummonNewCustomPickViewModel.DEFAULT_HERO_ID = 0
SummonNewCustomPickViewModel.MAX_SELECT_COUNT = 1

function SummonNewCustomPickViewModel:onInit()
	self._activityMoDic = {}
	self._showFx = {}
end

function SummonNewCustomPickViewModel:reInit()
	self._activityMoDic = {}
	self._showFx = {}
end

function SummonNewCustomPickViewModel:onGetInfo(activityId, heroId)
	self:setReward(activityId, heroId)
end

function SummonNewCustomPickViewModel:getHaveFirstDayLogin(activityId)
	local key = self:getDaliyLoginKey(activityId)

	return TimeUtil.getDayFirstLoginRed(key)
end

function SummonNewCustomPickViewModel:setHaveFirstDayLogin(activityId)
	local key = self:getDaliyLoginKey(activityId)

	TimeUtil.setDayFirstLoginRed(key)
end

function SummonNewCustomPickViewModel:getDaliyLoginKey(activityId)
	return PlayerPrefsKey.Version2_2SummonNewCustomPatFace .. tostring(activityId)
end

function SummonNewCustomPickViewModel:setCurActId(activityId)
	self._actId = activityId

	SummonNewCustomPickChoiceController.instance:onSelectActivity(activityId)
end

function SummonNewCustomPickViewModel:getCurActId()
	return self._actId
end

function SummonNewCustomPickViewModel:setReward(activityId, heroId)
	local activityMo = self:getActivityInfo(activityId)

	if activityMo then
		activityMo.heroId = heroId
	end

	activityMo = SummonNewCustomPickViewMo.New(activityId, heroId)
	self._activityMoDic[activityId] = activityMo
end

function SummonNewCustomPickViewModel:setSelect(activityId, selectId)
	local activityMo = self:getActivityInfo(activityId)

	if not activityMo then
		return
	end

	if self:isSelect(activityMo) then
		return
	end

	activityMo.selectId = selectId
end

function SummonNewCustomPickViewModel:getMaxSelectCount()
	return self.MAX_SELECT_COUNT
end

function SummonNewCustomPickViewModel:getSummonPickScope(activityId)
	local config = SummonNewCustomPickViewConfig.instance:getSummonConfigById(activityId)

	return config.heroIds
end

function SummonNewCustomPickViewModel:getSummonInfo(activityId)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(activityId)
end

function SummonNewCustomPickViewModel:isSelect(activityId)
	local activityMo = self:getActivityInfo(activityId)

	if activityMo == nil then
		return false
	end

	return self:isMoSelect(activityMo)
end

function SummonNewCustomPickViewModel:isActivityOpen(activityId)
	local nowTime = ServerTime.now() * 1000

	if not activityId or not ActivityModel.instance:isActOnLine(activityId) then
		return false
	end

	local startTime = ActivityModel.instance:getActStartTime(activityId)

	if nowTime < startTime then
		return false
	end

	local endTime = ActivityModel.instance:getActEndTime(activityId)

	if endTime <= nowTime then
		return false
	end

	return true
end

function SummonNewCustomPickViewModel:isMoSelect(activityMo)
	return activityMo.activityId ~= SummonNewCustomPickViewModel.DEFAULT_HERO_ID
end

function SummonNewCustomPickViewModel:isNewbiePoolExist()
	return SummonMainModel.instance:getNewbiePoolExist()
end

function SummonNewCustomPickViewModel:isGetReward(activityId)
	local activityMo = self:getActivityInfo(activityId)

	if activityMo == nil then
		return false
	end

	return activityMo.heroId ~= self.DEFAULT_HERO_ID
end

function SummonNewCustomPickViewModel:getActivityInfo(activityId)
	return self._activityMoDic[activityId]
end

function SummonNewCustomPickViewModel:setGetRewardFxState(activityId, state)
	self._showFx[activityId] = state
end

function SummonNewCustomPickViewModel:getGetRewardFxState(activityId)
	return not not self._showFx[activityId]
end

SummonNewCustomPickViewModel.instance = SummonNewCustomPickViewModel.New()

return SummonNewCustomPickViewModel
