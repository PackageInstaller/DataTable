-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/facade/MaterialFacade.lua

module("logic.extensions.material.facade.MaterialFacade", package.seeall)

local MaterialFacade = class("MaterialFacade", BaseFacade)
local json = require("cjson")

function MaterialFacade:ctor()
	return
end

function MaterialFacade:loadMaterialInfos()
	MaterialAgent.instance:sendLoadAllMaterialsReq(function(msg)
		forcePrint("=====RoleDataRequestor:_loadMaterials===back")
		MaterialModel.instance:onReset()

		local items = msg.allCommonItems

		MaterialModel.instance:setMaterials(items)
	end)
end

function MaterialFacade:getMaterialInfoByType(type, isSplit)
	local items = MaterialModel.instance:getMaterialsByType(type)

	if isSplit then
		return MaterialModel.instance:splitMaterials(items)
	else
		return items
	end
end

function MaterialFacade:getMatByTypeAndSub(subType)
	return MaterialModel.instance:getMaterialsByTypeAndSub(subType)
end

function MaterialFacade:useItem(materialType, materialId, num, extraParam, callBack, showType)
	extraParam = extraParam or ""

	MaterialController.instance:localNotify("ItemUsedBegin", materialType, materialId, num)
	MaterialAgent.instance:sendUseMaterialReq(materialType, materialId, num, extraParam, function(msg)
		local str = msg.resultParam

		if str ~= nil and str ~= "" then
			local obj = json.decode(str)

			if obj.changeSetId ~= nil then
				local changeSetId = checknumber(obj.changeSetId)

				if changeSetId >= 0 then
					MaterialController.instance:setChangeSetPopup(changeSetId, showType)
					MaterialController.instance:showItemsGetWindow(changeSetId)
				end
			end
		end

		MaterialController.instance:localNotify("ItemUsed", materialType, materialId, num)

		if callBack ~= nil then
			callBack()
		end
	end)
end

function MaterialFacade:batchUseItem(materialType, materialItems, extraParam, callback)
	local items_pb_Ary = {}

	for _, v in ipairs(materialItems) do
		local items = MaterialExtension_pb.MaterialItemNO()

		items.id = v.id
		items.num = v.num

		table.insert(items_pb_Ary, items)
	end

	MaterialAgent.instance:sendBatchUseMaterialReq(materialType, items_pb_Ary, extraParam, function(msg)
		GameUtil.callBack(callback, msg)
	end, nil, function(msg)
		GameUtil.callBack(callback, msg)
	end)
end

function MaterialFacade:getMatNumber(matType, id)
	matType = checknumber(matType)
	id = checknumber(id)

	return MaterialModel.instance:getMaterialsNumber(matType, id)
end

function MaterialFacade:getMatNumberByDefineId(matType, defineId, extKey)
	local count = 0

	if matType == MatType.Pet then
		count = BagPetsController.instance:getPetNumByRaceId(defineId)
	end

	return self:getMatNumber(matType, defineId)
end

function MaterialFacade:sellItem(type, id, num, callBack)
	MaterialAgent.instance:sendSellMaterialsReq(type, id, num, function(msg)
		MaterialController.instance:localNotify("ItemSold")

		if callBack ~= nil then
			callBack()
		end
	end)
end

function MaterialFacade:AddMaterial(matType, id, count)
	MaterialModel.instance:AddMaterial(matType, id, count)
end

function MaterialFacade:UpdateMaterial(matType, id, count)
	MaterialModel.instance:UpdateMaterial(matType, id, count, false)
end

function MaterialFacade:popAndShowChangeSetItems(changeSetId)
	MaterialController.instance:showItemsGetWindow(changeSetId)
end

function MaterialFacade:getItemsByChangeSetId(changeSetId)
	return MaterialController.instance:getItemsByChangeSetId(changeSetId)
end

function MaterialFacade:getMatCfg(matType, cfgId)
	return MaterialMgr.getMatCfg(checknumber(matType), checknumber(cfgId), 0)
end

function MaterialFacade:checkMatsEnough(str)
	return
end

function MaterialFacade:checkMatEnough(matType, matId, matNum, ownedNum, autoOpenSource)
	local isEnough = MaterialModel.instance:IsEnough(matType, matId, matNum, ownedNum)

	if not isEnough then
		local cfg = self:getMatCfg(matType, matId)

		if cfg then
			local na = MaterialMgr.getMaterialsName(matType, matId)

			FloatWordMgr.instance:show(langPara("%s数量不足", na))

			if autoOpenSource ~= false and not string.nilorempty(cfg.source) then
				MaterialMgr.openGetSource(matType, matId)
			end
		else
			FloatWordMgr.instance:show(lang("物品数量不足"))
		end
	end

	return isEnough
end

function MaterialFacade:CreateMOByString(str)
	return MaterialModel.instance:createMoByData(str)
end

function MaterialFacade:isMatsEnough(matsStr)
	if string.nilorempty(matsStr) then
		return true
	end

	local isEnough = true
	local t = string.split(matsStr, "#")

	for _, v in ipairs(t) do
		local curNum = MaterialMgr.getMatCount(v)
		local cost = self:getGoodCostByStr(v)

		isEnough = isEnough and cost <= curNum

		if not isEnough then
			break
		end
	end

	return isEnough
end

function MaterialFacade:getGoodCost(matType, matId, matNum)
	matType = checknumber(matType)
	matId = checknumber(matId)
	matNum = checknumber(matNum)

	return matNum * ((matType == MatType.Diamond_Consume or nil) and GoodsConfig.instance:getCfgPrice(matId))
end

function MaterialFacade:getGoodCostByStr(matStr)
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	return self:getGoodCost(matType, matId, matNum)
end

function MaterialFacade:getItemsInUseCfg(matType, matId)
	local queue = {}
	local visited = {}
	local result = {}

	local function addToQueue(useType, contentStr, depth)
		if string.nilorempty(contentStr) then
			return
		end

		local array

		if useType == MatUseType.EXCHANGE then
			array = {}

			local temp = string.split(contentStr, ",")

			table.insert(array, temp[2])
		elseif useType == MatUseType.PACK then
			array = string.split(contentStr, "#")
		elseif useType == MatUseType.WEIGHT_PACK then
			array = {}

			local list = string.split(contentStr, "|")

			for _, v in ipairs(list) do
				local sub = string.split(v, ",")

				for _, vv in ipairs(sub) do
					local temp = string.split(vv, "$")

					if temp and #temp >= 2 and temp[1] == "内容" then
						table.insert(array, temp[2])
					end
				end
			end
		else
			array = useType == MatUseType.MIX_SELECT and string.split(contentStr, ";") or useType == MatUseType.MIX_SELECT_ONCE and string.split(contentStr, ";") or {
				contentStr
			}
		end

		for _, subStr in ipairs(array or {}) do
			local matType, matId, matNum = MaterialMgr.getMatParams(subStr)

			if matType and matId then
				local key = string.format("%s:%s", matType, matId)

				if not visited[key] then
					table.insert(queue, {
						matType = matType,
						matId = matId,
						key = key,
						depth = depth
					})

					visited[key] = true
				end
			end
		end
	end

	local originalKey = string.format("%s:%s", matType, matId)

	visited[originalKey] = true

	table.insert(result, originalKey)

	local useCfg = MaterialConfig.instance:getCfgByMatAndId(matType, matId)

	if useCfg then
		addToQueue(useCfg.materialUseType, useCfg.content, 1)
	end

	while #queue > 0 do
		local node = table.remove(queue, 1)

		table.insert(result, node.key)

		local useCfg = MaterialConfig.instance:getCfgByMatAndId(node.matType, node.matId)

		if useCfg and not string.nilorempty(useCfg.content) and node.depth < 10 then
			addToQueue(useCfg.materialUseType, useCfg.content, node.depth + 1)
		end
	end

	return result
end

MaterialFacade.instance = MaterialFacade.New()

return MaterialFacade
