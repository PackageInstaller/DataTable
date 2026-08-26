-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStorySliderPictureItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStorySliderPictureItem", package.seeall)

local NecrologistStorySliderPictureItem = class("NecrologistStorySliderPictureItem", NecrologistStoryControlItem)

function NecrologistStorySliderPictureItem:onInit()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.rootTrs = self.goRoot.transform
	self.goDrag = gohelper.findChild(self.viewGO, "root/go_drag")

	self:addDrag(self.goDrag)

	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "root/txtContent")
	self.simageNormal = gohelper.findChildSingleImage(self.viewGO, "root/go_drag/normal")
	self.simageFinished = gohelper.findChildSingleImage(self.viewGO, "root/go_drag/finished")
	self.goTips = gohelper.findChild(self.viewGO, "root/tips")
end

function NecrologistStorySliderPictureItem:addDrag(go)
	if self._drag then
		return
	end

	self._click = gohelper.getClickWithAudio(go)
	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self, go.transform)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function NecrologistStorySliderPictureItem:setDragEnabled(isEnabled)
	if self._drag then
		self._drag.enabled = isEnabled
	end
end

function NecrologistStorySliderPictureItem:refreshState()
	local isDone = self:isDone()

	self:setDragEnabled(not isDone)
	gohelper.setActive(self.simageNormal.gameObject, not isDone)
	gohelper.setActive(self.simageFinished.gameObject, isDone)
	gohelper.setActive(self.goTips, not isDone)

	if isDone then
		self.anim:Play("finish")
	else
		self.anim:Play("open")
	end
end

function NecrologistStorySliderPictureItem:onPlayStory()
	self.txtContent.text = NecrologistStoryHelper.getDesc(self._storyId)
	self._isFinish = false

	local params = string.split(self._controlParam, "#")

	self.dir = tonumber(params[1])

	self.simageNormal:LoadImage(ResUrl.getNecrologistStoryPicBg(params[2]), self.onSimageNormalLoaded, self)
	self.simageFinished:LoadImage(ResUrl.getNecrologistStoryPicBg(params[3]), self.onSimageFinishedLoaded, self)
	self:refreshState()
end

function NecrologistStorySliderPictureItem:onSimageNormalLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageNormal.gameObject)
end

function NecrologistStorySliderPictureItem:onSimageFinishedLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageFinished.gameObject)
end

function NecrologistStorySliderPictureItem:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	self.startDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.rootTrs)
	self.inDrag = true
end

function NecrologistStorySliderPictureItem:_onDrag(dragTransform, pointerEventData)
	return
end

function NecrologistStorySliderPictureItem:_onEndDrag(dragTransform, pointerEventData)
	self.inDrag = false

	if not self:canDrag() then
		return
	end

	local endDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.rootTrs)
	local isDirectionCorrect = NecrologistStoryHelper.checkDragDirection(self.startDragPos, endDragPos, self.dir)

	if isDirectionCorrect then
		self:onDragFinish()
	end
end

function NecrologistStorySliderPictureItem:onDragFinish()
	self._isFinish = true

	self:refreshState()
	self:onPlayFinish()
end

function NecrologistStorySliderPictureItem:canDrag()
	return not self:isDone()
end

function NecrologistStorySliderPictureItem:isDone()
	return self._isFinish
end

function NecrologistStorySliderPictureItem:caleHeight()
	return 400
end

function NecrologistStorySliderPictureItem:onDestroy()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self.simageNormal:UnLoadImage()
	self.simageFinished:UnLoadImage()
end

function NecrologistStorySliderPictureItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststoryslidepictureitem.prefab"
end

return NecrologistStorySliderPictureItem
