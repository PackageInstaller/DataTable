-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EquipFloatTouch.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EquipFloatTouch", package.seeall)

local Season123_1_9EquipFloatTouch = class("Season123_1_9EquipFloatTouch", BaseView)

function Season123_1_9EquipFloatTouch:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_9EquipFloatTouch:addEvents()
	return
end

function Season123_1_9EquipFloatTouch:removeEvents()
	return
end

function Season123_1_9EquipFloatTouch:init(ctrlGOPath, touchGOPath)
	self._goctrlPath = ctrlGOPath
	self._gotouchPath = touchGOPath
end

function Season123_1_9EquipFloatTouch:_editableInitView()
	self._goctrl = gohelper.findChild(self.viewGO, self._goctrlPath)
	self._gotouch = gohelper.findChild(self.viewGO, self._gotouchPath)
	self._tfTouch = self._gotouch.transform
	self._tfCtrl = self._goctrl.transform
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gotouch)

	self._drag:AddDragBeginListener(self.onDragBegin, self)
	self._drag:AddDragListener(self.onDrag, self)
	self._drag:AddDragEndListener(self.onDragEnd, self)
end

function Season123_1_9EquipFloatTouch:onDestroyView()
	self:killTween()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

function Season123_1_9EquipFloatTouch:onDragBegin(param, pointerEventData)
	return
end

function Season123_1_9EquipFloatTouch:onDragEnd(param, pointerEventData)
	self:killTween()

	self._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(self._tfCtrl, 0, 0, 0, 0.7, nil, nil, nil, EaseType.OutCirc)
end

Season123_1_9EquipFloatTouch.Range_Rotaion_Min_X = -25
Season123_1_9EquipFloatTouch.Range_Rotaion_Max_X = 25
Season123_1_9EquipFloatTouch.Range_Rotaion_Min_Y = -25
Season123_1_9EquipFloatTouch.Range_Rotaion_Max_Y = 25

function Season123_1_9EquipFloatTouch:onDrag(param, pointerEventData)
	local pos = pointerEventData.position
	local halfSize = 250
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._tfTouch)
	local anchorPosRateX = Mathf.Clamp(anchorPos.x / halfSize, -1, 1) * 0.5 + 0.5
	local anchorPosRateY = Mathf.Clamp(-anchorPos.y / halfSize, -1, 1) * 0.5 + 0.5
	local rotationX = Mathf.Lerp(Season123_1_9EquipFloatTouch.Range_Rotaion_Min_X, Season123_1_9EquipFloatTouch.Range_Rotaion_Max_X, anchorPosRateX)
	local rotationY = Mathf.Lerp(Season123_1_9EquipFloatTouch.Range_Rotaion_Min_Y, Season123_1_9EquipFloatTouch.Range_Rotaion_Max_Y, anchorPosRateY)

	self:killTween()

	self._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(self._tfCtrl, rotationY, rotationX, 0, 0.3, nil, nil, nil, EaseType.Linear)
end

function Season123_1_9EquipFloatTouch:killTween()
	if self._tweenRotationId then
		ZProj.TweenHelper.KillById(self._tweenRotationId)

		self._tweenRotationId = nil
	end
end

return Season123_1_9EquipFloatTouch
