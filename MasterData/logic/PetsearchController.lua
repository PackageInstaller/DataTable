-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/controller/PetsearchController.lua

module("logic.extensions.petsearch.controller.PetsearchController", package.seeall)

local PetsearchController = class("PetsearchController", BaseController)

PetsearchController.REDPOIND_KEY = "PetsearchController"

function PetsearchController:ctor()
	PetsearchController.super.ctor(self)
end

function PetsearchController:onReset()
	self.callBackList = {}
	self.callBackIdx = 0

	self:initRedPoint()
end

function PetsearchController:onInit()
	self:onReset()
	SeekPetAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.showChangeSet, self))
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
end

function PetsearchController:initRedPoint()
	GameUtil.getUserDayData(PetsearchController.REDPOIND_KEY, function(value)
		if checknumber(value) == 0 then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETSEARCH, true)
		end
	end)
end

function PetsearchController:resetRedPoint()
	GameUtil.saveUserDayData(PetsearchController.REDPOIND_KEY, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETSEARCH, false)
end

function PetsearchController:rmCallbackByIdx(idx, isHandle)
	local callBack = self.callBackList[idx]

	if idx and callBack then
		if isHandle then
			GameUtil.callBack(callBack.func, callBack.target)
		end

		self.callBackList[idx] = nil
	end
end

function PetsearchController:rmAllcallBack()
	self.callBackList = {}
end

function PetsearchController:addCallBack(cb, cbTarget)
	if cb ~= nil and type(cb) == "function" then
		self.callBackIdx = self.callBackIdx + 1

		local callBack = {}

		callBack.func = cb
		callBack.target = cbTarget
		self.callBackList[self.callBackIdx] = callBack

		return self.callBackIdx
	end
end

function PetsearchController:showChangeSet(changeSetId, msgName)
	if msgName == "handleNotifyAfterChallengeRes" then
		BattleSettlementModel.instance:setChangeSetId(changeSetId)
	else
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function PetsearchController:sendGetInfo(cb, cbTarget)
	local idx = self:addCallBack(cb, cbTarget)

	SeekPetAgent.instance:sendPM_SeekPetInfoReq(function(msg)
		PetsearchModel.instance:updateAfterGetInfo(msg)
		self:rmCallbackByIdx(idx, true)
	end)
end

function PetsearchController:sendSeekPet(cb, cbTarget)
	local idx = self:addCallBack(cb, cbTarget)

	SeekPetAgent.instance:sendPM_SeekPetReq(function(msg)
		PetsearchModel.instance:setCurBossId(msg.boss)
		GlobalDispatcher:dispatch(GlobalNotify.StartSearchPet)
		self:rmCallbackByIdx(idx, true)
	end)
end

function PetsearchController:sendSeekPetRefresh(cb, cbTarget)
	local idx = self:addCallBack(cb, cbTarget)

	SeekPetAgent.instance:sendPM_SeekPetRefreshReq(function(msg)
		PetsearchModel.instance:setCurBossId(msg.boss)
		PetsearchModel.instance:addCurRefreshTimes()
		UIStateManager.instance:popByName(ViewName.PetsearchsuccessView)
		GlobalDispatcher:dispatch(GlobalNotify.StartSearchPet)
		self:rmCallbackByIdx(idx, true)
	end)
end

function PetsearchController:sendSeekPetDirectly(bossId, cb, cbTarget)
	local idx = self:addCallBack(cb, cbTarget)

	SeekPetAgent.instance:sendPM_SeekPetDirectlyReq(bossId, function(msg)
		PetsearchModel.instance:setCurBossId(msg.boss)
		UIStateManager.instance:popByName(ViewName.PetsearchsuccessView)
		UIStateManager.instance:popByName(ViewName.PetsearchdirectView)
		GlobalDispatcher:dispatch(GlobalNotify.StartSearchPet)
		self:rmCallbackByIdx(idx, true)
	end)
end

function PetsearchController:sendSeekPetChallenge(cb, cbTarget)
	local idx = self:addCallBack(cb, cbTarget)

	SeekPetAgent.instance:sendPM_SeekPetChallengeReq(function(msg)
		self:rmCallbackByIdx(idx, true)
	end)
end

function PetsearchController:_dailyReset()
	PetsearchModel.instance:onReset()
	GlobalDispatcher:dispatch(GlobalNotify.RefreshSearchPet)
end

PetsearchController.instance = PetsearchController.New()

return PetsearchController
