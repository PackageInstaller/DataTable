-- chunkname: @modules/logic/survival/view/map/comp/SurvivalToastItem.lua

module("modules.logic.survival.view.map.comp.SurvivalToastItem", package.seeall)

local SurvivalToastItem = class("SurvivalToastItem", LuaCompBase)
local OutSidePos = 10000
local csTweenHelper = ZProj.TweenHelper

function SurvivalToastItem:init(go)
	self.width = 0
	self.height = 0
	self.tr = go.transform
	self._txt = gohelper.findChildText(go, "#txt_desc")
	self.canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._duration = 0.3
	self._showToastDuration = 1
	self.startAnchorPositionY = 0
end

function SurvivalToastItem:setMsg(msg)
	self.canvasGroup.alpha = 1
	self._txt.text = msg

	ZProj.UGUIHelper.RebuildLayout(self.tr)

	self.width = recthelper.getWidth(self.tr)
	self.height = recthelper.getHeight(self.tr)
end

function SurvivalToastItem:_delay()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.RecycleToast, self)
end

function SurvivalToastItem:appearAnimation()
	recthelper.setAnchorX(self.tr, self.width)
	csTweenHelper.KillById(self.startTweenId or -1)

	self.startTweenId = csTweenHelper.DOAnchorPosX(self.tr, 0, self._duration, function()
		self.startTweenId = nil

		TaskDispatcher.runDelay(self._delay, self, self._showToastDuration)
	end)
end

function SurvivalToastItem:upAnimation(targetPosY)
	csTweenHelper.KillById(self.upTweenId or -1)

	self.upTweenId = csTweenHelper.DOAnchorPosY(self.tr, targetPosY, self._duration, function()
		self.upTweenId = nil
	end)
end

function SurvivalToastItem:quitAnimation(quitAnimationDoneCallback, callbackObj)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.quitAnimationDoneCallback = quitAnimationDoneCallback
	self.callbackObj = callbackObj
	self.startAnchorPositionY = self.tr.anchoredPosition.y
	self.quitTweenId = csTweenHelper.DOTweenFloat(1, 0, self._duration, self.quitAnimationFrame, self.quitAnimationDone, self)
end

function SurvivalToastItem:quitAnimationFrame(value)
	local upPositionY = (1 - value) * self.height

	recthelper.setAnchorY(self.tr, self.startAnchorPositionY + upPositionY)

	self.canvasGroup.alpha = value
end

function SurvivalToastItem:quitAnimationDone()
	if self.quitAnimationDoneCallback then
		self.quitAnimationDoneCallback(self.callbackObj, self)
	end

	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
	self.quitTweenId = nil
end

function SurvivalToastItem:clearAllTask()
	TaskDispatcher.cancelTask(self._delay, self)
	csTweenHelper.KillById(self.startTweenId or -1)
	csTweenHelper.KillById(self.upTweenId or -1)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.startTweenId = nil
	self.upTweenId = nil
	self.quitTweenId = nil
	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
end

function SurvivalToastItem:reset()
	self.startAnchorPositionY = 0

	recthelper.setAnchor(self.tr, OutSidePos, OutSidePos)
end

function SurvivalToastItem:getHeight()
	return self.height
end

function SurvivalToastItem:onDestroy()
	self:clearAllTask()
end

return SurvivalToastItem
