-- chunkname: @modules/logic/udimo/controller/UdimoHelper.lua

module("modules.logic.udimo.controller.UdimoHelper", package.seeall)

local UdimoHelper = _M

function UdimoHelper.isCanEnterUdimoLockMode()
	local isOpenFunc = UdimoModel.instance:isOpenUdimoFunc()

	if not isOpenFunc then
		return
	end

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if not UdimoEnum.WaitEnterUdimoLockModeSceneType[curSceneType] then
		return
	end

	local forceGuideId = GuideModel.instance:lastForceGuideId()
	local isFinishForceGuide = GuideModel.instance:isGuideFinish(forceGuideId)
	local isGuiding = GuideController.instance:isGuiding()
	local doingClickGuide = GuideModel.instance:isDoingClickGuide()
	local isForbidGuide = GuideController.instance:isForbidGuides()

	if (isGuiding or doingClickGuide or not isFinishForceGuide) and not isForbidGuide then
		return
	end

	local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()

	if pickedUpUdimo then
		return
	end

	local settingId = UdimoModel.instance:getUdimoSettingId()
	local waitTime = UdimoConfig.instance:getSettingWaitTime(settingId)

	if not waitTime or waitTime <= 0 then
		return
	end

	local ExcludeViewList = {
		ViewName.LoadingView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.SummonView,
		ViewName.SummonADView,
		ViewName.StoryView
	}

	for _, viewName in ipairs(ExcludeViewList) do
		local isOpenView = ViewMgr.instance:isOpen(viewName)

		if isOpenView then
			return
		end
	end

	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if not UdimoEnum.WaitEnterUdimoLockModeView[topView] then
		return
	end

	return true
end

function UdimoHelper.hasUnlockItem(itemId)
	local result = false
	local itemCfg = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, itemId)
	local subType = itemCfg and itemCfg.subType

	if UdimoEnum.UdimoItemSubType[subType] then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, itemId)

		result = quantity > 0
	end

	return result
end

function UdimoHelper._getRaycastTrans(screenPos)
	local scene = UdimoController.instance:getUdimoScene()

	if not screenPos or not scene then
		return
	end

	local camera = CameraMgr.instance:getMainCamera()
	local ray = camera:ScreenPointToRay(screenPos)
	local hitInfo = UnityEngine.Physics2D.GetRayIntersection(ray, Mathf.Infinity, LayerMask.GetMask("Unit"))

	return hitInfo and hitInfo.transform
end

function UdimoHelper.getRaycastUdimo(screenPos)
	local transform = UdimoHelper._getRaycastTrans(screenPos)

	if not transform then
		return
	end

	local scene = UdimoController.instance:getUdimoScene()

	if not scene then
		return
	end

	local udimoEntityDict = scene.udimomgr:getUdimoEntityDict()

	for udimoId, entity in pairs(udimoEntityDict) do
		if transform:IsChildOf(entity.trans) then
			return udimoId, entity
		end
	end
end

function UdimoHelper.getRaycastDecorationEntity(screenPos)
	local transform = UdimoHelper._getRaycastTrans(screenPos)

	if not transform then
		return
	end

	local scene = UdimoController.instance:getUdimoScene()

	if not scene then
		return
	end

	local siteEntityDict = scene.decoration:getSiteEntityDict()

	for _, entity in pairs(siteEntityDict) do
		if transform:IsChildOf(entity.trans) then
			return entity
		end
	end
end

function UdimoHelper.changeScreenPos2UdimoWroldPos(screenPos, udimoEntity)
	local zLevel = udimoEntity:getZLevel()

	return (recthelper.screenPosToWorldPos(screenPos, nil, {
		x = 0,
		y = 0,
		z = zLevel
	}))
end

function UdimoHelper.getUdimoZLevel(targetUdimoId)
	local result
	local useBg = UdimoItemModel.instance:getUseBg()
	local udimoType = UdimoConfig.instance:getUdimoType(targetUdimoId)
	local zLevelList = UdimoConfig.instance:getBgAreaZLevelList(useBg, udimoType)
	local scene = UdimoController.instance:getUdimoScene()

	if zLevelList and scene then
		local curZLevelCountDict = {}
		local udimoEntityList = scene.udimomgr:getTypeUdimoList(udimoType)

		for _, entity in ipairs(udimoEntityList) do
			local zLevel = entity:getZLevel()

			curZLevelCountDict[zLevel] = (curZLevelCountDict[zLevel] or 0) + 1
		end

		local randomZLevelList = {}
		local maxShowingCount = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.MaxShowUdimoCount, true)
		local allUdimoTypeCount = UdimoConfig.instance:getUdimoTypeCount(udimoType)
		local canShowCount = math.min(maxShowingCount, allUdimoTypeCount)
		local hasZLevelCount = #zLevelList
		local perLevelCount = math.ceil(canShowCount / hasZLevelCount)

		for _, zLevel in pairs(zLevelList) do
			if not curZLevelCountDict[zLevel] then
				if curZLevelCountDict[zLevel] < perLevelCount then
					randomZLevelList[#randomZLevelList + 1] = zLevel
				end
			end
		end

		local randomZLevelCount = #randomZLevelList

		if randomZLevelCount > 0 then
			local index = math.random(1, randomZLevelCount)

			result = randomZLevelList[index]
		else
			result = zLevelList[1]

			logWarn("UdimoHelper.getUdimoZLevel warn, zLevel not enough, maxShow:%s, zLevelCount:%s, perLevelCount:%s", canShowCount, hasZLevelCount, perLevelCount)
		end
	end

	return result or 0
end

function UdimoHelper.getUdimoYLevel(targetUdimoId, newArea)
	local result
	local useBg = UdimoItemModel.instance:getUseBg()

	if not newArea then
		::label_8_0::

		local udimoType = UdimoConfig.instance:getUdimoType(targetUdimoId)
		local yLevelList = UdimoConfig.instance:getBgAreaYLevelList(useBg, udimoType)

		if yLevelList then
			if udimoType == UdimoEnum.UdimoType.Air then
				if not yLevelList[1] then
					local minY = 0

					if not yLevelList[2] then
						local maxY = 0

						result = math.random(minY * 100, maxY * 100) / 100
					end
				end
			else
				result = yLevelList[(#yLevelList > 1 or nil) and math.random(1, #yLevelList)]
			end
		end

		return result or 0
	end
end

function UdimoHelper.getUdimoXRange(targetUdimoId)
	local leftX, rightX
	local useBg = UdimoItemModel.instance:getUseBg()
	local udimoType = UdimoConfig.instance:getUdimoType(targetUdimoId)
	local xRangeList = UdimoConfig.instance:getBgAreaXMoveRange(useBg, udimoType)

	if xRangeList then
		leftX = xRangeList[1]
		rightX = xRangeList[2]
	end

	return leftX or 0, rightX or 0
end

function UdimoHelper.getPlayerCacheDataKey(key, id)
	return string.format("%s_%s", key, id)
end

function UdimoHelper.getAirUdimoTargetX(udimoId, udimoPosX)
	local result = udimoPosX
	local leftX, rightX = UdimoHelper.getUdimoXRange(udimoId)

	if udimoPosX then
		local needX = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.AirNeedXValue, false, nil, true)
		local targetLeft = udimoPosX - needX
		local targetRight = udimoPosX + needX
		local canInLeft = leftX <= targetLeft
		local canInRight = targetRight <= rightX

		if canInLeft or canInRight then
			local isLeft = true

			if canInLeft and canInRight then
				isLeft = math.random(2) == 1
			elseif canInRight then
				isLeft = false
			end

			result = isLeft and targetLeft or targetRight
		end
	else
		result = math.random(leftX, rightX)
	end

	return result
end

function UdimoHelper.getUidmoCurMoveX(startX, startDir, speed, minLeftX, maxRightX, time)
	local moveDis = startDir * speed * time
	local absMoveDis = math.abs(moveDis)
	local disToBoundary = startDir > 0 and maxRightX - startX or startX - minLeftX
	local resultX, curDir

	if absMoveDis <= disToBoundary then
		resultX = startX + moveDis
		curDir = startDir
	else
		local bounceCount = 0
		local finalSegment = 0
		local remainDis = absMoveDis - disToBoundary
		local range = maxRightX - minLeftX

		if range ~= 0 then
			local cycleTimes = math.floor(remainDis / range)

			finalSegment = remainDis % range
			bounceCount = cycleTimes + 1
		end

		curDir = bounceCount % 2 == 1 and -startDir or startDir
		resultX = curDir > 0 and minLeftX + finalSegment or maxRightX - finalSegment
	end

	return resultX, curDir
end

return UdimoHelper
