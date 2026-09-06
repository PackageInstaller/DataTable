-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpoint/model/RedPointEggModel.lua

module("logic.extensions.redpoint.model.RedPointEggModel", package.seeall)

local RedPointEggModel = class("RedPointEggModel", BaseModel)

function RedPointEggModel:ctor()
	return
end

function RedPointEggModel:onInit()
	return
end

function RedPointEggModel:onReset()
	return
end

function RedPointEggModel:_initNewEggList()
	local str = GameUtil.getLocalString(self:_getNewEggListKey())

	if not GameUtil.isEmptyString(str) then
		-- block empty
	end

	self._newEggList = {}
	self._newEggListStr = ""
end

function RedPointEggModel:getNewEggList()
	if not self._newEggList then
		self:_initNewEggList()
	end

	return self._newEggList
end

function RedPointEggModel:_getNewEggListKey()
	self._newEggListKey = self._newEggListKey or RoleModel.instance:getUserName() .. "_newEggListKey"

	return self._newEggListKey
end

function RedPointEggModel:addNewEggForRedpointRecord(id)
	if not id or id <= 0 then
		return
	end

	printInfo(string.format("addNewEggForRedpointRecord,id:%d", id))

	if not self._newEggList then
		self:_initNewEggList()
	end

	table.insert(self._newEggList, id)

	self._newEggListStr = #self._newEggList > 1 and self._newEggListStr .. "," .. id or "" .. id

	GameUtil.setLocalString(self:_getNewEggListKey(), self._newEggListStr)
	printInfo("addNewEggForRedpointRecord done")
	RedPointModel.instance:updateAllRedPoint()
end

function RedPointEggModel:hasAnyNewEgg()
	if not self._newEggList then
		self:_initNewEggList()
	end

	return #self._newEggList > 0
end

function RedPointEggModel:isNewEgg(id)
	if not self._newEggList then
		self:_initNewEggList()
	end

	local isNew = TableUtil.isHad(self._newEggList, id)

	printInfo("isNewEgg:" .. id .. "," .. tostring(isNew))

	return isNew
end

function RedPointEggModel:removeNewEggForRedpointRecord(id)
	if not self._newEggList then
		self:_initNewEggList()
	end

	if not TableUtil.isHad(self._newEggList, id) then
		return
	end

	local newList = {}
	local newListStr = ""

	for k, v in ipairs(self._newEggList) do
		if v ~= id then
			table.insert(newList, v)

			newListStr = #newList > 1 and "," .. id or id .. ""
		end
	end

	self._newEggList = newList
	self._newEggListStr = newListStr

	GameUtil.setLocalString(self:_getNewEggListKey(), self._newEggListStr)
	RedPointModel.instance:updateAllRedPoint()
end

RedPointEggModel.instance = RedPointEggModel.New()

return RedPointEggModel
