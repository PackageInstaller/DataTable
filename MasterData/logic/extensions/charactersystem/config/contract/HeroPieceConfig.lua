-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/config/contract/HeroPieceConfig.lua

module("logic.extensions.charactersystem.config.contract.HeroPieceConfig", package.seeall)

local M = class("HeroPieceConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.HeroPiece
	}
end

function M:getInfo(id)
	local tableInfo = self._dict[ConfigName.HeroPiece]
	local findInfo = tableInfo and tableInfo[id] or false

	return findInfo
end

M.instance = M.New()

return M
