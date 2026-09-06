-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/ZooMatchModel.lua

module("logic.extensions.zoo.model.ZooMatchModel", package.seeall)

local ZooMatchModel = class("ZooMatchModel", BaseModel)

function ZooMatchModel:onInit()
	self:onReset()
end

function ZooMatchModel:onReset()
	self._pairInviteList = nil
	self._matchingFriendId = 0
	self._matchingMatchId = 0
	self._matchingAnimalId = 0
	self._friendInitationList = nil
end

function ZooMatchModel:setMatchAnimalId(animalId)
	self._matchingAnimalId = animalId
end

function ZooMatchModel:getMatchAnimalId()
	return self._matchingAnimalId
end

function ZooMatchModel:setMatchFriendId(friendId)
	self._matchingFriendId = friendId
end

function ZooMatchModel:getMatchFriendId()
	return self._matchingFriendId
end

function ZooMatchModel:setMatchId(matchId)
	self._matchingMatchId = matchId
end

function ZooMatchModel:getMatchId()
	return self._matchingMatchId
end

function ZooMatchModel:addFriendInvitation(msg)
	self._friendInitationList = self._friendInitationList or {}

	local animalMo = AnimalModel.New()

	animalMo:initData({
		id = msg.animalId,
		raceId = msg.animalRace,
		name = msg.animalName,
		geneInfo = msg.animalGene
	})

	local invitation = FriendInvitationMO.New()

	invitation.matchId = msg.matchingId
	invitation.animalMo = animalMo
	invitation.startTime = tonumber(msg.startTime) / 1000
	invitation.friendMo = FriendModel.instance:getFriendMo(msg.buddyId)
	invitation.friendId = msg.buddyId

	table.insert(self._friendInitationList, invitation)
end

function ZooMatchModel:getFriendInvitation(matchId)
	if not self._friendInitationList then
		return
	end

	for i = 1, #self._friendInitationList do
		if self._friendInitationList[i].matchId == matchId then
			return self._friendInitationList[i]
		end
	end
end

function ZooMatchModel:removeFriendInvitation(matchId)
	if not self._friendInitationList then
		return
	end

	for i = 1, #self._friendInitationList do
		if self._friendInitationList[i].matchId == matchId then
			local friendMO = self._friendInitationList[i]

			table.remove(self._friendInitationList, i)

			return friendMO
		end
	end
end

function ZooMatchModel:getAllFriendInvitations()
	return self._friendInitationList
end

function ZooMatchModel:clearFriendInvitations()
	self._friendInitationList = nil
end

ZooMatchModel.instance = ZooMatchModel.New()

return ZooMatchModel
