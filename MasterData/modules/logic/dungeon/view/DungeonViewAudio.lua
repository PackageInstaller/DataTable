-- chunkname: @modules/logic/dungeon/view/DungeonViewAudio.lua

module("modules.logic.dungeon.view.DungeonViewAudio", package.seeall)

local DungeonViewAudio = class("DungeonViewAudio", BaseView)

function DungeonViewAudio:onInitView()
	self._scrollchapter = gohelper.findChildScrollRect(self.viewGO, "#go_story/chapterlist/#scroll_chapter")
	self._scrollchapterresource = gohelper.findChildScrollRect(self.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonViewAudio:addEvents()
	return
end

function DungeonViewAudio:removeEvents()
	return
end

function DungeonViewAudio:onOpen()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollchapter.gameObject)

	self:initScrollDragListener(self._drag, self._scrollchapter)

	self._dragResource = SLFramework.UGUI.UIDragListener.Get(self._scrollchapterresource.gameObject)

	self:initScrollDragListener(self._dragResource, self._scrollchapterresource)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeChapterList, self._onChangeChapterList, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.SelectMainStorySection, self._onSelectMainStorySection, self)
end

function DungeonViewAudio:_onSelectMainStorySection()
	self._silentTime = Time.time
	self._silentCD = 0.5
end

function DungeonViewAudio:_onChangeChapterList()
	if self._curScroll then
		self._curScroll:RemoveOnValueChanged()

		self._curScroll = nil
	end
end

function DungeonViewAudio:initScrollDragListener(drag, scroll)
	drag:AddDragBeginListener(self._onDragBegin, self, scroll)
	drag:AddDragListener(self._onDrag, self, scroll)
	drag:AddDragEndListener(self._onDragEnd, self, scroll)
end

function DungeonViewAudio:addScrollChangeCallback(callback, callbackTarget)
	self._scrollChangeCallback = callback
	self._scrollChangeCallbackTarget = callbackTarget
end

function DungeonViewAudio:_onScrollValueChanged(x, y)
	if self._scrollChangeCallback then
		self._scrollChangeCallback(self._scrollChangeCallbackTarget)
	end

	local scrollNormalizePos = self._curScroll.horizontalNormalizedPosition

	if self._curNormalizedPos and scrollNormalizePos >= 0 and scrollNormalizePos <= 1 then
		local delta = scrollNormalizePos - self._curNormalizedPos

		if math.abs(delta) >= self._cellCenterPos then
			self._curNormalizedPos = delta > 0 and self._curNormalizedPos + self._cellCenterPos or self._curNormalizedPos - self._cellCenterPos
			self._curNormalizedPos = scrollNormalizePos

			if not self._silentTime or Time.time - self._silentTime >= self._silentCD then
				DungeonAudio.instance:cardPass()
			end
		end
	end
end

function DungeonViewAudio:_onDragBegin(scroll, pointerEventData)
	self._beginDragScrollNormalizePos = scroll.horizontalNormalizedPosition
	self._beginDrag = true

	self:initNormalizePos(scroll)
end

function DungeonViewAudio:initNormalizePos(scroll)
	local contentWidth = recthelper.getWidth(scroll.content)
	local scrollWidth = recthelper.getWidth(scroll.transform)
	local transform = scroll.content
	local itemCount = transform.childCount

	if itemCount == 0 then
		return
	end

	local child = transform:GetChild(itemCount - 1)
	local childWidth = recthelper.getWidth(child)
	local deltaWidth = contentWidth - scrollWidth

	if deltaWidth > 0 then
		local showNum = deltaWidth / childWidth
		local cellWidth = 1 / showNum

		self._cellCenterPos = cellWidth / 2
		self._curNormalizedPos = scroll.horizontalNormalizedPosition

		if self._curScroll then
			self._curScroll:RemoveOnValueChanged()

			self._curScroll = nil
		end

		self._curScroll = scroll

		self._curScroll:AddOnValueChanged(self._onScrollValueChanged, self)
	else
		self._curNormalizedPos = nil
	end
end

function DungeonViewAudio:_onDrag(scroll, pointerEventData)
	if self._beginDrag then
		self._beginDrag = false

		return
	end

	local deltaX = pointerEventData.delta.x
	local scrollNormalizePos = scroll.horizontalNormalizedPosition

	if self._beginDragScrollNormalizePos then
		if scrollNormalizePos == self._beginDragScrollNormalizePos then
			if not self._silentTime or Time.time - self._silentTime >= self._silentCD then
				DungeonAudio.instance:chapterListBoundary()
			end
		elseif (deltaX > 0 and scrollNormalizePos <= 0 or deltaX < 0 and scrollNormalizePos >= 1) and (not self._silentTime or Time.time - self._silentTime >= self._silentCD) then
			DungeonAudio.instance:chapterListBoundary()
		end

		self._beginDragScrollNormalizePos = nil
	end
end

function DungeonViewAudio:_onDragEnd(scroll, pointerEventData)
	self._beginDrag = false
	self._beginDragScrollNormalizePos = nil
end

function DungeonViewAudio:removeScrollDragListener(drag)
	drag:RemoveDragBeginListener()
	drag:RemoveDragEndListener()
	drag:RemoveDragListener()
end

function DungeonViewAudio:onClose()
	if self._curScroll then
		self._curScroll:RemoveOnValueChanged()
	end

	self:removeScrollDragListener(self._drag)
	self:removeScrollDragListener(self._dragResource)

	self._scrollChangeCallback = nil
	self._scrollChangeCallbackTarget = nil
end

return DungeonViewAudio
