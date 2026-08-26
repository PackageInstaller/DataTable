-- chunkname: @modules/logic/rouge/controller/RougeCollectionHelper.lua

module("modules.logic.rouge.controller.RougeCollectionHelper", package.seeall)

local RougeCollectionHelper = _M
local CollectionSlotCenterPosition = Vector2.New(0, 0)

RougeCollectionHelper.CollectionSlotCellSize = Vector2.New(98, 98)

function RougeCollectionHelper.anchorPos2SlotPos(anchorPos)
	if not anchorPos then
		logError("anchorPos is nil")

		return CollectionSlotCenterPosition.x, CollectionSlotCenterPosition.y
	end

	local offset = Vector2(anchorPos.x - CollectionSlotCenterPosition.x, -anchorPos.y - CollectionSlotCenterPosition.y)
	local slotPosX = math.floor(offset.x / RougeCollectionHelper.CollectionSlotCellSize.x + 0.5)
	local slotPosY = math.floor(offset.y / RougeCollectionHelper.CollectionSlotCellSize.y + 0.5)

	return slotPosX, slotPosY
end

function RougeCollectionHelper.slotPos2AnchorPos(slotPos, cellSizeX, cellSizeY)
	if not slotPos then
		return Vector2.zero
	end

	cellSizeX = cellSizeX or RougeCollectionHelper.CollectionSlotCellSize.x
	cellSizeY = cellSizeY or RougeCollectionHelper.CollectionSlotCellSize.y

	local anchorPosX = slotPos.x * cellSizeX + CollectionSlotCenterPosition.x
	local anchorPosY = -slotPos.y * cellSizeY + CollectionSlotCenterPosition.y

	return anchorPosX, anchorPosY
end

function RougeCollectionHelper.getCollectionPlacePosition(leftTopPos, cellSizeX, cellSizeY)
	local centerPos = Vector2(leftTopPos.x - 0.5, leftTopPos.y - 0.5)
	local centerAnchorPosX, centerAnchorPosY = RougeCollectionHelper.slotPos2AnchorPos(centerPos, cellSizeX, cellSizeY)

	return centerAnchorPosX, centerAnchorPosY
end

function RougeCollectionHelper.getSlotCellSize()
	return RougeCollectionHelper.CollectionSlotCellSize
end

function RougeCollectionHelper.getSlotCellInsideLine(shapeCfgMap, slotCellPos, isRevertTop)
	if not shapeCfgMap then
		return
	end

	local topPos = slotCellPos + Vector2(0, 1)
	local bottomPos = slotCellPos - Vector2(0, 1)
	local leftPos = slotCellPos - Vector2(1, 0)
	local rightPos = slotCellPos + Vector2(1, 0)

	if isRevertTop then
		topPos = bottomPos
		bottomPos = topPos
	end

	local result = {}

	if shapeCfgMap[topPos.x] and shapeCfgMap[topPos.x][topPos.y] then
		table.insert(result, RougeEnum.SlotCellDirection.Top)
	end

	if shapeCfgMap[bottomPos.x] and shapeCfgMap[bottomPos.x][bottomPos.y] then
		table.insert(result, RougeEnum.SlotCellDirection.Bottom)
	end

	if shapeCfgMap[leftPos.x] and shapeCfgMap[leftPos.x][leftPos.y] then
		table.insert(result, RougeEnum.SlotCellDirection.Left)
	end

	if shapeCfgMap[rightPos.x] and shapeCfgMap[rightPos.x][rightPos.y] then
		table.insert(result, RougeEnum.SlotCellDirection.Right)
	end

	return result
end

function RougeCollectionHelper.getCollectionTopLeftSlotPos(collectionCfgId, centerSlotPos, rotation)
	local leftTopOffset = RougeCollectionHelper.getCollectionTopLeftPos(collectionCfgId, rotation)

	return Vector2(centerSlotPos.x + leftTopOffset.x, centerSlotPos.y - leftTopOffset.y)
end

function RougeCollectionHelper.getCollectionCenterSlotPos(collectionCfgId, rotation, topLeftPos)
	local leftTopOffset = RougeCollectionHelper.getCollectionTopLeftPos(collectionCfgId, rotation)

	if not leftTopOffset then
		return topLeftPos
	end

	local centerSlotPosY = topLeftPos.y + leftTopOffset.y
	local centerSlotPosX = topLeftPos.x - leftTopOffset.x

	return Vector2(centerSlotPosX, centerSlotPosY)
end

function RougeCollectionHelper.getCollectionTopLeftPos(collectionCfgId, rotation)
	local shapeCfgs = RougeCollectionConfig.instance:getRotateEditorParam(collectionCfgId, rotation, RougeEnum.CollectionEditorParamType.Shape)
	local minSlotPosX, minSlotPosY = 1000, 1000
	local maxSlotPosX, maxSlotPosY = -1000, -1000

	if shapeCfgs then
		for _, cell in pairs(shapeCfgs) do
			if minSlotPosX > cell.x then
				minSlotPosX = cell.x
			end

			if minSlotPosY > cell.y then
				minSlotPosY = cell.x
			end

			if maxSlotPosX < cell.y then
				maxSlotPosX = cell.x
			end

			if maxSlotPosY < cell.y then
				maxSlotPosY = cell.y
			end
		end
	end

	return Vector2(minSlotPosX, maxSlotPosY)
end

function RougeCollectionHelper.getRotateAngleByRotation(rotation)
	rotation = rotation or 0
	rotation = Mathf.Clamp(rotation, 0, 3)

	return rotation * -90
end

function RougeCollectionHelper.getCollectionIconUrl(collectionCfgId)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if collectionCfg then
		return ResUrl.getRougeIcon("collection/" .. collectionCfg.iconPath)
	end
end

function RougeCollectionHelper.getCollectionSizeAfterRotation(collectionCfgId, rotation)
	local width, height = RougeCollectionConfig.instance:getShapeSize(collectionCfgId)

	rotation = rotation or 0

	if rotation % 2 == 0 then
		return width, height
	else
		return height, width
	end
end

function RougeCollectionHelper.loadShapeGrid(collectionId, gridContainer, gridItem, gridList, scallWithSize)
	gohelper.setActive(gridItem, false)

	local matrix = RougeCollectionConfig.instance:getShapeMatrix(collectionId)
	local width, height = RougeCollectionConfig.instance:getShapeSize(collectionId)

	if scallWithSize == nil or scallWithSize == true then
		local scale = RougeCollectionHelper.getCollectionBgScaleSize(width, height)

		transformhelper.setLocalScale(gridContainer.transform, scale, scale, 1)
	end

	local gridLayout = gohelper.onceAddComponent(gridContainer, gohelper.Type_GridLayoutGroup)

	gridLayout.constraintCount = width

	local index = 0

	for i = 1, height do
		for j = 1, width do
			index = index + 1

			local grid

			if gridList then
				grid = gridList[index]

				if not gridList[index] then
					grid = gohelper.cloneInPlace(gridItem)

					table.insert(gridList, grid)
				end
			else
				grid = gohelper.cloneInPlace(gridItem)
			end

			gohelper.setActive(grid, true)

			local image = grid:GetComponent(gohelper.Type_Image)
			local isImageEnabled = tonumber(matrix[i][j]) == 1

			image.enabled = isImageEnabled

			if isImageEnabled then
				local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionId)
				local showRare = collectionCfg and collectionCfg.showRare

				UISpriteSetMgr.instance:setRougeSprite(image, "rouge_collection_grid_big_" .. tostring(showRare))
			end
		end
	end

	if gridList then
		for i = index + 1, #gridList do
			gohelper.setActive(gridList[i], false)
		end
	end
end

function RougeCollectionHelper.getCollectionBgScaleSize(width, height)
	if width == 0 or height == 0 then
		logError("get collection size zero, please check")

		return 0
	end

	if height < width then
		return RougeEnum.CollectionBgMaxSize / width
	end

	return RougeEnum.CollectionBgMaxSize / height
end

function RougeCollectionHelper.loadTags(collectionId, goTagItem, goList)
	local tagList = RougeCollectionConfig.instance:getCollectionTags(collectionId)

	for index, tag in ipairs(tagList) do
		local go

		if goList then
			go = goList[index]

			if not goList[index] then
				go = gohelper.cloneInPlace(goTagItem)

				table.insert(goList, go)
			end
		else
			go = gohelper.cloneInPlace(goTagItem)
		end

		local tagCo = RougeCollectionConfig.instance:getCollectioTagCo(tag)

		gohelper.setActive(go, true)

		local image = gohelper.findChildImage(go, "image_tagicon")

		UISpriteSetMgr.instance:setRougeSprite(image, tagCo and tagCo.iconUrl)
	end

	for i = #tagList + 1, #goList do
		gohelper.setActive(goList[i], false)
	end
end

function RougeCollectionHelper.loadCollectionAndEnchantTagsById(collectionId, goTagParent, goTagItem)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		return
	end

	local collectionCfgId = collectionMO.cfgId
	local enchantCfgIds = collectionMO:getAllEnchantCfgId()

	RougeCollectionHelper.loadCollectionAndEnchantTags(collectionCfgId, enchantCfgIds, goTagParent, goTagItem)
end

function RougeCollectionHelper.loadCollectionAndEnchantTags(collectionCfgId, enchantCfgIds, goTagParent, goTagItem)
	local collectionTags, enchantTags = RougeCollectionHelper.getCollectionAndEnchantTagIds(collectionCfgId, enchantCfgIds)

	if collectionTags then
		if not #collectionTags then
			local collectionTagCount = 0

			collectionTags = collectionTags or {}

			tabletool.addValues(collectionTags, enchantTags)
			gohelper.CreateObjList(nil, RougeCollectionHelper._loadCollectionTagCallBack, collectionTags, goTagParent, goTagItem, nil, 1, collectionTagCount)
			gohelper.CreateObjList(nil, RougeCollectionHelper._loadEnchantTagCallBack, collectionTags, goTagParent, goTagItem, nil, collectionTagCount + 1)
		end
	end
end

function RougeCollectionHelper.loadCollectionTags(collectionCfgId, goTagParent, goTagItem)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if not collectionCfg then
		return
	end

	if not collectionCfg.tags then
		local tags = {}

		gohelper.CreateObjList(nil, RougeCollectionHelper._loadCollectionTagCallBack, tags, goTagParent, goTagItem)
	end
end

function RougeCollectionHelper._loadCollectionTagCallBack(callBackObj, tagObj, tagId, index)
	RougeCollectionHelper._loadCollectionIconFunc(tagObj, tagId, index)

	local frameImg = gohelper.findChildImage(tagObj, "image_tagframe")

	UISpriteSetMgr.instance:setRougeSprite(frameImg, "rouge_collection_tagframe_1")
end

function RougeCollectionHelper._loadEnchantTagCallBack(callbackObj, tagObj, tagId, index)
	RougeCollectionHelper._loadCollectionIconFunc(tagObj, tagId, index)

	local frameImg = gohelper.findChildImage(tagObj, "image_tagframe")

	UISpriteSetMgr.instance:setRougeSprite(frameImg, "rouge_collection_tagframe_2")
end

function RougeCollectionHelper._loadCollectionIconFunc(tagObj, tagId, index)
	local tagImg = gohelper.findChildImage(tagObj, "image_tagicon")
	local tagCo = RougeCollectionConfig.instance:getCollectioTagCo(tagId)

	UISpriteSetMgr.instance:setRougeSprite(tagImg, tagCo and tagCo.iconUrl)
end

function RougeCollectionHelper.getCollectionAndEnchantTagIds(collectionCfgId, enchantCfgIds)
	local collectionTagIds = {}
	local enchantTagIds = {}
	local tagMap = {}
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)
	local collectiontags = collectionCfg and collectionCfg.tags

	RougeCollectionHelper._getFilterCollectionTags(collectiontags, collectionTagIds, tagMap)

	if enchantCfgIds then
		for _, cfgId in ipairs(enchantCfgIds) do
			if cfgId > 0 then
				local enchantCfg = RougeCollectionConfig.instance:getCollectionCfg(cfgId)
				local tags = enchantCfg and enchantCfg.tags

				RougeCollectionHelper._getFilterCollectionTags(tags, enchantTagIds, tagMap, true)
			end
		end
	end

	return collectionTagIds, enchantTagIds
end

function RougeCollectionHelper._getFilterCollectionTags(tags, list, filterMap, isFilterTypeTag)
	if not tags then
		return
	end

	list = list or {}
	filterMap = filterMap or {}

	for _, tagId in ipairs(tags) do
		local isSatisfy = RougeCollectionHelper._isCollectionTagSatisfy(tagId, filterMap, isFilterTypeTag)

		if isSatisfy then
			table.insert(list, tagId)

			filterMap[tagId] = true
		end
	end
end

function RougeCollectionHelper._isCollectionTagSatisfy(tagId, filterMap, isFilterTypeTag)
	if not tagId or filterMap[tagId] then
		return false
	end

	if isFilterTypeTag then
		return tagId < RougeEnum.MinCollectionExtraTagID
	end

	return true
end

function RougeCollectionHelper.loadCollectionAndEnchantTagNames(collectionCfgId, enchantCfgIds, goTagParent, goTagItem, overrideCb, overrideCbObj)
	local collectionTags, enchantTags = RougeCollectionHelper.getCollectionAndEnchantTagIds(collectionCfgId, enchantCfgIds)

	collectionTags = collectionTags or {}

	tabletool.addValues(collectionTags, enchantTags)

	overrideCb = overrideCb or RougeCollectionHelper._loadCollectionTagNameWithIconCallBack
	overrideCbObj = overrideCbObj or RougeCollectionHelper

	gohelper.CreateObjList(overrideCbObj, overrideCb, collectionTags, goTagParent, goTagItem)
end

function RougeCollectionHelper:_loadCollectionTagNameWithIconCallBack(tagObj, tagId, index)
	local tagImg = gohelper.findChildImage(tagObj, "image_tagicon")
	local tagCo = RougeCollectionConfig.instance:getCollectioTagCo(tagId)

	UISpriteSetMgr.instance:setRougeSprite(tagImg, tagCo and tagCo.iconUrl)

	local tagTxt = tagObj:GetComponent(gohelper.Type_TextMesh)

	tagTxt.text = tagCo and tagCo.name
end

function RougeCollectionHelper:_loadCollectionTagNameCallBack(tagObj, tagId, index)
	local tagCo = RougeCollectionConfig.instance:getCollectioTagCo(tagId)
	local tagTxt = tagObj:GetComponent(gohelper.Type_TextMesh)

	tagTxt.text = tagCo and tagCo.name
end

function RougeCollectionHelper.computeAndSetCollectionIconScale(collectionCfgId, iconTran, cellWidth, cellHeight)
	local width, height = RougeCollectionConfig.instance:getShapeSize(collectionCfgId)
	local scaleEdgeValue = width * cellWidth

	if width < height then
		scaleEdgeValue = height * cellHeight
	end

	recthelper.setSize(iconTran, scaleEdgeValue, scaleEdgeValue)
end

function RougeCollectionHelper.checkCollectionHasAnyOneTag(collectionCfgId, enchantCfgId, baseTag, extraTag)
	if GameUtil.tabletool_dictIsEmpty(baseTag) and GameUtil.tabletool_dictIsEmpty(extraTag) then
		return true
	end

	local collectionTags, enchantTags = RougeCollectionHelper.getCollectionAndEnchantTagIds(collectionCfgId, enchantCfgId)
	local totalTags = {}

	tabletool.addValues(totalTags, collectionTags)
	tabletool.addValues(totalTags, enchantTags)

	local isNeedCheckBaseTag = baseTag and tabletool.len(baseTag) > 0
	local isNeedCheckExtraTag = extraTag and tabletool.len(extraTag) > 0
	local isFitBaseTag = not isNeedCheckBaseTag

	if totalTags then
		for _, tag in ipairs(totalTags) do
			if isNeedCheckBaseTag and baseTag[tag] then
				isFitBaseTag = true
			end

			if isFitBaseTag and (isNeedCheckExtraTag and extraTag[tag] or nil) and true then
				return true
			end
		end
	end
end

function RougeCollectionHelper.checkCollectionHasAnyOneTag1(collectionId, checkTagMap)
	if GameUtil.tabletool_dictIsEmpty(checkTagMap) then
		return true
	end

	local tags = RougeCollectionConfig.instance:getCollectionTags(collectionId)

	if tags then
		for _, tag in ipairs(tags) do
			if checkTagMap[tag] then
				return true
			end
		end
	end
end

function RougeCollectionHelper.removeInValidItem(map)
	if GameUtil.tabletool_dictIsEmpty(map) then
		return
	end

	for k, v in pairs(map) do
		map[k] = map[k] or nil
	end
end

function RougeCollectionHelper.buildCollectionSlotMOs(serverMsg)
	if not serverMsg then
		return
	end

	local moList = {}

	for _, info in ipairs(serverMsg) do
		local mo = RougeCollectionHelper.buildNewCollectionSlotMO(info)

		table.insert(moList, mo)
	end

	return moList
end

function RougeCollectionHelper.buildNewCollectionSlotMO(info)
	local collectionMO = RougeCollectionSlotMO.New()

	collectionMO:init(info)

	return collectionMO
end

function RougeCollectionHelper.buildNewBagCollectionMO(info)
	local collectionMO = RougeCollectionMO.New()

	collectionMO:init(info)

	return collectionMO
end

function RougeCollectionHelper.isCollectionShapeAsSquare(collectionCfgId)
	local width, height = RougeCollectionConfig.instance:getShapeSize(collectionCfgId)

	if width ~= height then
		return false
	end

	local shapeSizeCellCount = width * height
	local shapeCfg = RougeCollectionConfig.instance:getOriginEditorParam(collectionCfgId, RougeEnum.CollectionEditorParamType.Shape)

	if shapeCfg then
		if not #shapeCfg then
			local realCellCount = 0

			return shapeSizeCellCount == realCellCount
		end
	end
end

function RougeCollectionHelper.getCollectionCellSlotPos(centerPos, offset)
	return (Vector2(offset.x + centerPos.x, centerPos.y - offset.y))
end

function RougeCollectionHelper.isNewGetCollection(reason)
	return reason == RougeEnum.CollectionReason.Product or reason == RougeEnum.CollectionReason.Composite
end

local oneCellCollectionDragPos = Vector2(1, 1)

function RougeCollectionHelper.getCollectionDragPos(collectionCfgId, rotation)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if not collectionCfg then
		return
	end

	local shapeMatrix = RougeCollectionConfig.instance:getShapeMatrix(collectionCfgId, rotation)
	local rowCount = tabletool.len(shapeMatrix)
	local bottomRow = shapeMatrix[rowCount]

	if rowCount <= 1 and #bottomRow <= 1 then
		return oneCellCollectionDragPos.x, oneCellCollectionDragPos.y
	end

	if bottomRow then
		for col, value in ipairs(bottomRow) do
			if value and value > 0 then
				return col, rowCount
			end
		end
	end
end

function RougeCollectionHelper.checkIsCollectionSlotArea(collectionCfgId, leftTopPos, rotation, checkout)
	if not collectionCfgId or not leftTopPos or not rotation then
		return
	end

	local rotationMatrix = RougeCollectionConfig.instance:getShapeMatrix(collectionCfgId, rotation)

	if rotationMatrix then
		for rowIndex, cols in ipairs(rotationMatrix) do
			for colIndex, value in ipairs(cols) do
				if value and value > 0 then
					local col = leftTopPos.x + colIndex - 1
					local row = leftTopPos.y + rowIndex - 1
					local isInSlotArea = RougeCollectionHelper.isSlotPosInSlotArea(row, col)

					if checkout and not isInSlotArea then
						return true
					elseif not checkout and isInSlotArea then
						return true
					end
				end
			end
		end
	end
end

function RougeCollectionHelper.isSlotPosInSlotArea(row, col)
	local slotAreaSize = RougeCollectionModel.instance:getCurSlotAreaSize()

	if not slotAreaSize.row then
		local slotRowCount = 0

		if not slotAreaSize.col then
			local slotColCount = 0

			if slotAreaSize then
				return row >= 0 and row < slotRowCount and col >= 0 and col < slotColCount
			end
		end
	end
end

RougeCollectionHelper.DefaultSlotParam = RougeCollectionSlotCompParam.New()
RougeCollectionHelper.StyleShowCollectionSlotParam = RougeCollectionSlotCompParam.New()
RougeCollectionHelper.StyleShowCollectionSlotParam.cellLineNameMap = {
	[RougeEnum.LineState.Grey] = "rouge_bagline_yellow",
	[RougeEnum.LineState.Green] = "rouge_bagline_yellow_light"
}
RougeCollectionHelper.StyleCollectionSlotParam = RougeCollectionSlotCompParam.New()
RougeCollectionHelper.StyleCollectionSlotParam.cellLineNameMap = {
	[RougeEnum.LineState.Grey] = "rouge_bagline_black",
	[RougeEnum.LineState.Green] = "rouge_bagline_grey"
}
RougeCollectionHelper.ResultReViewCollectionSlotParam = RougeCollectionSlotCompParam.New()
RougeCollectionHelper.ResultReViewCollectionSlotParam.cellWidth = RougeCollectionHelper.CollectionSlotCellSize.x
RougeCollectionHelper.ResultReViewCollectionSlotParam.cellHeight = RougeCollectionHelper.CollectionSlotCellSize.y
RougeCollectionHelper.ResultReViewCollectionSlotParam.cellLineNameMap = {
	[RougeEnum.LineState.Grey] = "rouge_collection_gridline_grey",
	[RougeEnum.LineState.Green] = "rouge_collection_gridline_green",
	[RougeEnum.LineState.Red] = "rouge_collection_gridline_red",
	[RougeEnum.LineState.Blue] = "rouge_collection_gridline_blue"
}
RougeCollectionHelper.ResultReViewCollectionSlotParam.showIcon = true

function RougeCollectionHelper.foreachCollectionCells(collectionMO, callBack, callBackObj, ...)
	if not collectionMO then
		return
	end

	local collectionCfgId = collectionMO.cfgId
	local rotation = collectionMO:getRotation()
	local shapeMatrix = RougeCollectionConfig.instance:getShapeMatrix(collectionCfgId, rotation)

	if shapeMatrix then
		for row, rows in ipairs(shapeMatrix) do
			for col, exist in ipairs(rows) do
				if exist and exist > 0 then
					callBack(callBackObj, collectionMO, row, col, ...)
				end
			end
		end
	end
end

function RougeCollectionHelper.getTwoCollectionConnectCell(originCollection, targetCollection)
	if not originCollection or not targetCollection then
		return
	end

	local result = {}

	RougeCollectionHelper.foreachCollectionCells(originCollection, RougeCollectionHelper._checkIsTwoCollectionCellNear, nil, targetCollection, result)

	if result and #result > 0 then
		return result[1], result[2]
	end
end

function RougeCollectionHelper:_checkIsTwoCollectionCellNear(collectionMO, row, col, targetCollection, result)
	if (not collectionMO or not targetCollection) and result then
		return
	end

	local originLeftTopPos = collectionMO:getLeftTopPos()
	local cellPosX = originLeftTopPos.x + col - 1
	local cellPosY = originLeftTopPos.y + row - 1
	local leftNear = RougeCollectionHelper._checkIsCellNearCollection(cellPosX - 1, cellPosY, targetCollection)
	local rightNear = RougeCollectionHelper._checkIsCellNearCollection(cellPosX + 1, cellPosY, targetCollection)
	local bottomNear = RougeCollectionHelper._checkIsCellNearCollection(cellPosX, cellPosY - 1, targetCollection)
	local topNear = RougeCollectionHelper._checkIsCellNearCollection(cellPosX, cellPosY + 1, targetCollection)
	local isMatch = leftNear or rightNear or bottomNear or topNear

	if isMatch then
		table.insert(result, Vector2(cellPosX, cellPosY))

		if leftNear then
			table.insert(result, Vector2(cellPosX - 1, cellPosY))
		elseif rightNear then
			table.insert(result, Vector2(cellPosX + 1, cellPosY))
		elseif bottomNear then
			table.insert(result, Vector2(cellPosX, cellPosY - 1))
		else
			table.insert(result, Vector2(cellPosX, cellPosY + 1))
		end
	end
end

function RougeCollectionHelper._checkIsCellNearCollection(cellPosX, cellPosY, targetCollection)
	if not targetCollection then
		return
	end

	local targetLeftTopPos = targetCollection:getLeftTopPos()
	local cellInTargetMatrixRow = cellPosY - targetLeftTopPos.y + 1
	local targetMatrix = RougeCollectionConfig.instance:getShapeMatrix(targetCollection.cfgId, targetCollection:getRotation())
	local isCellInTargetMatrix = false

	if targetMatrix then
		if targetMatrix[cellInTargetMatrixRow] then
			isCellInTargetMatrix = targetMatrix[cellInTargetMatrixRow] and targetMatrix[cellInTargetMatrixRow] > 0
		end
	end

	return isCellInTargetMatrix
end

function RougeCollectionHelper.isCanDragCollection()
	return UnityEngine.Input.touchCount <= 1
end

function RougeCollectionHelper.isUniqueCollection(collectionId)
	local co = RougeCollectionConfig.instance:getCollectionCfg(collectionId)

	return co and co.isUnique
end

function RougeCollectionHelper.isUnremovableCollection(collectionCfgId)
	local co = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	return co and co.unremovable
end

function RougeCollectionHelper.getNotUniqueCollectionNum()
	local collectionMoList = RougeCollectionModel.instance:getAllCollections()
	local num = 0

	for _, collectionMo in ipairs(collectionMoList) do
		if not RougeCollectionHelper.isUniqueCollection(collectionMo.cfgId) then
			num = num + 1
		end
	end

	return num
end

return RougeCollectionHelper
