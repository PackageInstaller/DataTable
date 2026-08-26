-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti_chess.lua

module("modules.configs.excel2json.lua_activity161_graffiti_chess", package.seeall)

local lua_activity161_graffiti_chess = {}
local fields = {
	chessId = 1,
	pos = 3,
	resource = 2
}
local primaryKey = {
	"chessId"
}
local mlStringKey = {}

function lua_activity161_graffiti_chess.onLoad(json)
	lua_activity161_graffiti_chess.configList, lua_activity161_graffiti_chess.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity161_graffiti_chess
