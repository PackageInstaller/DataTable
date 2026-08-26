-- chunkname: @modules/logic/room/view/debug/RoomDebugBuildingAreaView.lua

module("modules.logic.room.view.debug.RoomDebugBuildingAreaView", package.seeall)

local RoomDebugBuildingAreaView = class("RoomDebugBuildingAreaView", BaseView)

function RoomDebugBuildingAreaView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_close")
	self._goarearoot = gohelper.findChild(self.viewGO, "#go_content/#go_arearoot")
	self._goareaitem = gohelper.findChild(self.viewGO, "#go_content/#go_arearoot/#go_areaitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugBuildingAreaView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomDebugBuildingAreaView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomDebugBuildingAreaView:_btncloseOnClick()
	self:closeThis()
end

function RoomDebugBuildingAreaView:_editableInitView()
	self._goarearootTrs = self._goarearoot.transform
	self._itemTbList = {}
	self._lastIndex = 1

	table.insert(self._itemTbList, self:_createTbByGO(self._goareaitem))
end

function RoomDebugBuildingAreaView:_createTbByGO(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goTrs = go.transform
	tb.txtname = gohelper.findChildText(go, "txt_name")
	tb._canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))

	return tb
end

function RoomDebugBuildingAreaView:onOpen()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		self:closeThis()

		return
	end

	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._refreshUI, self)

	self._scene = GameSceneMgr.instance:getCurScene()

	self:_refreshUI()
end

function RoomDebugBuildingAreaView:onClose()
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._refreshUI, self)
end

function RoomDebugBuildingAreaView:onDestroyView()
	return
end

function RoomDebugBuildingAreaView:_refreshUI()
	self._focusPos = self._scene.camera:getCameraFocus()

	local allOccupyDict = RoomMapBuildingModel.instance:getAllOccupyDict()
	local index = 1

	for x, dict in pairs(allOccupyDict) do
		for y, param in pairs(dict) do
			if index > #self._itemTbList then
				local cloneGo = gohelper.cloneInPlace(self._goareaitem)

				table.insert(self._itemTbList, self:_createTbByGO(cloneGo))
			end

			local tbItem = self._itemTbList[index]

			index = index + 1

			self:_setTbItemAvtive(tbItem, true)
			self:_refreshByParam(tbItem, param)
		end
	end

	for i = index, #self._itemTbList do
		self:_setTbItemAvtive(self._itemTbList[i], false)
	end
end

function RoomDebugBuildingAreaView:_setTbItemAvtive(tbItem, active)
	if tbItem.isActive ~= active then
		tbItem.isActive = active

		gohelper.setActive(tbItem.go, active)
	end
end

function RoomDebugBuildingAreaView:_refreshByParam(tbItem, param)
	if tbItem.buildingId ~= param.buildingId or tbItem.posindex ~= param.index then
		tbItem.buildingId = param.buildingId
		tbItem.posindex = param.index

		local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(param.buildingId)
		local pointList = buildingConfigParam.pointList
		local point = pointList[param.index]

		tbItem.txtname.text = point.x .. "#" .. point.y
	end

	local bendingPos = HexMath.hexToPosition(param.hexPoint, RoomBlockEnum.BlockSize)

	self:_setTbItemPos(bendingPos, tbItem, self._goarearootTrs)
end

function RoomDebugBuildingAreaView:_setTbItemPos(bendingPos, tbItem, parentUIGOTrs)
	local worldPos = Vector3(bendingPos.x, 0.12, bendingPos.y)
	local localPos = recthelper.worldPosToAnchorPos(worldPos, parentUIGOTrs)
	local focusDistance = Vector2.Distance(self._focusPos, bendingPos)

	tbItem._canvasGroup.alpha = focusDistance <= 2.5 and 1 or focusDistance >= 3.5 and 0 or 3.5 - focusDistance

	recthelper.setAnchor(tbItem.goTrs, localPos.x, localPos.y)
end

return RoomDebugBuildingAreaView
