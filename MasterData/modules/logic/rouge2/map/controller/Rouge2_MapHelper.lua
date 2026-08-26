-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapHelper", package.seeall)

local Rouge2_MapHelper = class("Rouge2_MapHelper")

function Rouge2_MapHelper.blockEsc()
	return
end

Rouge2_MapHelper.StandardRate = 1.7777777777777777

function Rouge2_MapHelper.getMiddleLayerCameraSize()
	local w, h = UnityEngine.Screen.width, UnityEngine.Screen.height
	local rate = w / h
	local mapSize = Rouge2_MapModel.instance:getMapSize()

	if rate >= Rouge2_MapHelper.StandardRate then
		return mapSize.y / 2
	end

	local mapWidth = mapSize.y * Rouge2_MapHelper.StandardRate
	local halfHeight = mapWidth / rate

	return halfHeight / 2
end

function Rouge2_MapHelper.getNormalLayerCameraSize()
	local w, h = UnityEngine.Screen.width, UnityEngine.Screen.height
	local rate = w / h
	local mapSize = Rouge2_MapModel.instance:getMapSize()
	local halfHeight = mapSize.y / 2

	if rate >= Rouge2_MapHelper.StandardRate then
		return halfHeight
	end

	local scaleRate = h * Rouge2_MapHelper.StandardRate / w

	return halfHeight * scaleRate
end

function Rouge2_MapHelper.getUIRoot()
	local w, h = UnityEngine.Screen.width, UnityEngine.Screen.height
	local rate = w / h

	if rate >= Rouge2_MapHelper.StandardRate then
		return ViewMgr.instance:getUIRoot()
	end

	return ViewMgr.instance:getUILayer(UILayerName.PopUpTop)
end

function Rouge2_MapHelper.getScenePos(camera, mousePos, offsetZ)
	mousePos.z = offsetZ

	local pos = camera:ScreenToWorldPoint(mousePos)

	pos.x = Rouge2_MapHelper.retain2decimals(pos.x)
	pos.y = Rouge2_MapHelper.retain2decimals(pos.y)
	pos.z = Rouge2_MapHelper.retain2decimals(pos.z)

	return pos
end

function Rouge2_MapHelper.retain2decimals(num)
	return num - num % 0.01
end

function Rouge2_MapHelper.getEpisodePosX(index)
	return 0
end

function Rouge2_MapHelper.getNodeLocalPos(layerId, posType, episodeIndex, nodeIndex)
	local cellPos = Rouge2_MapConfig.instance:getCellPos(layerId, posType, episodeIndex, nodeIndex)

	if cellPos then
		if not cellPos[1] then
			local row = 0

			if cellPos then
				if not cellPos[2] then
					local col = 0
					local localPosX = (col - 1) * Rouge2_MapEnum.LayerCellSize.x + Rouge2_MapEnum.LayerCellSize.x / 2
					local localPosY = -row * Rouge2_MapEnum.LayerCellSize.y + Rouge2_MapEnum.LayerCellSize.y / 2

					return localPosX, localPosY, 0
				end
			end
		end
	end
end

function Rouge2_MapHelper.getNodeContainerPos(episodeIndex, posX, posY, posZ)
	local episodePosX = Rouge2_MapHelper.getEpisodePosX(episodeIndex)

	return episodePosX + posX, posY, posZ
end

function Rouge2_MapHelper.getWorldPos(screenPos, camera, refPos)
	local pos = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(screenPos, camera, refPos)

	return pos.x, pos.y, pos.z
end

function Rouge2_MapHelper.getOffsetZ(posY)
	if math.abs(posY) > 100 then
		logWarn("abs Y > 100")
	end

	posY = posY - 100

	return posY * 0.001
end

Rouge2_MapHelper.MapType2Cls = {
	[Rouge2_MapEnum.MapType.Edit] = Rouge2_MiddleLayerEditMap,
	[Rouge2_MapEnum.MapType.Normal] = Rouge2_LayerMap,
	[Rouge2_MapEnum.MapType.Middle] = Rouge2_MiddleLayerMap,
	[Rouge2_MapEnum.MapType.PathSelect] = Rouge2_PathSelectMap
}

function Rouge2_MapHelper.createMapComp(mapType)
	local cls = Rouge2_MapHelper.MapType2Cls[mapType]

	if not cls then
		logError("not found map cls .. " .. tostring(mapType))

		cls = Rouge2_MapHelper.MapType2Cls[Rouge2_MapEnum.MapType.Normal]
	end

	return (cls.New())
end

function Rouge2_MapHelper.addMapOtherRes(mapType, loader)
	if mapType == Rouge2_MapEnum.MapType.Edit then
		loader:addPath(Rouge2_MapEnum.RedNodeResPath)
		loader:addPath(Rouge2_MapEnum.GreenNodeResPath)
		loader:addPath(Rouge2_MapEnum.LineResPath)
	elseif mapType == Rouge2_MapEnum.MapType.Normal then
		loader:addPath(Rouge2_MapEnum.LinePrefabRes)
		loader:addPath(Rouge2_MapEnum.LayerNodeIconCanvas)
	elseif mapType == Rouge2_MapEnum.MapType.Middle then
		loader:addPath(Rouge2_MapEnum.PieceBossEffect)

		local middleLayerCo = Rouge2_MapModel.instance:getMiddleLayerCo()
		local dayOrNight = middleLayerCo.dayOrNight
		local actorPiecePath = Rouge2_MapHelper.getPieceResPath(Rouge2_MapEnum.ActorPiecePath, dayOrNight)

		loader:addPath(actorPiecePath)

		local pieceMoList = Rouge2_MapModel.instance:getPieceList()

		for _, pieceMo in ipairs(pieceMoList) do
			local co = pieceMo:getPieceCo()
			local resPath = co.pieceRes

			if not string.nilorempty(resPath) then
				resPath = Rouge2_MapHelper.getPieceResPath(resPath, dayOrNight)

				loader:addPath(resPath)
			end
		end

		loader:addPath(Rouge2_MapEnum.MiddlePieceIconCanvas)
	elseif mapType == Rouge2_MapEnum.MapType.PathSelect then
		-- block empty
	end
end

function Rouge2_MapHelper.getMapResPath(mapType)
	if mapType == Rouge2_MapEnum.MapType.Edit then
		local middleLayerId = Rouge2_MapEditModel.instance.middleLayerId

		return Rouge2_MapConfig.instance:getMiddleMapResPath(middleLayerId)
	elseif mapType == Rouge2_MapEnum.MapType.Middle then
		local middleLayerId = Rouge2_MapModel.instance:getMiddleLayerId()

		return Rouge2_MapConfig.instance:getMiddleMapResPath(middleLayerId)
	elseif mapType == Rouge2_MapEnum.MapType.Normal then
		local layerCo = Rouge2_MapModel.instance:getLayerCo()
		local weatherInfo = Rouge2_MapModel.instance:getCurMapWeatherInfo()
		local weatherId = weatherInfo and weatherInfo:getWeatherId()

		return Rouge2_MapConfig.instance:getLayerMapResPath(layerCo.id, weatherId)
	elseif mapType == Rouge2_MapEnum.MapType.PathSelect then
		-- block empty
	end
end

function Rouge2_MapHelper.getPieceResPath(resName, dayOrNight)
	local suffix = Rouge2_MapEnum.DayOrNightSuffix[dayOrNight]

	return string.format("scenes/v3a2_m_s16_dilao/scenes_prefab/chess/%s_%s.prefab", resName, suffix)
end

function Rouge2_MapHelper.formatLineParam(startType, startId, endType, endId)
	if startType == Rouge2_MapEnum.MiddleLayerPointType.Pieces or startType == Rouge2_MapEnum.MiddleLayerPointType.Leave then
		return startType, startId, endType, endId
	end

	return endType, endId, startType, startId
end

function Rouge2_MapHelper.backToMainScene()
	Rouge2_MapModel.instance:clearInteractive()
	Rouge2_MapModel.instance:setManualCloseHeroGroupView(false)
	Rouge2_MapAttrUpdateController.instance:clearUpdateAttrMap()
	Rouge2_MapChoiceController.instance:clear()
	Rouge2_PopController.instance:clearAllPopView()
	ViewMgr.instance:closeAllPopupViews(nil, true)
	Rouge2_StatController.instance:quitMap()
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Rouge2)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.Rouge2_MapLoadingView)
	MainController.instance:enterMainScene(true, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, Rouge2_MapHelper._onEnterMainSceneDone)
end

function Rouge2_MapHelper._onEnterMainSceneDone()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Rouge2_EnterView)

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = Rouge2_MapHelper.openEnterView,
		waitOpenViewName = ViewName.DungeonView
	}))
	sequence:start()
end

function Rouge2_MapHelper.openEnterView()
	Rouge2_Controller.instance:enterDungeonView()
	Rouge2_Controller.instance:openEnterView({
		openMain = true
	}, false)
end

function Rouge2_MapHelper.getEpisodeIndex(stage)
	return stage + 1
end

function Rouge2_MapHelper.loadItem(goItem, cls, moList, itemList)
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

function Rouge2_MapHelper.loadItemWithCustomUpdateFunc(goItem, cls, dataList, itemList, updateFunc, updateFuncObj)
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

function Rouge2_MapHelper.loadGoItem(goItem, num, itemList)
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

function Rouge2_MapHelper.destroyItemList(itemList)
	for _, item in pairs(itemList) do
		item:destroy()
	end
end

function Rouge2_MapHelper.getLineType(curStatus, preStatus)
	local lineType = Rouge2_MapEnum.StatusLineMap[curStatus][preStatus]

	if lineType == Rouge2_MapEnum.LineType.None then
		logError(string.format("Impossible situation .. curStatus : %s   ---   preStatus : %s", curStatus, preStatus))

		return Rouge2_MapEnum.LineType.CantArrive
	end

	return lineType
end

function Rouge2_MapHelper.getMiddleLayerPathListLen(middleLayerCo, pathList, lenList)
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

function Rouge2_MapHelper.getAngle(posA_X, posA_Y, posB_X, posB_Y)
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

function Rouge2_MapHelper.getPieceDir(angle)
	if angle >= 0 and angle <= 90 then
		return Rouge2_MapEnum.PieceDir.Top
	elseif angle >= 90 and angle <= 180 then
		return Rouge2_MapEnum.PieceDir.Left
	elseif angle >= 180 and angle <= 270 then
		return Rouge2_MapEnum.PieceDir.Bottom
	elseif angle >= 270 and angle <= 360 then
		return Rouge2_MapEnum.PieceDir.Right
	end

	return Rouge2_MapEnum.PieceDir.Bottom
end

function Rouge2_MapHelper.getActorDir(angle)
	if angle >= 0 and angle <= 22.5 then
		return Rouge2_MapEnum.ActorDir.RightTop
	elseif angle >= 22.5 and angle <= 67.5 then
		return Rouge2_MapEnum.ActorDir.Top
	elseif angle >= 67.5 and angle <= 112.5 then
		return Rouge2_MapEnum.ActorDir.LeftTop
	elseif angle >= 112.5 and angle <= 157.5 then
		return Rouge2_MapEnum.ActorDir.Left
	elseif angle >= 157.5 and angle <= 202.5 then
		return Rouge2_MapEnum.ActorDir.LeftBottom
	elseif angle >= 202.5 and angle <= 247.5 then
		return Rouge2_MapEnum.ActorDir.Bottom
	elseif angle >= 247.5 and angle <= 292.5 then
		return Rouge2_MapEnum.ActorDir.RightBottom
	elseif angle >= 292.5 and angle <= 337.5 then
		return Rouge2_MapEnum.ActorDir.Right
	elseif angle >= 337.5 and angle <= 360 then
		return Rouge2_MapEnum.ActorDir.RightTop
	end

	return Rouge2_MapEnum.ActorDir.Bottom
end

function Rouge2_MapHelper.isEntrustPiece(entrustType)
	return entrustType == Rouge2_MapEnum.PieceEntrustType.Normal or entrustType == Rouge2_MapEnum.PieceEntrustType.Hard
end

function Rouge2_MapHelper.isRestPiece(type)
	return type == Rouge2_MapEnum.PieceEntrustType.Rest
end

function Rouge2_MapHelper.isFightEvent(eventType)
	if not eventType then
		return false
	end

	return eventType == Rouge2_MapEnum.EventType.NormalFight or eventType == Rouge2_MapEnum.EventType.EliteFight or eventType == Rouge2_MapEnum.EventType.BossFight or eventType == Rouge2_MapEnum.EventType.EasyFight
end

function Rouge2_MapHelper.isEliteFightEvent(eventType)
	if not eventType then
		return false
	end

	return eventType == Rouge2_MapEnum.EventType.EliteFight or eventType == Rouge2_MapEnum.EventType.BossFight
end

function Rouge2_MapHelper.isChoiceEvent(eventType)
	if not eventType then
		return false
	end

	return eventType == Rouge2_MapEnum.EventType.HighHardFight or eventType == Rouge2_MapEnum.EventType.Reward or eventType == Rouge2_MapEnum.EventType.Rest or eventType == Rouge2_MapEnum.EventType.Strengthen or eventType == Rouge2_MapEnum.EventType.StoryChoice or eventType == Rouge2_MapEnum.EventType.ExploreChoice
end

function Rouge2_MapHelper.isStoreEvent(eventType)
	if not eventType then
		return false
	end

	return eventType == Rouge2_MapEnum.EventType.Store
end

function Rouge2_MapHelper.getPos(posStr)
	local array = string.splitToNumber(posStr, "#")

	return array[1], array[2]
end

function Rouge2_MapHelper.getChangeMapEnum(preMapType, curMapType)
	if preMapType == Rouge2_MapEnum.MapType.Normal and curMapType == Rouge2_MapEnum.MapType.Middle then
		return Rouge2_MapEnum.ChangeMapEnum.NormalToMiddle
	elseif preMapType == Rouge2_MapEnum.MapType.Middle and curMapType == Rouge2_MapEnum.MapType.PathSelect then
		return Rouge2_MapEnum.ChangeMapEnum.MiddleToPathSelect
	elseif preMapType == Rouge2_MapEnum.MapType.PathSelect and curMapType == Rouge2_MapEnum.MapType.Normal then
		return Rouge2_MapEnum.ChangeMapEnum.PathSelectToNormal
	end
end

function Rouge2_MapHelper.getLifeChangeStatus(preLife, curLife)
	if preLife == curLife then
		return Rouge2_MapEnum.LifeChangeStatus.Idle
	end

	if preLife < curLife then
		return Rouge2_MapEnum.LifeChangeStatus.Add
	end

	return Rouge2_MapEnum.LifeChangeStatus.Reduce
end

function Rouge2_MapHelper.getEndId()
	local curPieceMo = Rouge2_MapModel.instance:getCurPieceMo()
	local selectId = curPieceMo and curPieceMo.selectId
	local co = selectId and lua_rouge2_piece_select.configDict[selectId]

	if not co then
		return
	end

	local paramArray = string.splitToNumber(co.triggerParam, "#")

	return paramArray and paramArray[2]
end

Rouge2_MapHelper.CommonIgnoreViewDict = {
	[ViewName.Rouge2_MapView] = true,
	[ViewName.Rouge2_MapTipView] = true,
	[ViewName.ToastView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.WaterMarkView] = true,
	[ViewName.GuideView] = true
}

function Rouge2_MapHelper.checkMapViewOnTop(log)
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(openViewList) do
		if not Rouge2_MapHelper.CommonIgnoreViewDict[viewName] then
			if log then
				logNormal("cur top view : " .. tostring(viewName))
			end

			return false
		end
	end

	return true
end

function Rouge2_MapHelper.clearMapData()
	Rouge2_MapController.instance:clear()
	Rouge2_MapModel.instance:clear()
	Rouge2_MapTipPopController.instance:clear()
	Rouge2_MapVoiceTriggerController.instance:clear()
	Rouge2_PopController.instance:clearAllPopView()
end

function Rouge2_MapHelper.getWeatherRuleDesc(weatherRuleIdList)
	if not weatherRuleIdList then
		return
	end

	local weatherRuleDescList = {}

	for _, weatherRuleId in ipairs(weatherRuleIdList) do
		local weatherRuleCo = Rouge2_MapConfig.instance:getWeatherRuleConfig(weatherRuleId)

		table.insert(weatherRuleDescList, weatherRuleCo and weatherRuleCo.desc)
	end

	return table.concat(weatherRuleDescList, "\n")
end

function Rouge2_MapHelper.buildChoiceDesc(desc)
	desc = Rouge2_MapHelper.addChoiceLink(desc)
	desc = SkillHelper.addColor(desc)

	return desc
end

function Rouge2_MapHelper.addChoiceLink(desc)
	desc = string.gsub(desc, "%[(.-)%]", Rouge2_MapHelper._replaceItemIdFunc1)
	desc = string.gsub(desc, "【(.-)】", Rouge2_MapHelper._replaceItemIdFunc2)

	return desc
end

function Rouge2_MapHelper._replaceItemIdFunc1(itemId)
	itemId = tonumber(itemId)

	if not itemId then
		return itemId
	end

	local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)
	local itemName = itemCo and itemCo.name

	return string.format("[<u><link=%s>%s</link></u>]", itemId, itemName)
end

function Rouge2_MapHelper._replaceItemIdFunc2(itemId)
	itemId = tonumber(itemId)

	if not itemId then
		return itemId
	end

	local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)
	local itemName = itemCo and itemCo.name

	return string.format("【<u><link=%s>%s</link></u>】", itemId, itemName)
end

return Rouge2_MapHelper
