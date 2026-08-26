-- chunkname: @modules/logic/room/utils/RoomLayoutHelper.lua

module("modules.logic.room.utils.RoomLayoutHelper", package.seeall)

local RoomLayoutHelper = {}

function RoomLayoutHelper.tipLayoutAnchor(targetTrs, parentTrs, uiWorldPos, offWidth, offHeight)
	local uiPos = recthelper.rectToRelativeAnchorPos(uiWorldPos, parentTrs)
	local posX = uiPos.x
	local posY = uiPos.y
	local viewWidth = recthelper.getWidth(parentTrs)
	local viewHeight = recthelper.getHeight(parentTrs)
	local viewHalfWidth = viewWidth * 0.5
	local viewHalfHeight = viewHeight * 0.5
	local targetWidth = recthelper.getWidth(targetTrs)
	local targetHeight = recthelper.getHeight(targetTrs)
	local targetHalfWidth = targetWidth * 0.5
	local targetHalfHeight = targetHeight * 0.5
	local targetY = 0

	if offHeight and offHeight > 0 and targetHalfHeight < viewHalfHeight then
		targetY = posY > 0 and posY + offHeight - targetHalfHeight or posY + targetHalfHeight - offHeight

		local d = viewHalfHeight - targetHalfHeight

		if d <= targetY then
			targetY = d
		elseif targetY <= -d then
			targetY = -d
		end
	end

	local lwith = posX + targetWidth + offWidth

	if lwith <= viewHalfWidth then
		transformhelper.setLocalPos(targetTrs, posX + offWidth + targetHalfWidth, targetY, 0)
	else
		transformhelper.setLocalPos(targetTrs, posX - offWidth - targetHalfWidth, targetY, 0)
	end
end

function RoomLayoutHelper.findBlockInfos(blockInfos, isBirthdayBlock)
	local packageDict = {}
	local roleBirthdayList = {}

	if not blockInfos then
		return packageDict, roleBirthdayList
	end

	local tRoomConfig = RoomConfig.instance
	local isRoleBirthday = isBirthdayBlock == true

	for i, info in ipairs(blockInfos) do
		local blockCfg = not tRoomConfig:getInitBlock(info.blockId) and tRoomConfig:getBlock(info.blockId)

		if blockCfg then
			local packageId = blockCfg.packageId

			if isRoleBirthday and RoomBlockPackageEnum.ID.RoleBirthday == packageId then
				table.insert(roleBirthdayList, info.blockId)
			else
				packageDict[packageId] = not packageDict[packageId] and 1 or packageDict[packageId] + 1
			end
		end
	end

	return packageDict, roleBirthdayList
end

function RoomLayoutHelper.findbuildingInfos(buildingInfos)
	local buildingDict = {}

	if not buildingInfos then
		return buildingDict
	end

	for i, info in ipairs(buildingInfos) do
		local buildingId = info.defineId

		buildingDict[buildingId] = not buildingDict[buildingId] and 1 or buildingDict[buildingId] + 1
	end

	return buildingDict
end

function RoomLayoutHelper.createInfoByObInfo(obInfo)
	local info = {
		infos = {},
		buildingInfos = {}
	}

	tabletool.addValues(info.infos, obInfo.infos)
	tabletool.addValues(info.buildingInfos, obInfo.buildingInfos)

	local totalDegree, blockCount = RoomLayoutHelper.sunDegreeInfos(info.infos, info.buildingInfos)

	info.buildingDegree = totalDegree
	info.blockCount = blockCount
	info.changeColorCount = obInfo.changeColorCount

	return info
end

function RoomLayoutHelper.sunDegreeInfos(blockInfos, buildingInfos)
	local totalDegree = RoomBlockEnum.InitBlockDegreeValue
	local blockCount = 0
	local tRoomConfig = RoomConfig.instance

	if blockInfos then
		for i, blockInfo in ipairs(blockInfos) do
			if not tRoomConfig:getInitBlock(blockInfo.blockId) then
				blockCount = blockCount + 1

				local packageCfg = tRoomConfig:getPackageConfigByBlockId(blockInfo.blockId)

				if packageCfg then
					totalDegree = totalDegree + packageCfg.blockBuildDegree
				end
			end
		end
	end

	if buildingInfos then
		for i, buildingInfo in ipairs(buildingInfos) do
			local buildingCfg = tRoomConfig:getBuildingConfig(buildingInfo.defineId)

			if buildingCfg then
				totalDegree = totalDegree + buildingCfg.buildDegree
			end
		end
	end

	return totalDegree, blockCount
end

function RoomLayoutHelper.comparePlanInfo(planInfo, isGetName)
	local packageDict, roleBirthdayList = RoomLayoutHelper.findBlockInfos(planInfo.infos)
	local buildingDict = RoomLayoutHelper.findbuildingInfos(planInfo.buildingInfos)
	local strList

	if isGetName ~= false then
		strList = {}
	end
end

function RoomLayoutHelper._checkNeedNum(itemType, itemId, needNum, strList)
	if needNum < 1 then
		return 0
	end

	local tItemModel = ItemModel.instance
	local num = tItemModel:getItemQuantity(itemType, itemId) or 0

	num = math.max(num, 0)

	if num < needNum then
		if strList then
			local cfg = tItemModel:getItemConfig(itemType, itemId)

			if cfg then
				table.insert(strList, cfg.name)
			else
				table.insert(strList, itemType .. ":" .. itemId)
			end
		end

		return needNum - num
	end

	return 0
end

function RoomLayoutHelper.connStrList(strList, connchar, lastConnchar, maxCount)
	local desStr
	local count = #strList

	maxCount = maxCount or count

	for i, str in ipairs(strList) do
		if i == 1 then
			desStr = str
		elseif i == count and i > 1 then
			desStr = desStr .. lastConnchar .. str
		elseif maxCount < i then
			desStr = desStr .. "..."

			break
		else
			desStr = desStr .. connchar .. str
		end
	end

	return desStr
end

function RoomLayoutHelper.checkVisitParamCoppare(visitParam)
	if visitParam and visitParam.isCompareInfo == true then
		return true
	end

	return false
end

function RoomLayoutHelper.findHasBlockBuildingInfos(pInfos, pBuildingInfos)
	local blockInfos, removeBlockInfos = RoomLayoutHelper.findHasBlockInfos(pInfos)
	local buildingInfos = RoomLayoutHelper.findHasBuildingInfos(pBuildingInfos, removeBlockInfos)

	return blockInfos, buildingInfos
end

function RoomLayoutHelper.findHasBlockInfos(pInfos)
	local infos = {}
	local removeInfos = {}

	if not pInfos then
		return infos, removeInfos
	end

	for i, info in ipairs(pInfos) do
		if RoomLayoutHelper.isHasBlockById(info.blockId) then
			table.insert(infos, info)
		else
			table.insert(removeInfos, info)
		end
	end

	return infos, removeInfos
end

function RoomLayoutHelper.findHasBuildingInfos(pBuildingInfos, removeBlockInfos)
	local bInfos = {}
	local removeInfos = {}

	if not pBuildingInfos then
		return bInfos, removeInfos
	end

	local countDic = {}

	for i, buildInfo in ipairs(pBuildingInfos) do
		local buildId = buildInfo.defineId

		if not countDic[buildId] then
			if countDic[buildId] < RoomModel.instance:getBuildingCount(buildId) and not RoomLayoutHelper._isInRemoveBlock(buildInfo, removeBlockInfos) then
				countDic[buildId] = countDic[buildId] + 1

				table.insert(bInfos, buildInfo)
			else
				table.insert(removeInfos, buildInfo)
			end
		end
	end

	return bInfos, removeInfos
end

function RoomLayoutHelper._isInRemoveBlock(buildInfo, removeBlockInfos)
	if not removeBlockInfos or #removeBlockInfos < 1 then
		return false
	end

	local hexPoint = HexPoint(buildInfo.x, buildInfo.y)
	local dict = RoomBuildingHelper.getOccupyDict(buildInfo.defineId, hexPoint, buildInfo.rotate, buildInfo.uid)

	for i, info in ipairs(removeBlockInfos) do
		if dict[info.x] and dict[info.x][info.y] then
			return true
		end
	end

	return false
end

function RoomLayoutHelper.isHasBlockById(blockId)
	local tRoomConfig = RoomConfig.instance

	if tRoomConfig:getInitBlock(blockId) then
		return true
	end

	local blockCfg = tRoomConfig:getBlock(blockId)

	if blockCfg then
		if (RoomBlockPackageEnum.ID.RoleBirthday == blockCfg.packageId and RoomLayoutHelper._checkNeedNum(MaterialEnum.MaterialType.SpecialBlock, blockId, 1) or RoomLayoutHelper._checkNeedNum(MaterialEnum.MaterialType.BlockPackage, blockCfg.packageId, 1)) == 0 then
			return true
		end
	end

	return false
end

return RoomLayoutHelper
