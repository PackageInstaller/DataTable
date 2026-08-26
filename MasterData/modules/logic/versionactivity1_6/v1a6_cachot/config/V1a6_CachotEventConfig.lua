-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/config/V1a6_CachotEventConfig.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotEventConfig", package.seeall)

local V1a6_CachotEventConfig = class("V1a6_CachotEventConfig", BaseConfig)

function V1a6_CachotEventConfig:onInit()
	self._dramaChoiceDict = {}
	self._dramaChoiceGroupToId = {}
end

function V1a6_CachotEventConfig:reqConfigNames()
	return {
		"rogue_collection_drop",
		"rogue_collection_group",
		"rogue_dialog",
		"rogue_event",
		"rogue_event_drama_choice",
		"rogue_event_fight",
		"rogue_event_hint",
		"rogue_event_life",
		"rogue_event_revive",
		"rogue_goods",
		"rogue_shop",
		"rogue_ending",
		"rogue_event_drop_desc",
		"rogue_event_tips"
	}
end

function V1a6_CachotEventConfig:onConfigLoaded(configName, configTable)
	if configName == "rogue_event_drama_choice" then
		for _, v in pairs(configTable.configList) do
			if v.type == 1 then
				self._dramaChoiceGroupToId[v.group] = v.id
			elseif v.type == 2 then
				self._dramaChoiceDict[v.group] = self._dramaChoiceDict[v.group] or {}

				table.insert(self._dramaChoiceDict[v.group], v)
			end
		end
	elseif configName == "rogue_collection_drop" then
		self:onCollectionDropConfigLoaded(configTable)
	end
end

function V1a6_CachotEventConfig:onCollectionDropConfigLoaded(configTab)
	self._collectionDropMap = {}

	for _, dropCfg in ipairs(configTab.configList) do
		self._collectionDropMap[dropCfg.groupId] = self._collectionDropMap[dropCfg.groupId] or {}

		table.insert(self._collectionDropMap[dropCfg.groupId], dropCfg)
	end
end

function V1a6_CachotEventConfig:getChoiceCos(group)
	return self._dramaChoiceDict[group]
end

function V1a6_CachotEventConfig:getDramaId(group)
	return self._dramaChoiceGroupToId[group]
end

function V1a6_CachotEventConfig:getEventHeartShow(eventId, difficulty)
	local eventCo = lua_rogue_event.configDict[eventId]

	if not eventCo then
		return
	end

	local showTxt
	local addHeart = 0

	if eventCo.type == V1a6_CachotEnum.EventType.Battle then
		local fightCo = lua_rogue_event_fight.configDict[eventCo.eventId]

		if fightCo then
			local heartChange = fightCo["heartChange" .. difficulty]

			if not string.nilorempty(heartChange) then
				local arr = string.split(heartChange, "|") or {}

				for i = 1, #arr do
					local heartVal = string.match(arr[i], "^1#1#(-?[0-9]+)$")

					if heartVal then
						addHeart = tonumber(heartVal)

						break
					end
				end
			end
		end
	end

	local var_7_0 = eventCo["dropGroup" .. difficulty]

	if not eventCo["dropGroup" .. difficulty] then
		var_7_0 = eventCo.dropGroup

		if not eventCo.dropGroup then
			local drops = ""
			local dropArr = string.split(drops, "|") or {}

			for i = 1, #dropArr do
				local key = string.match(dropArr[i], "^[0-9]+#(heart[1-3])$")

				if key and not string.nilorempty(eventCo[key]) then
					if showTxt then
						showTxt = "?"

						break
					else
						showTxt = string.format("%+d", (tonumber(eventCo[key]) or 0) + addHeart)
					end
				end
			end

			if not showTxt and addHeart ~= 0 then
				showTxt = string.format("%+d", addHeart)
			end

			return showTxt
		end
	end
end

function V1a6_CachotEventConfig:getCollectionDropListByGroupId(groupId)
	return self._collectionDropMap and self._collectionDropMap[groupId]
end

function V1a6_CachotEventConfig:getBgmIdByLayer(layer)
	if not self._bgmIdDict then
		self._bgmIdDict = {}

		local arr = GameUtil.splitString2(lua_rogue_const.configDict[V1a6_CachotEnum.Const.LayerBGM].value, true)

		for _, v in ipairs(arr) do
			self._bgmIdDict[v[1]] = v[2]
		end
	end

	return self._bgmIdDict[layer] or self._bgmIdDict[0]
end

function V1a6_CachotEventConfig:getSceneIdByLayer(layer)
	if not self._sceneIdDict then
		self._sceneIdDict = {}

		local arr = GameUtil.splitString2(lua_rogue_const.configDict[V1a6_CachotEnum.Const.LayerFightScene].value, true)

		for _, v in ipairs(arr) do
			self._sceneIdDict[v[1]] = {
				sceneId = v[2],
				levelId = v[3]
			}
		end
	end

	return self._sceneIdDict[layer] or self._sceneIdDict[1]
end

function V1a6_CachotEventConfig:getDescCoByEventId(eventId)
	local descCo, desc
	local eventCo = lua_rogue_event.configDict[eventId]

	if eventCo then
		if eventCo.type == V1a6_CachotEnum.EventType.CharacterCure then
			local cureCo = lua_rogue_event_life.configDict[eventCo.eventId]
			local arr = string.splitToNumber(cureCo.num, "#")
			local type = arr[1]

			if not arr[2] then
				local num = cureCo.lifeAdd / 10

				descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.CureEvent][type]

				if type == 1 then
					desc = GameUtil.getSubPlaceholderLuaLang(descCo.desc, {
						arr[2],
						num
					})
				elseif type == 2 then
					desc = GameUtil.getSubPlaceholderLuaLang(descCo.desc, {
						arr[2],
						num
					})
				elseif type == 3 then
					desc = GameUtil.getSubPlaceholderLuaLang(descCo.desc, {
						num
					})
				end
			end
		elseif eventCo.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			local reviveCo = lua_rogue_event_revive.configDict[eventCo.eventId]
			local type = string.splitToNumber(reviveCo.num, "#")[1]

			descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.ReviveEvent][type]
		elseif eventCo.type == V1a6_CachotEnum.EventType.CharacterGet then
			descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.CharacterGet][1]
		elseif eventCo.type == V1a6_CachotEnum.EventType.HeroPosUpgrade then
			descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.HeroPosUpgrade][1]
		end
	end

	return descCo, desc
end

V1a6_CachotEventConfig.instance = V1a6_CachotEventConfig.New()

return V1a6_CachotEventConfig
