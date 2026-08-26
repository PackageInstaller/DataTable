-- chunkname: @modules/logic/versionactivity/view/VersionActivityPuzzleOptionItem.lua

module("modules.logic.versionactivity.view.VersionActivityPuzzleOptionItem", package.seeall)

local VersionActivityPuzzleOptionItem = class("VersionActivityPuzzleOptionItem", UserDataDispose)

function VersionActivityPuzzleOptionItem:onInitView(go, parentView)
	self:__onInit()

	self.go = go
	self.parentView = parentView
	self.txtInfo = gohelper.findChildText(go, "info")
	self.head = gohelper.findChild(self.go, "head")
	self.txtLineIndex = gohelper.findChildText(self.go, "head/txt_index")

	if not parentView.isFinish then
		self.drag = SLFramework.UGUI.UIDragListener.Get(self.go)

		self.drag:AddDragBeginListener(self._onDragBegin, self)
		self.drag:AddDragEndListener(self._onDragEnd, self)
		self.drag:AddDragListener(self._onDrag, self)
	end
end

function VersionActivityPuzzleOptionItem:updateInfo(info, answerIndex)
	gohelper.setActive(self.go, true)

	self.txtInfo.text = info
	self.info = info
	self.answerIndex = answerIndex

	gohelper.setActive(self.head, false)

	local isFirstInLine = (self.answerIndex - 1) % 4 == 0

	if isFirstInLine then
		gohelper.setActive(self.head, true)

		self.txtLineIndex.text = math.ceil(self.answerIndex / 4)
	end
end

function VersionActivityPuzzleOptionItem:hide()
	gohelper.setActive(self.go, false)
end

function VersionActivityPuzzleOptionItem:_onDragBegin(param, pointerEventData)
	self.parentView:onDragItemDragBegin(pointerEventData, self.info, self.answerIndex)
end

function VersionActivityPuzzleOptionItem:_onDrag(param, pointerEventData)
	self.parentView:onDragItemDragging(pointerEventData)
end

function VersionActivityPuzzleOptionItem:_onDragEnd(param, pointerEventData)
	self.parentView:onDragItemDragEnd(pointerEventData)
end

function VersionActivityPuzzleOptionItem:unUse()
	self.txtInfo.text = self.info
end

function VersionActivityPuzzleOptionItem:matchCorrect()
	self.txtInfo.text = string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor, self.info)
end

function VersionActivityPuzzleOptionItem:matchError()
	self.txtInfo.text = string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchErrorColor, self.info)
end

function VersionActivityPuzzleOptionItem:getScreenPos()
	return recthelper.uiPosToScreenPos(self.go.transform)
end

function VersionActivityPuzzleOptionItem:onDestroy()
	if self.drag then
		self.drag:RemoveDragListener()
		self.drag:RemoveDragBeginListener()
		self.drag:RemoveDragEndListener()

		self.drag = nil
	end

	self:__onDispose()
end

return VersionActivityPuzzleOptionItem
