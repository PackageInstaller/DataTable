-- chunkname: @modules/logic/gm/view/rouge2/Rouge2_PathSelectMapEditorView.lua

module("modules.logic.gm.view.rouge2.Rouge2_PathSelectMapEditorView", package.seeall)

local Rouge2_PathSelectMapEditorView = class("Rouge2_PathSelectMapEditorView", BaseView)

function Rouge2_PathSelectMapEditorView:onInitView()
	self._gotop = gohelper.findChild(self.viewGO, "#go_top")
	self._btnStartPosXReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposX/#btn_reduce")
	self._inputStartPosX = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top1/#go_startposX/#input_posX")
	self._btnStartPosXAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposX/#btn_add")
	self._btnStartPosYReduce = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposY/#btn_reduce")
	self._inputStartPosY = gohelper.findChildTextMeshInputField(self.viewGO, "#go_top1/#go_startposY/#input_posY")
	self._btnStartPosYAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_top1/#go_startposY/#btn_add")
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

function Rouge2_PathSelectMapEditorView:addEvents()
	self._btnStartPosXReduce:AddClickListener(self.onClickStartPosXReduceBtn, self)
	self._btnStartPosXAdd:AddClickListener(self.onClickStartPosXAddBtn, self)
	self._inputStartPosX:AddOnValueChanged(self.onInputStartPosXChange, self)
	self._btnStartPosYReduce:AddClickListener(self.onClickStartPosYReduceBtn, self)
	self._btnStartPosYAdd:AddClickListener(self.onClickStartPosYAddBtn, self)
	self._inputStartPosY:AddOnValueChanged(self.onInputStartPosYChange, self)
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

function Rouge2_PathSelectMapEditorView:removeEvents()
	self._btnStartPosXReduce:RemoveClickListener()
	self._btnStartPosXAdd:RemoveClickListener()
	self._btnStartPosYReduce:RemoveClickListener()
	self._btnStartPosYAdd:RemoveClickListener()
	self._inputStartPosX:RemoveOnValueChanged()
	self._inputStartPosY:RemoveOnValueChanged()
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

function Rouge2_PathSelectMapEditorView:onDropMapValueChanged(index)
	if self.switchLayering then
		self.dropMap:SetValue(self.curLayerIndex - 1)

		return
	end

	local layerId = self.layerIdList[index + 1]

	if layerId == self.curLayerId then
		return
	end

	local nextLayerList = Rouge2_MapConfig.instance:getNextLayerList(layerId)

	if not nextLayerList then
		self.dropMap:SetValue(self.curLayerIndex - 1)
		GameFacade.showToastString(layerId .. " 层 没有下一层 ")

		return
	end

	self.switchLayering = true
	self.curLayerIndex = index + 1
	self.curLayerId = layerId

	Rouge2_MapModel.instance:updateMapInfo({
		mapType = Rouge2_MapEnum.MapType.Middle,
		middleLayerInfo = {
			layerId = 101,
			positionIndex = Rouge2_MapEnum.PathSelectIndex,
			middleLayerId = layerId
		},
		HasField = function()
			return false
		end
	})
end

function Rouge2_PathSelectMapEditorView:onPathSelectMapFocusDone()
	self.switchLayering = false

	ViewMgr.instance:openView(self.viewName, nil, true)

	self.pathSelectCo = Rouge2_MapModel.instance:getPathSelectCo()
	self.map = Rouge2_MapController.instance:getMapComp()
	self.mapViewGo = ViewMgr.instance:getContainer(ViewName.Rouge2_MapView).viewGO

	self:initPos()
end

function Rouge2_PathSelectMapEditorView:onClickStartPosXReduceBtn()
	self.startPosX = self.startPosX + Rouge2_PathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function Rouge2_PathSelectMapEditorView:onClickStartPosXAddBtn()
	self.startPosX = self.startPosX - Rouge2_PathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function Rouge2_PathSelectMapEditorView:onClickStartPosYReduceBtn()
	self.startPosY = self.startPosY + Rouge2_PathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function Rouge2_PathSelectMapEditorView:onClickStartPosYAddBtn()
	self.startPosY = self.startPosY - Rouge2_PathSelectMapEditorView.Interval

	self:onStartPosChange()
end

function Rouge2_PathSelectMapEditorView:onInputStartPosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.startPosX = value

	self:onStartPosChange()
end

function Rouge2_PathSelectMapEditorView:onInputStartPosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.startPosY = value

	self:onStartPosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLinePosXReduceBtn()
	self.linePosX = self.linePosX + Rouge2_PathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLinePosXAddBtn()
	self.linePosX = self.linePosX - Rouge2_PathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLinePosYReduceBtn()
	self.linePosY = self.linePosY + Rouge2_PathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLinePosYAddBtn()
	self.linePosY = self.linePosY - Rouge2_PathSelectMapEditorView.Interval

	self:onSelectLinePosChange()
end

function Rouge2_PathSelectMapEditorView:onInputSelectLinePosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.linePosX = value

	self:onSelectLinePosChange()
end

function Rouge2_PathSelectMapEditorView:onInputSelectLinePosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.linePosY = value

	self:onSelectLinePosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLineIconXReduceBtn()
	self.lineIconPosX = self.lineIconPosX + Rouge2_PathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLineIconXAddBtn()
	self.lineIconPosX = self.lineIconPosX - Rouge2_PathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLineIconYReduceBtn()
	self.lineIconPosY = self.lineIconPosY + Rouge2_PathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function Rouge2_PathSelectMapEditorView:onClickLineIconYAddBtn()
	self.lineIconPosY = self.lineIconPosY - Rouge2_PathSelectMapEditorView.Interval

	self:onLineIconPosChange()
end

function Rouge2_PathSelectMapEditorView:onInputLineIconPosXChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.lineIconPosX = value

	self:onLineIconPosChange()
end

function Rouge2_PathSelectMapEditorView:onInputLineIconPosYChange(value)
	value = tonumber(value)

	if not value then
		return
	end

	self.lineIconPosY = value

	self:onLineIconPosChange()
end

Rouge2_PathSelectMapEditorView.Interval = 0.01

function Rouge2_PathSelectMapEditorView:onOpen()
	self.addEventCb(self, Rouge2_MapController.instance, RougeMapEvent.onPathSelectMapFocusDone, self.onPathSelectMapFocusDone, self, LuaEventSystem.Low)
	self.addEventCb(self, Rouge2_MapController.instance, RougeMapEvent.onSelectLayerChange, self.onSelectLayerChange, self, LuaEventSystem.Low)

	self.pathSelectCo = Rouge2_MapModel.instance:getPathSelectCo()
	self.map = Rouge2_MapController.instance:getMapComp()
	self.mapViewGo = ViewMgr.instance:getContainer(ViewName.Rouge2_MapView).viewGO

	self:initPos()
	self:initLayerDrop()
end

function Rouge2_PathSelectMapEditorView:initPos()
	self:initStartPos()
	self:initSelectLinePos()
	self:initLineIconPos()
end

function Rouge2_PathSelectMapEditorView:onSelectLayerChange(layerId)
	self:initSelectLinePos()
	self:initLineIconPos()
end

function Rouge2_PathSelectMapEditorView:initStartPos()
	self.startPosX, self.startPosY = Rouge2_MapHelper.getPos(self.pathSelectCo.startPos)

	local goStart = gohelper.findChild(self.mapViewGo, "#go_linecontainer/#go_start")

	self.rectTrStart = goStart:GetComponent(gohelper.Type_RectTransform)

	self:onStartPosChange()
end

function Rouge2_PathSelectMapEditorView:onStartPosChange()
	recthelper.setAnchor(self.rectTrStart, self.startPosX, self.startPosY)
	self._inputStartPosX:SetText(self.startPosX)
	self._inputStartPosY:SetText(self.startPosY)
end

function Rouge2_PathSelectMapEditorView:initSelectLinePos()
	local selectLayerId = Rouge2_MapModel.instance:getSelectLayerId()
	local selectLayerCo = lua_rouge2_layer.configDict[selectLayerId]

	self.linePosX, self.linePosY = Rouge2_MapHelper.getPos(selectLayerCo.pathPos)

	local path = string.format("#go_linecontainer/%s/line", selectLayerCo.id)
	local line = gohelper.findChild(self.mapViewGo, path)

	if not line then
		return
	end

	self.rectTrLine = line:GetComponent(gohelper.Type_RectTransform)

	self:onSelectLinePosChange()
end

function Rouge2_PathSelectMapEditorView:onSelectLinePosChange()
	self._inputSelectLinePosX:SetText(self.linePosX)
	self._inputSelectLinePosY:SetText(self.linePosY)
	recthelper.setAnchor(self.rectTrLine, self.linePosX, self.linePosY)
end

function Rouge2_PathSelectMapEditorView:initLineIconPos()
	local selectLayerId = Rouge2_MapModel.instance:getSelectLayerId()
	local selectLayerCo = lua_rouge2_layer.configDict[selectLayerId]

	self.lineIconPosX, self.lineIconPosY = Rouge2_MapHelper.getPos(selectLayerCo.iconPos)

	local linePath = string.format("#go_linecontainer/%s/lineIcon", selectLayerCo.id)
	local lineIcon = gohelper.findChild(self.mapViewGo, linePath)

	if not lineIcon then
		return
	end

	self.rectTrLineIcon = lineIcon:GetComponent(gohelper.Type_RectTransform)

	self:onLineIconPosChange()
end

function Rouge2_PathSelectMapEditorView:onLineIconPosChange()
	self._inputLineIconPosX:SetText(self.lineIconPosX)
	self._inputLineIconPosY:SetText(self.lineIconPosY)
	recthelper.setAnchor(self.rectTrLineIcon, self.lineIconPosX, self.lineIconPosY)
end

function Rouge2_PathSelectMapEditorView:initLayerDrop()
	self.curLayerId = Rouge2_MapModel.instance:getMiddleLayerId()
	self.curLayerIndex = 1
	self.layerIdList = {}
	self.layerStrList = {}

	for index, layerCo in ipairs(lua_rouge2_middle_layer.configList) do
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

return Rouge2_PathSelectMapEditorView
