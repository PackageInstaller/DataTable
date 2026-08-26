-- chunkname: @modules/logic/gm/view/rouge/RougeMapEditorView.lua

module("modules.logic.gm.view.rouge.RougeMapEditorView", package.seeall)

local RougeMapEditorView = class("RougeMapEditorView", BaseView)

function RougeMapEditorView:onInitView()
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

function RougeMapEditorView:addEvents()
	self.btnExit:AddClickListener(self.onClickExit, self)
	self.btnGenerateNode:AddClickListener(self.onClickGenerateNode, self)
	self.btnGeneratePathNode:AddClickListener(self.onClickGeneratePathNode, self)
	self.btnGenerateLeaveNode:AddClickListener(self.onClickGenerateLeaveNode, self)
	self.btnGeneratePath:AddClickListener(self.onClickGeneratePath, self)
	self.btnShowPath:AddClickListener(self.onClickShowPath, self)
	self.dropMap:AddOnValueChanged(self.onDropMapValueChanged, self)
end

function RougeMapEditorView:removeEvents()
	self.btnExit:RemoveClickListener()
	self.btnGenerateNode:RemoveClickListener()
	self.btnGeneratePathNode:RemoveClickListener()
	self.btnGenerateLeaveNode:RemoveClickListener()
	self.btnGeneratePath:RemoveClickListener()
	self.btnShowPath:RemoveClickListener()
	self.dropMap:RemoveOnValueChanged()
end

function RougeMapEditorView:onClickShowPath()
	local start = tonumber(self.inputStart:GetText())
	local endPos = tonumber(self.inputEnd:GetText())

	if not start or not endPos then
		return
	end

	local list = {}
	local pathDict = RougeMapEditModel.instance:getLineDict()

	RougeMapConfig.instance:getPathIndexList(pathDict, start, endPos, list)

	if GameUtil.tabletool_dictIsEmpty(list) then
		GameFacade.showToastString("没找到路径")

		return
	end

	local str = table.concat(list, " -> ")

	logError(str)
	GameFacade.showToastString(str)
end

function RougeMapEditorView:onDropMapValueChanged(index)
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

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onLoadMapDone, self.onSwitchDone, self)

	local scene = GameSceneMgr.instance:getCurScene()
	local map = scene.map

	RougeMapEditModel.instance:init(layerId)
	map:switchMap()
end

function RougeMapEditorView:onSwitchDone()
	self.switchLayering = false

	ViewMgr.instance:openView(self.viewName)
end

function RougeMapEditorView:onClickExit()
	self:closeThis()
end

function RougeMapEditorView:onClickGenerateNode()
	if self.switchLayering then
		return
	end

	RougeMapEditModel.instance:generateNodeConfig()
end

function RougeMapEditorView:onClickGeneratePathNode()
	if self.switchLayering then
		return
	end

	RougeMapEditModel.instance:generatePathNodeConfig()
end

function RougeMapEditorView:onClickGenerateLeaveNode()
	if self.switchLayering then
		return
	end

	local leavePos = RougeMapEditModel.instance:getLeavePos()

	if not leavePos then
		GameFacade.showToastString("未生成离开点。")

		return
	end

	RougeMapEditModel.instance:generateLeaveNodeConfig()
end

function RougeMapEditorView:onClickGeneratePath()
	if self.switchLayering then
		return
	end

	RougeMapEditModel.instance:generateNodePath()
end

function RougeMapEditorView:_editableInitView()
	self.camera = CameraMgr.instance:getMainCamera()
	self.offsetZ = RougeMapEnum.OffsetZ.NodeContainer
	self.map = RougeMapController.instance:getMapComp()
	self.frameHandle = UpdateBeat:CreateListener(self.onFrame, self)

	UpdateBeat:AddListener(self.frameHandle)
	gohelper.setActive(self.goStartText, false)

	self.rectTrView = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.textGoList = self:getUserDataTb_()

	self:initDrop()
end

function RougeMapEditorView:initDrop()
	self.layerIdList = {}
	self.layerStrList = {}

	for _, layerCo in ipairs(lua_rouge_middle_layer.configList) do
		table.insert(self.layerIdList, layerCo.id)
		table.insert(self.layerStrList, tostring(layerCo.id))
	end

	self.dropMap:ClearOptions()
	self.dropMap:AddOptions(self.layerStrList)

	self.layerId = RougeMapEditModel.instance:getMiddleLayerId()

	for index, layerId in ipairs(self.layerIdList) do
		if layerId == self.layerId then
			self.dropMap:SetValue(index - 1)
		end
	end
end

function RougeMapEditorView:onUpdateParam()
	self.map = RougeMapController.instance:getMapComp()

	self:refreshAllText()
end

function RougeMapEditorView:onOpen()
	self:refreshAllText()
end

function RougeMapEditorView:refreshAllText()
	local pointDict = RougeMapEditModel.instance:getPointsDict()
	local pathPointDict = RougeMapEditModel.instance:getPathPointsDict()
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

function RougeMapEditorView:refreshPointDictText(pointDict, pre, index)
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

function RougeMapEditorView:onFrame()
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

function RougeMapEditorView:createPoint()
	if self.editLining then
		return
	end

	local scenePos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id = RougeMapEditModel.instance:getPointByPos(scenePos)

	if id then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	self.map:addPoint(scenePos)
	self:refreshAllText()
end

function RougeMapEditorView:createPathPoint()
	if self.editLining then
		return
	end

	local scenePos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id = RougeMapEditModel.instance:getPointByPos(scenePos)

	if id then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	self.map:addPathPoint(scenePos)
	self:refreshAllText()
end

function RougeMapEditorView:createLeavePoint()
	if self.editLining then
		return
	end

	local scenePos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id = RougeMapEditModel.instance:getPointByPos(scenePos)

	if id then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	self.map:addLeavePoint(scenePos)
end

function RougeMapEditorView:deletePoint()
	if self.editLining then
		return
	end

	local scenePos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id, type = RougeMapEditModel.instance:getPointByPos(scenePos)

	if id then
		self.map:deletePoint(type, id)
		self:refreshAllText()
	end
end

function RougeMapEditorView:startDrag()
	if not self.draggingId then
		local scenePos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
		local id, type = RougeMapEditModel.instance:getPointByPos(scenePos)

		if not id then
			return
		end

		self.draggingId = id
		self.draggingType = type
	end
end

function RougeMapEditorView:dragPoint()
	if not self.draggingId then
		return
	end

	local scenePos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)

	self.map:setPointPos(self.draggingId, self.draggingType, scenePos.x, scenePos.y)
	self:refreshAllText()
end

function RougeMapEditorView:startEditLine()
	local scenePos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)
	local id, type = RougeMapEditModel.instance:getPointByPos(scenePos)

	if not id then
		return
	end

	if self.editLining then
		if self.startType == type and self.startPointId == id then
			return
		end

		if not RougeMapEditModel.instance:checkCanAddLine(self.startType, self.startPointId, type, id) then
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

function RougeMapEditorView:exitEditLine()
	self.map:exitEditLine()

	self.editLining = false
	self.startPointId = nil
end

function RougeMapEditorView:drawEditingLine()
	if not self.editLining then
		return
	end

	local endPos = RougeMapHelper.getScenePos(self.camera, UnityEngine.Input.mousePosition, self.offsetZ)

	self.map:updateDrawingLine(endPos)
end

function RougeMapEditorView:onClose()
	if self.frameHandle then
		UpdateBeat:RemoveListener(self.frameHandle)

		self.frameHandle = nil
	end
end

function RougeMapEditorView:onDestroyView()
	return
end

return RougeMapEditorView
