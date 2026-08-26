-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameViewDragItemBase.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameViewDragItemBase", package.seeall)

local V3a1_GaoSiNiao_GameViewDragItemBase = class("V3a1_GaoSiNiao_GameViewDragItemBase", RougeSimpleItemBase)

function V3a1_GaoSiNiao_GameViewDragItemBase:ctor(ctorParam)
	V3a1_GaoSiNiao_GameViewDragItemBase.super.ctor(self, ctorParam)
end

function V3a1_GaoSiNiao_GameViewDragItemBase:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
	V3a1_GaoSiNiao_GameViewDragItemBase.super.onDestroyView(self)
end

function V3a1_GaoSiNiao_GameViewDragItemBase:initDragObj(goToListenDragging)
	self._drag = UIDragListenerHelper.New()

	self._drag:create(goToListenDragging, self)
	self._drag:registerCallback(self._drag.EventBegin, self._onBeginDrag, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDragging, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onEndDrag, self)
end

function V3a1_GaoSiNiao_GameViewDragItemBase:_dragContext()
	local c = self:baseViewContainer()

	return c:dragContext()
end

function V3a1_GaoSiNiao_GameViewDragItemBase:isCompleted()
	return self:_dragContext():isCompleted()
end

function V3a1_GaoSiNiao_GameViewDragItemBase:_onBeginDrag(dragObj)
	assert(false, "please override this function")
end

function V3a1_GaoSiNiao_GameViewDragItemBase:_onDragging(dragObj)
	assert(false, "please override this function")
end

function V3a1_GaoSiNiao_GameViewDragItemBase:_onEndDrag(dragObj)
	assert(false, "please override this function")
end

function V3a1_GaoSiNiao_GameViewDragItemBase:getDraggingSpriteAndZRot()
	assert(false, "please override this function")
end

function V3a1_GaoSiNiao_GameViewDragItemBase:isDraggable()
	return true
end

return V3a1_GaoSiNiao_GameViewDragItemBase
