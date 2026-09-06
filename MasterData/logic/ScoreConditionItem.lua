-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/ScoreConditionItem.lua

module("logic.extensions.battlesettlement.view.ScoreConditionItem", package.seeall)

local ScoreConditionItem = class("ScoreConditionItem")

function ScoreConditionItem:init(go, data)
	self._data = data
	self._goRect = go:GetComponent(goutil.Type_RectTransform)
	self._txtDesc = goutil.findChild(go, "txtDesc"):GetComponent(goutil.Type_UIText)

	self:_showView()
end

function ScoreConditionItem:reset()
	self:doKillTween()
end

function ScoreConditionItem:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._goRect, 1500, self._data.posY)
	self._goRect:DOAnchorPosX(0, self._data.curTime):SetDelay(self._data.curDelay)
end

function ScoreConditionItem:doKillTween()
	self._goRect:DOKill(true)
end

function ScoreConditionItem:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._goRect, 0, self._data.posY)
end

function ScoreConditionItem:_showView()
	self._txtDesc.text = self._data.txtDesc
end

return ScoreConditionItem
