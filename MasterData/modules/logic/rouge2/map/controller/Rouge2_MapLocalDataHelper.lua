-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapLocalDataHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapLocalDataHelper", package.seeall)

local Rouge2_MapLocalDataHelper = class("Rouge2_MapLocalDataHelper")

function Rouge2_MapLocalDataHelper.isNodeUnlockAnim(layerId, nodeId)
	local unlockNodeMap = Rouge2_MapLocalDataHelper._getTempData(Rouge2_MapLocalDataHelper.Key.UnlockNode)
	local nodeIdMap = unlockNodeMap and unlockNodeMap[layerId]

	return nodeIdMap and tabletool.indexOf(nodeIdMap, nodeId) ~= nil
end

function Rouge2_MapLocalDataHelper.addUnlockAnimNode(layerId, nodeId)
	local unlockNodeMap = Rouge2_MapLocalDataHelper._getTempData(Rouge2_MapLocalDataHelper.Key.UnlockNode)

	unlockNodeMap = unlockNodeMap or {}
	unlockNodeMap[layerId] = unlockNodeMap[layerId] or {}

	table.insert(unlockNodeMap[layerId], nodeId)

	local unlockNodeStrList = {}

	for layerId, nodeIdList in pairs(unlockNodeMap) do
		local nodeIdStr = table.concat(nodeIdList, "#")
		local layerIdWithNodeIdStr = layerId .. "#" .. nodeIdStr

		table.insert(unlockNodeStrList, layerIdWithNodeIdStr)
	end

	local unlockNodeStr = table.concat(unlockNodeStrList, "|")

	Rouge2_MapLocalDataHelper._addTempData(Rouge2_MapLocalDataHelper.Key.UnlockNode, unlockNodeMap)
	Rouge2_MapLocalDataHelper._saveLocalData(Rouge2_MapLocalDataHelper.Key.UnlockNode, unlockNodeStr)
end

function Rouge2_MapLocalDataHelper._initUnlockAnimNode(key)
	local dataStr = GameUtil.playerPrefsGetStringByUserId(key, "")
	local dataList = GameUtil.splitString2(dataStr, true)
	local dataMap = {}

	if dataList then
		for _, data in ipairs(dataList) do
			local layerId = data[1]

			dataMap[layerId] = dataMap[layerId] or {}

			local dataNum = #data

			for i = 2, dataNum do
				local nodeId = data[i]

				table.insert(dataMap[layerId], nodeId)
			end
		end
	end

	return dataMap
end

function Rouge2_MapLocalDataHelper.getItemReddotStatus(itemUid)
	local readItemMap = Rouge2_MapLocalDataHelper._getTempData(Rouge2_MapLocalDataHelper.Key.ReadItem)
	local status = readItemMap and readItemMap[itemUid]

	return status or Rouge2_Enum.ItemStatus.New
end

function Rouge2_MapLocalDataHelper.setItemReddotStatus(itemUid, status)
	local readItemMap = Rouge2_MapLocalDataHelper._getTempData(Rouge2_MapLocalDataHelper.Key.ReadItem)

	readItemMap = readItemMap or {}
	readItemMap[itemUid] = status

	local itemStatusStrList = {}

	for uid, itemStatus in pairs(readItemMap) do
		table.insert(itemStatusStrList, string.format("%s#%s", uid, itemStatus))
	end

	local itemStatusStr = table.concat(itemStatusStrList, "|")

	Rouge2_MapLocalDataHelper._addTempData(Rouge2_MapLocalDataHelper.Key.ReadItem, readItemMap)
	Rouge2_MapLocalDataHelper._saveLocalData(Rouge2_MapLocalDataHelper.Key.ReadItem, itemStatusStr)
end

function Rouge2_MapLocalDataHelper._initItemReddotStatusMap(key)
	local dataStr = GameUtil.playerPrefsGetStringByUserId(key, "")
	local statusList = GameUtil.splitString2(dataStr, true)
	local itemStatusMap = {}

	if statusList then
		for _, statusInfo in ipairs(statusList) do
			local itemUid = statusInfo[1]

			itemStatusMap[itemUid] = statusInfo[2]
		end
	end

	return itemStatusMap
end

function Rouge2_MapLocalDataHelper.getActiveSkillDropIndex(skillId)
	local skillCo = Rouge2_BackpackHelper.getItemConfig(skillId)

	if not skillCo then
		return 0
	end

	if not skillCo.skillTypeName then
		local skillType = ""
		local dropIndexInfo = Rouge2_MapLocalDataHelper._getTempData(Rouge2_MapLocalDataHelper.Key.ActiveSkillDropIndex)
		local dropIndexMap = dropIndexInfo and dropIndexInfo.map
		local dropIndex = dropIndexMap and dropIndexMap[skillType]

		dropIndex = dropIndex or 0

		return dropIndex
	end
end

function Rouge2_MapLocalDataHelper.setActiveSkillDropIndex(skillId)
	local originIndex = Rouge2_MapLocalDataHelper.getActiveSkillDropIndex(skillId)

	if originIndex and originIndex ~= 0 then
		return
	end

	local skillCo = Rouge2_BackpackHelper.getItemConfig(skillId)

	if skillCo then
		if not skillCo.skillTypeName then
			local skillType = ""
			local dropIndexInfo = Rouge2_MapLocalDataHelper._getTempData(Rouge2_MapLocalDataHelper.Key.ActiveSkillDropIndex)

			dropIndexInfo = dropIndexInfo or {
				map = {},
				list = {}
			}

			local dropIndexList = dropIndexInfo and dropIndexInfo.list

			if dropIndexList then
				if not #dropIndexList then
					local dropIndexNum = 0

					dropIndexInfo.map[skillType] = dropIndexNum + 1

					table.insert(dropIndexList, skillType)

					local dropIndexMapStr = table.concat(dropIndexList, "#")

					Rouge2_MapLocalDataHelper._addTempData(Rouge2_MapLocalDataHelper.Key.ActiveSkillDropIndex, dropIndexInfo)
					Rouge2_MapLocalDataHelper._saveLocalData(Rouge2_MapLocalDataHelper.Key.ActiveSkillDropIndex, dropIndexMapStr)
				end
			end
		end
	end
end

function Rouge2_MapLocalDataHelper._initActiveSkillDropIndexMap()
	local dropIndexMapStr = Rouge2_MapLocalDataHelper._getLocalData(Rouge2_MapLocalDataHelper.Key.ActiveSkillDropIndex, "")
	local dropIndexList = string.splitToNumber(dropIndexMapStr, "#") or {}
	local dropIndexMap = {}

	for i, skillType in ipairs(dropIndexList) do
		dropIndexMap[skillType] = i
	end

	return {
		map = dropIndexMap,
		list = dropIndexList
	}
end

function Rouge2_MapLocalDataHelper._addTempData(key, value)
	Rouge2_MapLocalDataHelper._localData = Rouge2_MapLocalDataHelper._localData or {}
	Rouge2_MapLocalDataHelper._localData[key] = value
end

function Rouge2_MapLocalDataHelper._getTempData(key)
	if not Rouge2_MapLocalDataHelper._initData or not Rouge2_MapLocalDataHelper._initData[key] then
		local initFunc = Rouge2_MapLocalDataHelper.InitFunction[key]

		if initFunc then
			local data = initFunc(key)

			Rouge2_MapLocalDataHelper._addTempData(key, data)
		end

		Rouge2_MapLocalDataHelper._initData = Rouge2_MapLocalDataHelper._initData or {}
		Rouge2_MapLocalDataHelper._initData[key] = true
	end

	return Rouge2_MapLocalDataHelper._localData and Rouge2_MapLocalDataHelper._localData[key]
end

function Rouge2_MapLocalDataHelper._getLocalData(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local isNumber = type(value) == "number"

	value = isNumber and GameUtil.playerPrefsGetNumberByUserId(key, value) or GameUtil.playerPrefsGetStringByUserId(key, value)

	return value
end

function Rouge2_MapLocalDataHelper._saveLocalData(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(key, value)
	else
		GameUtil.playerPrefsSetStringByUserId(key, value)
	end
end

function Rouge2_MapLocalDataHelper.clear()
	Rouge2_MapLocalDataHelper.clearAllTempData()
	Rouge2_MapLocalDataHelper.clearAllLocalData()
end

function Rouge2_MapLocalDataHelper.clearAllTempData()
	Rouge2_MapLocalDataHelper._initData = {}
	Rouge2_MapLocalDataHelper._localData = {}
end

function Rouge2_MapLocalDataHelper.clearAllLocalData()
	local userId = PlayerModel.instance:getMyUserId()

	if not userId then
		return
	end

	for _, key in pairs(Rouge2_MapLocalDataHelper.Key) do
		local prefsKey = key .. "#" .. tostring(userId)

		PlayerPrefsHelper.deleteKey(prefsKey)
	end
end

function Rouge2_MapLocalDataHelper.Init()
	Rouge2_MapLocalDataHelper.clearAllTempData()
end

Rouge2_MapLocalDataHelper.Key = {
	UnlockNode = PlayerPrefsKey.Rouge2PlayedUnlockAnimNodeId,
	ReadItem = PlayerPrefsKey.Rouge2ReadItemId,
	ActiveSkillDropIndex = PlayerPrefsKey.Rouge2ActiveSkillDropIndex
}
Rouge2_MapLocalDataHelper.InitFunction = {
	[Rouge2_MapLocalDataHelper.Key.UnlockNode] = Rouge2_MapLocalDataHelper._initUnlockAnimNode,
	[Rouge2_MapLocalDataHelper.Key.ReadItem] = Rouge2_MapLocalDataHelper._initItemReddotStatusMap,
	[Rouge2_MapLocalDataHelper.Key.ActiveSkillDropIndex] = Rouge2_MapLocalDataHelper._initActiveSkillDropIndexMap
}

return Rouge2_MapLocalDataHelper
