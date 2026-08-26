-- chunkname: @modules/logic/sodache/config/SodacheConfig.lua

module("modules.logic.sodache.config.SodacheConfig", package.seeall)

local SodacheConfig = class("SodacheConfig", BaseConfig)

function SodacheConfig:reqConfigNames()
	return {
		"sodache_const",
		"sodache_unlock",
		"sodache_skill",
		"sodache_item",
		"sodache_card",
		"sodache_building",
		"sodache_handbook",
		"sodache_upgrade",
		"sodache_copy",
		"sodache_tickets",
		"sodache_event",
		"sodache_event_group",
		"sodache_shop",
		"sodache_goods",
		"sodache_bubble_talk",
		"sodache_bubble_talk_step",
		"sodache_choice",
		"sodache_dice",
		"sodache_dialog",
		"sodache_difficulty",
		"sodache_level",
		"sodache_task",
		"sodache_attr"
	}
end

function SodacheConfig:onInit()
	self._copyCos = {}
	self._copyGroups = {}
	self._allMapCo = {}
	self._itemPrice = {}
	self._shopchats = {}
	self._diceInfos = {}
	self._eventIdToInitChoiceIds = {}
	self._eventDialogCoDict = {}
end

function SodacheConfig:onConfigLoaded(configName, configTable)
	local func = self["process_" .. configName]

	if func then
		func(self, configTable)
	end

	if isDebugBuild then
		local inst = SodacheConfigCheck.instance

		func = inst["process_" .. configName]

		if inst["process_" .. configName] then
			func(inst, configTable)
		end
	end
end

function SodacheConfig:process_sodache_dialog(configTable)
	for i, v in ipairs(configTable.configList) do
		self._eventDialogCoDict[v.group] = self._eventDialogCoDict[v.group] or {}
		self._eventDialogCoDict[v.group][v.order] = v
	end
end

function SodacheConfig:process_sodache_dice(configTable)
	for i, v in ipairs(configTable.configList) do
		local arr = string.splitToNumber(v.faceList, "#") or {}

		if #arr ~= 6 then
			logError("骰子不是6面的？" .. v.id)
		end

		local info = {}

		for _, vv in pairs(SodacheEnum.DiceColor) do
			info[vv] = 0
		end

		for _, vv in ipairs(arr) do
			if not info[vv] then
				logError("骰子颜色未定义:" .. v.id .. " >> " .. vv)
			else
				info[vv] = info[vv] + 1
			end
		end

		self._diceInfos[v.id] = info
	end
end

function SodacheConfig:process_sodache_card(configTable)
	for i, v in ipairs(configTable.configList) do
		self._itemPrice[v.id] = v.price
	end
end

function SodacheConfig:process_sodache_copy(configTable)
	for i, v in ipairs(configTable.configList) do
		self._copyCos[v.type] = v
	end
end

function SodacheConfig:process_sodache_bubble_talk(configTable)
	for i, v in ipairs(configTable.configList) do
		local arr = string.splitToNumber(v.condition, "#") or {}

		if not arr[1] then
			local type = 0
			local info = {}

			info.id = v.id
			info.weight = v.weight
			info.param = {
				unpack(arr, 2)
			}
			self._shopchats[type] = self._shopchats[type] or {}

			table.insert(self._shopchats[type], info)
		end
	end
end

function SodacheConfig:process_sodache_choice(configTable)
	for i, v in ipairs(configTable.configList) do
		if v.initialSelect == 1 then
			self._eventIdToInitChoiceIds[v.eventId] = self._eventIdToInitChoiceIds[v.eventId] or {}

			table.insert(self._eventIdToInitChoiceIds[v.eventId], v.id)
		end
	end
end

function SodacheConfig:getInitChoice(eventId)
	return self._eventIdToInitChoiceIds[eventId] or {}
end

function SodacheConfig:getEventDialog(dialogId)
	return self._eventDialogCoDict[dialogId]
end

function SodacheConfig:getShopChatRandomCo(type, checkFunc)
	local infos = self._shopchats[type]

	if not infos then
		return
	end

	local list = infos

	if checkFunc then
		list = {}

		for i, v in ipairs(infos) do
			if checkFunc(v) then
				table.insert(list, v)
			end
		end
	end

	local totalWeight = 0

	for i, v in ipairs(list) do
		totalWeight = totalWeight + v.weight
	end

	local randomNum = math.random(1, totalWeight)
	local index = 1

	while list[index] and randomNum > list[index].weight do
		randomNum = randomNum - list[index].weight
		index = index + 1
	end

	if list[index] then
		local id = list[index].id

		if not id then
			return
		end

		return lua_sodache_bubble_talk_step.configDict[id]
	end
end

function SodacheConfig:getConstVal(constId)
	local co = lua_sodache_const.configDict[constId]

	if not co then
		return "", ""
	end

	return co.value, co.mlvalue
end

function SodacheConfig:getConstNum(constId)
	return tonumber((self:getConstVal(constId))) or 0
end

function SodacheConfig:getItemCo(itemType, itemId)
	if itemType == SodacheEnum.ItemType.Item then
		return lua_sodache_item.configDict[itemId]
	elseif itemType == SodacheEnum.ItemType.Card then
		return lua_sodache_card.configDict[itemId]
	end
end

function SodacheConfig:getAllCopyGroups()
	return self._copyGroups
end

function SodacheConfig:getCopyCo(mapType)
	return GameUtil.getTbValue(self._copyCos, mapType)
end

function SodacheConfig:getMapCo(copyId)
	if not self._allMapCo[copyId] then
		local data = addGlobalModule("modules.configs.sodache.lua_sodache_map_" .. tostring(copyId), "lua_sodache_map_" .. tostring(copyId))
		local mapCo = SodacheMapCo.New()

		mapCo:init(data)

		self._allMapCo[copyId] = mapCo
	end

	return self._allMapCo[copyId]
end

function SodacheConfig:getItemPrice(itemId)
	return self._itemPrice[itemId] or 0
end

function SodacheConfig:getHandBookCfgList(subType)
	local list = {}

	for _, v in ipairs(lua_sodache_handbook.configList) do
		if v.tab2 == subType then
			list[#list + 1] = v
		end
	end

	table.sort(list, function(a, b)
		if a.tab1 == SodacheEnum.HandBookType.Card then
			local configA = lua_sodache_card.configDict[a.eleId]
			local configB = lua_sodache_card.configDict[b.eleId]

			if configA.quality == configB.quality then
				return a.id < b.id
			else
				return configA.quality < configB.quality
			end
		else
			return a.id < b.id
		end
	end)

	return list
end

function SodacheConfig:getDiceColorInfo(diceId)
	return self._diceInfos[diceId]
end

SodacheConfig.instance = SodacheConfig.New()

return SodacheConfig
