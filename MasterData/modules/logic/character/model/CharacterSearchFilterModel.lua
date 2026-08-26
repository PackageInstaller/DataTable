-- chunkname: @modules/logic/character/model/CharacterSearchFilterModel.lua

module("modules.logic.character.model.CharacterSearchFilterModel", package.seeall)

local CharacterSearchFilterModel = class("CharacterSearchFilterModel", BaseModel)

function CharacterSearchFilterModel:onInit()
	self:clearSelectTag()

	self._addLowTags = {}
	self._showMappingTags = nil
end

function CharacterSearchFilterModel:reInit()
	self:onInit()
end

function CharacterSearchFilterModel:_initLocalTags()
	self._tagsDict = {}
	self._tagCosDict = {}

	for _, co in ipairs(lua_character_battle_tag.configList) do
		local isHidden = CharacterBackpackEnum.HiddenTags[co.id]

		if not isHidden then
			local type = self:getLocalTagTypeByCo(co)

			if type then
				self._tagsDict[type] = self._tagsDict[type] or {}

				table.insert(self._tagsDict[type], co)
			end

			self._tagCosDict[co.id] = co
		end
	end

	self:_initShowMappingTags()
end

function CharacterSearchFilterModel:_initShowMappingTags()
	if self._showMappingTags then
		return
	end

	self._showMappingTags = {}

	for tagId, constId in pairs(CharacterBackpackEnum.ShowMappingTags) do
		local co = lua_fight_const.configDict[constId]
		local value = co and co.value

		if string.nilorempty(value) then
			logError("CharacterSearchFilterModel:_initShowMappingTags constId:" .. tostring(constId) .. " value nil")
		else
			local list = string.split(value, ",")
			local tagConfig = lua_character_battle_tag.configDict[tagId]
			local type = tagConfig and tagConfig.typeid

			if not type then
				logError("CharacterSearchFilterModel:_initShowMappingTags tagId:" .. tostring(tagId) .. " type nil")
			end

			local mapList = {}

			for i, id in ipairs(list) do
				mapList[id] = true
			end

			self._showMappingTags[tagId] = {
				type = type,
				mapList = mapList
			}
		end
	end
end

function CharacterSearchFilterModel:getLocalTagCo(id)
	if not self._tagCosDict then
		self:_initLocalTags()
	end

	return self._tagCosDict[id]
end

function CharacterSearchFilterModel:getTagTypeById(id)
	local co = self:getLocalTagCo(id)

	return self:getLocalTagTypeByCo(co)
end

function CharacterSearchFilterModel:getLocalTagTypeByCo(co)
	return co and co.typeid
end

function CharacterSearchFilterModel:getLocalTags(type)
	if not self._tagsDict then
		self:_initLocalTags()
	end

	return self._tagsDict[type]
end

function CharacterSearchFilterModel:setEditing(isEditing)
	self._isEditing = isEditing

	if not isEditing then
		self._readyAddLowTags = {}
	end
end

function CharacterSearchFilterModel:isEditing()
	return self._isEditing
end

function CharacterSearchFilterModel:selectLocalTag(tagId)
	local type = self:getTagTypeById(tagId)

	type = type == CharacterBackpackEnum.TagId.CharacterFeaturesLow and CharacterBackpackEnum.TagId.CharacterFeaturesHigh or type

	if self._selectLocal[type] then
		local index = tabletool.indexOf(self._selectLocal[type], tagId)
		local isSelect = index ~= nil

		if isSelect then
			table.remove(self._selectLocal[type], index)
		else
			self._selectLocal[type] = self._selectLocal[type] or {}

			table.insert(self._selectLocal[type], tagId)
		end

		self:_onSelectLocalTagChange(type, self._selectLocal[type])

		return not isSelect
	end
end

function CharacterSearchFilterModel:_onSelectLocalTagChange(type, list)
	if not self._showMappingTags then
		return
	end

	for tagId, info in pairs(self._showMappingTags) do
		local mapType = info.type
		local mapList = info.mapList

		if mapType == type then
			local tagMapping = false

			for i, id in ipairs(list) do
				if mapList[id] then
					tagMapping = true
				end
			end

			tabletool.removeValue(list, tagId)

			if tagMapping then
				table.insert(list, tagId)
			end
		end
	end
end

function CharacterSearchFilterModel:isSelectLocalTag(tagId)
	local type = self:getTagTypeById(tagId)

	type = type == CharacterBackpackEnum.TagId.CharacterFeaturesLow and CharacterBackpackEnum.TagId.CharacterFeaturesHigh or type

	if self._selectLocal[type] then
		local index = tabletool.indexOf(self._selectLocal[type], tagId)

		return index ~= nil
	end
end

function CharacterSearchFilterModel:getSelectLocalTags()
	return self._selectLocal
end

function CharacterSearchFilterModel:refreshEditorLowTags(value)
	if not string.nilorempty(value) then
		self._addLowTags = string.split(value, "#")
	end
end

function CharacterSearchFilterModel:addEditorLowTags(tagId, isAdd)
	local index = tabletool.indexOf(self._addLowTags, tagId)

	if isAdd and not index then
		table.insert(self._addLowTags, tagId)
	else
		table.remove(self._addLowTags, index)

		local isSelect = self:isSelectLocalTag(tagId)

		if isSelect then
			self:selectLocalTag(tagId)
		end
	end
end

function CharacterSearchFilterModel:getAddLowTags()
	return self._addLowTags
end

function CharacterSearchFilterModel:cacheReadyAddLowTags(tags)
	self._readyAddLowTags = tags
end

function CharacterSearchFilterModel:getReadyAddLowTags()
	return self._readyAddLowTags
end

function CharacterSearchFilterModel:saveEditorTags()
	local value = ""

	for i, tagId in ipairs(self._addLowTags) do
		value = i == 1 and tagId or value .. "#" .. tagId
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.HeroSearchFilterTags, value)
end

function CharacterSearchFilterModel:setSelectDmgs(dmgs)
	self._selectDmgs = dmgs
end

function CharacterSearchFilterModel:getSelectDmgs()
	return self._selectDmgs or {}
end

function CharacterSearchFilterModel:setSelectDestiny(destiny)
	self._selectDestiny = destiny
end

function CharacterSearchFilterModel:getSelectDestiny()
	return self._selectDestiny
end

function CharacterSearchFilterModel:setSelectAttrs(attrs)
	self._selectAttrs = attrs
end

function CharacterSearchFilterModel:getSelectAttrs()
	return self._selectAttrs or {}
end

function CharacterSearchFilterModel:clearSelectTag()
	self._selectDmgs = {}
	self._selectAttrs = {}
	self._selectLocal = {}
	self._selectDestiny = nil

	CharacterModel.instance:clearTagCountDict()
end

function CharacterSearchFilterModel:exitParentView()
	self:clearSelectTag()
	self:setEditing(false)
end

function CharacterSearchFilterModel:onComfirmSearchFilter(dmgs, attrs)
	self._selectDmgs = {}
	self._selectAttrs = {}

	local _dmgs = {}
	local _attrs = {}

	for i, select in pairs(dmgs) do
		if select == true then
			table.insert(_dmgs, i)
			table.insert(self._selectDmgs, i)
		end
	end

	if #_dmgs == 0 then
		for i = 1, CharacterBackpackEnum.dmgItemCount do
			table.insert(_dmgs, i)
		end
	end

	for i, select in pairs(attrs) do
		if select == true then
			table.insert(_attrs, i)
			table.insert(self._selectAttrs, i)
		end
	end

	if #_attrs == 0 then
		for i = 1, CharacterBackpackEnum.attrItemCount do
			table.insert(_attrs, i)
		end
	end

	return _dmgs, _attrs
end

function CharacterSearchFilterModel:hasFilter()
	for _, v in pairs(self._selectDmgs) do
		if v then
			return true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			return true
		end
	end

	if self._selectDestiny then
		return true
	end

	for _, v in pairs(self._selectLocal) do
		if v then
			return true
		end
	end
end

CharacterSearchFilterModel.instance = CharacterSearchFilterModel.New()

return CharacterSearchFilterModel
