-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/TargetConditionItem.lua

module("logic.extensions.battlesettlement.view.TargetConditionItem", package.seeall)

local TargetConditionItem = class("TargetConditionItem")

function TargetConditionItem:init(go, data)
	self._data = data
	self._goRect = go:GetComponent(goutil.Type_RectTransform)
	self._txtDesc = goutil.findChild(go, "txtDesc"):GetComponent(goutil.Type_UIText)
	self._imgReached = goutil.findChild(go, "imgReached")
	self._imgNotReached = goutil.findChild(go, "imgNotReached")
	self._newRecord = goutil.findChild(go, "newRecord")
	self._oldRecord = goutil.findChild(go, "oldRecord")

	self:_showView()
end

function TargetConditionItem:reset()
	self:doKillTween()
end

function TargetConditionItem:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._goRect, 1500, self._data.posY)
	self._goRect:DOAnchorPosX(0, self._data.curTime):SetDelay(self._data.curDelay)
end

function TargetConditionItem:doKillTween()
	self._goRect:DOKill(true)
end

function TargetConditionItem:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._goRect, 0, self._data.posY)
end

function TargetConditionItem:_showView()
	self._txtDesc.text = self._data.txtDesc

	if self._data.isReach == nil then
		goutil.setActive(self._imgReached, false)
		goutil.setActive(self._imgNotReached, false)
	else
		goutil.setActive(self._imgReached, self._data.isReach)
		goutil.setActive(self._imgNotReached, not self._data.isReach)
	end

	if self._data.isNewRecord == nil then
		goutil.setActive(self._newRecord, false)
		goutil.setActive(self._oldRecord, false)
	else
		goutil.setActive(self._newRecord, self._data.isNewRecord)
		goutil.setActive(self._oldRecord, not self._data.isNewRecord)
	end
end

return TargetConditionItem
