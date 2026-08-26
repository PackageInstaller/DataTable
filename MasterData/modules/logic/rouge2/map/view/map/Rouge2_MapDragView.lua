-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapDragView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapDragView", package.seeall)

local Rouge2_MapDragView = class("Rouge2_MapDragView", BaseView)

function Rouge2_MapDragView:onInitView()
	self.goFullScreen = gohelper.findChild(self.viewGO, "#go_fullscreen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapDragView:addEvents()
	return
end

function Rouge2_MapDragView:removeEvents()
	return
end

function Rouge2_MapDragView:_editableInitView()
	self.drag = SLFramework.UGUI.UIDragListener.Get(self.goFullScreen)

	self.drag:AddDragBeginListener(self._onBeginDrag, self)
	self.drag:AddDragListener(self._onDrag, self)
	self.drag:AddDragEndListener(self._onEndDrag, self)

	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.refPos = self.goFullScreen.transform.position
end

function Rouge2_MapDragView:_onBeginDrag()
	if not Rouge2_MapModel.instance:isNormalLayer() then
		return
	end

	self.startPosX = Rouge2_MapHelper.getWorldPos(UnityEngine.Input.mousePosition, self.mainCamera, self.refPos)
end

function Rouge2_MapDragView:_onDrag()
	if not Rouge2_MapModel.instance:isNormalLayer() then
		return
	end

	if not self.startPosX then
		return
	end

	local curX = Rouge2_MapHelper.getWorldPos(UnityEngine.Input.mousePosition, self.mainCamera, self.refPos)
	local offsetX = curX - self.startPosX
	local curPosX = Rouge2_MapModel.instance:getMapPosX()

	Rouge2_MapModel.instance:setMapPosX(curPosX + offsetX)

	self.startPosX = curX
end

function Rouge2_MapDragView:_onEndDrag()
	self.startPosX = nil
end

function Rouge2_MapDragView:onClose()
	if self.drag then
		self.drag:RemoveDragBeginListener()
		self.drag:RemoveDragListener()
		self.drag:RemoveDragEndListener()
	end
end

return Rouge2_MapDragView
