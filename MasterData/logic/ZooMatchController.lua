-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/controller/ZooMatchController.lua

module("logic.extensions.zoo.controller.ZooMatchController", package.seeall)

local ZooMatchController = class("ZooMatchController", BaseController)

function ZooMatchController:onInit()
	self:onReset()
end

function ZooMatchController:onReset()
	self._lastInviteMatchAnimalId = 0
	self._lastInviteMatchFriendId = 0
	self._lastHandleBuddyMatchFriendId = 0
	self._lastHandleBuddyMatchId = 0
	self._lastHandleBuddyMatchResult = false
	self._putMatchAnimalId = 0

	removetimer(self._autoRemoveInvitationList, self)
end

function ZooMatchController:sendPM_ZooInviteBuddyMatchReq(buddyId, animalId)
	self._lastInviteMatchAnimalId = animalId
	self._lastInviteMatchFriendId = buddyId

	ZooAgent.instance:sendPM_ZooInviteBuddyMatchReq(buddyId, animalId)
end

function ZooMatchController:onZooInviteBuddyMatch(msg)
	if self._lastInviteMatchFriendId == 0 then
		return
	end

	local friendId = self._lastInviteMatchFriendId
	local animalId = self._lastInviteMatchAnimalId

	self._lastInviteMatchAnimalId = 0
	self._lastInviteMatchFriendId = 0

	ZooMatchModel.instance:setMatchAnimalId(animalId)
	ZooMatchModel.instance:setMatchFriendId(friendId)

	local animalMo = ZooModel.instance:getMyAnimalById(animalId)
	local friendMo = FriendModel.instance:getFriendMo(friendId)

	UIStateManager.instance:push(ViewName.ZooInviteView, animalMo, friendMo)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooInviteFriendMatch, friendId, animalId)
end

function ZooMatchController:onZooNotifyBuddyMatchAccpet(msg)
	local friendId = ZooMatchModel.instance:getMatchFriendId()
	local animalId = ZooMatchModel.instance:getMatchAnimalId()

	if friendId ~= msg.buddyId or animalId == 0 then
		return
	end

	ZooMatchModel.instance:setMatchId(msg.matchingId)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyPairAccept)
	UIStateManager.instance:popByName(ViewName.ZooinvitepairView)

	local animalMo = ZooModel.instance:getMyAnimalById()

	UIStateManager.instance:push(ViewName.ZoopairView, animalId, friendId)
end

function ZooMatchController:onZooNotifyBuddyMatchReject(msg)
	local friendId = ZooMatchModel.instance:getMatchFriendId()

	if friendId ~= msg.buddyId then
		return
	end

	ZooMatchModel.instance:setMatchId(0)
	ZooMatchModel.instance:setMatchAnimalId(0)
	ZooMatchModel.instance:setMatchFriendId(0)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyPairRefuse, msg.matchingId, msg.buddyId)
end

function ZooMatchController:onZooNotifyBuddyMatchCancel(msg)
	local matchId = ZooMatchModel.instance:getMatchId()

	if matchId ~= msg.matchingId then
		return
	end

	local friendId = ZooMatchModel.instance:getMatchFriendId()

	ZooMatchModel.instance:setMatchId(0)
	ZooMatchModel.instance:setMatchAnimalId(0)
	ZooMatchModel.instance:setMatchFriendId(0)
	TipsFacade.instance:openTipWindow(lang("tip"), lang("petzoo_match_cancel"))
	GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyPairCancel, matchId, friendId)
end

function ZooMatchController:sendPM_ZooHandleBuddyMatchRequestReq(matchId, buddyId, accept)
	if accept then
		if EscortModel.instance:IsPickupEscort() then
			FloatWordMgr.instance:show(lang("petzoo_match_inescort"))

			return
		end

		if SceneMgr.instance.isGogingToEnterBattleScene or AnswerSceneController.instance:isAnsweringQuestion() then
			FloatWordMgr.instance:show(lang("petzoo_match_noavailable"))

			return
		end
	end

	self._lastHandleBuddyMatchId = matchId
	self._lastHandleBuddyMatchFriendId = buddyId
	self._lastHandleBuddyMatchResult = accept

	ZooAgent.instance:sendPM_ZooHandleBuddyMatchRequestReq(buddyId, accept)
end

function ZooMatchController:onZooHandleBuddyMatchRequestRes(msg)
	if self._lastHandleBuddyMatchFriendId == 0 then
		return
	end

	local matchId = self._lastHandleBuddyMatchId
	local friendId = self._lastHandleBuddyMatchFriendId
	local lastResult = self._lastHandleBuddyMatchResult

	self._lastHandleBuddyMatchFriendId = 0
	self._lastHandleBuddyMatchResult = false
	self._lastHandleBuddyMatchId = 0

	local invitationMO = ZooMatchModel.instance:removeFriendInvitation(matchId)

	if lastResult then
		ZooMatchModel.instance:setMatchId(matchId)
		ZooMatchModel.instance:setMatchFriendId(friendId)
		UIStateManager.instance:push(ViewName.ZoopairView, 0, invitationMO.friendId, invitationMO)
	else
		ZooMatchModel.instance:setMatchId(0)
		ZooMatchModel.instance:setMatchAnimalId(0)
		ZooMatchModel.instance:setMatchFriendId(0)
	end

	self:_checkInvitationRedPoints()
	GlobalDispatcher:dispatch(GlobalNotify.OnZooHandleFriendInvitation, invitationMO, lastResult)
end

function ZooMatchController:onZooNotifyBuddyMatchInvite(msg)
	ZooMatchModel.instance:addFriendInvitation(msg)
	self:_checkInvitationRedPoints()
	GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyPairInvite)
end

function ZooMatchController:_checkInvitationRedPoints()
	local initeMaxTime = ZooConfig.instance:getInviteMatchWaitingTime()
	local maxTime = 0
	local invitationList = ZooMatchModel.instance:getAllFriendInvitations()

	if invitationList then
		local now = ServerTime.now()

		for i = #invitationList, 1, -1 do
			local startTime = invitationList[i].startTime

			if now >= startTime + initeMaxTime then
				table.remove(invitationList, i)
			else
				maxTime = math.max(initeMaxTime + startTime - now, maxTime)
			end
		end
	end

	if maxTime > 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_ZOO_PAIR, FuncOpenModel.instance:getFuncIsOpen(110))
		removetimer(self._autoRemoveInvitationList, self)
		settimer(maxTime, self._autoRemoveInvitationList, self)
	else
		self:_autoRemoveInvitationList()
	end
end

function ZooMatchController:_autoRemoveInvitationList()
	removetimer(self._autoRemoveInvitationList, self)
	ZooMatchModel.instance:clearFriendInvitations()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ZOO_PAIR, false)
end

function ZooMatchController:sendPM_ZooCancelBuddyMatchReq()
	local matchId = ZooMatchModel.instance:getMatchId()

	if matchId == 0 then
		return
	end

	ZooAgent.instance:sendPM_ZooCancelBuddyMatchReq()
end

function ZooMatchController:onZooCancelBuddyMatch(status, msg)
	ZooMatchModel.instance:setMatchId(0)
	ZooMatchModel.instance:setMatchAnimalId(0)
	ZooMatchModel.instance:setMatchFriendId(0)
	GlobalDispatcher:dispatch(GlobalNotify.ZooPairCancel)
end

function ZooMatchController:sendPM_ZooPutBuddyMatchAnimalReq(animalId)
	self._putMatchAnimalId = animalId

	ZooAgent.instance:sendPM_ZooPutBuddyMatchAnimalReq(animalId)
end

function ZooMatchController:onZooPutBuddyMatchAnimalRes(msg)
	if self._putMatchAnimalId == 0 then
		return
	end

	local animalId = self._putMatchAnimalId

	self._putMatchAnimalId = 0

	local eggId = msg.eggId

	ZooMatchModel.instance:setMatchAnimalId(animalId)
	GlobalDispatcher:dispatch(GlobalNotify.OnZooPutBuddyMatchAnimal, animalId, eggId)
end

function ZooMatchController:onZooNotifyBuddyMatchReady(msg)
	local matchId = ZooMatchModel.instance:getMatchId()

	if matchId ~= msg.matchingId then
		return
	end

	local animalMo = AnimalModel.New()

	animalMo:initData({
		id = msg.animalId,
		raceId = msg.animalRace,
		name = msg.animalName,
		geneInfo = msg.animalGene
	})
	GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyBuddyMatchReady, animalMo)
end

function ZooMatchController:sendPM_ZooConfirmBuddyMatchReq()
	ZooAgent.instance:sendPM_ZooConfirmBuddyMatchReq()
end

function ZooMatchController:onZooConfirmBuddyMatchRes(msg)
	local animalId = ZooMatchModel.instance:getMatchAnimalId()

	if animalId ~= 0 then
		local animalMo = ZooModel.instance:getMyAnimalById(animalId)

		animalMo.restMatchTimes = animalMo.restMatchTimes - 1
		animalMo.matchCdEndTime = ServerTime.now() + ZooConfig.instance:getMatchCDInterval()

		local eggid = tonumber(msg.eggId)

		GlobalDispatcher:dispatch(GlobalNotify.OnZooConfirmBuddyMatch, eggid)
	end
end

function ZooMatchController:onZooNotifyBuddyMatchFinish(msg)
	local matchId = ZooMatchModel.instance:getMatchId()

	if matchId ~= msg.matchingId then
		return
	end

	local animalId = ZooMatchModel.instance:getMatchAnimalId()

	if animalId ~= 0 then
		local animalMo = ZooModel.instance:getMyAnimalById(animalId)

		animalMo.restMatchTimes = animalMo.restMatchTimes - 1
		animalMo.matchCdEndTime = ServerTime.now() + ZooConfig.instance:getMatchCDInterval()

		local eggid = tonumber(msg.eggId)

		GlobalDispatcher:dispatch(GlobalNotify.OnZooNotifyPairFinish, eggid)
	end
end

ZooMatchController.instance = ZooMatchController.New()

return ZooMatchController
