-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petdisplay/model/PetDisplayModel.lua

module("logic.extensions.petdisplay.module.PetDisplayModel", package.seeall)

local PetDisplayModel = class("PetDisplayModel", BaseModel)

function PetDisplayModel:ctor()
	self._newPetList = {}
	self._callbacks = {}
	self._newPetIds = {}
end

function PetDisplayModel:onInit()
	self:onReset()
end

function PetDisplayModel:onReset()
	self._newPetList = {}
	self._callbacks = {}
	self._newPetIds = {}
end

function PetDisplayModel:addNewPet(petId)
	table.insert(self._newPetList, 1, petId)
end

function PetDisplayModel:getNewPet()
	local count = #self._newPetList

	if count == 0 then
		return nil
	end

	local petId = self._newPetList[count]

	table.remove(self._newPetList)

	return petId
end

function PetDisplayModel:addNewPetId(petId)
	if checknumber(petId) > 0 then
		self._newPetIds[petId] = true
	end
end

function PetDisplayModel:isPetIdNew(petId)
	return self._newPetIds[petId] == true
end

function PetDisplayModel:ClearList()
	self._newPetList = {}
end

function PetDisplayModel:getNewPetList()
	return self._newPetList
end

function PetDisplayModel:getNewCount()
	return #self._newPetList
end

function PetDisplayModel:hasNewPet()
	return self:getNewCount() > 0
end

function PetDisplayModel:setCallback(callback)
	self._callbacks = self._callbacks or {}

	table.insert(self._callbacks, callback)
end

function PetDisplayModel:excuteCallback()
	if self._callbacks and #self._callbacks > 0 then
		for k, func in pairs(self._callbacks) do
			GameUtil.callBack(func)
		end

		table.clear(self._callbacks)
	end
end

PetDisplayModel.instance = PetDisplayModel.New()

return PetDisplayModel
