-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petawakenverification/model/PetAwakenVerificationModel.lua

module("logic.extensions.petawakenverification.model.PetAwakenVerificationModel", package.seeall)

local PetAwakenVerificationModel = class("PetAwakenVerificationModel", BaseModel)

function PetAwakenVerificationModel:ctor()
	return
end

function PetAwakenVerificationModel:onInit()
	self:onReset()
end

function PetAwakenVerificationModel:onReset()
	self._activityId = 0
	self._infoRes = {
		infos = {}
	}
	self._prizeRes = {
		prizeId = 0,
		id = 0,
		petId = 0,
		changeSetId = 0
	}
end

function PetAwakenVerificationModel:onHandlePetAwakenVerificationGetInfoRes(msg)
	self._activityId = checknumber(msg.activityId)
	self._infoRes.infos = {}

	for _, info in ipairs(msg.infos) do
		local tab = {}

		tab.id = checknumber(info.id)
		tab.gainedPrizeIds = {}

		for idx, prizeId in ipairs(info.gainedPrizeIds) do
			table.insert(tab.gainedPrizeIds, checknumber(prizeId))
		end

		table.insert(self._infoRes.infos, tab)
	end
end

function PetAwakenVerificationModel:onHandlePetAwakenVerificationGainPrizeRes(msg)
	self._activityId = checknumber(msg.activityId)
	self._prizeRes = {
		id = checknumber(msg.id),
		prizeId = checknumber(msg.prizeId),
		petId = checknumber(msg.petId),
		changeSetId = checknumber(msg.changeSetId)
	}

	for _, info in ipairs(self._infoRes.infos) do
		if info.id == self._prizeRes.id then
			table.insert(info.gainedPrizeIds, self._prizeRes.prizeId)
		end
	end
end

function PetAwakenVerificationModel:getInfoById(id)
	local infos = self._infoRes.infos

	for _, info in ipairs(infos) do
		if info.id == id then
			return info
		end
	end

	return {}
end

function PetAwakenVerificationModel:getGainedPrizeIdsById(id)
	local infos = self._infoRes.infos

	for _, info in ipairs(infos) do
		if info.id == id then
			return info.gainedPrizeIds
		end
	end

	return {}
end

PetAwakenVerificationModel.instance = PetAwakenVerificationModel.New()

return PetAwakenVerificationModel
