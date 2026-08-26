-- chunkname: @modules/logic/season/view1_3/Season1_3EquipFloatTouch.lua

module("modules.logic.season.view1_3.Season1_3EquipFloatTouch", package.seeall)

local Season1_3EquipFloatTouch = class("Season1_3EquipFloatTouch", BaseView)

function Season1_3EquipFloatTouch:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_3EquipFloatTouch:addEvents()
	return
end

function Season1_3EquipFloatTouch:removeEvents()
	return
end

function Season1_3EquipFloatTouch:init(ctrlGOPath, touchGOPath)
	self._goctrlPath = ctrlGOPath
	self._gotouchPath = touchGOPath
end

function Season1_3EquipFloatTouch:_editableInitView()
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

function Season1_3EquipFloatTouch:onDestroyView()
	self:killTween()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

function Season1_3EquipFloatTouch:onDragBegin(param, pointerEventData)
	return
end

function Season1_3EquipFloatTouch:onDragEnd(param, pointerEventData)
	local pos = pointerEventData.position

	self:killTween()

	local screenPos = recthelper.screenPosToAnchorPos(pos, self._tfTouch)

	self._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(self._tfCtrl, 0, 0, 0, 0.7, nil, nil, nil, EaseType.OutCirc)
end

Season1_3EquipFloatTouch.Range_Rotaion_Min_X = -25
Season1_3EquipFloatTouch.Range_Rotaion_Max_X = 25
Season1_3EquipFloatTouch.Range_Rotaion_Min_Y = -25
Season1_3EquipFloatTouch.Range_Rotaion_Max_Y = 25

function Season1_3EquipFloatTouch:onDrag(param, pointerEventData)
	local pos = pointerEventData.position
	local halfSize = 250
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._tfTouch)
	local anchorPosRateX = Mathf.Clamp(anchorPos.x / halfSize, -1, 1) * 0.5 + 0.5
	local anchorPosRateY = Mathf.Clamp(-anchorPos.y / halfSize, -1, 1) * 0.5 + 0.5
	local rotationX = Mathf.Lerp(Season1_3EquipFloatTouch.Range_Rotaion_Min_X, Season1_3EquipFloatTouch.Range_Rotaion_Max_X, anchorPosRateX)
	local rotationY = Mathf.Lerp(Season1_3EquipFloatTouch.Range_Rotaion_Min_Y, Season1_3EquipFloatTouch.Range_Rotaion_Max_Y, anchorPosRateY)

	self:killTween()

	self._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(self._tfCtrl, rotationY, rotationX, 0, 0.3, nil, nil, nil, EaseType.Linear)
end

function Season1_3EquipFloatTouch:killTween()
	if self._tweenRotationId then
		ZProj.TweenHelper.KillById(self._tweenRotationId)

		self._tweenRotationId = nil
	end
end

return Season1_3EquipFloatTouch
