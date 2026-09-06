-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/view/UltimateTrialDualDragonMainView.lua

module("logic.extensions.divinedualdragonclg.view.UltimateTrialDualDragonMainView", package.seeall)

local UltimateTrialDualDragonMainView = class("UltimateTrialDualDragonMainView", DivineDualDragonClgMainView)

function UltimateTrialDualDragonMainView:buildUI()
	UltimateTrialDualDragonMainView.super.buildUI(self)
	self:_recordGoDefaultActive(self._btnRank)
	self:_recordGoDefaultActive(self._btnCall)
	self:_recordGoDefaultActive(self._btnPrize)
end

function UltimateTrialDualDragonMainView:onEnter()
	UltimateTrialDualDragonMainView.super.onEnter(self)

	self._isUltTrialClg = UltimateTrialController.instance:isUltTrialClg(self._activityId)

	if self._isUltTrialClg then
		GameUtil.SetActive(self._btnRank, false)
		GameUtil.SetActive(self._btnCall, false)
		GameUtil.SetActive(self._btnPrize, false)
	else
		self:_refreshDefaultActive(self._btnRank)
		self:_refreshDefaultActive(self._btnCall)
		self:_refreshDefaultActive(self._btnPrize)
	end
end

function UltimateTrialDualDragonMainView:_onClickChallenge()
	if UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId) then
		return
	end

	UIStateManager.instance:push(ViewName.UltimateTrialDualDragonLevelView, self._activityId)
end

function UltimateTrialDualDragonMainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function UltimateTrialDualDragonMainView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function UltimateTrialDualDragonMainView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

return UltimateTrialDualDragonMainView
