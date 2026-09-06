-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/model/ContractNewestPetModel.lua

module("logic.extensions.contract.model.ContractNewestPetModel", package.seeall)

local ContractNewestPetModel = class("ContractNewestPetModel", BaseModel)

function ContractNewestPetModel:ctor()
	return
end

function ContractNewestPetModel:onInit()
	self._childAsAdult = {}

	self:onReset()
end

function ContractNewestPetModel:onReset()
	self._selectedPetId = nil
	self._petIndex = nil
end

function ContractNewestPetModel:getSelectedPetId()
	return self._selectedPetId
end

function ContractNewestPetModel:getSelectedPetIndex()
	return self._petIndex or 1
end

function ContractNewestPetModel:getPetListLen()
	return #self._allPet
end

function ContractNewestPetModel:getIndexPet(index)
	self._petIndex = index

	return self._allPet[index]
end

function ContractNewestPetModel:setSelectedPet(raceId)
	self._selectedPetId = self._childAsAdult[raceId] and self._childAsAdult[raceId] or raceId

	if self._allPet == nil then
		self:getPetDatas()
	end

	for i = 1, #self._allPet do
		if self._allPet[i].raceId == self._selectedPetId then
			self._petIndex = i

			break
		end
	end
end

function ContractNewestPetModel:getPetDatas()
	self._allPet = {}

	local raceIdList = ContractConfig.instance:getSummonMasterRaceIdList()

	for _, raceId in ipairs(raceIdList) do
		local cfg = CharacterConfig.instance:getPetCo(raceId)

		if cfg and cfg.raceIdsBeforeEvolve then
			self._childAsAdult[cfg.raceIdsBeforeEvolve] = cfg.raceId
		end

		table.insert(self._allPet, cfg)
	end

	printInfo("test 新展示神启精灵总数", #self._allPet)
end

ContractNewestPetModel.instance = ContractNewestPetModel.New()

return ContractNewestPetModel
