-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpoint/model/RedPointTitleModel.lua

module("logic.extensions.redpoint.model.RedPointTitleModel", package.seeall)

local RedPointTitleModel = class("RedPointTitleModel", BaseModel)

function RedPointTitleModel:ctor()
	return
end

function RedPointTitleModel:onInit()
	return
end

function RedPointTitleModel:onReset()
	return
end

function RedPointTitleModel:_initNewList()
	local str = GameUtil.getLocalString(self:_getNewListKey())

	if GameUtil.isEmptyString(str) then
		self._newList = {}
		self._newListStr = ""
	else
		local list = string.split(str, ",")

		self._newList = {}

		for i, v in ipairs(list) do
			local id = checknumber(v)

			if id > 0 then
				table.insert(self._newList, id)
			end
		end

		self._newListStr = str
	end
end

function RedPointTitleModel:_initCheckDic()
	local str = GameUtil.getLocalString(self:_getCheckDicKey())

	if GameUtil.isEmptyString(str) then
		self._hasCheckDic = {}
		self._hasCheckDicStr = ""
	else
		local list = string.split(str, ",")

		self._hasCheckDic = {}

		for i, v in ipairs(list) do
			local str2 = string.split(v, "_")
			local id = checknumber(str2[1])
			local gainTime = checknumber(str2[2])

			if id > 0 then
				self._hasCheckDic[id] = {
					gainTime = gainTime
				}
			end
		end

		self._hasCheckDicStr = str
	end
end

function RedPointTitleModel:_getCheckDicKey()
	self._newCheckDicKey = self._newCheckDicKey or RoleModel.instance:getUserName() .. "_CheckDicKey"

	return self._newCheckDicKey
end

function RedPointTitleModel:getNewPetList()
	if not self._newList then
		self:_initNewList()
	end

	return self._newList
end

function RedPointTitleModel:_getNewListKey()
	self._newPetListKey = self._newPetListKey or RoleModel.instance:getUserName() .. "_NewTitleList"

	return self._newPetListKey
end

function RedPointTitleModel:addNewTitleForRedpointRecord(id, gainTime)
	if id <= 0 then
		return
	end

	printInfo(string.format("addNewTitleForRedpointRecord,id:%d", id))

	if not self._newList then
		self:_initNewList()
	end

	if not self._hasCheckDic then
		self:_initCheckDic()
	end

	if self._hasCheckDic[id] and self._hasCheckDic[id].gainTime == gainTime then
		return
	end

	if TableUtil.isHad(self._newList, id) then
		-- block empty
	else
		table.insert(self._newList, id)

		self._newListStr = #self._newList > 1 and self._newListStr .. "," .. id or "" .. id

		GameUtil.setLocalString(self:_getNewListKey(), self._newListStr)
	end

	printInfo("addNewTitleForRedpointRecord done")
	RedPointModel.instance:updateAllRedPoint()
end

function RedPointTitleModel:hasAnyNew()
	if not self._newList then
		self:_initNewList()
	end

	local hasAnyNew = false

	for k, v in ipairs(self._newList) do
		if not TitleModel.instance:isOutdate(v) then
			hasAnyNew = true

			break
		end
	end

	return hasAnyNew
end

function RedPointTitleModel:isNew(id)
	if not self._newList then
		self:_initNewList()
	end

	local isNew = TableUtil.isHad(self._newList, id)

	return isNew and not TitleModel.instance:isOutdate(id)
end

function RedPointTitleModel:removeNewForRedpointRecord(id, gaintime)
	if not self._newList then
		self:_initNewList()
	end

	if TableUtil.isHad(self._newList, id) then
		local newList = {}
		local newListStr = ""

		for k, v in ipairs(self._newList) do
			if v ~= id then
				table.insert(newList, v)

				newListStr = #newList > 1 and "," .. id or id .. ""
			end
		end

		self._newList = newList
		self._newListStr = newListStr

		GameUtil.setLocalString(self:_getNewListKey(), self._newListStr)
		self:_addHasCheck(id, gaintime)
		RedPointModel.instance:updateAllRedPoint()
	end
end

function RedPointTitleModel:_addHasCheck(id, gainTime)
	if not self._hasCheckDic then
		self:_initCheckDic()
	end

	self._hasCheckDic[id] = {
		gainTime = gainTime
	}

	local tempStr = ""
	local isFirst = true

	for k, v in pairs(self._hasCheckDic) do
		if isFirst then
			isFirst = false
			tempStr = k .. "_" .. v.gainTime
		else
			tempStr = tempStr .. "," .. k .. "_" .. v.gainTime
		end
	end

	self._hasCheckDicStr = tempStr

	GameUtil.setLocalString(self:_getCheckDicKey(), self._hasCheckDicStr)
end

function RedPointTitleModel:updateHasGotPets()
	self._hasGotPets = {}

	local allPets = BagModel.instance:getPets()

	for k, v in pairs(allPets) do
		if not TableUtil.isHad(self._hasGotPets, v.raceId) then
			table.insert(self._hasGotPets, v.raceId)
		end
	end
end

RedPointTitleModel.instance = RedPointTitleModel.New()

return RedPointTitleModel
