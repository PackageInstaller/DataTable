-- chunkname: @modules/logic/chessgame/config/ChessGameConfig.lua

module("modules.logic.chessgame.config.ChessGameConfig", package.seeall)

local ChessGameConfig = class("ChessGameConfig", BaseConfig)

function ChessGameConfig:ctor()
	self._mapCos = {}
	self._interactList = {}
end

function ChessGameConfig:reqConfigNames()
	return
end

function ChessGameConfig:getMapCo(mapGroupId)
	if not self._mapCos[mapGroupId] then
		local co = {}
		local rawCo = addGlobalModule("modules.configs.chessgame.lua_chessgame_group_" .. tostring(mapGroupId), "lua_chessgame_group_" .. tostring(mapGroupId))

		for i = 1, #rawCo do
			co[i] = {}
			co[i].path = rawCo[i][1]
			co[i].interacts = {}

			for k, v in ipairs(rawCo[i][2]) do
				co[i].interacts[k] = {}

				for name, index in pairs(ChessGameInteractField) do
					co[i].interacts[k][name] = v[index]
				end

				co[i].interacts[k].offset = {
					x = v[8][1],
					y = v[8][2],
					z = v[8][3]
				}
				co[i].interacts[k].effects = {}

				for index, val in ipairs(v[15]) do
					co[i].interacts[k].effects[index] = {
						type = val[1],
						param = val[2]
					}
				end

				self._interactList[mapGroupId] = self._interactList[mapGroupId] or {}
				self._interactList[mapGroupId][v[1]] = co[i].interacts[k]
			end

			co[i].nodes = {}

			for k, v in ipairs(rawCo[i][3]) do
				co[i].nodes[k] = {
					x = v[1],
					y = v[2]
				}
			end
		end

		self._mapCos[mapGroupId] = co
	end

	return self._mapCos[mapGroupId]
end

function ChessGameConfig:getInteractCoById(mapGroupId, id)
	return self._interactList[mapGroupId][id]
end

function ChessGameConfig:setCurrentMapGroupId(id)
	self._currentMapGroupId = id
end

function ChessGameConfig:getCurrentMapGroupId()
	return self._currentMapGroupId
end

function ChessGameConfig:getCurrentMapCo(mapIndex)
	if not self._currentMapGroupId then
		return
	end

	local mapGroupCo = self._mapCos[self._currentMapGroupId]

	if not mapGroupCo then
		return
	end

	if not mapIndex then
		return mapGroupCo[1]
	else
		return mapGroupCo[mapIndex]
	end
end

function ChessGameConfig:getCurrentMapCoList()
	return self._mapCos[self._currentMapGroupId]
end

ChessGameConfig.instance = ChessGameConfig.New()

return ChessGameConfig
