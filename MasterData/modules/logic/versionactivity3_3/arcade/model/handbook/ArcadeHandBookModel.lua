-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookModel.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookModel", package.seeall)

local ArcadeHandBookModel = class("ArcadeHandBookModel", BaseModel)

function ArcadeHandBookModel:onInit()
	self._listModel = ArcadeHandBookListModel.instance
end

function ArcadeHandBookModel:reInit()
	return
end

function ArcadeHandBookModel:initModel()
	self._moDict = {}

	local luaConfigList = {
		lua_arcade_character,
		lua_arcade_monster,
		lua_arcade_collection,
		lua_arcade_floor,
		lua_arcade_interactive_unit
	}

	for _, lua in ipairs(luaConfigList) do
		for _, co in ipairs(lua.configList) do
			local tag = co.category

			if not string.nilorempty(tag) then
				local param = ArcadeEnum.HandBookParams[tag]

				if param then
					self._moDict[tag] = self._moDict[tag] or BaseModel.New()

					local id = co.id

					if self._moDict[tag][id] then
						logError(tag .. "  " .. co.id)
					end

					local mo = param.MO.New(id, tag, co)

					self._moDict[tag]:addAtLast(mo)
				end
			end
		end
	end

	for type, v in pairs(self._moDict) do
		local list = v:getList()

		table.sort(list, function(a, b)
			return a.id < b.id
		end)
	end
end

function ArcadeHandBookModel:refreshInfo(bookInfo)
	if not self._moDict then
		self:initModel()
	end

	local list = {}

	for type, _ in pairs(self._moDict) do
		local moList = self:getMoListByType(type)

		for _, mo in pairs(moList) do
			mo:setLock(true)
			mo:setCount(0)
			mo:setNew(false)
		end

		local param = ArcadeEnum.HandBookParams[type]

		list[param.InfoType] = type
	end

	if bookInfo and bookInfo.books then
		for i = 1, #bookInfo.books do
			local info = bookInfo.books[i]
			local type = list[info.type]

			for j = 1, #info.eleId do
				local id = info.eleId[j]
				local mo = self:getMoByTypeId(type, id)

				if mo then
					local count = mo:getCount()

					mo:setCount(count + 1)
					mo:setLock(false)
				end
			end

			for j = 1, #info.newEleId do
				local id = info.newEleId[j]
				local mo = self:getMoByTypeId(type, id)

				if mo then
					local isLock = mo:isLock()
					local prefsKey, key = mo:getReddotKey()
					local value = ArcadeOutSizeModel.instance:getPlayerPrefsValue(prefsKey, key, 0, true)
					local isNew = not isLock and value == 0

					mo:setNew(isNew)
					mo:saveNew(isNew)
				end
			end
		end
	end
end

function ArcadeHandBookModel:openView(type, id)
	if not self._moDict then
		self:initModel()
	end

	self:setShowTypeId(type, id)
	self:showModel()
end

function ArcadeHandBookModel:curTab(type)
	self:setShowTypeId(type)
	self:showModel()
end

function ArcadeHandBookModel:getMoListByType(type)
	if not self._moDict then
		self:initModel()
	end

	return self._moDict[type]:getList()
end

function ArcadeHandBookModel:getMoByTypeId(type, id)
	if not self._moDict then
		self:initModel()
	end

	local dict = self._moDict[type]:getDict()

	return dict[id]
end

function ArcadeHandBookModel:getTypeByIndex(index)
	for type, param in pairs(ArcadeEnum.HandBookParams) do
		if param.sort == index then
			return type
		end
	end
end

function ArcadeHandBookModel:getDefaultId(type)
	local moList = self:getMoListByType(type)

	return moList[1] and moList[1].id
end

function ArcadeHandBookModel:setShowTypeId(type, id)
	self._showType = type or ArcadeEnum.HandBookType.Character
	self._curId = id or self:getDefaultId(self._showType)
end

function ArcadeHandBookModel:getShowTypeId()
	return self._showType, self._curId
end

function ArcadeHandBookModel:showModel()
	self._listModel:setMoList(self._showType)
end

function ArcadeHandBookModel:getCurShowMo()
	return self:getMoByTypeId(self._showType, self._curId)
end

function ArcadeHandBookModel:getMo(type, id)
	return self:getMoByTypeId(type, id)
end

function ArcadeHandBookModel:hasReddot()
	for _, type in pairs(ArcadeEnum.HandBookType) do
		if self:hasReddotByType(type) then
			return true
		end
	end
end

function ArcadeHandBookModel:hasReddotByType(type)
	local moList = self:getMoListByType(type)

	if moList then
		for _, mo in ipairs(moList) do
			if mo:isNew() then
				return true
			end
		end
	end
end

ArcadeHandBookModel.instance = ArcadeHandBookModel.New()

return ArcadeHandBookModel
