-- chunkname: @modules/logic/gm/view/rouge/RougeEditorController.lua

module("modules.logic.gm.view.rouge.RougeEditorController", package.seeall)

local RougeEditorController = class("RougeEditorController")

function RougeEditorController:_addMapEditorView()
	local viewName = "RougeMapEditorView"

	if module_views[viewName] then
		return
	end

	module_views[viewName] = {
		destroy = 0,
		container = "RougeMapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge/gm_rougemapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[viewName] = viewName
end

function RougeEditorController:_addPathSelectMapEditorView()
	local viewName = "RougePathSelectMapEditorView"

	if module_views[viewName] then
		return
	end

	module_views[viewName] = {
		destroy = 0,
		container = "RougePathSelectMapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge/gm_rougepathselectmapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[viewName] = viewName
end

function RougeEditorController:enterRougeMapEditor()
	if self.flow then
		return
	end

	self:_addMapEditorView()

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge then
		local middleLayerCo = lua_rouge_middle_layer.configList[1]

		RougeMapModel.instance:init(RougeMapEnum.MapType.Edit)
		RougeMapEditModel.instance:init(middleLayerCo.id)

		self.flow = FlowSequence.New()

		self.flow:addWork(OpenSceneWork.New(SceneType.Rouge, 1, middleLayerCo.id))
		self.flow:addWork(OpenViewWorkByViewName.New(ViewName.RougeMapEditorView))
		self.flow:registerDoneListener(self.onFlowDone, self)
		self.flow:start()

		return
	end

	if RougeMapModel.instance:isMiddle() then
		ViewMgr.instance:openView(ViewName.RougeMapEditorView)
	else
		RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, self.onLoadMapDone, self)

		RougeMapModel.instance.isMiddle = true

		local scene = GameSceneMgr.instance:getCurScene()
		local map = scene.map
		local middleLayerCo = lua_rouge_middle_layer.configList[1]

		map:switchMap(RougeMapModel.instance:getLayerId(), middleLayerCo.id)
	end
end

function RougeEditorController:onFlowDone()
	self.flow = nil
end

function RougeEditorController:onLoadMapDone()
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, self.onMapLoadDone, self)
	ViewMgr.instance:openView(ViewName.RougeMapEditorView)
end

function RougeEditorController:enterRougeTestMap()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge then
		RougeMapModel.instance:init(RougeMapEnum.MapType.Normal)
		GameSceneMgr.instance:startScene(SceneType.Rouge, 1, RougeMapModel.instance:getLayerId())

		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local map = scene.map

	map:switchMap(RougeMapModel.instance:getLayerId(), nil)
end

function RougeEditorController:showNodeClickArea()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge then
		return
	end

	local mapType = RougeMapModel.instance:getMapType()

	if mapType == RougeMapEnum.MapType.Edit then
		return
	end

	if self.loadingText then
		return
	end

	self.showing = true

	if self.textGo then
		self:_showNodeClickArea()
	else
		self.loadingText = true

		loadAbAsset(RougeEditorController.TextPath, false, self._onLoadTextCallback, self)
	end
end

RougeEditorController.TextPath = "ui/viewres/gm/rouge/gm_rouge_text.prefab"

function RougeEditorController:_onLoadTextCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self.textGo = self._assetItem:GetResource(RougeEditorController.TextPath)
		self.loadingText = false

		self:_showNodeClickArea()
	end
end

function RougeEditorController:_showNodeClickArea()
	if not self.showing then
		return
	end

	self:createArea()
	RougeMapController.instance:registerCallback(RougeMapEvent.onMapPosChange, self.onMapPosChange, self, LuaEventSystem.Low)
	TaskDispatcher.runRepeat(self.refreshPos, self, 0.1)
end

RougeEditorController.AreaTextColor = Color.New(1, 0, 0, 1)

function RougeEditorController:createArea()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.RougeMapView)
	local go = viewContainer.viewGO
	local textGo = self.textGo
	local areaContainer = gohelper.findChild(go, "areaContainer") or gohelper.create2d(go, "areaContainer")
	local centerPointContainer = gohelper.findChild(go, "centerPointContainer") or gohelper.create2d(go, "centerPointContainer")
	local areaRectTr = areaContainer:GetComponent(gohelper.Type_RectTransform)
	local centerPointRectTr = centerPointContainer:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(areaContainer, true)
	gohelper.setActive(centerPointRectTr, true)

	self.goAreaContainer = areaContainer
	self.goCenterPointContainer = centerPointContainer
	self.textItemList = {}

	local mapComp = RougeMapController.instance:getMapComp()
	local mapItemList = mapComp:getMapItemList()

	for index, mapItem in ipairs(mapItemList) do
		local areaGo = gohelper.findChild(areaContainer, index) or gohelper.create2d(areaContainer, index)

		gohelper.setActive(areaGo, true)

		local image = gohelper.onceAddComponent(areaGo, gohelper.Type_Image)

		ZProj.UGUIHelper.SetColorAlpha(image, 0.5)

		image.raycastTarget = false

		local clickArea = mapItem:getClickArea()
		local width = clickArea.x
		local height = clickArea.y
		local offsetX = clickArea.z
		local offsetY = clickArea.w
		local posX, posY = mapItem:getUiPos(areaRectTr)

		recthelper.setAnchor(areaGo.transform, posX + offsetX, posY + offsetY)
		recthelper.setSize(areaGo.transform, width, height)

		local pointGo = gohelper.findChild(centerPointContainer, index) or gohelper.create2d(centerPointContainer, index)

		gohelper.setActive(pointGo, true)

		image = gohelper.onceAddComponent(pointGo, gohelper.Type_Image)
		image.color = Color.New(0, 0, 0, 1)
		image.raycastTarget = false

		recthelper.setSize(pointGo.transform, 20, 20)
		recthelper.setAnchor(pointGo.transform, posX, posY)

		local textItem = {}
		local text = gohelper.findChild(areaGo, "text") or gohelper.clone(textGo, areaGo, "text")

		textItem.text = text:GetComponent(gohelper.Type_TextMesh)
		textItem.text.color = RougeEditorController.AreaTextColor
		textItem.areaRectTr = areaGo:GetComponent(gohelper.Type_RectTransform)
		textItem.mapItem = mapItem

		local rectTr = text:GetComponent(gohelper.Type_RectTransform)

		recthelper.setAnchor(rectTr, 0, 50)
		table.insert(self.textItemList, textItem)
		self:refreshOnePos(textItem)
	end
end

function RougeEditorController:refreshPos()
	for _, textItem in ipairs(self.textItemList) do
		if not self:refreshOnePos(textItem) then
			TaskDispatcher.cancelTask(self.refreshPos, self)

			return
		end
	end
end

function RougeEditorController:refreshOnePos(textItem)
	if gohelper.isNil(textItem.areaRectTr) then
		return false
	end

	local width = recthelper.getWidth(textItem.areaRectTr)
	local height = recthelper.getHeight(textItem.areaRectTr)
	local srcAnchorX, srcAnchorY = textItem.mapItem:getUiPos(self.goAreaContainer.transform)
	local curAnchorX, curAnchorY = recthelper.getAnchor(textItem.areaRectTr)
	local offsetX = curAnchorX - srcAnchorX
	local offsetY = curAnchorY - srcAnchorY

	textItem.text.text = string.format("%s, %s, %s, %s", RougeMapHelper.retain2decimals(width), RougeMapHelper.retain2decimals(height), RougeMapHelper.retain2decimals(offsetX), RougeMapHelper.retain2decimals(offsetY))

	return true
end

function RougeEditorController:onMapPosChange()
	if not self.showing then
		return
	end

	self:createArea()
end

function RougeEditorController:hideNodeClickArea()
	TaskDispatcher.cancelTask(self.refreshPos, self)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMapPosChange, self.onMapPosChange, self)

	if not self.showing then
		return
	end

	if gohelper.isNil(self.goAreaContainer) then
		return
	end

	self.showing = false

	gohelper.setActive(self.goAreaContainer, false)

	local tr = self.goAreaContainer.transform
	local count = tr.childCount

	for i = 0, count - 1 do
		local go = tr:GetChild(i)

		gohelper.setActive(go.gameObject, false)
	end

	gohelper.setActive(self.goCenterPointContainer, false)

	tr = self.goCenterPointContainer.transform
	count = self.goCenterPointContainer.transform.childCount

	for i = 0, self.goCenterPointContainer.transform.childCount - 1 do
		local go = tr:GetChild(i)

		gohelper.setActive(go.gameObject, false)
	end
end

function RougeEditorController:getIsShowing()
	return self.showing
end

function RougeEditorController:enterPathSelectMapEditorView()
	if self.flow then
		return
	end

	self:_addPathSelectMapEditorView()

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge then
		local info = {
			mapType = RougeMapEnum.MapType.Middle,
			middleLayerInfo = {
				layerId = 101,
				middleLayerId = 101,
				positionIndex = RougeMapEnum.PathSelectIndex
			},
			HasField = function()
				return false
			end
		}

		RougeMapModel.instance:updateMapInfo(info)

		self.flow = FlowSequence.New()

		self.flow:addWork(OpenSceneWork.New(SceneType.Rouge, 1, 101))
		self.flow:addWork(OpenViewWorkByViewName.New(ViewName.RougePathSelectMapEditorView))
		self.flow:registerDoneListener(self.onFlowDone, self)
		self.flow:start()

		return
	end

	if RougeMapModel.instance:isPathSelect() then
		ViewMgr.instance:openView(ViewName.RougePathSelectMapEditorView)
	end
end

function RougeEditorController:allowAbortFight(allow)
	self.allow = allow
end

function RougeEditorController:isAllowAbortFight()
	return not not self.allow
end

RougeEditorController.instance = RougeEditorController.New()

return RougeEditorController
