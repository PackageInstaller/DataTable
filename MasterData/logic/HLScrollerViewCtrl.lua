-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HLScrollerViewCtrl.lua

module("logic.extensions.holylight.view.HLScrollerViewCtrl", package.seeall)

local HLScrollerViewCtrl = class("HLScrollerViewCtrl")

function HLScrollerViewCtrl:ctor()
	return
end

function HLScrollerViewCtrl:onInit(scrollRect)
	self._scrollRect = scrollRect
	self._contenRectTran = scrollRect.content
	self._viewportRectTran = scrollRect.viewport
	self._ctWidth = 0
	self._ctHeight = 0

	self:_setRaycast(true)
end

function HLScrollerViewCtrl:onClear()
	self:stopFollow()
	self:killViewTo()

	self._scrollerView = nil
	self._contenRectTran = nil
	self._viewportRectTran = nil
	self._ctWidth = nil
	self._ctHeight = nil
end

function HLScrollerViewCtrl:onSet(ctX, ctY)
	local dx = 0
	local d = UnityEngine.Screen.width / UnityEngine.Screen.height

	if d > 2.23 then
		dx = -160
	end

	local viewX = Mathf.Min(UnityEngine.Screen.width * (d < 1.7777777778 and 1280 / UnityEngine.Screen.width or 720 / UnityEngine.Screen.height) + dx, ctX)
	local viewY = Mathf.Min(720, ctY)

	self._viewportRectTran.sizeDelta = Vector2.New(viewX, viewY)
	self._contenRectTran.sizeDelta = Vector2.New(ctX, ctY)
end

function HLScrollerViewCtrl:setNorPosition(targetPos)
	self._tempSizeX = self._contenRectTran.sizeDelta.x - self._viewportRectTran.sizeDelta.x
	self._tempSizeY = self._contenRectTran.sizeDelta.y - self._viewportRectTran.sizeDelta.y
	self._scrollRect.horizontalNormalizedPosition = (targetPos.x + 0.5 * self._tempSizeX) / self._tempSizeX
	self._scrollRect.verticalNormalizedPosition = (targetPos.y + 0.5 * self._tempSizeY) / self._tempSizeY
end

function HLScrollerViewCtrl:viewTo(pos, startCallBack, finishCallBack)
	local ctSizeX = self._contenRectTran.sizeDelta.x
	local ctSizeY = self._contenRectTran.sizeDelta.y
	local vpSizeX = self._viewportRectTran.sizeDelta.x
	local vpSizeY = self._viewportRectTran.sizeDelta.y
	local tempSizeX = ctSizeX - vpSizeX
	local tempSizeY = ctSizeY - vpSizeY
	local formHorValue = self._scrollRect.horizontalNormalizedPosition
	local formVerValue = self._scrollRect.verticalNormalizedPosition
	local formPosX = tempSizeX * (formHorValue - 0.5)
	local formPosY = tempSizeY * (formVerValue - 0.5)
	local formPos = Vector3.New(formPosX, formPosY, 0)
	local toPos = Vector3.New(pos.x, pos.y, 0)
	local toHorValue = (toPos.x + 0.5 * tempSizeX) / tempSizeX
	local toVerValue = (toPos.y + 0.5 * tempSizeY) / tempSizeY
	local disHorValue = toHorValue - formHorValue
	local disVerValue = toVerValue - formVerValue
	local speed = 300
	local distance = Vector3.Distance(formPos, toPos)
	local duration = Mathf.Clamp(distance / speed, 0.2, 1.2)

	local function updateHander(val)
		self._scrollRect.horizontalNormalizedPosition = formHorValue + disHorValue * val
		self._scrollRect.verticalNormalizedPosition = formVerValue + disVerValue * val
	end

	local function startHander()
		self:_setRaycast(false)
		GameUtil.callBack(startCallBack)
	end

	local function endHander()
		self:_setRaycast(true)
		GameUtil.callBack(finishCallBack)
	end

	local function killHander()
		self:_setRaycast(true)
	end

	local luaTarget = self
	local easeType = DG.Tweening.Ease.OutCirc

	self:killViewTo()

	self._tweenerOfViewTo = TweenUtil.ValueTo(0, 1, duration, updateHander, endHander, luaTarget, easeType)

	self._tweenerOfViewTo:OnStart(startHander)
	self._tweenerOfViewTo:OnKill(killHander)

	return self._tweenerOfViewTo
end

function HLScrollerViewCtrl:killViewTo()
	if self._tweenerOfViewTo then
		self._tweenerOfViewTo:Kill(false)

		self._tweenerOfViewTo = nil
	end
end

function HLScrollerViewCtrl:startFollow(targetGo)
	self:_setRaycast(false)

	self._followTargetGo = targetGo
	self._followTargetPos = Vector3.New()

	settimer(0, self._tickingFollow, self)
end

function HLScrollerViewCtrl:stopFollow()
	removetimer(self._tickingFollow, self)
	self:_setRaycast(true)
end

function HLScrollerViewCtrl:_tickingFollow()
	self._followTargetPos:Set(Framework.TransformUtil.GetLocalPos(self._followTargetGo.transform, 0, 0, 0))
	self:setNorPosition(self._followTargetPos)
end

function HLScrollerViewCtrl:_setRaycast(isCanRaycast)
	if self._viewportRectTran then
		self._viewportRectTran.transform:GetComponent("EmptyRaycast").raycastTarget = isCanRaycast
	end
end

return HLScrollerViewCtrl
