-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_MapEditorView.lua

module("modules.logic.gm.view.rouge2.Rouge2_MapEditorView", package.seeall)

local Rouge2_MapEditorView = class("Rouge2_MapEditorView", BaseView)

function Rouge2_MapEditorView:onInitView()
	self.btnExit = gohelper.findChildButton(self.viewGO, "left_tool/#btn_exit")
	self.btnGenerateNode = gohelper.findChildButton(self.viewGO, "left_tool/#btn_generatenode")
	self.btnGeneratePathNode = gohelper.findChildButton(self.viewGO, "left_tool/#btn_generatepathnode")
	self.btnGenerateLeaveNode = gohelper.findChildButton(self.viewGO, "left_tool/#btn_generateleavenode")
	self.btnGeneratePath = gohelper.findChildButton(self.viewGO, "left_tool/#btn_generatepath")
	self.dropMap = gohelper.findChildDropdown(self.viewGO, "left_tool/#drop_map")
	self.goStartTextContainer = gohelper.findChild(self.viewGO, "textcontainer")
	self.goStartText = gohelper.findChild(self.viewGO, "textcontainer/startText")
	self.btnShowPath = gohelper.findChildButton(self.viewGO, "left_tool/#btn_showpath")
	self.inputStart = gohelper.findChildTextMeshInputField(self.viewGO, "left_tool/inputpathpoint/#input_start")
	self.inputEnd = gohelper.findChildTextMeshInputField(self.viewGO, "left_tool/inputpathpoint/#input_end")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapEditorView:addEvents()
	self.btnExit:AddClickListener(self.onClickExit, self)
	self.btnGenerateNode:AddClickListener(self.onClickGenerateNode, self)
	self.btnGeneratePathNode:AddClickListener(self.onClickGeneratePathNode, self)
	self.btnGenerateLeaveNode:AddClickListener(self.onClickGenerateLeaveNode, self)
	self.btnGeneratePath:AddClickListener(self.onClickGeneratePath, self)
	self.btnShowPath:AddClickListener(self.onClickShowPath, self)
	self.dropMap:AddOnValueChanged(self.onDropMapValueChanged, self)
end

function Rouge2_MapEditorView:removeEvents()
	self.btnExit:RemoveClickListener()
	self.btnGenerateNode:RemoveClickListener()
	self.btnGeneratePathNode:RemoveClickListener()
	self.btnGenerateLeaveNode:RemoveClickListener()
	self.btnGeneratePath:RemoveClickListener()
	self.btnShowPath:RemoveClickListener()
	self.dropMap:RemoveOnValueChanged()
end

function Rouge2_MapEditorView:onClickShowPath()
	local start = tonumber(self.inputStart:GetText())
	local endPos = tonumber(self.inputEnd:GetText())

	if not start or not endPos then
		return
	end

	local list = {}
	local pathDict = Rouge2_MapEditModel.instance:getLineDict()

	Rouge2_MapConfig.instance:getPathIndexList(pathDict, start, endPos, list)

	if GameUtil.tabletool_dictIsEmpty(list) then
		GameFacade.showToastString("没找到路径")

		return
	end

	local str = table.concat(list, " -> ")

	logError(str)
	GameFacade.showToastString(str)
end

function Rouge2_MapEditorView:onDropMapValueChanged(index)
	if self.switchLayering then
		self.dropMap:SetValue(self.layerIndex - 1)

		return
	end

	local layerId = self.layerIdList[index + 1]

	if layerId == self.layerId then
		return
	end

	self.switchLayering = true
	self.layerIndex = index + 1
	self.layerId = layerId

	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onLoadMapDone, self.onSwitchDone, self)

	local scene = GameSceneMgr.instance:getCurScene()
	local map = scene.map

	Rouge2_MapEditModel.instance:init(layerId)
	map:switchMap()
end

function Rouge2_MapEditorView:onSwitchDone()
	self.switchLayering = false

	ViewMgr.instance:openView(self.viewName)
end

function Rouge2_MapEditorView:onClickExit()
	self:closeThis()
end

function Rouge2_MapEditorView:onClickGenerateNode()
	if self.switchLayering then
		return
	end

	Rouge2_MapEditModel.instance:generateNodeConfig()
end

function Rouge2_MapEditorView:onClickGeneratePathNode()
	if self.switchLayering then
		return
	end

	Rouge2_MapEditModel.instance:generatePathNodeConfig()
end

function Rouge2_MapEditorView:onClickGenerateLeaveNode()
	if self.switchLayering then
		return
	end

	local leavePos = Rouge2_MapEditModel.instance:getLeavePos()

	if not leavePos then
		GameFacade.showToastString("未生成离开点。")

		return
	end

	Rouge2_MapEditModel.instance:generateLeaveNodeConfig()
end

function Rouge2_MapEditorView:onClickGeneratePath()
	if self.switchLayering then
		return
	end

	Rouge2_MapEditModel.instance:generateNodePath()
end

function Rouge2_MapEditorView:_editableInitView()
	self.camera = CameraMgr.instance:getMainCamera()
	self.offsetZ = Rouge2_MapEnum.OffsetZ.NodeContainer
	self.map = Rouge2_MapController.instance:getMapComp()
	self.frameHandle = UpdateBeat:CreateListener(self.onFrame, self)

	UpdateBeat:AddListener(self.frameHandle)
	gohelper.setActive(self.goStartText, false)

	self.rectTrView = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.textGoList = self:getUserDataTb_()

	self:initDrop()
end

function Rouge2_MapEditorView:initDrop()
	self.layerIdList = {}
	self.layerStrList = {}

	for _, layerCo in ipairs(lua_rouge2_middle_layer.configList) do
		table.insert(self.layerIdList, layerCo.id)
		table.insert(self.layerStrList, tostring(layerCo.id))
	end

	self.dropMap:ClearOptions()
	self.dropMap:AddOptions(self.layerStrList)

	self.layerId = Rouge2_MapEditModel.instance:getMiddleLayerId()

	for index, layerId in ipairs(self.layerIdList) do
		if layerId == self.layerId then
			self.dropMap:SetValue(index - 1)
		end
	end
end

function Rouge2_MapEditorView:onUpdateParam()
	self.map = Rouge2_MapController.instance:getMapComp()

	self:refreshAllText()
end

function Rouge2_MapEditorView:onOpen()
	self:refreshAllText()
end

function Rouge2_MapEditorView:refreshAllText()
	local pointDict = Rouge2_MapEditModel.instance:getPointsDict()
	local pathPointDict = Rouge2_MapEditModel.instance:getPathPointsDict()
	local isEmpty = GameUtil.tabletool_dictIsEmpty(pointDict) and GameUtil.tabletool_dictIsEmpty(pathPointDict)

	if isEmpty then
		gohelper.setActive(self.goStartTextContainer, false)

		return
	end

	gohelper.setActive(self.goStartTextContainer, true)

	local index = 0

	index = self:refreshPointDictText(pointDict, "坐标点id : ", index)
	index = self:refreshPointDictText(pathPointDict, "路径点id : ", index)

	for i = index + 1, #self.textGoList do
		gohelper.setActive(self.textGoList[i], false)
	end
end

function Rouge2_MapEditorView:refreshPointDictText(pointDict, pre, index)
	for pointId, point in pairs(pointDict) do
		index = index + 1

		local textGo = self.textGoList[index]

		if not textGo then
			textGo = gohelper.cloneInPlace(self.goStartText)

			table.insert(self.textGoList, textGo)
		end

		gohelper.setActive(textGo, true)

		local rectTr = textGo:GetComponent(gohelper.Type_RectTransform)
		local anchorX, anchorY = recthelper.worldPosToAnchorPos2(point, self.rectTrView)

		anchorY = anchorY > 0 and anchorY + 60 or anchorY - 60

		recthelper.setAnchor(rectTr, anchorX, anchorY)

		local text = gohelper.findChildText(textGo, "text")

		text.text = pre .. pointId
	end

	return index
end

function Rouge2_MapEditorView:onFrame()
	if self.switchLayering then
		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Q) then
		self:createPoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.W) then
		self:createPathPoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.R) then
		self:createLeavePoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.E) then
		self:deletePoint()

		return
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		if UnityEngine.Input.GetMouseButtonDown(0) then
			self:startDrag()
		elseif UnityEngine.Input.GetMouseButton(0) then
			self:dragPoint()
		end

		return
	end

	if UnityEngine.Input.GetMouseButtonUp(0) then
		if self.draggingId then
			self.draggingId = nil
		else
			self:startEditLine()
		end

		return
	end

	if UnityEngine.Input.GetMouseButton(1) then
		self:exitEditLine()

		return
	end

	self:drawEditingLine()
end

function Rouge2_MapEditorView:createPoint()
	if self.editLining then
		return
	end

	local scenePos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id = Rouge2_MapEditModel.instance:getPointByPos(scenePos)

	if id then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	self.map:addPoint(scenePos)
	self:refreshAllText()
end

function Rouge2_MapEditorView:createPathPoint()
	if self.editLining then
		return
	end

	local scenePos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id = Rouge2_MapEditModel.instance:getPointByPos(scenePos)

	if id then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	self.map:addPathPoint(scenePos)
	self:refreshAllText()
end

function Rouge2_MapEditorView:createLeavePoint()
	if self.editLining then
		return
	end

	local scenePos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id = Rouge2_MapEditModel.instance:getPointByPos(scenePos)

	if id then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	self.map:addLeavePoint(scenePos)
end

function Rouge2_MapEditorView:deletePoint()
	if self.editLining then
		return
	end

	local scenePos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id, type = Rouge2_MapEditModel.instance:getPointByPos(scenePos)

	if id then
		self.map:deletePoint(type, id)
		self:refreshAllText()
	end
end

function Rouge2_MapEditorView:startDrag()
	if not self.draggingId then
		local scenePos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
		local id, type = Rouge2_MapEditModel.instance:getPointByPos(scenePos)

		if not id then
			return
		end

		self.draggingId = id
		self.draggingType = type
	end
end

function Rouge2_MapEditorView:dragPoint()
	if not self.draggingId then
		return
	end

	local scenePos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)

	self.map:setPointPos(self.draggingId, self.draggingType, scenePos.x, scenePos.y)
	self:refreshAllText()
end

function Rouge2_MapEditorView:startEditLine()
	local scenePos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id, type = Rouge2_MapEditModel.instance:getPointByPos(scenePos)

	if not id then
		return
	end

	if self.editLining then
		if self.startType == type and self.startPointId == id then
			return
		end

		if not Rouge2_MapEditModel.instance:checkCanAddLine(self.startType, self.startPointId, type, id) then
			return
		end

		self.map:addLine(self.startType, self.startPointId, type, id)

		self.editLineGo = nil
		self.editLining = false
		self.startPointId = nil

		return
	end

	self.editLining = true
	self.startPointId = id
	self.startType = type

	self.map:createEditingLine(id, type)
end

function Rouge2_MapEditorView:exitEditLine()
	self.map:exitEditLine()

	self.editLining = false
	self.startPointId = nil
end

function Rouge2_MapEditorView:drawEditingLine()
	if not self.editLining then
		return
	end

	local endPos = Rouge2_MapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)

	self.map:updateDrawingLine(endPos)
end

function Rouge2_MapEditorView:onClose()
	if self.frameHandle then
		UpdateBeat:RemoveListener(self.frameHandle)

		self.frameHandle = nil
	end
end

function Rouge2_MapEditorView:onDestroyView()
	return
end

return Rouge2_MapEditorView
