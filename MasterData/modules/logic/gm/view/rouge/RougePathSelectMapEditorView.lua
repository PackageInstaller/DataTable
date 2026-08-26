-- chunkname: @modules/logic/gm/view/rouge/RougePathSelectMapEditorView.lua

module("modules.logic.gm.view.rouge.RougePathSelectMapEditorView", package.seeall)

local RougePathSelectMapEditorView = class("RougePathSelectMapEditorView", BaseView)

function RougePathSelectMapEditorView:onInitView()
	self._gotop = gohelper.findChild(self.viewGO, "#go_top")
	self._gocamera = gohelper.findChild(self.viewGO, "#go_top/#go_camera")
	self._btncamerareduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#go_camera/#btn_reduce")
	self._inputcamera = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top/#go_camera/#input_camera")
	self._btncameraadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#go_camera/#btn_add")
	self._btnFocusPosXReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#go_focusposX/#btn_reduce")
	self._inputFocusPosX = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top/#go_focusposX/#input_posX")
	self._btnFocusPosXAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#go_focusposX/#btn_add")
	self._btnFocusPosYReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#go_focusposY/#btn_reduce")
	self._inputFocusPosY = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top/#go_focusposY/#input_posY")
	self._btnFocusPosYAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top/#go_focusposY/#btn_add")
	self._btnStartPosXReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposX/#btn_reduce")
	self._inputStartPosX = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top1/#go_startposX/#input_posX")
	self._btnStartPosXAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposX/#btn_add")
	self._btnStartPosYReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposY/#btn_reduce")
	self._inputStartPosY = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top1/#go_startposY/#input_posY")
	self._btnStartPosYAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposY/#btn_add")
	self._btnEndPosXReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_endposX/#btn_reduce")
	self._inputEndPosX = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top1/#go_endposX/#input_posX")
	self._btnEndPosXAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_endposX/#btn_add")
	self._btnEndPosYReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_endposY/#btn_reduce")
	self._inputEndPosY = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top1/#go_endposY/#input_posY")
	self._btnEndPosYAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_endposY/#btn_add")
	self._btnSelectLinePosXReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineposX/#btn_reduce")
	self._inputSelectLinePosX = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top2/#go_lineposX/#input_posX")
	self._btnSelectLinePosXAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineposX/#btn_add")
	self._btnSelectLinePosYReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineposY/#btn_reduce")
	self._inputSelectLinePosY = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top2/#go_lineposY/#input_posY")
	self._btnSelectLinePosYAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineposY/#btn_add")
	self._btnLineIconPosXReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineiconposX/#btn_reduce")
	self._inputLineIconPosX = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top2/#go_lineiconposX/#input_posX")
	self._btnLineIconPosXAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineiconposX/#btn_add")
	self._btnLineIconPosYReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineiconposY/#btn_reduce")
	self._inputLineIconPosY = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top2/#go_lineiconposY/#input_posY")
	self._btnLineIconPosYAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top2/#go_lineiconposY/#btn_add")
	self.dropMap = gohelper.findChildDropdown(self.viewGO, "#go_top/#go_dropmap/#drop_map")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougePathSelectMapEditorView:addEvents()
	self._btncamerareduce:AddClickListener(self.onClickCameraReduceBtn, self)
	self._btncameraadd:AddClickListener(self.onClickCameraAddBtn, self)
	self._inputcamera:AddOnValueChanged(self.onCameraValueChange, self)
	self._btnFocusPosXReduce:AddClickListener(self.onClickFocusPosXReduceBtn, self)
	self._btnFocusPosXAdd:AddClickListener(self.onClickFocusPosXAddBtn, self)
	self._inputFocusPosX:AddOnValueChanged(self.onInputFocusPosXChange, self)
	self._btnFocusPosYReduce:AddClickListener(self.onClickFocusPosYReduceBtn, self)
	self._btnFocusPosYAdd:AddClickListener(self.onClickFocusPosYAddBtn, self)
	self._inputFocusPosY:AddOnValueChanged(self.onInputFocusPosYChange, self)
	self._btnStartPosXReduce:AddClickListener(self.onClickStartPosXReduceBtn, self)
	self._btnStartPosXAdd:AddClickListener(self.onClickStartPosXAddBtn, self)
	self._inputStartPosX:AddOnValueChanged(self.onInputStartPosXChange, self)
	self._btnStartPosYReduce:AddClickListener(self.onClickStartPosYReduceBtn, self)
	self._btnStartPosYAdd:AddClickListener(self.onClickStartPosYAddBtn, self)
	self._inputStartPosY:AddOnValueChanged(self.onInputStartPosYChange, self)
	self._btnEndPosXReduce:AddClickListener(self.onClickEndPosXReduceBtn, self)
	self._btnEndPosXAdd:AddClickListener(self.onClickEndPosXAddBtn, self)
	self._inputEndPosX:AddOnValueChanged(self.onInputEndPosXChange, self)
	self._btnEndPosYReduce:AddClickListener(self.onClickEndPosYReduceBtn, self)
	self._btnEndPosYAdd:AddClickListener(self.onClickEndPosYAddBtn, self)
	self._inputEndPosY:AddOnValueChanged(self.onInputEndPosYChange, self)
	self._btnSelectLinePosXReduce:AddClickListener(self.onClickLinePosXReduceBtn, self)
	self._btnSelectLinePosXAdd:AddClickListener(self.onClickLinePosXAddBtn, self)
	self._inputSelectLinePosX:AddOnValueChanged(self.onInputSelectLinePosXChange, self)
	self._btnSelectLinePosYReduce:AddClickListener(self.onClickLinePosYReduceBtn, self)
	self._btnSelectLinePosYAdd:AddClickListener(self.onClickLinePosYAddBtn, self)
	self._inputSelectLinePosY:AddOnValueChanged(self.onInputSelectLinePosYChange, self)
	self._btnLineIconPosXReduce:AddClickListener(self.onClickLineIconXReduceBtn, self)
	self._btnLineIconPosXAdd:AddClickListener(self.onClickLineIconXAddBtn, self)
	self._inputLineIconPosX:AddOnValueChanged(self.onInputLineIconPosXChange, self)
	self._btnLineIconPosYReduce:AddClickListener(self.onClickLineIconYReduceBtn, self)
	self._btnLineIconPosYAdd:AddClickListener(self.onClickLineIconYAddBtn, self)
	self._inputLineIconPosY:AddOnValueChanged(self.onInputLineIconPosYChange, self)
	self.dropMap:AddOnValueChanged(self.onDropMapValueChanged, self)
end

function RougePathSelectMapEditorView:removeEvents()
	self._btncamerareduce:RemoveClickListener()
	self._btncameraadd:RemoveClickListener()
	self._inputcamera:RemoveOnValueChanged()
	self._btnFocusPosXReduce:RemoveClickListener()
	self._btnFocusPosXAdd:RemoveClickListener()
	self._btnFocusPosYReduce:RemoveClickListener()
	self._btnFocusPosYAdd:RemoveClickListener()
	self._inputFocusPosX:RemoveOnValueChanged()
	self._inputFocusPosY:RemoveOnValueChanged()
	self._btnStartPosXReduce:RemoveClickListener()
	self._btnStartPosXAdd:RemoveClickListener()
	self._btnStartPosYReduce:RemoveClickListener()
	self._btnStartPosYAdd:RemoveClickListener()
	self._inputStartPosX:RemoveOnValueChanged()
	self._inputStartPosY:RemoveOnValueChanged()
	self._btnEndPosXReduce:RemoveClickListener()
	self._btnEndPosXAdd:RemoveClickListener()
	self._btnEndPosYReduce:RemoveClickListener()
	self._btnEndPosYAdd:RemoveClickListener()
	self._inputEndPosX:RemoveOnValueChanged()
	self._inputEndPosY:RemoveOnValueChanged()
	self._btnSelectLinePosXReduce:RemoveClickListener()
	self._btnSelectLinePosXAdd:RemoveClickListener()
	self._btnSelectLinePosYReduce:RemoveClickListener()
	self._btnSelectLinePosYAdd:RemoveClickListener()
	self._inputSelectLinePosX:RemoveOnValueChanged()
	self._inputSelectLinePosY:RemoveOnValueChanged()
	self._btnLineIconPosXReduce:RemoveClickListener()
	self._btnLineIconPosXAdd:RemoveClickListener()
	self._btnLineIconPosYReduce:RemoveClickListener()
	self._btnLineIconPosYAdd:RemoveClickListener()
	self._inputLineIconPosX:RemoveOnValueChanged()
	self._inputLineIconPosY:RemoveOnValueChanged()
	self.dropMap:RemoveOnValueChanged()
end

function RougePathSelectMapEditorView:onDropMapValueChanged(index)
	if self.switchLayering then
		self.dropMap:SetValue(self.curLayerIndex - 1)

		return
	end

	local layerId = self.layerIdList[index + 1]

	if layerId == self.curLayerId then
		return
	end

	local nextLayerList = RougeMapConfig.instance:getNextLayerList(layerId)

	if not nextLayerList then
		self.dropMap:SetValue(self.curLayerIndex - 1)
		GameFacade.showToastString(layerId .. " 层 没有下一层 ")

		return
	end

	self.switchLayering = true
	self.curLayerIndex = index + 1
	self.curLayerId = layerId

	RougeMapModel.instance:updateMapInfo({
		mapType = RougeMapEnum.MapType.Middle,
		middleLayerInfo = {
			layerId = 101,
			positionIndex = RougeMapEnum.PathSelectIndex,
			middleLayerId = layerId
		},
		HasField = function()
			return false
		end
	})
end

function RougePathSelectMapEditorView:onPathSelectMapFocusDone()
	self.switchLayering = false

	ViewMgr.instance:openView(self.viewName, nil, true)

	self.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	self.map = RougeMapController.instance:getMapComp()
	self.mapViewGo = ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO

	self:initPos()
end

function RougePathSelectMapEditorView:onClickCameraReduceBtn()
	self.cameraSize = self.cameraSize - RougePathSelectMapEditorView.Interval

	self:onCameraSizeChange()
end

function RougePathSelectMapEditorView:onClickCameraAddBtn()
	self.cameraSize = self.cameraSize + RougePathSelectMapEditorView.Interval

	self:onCameraSizeChange()
end

function RougePathSelectMapEditorView:onCameraValueChange(value)
	self.cameraSize = value

	self:onCameraSizeChange()
end

function RougePathSelectMapEditorView:onClickFocusPosXReduceBtn()
	self.focusPosX = self.focusPosX + RougePathSelectMapEditorView.Interval

	self:onFocusPosChange()
end

function RougePathSelectMapEditorView:onClickFocusPosXAddBtn()
	self.focusPosX = self.focusPosX - RougePathSelectMapEditorView.Interval

	self:onFocusPosChange()
end

function RougePathSelectMapEditorView:onClickFocusPosYReduceBtn()
	self.focusPosY = self.focusPosY + RougePathSelectMapEditorView.Interval

	self:onFocusPosChange()
end

function RougePathSelectMapEditorView:onClickFocusPosYAddBtn()
	self.focusPosY = self.focusPosY - RougePathSelectMapEditorView.Interval

	self:onFocusPosChange()
end

function RougePathSelectMapEditorView:onInputFocusPosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.focusPosX = value

	self:onFocusPosChange()
end

function RougePathSelectMapEditorView:onInputFocusPosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.focusPosY = value

	self:onFocusPosChange()
end

function RougePathSelectMapEditorView:onClickStartPosXReduceBtn()
	self.startPosX = self.startPosX + RougePathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function RougePathSelectMapEditorView:onClickStartPosXAddBtn()
	self.startPosX = self.startPosX - RougePathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function RougePathSelectMapEditorView:onClickStartPosYReduceBtn()
	self.startPosY = self.startPosY + RougePathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function RougePathSelectMapEditorView:onClickStartPosYAddBtn()
	self.startPosY = self.startPosY - RougePathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function RougePathSelectMapEditorView:onInputStartPosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.startPosX = value

	self:onStartPosChange()
end

function RougePathSelectMapEditorView:onInputStartPosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.startPosY = value

	self:onStartPosChange()
end

function RougePathSelectMapEditorView:onClickEndPosXReduceBtn()
	self.endPosX = self.endPosX + RougePathSelectMapEditorView.Interval

	self:onEndPosChange()
end

function RougePathSelectMapEditorView:onClickEndPosXAddBtn()
	self.endPosX = self.endPosX - RougePathSelectMapEditorView.Interval

	self:onEndPosChange()
end

function RougePathSelectMapEditorView:onClickEndPosYReduceBtn()
	self.endPosY = self.endPosY + RougePathSelectMapEditorView.Interval

	self:onEndPosChange()
end

function RougePathSelectMapEditorView:onClickEndPosYAddBtn()
	self.endPosY = self.endPosY - RougePathSelectMapEditorView.Interval

	self:onEndPosChange()
end

function RougePathSelectMapEditorView:onInputEndPosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.endPosX = value

	self:onEndPosChange()
end

function RougePathSelectMapEditorView:onInputEndPosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.endPosY = value

	self:onEndPosChange()
end

function RougePathSelectMapEditorView:onClickLinePosXReduceBtn()
	self.linePosX = self.linePosX + RougePathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function RougePathSelectMapEditorView:onClickLinePosXAddBtn()
	self.linePosX = self.linePosX - RougePathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function RougePathSelectMapEditorView:onClickLinePosYReduceBtn()
	self.linePosY = self.linePosY + RougePathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function RougePathSelectMapEditorView:onClickLinePosYAddBtn()
	self.linePosY = self.linePosY - RougePathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function RougePathSelectMapEditorView:onInputSelectLinePosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.linePosX = value

	self:onSelectLinePosChange()
end

function RougePathSelectMapEditorView:onInputSelectLinePosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.linePosY = value

	self:onSelectLinePosChange()
end

function RougePathSelectMapEditorView:onClickLineIconXReduceBtn()
	self.lineIconPosX = self.lineIconPosX + RougePathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function RougePathSelectMapEditorView:onClickLineIconXAddBtn()
	self.lineIconPosX = self.lineIconPosX - RougePathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function RougePathSelectMapEditorView:onClickLineIconYReduceBtn()
	self.lineIconPosY = self.lineIconPosY + RougePathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function RougePathSelectMapEditorView:onClickLineIconYAddBtn()
	self.lineIconPosY = self.lineIconPosY - RougePathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function RougePathSelectMapEditorView:onInputLineIconPosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.lineIconPosX = value

	self:onLineIconPosChange()
end

function RougePathSelectMapEditorView:onInputLineIconPosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.lineIconPosY = value

	self:onLineIconPosChange()
end

RougePathSelectMapEditorView.Interval = 0.01

function RougePathSelectMapEditorView:onOpen()
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, self.onPathSelectMapFocusDone, self, LuaEventSystem.Low)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectLayerChange, self.onSelectLayerChange, self, LuaEventSystem.Low)

	self.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	self.map = RougeMapController.instance:getMapComp()
	self.mapViewGo = ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO

	self:initPos()
	self:initLayerDrop()
end

function RougePathSelectMapEditorView:initPos()
	self:initCamera()
	self:initFocusPos()
	self:initStartPos()
	self:initEndPos()
	self:initSelectLinePos()
	self:initLineIconPos()
end

function RougePathSelectMapEditorView:onSelectLayerChange(layerId)
	self:initSelectLinePos()
	self:initLineIconPos()
end

function RougePathSelectMapEditorView:initCamera()
	self.cameraSize = self.pathSelectCo.focusCameraSize
	self.camera = CameraMgr.instance:getMainCamera()

	self:onCameraSizeChange()
end

function RougePathSelectMapEditorView:onCameraSizeChange()
	self.camera.orthographicSize = self.cameraSize

	self._inputcamera:SetText(self.cameraSize)
end

function RougePathSelectMapEditorView:initFocusPos()
	self.focusPosX, self.focusPosY = RougeMapHelper.getPos(self.pathSelectCo.focusMapPos)
	self.mapTransform = self.map.mapTransform

	self:onFocusPosChange()
end

function RougePathSelectMapEditorView:onFocusPosChange()
	transformhelper.setLocalPos(self.mapTransform, self.focusPosX, self.focusPosY, RougeMapEnum.OffsetZ.Map)
	self._inputFocusPosX:SetText(self.focusPosX)
	self._inputFocusPosY:SetText(self.focusPosY)
end

function RougePathSelectMapEditorView:initStartPos()
	self.startPosX, self.startPosY = RougeMapHelper.getPos(self.pathSelectCo.startPos)

	local goStart = gohelper.findChild(self.mapViewGo, "#go_linecontainer/#go_start")

	self.rectTrStart = goStart:GetComponent(gohelper.Type_RectTransform)

	self:onStartPosChange()
end

function RougePathSelectMapEditorView:onStartPosChange()
	recthelper.setAnchor(self.rectTrStart, self.startPosX, self.startPosY)
	self._inputStartPosX:SetText(self.startPosX)
	self._inputStartPosY:SetText(self.startPosY)
end

function RougePathSelectMapEditorView:initEndPos()
	self.endPosX, self.endPosY = RougeMapHelper.getPos(self.pathSelectCo.endPos)

	local goEnd = gohelper.findChild(self.mapViewGo, "#go_linecontainer/#go_end")

	self.rectTrEnd = goEnd:GetComponent(gohelper.Type_RectTransform)

	self:onEndPosChange()
end

function RougePathSelectMapEditorView:onEndPosChange()
	recthelper.setAnchor(self.rectTrEnd, self.endPosX, self.endPosY)
	self._inputEndPosX:SetText(self.endPosX)
	self._inputEndPosY:SetText(self.endPosY)
end

function RougePathSelectMapEditorView:initSelectLinePos()
	local selectLayerId = RougeMapModel.instance:getSelectLayerId()
	local selectLayerCo = lua_rouge_layer.configDict[selectLayerId]

	self.linePosX, self.linePosY = RougeMapHelper.getPos(selectLayerCo.pathPos)

	local path = string.format("#go_linecontainer/%s/line", selectLayerCo.id)
	local line = gohelper.findChild(self.mapViewGo, path)

	if not line then
		return
	end

	self.rectTrLine = line:GetComponent(gohelper.Type_RectTransform)

	self:onSelectLinePosChange()
end

function RougePathSelectMapEditorView:onSelectLinePosChange()
	self._inputSelectLinePosX:SetText(self.linePosX)
	self._inputSelectLinePosY:SetText(self.linePosY)
	recthelper.setAnchor(self.rectTrLine, self.linePosX, self.linePosY)
end

function RougePathSelectMapEditorView:initLineIconPos()
	local selectLayerId = RougeMapModel.instance:getSelectLayerId()
	local selectLayerCo = lua_rouge_layer.configDict[selectLayerId]

	self.lineIconPosX, self.lineIconPosY = RougeMapHelper.getPos(selectLayerCo.iconPos)

	local linePath = string.format("#go_linecontainer/%s/lineIcon", selectLayerCo.id)
	local lineIcon = gohelper.findChild(self.mapViewGo, linePath)

	if not lineIcon then
		return
	end

	self.rectTrLineIcon = lineIcon:GetComponent(gohelper.Type_RectTransform)

	self:onLineIconPosChange()
end

function RougePathSelectMapEditorView:onLineIconPosChange()
	self._inputLineIconPosX:SetText(self.lineIconPosX)
	self._inputLineIconPosY:SetText(self.lineIconPosY)
	recthelper.setAnchor(self.rectTrLineIcon, self.lineIconPosX, self.lineIconPosY)
end

function RougePathSelectMapEditorView:initLayerDrop()
	self.curLayerId = RougeMapModel.instance:getMiddleLayerId()
	self.curLayerIndex = 1
	self.layerIdList = {}
	self.layerStrList = {}

	for index, layerCo in ipairs(lua_rouge_middle_layer.configList) do
		local layerId = layerCo.id

		table.insert(self.layerIdList, layerId)
		table.insert(self.layerStrList, tostring(layerId))

		if layerId == self.curLayerId then
			self.curLayerIndex = index
		end
	end

	self.dropMap:ClearOptions()
	self.dropMap:AddOptions(self.layerStrList)
	self.dropMap:SetValue(self.curLayerIndex - 1)
end

return RougePathSelectMapEditorView
