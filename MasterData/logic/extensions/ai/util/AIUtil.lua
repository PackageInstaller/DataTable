-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/util/AIUtil.lua

module("logic.extensions.ai.util.AIUtil", package.seeall)

local AIUtil = _M

function AIUtil.parseAINodeConfig(nodeJsonData, context)
	local aiClass = AIUtil.getAIClass(nodeJsonData.type)

	if not aiClass then
		printError(string.format("the ai type[%s] is unsupported!", nodeJsonData.type))
	end

	local aiObj = aiClass:createInstance(context)

	aiObj:initFromConfig(nodeJsonData)

	if nodeJsonData.children then
		for _, childNode in ipairs(nodeJsonData.children) do
			local childObj = AIUtil.parseAINodeConfig(childNode, context)

			aiObj:addChild(childObj)
		end
	end

	return aiObj
end

function AIUtil.buildAI(unit, aiConfigName)
	if not string.nilorempty(aiConfigName) then
		AIUtil.returnUnitAI(unit)

		local aiConfigData = AIUtil.getAIConfigData(aiConfigName)
		local context = AIContext:createInstance(unit, aiConfigName)
		local firstAI = AIUtil.parseAINodeConfig(aiConfigData.root, context)
		local newAI = AIRoot:createInstance(context)

		newAI:addChild(firstAI)
		newAI:setName(aiConfigName)
		unit.ai:setAI(newAI)

		return newAI
	else
		unit.ai:setAI(nil)
	end
end

function AIUtil.getAIClass(aiType)
	local aiClassName = "AI" .. aiType
	local aiClass = _G[aiClassName]

	return aiClass
end

function AIUtil.getAIConfigData(aiName)
	local t = require("logic.config.t_" .. aiName)

	if not t or type(t) ~= "table" then
		printError(string.format("require AIConfig[%s] failed", aiName))

		return
	end

	return t.aiConfigData
end

function AIUtil.returnUnitAI(unit)
	local ai = unit.ai:getAI()

	if ai then
		ai:returnSelf()
	end
end

return AIUtil
