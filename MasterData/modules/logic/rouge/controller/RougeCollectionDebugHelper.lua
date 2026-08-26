-- chunkname: @modules/logic/rouge/controller/RougeCollectionDebugHelper.lua

module("modules.logic.rouge.controller.RougeCollectionDebugHelper", package.seeall)

local RougeCollectionDebugHelper = _M

function RougeCollectionDebugHelper.checkCollectionStaticItmeCfgs()
	if not isDebugBuild then
		return
	end

	local allCfgs = RougeCollectionConfig.instance:getAllItemStaticDescCfgs()

	if allCfgs then
		for _, itemCfg in ipairs(allCfgs) do
			local collectionCfgId = itemCfg.id
			local itmeCfgId_1 = tonumber(itemCfg.item1)
			local itmeCfgId_2 = tonumber(itemCfg.item2)
			local itmeCfgId_3 = tonumber(itemCfg.item3)
			local enchantCfgIds = {
				itmeCfgId_1,
				itmeCfgId_2,
				itmeCfgId_3
			}

			RougeCollectionDescHelper.setCollectionDescInfos3(collectionCfgId, enchantCfgIds)
		end
	end
end

function RougeCollectionDebugHelper.checkCollectionDescCfgs()
	if not isDebugBuild then
		return
	end

	local attrValueMap = {}
	local allCfgs = RougeCollectionConfig.instance:getAllCollectionDescCfgs()

	if allCfgs then
		for _, cfg in ipairs(allCfgs) do
			local desc = cfg.desc

			RougeCollectionExpressionHelper.getDescExpressionResult(desc, attrValueMap)
		end
	end
end

return RougeCollectionDebugHelper
