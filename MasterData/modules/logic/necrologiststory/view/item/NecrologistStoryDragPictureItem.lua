-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryDragPictureItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryDragPictureItem", package.seeall)

local NecrologistStoryDragPictureItem = class("NecrologistStoryDragPictureItem", NecrologistStoryControlItem)

function NecrologistStoryDragPictureItem:onInit()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.rootTrs = self.goRoot.transform
	self.goDrag = gohelper.findChild(self.viewGO, "root/go_drag")
	self.srcPosX, self.srcPosY = recthelper.getAnchor(self.goDrag.transform)
	self.goSelect = gohelper.findChild(self.viewGO, "root/go_drag/#select")
	self.imgGlow = gohelper.findChildImage(self.viewGO, "root/go_drag/#select/glow")
	self.imgLight = gohelper.findChildImage(self.viewGO, "root/go_drag/#select/light")

	gohelper.setActive(self.goSelect, false)
	self:addDrag(self.goDrag)

	self.maskableGraphicList = {}

	local list = self.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.MaskableGraphic), true)

	for i = 0, list.Length - 1 do
		local graphic = list[i]

		table.insert(self.maskableGraphicList, graphic)
	end

	self.simageNormal = gohelper.findChildSingleImage(self.viewGO, "root/go_drag/normal")
	self.simageSelect = gohelper.findChildSingleImage(self.viewGO, "root/go_drag/#select/glow")
end

function NecrologistStoryDragPictureItem:addDrag(go)
	if self._drag then
		return
	end

	self._click = gohelper.getClickWithAudio(go)
	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self, go.transform)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function NecrologistStoryDragPictureItem:setDragEnabled(isEnabled)
	if self._drag then
		self._drag.enabled = isEnabled
	end

	if self.storyView then
		self.storyView:onDragPicEnable(isEnabled)
	end
end

function NecrologistStoryDragPictureItem:setMaskable(isEnabled)
	for _, graphic in ipairs(self.maskableGraphicList) do
		graphic.maskable = isEnabled
	end
end

function NecrologistStoryDragPictureItem:onPlayStory()
	self._isFinish = false

	local picRes = self._controlParam
	local imgRes = ResUrl.getNecrologistStoryPicBg(picRes)

	self.simageNormal:LoadImage(imgRes, self.onSimageNormalLoaded, self)
	self.simageSelect:LoadImage(imgRes, self.onSimageSelectLoaded, self)
	self:setDragEnabled(true)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.StartDragPic)
end

function NecrologistStoryDragPictureItem:onSimageSelectLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageSelect.gameObject)
end

function NecrologistStoryDragPictureItem:onSimageNormalLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageNormal.gameObject)
end

function NecrologistStoryDragPictureItem:_tweenToPos(transform, anchorPos)
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end

	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 5 or math.abs(curAnchorY - anchorPos.y) > 5 then
		self.posTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.05)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)
	end
end

function NecrologistStoryDragPictureItem:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.rootTrs)

	self:_tweenToPos(dragTransform, anchorPos)

	self.inDrag = true

	self:setMaskable(false)
	gohelper.setActive(self.goSelect, true)
end

function NecrologistStoryDragPictureItem:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local position = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(position, self.rootTrs)

	self:_tweenToPos(dragTransform, anchorPos)

	self.inDrag = true
end

function NecrologistStoryDragPictureItem:_onEndDrag(dragTransform, pointerEventData)
	self.inDrag = false

	if not self:canDrag() then
		return
	end

	gohelper.setActive(self.goSelect, false)
	self:killTweenId()

	local isFinish = self:checkIsFinish(dragTransform)

	if isFinish then
		self:onDragFinish()
	else
		self:setMaskable(true)
		self:_tweenToPos(dragTransform, Vector2(self.srcPosX, self.srcPosY))
	end
end

function NecrologistStoryDragPictureItem:onDragFinish()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_leimi_celebrity_get)
	self:setDragEnabled(false)
	self.anim:Play("finish", 0, 0)
	TaskDispatcher.runDelay(self._delayDeleteItem, self, 0.8)
end

function NecrologistStoryDragPictureItem:_delayDeleteItem()
	self._isFinish = true

	self.storyView:delItem(self)
end

function NecrologistStoryDragPictureItem:canDrag()
	return not self._isFinish
end

function NecrologistStoryDragPictureItem:checkIsFinish(dragTransform)
	return self.storyView:isInLeftArea(dragTransform)
end

function NecrologistStoryDragPictureItem:isDone()
	return self._isFinish
end

function NecrologistStoryDragPictureItem:caleHeight()
	return 400
end

function NecrologistStoryDragPictureItem:killTweenId()
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end

	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end
end

function NecrologistStoryDragPictureItem:onDestroy()
	TaskDispatcher.cancelTask(self._delayDeleteItem, self)
	self:killTweenId()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self.simageNormal:UnLoadImage()
	self.simageSelect:UnLoadImage()
end

function NecrologistStoryDragPictureItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststorydragpictureitem.prefab"
end

return NecrologistStoryDragPictureItem
