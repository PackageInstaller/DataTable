-- chunkname: @modules/logic/rouge/map/controller/RougeMapHelper.lua

module("modules.logic.rouge.map.controller.RougeMapHelper", package.seeall)

local RougeMapHelper = class("RougeMapHelper")

function RougeMapHelper.blockEsc()
	return
end

RougeMapHelper.StandardRate = 1.7777777777777777

function RougeMapHelper.getMiddleLayerCameraSize()
	local w, h = UnityEngine.Screen.width, UnityEngine.Screen.height
	local rate = w / h
	local mapSize = RougeMapModel.instance:getMapSize()

	if rate >= RougeMapHelper.StandardRate then
		return mapSize.y / 2
	end

	local mapWidth = mapSize.y * RougeMapHelper.StandardRate
	local halfHeight = mapWidth / rate

	return halfHeight / 2
end

function RougeMapHelper.getNormalLayerCameraSize()
	local w, h = UnityEngine.Screen.width, UnityEngine.Screen.height
	local rate = w / h
	local mapSize = RougeMapModel.instance:getMapSize()
	local halfHeight = mapSize.y / 2

	if rate >= RougeMapHelper.StandardRate then
		return halfHeight
	end

	local scaleRate = h * RougeMapHelper.StandardRate / w

	return halfHeight * scaleRate
end

function RougeMapHelper.getUIRoot()
	local w, h = UnityEngine.Screen.width, UnityEngine.Screen.height
	local rate = w / h

	if rate >= RougeMapHelper.StandardRate then
		return ViewMgr.instance:getUIRoot()
	end

	return ViewMgr.instance:getUILayer(UILayerName.PopUpTop)
end

function RougeMapHelper.getScenePos(camera, mousePos, offsetZ)
	mousePos.z = offsetZ

	local pos = camera:ScreenToWorldPoint(mousePos)

	pos.x = RougeMapHelper.retain2decimals(pos.x)
	pos.y = RougeMapHelper.retain2decimals(pos.y)
	pos.z = RougeMapHelper.retain2decimals(pos.z)

	return pos
end

function RougeMapHelper.retain2decimals(num)
	return num - num % 0.01
end

function RougeMapHelper.getEpisodePosX(index)
	local interval = (index - 1) * RougeMapModel.instance:getMapEpisodeIntervalX()
	local startOffsetX = RougeMapModel.instance:getMapStartOffsetX()

	return startOffsetX + interval
end

function RougeMapHelper.getNodeLocalPos(index, posType)
	local x = RougeMapHelper.randomX()
	local posList = RougeMapEnum.NodeLocalPosY[posType]
	local posYRate = posList[index] + RougeMapEnum.NodeGlobalOffsetY
	local mapSizeY = RougeMapModel.instance:getMapSize().y

	return x, -posYRate * mapSizeY, 0
end

function RougeMapHelper.randomX()
	local range = RougeMapEnum.NodeLocalPosXRange * 2 + 1

	range = range * 100
	range = math.random(100, range)
	range = range * 0.01

	local middle = RougeMapEnum.NodeLocalPosXRange + 1

	return range - middle
end

function RougeMapHelper.getNodeContainerPos(episodeIndex, posX, posY, posZ)
	local episodePosX = RougeMapHelper.getEpisodePosX(episodeIndex)

	return episodePosX + posX, posY, posZ
end

function RougeMapHelper.getWorldPos(screenPos, camera, refPos)
	local pos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(screenPos, camera, refPos)

	return pos.x, pos.y, pos.z
end

function RougeMapHelper.getOffsetZ(posY)
	if math.abs(posY) > 100 then
		logWarn("abs Y > 100")
	end

	posY = posY - 100

	return posY * 0.001
end

RougeMapHelper.MapType2Cls = {
	[RougeMapEnum.MapType.Edit] = RougeMiddleLayerEditMap,
	[RougeMapEnum.MapType.Normal] = RougeLayerMap,
	[RougeMapEnum.MapType.Middle] = RougeMiddleLayerMap,
	[RougeMapEnum.MapType.PathSelect] = RougePathSelectMap
}

function RougeMapHelper.createMapComp(mapType)
	local cls = RougeMapHelper.MapType2Cls[mapType]

	if not cls then
		logError("not found map cls .. " .. tostring(mapType))

		cls = RougeMapHelper.MapType2Cls[RougeMapEnum.MapType.Normal]
	end

	return (cls.New())
end

function RougeMapHelper.getScenePath(name)
	return string.format(RougeMapEnum.ScenePrefabFormat, name)
end

function RougeMapHelper.addMapOtherRes(mapType, loader)
	if mapType == RougeMapEnum.MapType.Edit then
		loader:addPath(RougeMapEnum.RedNodeResPath)
		loader:addPath(RougeMapEnum.GreenNodeResPath)
		loader:addPath(RougeMapEnum.LineResPath)
		loader:addPath(RougeMapEnum.MiddleLayerLeavePath)
	elseif mapType == RougeMapEnum.MapType.Normal then
		loader:addPath(RougeMapEnum.LinePrefabRes)

		for _, res in pairs(RougeMapEnum.LineIconRes) do
			loader:addPath(res)
		end

		for _, name in pairs(RougeMapEnum.IconPath) do
			loader:addPath(RougeMapHelper.getScenePath(name))
		end

		for _, tab in pairs(RougeMapEnum.NodeBgPath) do
			for _, name in pairs(tab) do
				loader:addPath(RougeMapHelper.getScenePath(name))
			end
		end

		loader:addPath(RougeMapHelper.getScenePath(RougeMapEnum.StartNodeBgPath))
	elseif mapType == RougeMapEnum.MapType.Middle then
		loader:addPath(RougeMapEnum.MiddleLayerLeavePath)
		loader:addPath(RougeMapEnum.PieceBossEffect)

		local middleLayerCo = RougeMapModel.instance:getMiddleLayerCo()
		local dayOrNight = middleLayerCo.dayOrNight
		local actorPiecePath = RougeMapHelper.getPieceResPath(RougeMapEnum.ActorPiecePath, dayOrNight)

		loader:addPath(actorPiecePath)

		local pieceMoList = RougeMapModel.instance:getPieceList()

		for _, pieceMo in ipairs(pieceMoList) do
			local co = pieceMo:getPieceCo()
			local resPath = co.pieceRes

			if not string.nilorempty(resPath) then
				resPath = RougeMapHelper.getPieceResPath(resPath, dayOrNight)

				loader:addPath(resPath)
			end
		end

		for _, res in pairs(RougeMapEnum.PieceIconRes) do
			loader:addPath(res)
		end

		for _, res in pairs(RougeMapEnum.PieceIconBgRes) do
			loader:addPath(res)
		end
	elseif mapType == RougeMapEnum.MapType.PathSelect then
		-- block empty
	end
end

function RougeMapHelper.getMapResPath(mapType)
	if mapType == RougeMapEnum.MapType.Edit then
		local middleLayerId = RougeMapEditModel.instance.middleLayerId

		return RougeMapConfig.instance:getMiddleMapResPath(middleLayerId)
	elseif mapType == RougeMapEnum.MapType.Middle then
		local middleLayerId = RougeMapModel.instance:getMiddleLayerId()

		return RougeMapConfig.instance:getMiddleMapResPath(middleLayerId)
	elseif mapType == RougeMapEnum.MapType.Normal then
		local layerCo = RougeMapModel.instance:getLayerCo()

		return layerCo.mapRes
	elseif mapType == RougeMapEnum.MapType.PathSelect then
		local pathSelectCo = RougeMapModel.instance:getPathSelectCo()

		return pathSelectCo.mapRes
	end
end

function RougeMapHelper.getPieceResPath(resName, dayOrNight)
	local suffix = RougeMapEnum.DayOrNightSuffix[dayOrNight]

	return string.format("scenes/v1a9_m_s16_dilao_room/scene_prefab/chess/%s_%s.prefab", resName, suffix)
end

function RougeMapHelper.formatLineParam(startType, startId, endType, endId)
	if startType == RougeMapEnum.MiddleLayerPointType.Pieces or startType == RougeMapEnum.MiddleLayerPointType.Leave then
		return startType, startId, endType, endId
	end

	return endType, endId, startType, startId
end

function RougeMapHelper.backToMainScene()
	RougeMapModel.instance:clearInteractive()
	RougePopController.instance:clearAllPopView()
	ViewMgr.instance:closeAllPopupViews(nil, true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Rouge)
	MainController.instance:enterMainScene(true, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, RougeMapHelper._onEnterMainSceneDone)
end

function RougeMapHelper._onEnterMainSceneDone()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.DungeonView)

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = RougeMapHelper.openEnterView,
		waitOpenViewName = ViewName.DungeonView
	}))
	sequence:start()
end

function RougeMapHelper.openEnterView()
	RougeController.instance:enterDungeonView()
	RougeController.instance:openRougeMainView()
end

function RougeMapHelper.getEpisodeIndex(stage)
	return stage + 1
end

function RougeMapHelper.loadItem(goItem, cls, moList, itemList)
	for index, mo in ipairs(moList) do
		local item = itemList[index]

		if not item then
			item = cls.New()

			local go = gohelper.cloneInPlace(goItem)

			item:init(go)
			table.insert(itemList, item)
		end

		item:show()
		item:update(index, mo)
	end

	for i = #moList + 1, #itemList do
		itemList[i]:hide()
	end
end

function RougeMapHelper.loadItemWithCustomUpdateFunc(goItem, cls, dataList, itemList, updateFunc, updateFuncObj)
	for index, data in ipairs(dataList) do
		local item = itemList[index]

		if not item then
			item = cls.New()

			local go = gohelper.cloneInPlace(goItem)

			item:init(go)
			table.insert(itemList, item)
		end

		item:show()
		updateFunc(updateFuncObj, item, index, data)
	end

	for i = #dataList + 1, #itemList do
		itemList[i]:hide()
	end
end

function RougeMapHelper.loadGoItem(goItem, num, itemList)
	for i = 1, num do
		local go

		if itemList then
			go = itemList[i]

			if not itemList[i] then
				go = gohelper.cloneInPlace(goItem)

				table.insert(itemList, go)
			end
		else
			go = gohelper.cloneInPlace(goItem)
		end

		gohelper.setActive(go, true)
	end

	if itemList then
		for i = num + 1, #itemList do
			gohelper.setActive(itemList[i], false)
		end
	end
end

function RougeMapHelper.destroyItemList(itemList)
	for _, item in pairs(itemList) do
		item:destroy()
	end
end

function RougeMapHelper.getLineType(curStatus, preStatus)
	local lineType = RougeMapEnum.StatusLineMap[curStatus][preStatus]

	if lineType == RougeMapEnum.LineType.None then
		logError(string.format("Impossible situation .. curStatus : %s   ---   preStatus : %s", curStatus, preStatus))

		return RougeMapEnum.LineType.CantArrive
	end

	return lineType
end

function RougeMapHelper.getMiddleLayerPathListLen(middleLayerCo, pathList, lenList)
	local pathPointList = middleLayerCo.pathPointPos
	local len = 0

	for i = 2, #pathList do
		local prePos = pathPointList[pathList[i - 1]]
		local curPos = pathPointList[pathList[i]]
		local curLen = Vector2.Distance(prePos, curPos)

		len = len + curLen

		table.insert(lenList, curLen)
	end

	for i, curLen in ipairs(lenList) do
		lenList[i] = curLen / len + (lenList[i - 1] or 0)
	end

	lenList[#lenList] = 1

	return len
end

function RougeMapHelper.getAngle(posA_X, posA_Y, posB_X, posB_Y)
	local weight = posB_X - posA_X
	local height = posB_Y - posA_Y
	local w_symbol = weight > 0 and 1 or -1
	local h_symbol = height > 0 and 1 or -1

	if weight == 0 then
		if height == 0 then
			return 0
		else
			return h_symbol > 0 and 90 or 270
		end
	end

	if height == 0 then
		if weight == 0 then
			return 0
		else
			return w_symbol > 0 and 0 or 180
		end
	end

	height = math.abs(height)
	weight = math.abs(weight)

	local tanValue = height / weight
	local rotationZ = math.atan(tanValue) * 180 / math.pi

	if w_symbol > 0 then
		if h_symbol > 0 then
			return rotationZ
		else
			return 360 - rotationZ
		end
	else
		return 180 - h_symbol * rotationZ
	end
end

function RougeMapHelper.getPieceDir(angle)
	if angle >= 0 and angle <= 90 then
		return RougeMapEnum.PieceDir.Top
	elseif angle >= 90 and angle <= 180 then
		return RougeMapEnum.PieceDir.Left
	elseif angle >= 180 and angle <= 270 then
		return RougeMapEnum.PieceDir.Bottom
	elseif angle >= 270 and angle <= 360 then
		return RougeMapEnum.PieceDir.Right
	end

	return RougeMapEnum.PieceDir.Bottom
end

function RougeMapHelper:getActorDir(angle)
	if angle >= 0 and angle <= 22.5 then
		return RougeMapEnum.ActorDir.RightTop
	elseif angle >= 22.5 and angle <= 67.5 then
		return RougeMapEnum.ActorDir.Top
	elseif angle >= 67.5 and angle <= 112.5 then
		return RougeMapEnum.ActorDir.LeftTop
	elseif angle >= 112.5 and angle <= 157.5 then
		return RougeMapEnum.ActorDir.Left
	elseif angle >= 157.5 and angle <= 202.5 then
		return RougeMapEnum.ActorDir.LeftBottom
	elseif angle >= 202.5 and angle <= 247.5 then
		return RougeMapEnum.ActorDir.Bottom
	elseif angle >= 247.5 and angle <= 292.5 then
		return RougeMapEnum.ActorDir.RightBottom
	elseif angle >= 292.5 and angle <= 337.5 then
		return RougeMapEnum.ActorDir.Right
	elseif angle >= 337.5 and angle <= 360 then
		return RougeMapEnum.ActorDir.RightTop
	end

	return RougeMapEnum.ActorDir.Bottom
end

function RougeMapHelper.isEntrustPiece(entrustType)
	return entrustType == RougeMapEnum.PieceEntrustType.Normal or entrustType == RougeMapEnum.PieceEntrustType.Hard
end

function RougeMapHelper.isRestPiece(type)
	return type == RougeMapEnum.PieceEntrustType.Rest
end

function RougeMapHelper.isFightEvent(eventType)
	if not eventType then
		return false
	end

	return eventType == RougeMapEnum.EventType.NormalFight or eventType == RougeMapEnum.EventType.HardFight or eventType == RougeMapEnum.EventType.EliteFight or eventType == RougeMapEnum.EventType.BossFight
end

function RougeMapHelper.isChoiceEvent(eventType)
	if not eventType then
		return false
	end

	return eventType == RougeMapEnum.EventType.Reward or eventType == RougeMapEnum.EventType.Choice or eventType == RougeMapEnum.EventType.Rest
end

function RougeMapHelper.isStoreEvent(eventType)
	if not eventType then
		return false
	end

	return eventType == RougeMapEnum.EventType.Store
end

function RougeMapHelper.getPos(posStr)
	local array = string.splitToNumber(posStr, "#")

	return array[1], array[2]
end

function RougeMapHelper.filterUnActivePieceChoice(choiceIdList)
	for i = #choiceIdList, 1, -1 do
		local id = choiceIdList[i]
		local co = lua_rouge_piece_select.configDict[id]

		if not RougeMapUnlockHelper.checkIsUnlock(co.activeType, co.activeParam) then
			table.remove(choiceIdList, i)
		end
	end
end

function RougeMapHelper.getChangeMapEnum(preMapType, curMapType)
	if preMapType == RougeMapEnum.MapType.Normal and curMapType == RougeMapEnum.MapType.Middle then
		return RougeMapEnum.ChangeMapEnum.NormalToMiddle
	elseif preMapType == RougeMapEnum.MapType.Middle and curMapType == RougeMapEnum.MapType.PathSelect then
		return RougeMapEnum.ChangeMapEnum.MiddleToPathSelect
	elseif preMapType == RougeMapEnum.MapType.PathSelect and curMapType == RougeMapEnum.MapType.Normal then
		return RougeMapEnum.ChangeMapEnum.PathSelectToNormal
	end
end

function RougeMapHelper.getLifeChangeStatus(preLife, curLife)
	if preLife == curLife then
		return RougeMapEnum.LifeChangeStatus.Idle
	end

	if preLife < curLife then
		return RougeMapEnum.LifeChangeStatus.Add
	end

	return RougeMapEnum.LifeChangeStatus.Reduce
end

function RougeMapHelper.checkNeedFilterUnique(interactType)
	return interactType == RougeMapEnum.InteractType.LossAndCopy or interactType == RougeMapEnum.InteractType.LossNotUniqueCollection or interactType == RougeMapEnum.InteractType.StorageCollection
end

function RougeMapHelper.getEndId()
	local curPieceMo = RougeMapModel.instance:getCurPieceMo()
	local selectId = curPieceMo and curPieceMo.selectId
	local co = selectId and lua_rouge_piece_select.configDict[selectId]

	if not co then
		return
	end

	local paramArray = string.splitToNumber(co.triggerParam, "#")

	return paramArray and paramArray[2]
end

RougeMapHelper.CommonIgnoreViewDict = {
	[ViewName.RougeMapView] = true,
	[ViewName.RougeMapTipView] = true,
	[ViewName.ToastView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.WaterMarkView] = true,
	[ViewName.GuideView] = true
}

function RougeMapHelper.checkMapViewOnTop(log)
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(openViewList) do
		if not RougeMapHelper.CommonIgnoreViewDict[viewName] then
			if log then
				logNormal("cur top view : " .. tostring(viewName))
			end

			return false
		end
	end

	return true
end

function RougeMapHelper.clearMapData()
	RougeMapController.instance:clear()
	RougeMapModel.instance:clear()
	RougeMapTipPopController.instance:clear()
	RougeMapVoiceTriggerController.instance:clear()
	RougePopController.instance:clearAllPopView()
end

return RougeMapHelper
