-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_NormalLayerMapEditorView.lua

module("modules.logic.gm.view.rouge2.Rouge2_NormalLayerMapEditorView", package.seeall)

local Rouge2_NormalLayerMapEditorView = class("Rouge2_NormalLayerMapEditorView", BaseView)

if not Rouge2_MapEnum.LayerCellSize then
	local CellSize = Vector2(1, 1)
	local Scale = Vector3(1, 1, 1)
	local PathPointLengthen = 10
	local SelectColNum = {
		1,
		2,
		3
	}

	function Rouge2_NormalLayerMapEditorView:onInitView()
		self._dropMap = gohelper.findChildDropdown(self.viewGO, "#go_top/#go_dropmap/#drop_map")
		self._dropRow = gohelper.findChildDropdown(self.viewGO, "#go_top/#go_droprow/#drop_row")
		self._btnExport = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#btn_export")
		self._goFullscreen = gohelper.findChild(self.viewGO, "#go_FullScreen")

		if self._editableInitView then
			self:_editableInitView()
		end
	end

	function Rouge2_NormalLayerMapEditorView:addEvents()
		self._dropMap:AddOnValueChanged(self._onDropMapValueChanged, self)
		self._dropRow:AddOnValueChanged(self._onDropRowValueChanged, self)
		self._btnExport:AddClickListener(self._btnExportOnClick, self)

		self._drag = SLFramework.UGUI.UIDragListener.Get(self._goFullscreen)

		self._drag:AddDragBeginListener(self._onDragBegin, self)
		self._drag:AddDragListener(self._onDrag, self)
		self._drag:AddDragEndListener(self._onDragEnd, self)
	end

	function Rouge2_NormalLayerMapEditorView:removeEvents()
		self._btnExport:RemoveClickListener()
		self._dropMap:RemoveOnValueChanged()
		self._dropRow:RemoveOnValueChanged()
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	function Rouge2_NormalLayerMapEditorView:_btnExportOnClick()
		self:exportNodeInfo()
	end

	function Rouge2_NormalLayerMapEditorView:_onDropMapValueChanged(index)
		local layerId = self._layerIdList[index + 1]

		if layerId == self._curLayerId then
			return
		end

		self._curLayerId = layerId

		self:loadMap(layerId)
	end

	function Rouge2_NormalLayerMapEditorView:_onDropRowValueChanged(index)
		self._maxNodeNumOneCol = SelectColNum[index + 1] or 1

		self:initNodeInfo()
		self:initNodeList()
	end

	function Rouge2_NormalLayerMapEditorView:_onDragBegin(param, pointerEventData)
		self._isDraging = true
		self._dragBeginPosX = Rouge2_MapHelper.getWorldPos(pointerEventData.position, self._mainCamera, self._goFullscreen.transform.position)
		self._beginDragPos = self._goRoot.transform.localPosition
	end

	function Rouge2_NormalLayerMapEditorView:_onDrag(param, pointerEventData)
		if not self._dragBeginPosX then
			return
		end

		local deltaPosX = Rouge2_MapHelper.getWorldPos(pointerEventData.position, self._mainCamera, self._goFullscreen.transform.position) - self._dragBeginPosX
		local mapPosX = deltaPosX + self._beginDragPos.x

		self:setMapPos(mapPosX)
	end

	function Rouge2_NormalLayerMapEditorView:_onDragEnd()
		self._isDraging = false
	end

	function Rouge2_NormalLayerMapEditorView:_editableInitView()
		self._nodeItemTab = self:getUserDataTb_()
		self._mainCamera = CameraMgr.instance:getMainCamera()
		self._isDraging = false
	end

	function Rouge2_NormalLayerMapEditorView:onOpen()
		self:initOptions()
		self:initScene()
		self:initNodeCanvas()

		self._maxNodeNumOneCol = SelectColNum[1]

		local firstLayerId = self._layerIdList[1]

		self:loadMap(firstLayerId)
	end

	function Rouge2_NormalLayerMapEditorView:initOptions()
		self._layerIdList = {}
		self._layerStrList = {}
		self._layerId2MapRes = {}

		for _, layerCo in ipairs(lua_rouge2_layer.configList) do
			table.insert(self._layerIdList, layerCo.id)
			table.insert(self._layerStrList, string.format("%s#%s", layerCo.id, layerCo.name))

			local mapResList = GameUtil.splitString2(layerCo.mapRes)
			local firstMapInfo = mapResList and mapResList[1]

			self._layerId2MapRes[layerCo.id] = firstMapInfo and firstMapInfo[2]
		end

		self._dropMap:ClearOptions()
		self._dropMap:AddOptions(self._layerStrList)

		self._selectColNumStrList = {}

		for _, colNum in ipairs(SelectColNum) do
			table.insert(self._selectColNumStrList, string.format("%s个", colNum))
		end

		self._dropRow:ClearOptions()
		self._dropRow:AddOptions(self._selectColNumStrList)
	end

	function Rouge2_NormalLayerMapEditorView:initScene()
		self._sceneGo = CameraMgr.instance:getSceneRoot()
		self._goEditorRoot = gohelper.create3d(self._sceneGo, "rouge2_editor")

		transformhelper.setLocalPos(self._goEditorRoot.transform, 0, 0, 0)

		self._goRoot = gohelper.create3d(self._goEditorRoot, "root")
		self._goMapRoot = gohelper.create3d(self._goRoot, "maproot")
		self._goIconRoot = gohelper.create3d(self._goRoot, "iconroot")
		self._loader = PrefabInstantiate.Create(self._goMapRoot)

		transformhelper.setLocalPos(self._goMapRoot.transform, 0, 0, 0)
		transformhelper.setLocalPos(self._goIconRoot.transform, 0, 0, 0)
		transformhelper.setLocalScale(self._goMapRoot.transform, Scale.x, Scale.y, Scale.z)
	end

	function Rouge2_NormalLayerMapEditorView:initNodeCanvas()
		self._goCanvas = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._goIconRoot, "NodeCanvas")

		transformhelper.setLocalScale(self._goCanvas.transform, 0.01 * Scale.x, 0.01 * Scale.y, 0.01 * Scale.z)

		self._goLayerNodeContainer = gohelper.findChild(self._goCanvas, "#go_LayerNodeContainer")
		self._tranLayerNodeContainer = self._goLayerNodeContainer.transform
		self._goNodeItem = gohelper.findChild(self._goLayerNodeContainer, "#go_NodeItem")

		gohelper.setActive(self._goNodeItem, false)

		self._canvas = self._goCanvas:GetComponent("Canvas")
		self._canvas.worldCamera = CameraMgr.instance:getMainCamera()
	end

	function Rouge2_NormalLayerMapEditorView:loadMap(layerId)
		local mapRes = self._layerId2MapRes[layerId]

		if string.nilorempty(mapRes) then
			logError(string.format("肉鸽地图资源配置为空! layerId = %s", layerId))

			return
		end

		self._curLayerId = layerId

		self:destroyOldMap()
		self:initNodeInfo()
		self._loader:startLoad(mapRes, self._loadDoneCallback, self)
	end

	function Rouge2_NormalLayerMapEditorView:destroyOldMap()
		if gohelper.isNil(self._goMap) then
			return
		end

		gohelper.destroy(self._goMap)

		self._goMap = nil
	end

	function Rouge2_NormalLayerMapEditorView:_loadDoneCallback(loader)
		self._goMap = loader:getInstGO()

		if gohelper.isNil(self._goMap) then
			return
		end

		self:initMapInfo()
		self:initMapMoveRange()
		self:initNodeList()
	end

	function Rouge2_NormalLayerMapEditorView:initMapInfo()
		local sizeGo = gohelper.findChild(self._goMap, "root/size")
		local boxCollider = sizeGo:GetComponent(typeof(UnityEngine.BoxCollider))

		self._mapSize = boxCollider.size
	end

	function Rouge2_NormalLayerMapEditorView:initNodeInfo()
		self._selectNodeMap = {}
		self._selectNodeList = Rouge2_MapConfig.instance:getCellPosList(self._curLayerId, self._maxNodeNumOneCol) or {}

		for _, nodeInfo in ipairs(self._selectNodeList) do
			local row = nodeInfo[1]
			local col = nodeInfo[2]

			self._selectNodeMap[row] = self._selectNodeMap[row] or {}
			self._selectNodeMap[row][col] = true
		end
	end

	function Rouge2_NormalLayerMapEditorView:initNodeList()
		self._rowNum = math.floor(self._mapSize.y / CellSize.y)
		self._colNum = math.floor(self._mapSize.x / CellSize.x)

		local useIndex = 0

		for i = 1, self._rowNum do
			for j = 1, self._colNum do
				useIndex = useIndex + 1

				self:initNode(useIndex, i, j)
			end
		end

		for i = useIndex + 1, #self._nodeItemTab do
			local nodeItem = self._nodeItemTab[i]

			gohelper.setActive(nodeItem.go, false)
		end

		self:refreshAllNodeLayer()
	end

	function Rouge2_NormalLayerMapEditorView:initNode(index, row, col)
		local nodePosX = self._startPos.x + (col - 1) * CellSize.x * Scale.x
		local nodePosY = self._startPos.y - (row - 1) * CellSize.y * Scale.y
		local nodePosZ = self._startPos.z * Scale.z
		local nodeItem = self:getOrCreateNode(index)

		nodeItem.row = row
		nodeItem.col = col
		nodeItem.txtpos.text = string.format("(%s,%s)", row, col)

		local anchorPosX, anchorPosY = recthelper.worldPosToAnchorPosXYZ(nodePosX, nodePosY, nodePosZ, self._tranLayerNodeContainer, self._mainCamera, self._mainCamera)

		recthelper.setAnchor(nodeItem.go.transform, anchorPosX, anchorPosY)
		gohelper.setActive(nodeItem.go, true)
		self:refreshNodeColor(nodeItem)
	end

	function Rouge2_NormalLayerMapEditorView:getOrCreateNode(index)
		local nodeItem = self._nodeItemTab[index]

		if not nodeItem then
			nodeItem = self:getUserDataTb_()
			nodeItem.index = index
			nodeItem.row = 0
			nodeItem.col = 0
			nodeItem.go = gohelper.cloneInPlace(self._goNodeItem, index)
			nodeItem.icon = gohelper.findChildImage(nodeItem.go, "image")
			nodeItem.txtpos = gohelper.findChildText(nodeItem.go, "pos")
			nodeItem.txtlayer = gohelper.findChildText(nodeItem.go, "layer")
			nodeItem.btnclick = gohelper.findChildButtonWithAudio(nodeItem.go, "click")

			nodeItem.btnclick:AddClickListener(self._btnClickNode, self, nodeItem)
			recthelper.setSize(nodeItem.go.transform, CellSize.x * 100, CellSize.y * 100)

			self._nodeItemTab[index] = nodeItem
		end

		return nodeItem
	end

	function Rouge2_NormalLayerMapEditorView:_btnClickNode(nodeItem)
		if self._isDraging then
			return
		end

		local isSelect = self:isSelectNode(nodeItem.row, nodeItem.col)

		self:updateNodeInfo(nodeItem.row, nodeItem.col, not isSelect)
		self:refreshNodeColor(nodeItem)
		self:refreshAllNodeLayer()
	end

	function Rouge2_NormalLayerMapEditorView:refreshNodeColor(nodeItem)
		local isSelect = self:isSelectNode(nodeItem.row, nodeItem.col)
		local color = isSelect and "#7CFF00" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(nodeItem.icon, color)
		ZProj.UGUIHelper.SetColorAlpha(nodeItem.icon, 0.5)
	end

	function Rouge2_NormalLayerMapEditorView:isSelectNode(row, col)
		if self._selectNodeMap then
			return self._selectNodeMap and self._selectNodeMap[col] == true
		end
	end

	function Rouge2_NormalLayerMapEditorView:updateNodeInfo(row, col, isSelect)
		self._selectNodeMap[row] = self._selectNodeMap[row] or {}
		self._selectNodeMap[row][col] = isSelect
	end

	function Rouge2_NormalLayerMapEditorView:refreshAllNodeLayer()
		local selectNodeList = self:_getSortSelectNodeList()

		for j = 1, self._colNum do
			for i = 1, self._rowNum do
				local nodeItem = self:getNodeItem(i, j)

				nodeItem.txtlayer.text = ""
			end
		end

		for i, colNodeList in ipairs(selectNodeList) do
			for j, nodeItem in ipairs(colNodeList) do
				nodeItem.txtlayer.text = string.format("%s列%s号", i, j)
			end
		end
	end

	function Rouge2_NormalLayerMapEditorView._sortNode(aNode, bNode)
		if aNode.row ~= bNode.row then
			return aNode.row < bNode.row
		end

		return aNode.col < bNode.col
	end

	function Rouge2_NormalLayerMapEditorView:getNodeItem(row, col)
		local index = (row - 1) * self._colNum + col

		return self._nodeItemTab[index]
	end

	function Rouge2_NormalLayerMapEditorView:initMapMoveRange()
		local canvasGo
		local scale = GameUtil.getAdapterScale()
		local worldcorners = (scale ~= 1 and ViewMgr.instance:getUILayer(UILayerName.Hud) or ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
		local posTL = worldcorners[1] * scale
		local posBR = worldcorners[3] * scale

		self._viewWidth = math.abs(posBR.x - posTL.x)
		self._viewHeight = math.abs(posBR.y - posTL.y)
		self._mapMinX = posTL.x - (self._mapSize.x - self._viewWidth)
		self._mapMaxX = posTL.x

		self:setMapPos(self._mapMaxX)

		local posX, posY, posZ = transformhelper.getPos(self._goMap.transform)

		self._startPos = Vector3(posX, posY, posZ)
	end

	function Rouge2_NormalLayerMapEditorView:setMapPos(mapPosX)
		if mapPosX < self._mapMinX then
			mapPosX = self._mapMinX
		elseif mapPosX > self._mapMaxX then
			mapPosX = self._mapMaxX
		end

		self._curMapPosX = mapPosX

		transformhelper.setLocalPos(self._goRoot.transform, mapPosX, 10.5, 0)
	end

	function Rouge2_NormalLayerMapEditorView:exportNodeInfo()
		local selectNodeList, selectNodeNum = self:_getSortSelectNodeList()
		local selectNodePosList = {}

		for i, colNodeList in ipairs(selectNodeList) do
			for j, nodeItem in ipairs(colNodeList) do
				table.insert(selectNodePosList, string.format("%s#%s", nodeItem.row, nodeItem.col))
			end
		end

		local targetSelectNodeNum = self._maxNodeNumOneCol * PathPointLengthen

		if selectNodeNum ~= targetSelectNodeNum then
			GameFacade.showToastString(string.format("导出失败， 当前选中的格子数量不符合要求！  当前:%s, 目标:%s", selectNodeNum, targetSelectNodeNum))

			return
		end

		local selectNodeStr = table.concat(selectNodePosList, "|")

		ZProj.GameHelper.SetSystemBuffer(selectNodeStr)
		GameFacade.showToastString("导出成功!")
	end

	function Rouge2_NormalLayerMapEditorView:_getSortSelectNodeList()
		local allSelectNodeNum = 0
		local selectNodeNum = 0
		local selectNodeList = {}
		local selectColNodeList = {}

		for j = 1, self._colNum do
			for i = 1, self._rowNum do
				local isSelect = self:isSelectNode(i, j)
				local nodeItem = self:getNodeItem(i, j)

				if isSelect then
					selectNodeNum = selectNodeNum + 1
					allSelectNodeNum = allSelectNodeNum + 1
				end

				if selectNodeNum > self._maxNodeNumOneCol then
					selectNodeNum = 1

					table.sort(selectNodeList, self._sortNode)
					table.insert(selectColNodeList, selectNodeList)

					selectNodeList = {}
				end

				if isSelect then
					table.insert(selectNodeList, nodeItem)
				end
			end
		end

		if #selectNodeList > 0 then
			table.sort(selectNodeList, self._sortNode)
			table.insert(selectColNodeList, selectNodeList)
		end

		return selectColNodeList, allSelectNodeNum
	end

	function Rouge2_NormalLayerMapEditorView:onDestroyView()
		gohelper.destroy(self._goEditorRoot)

		if self._nodeItemTab ~= nil then
			for _, nodeItem in pairs(self._nodeItemTab) do
				nodeItem.btnclick:RemoveClickListener()
			end
		end
	end

	return Rouge2_NormalLayerMapEditorView
end
