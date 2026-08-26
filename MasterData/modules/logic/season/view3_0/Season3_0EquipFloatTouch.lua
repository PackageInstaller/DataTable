-- chunkname: @modules/logic/season/view3_0/Season3_0EquipFloatTouch.lua

module("modules.logic.season.view3_0.Season3_0EquipFloatTouch", package.seeall)

local Season3_0EquipFloatTouch = class("Season3_0EquipFloatTouch", BaseView)

function Season3_0EquipFloatTouch:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0EquipFloatTouch:addEvents()
	return
end

function Season3_0EquipFloatTouch:removeEvents()
	return
end

function Season3_0EquipFloatTouch:init(ctrlGOPath, touchGOPath)
	self._goctrlPath = ctrlGOPath
	self._gotouchPath = touchGOPath
end

function Season3_0EquipFloatTouch:_editableInitView()
	self._goctrl = gohelper.findChild(self.viewGO, self._goctrlPath)
	self._gotouch = gohelper.findChild(self.viewGO, self._gotouchPath)
	self._tfTouch = self._gotouch.transform
	self._tfCtrl = self._goctrl.transform
	self._originX, self._originY, self._originZ = transformhelper.getLocalRotation(self._tfTouch)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gotouch)

	self._drag:AddDragBeginListener(self.onDragBegin, self)
	self._drag:AddDragListener(self.onDrag, self)
	self._drag:AddDragEndListener(self.onDragEnd, self)
end

function Season3_0EquipFloatTouch:onDestroyView()
	self:killTween()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

function Season3_0EquipFloatTouch:onDragBegin(param, pointerEventData)
	return
end

function Season3_0EquipFloatTouch:onDragEnd(param, pointerEventData)
	local pos = pointerEventData.position

	self:killTween()

	local screenPos = recthelper.screenPosToAnchorPos(pos, self._tfTouch)

	self._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(self._tfCtrl, 0, 0, 0, 0.7, nil, nil, nil, EaseType.OutCirc)
end

Season3_0EquipFloatTouch.Range_Rotaion_Min_X = -25
Season3_0EquipFloatTouch.Range_Rotaion_Max_X = 25
Season3_0EquipFloatTouch.Range_Rotaion_Min_Y = -25
Season3_0EquipFloatTouch.Range_Rotaion_Max_Y = 25

function Season3_0EquipFloatTouch:onDrag(param, pointerEventData)
	local pos = pointerEventData.position
	local halfSize = 250
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._tfTouch)
	local anchorPosRateX = Mathf.Clamp(anchorPos.x / halfSize, -1, 1) * 0.5 + 0.5
	local anchorPosRateY = Mathf.Clamp(-anchorPos.y / halfSize, -1, 1) * 0.5 + 0.5
	local rotationX = Mathf.Lerp(Season3_0EquipFloatTouch.Range_Rotaion_Min_X, Season3_0EquipFloatTouch.Range_Rotaion_Max_X, anchorPosRateX)
	local rotationY = Mathf.Lerp(Season3_0EquipFloatTouch.Range_Rotaion_Min_Y, Season3_0EquipFloatTouch.Range_Rotaion_Max_Y, anchorPosRateY)

	self:killTween()

	self._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(self._tfCtrl, rotationY, rotationX, 0, 0.3, nil, nil, nil, EaseType.Linear)
end

function Season3_0EquipFloatTouch:killTween()
	if self._tweenRotationId then
		ZProj.TweenHelper.KillById(self._tweenRotationId)

		self._tweenRotationId = nil
	end
end

return Season3_0EquipFloatTouch
