-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreClickNode.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreClickNode", package.seeall)

local WaitGuideActionExploreClickNode = class("WaitGuideActionExploreClickNode", BaseGuideAction)

function WaitGuideActionExploreClickNode:onStart(context)
	local arr = string.split(self.actionParam, "#")
	local x = tonumber(arr[1]) or 0
	local y = tonumber(arr[2]) or 0
	local addHeight = tonumber(arr[3]) or 0
	local statu = ExploreController.instance:getMap():getNowStatus()
	local heroX, heroY = ExploreMapModel.instance:getHeroPos()

	if heroX == x and heroY == y and statu == ExploreEnum.MapStatus.Normal then
		self:onDone(true)

		return
	end

	local node = ExploreMapModel.instance:getNode(ExploreHelper.getKeyXY(x, y))
	local height = 0

	if node then
		height = node.rawHeight
	end

	height = height + addHeight
	self._targetPos = Vector3.New(x + 0.5, height, y + 0.5)

	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, self._setMaskPosAndClickAction, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._setMaskPosAndClickAction, self)

	if not ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenViewFinish, self)
	else
		self:_setMaskPosAndClickAction()
	end
end

function WaitGuideActionExploreClickNode:_checkOpenViewFinish(viewName, viewParam)
	if ViewName.GuideView ~= viewName then
		return
	end

	self:_setMaskPosAndClickAction()
end

function WaitGuideActionExploreClickNode:_setMaskPosAndClickAction()
	if not ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		return
	end

	GuideController.instance:dispatchEvent(GuideEvent.SetMaskPosition, self._targetPos, true)
	GuideViewMgr.instance:setHoleClickCallback(self._onHoldClick, self)
end

function WaitGuideActionExploreClickNode:_getScreenPos()
	return CameraMgr.instance:getMainCamera():WorldToScreenPoint(self._targetPos)
end

function WaitGuideActionExploreClickNode:_onHoldClick(isInside)
	local screenPos = self:_getScreenPos()

	if isInside or not self._isForceGuide or self:isOutScreen(screenPos) then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickMap, screenPos)
		GuideController.instance:dispatchEvent(GuideEvent.SetMaskPosition, nil)
		GuideViewMgr.instance:close()
		self:onDone(true)
	end
end

function WaitGuideActionExploreClickNode:isOutScreen(screenPos)
	if screenPos.x < 0 or screenPos.y < 0 or screenPos.x > UnityEngine.Screen.width or screenPos.y > UnityEngine.Screen.height then
		return true
	end

	return false
end

function WaitGuideActionExploreClickNode:clearWork()
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, self._setMaskPosAndClickAction, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._setMaskPosAndClickAction, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenViewFinish, self)
end

return WaitGuideActionExploreClickNode
