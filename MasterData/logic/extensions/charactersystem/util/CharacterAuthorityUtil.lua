-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/util/CharacterAuthorityUtil.lua

module("logic.extensions.charactersystem.util.CharacterAuthorityUtil", package.seeall)

local M = class("CharacterAuthorityUtil")
local NormalNode = 20

function M.isNodeUnlock(herodata, nodeId)
	if herodata and nodeId and nodeId >= 0 then
		local nodesInfo = herodata:getNodesInfo()
		local extNodesInfo = herodata:getExtNodesInfo()

		if nodeId <= NormalNode then
			if nodeId <= #nodesInfo then
				return true
			end
		elseif nodeId > NormalNode then
			for _, v in ipairs(extNodesInfo) do
				if nodeId == v then
					return true
				end
			end
		end
	end

	return false
end

return M
