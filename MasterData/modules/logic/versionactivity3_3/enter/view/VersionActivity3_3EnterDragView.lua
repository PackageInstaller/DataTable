-- chunkname: @modules/logic/versionactivity3_3/enter/view/VersionActivity3_3EnterDragView.lua

module("modules.logic.versionactivity3_3.enter.view.VersionActivity3_3EnterDragView", package.seeall)

local VersionActivity3_3EnterDragView = class("VersionActivity3_3EnterDragView", BaseView)

function VersionActivity3_3EnterDragView:ctor(nodeName)
	VersionActivity3_3EnterDragView.super.ctor(self)

	self._nodeName = nodeName
end

function VersionActivity3_3EnterDragView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_3EnterDragView:addEvents()
	return
end

function VersionActivity3_3EnterDragView:removeEvents()
	return
end

function VersionActivity3_3EnterDragView:_editableInitView()
	if not self._nodeName then
		logError(string.format("需要给VersionActivity3_3EnterDragView传递拖动节点名称"))

		return
	end

	local node = gohelper.findChild(self.viewGO, self._nodeName)

	if not node then
		logError(string.format("VersionActivity3_3EnterDragView没有找到节点:%s", self._nodeName))

		return
	end

	local path = self.viewContainer:getSetting().otherRes[1]
	local dragItemGo = self.viewContainer:getResInst(path, self.viewGO)

	gohelper.setSiblingAfter(dragItemGo, node)

	self._drag = SLFramework.UGUI.UIDragListener.Get(dragItemGo)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
end

function VersionActivity3_3EnterDragView:onOpen()
	return
end

function VersionActivity3_3EnterDragView:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = pointerEventData.position
end

function VersionActivity3_3EnterDragView:_onDragEnd(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local deltaPos = pointerEventData.position - self._dragBeginPos

	if math.abs(deltaPos.x) < 50 or math.abs(deltaPos.y) > 100 then
		return
	end

	local moveLeft = deltaPos.x < 0

	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.DragOpenAct, moveLeft)
end

function VersionActivity3_3EnterDragView:onClose()
	return
end

function VersionActivity3_3EnterDragView:onDestroyView()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

return VersionActivity3_3EnterDragView
