-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpoint/model/RedPointPetModel.lua

module("logic.extensions.redpoint.model.RedPointPetModel", package.seeall)

local RedPointPetModel = class("RedPointPetModel", BaseModel)

function RedPointPetModel:ctor()
	return
end

function RedPointPetModel:onInit()
	return
end

function RedPointPetModel:onReset()
	return
end

function RedPointPetModel:_initNewPetList()
	local str = GameUtil.getLocalString(self:_getNewPetListKey())

	if GameUtil.isEmptyString(str) then
		self._newPetList = {}
		self._newPetListStr = ""
	else
		local list = string.split(str, ",")

		self._newPetList = {}

		for i, v in ipairs(list) do
			local id = checknumber(v)

			if id > 0 then
				table.insert(self._newPetList, id)
			end
		end

		self._newPetListStr = str
	end
end

function RedPointPetModel:getNewPetList()
	if not self._newPetList then
		self:_initNewPetList()
	end

	return self._newPetList
end

function RedPointPetModel:_getNewPetListKey()
	self._newPetListKey = self._newPetListKey or RoleModel.instance:getUserName() .. "_NewPetList"

	return self._newPetListKey
end

function RedPointPetModel:addNewPetForRedpointRecord(id, raceId)
	if id <= 0 then
		return
	end

	printInfo(string.format("addNewPetForRedpointRecord,id:%d,raceId:%d", id, raceId))

	if not self._newPetList then
		self:_initNewPetList()
	end

	self._hasGotPets = self._hasGotPets or {}

	if TableUtil.isHad(self._hasGotPets, raceId) then
		printInfo("has same race in bag already:" .. raceId)

		return
	else
		table.insert(self._hasGotPets, raceId)
	end

	table.insert(self._newPetList, id)

	self._newPetListStr = #self._newPetList > 1 and self._newPetListStr .. "," .. id or "" .. id

	GameUtil.setLocalString(self:_getNewPetListKey(), self._newPetListStr)
	printInfo("addNewPetForRedpointRecord done")
	RedPointModel.instance:updateAllRedPoint()
end

function RedPointPetModel:hasAnyNewPet()
	if not self._newPetList then
		self:_initNewPetList()
	end

	return #self._newPetList > 0
end

function RedPointPetModel:isNewPet(id)
	if not self._newPetList then
		self:_initNewPetList()
	end

	local isNew = TableUtil.isHad(self._newPetList, id)

	printInfo("isNewPet:" .. id .. "," .. tostring(isNew))

	return isNew
end

function RedPointPetModel:removeNewPetForRedpointRecord(id)
	if not self._newPetList then
		self:_initNewPetList()
	end

	if not TableUtil.isHad(self._newPetList, id) then
		return
	end

	local newList = {}
	local newListStr = ""

	for k, v in ipairs(self._newPetList) do
		if v ~= id then
			table.insert(newList, v)

			newListStr = #newList > 1 and "," .. id or id .. ""
		end
	end

	self._newPetList = newList
	self._newPetListStr = newListStr

	GameUtil.setLocalString(self:_getNewPetListKey(), self._newPetListStr)
	RedPointModel.instance:updateAllRedPoint()
end

function RedPointPetModel:updateHasGotPets()
	self._hasGotPets = {}

	local allPets = BagModel.instance:getPets()

	for k, v in pairs(allPets) do
		if not TableUtil.isHad(self._hasGotPets, v.raceId) then
			table.insert(self._hasGotPets, v.raceId)
		end
	end
end

RedPointPetModel.instance = RedPointPetModel.New()

return RedPointPetModel
