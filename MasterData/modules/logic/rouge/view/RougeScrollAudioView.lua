-- chunkname: @modules/logic/rouge/view/RougeScrollAudioView.lua

module("modules.logic.rouge.view.RougeScrollAudioView", package.seeall)

local RougeScrollAudioView = class("RougeScrollAudioView", BaseView)

function RougeScrollAudioView:ctor(scrollViewPath)
	self._scrollviewPath = scrollViewPath
end

function RougeScrollAudioView:onInitView()
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, self._scrollviewPath or "#scroll_view")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeScrollAudioView:addEvents()
	return
end

function RougeScrollAudioView:removeEvents()
	return
end

function RougeScrollAudioView:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollview.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._scrollview.gameObject)

	self._touch:AddClickDownListener(self._onClickDown, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollview.gameObject, DungeonMapEpisodeAudio, self._scrollview)
end

function RougeScrollAudioView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function RougeScrollAudioView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function RougeScrollAudioView:_onClickDown()
	self._audioScroll:onClickDown()
end

function RougeScrollAudioView:onUpdateParam()
	return
end

function RougeScrollAudioView:onOpen()
	return
end

function RougeScrollAudioView:onClose()
	return
end

function RougeScrollAudioView:onDestroyView()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end
end

return RougeScrollAudioView
