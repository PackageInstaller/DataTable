-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_ScrollAudioView.lua

module("modules.logic.rouge2.outside.view.Rouge2_ScrollAudioView", package.seeall)

local Rouge2_ScrollAudioView = class("Rouge2_ScrollAudioView", BaseView)

function Rouge2_ScrollAudioView:ctor(scrollViewPath)
	self._scrollviewPath = scrollViewPath
end

function Rouge2_ScrollAudioView:onInitView()
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, self._scrollviewPath or "#scroll_view")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ScrollAudioView:addEvents()
	return
end

function Rouge2_ScrollAudioView:removeEvents()
	return
end

function Rouge2_ScrollAudioView:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollview.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._scrollview.gameObject)

	self._touch:AddClickDownListener(self._onClickDown, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollview.gameObject, DungeonMapEpisodeAudio, self._scrollview)
end

function Rouge2_ScrollAudioView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function Rouge2_ScrollAudioView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function Rouge2_ScrollAudioView:_onClickDown()
	self._audioScroll:onClickDown()
end

function Rouge2_ScrollAudioView:onUpdateParam()
	return
end

function Rouge2_ScrollAudioView:onOpen()
	return
end

function Rouge2_ScrollAudioView:onClose()
	return
end

function Rouge2_ScrollAudioView:onDestroyView()
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

return Rouge2_ScrollAudioView
