-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/condition/handler/RogueConditionHandler_ByOwnMaxHero.lua

module("logic.extensions.roguelike.condition.handler.RogueConditionHandler_ByOwnMaxHero", package.seeall)

local M = class("RogueConditionHandler_ByOwnMaxHero", RogueBaseBuffHandler)

function M:ctor()
	return
end

function M:onAdd(entity, buffMO)
	return
end

function M:onTrigger(conditioinMO)
	local params = conditioinMO:getParams()
	local temp = string.split(params, "#")
	local name = temp[1]
	local compare = temp[2]
	local count = tonumber(temp[3])
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local fullCount = 0

	if name == "MAX_HP" then
		for k, v in pairs(allRoles) do
			local prop = v.roleProp

			if prop:getIsFullHp() then
				fullCount = fullCount + 1
			end
		end
	elseif name == "MAX_SAN" then
		for k, v in pairs(allRoles) do
			local prop = v.roleProp

			if prop:getIsFullHp() then
				fullCount = fullCount + 1
			end
		end
	end

	if compare == "E" then
		return fullCount == count
	elseif compare == "LE" then
		return fullCount <= count
	elseif compare == "GE" then
		return count <= fullCount
	end

	return false
end

function M:onRemove(entity, buffMO)
	return
end

return M
