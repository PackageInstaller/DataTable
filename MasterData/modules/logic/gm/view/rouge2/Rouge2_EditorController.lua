-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_EditorController.lua

module("modules.logic.gm.view.rouge2.Rouge2_EditorController", package.seeall)

local Rouge2_EditorController = class("Rouge2_EditorController")

function Rouge2_EditorController:_addMapEditorView()
	local viewName = "Rouge2_MapEditorView"

	if module_views[viewName] then
		return
	end

	module_views[viewName] = {
		destroy = 0,
		container = "Rouge2_MapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge/gm_rougemapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[viewName] = viewName
end

function Rouge2_EditorController:_addNormalLayerMapEditorView()
	local viewName = "Rouge2_NormalLayerMapEditorView"

	if module_views[viewName] then
		return
	end

	module_views[viewName] = {
		bgBlur = 0,
		container = "Rouge2_NormalLayerMapEditorViewContainer",
		destroy = 0,
		mainRes = "ui/viewres/gm/rouge2/gm_rouge2layermapcanvaseditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Full,
		anim = ViewAnim.Default,
		otherRes = {
			[1] = "ui/viewres/gm/rouge2/gm_rouge2layernodeiconcanvas.prefab"
		},
		tabRes = {
			{
				{
					NavigateButtonsView.prefabPath
				}
			}
		}
	}
	ViewName[viewName] = viewName
end

function Rouge2_EditorController:_addPathSelectMapEditorView()
	local viewName = "Rouge2_PathSelectMapEditorView"

	if module_views[viewName] then
		return
	end

	module_views[viewName] = {
		destroy = 0,
		container = "Rouge2_PathSelectMapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge2/gm_rouge2pathselectmapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[viewName] = viewName
end

function Rouge2_EditorController:enterRougeMapEditor()
	if self.flow then
		return
	end

	self:_addMapEditorView()

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge2 then
		local middleLayerCo = lua_rouge2_middle_layer.configList[1]

		Rouge2_MapModel.instance:init(Rouge2_MapEnum.MapType.Edit)
		Rouge2_MapEditModel.instance:init(middleLayerCo.id)

		self.flow = FlowSequence.New()

		self.flow:addWork(OpenSceneWork.New(SceneType.Rouge2, 1, middleLayerCo.id))
		self.flow:addWork(OpenViewWorkByViewName.New(ViewName.Rouge2_MapEditorView))
		self.flow:registerDoneListener(self.onFlowDone, self)
		self.flow:start()

		return
	end

	if Rouge2_MapModel.instance:isMiddle() then
		ViewMgr.instance:openView(ViewName.Rouge2_MapEditorView)
	else
		Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onLoadMapDone, self.onLoadMapDone, self)

		Rouge2_MapModel.instance.isMiddle = true

		local scene = GameSceneMgr.instance:getCurScene()
		local map = scene.map
		local middleLayerCo = lua_rouge2_middle_layer.configList[1]

		map:switchMap(Rouge2_MapModel.instance:getLayerId(), middleLayerCo.id)
	end
end

function Rouge2_EditorController:onFlowDone()
	self.flow = nil
end

function Rouge2_EditorController:onLoadMapDone()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onLoadMapDone, self.onMapLoadDone, self)
	ViewMgr.instance:openView(ViewName.Rouge2_MapEditorView)
end

function Rouge2_EditorController:enterRougeTestMap()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge2 then
		Rouge2_MapModel.instance:init(Rouge2_MapEnum.MapType.Normal)
		GameSceneMgr.instance:startScene(SceneType.Rouge2, 1, Rouge2_MapModel.instance:getLayerId())

		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local map = scene.map

	map:switchMap(Rouge2_MapModel.instance:getLayerId(), nil)
end

function Rouge2_EditorController:showNodeClickArea()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge2 then
		return
	end

	local mapType = Rouge2_MapModel.instance:getMapType()

	if mapType == Rouge2_MapEnum.MapType.Edit then
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

		loadAbAsset(Rouge2_EditorController.TextPath, false, self._onLoadTextCallback, self)
	end
end

Rouge2_EditorController.TextPath = "ui/viewres/gm/rouge/gm_rouge_text.prefab"

function Rouge2_EditorController:_onLoadTextCallback(assetItem)
	if assetItem.IsLoadSuccess then
		self._assetItem = assetItem

		self._assetItem:Retain()

		self.textGo = self._assetItem:GetResource(Rouge2_EditorController.TextPath)
		self.loadingText = false

		self:_showNodeClickArea()
	end
end

function Rouge2_EditorController:_showNodeClickArea()
	if not self.showing then
		return
	end

	self:createArea()
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onMapPosChange, self.onMapPosChange, self, LuaEventSystem.Low)
	TaskDispatcher.runRepeat(self.refreshPos, self, 0.1)
end

Rouge2_EditorController.AreaTextColor = Color.New(1, 0, 0, 1)

function Rouge2_EditorController:createArea()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.Rouge2_MapView)
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

	local mapComp = Rouge2_MapController.instance:getMapComp()
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
		textItem.text.color = Rouge2_EditorController.AreaTextColor
		textItem.areaRectTr = areaGo:GetComponent(gohelper.Type_RectTransform)
		textItem.mapItem = mapItem

		local rectTr = text:GetComponent(gohelper.Type_RectTransform)

		recthelper.setAnchor(rectTr, 0, 50)
		table.insert(self.textItemList, textItem)
		self:refreshOnePos(textItem)
	end
end

function Rouge2_EditorController:refreshPos()
	for _, textItem in ipairs(self.textItemList) do
		if not self:refreshOnePos(textItem) then
			TaskDispatcher.cancelTask(self.refreshPos, self)

			return
		end
	end
end

function Rouge2_EditorController:refreshOnePos(textItem)
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

function Rouge2_EditorController:onMapPosChange()
	if not self.showing then
		return
	end

	self:createArea()
end

function Rouge2_EditorController:hideNodeClickArea()
	TaskDispatcher.cancelTask(self.refreshPos, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onMapPosChange, self.onMapPosChange, self)

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

function Rouge2_EditorController:getIsShowing()
	return self.showing
end

function Rouge2_EditorController:enterPathSelectMapEditorView()
	if self.flow then
		return
	end

	self:_addPathSelectMapEditorView()

	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.Rouge2 then
		local info = {
			mapType = Rouge2_MapEnum.MapType.Middle,
			middleLayerInfo = {
				layerId = 101,
				middleLayerId = 101,
				positionIndex = Rouge2_MapEnum.PathSelectIndex
			},
			HasField = function()
				return false
			end
		}

		Rouge2_MapModel.instance:updateMapInfo(info)

		self.flow = FlowSequence.New()

		self.flow:addWork(OpenSceneWork.New(SceneType.Rouge2, 1, 101))
		self.flow:addWork(OpenViewWorkByViewName.New(ViewName.Rouge2_PathSelectMapEditorView))
		self.flow:registerDoneListener(self.onFlowDone, self)
		self.flow:start()

		return
	end

	if Rouge2_MapModel.instance:isPathSelect() then
		ViewMgr.instance:openView(ViewName.Rouge2_PathSelectMapEditorView)
	end
end

function Rouge2_EditorController:allowAbortFight(allow)
	self.allow = allow
end

function Rouge2_EditorController:isAllowAbortFight()
	return not not self.allow
end

function Rouge2_EditorController:enterNormalLayerMapEditor()
	self:_addNormalLayerMapEditorView()
	ViewMgr.instance:openView(ViewName.Rouge2_NormalLayerMapEditorView)
end

Rouge2_EditorController.instance = Rouge2_EditorController.New()

return Rouge2_EditorController
