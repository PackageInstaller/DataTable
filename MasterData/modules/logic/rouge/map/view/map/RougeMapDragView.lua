-- chunkname: @modules/logic/rouge/map/view/map/RougeMapDragView.lua

module("modules.logic.rouge.map.view.map.RougeMapDragView", package.seeall)

local RougeMapDragView = class("RougeMapDragView", BaseView)

function RougeMapDragView:onInitView()
	self.goFullScreen = gohelper.findChild(self.viewGO, "#go_fullscreen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapDragView:addEvents()
	return
end

function RougeMapDragView:removeEvents()
	return
end

function RougeMapDragView:_editableInitView()
	self.drag = SLFramework.UGUI.UIDragListener.Get(self.goFullScreen)

	self.drag:AddDragBeginListener(self._onBeginDrag, self)
	self.drag:AddDragListener(self._onDrag, self)
	self.drag:AddDragEndListener(self._onEndDrag, self)

	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.refPos = self.goFullScreen.transform.position
end

function RougeMapDragView:_onBeginDrag()
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	self.startPosX = RougeMapHelper.getWorldPos(UnityEngine.Input.mousePosition, self.mainCamera, self.refPos)
end

function RougeMapDragView:_onDrag()
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	if not self.startPosX then
		return
	end

	local curX = RougeMapHelper.getWorldPos(UnityEngine.Input.mousePosition, self.mainCamera, self.refPos)
	local offsetX = curX - self.startPosX
	local curPosX = RougeMapModel.instance:getMapPosX()

	RougeMapModel.instance:setMapPosX(curPosX + offsetX)

	self.startPosX = curX
end

function RougeMapDragView:_onEndDrag()
	self.startPosX = nil
end

function RougeMapDragView:onClose()
	if self.drag then
		self.drag:RemoveDragBeginListener()
		self.drag:RemoveDragListener()
		self.drag:RemoveDragEndListener()
	end
end

return RougeMapDragView
